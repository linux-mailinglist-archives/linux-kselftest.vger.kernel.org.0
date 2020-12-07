Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23A2D0BAC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 09:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgLGIWu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 03:22:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37164 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbgLGIWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 03:22:50 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B782Md6018226;
        Mon, 7 Dec 2020 03:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Q31uStJR0kTYBYgsIX6g8f4LxwrePMvihbUhAOiZaCM=;
 b=IHJIj0HlpXfoHrIGpDgWis0NI4a2tjKEfZwXgdFnPa7U1cVad6hJukriQ+0CwSuZ0AGq
 Xta/DntSwIwtp5TSRCK9WwdIaAJ9yOIwNt2Ar7myXDLrBJ4Y8EOTWWJONQAeaKyJObst
 jFKV8mspHTDgRYPPUn+ab/WNkj5tKXt7MP8YP7zeJ2ju7BKExnmLnfnQBuxac7Or0eVO
 dYBHl05zRGp+UCmop1uZERoE3hInJZeRhll5DgKfj+/3rvhlUYLW8Uz+CWcxDkjaTEkS
 9X/vi3egOfdoQ3QoxmLbd/fefRIw0FrfXKmDm7O4G8X1/oZq2A6WXibxQnXD1kcMdQKZ /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359dkgmtv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 03:22:07 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B782kQI020619;
        Mon, 7 Dec 2020 03:22:07 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359dkgmtug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 03:22:07 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B78DWMZ026541;
        Mon, 7 Dec 2020 08:22:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8kbyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 08:22:05 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B78JWHO7668418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 08:19:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E88E242042;
        Mon,  7 Dec 2020 08:19:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DD8B42047;
        Mon,  7 Dec 2020 08:19:31 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.4.19])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Dec 2020 08:19:31 +0000 (GMT)
Subject: Re: [PATCH v3] self_tests/kvm: sync_regs test for diag318
To:     Janosch Frank <frankja@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     david@redhat.com, thuth@redhat.com, cohuck@redhat.com,
        pbonzini@redhat.com, imbrenda@linux.ibm.com
References: <20201203215212.243145-1-walling@linux.ibm.com>
 <39f22c09-788c-4ba7-9cf8-018f86b10803@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <06853772-8c12-b5e9-761f-9743ce01e270@de.ibm.com>
Date:   Mon, 7 Dec 2020 09:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <39f22c09-788c-4ba7-9cf8-018f86b10803@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-07_05:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 suspectscore=2
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070046
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 07.12.20 09:16, Janosch Frank wrote:
> On 12/3/20 10:52 PM, Collin Walling wrote:
>> The DIAGNOSE 0x0318 instruction, unique to s390x, is a privileged call
> 
> s/call/instruction/
> 
>> that must be intercepted via SIE, handled in userspace, and the
>> information set by the instruction is communicated back to KVM.
>>
>> To test the instruction interception, an ad-hoc handler is defined which
>> simply has a VM execute the instruction and then userspace will extract
>> the necessary info. The handler is defined such that the instruction
>> invocation occurs only once. It is up to the caller to determine how the
>> info returned by this handler should be used.
>>
>> The diag318 info is communicated from userspace to KVM via a sync_regs
>> call. This is tested during a sync_regs test, where the diag318 info is
>> requested via the handler, then the info is stored in the appropriate
>> register in KVM via a sync registers call.
>>
>> If KVM does not support diag318, then the tests will print a message
>> stating that diag318 was skipped, and the asserts will simply test
>> against a value of 0.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> 
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> 
> Some nits below.

Collin, can you have a look at the nits and resubmit soon? Then I can pick this
for 5.11.

> 
>> ---
>>
>> v3 changes: no longer testing the reset code, as it is handled
>> entirely via userspace. The respective reset tests have been removed
>>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |  2 +-
>>  .../kvm/include/s390x/diag318_test_handler.h  | 13 +++
>>  .../kvm/lib/s390x/diag318_test_handler.c      | 82 +++++++++++++++++++
>>  tools/testing/selftests/kvm/s390x/resets.c    |  1 +
>>  .../selftests/kvm/s390x/sync_regs_test.c      | 16 +++-
>>  5 files changed, 112 insertions(+), 2 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h
>>  create mode 100644 tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 3d14ef77755e..426c78449044 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -36,7 +36,7 @@ endif
>>  LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c lib/test_util.c
>>  LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
>>  LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
>> -LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c
>> +LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>>  
>>  TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
>> diff --git a/tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h b/tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h
>> new file mode 100644
>> index 000000000000..b0ed71302722
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * Test handler for the s390x DIAGNOSE 0x0318 instruction.
>> + *
>> + * Copyright (C) 2020, IBM
>> + */
>> +
>> +#ifndef SELFTEST_KVM_DIAG318_TEST_HANDLER
>> +#define SELFTEST_KVM_DIAG318_TEST_HANDLER
>> +
>> +uint64_t get_diag318_info(void);
>> +
>> +#endif
>> diff --git a/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c b/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
>> new file mode 100644
>> index 000000000000..1e0b766efeb7
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
>> @@ -0,0 +1,82 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Test handler for the s390x DIAGNOSE 0x0318 instruction.
>> + *
>> + * Copyright (C) 2020, IBM
>> + */
>> +
>> +#include "test_util.h"
>> +#include "kvm_util.h"
>> +
>> +#define VCPU_ID	5
> 
> The sync_regs test has the same ID, will this be a problem?
> 
>> +
>> +#define ICPT_INSTRUCTION	0x04
>> +#define IPA0_DIAG		0x8300
>> +
>> +static void guest_code(void)
>> +{
>> +	uint64_t diag318_info = 0x12345678;
>> +
>> +	asm volatile ("diag %0,0,0x318\n" : : "d" (diag318_info));
>> +}
>> +
>> +/*
>> + * The DIAGNOSE 0x0318 instruction call must be handled via userspace. As such,
>> + * we create an ad-hoc VM here to handle the instruction then extract the
>> + * necessary data. It is up to the caller to decide what to do with that data.
>> + */
>> +static uint64_t diag318_handler(void)
>> +{
>> +	struct kvm_vm *vm;
>> +	struct kvm_run *run;
>> +	uint64_t reg;
>> +	uint64_t diag318_info;
>> +
>> +	vm = vm_create_default(VCPU_ID, 0, guest_code);
>> +	vcpu_run(vm, VCPU_ID);
>> +	run = vcpu_state(vm, VCPU_ID);
>> +
>> +	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
>> +		    "DIAGNOSE 0x0318 instruction was not intercepted");
>> +	TEST_ASSERT(run->s390_sieic.icptcode == ICPT_INSTRUCTION,
>> +		    "Unexpected intercept code: 0x%x", run->s390_sieic.icptcode);
>> +	TEST_ASSERT((run->s390_sieic.ipa & 0xff00) == IPA0_DIAG,
>> +		    "Unexpected IPA0 code: 0x%x", (run->s390_sieic.ipa & 0xff00));
>> +
>> +	reg = (run->s390_sieic.ipa & 0x00f0) >> 4;
>> +	diag318_info = run->s.regs.gprs[reg];
>> +
>> +	TEST_ASSERT(diag318_info != 0, "DIAGNOSE 0x0318 info not set");
>> +
>> +	kvm_vm_free(vm);
>> +
>> +	return diag318_info;
>> +}
>> +
>> +uint64_t get_diag318_info(void)
>> +{
>> +	static uint64_t diag318_info;
>> +	static bool printed_skip;
>> +
>> +	/*
>> +	 * If KVM does not support diag318, then return 0 to
>> +	 * ensure tests do not break.
>> +	 */
>> +	if (!kvm_check_cap(KVM_CAP_S390_DIAG318)) {
>> +		if (!printed_skip) {
>> +			fprintf(stdout, "KVM_CAP_S390_DIAG318 not supported. "
>> +				"Skipping diag318 test.\n");
>> +			printed_skip = true;
>> +		}
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * If a test has previously requested the diag318 info,
>> +	 * then don't bother spinning up a temporary VM again.
>> +	 */
>> +	if (!diag318_info)
>> +		diag318_info = diag318_handler();
>> +
>> +	return diag318_info;
>> +}
>> diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
>> index b143db6d8693..b3d7d4ac2d54 100644
>> --- a/tools/testing/selftests/kvm/s390x/resets.c
>> +++ b/tools/testing/selftests/kvm/s390x/resets.c
>> @@ -110,6 +110,7 @@ static void assert_clear(void)
>>  
>>  	TEST_ASSERT(!memcmp(sync_regs->vrs, regs_null, sizeof(sync_regs->vrs)),
>>  		    "vrs0-15 == 0 (sync_regs)");
>> +
> 
> Whitespace damage
> 
>>  }
>>  
>>  static void assert_initial_noclear(void)
>> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> index 5731ccf34917..caf7b8859a94 100644
>> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> @@ -20,6 +20,7 @@
>>  
>>  #include "test_util.h"
>>  #include "kvm_util.h"
>> +#include "diag318_test_handler.h"
>>  
>>  #define VCPU_ID 5
>>  
>> @@ -70,7 +71,7 @@ static void compare_sregs(struct kvm_sregs *left, struct kvm_sync_regs *right)
>>  
>>  #undef REG_COMPARE
>>  
>> -#define TEST_SYNC_FIELDS   (KVM_SYNC_GPRS|KVM_SYNC_ACRS|KVM_SYNC_CRS)
>> +#define TEST_SYNC_FIELDS   (KVM_SYNC_GPRS|KVM_SYNC_ACRS|KVM_SYNC_CRS|KVM_SYNC_DIAG318)
>>  #define INVALID_SYNC_FIELD 0x80000000
>>  
>>  int main(int argc, char *argv[])
>> @@ -152,6 +153,12 @@ int main(int argc, char *argv[])
>>  
>>  	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>>  	run->kvm_dirty_regs = KVM_SYNC_GPRS | KVM_SYNC_ACRS;
>> +
>> +	if (get_diag318_info() > 0) {
>> +		run->s.regs.diag318 = get_diag318_info();
>> +		run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
>> +	}
>> +
>>  	rv = _vcpu_run(vm, VCPU_ID);
>>  	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
>>  	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
>> @@ -164,6 +171,9 @@ int main(int argc, char *argv[])
>>  	TEST_ASSERT(run->s.regs.acrs[0]  == 1 << 11,
>>  		    "acr0 sync regs value incorrect 0x%x.",
>>  		    run->s.regs.acrs[0]);
>> +	TEST_ASSERT(run->s.regs.diag318 == get_diag318_info(),
>> +		    "diag318 sync regs value incorrect 0x%llx.",
>> +		    run->s.regs.diag318);
>>  
>>  	vcpu_regs_get(vm, VCPU_ID, &regs);
>>  	compare_regs(&regs, &run->s.regs);
>> @@ -177,6 +187,7 @@ int main(int argc, char *argv[])
>>  	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>>  	run->kvm_dirty_regs = 0;
>>  	run->s.regs.gprs[11] = 0xDEADBEEF;
>> +	run->s.regs.diag318 = 0x4B1D;
>>  	rv = _vcpu_run(vm, VCPU_ID);
>>  	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
>>  	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
>> @@ -186,6 +197,9 @@ int main(int argc, char *argv[])
>>  	TEST_ASSERT(run->s.regs.gprs[11] != 0xDEADBEEF,
>>  		    "r11 sync regs value incorrect 0x%llx.",
>>  		    run->s.regs.gprs[11]);
>> +	TEST_ASSERT(run->s.regs.diag318 != 0x4B1D,
>> +		    "diag318 sync regs value incorrect 0x%llx.",
>> +		    run->s.regs.diag318);
>>  
>>  	kvm_vm_free(vm);
>>  
>>
> 
