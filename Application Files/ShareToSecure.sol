pragma solidity >=0.4.25 <0.6.0;

contract ShareToSecure2
{
    enum StateType { BuyPolicy, RequestUnderwriting,BankUnderwriting,BankUnderwritingDone,MedicalUnderwriting,MedicalUnderwritingDone,FinalPolicyIssuance,ConfirmPolicyDetails,Rejected,ClaimVerificationFromHospital,ClaimVerificationDone,ClaimAcccepted,ClaimRejected}
    StateType public  State;

    address public  Buyer;
    address public  BankUnderwriter;
    address public  MedicalUnderwriter;
    address public  InsuranceProvider;

    int public AadhaarCardNumber;
    string public Sex;
    address public BankName;
    int public AccountNumber;
    address public InsurerName;
    string public PolicyName;
    address public HospitalName;
    string public PAN;
    int public SumAssured;
    int public PolicyTerm;

    int public PaymentTerm;
    bool public PremiumPayment;
    bool public CustomerVerification;
    bool public Active;
    int public FinancialHealthPoints;
    bool public BankUnderwritingResult;
    bool public ActiveStatus;
    int public HealthScore;
    bool public PhysicalVerification;
    bool public MedicalUnderwriting;
    bool public PremiumRecieved;
    int public PolicyNumber;
    int public IssuanceDate;
    int public MaturityDate;
    int public PremiumFinal;
    int public  SumAssuredFinal;
    bool public PolicyIssued;
    string public ClaimReason;
    bool public ClaimReasonVerification;
    string public ClaimReasonRemark;
    address public ClaimResponder;

    constructor(int aadhaarCardNumber,string memory sex, address bankName, int accountNumber, address insurerName,string memory policyName,address hospitalName,string memory pan, int sumAssured,int policyTerm,int paymentTerm, bool premiumPayment) public
    {
            Buyer = msg.sender;

            AadhaarCardNumber=aadhaarCardNumber;
            Sex=sex;
            BankName=bankName;
            AccountNumber=accountNumber;
            InsurerName=insurerName;
            PolicyName=policyName;
            HospitalName=hospitalName;
            PAN=pan;
            SumAssured=sumAssured;
            PolicyTerm=policyTerm;
            PaymentTerm=paymentTerm;
            PremiumPayment=premiumPayment;

            State = StateType.BuyPolicy;
    }

    function ConfirmDetails() public
    {
         Buyer = msg.sender;
         State = StateType.RequestUnderwriting;
    }

    function SendToBankUnderwriter() public 
    {
        InsuranceProvider = msg.sender;
        State = StateType.BankUnderwriting;
    }

    function UpdateFinancialHealth(bool customerVerification,bool active,int financialHealthPoints,bool bankUnderwritingResult) public 
    {
        BankUnderwriter = msg.sender;
        CustomerVerification=customerVerification;
        Active=active;
        FinancialHealthPoints=financialHealthPoints;
        BankUnderwritingResult=bankUnderwritingResult;

        State = StateType.BankUnderwritingDone;
    }
    function  SendToMedicalUnderwriter() public
    {
         InsuranceProvider = msg.sender;
         State = StateType.MedicalUnderwriting;
    }

    function  UpdateMedicalHealth(bool activeStatus,int healthScore,bool physicalVerification,bool medicalUnderwriting) public
    {
         MedicalUnderwriter = msg.sender;
         ActiveStatus=activeStatus;
         HealthScore=healthScore;
         PhysicalVerification=physicalVerification;
         MedicalUnderwriting=medicalUnderwriting;

         State = StateType.MedicalUnderwritingDone;
    }


    function RecalculatePolicy(bool premiumRecieved,int policyNumber,int issuanceDate,int maturityDate,int premiumFinal,int sumAssuredFinal,bool policyIssued ) public
    {
        PremiumRecieved=premiumRecieved;
        PolicyNumber=policyNumber;
        IssuanceDate=issuanceDate;
        MaturityDate=maturityDate;
        PremiumFinal=premiumFinal;
        SumAssuredFinal=sumAssuredFinal;
        PolicyIssued=policyIssued;

        State = StateType.FinalPolicyIssuance;
    }
    function ConfirmPolicy() public {
        Buyer = msg.sender;
        State = StateType.ConfirmPolicyDetails;
    }
    function Reject() public{
        Buyer = msg.sender;
    }

    function InvokeClaim(string memory claimReason,address claimResponder) public{
        ClaimReason = claimReason;
        ClaimResponder=claimResponder;
        State = StateType.ClaimVerificationFromHospital;
    }

    function SubmitClaimDetails(bool claimReasonVerification,string memory claimReasonRemark) public{
        ClaimReasonVerification = claimReasonVerification;
        ClaimReasonRemark=claimReasonRemark;
        State = StateType.ClaimVerificationDone;
    }
     function ClaimRequestAcccepted() public{

        State = StateType.ClaimAcccepted;
    }
     function ClaimRequestRejected() public{
        
        State = StateType.ClaimRejected;
    }
}
