Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAF45085D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 12:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbiDTKZ5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiDTKZ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 06:25:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DC3F325;
        Wed, 20 Apr 2022 03:23:10 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K8ch5l024950;
        Wed, 20 Apr 2022 10:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2JXeKqWWt88XPm4/48YPHM5ctyUMdD8aKeTOLMdNvZg=;
 b=FSFRrXPpSAcx0PcxDHCSdjgdZ1lS3bPWB4g8WBQTk+WIMsO9+ABiuQCyVMqIDoaKt8z7
 cy/cYddxXE9+MkkJBszc+4rQgYBgr+iSdOhJfIsu9tzyioGsvkB3FEv4H/UR9fpbsIFX
 WOrI1UK+oCxMWiLlVCQSEfZQtsHNhjZ6PZPQP5/6D/uDoCEeEjH8DpEHB27bXZAh7kV0
 3uxXTf2fGeyjT7Xhf+M11F4CDgC53fQDhw+hnJN7IoU2TuWclkYFk/hMUt4RG9+dmBap
 VbUcVKMucQ7Yew3JM6q7rj5mJ76Spu+Yy0olB+aUd/IhSH5r8Mw+Aibndzjg5Mz4dIoE DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fhuukb1b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:23:07 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KACV7R020268;
        Wed, 20 Apr 2022 10:23:07 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fhuukb1aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:23:06 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KAD0Lu019405;
        Wed, 20 Apr 2022 10:23:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3ffne8vt7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:23:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KAN1kQ49676624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 10:23:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 762F4AE04D;
        Wed, 20 Apr 2022 10:23:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04F6CAE045;
        Wed, 20 Apr 2022 10:23:01 +0000 (GMT)
Received: from [9.145.164.14] (unknown [9.145.164.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 10:23:00 +0000 (GMT)
Message-ID: <65711eda-76da-882c-ee3e-a0f8805943ab@linux.ibm.com>
Date:   Wed, 20 Apr 2022 12:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] KVM: s390: selftests: Use TAP interface in the
 tprot test
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
 <20220419185857.128351-4-thuth@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220419185857.128351-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T2MuDnXu-0nQf3cbVqhNFgnJwe4zJ7Gz
X-Proofpoint-GUID: tiIJXkW-s6mv4XbPnBkZpxfTly2NVBPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_02,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200063
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
> The tprot test currently does not have any output (unless one of
> the TEST_ASSERT statement fails), so it's hard to say for a user
> whether a certain new sub-test has been included in the binary or
> not. Let's make this a little bit more user-friendly and include
> some TAP output via the kselftests.h interface.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Some comments below.

> ---
>   tools/testing/selftests/kvm/s390x/tprot.c | 28 +++++++++++++++++++----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
> index c097b9db495e..baba883d7a6d 100644
> --- a/tools/testing/selftests/kvm/s390x/tprot.c
> +++ b/tools/testing/selftests/kvm/s390x/tprot.c
> @@ -8,6 +8,7 @@
>   #include <sys/mman.h>
>   #include "test_util.h"
>   #include "kvm_util.h"
> +#include "kselftest.h"
>   
>   #define PAGE_SHIFT 12
>   #define PAGE_SIZE (1 << PAGE_SHIFT)
> @@ -63,12 +64,12 @@ static enum permission test_protection(void *addr, uint8_t key)
>   }
>   
>   enum stage {
> -	STAGE_END,
>   	STAGE_INIT_SIMPLE,
>   	TEST_SIMPLE,
>   	STAGE_INIT_FETCH_PROT_OVERRIDE,
>   	TEST_FETCH_PROT_OVERRIDE,
>   	TEST_STORAGE_PROT_OVERRIDE,
> +	STAGE_END			/* this must be the last entry */

...so we can use it to calculate the test number

>   };
>   
>   struct test {
> @@ -182,7 +183,7 @@ static void guest_code(void)
>   	GUEST_SYNC(perform_next_stage(&i, mapped_0));
>   }
>   

> @@ -212,9 +222,13 @@ int main(int argc, char *argv[])
>   	HOST_SYNC(vm, TEST_SIMPLE);
>   
>   	guest_0_page = vm_vaddr_alloc(vm, PAGE_SIZE, 0);
> -	if (guest_0_page != 0)
> -		print_skip("Did not allocate page at 0 for fetch protection override tests");
> -	HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
> +	if (guest_0_page != 0) {

Maybe add:
/* Use no_tap so we don't get a PASS print */

> +		HOST_SYNC_NO_TAP(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
> +		ksft_test_result_skip("STAGE_INIT_FETCH_PROT_OVERRIDE - "
> +				      "Did not allocate page at 0\n");
> +	} else {
> +		HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
> +	}

Otherwise this would look weird.

>   	if (guest_0_page == 0)
>   		mprotect(addr_gva2hva(vm, (vm_vaddr_t)0), PAGE_SIZE, PROT_READ);
>   	run->s.regs.crs[0] |= CR0_FETCH_PROTECTION_OVERRIDE;
> @@ -224,4 +238,8 @@ int main(int argc, char *argv[])
>   	run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
>   	run->kvm_dirty_regs = KVM_SYNC_CRS;
>   	HOST_SYNC(vm, TEST_STORAGE_PROT_OVERRIDE);
> +
> +	kvm_vm_free(vm);
> +
> +	ksft_finished();
>   }

