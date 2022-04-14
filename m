Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CCD500E05
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 14:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbiDNMvM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 08:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiDNMvL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 08:51:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23D49157B;
        Thu, 14 Apr 2022 05:48:42 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EC48ZL008872;
        Thu, 14 Apr 2022 12:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QA7gBG0Vqb6X4lCe7FycL06CwTbFrS+3RDRfZYSVa1Q=;
 b=mKfOz03GtPgM/CUR7U7FJY0T6kWbL0TZdTdVGbkfbiil7VrASOFOjf3k2Uuf+HHQXVr5
 1PzqYVcgenAe27Ry6SSY1YDU2Msg8gw6NJpjT/a2n1aHyAzpTa00yiJMHGO/UNqg0SCx
 MF44QX+0PipXbx5zpYgT1OqhE2Fme2RhgQuU/Eq2I9g+VEFK3GKKTxIJSamLcf6sjL76
 Jwvp0EBEWHVzOUo3fExGvCxk11lBjXllFVqUTEcvCbgMIHpRgRyTPG3nlgcyadK+yGsw
 1JEVCeEfaW1r3ZN7Dv2+7n8DumE3/3Hq9FbaBkCiUiVL/d62EnLwTn6ZlZtM1vIL95DR 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3febpbsxgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 12:48:39 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23ECSbDo017078;
        Thu, 14 Apr 2022 12:48:39 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3febpbsxfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 12:48:39 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23EClepd013947;
        Thu, 14 Apr 2022 12:48:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fbsj05t08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 12:48:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23ECmYjF25952534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 12:48:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 394CF42041;
        Thu, 14 Apr 2022 12:48:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7A5C4203F;
        Thu, 14 Apr 2022 12:48:33 +0000 (GMT)
Received: from [9.171.78.130] (unknown [9.171.78.130])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Apr 2022 12:48:33 +0000 (GMT)
Message-ID: <3c627856-5e66-3cbe-adab-464ae573e23d@linux.ibm.com>
Date:   Thu, 14 Apr 2022 14:48:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] KVM: s390: selftests: Use TAP interface in the memop
 test
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220414105322.577439-1-thuth@redhat.com>
 <20220414105322.577439-2-thuth@redhat.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <20220414105322.577439-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hpLZtOw-PYvrQbNwLUGCQ_XTNFvLSYxn
X-Proofpoint-ORIG-GUID: vu21Wmc0awv14lNgwkJxxc60la1ShQLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_04,2022-04-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140068
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/22 12:53, Thomas Huth wrote:
> The memop test currently does not have any output (unless one of the
> TEST_ASSERT statement fails), so it's hard to say for a user whether
> a certain new sub-test has been included in the binary or not. Let's
> make this a little bit more user-friendly and include some TAP output
> via the kselftests.h interface.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 90 ++++++++++++++++++-----
>  1 file changed, 73 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index b04c2c1b3c30..a2783d9afcac 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -12,6 +12,7 @@
>  
>  #include "test_util.h"
>  #include "kvm_util.h"
> +#include "kselftest.h"
>  
>  enum mop_target {
>  	LOGICAL,
> @@ -648,33 +649,88 @@ static void test_errors(void)
>  	kvm_vm_free(t.kvm_vm);
>  }
>  
> +struct testdef {
> +	const char *name;
> +	void (*test)(void);
> +	bool needs_extension;

Please make this numeric. You could also rename it to required_extension or similar.

> +} testlist[] = {
> +	{
> +		.name = "simple copy",
> +		.test = test_copy,
> +		.needs_extension = false,
> +	},
> +	{
> +		.name = "copy with storage keys",
> +		.test = test_copy_key,
> +		.needs_extension = true,
> +	},
> +	{
> +		.name = "copy with key storage protection override",
> +		.test = test_copy_key_storage_prot_override,
> +		.needs_extension = true,
> +	},
> +	{
> +		.name = "copy with key fetch protection",
> +		.test = test_copy_key_fetch_prot,
> +		.needs_extension = true,
> +	},
> +	{
> +		.name = "copy with key fetch protection override",
> +		.test = test_copy_key_fetch_prot_override,
> +		.needs_extension = true,
> +	},
> +	{
> +		.name = "error checks with key",
> +		.test = test_errors_key,
> +		.needs_extension = true,
> +	},
> +	{
> +		.name = "error checks with key storage protection override",
> +		.test = test_errors_key_storage_prot_override,
> +		.needs_extension = true,
> +	},
> +	{
> +		.name = "error checks without key fetch prot override",
> +		.test = test_errors_key_fetch_prot_override_not_enabled,
> +		.needs_extension = true,
> +	},
> +	{
> +		.name = "error checks with key fetch prot override",
> +		.test = test_errors_key_fetch_prot_override_enabled,
> +		.needs_extension = true,
> +	},
> +	{
> +		.name = "generic error checks",
> +		.test = test_errors,
> +		.needs_extension = false,
> +	},
> +};
> +
>  int main(int argc, char *argv[])
>  {
> -	int memop_cap, extension_cap;
> +	int memop_cap, extension_cap, idx;
>  
>  	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
>  
> +	ksft_print_header();
> +
>  	memop_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP);
>  	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
>  	if (!memop_cap) {
> -		print_skip("CAP_S390_MEM_OP not supported");
> -		exit(KSFT_SKIP);
> +		ksft_exit_skip("CAP_S390_MEM_OP not supported.\n");
>  	}
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
> +		if (!testlist[idx].needs_extension || extension_cap) {

Then check here that extension_cap >= the required extension.
This way the test can easily be adapted in case of future extensions.
> +			testlist[idx].test();
> +			ksft_test_result_pass("%s\n", testlist[idx].name);
> +		} else {
> +			ksft_test_result_skip("%s - storage key memop not supported\n",
> +					      testlist[idx].name);
> +		}
>  	}
> -	test_errors();
>  
> -	return 0;
> +	ksft_finished();
>  }

