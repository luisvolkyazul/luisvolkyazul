# TVM Calculator User Manual
## for Agon Light 2 (BBC BASIC V)

---

## What is "Time Value of Money"?
Money available today is worth more than the same amount in the future because it can be invested to earn interest or returns. This program calculates common Time Value of Money (TVM) scenarios to help you understand how money grows or declines over time with compound interest.

**Disclaimer:** This program is **for entertainment purposes only**. It is not financial advice. Consult a qualified financial professional before making any investment or loan decisions.

---

## How to Run the Program
1. Copy `tvm_calculator.bas` to your Agon Light 2
2. Type: `LOAD "tvm_calculator.bas"`
3. Type: `RUN`
4. Pick a choice (1-6), enter the requested values, and review the result
5. Results are automatically saved to a plain text file named based on your calculation choice

**Disclaimer:** This program is **for entertainment purposes only**. It is not financial advice. Consult a qualified financial professional before making any investment or loan decisions.

---

## The 6 Calculation Choices (When to Use Each)

### 1. Future Value (Lump Sum)
**Best for:** Calculating the future value of a single lump sum investment or deposit over a set number of periods.

**Example:** You received $1,000 as a gift. You invest it in a savings account earning 5% interest per year. What will it be worth in 10 years?

**Screen Output:**
```
Enter choice (1-6): 1
--- Future Value (Lump Sum) ---
Present Value (PV): 1000
Period Rate (r, e.g. 0.05 for 5%): 0.05
Number of Periods (n): 10
Future Value: 1628.89
Results saved to fv_lumpsum.txt
```

**File Output (`fv_lumpsum.txt`):**
```
=== TVM CALCULATION REPORT ===
Calculation Type: Future Value (Lump Sum))

Inputs:
  Present Value (PV): 1000.00
  Period Rate (r): 0.05
  Number of Periods (n): 10

Output:
  Future Value: 1628.89

=== END OF REPORT ===
```

**Interpretation:** A $1,000 initial investment at 5% annual interest grows to $1,628.89 over 10 years without additional contributions, demonstrating the power of compound interest.

---

### 2. Present Value (Lump Sum)
**Best for:** Determining how much you need to invest today to reach a specific future financial goal.

**Example:** You plan to buy a car for $20,000 in 5 years. You can earn 6% interest annually. How much do you need to invest today to reach this goal?

**Screen Output:**
```
Enter choice (1-6): 2
--- Present Value (Lump Sum) ---
Future Value (FV): 20000
Period Rate (r): 0.06
Number of Periods (n): 5
Present Value: 14945.16
Results saved to pv_lumpsum.txt
```

**File Output (`pv_lumpsum.txt`):**
```
=== TVM CALCULATION REPORT ===
Calculation Type: Present Value (Lump Sum)

Inputs:
  Future Value (FV): 20000.00
  Period Rate (r): 0.06
  Number of Periods (n): 5

Output:
  Present Value: 14945.16

=== END OF REPORT ===
```

**Interpretation:** You need to invest $14,945.16 today at 6% annual interest to have exactly $20,000 in 5 years. The remaining $5,054.84 comes from earned interest.

---

### 3. Future Value (Ordinary Annuity)
**Best for:** Calculating the future value of regular, equal recurring payments made at the end of each period.

**Example:** You earn $200 per month from babysitting and deposit it into an account earning 4% annual interest (0.33% per month). What will you have saved after 3 years (36 months)?

**Screen Output:**
```
Enter choice (1-6): 3
--- Future Value (Ordinary Annuity) ---
Payment per Period (PMT): 200
Period Rate (r): 0.0033
Number of Periods (n): 36
Annuity Future Value: 7634.50
Results saved to fv_annuity.txt
```

**File Output (`fv_annuity.txt`):**
```
=== TVM CALCULATION REPORT ===
Calculation Type: Future Value (Ordinary Annuity))

Inputs:
  Payment per Period (PMT): 200.00
  Period Rate (r): 0.0033
  Number of Periods (n): 36

Output:
  Annuity Future Value: 7634.50

=== END OF REPORT ===
```

**Interpretation:** Saving $200 monthly for 3 years yields $7,634.50. You contributed $7,200 total (200 × 36), with $434.50 earned in interest.

---

### 4. Present Value (Ordinary Annuity)
**Best for:** Determining the current value of a series of equal future payments, such as lottery winnings, pension payments, or structured settlements.

**Example:** A relative offers you $100 per year for 10 years. If you could invest at 5% annual return, what is the current value of this payment stream?

**Screen Output:**
```
Enter choice (1-6): 4
--- Present Value (Ordinary Annuity) ---
Payment per Period (PMT): 100
Period Rate (r): 0.05
Number of Periods (n): 10
Annuity Present Value: 772.17
Results saved to pv_annuity.txt
```

**File Output (`pv_annuity.txt`):**
```
=== TVM CALCULATION REPORT ===
Calculation Type: Present Value (Ordinary Annuity))

Inputs:
  Payment per Period (PMT): 100.00
  Period Rate (r): 0.05
  Number of Periods (n): 10

Output:
  Annuity Present Value: 772.17

=== END OF REPORT ===
```

**Interpretation:** A 10-year stream of $100 annual payments is worth $772.17 in today's money at 5% interest. A $750 lump sum offer would be preferable to the payment stream in this scenario.

---

### 5. Payment (PMT) for Annuity
**Best for:** Calculating the fixed periodic payment needed to repay a loan (amortization) over a set term.

**Example:** You purchase a used car with an $8,000 loan at 7% annual interest (0.58% monthly) for 4 years (48 months). What is your monthly payment?

**Screen Output:**
```
Enter choice (1-6): 5
--- Payment (PMT) for Annuity ---
Present Value (PV): 8000
Period Rate (r): 0.0058
Number of Periods (n): 48
Payment per Period: 191.56
Results saved to pmt_annuity.txt
```

**File Output (`pmt_annuity.txt`):**
```
=== TVM CALCULATION REPORT ===
Calculation Type: Payment (PMT) for Annuity)

Inputs:
  Present Value (PV): 8000.00
  Period Rate (r): 0.0058
  Number of Periods (n): 48

Output:
  Payment per Period: 191.56

=== END OF REPORT ===
```

**Interpretation:** You will pay $191.56 per month for 48 months. Total payments equal $9,194.88, meaning $1,194.88 is paid in interest over the loan term.

**0% Interest Example:** With a 0% interest offer, the monthly payment is $8,000 ÷ 48 = $166.67, with no additional interest cost.

---

### 6. Number of Periods (Lump Sum)
**Best for:** Calculating how many periods it takes for an investment to grow from a present value to a target future value at a given interest rate.

**Example:** You invest $500 at 8% annual interest. How many years will it take to double your money to $1,000?

**Screen Output:**
```
Enter choice (1-6): 6
--- Number of Periods (Lump Sum) ---
Present Value (PV): 500
Future Value (FV): 1000
Period Rate (r): 0.08
Number of Periods: 9.01
Results saved to periods_lumpsum.txt
```

**File Output (`periods_lumpsum.txt`):**
```
=== TVM CALCULATION REPORT ===
Calculation Type: Number of Periods (Lump Sum)

Inputs:
  Present Value (PV): 500.00
  Future Value (FV): 1000.00
  Period Rate (r): 0.08

Output:
  Number of Periods: 9.01

=== END OF REPORT ===
```

**Interpretation:** At 8% annual interest, $500 doubles to $1,000 in approximately 9 years. This aligns with the "Rule of 72" (72 ÷ 8 = 9 years).

**Important:** The interest rate cannot be 0% for this calculation, as it would require division by zero in the formula.

---

## Quick Tips
- **Interest rates:** Always enter as decimals (5% = 0.05, 7.5% = 0.075)
- **Periods must match rates:** Monthly rates require monthly periods, annual rates require annual periods
- **Dollar amounts display 2 decimal places** (standard currency format: $123.45)
- **Rates and periods use plain decimal notation** (no forced 2 decimal places, no exponential notation)
- **Files save automatically** with descriptive names based on calculation type
- **0% interest is supported** for most calculations, except "Number of Periods" (mathematically invalid)

---

## Output File Names
| Choice | File Name |
|--------|-----------|
| 1 | `fv_lumpsum.txt` |
| 2 | `pv_lumpsum.txt` |
| 3 | `fv_annuity.txt` |
| 4 | `pv_annuity.txt` |
| 5 | `pmt_annuity.txt` |
| 6 | `periods_lumpsum.txt` |

All output files follow a consistent format: calculation type header, labeled inputs, calculation output, and footer.