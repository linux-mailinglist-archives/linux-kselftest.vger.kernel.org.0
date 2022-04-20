Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21F95084FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 11:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358692AbiDTJcS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 05:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346143AbiDTJcM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 05:32:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9D167E9;
        Wed, 20 Apr 2022 02:29:27 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K8wvFI005632;
        Wed, 20 Apr 2022 09:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uemMEZVsgx72YC6TI4ImdzCfIuvWPkFMx1ZeSd6ku2M=;
 b=eiSdkFx8qU94CpU3b6CI/TIenmyxmIfsZdxwFIy4UK+ggiQFZ60OkgS3+oiPmj7PNOu6
 LgIUX+TSmxUfbm19oHjRyT59TZSc+lb85NrIo7QMRUFwb5btzfPxWpbmkbY868HCSNjO
 roiqbVwYX5Ih3XZUGmMgeKYHy9gjdDZF8o/4/p6Bf8ZxomQXVbTiNi8/u9sPyOlYwiMp
 qNHIyquEyALSmLpbgAb1sqfU7HzSiXzdtnohhPupXRRHp834FW9SC+5YKyY8KtBXU3wA
 yce51SiOtbqaHjOINWypXpAWdvjciytaTmaqPXJZocN4dFyPhU0SX4L1Zm5e75dNIIVv TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjf51rh0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 09:29:20 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23K9NTWK010287;
        Wed, 20 Apr 2022 09:29:19 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjf51rh04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 09:29:19 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23K9RrgC023240;
        Wed, 20 Apr 2022 09:29:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3ffvt9cbuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 09:29:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23K9TEA848169238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 09:29:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C5BDAE051;
        Wed, 20 Apr 2022 09:29:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99E12AE045;
        Wed, 20 Apr 2022 09:29:13 +0000 (GMT)
Received: from [9.145.164.14] (unknown [9.145.164.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 09:29:13 +0000 (GMT)
Message-ID: <0f208aa9-9e0b-cabc-575e-ac384910ac52@linux.ibm.com>
Date:   Wed, 20 Apr 2022 11:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/4] KVM: s390: selftests: Use TAP interface in the
 sync_regs test
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20220419185857.128351-1-thuth@redhat.com>
 <20220419185857.128351-3-thuth@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220419185857.128351-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e7U4VLQ7LLVjmVYxLT3vPsSBJ2ePWbNC
X-Proofpoint-ORIG-GUID: URED3cIgoQ5hZSXqpSKJgMMlSvFItvFE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_02,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=954 malwarescore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200057
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/19/22 20:58, Thomas Huth wrote:
> The sync_regs test currently does not have any output (unless one
> of the TEST_ASSERT statement fails), so it's hard to say for a user
> whether a certain new sub-test has been included in the binary or
> not. Let's make this a little bit more user-friendly and include
> some TAP output via the kselftests.h interface.
> To be able to distinguish the different sub-tests more easily, we
> also break up the huge main() function here in more fine grained
> parts.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>   .../selftests/kvm/s390x/sync_regs_test.c      | 87 ++++++++++++++-----
>   1 file changed, 66 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> index caf7b8859a94..c3719c92f4e8 100644
> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> @@ -21,6 +21,7 @@
>   #include "test_util.h"
>   #include "kvm_util.h"
>   #include "diag318_test_handler.h"
> +#include "kselftest.h"
>   
>   #define VCPU_ID 5
>   
> @@ -74,27 +75,9 @@ static void compare_sregs(struct kvm_sregs *left, struct kvm_sync_regs *right)
>   #define TEST_SYNC_FIELDS   (KVM_SYNC_GPRS|KVM_SYNC_ACRS|KVM_SYNC_CRS|KVM_SYNC_DIAG318)
>   #define INVALID_SYNC_FIELD 0x80000000
>   
> -int main(int argc, char *argv[])
> +void test_read_invalid(struct kvm_vm *vm, struct kvm_run *run)
>   {
> -	struct kvm_vm *vm;
> -	struct kvm_run *run;
> -	struct kvm_regs regs;
> -	struct kvm_sregs sregs;
> -	int rv, cap;
> -
> -	/* Tell stdout not to buffer its content */
> -	setbuf(stdout, NULL);
> -
> -	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
> -	if (!cap) {
> -		print_skip("CAP_SYNC_REGS not supported");
> -		exit(KSFT_SKIP);
> -	}
> -
> -	/* Create VM */
> -	vm = vm_create_default(VCPU_ID, 0, guest_code);
> -
> -	run = vcpu_state(vm, VCPU_ID);
> +	int rv;
>   
>   	/* Request reading invalid register set from VCPU. */
>   	run->kvm_valid_regs = INVALID_SYNC_FIELD;
> @@ -110,6 +93,11 @@ int main(int argc, char *argv[])
>   		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
>   		    rv);
>   	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
> +}
> +
> +void test_set_invalid(struct kvm_vm *vm, struct kvm_run *run)
> +{
> +	int rv;
>   
>   	/* Request setting invalid register set into VCPU. */
>   	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
> @@ -125,6 +113,13 @@ int main(int argc, char *argv[])
>   		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
>   		    rv);
>   	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
> +}
> +
> +void test_req_and_verify_all_valid_regs(struct kvm_vm *vm, struct kvm_run *run)
> +{
> +	struct kvm_sregs sregs;
> +	struct kvm_regs regs;
> +	int rv;
>   
>   	/* Request and verify all valid register sets. */
>   	run->kvm_valid_regs = TEST_SYNC_FIELDS;
> @@ -146,6 +141,13 @@ int main(int argc, char *argv[])
>   
>   	vcpu_sregs_get(vm, VCPU_ID, &sregs);
>   	compare_sregs(&sregs, &run->s.regs);
> +}
> +
> +void test_set_and_verify_various_reg_values(struct kvm_vm *vm, struct kvm_run *run)
> +{
> +	struct kvm_sregs sregs;
> +	struct kvm_regs regs;
> +	int rv;
>   
>   	/* Set and verify various register values */
>   	run->s.regs.gprs[11] = 0xBAD1DEA;
> @@ -180,6 +182,11 @@ int main(int argc, char *argv[])
>   
>   	vcpu_sregs_get(vm, VCPU_ID, &sregs);
>   	compare_sregs(&sregs, &run->s.regs);
> +}
> +
> +void test_clear_kvm_dirty_regs_bits(struct kvm_vm *vm, struct kvm_run *run)
> +{
> +	int rv;
>   
>   	/* Clear kvm_dirty_regs bits, verify new s.regs values are
>   	 * overwritten with existing guest values.
> @@ -200,8 +207,46 @@ int main(int argc, char *argv[])
>   	TEST_ASSERT(run->s.regs.diag318 != 0x4B1D,
>   		    "diag318 sync regs value incorrect 0x%llx.",
>   		    run->s.regs.diag318);
> +}
> +
> +struct testdef {
> +	const char *name;
> +	void (*test)(struct kvm_vm *vm, struct kvm_run *run);
> +} testlist[] = {
> +	{ "read invalid", test_read_invalid },
> +	{ "set invalid", test_set_invalid },
> +	{ "request+verify all valid regs", test_req_and_verify_all_valid_regs },
> +	{ "set+verify various regs", test_set_and_verify_various_reg_values },
> +	{ "clear kvm_dirty_regs bits", test_clear_kvm_dirty_regs_bits },
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +	static struct kvm_run *run;
> +	static struct kvm_vm *vm;
> +	int idx;
> +
> +	/* Tell stdout not to buffer its content */
> +	setbuf(stdout, NULL);
> +
> +	ksft_print_header();
> +
> +	if (!kvm_check_cap(KVM_CAP_SYNC_REGS))
> +		ksft_exit_skip("CAP_SYNC_REGS not supported");
> +
> +	ksft_set_plan(ARRAY_SIZE(testlist));
> +
> +	/* Create VM */
> +	vm = vm_create_default(VCPU_ID, 0, guest_code);
> +
> +	run = vcpu_state(vm, VCPU_ID);
> +
> +	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
> +		testlist[idx].test(vm, run);
> +		ksft_test_result_pass("%s\n", testlist[idx].name);
> +	}
>   
>   	kvm_vm_free(vm);
>   
> -	return 0;
> +	ksft_finished();
>   }

