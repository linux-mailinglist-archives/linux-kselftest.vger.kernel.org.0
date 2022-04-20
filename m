Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E435084CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbiDTJYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 05:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244208AbiDTJYX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 05:24:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9427FE2;
        Wed, 20 Apr 2022 02:21:38 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K8wpsl005532;
        Wed, 20 Apr 2022 09:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Qi5kOMn/VW1X7Sgjn67bEyOT03thHhFxSSziyXqmlOc=;
 b=oMxsytYqpiPpT0PGjZa0GncbiJHyFDxtDxkBYEeXacBhb7pN8EMrUwvoHargG9KHWzCp
 jJHzYRKoaXKdjmNvR1yqvHzKt1uksmHV7hunER+nmeHbAodftBdM8y8KAMayfyKqtvCN
 lVn5iaOaZbHTqgi0FwJnjvhjnvg7UTPhR2WWk4/WhBcu+aq+shAZJlkFFLgl1MHDJ80f
 51aH85/+J3CgQpwxF+GiOFkLT8ttvCfGxH1EwKiTyq6VOV65TfoPYp5p69ouW9AHqWIr
 oUSew4N/RVdFclmbGB3+vLjiH/dIdLmAlvzs3Xv3yZWgqnNw/SoVJk0krLeoQKJppwcb hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjf51rdcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 09:21:35 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23K9DTBJ004214;
        Wed, 20 Apr 2022 09:21:34 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjf51rdc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 09:21:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23K97Ata013842;
        Wed, 20 Apr 2022 09:21:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3ffne9616v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 09:21:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23K9LTGt49545570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 09:21:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B00BEAE04D;
        Wed, 20 Apr 2022 09:21:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D576AE045;
        Wed, 20 Apr 2022 09:21:29 +0000 (GMT)
Received: from [9.145.164.14] (unknown [9.145.164.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 09:21:29 +0000 (GMT)
Message-ID: <f836b7e2-f581-3002-0d99-cd0f186c33c8@linux.ibm.com>
Date:   Wed, 20 Apr 2022 11:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
 <20220419185857.128351-2-thuth@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] KVM: s390: selftests: Use TAP interface in the
 memop test
In-Reply-To: <20220419185857.128351-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kFU9QUo-RCANII1yt6kiiUSw1kmkRhJG
X-Proofpoint-ORIG-GUID: oaBnK_-JulFlsAtJCq-b1JW6nmmB9GHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_02,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
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
> The memop test currently does not have any output (unless one of the
> TEST_ASSERT statement fails), so it's hard to say for a user whether
> a certain new sub-test has been included in the binary or not. Let's
> make this a little bit more user-friendly and include some TAP output
> via the kselftests.h interface.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 90 ++++++++++++++++++-----
>   1 file changed, 73 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index b04c2c1b3c30..ad9fe86c0592 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -12,6 +12,7 @@
>   
>   #include "test_util.h"
>   #include "kvm_util.h"
> +#include "kselftest.h"
>   
>   enum mop_target {
>   	LOGICAL,
> @@ -648,33 +649,88 @@ static void test_errors(void)
>   	kvm_vm_free(t.kvm_vm);
>   }
>   
> +struct testdef {
> +	const char *name;
> +	void (*test)(void);
> +	int cap;
> +} testlist[] = {
> +	{
> +		.name = "simple copy",
> +		.test = test_copy,
> +	},
> +	{
> +		.name = "generic error checks",
> +		.test = test_errors,
> +	},
> +	{
> +		.name = "copy with storage keys",
> +		.test = test_copy_key,
> +		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
> +	},
> +	{
> +		.name = "copy with key storage protection override",
> +		.test = test_copy_key_storage_prot_override,
> +		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
> +	},
> +	{
> +		.name = "copy with key fetch protection",
> +		.test = test_copy_key_fetch_prot,
> +		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
> +	},
> +	{
> +		.name = "copy with key fetch protection override",
> +		.test = test_copy_key_fetch_prot_override,
> +		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
> +	},
> +	{
> +		.name = "error checks with key",
> +		.test = test_errors_key,
> +		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
> +	},
> +	{
> +		.name = "error checks with key storage protection override",
> +		.test = test_errors_key_storage_prot_override,
> +		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
> +	},
> +	{
> +		.name = "error checks without key fetch prot override",
> +		.test = test_errors_key_fetch_prot_override_not_enabled,
> +		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
> +	},
> +	{
> +		.name = "error checks with key fetch prot override",
> +		.test = test_errors_key_fetch_prot_override_enabled,
> +		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
> +	},
> +};
> +
>   int main(int argc, char *argv[])
>   {
> -	int memop_cap, extension_cap;
> +	int memop_cap, extension_cap, idx;
>   
>   	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
>   
> +	ksft_print_header();
> +
>   	memop_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP);
>   	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
>   	if (!memop_cap) {
> -		print_skip("CAP_S390_MEM_OP not supported");
> -		exit(KSFT_SKIP);
> +		ksft_exit_skip("CAP_S390_MEM_OP not supported.\n");
>   	}
>   
> -	test_copy();
> -	if (extension_cap > 0) {
> -		test_copy_key();
> -		test_copy_key_storage_prot_override();
> -		test_copy_key_fetch_prot();
> -		test_copy_key_fetch_prot_override();
> -		test_errors_key();
> -		test_errors_key_storage_prot_override();
> -		test_errors_key_fetch_prot_override_not_enabled();
> -		test_errors_key_fetch_prot_override_enabled();
> -	} else {
> -		print_skip("storage key memop extension not supported");
> +	ksft_set_plan(ARRAY_SIZE(testlist));
> +
> +	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
> +		if (!testlist[idx].cap || (extension_cap &&
> +		    testlist[idx].cap == KVM_CAP_S390_MEM_OP_EXTENSION)) {
> +			testlist[idx].test();
> +			ksft_test_result_pass("%s\n", testlist[idx].name);
> +		} else {
> +			ksft_test_result_skip("%s - capability %d not supported\n",
> +					      testlist[idx].name,
> +					      testlist[idx].cap);
> +		}
>   	}
> -	test_errors();
>   
> -	return 0;
> +	ksft_finished();
>   }

