Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B8F500C6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242542AbiDNLzA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDNLzA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:55:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD6885BF1;
        Thu, 14 Apr 2022 04:52:35 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EA54MU018264;
        Thu, 14 Apr 2022 11:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=jy6pMQzK/sf8v366NBgPB3PYCPB+8C4yfgy5SBgvW3Y=;
 b=tgF4ss+6jsyV8m931IWh9QfUAVC56aDeu/A48s+gAUWCQXC1fvq2rBAm02huw4ytowIS
 36xflN2eEt1EXUhl5ODJ0qwpwkOaW2FkcbquAMsxT3HU2lZGqOGxL3D2LsvxXGF+CQ+F
 9gYWIKA2C1EnhneWYjI9eflyse8pEDugSrgNlUmNXySyKACrUrQM2SHFyMljtCN8WVeC
 nhHx0RpbdRQOf0l2ha8WtbC/gN/MkldbiNPwuI0/QyZ5IVr6Fcguvq4Yjy0h63eJv5By
 BWOFUD/xIFKRH3DPz1lo9gprrtk/HNvNlI1bdPv4t9yUz9PNGjC+u5nXo6sDm9tIyHgb ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fefr9kums-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 11:52:33 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23EBmkUR029691;
        Thu, 14 Apr 2022 11:52:32 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fefr9kumf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 11:52:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23EBmNSR017259;
        Thu, 14 Apr 2022 11:52:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3fb1s90dm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 11:52:30 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23EBqRnO28377370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 11:52:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00E6E11C04C;
        Thu, 14 Apr 2022 11:52:27 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D92D11C050;
        Thu, 14 Apr 2022 11:52:26 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.140])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Apr 2022 11:52:26 +0000 (GMT)
Date:   Thu, 14 Apr 2022 13:51:10 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Subject: Re: [PATCH 3/4] KVM: s390: selftests: Use TAP interface in the
 tprot test
Message-ID: <20220414135110.6b2baead@p-imbrenda>
In-Reply-To: <20220414105322.577439-4-thuth@redhat.com>
References: <20220414105322.577439-1-thuth@redhat.com>
        <20220414105322.577439-4-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AO3WHVyr4ZmKOBM1HWGIwUff5spqNczk
X-Proofpoint-GUID: CMHZIyZlHUCLL3bEQbOI3Ew4HdtuwSmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_03,2022-04-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 14 Apr 2022 12:53:21 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The tprot test currently does not have any output (unless one of
> the TEST_ASSERT statement fails), so it's hard to say for a user
> whether a certain new sub-test has been included in the binary or
> not. Let's make this a little bit more user-friendly and include
> some TAP output via the kselftests.h interface.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/s390x/tprot.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
> index c097b9db495e..a714b4206e95 100644
> --- a/tools/testing/selftests/kvm/s390x/tprot.c
> +++ b/tools/testing/selftests/kvm/s390x/tprot.c
> @@ -8,6 +8,7 @@
>  #include <sys/mman.h>
>  #include "test_util.h"
>  #include "kvm_util.h"
> +#include "kselftest.h"
>  
>  #define PAGE_SHIFT 12
>  #define PAGE_SIZE (1 << PAGE_SHIFT)
> @@ -69,6 +70,7 @@ enum stage {
>  	STAGE_INIT_FETCH_PROT_OVERRIDE,
>  	TEST_FETCH_PROT_OVERRIDE,
>  	TEST_STORAGE_PROT_OVERRIDE,
> +	NUM_STAGES			/* this must be the last entry */
>  };
>  
>  struct test {
> @@ -196,6 +198,7 @@ static void guest_code(void)
>  	}									\
>  	ASSERT_EQ(uc.cmd, UCALL_SYNC);						\
>  	ASSERT_EQ(uc.args[1], __stage);						\
> +	ksft_test_result_pass("" #stage "\n");					\
>  })
>  
>  int main(int argc, char *argv[])
> @@ -204,6 +207,9 @@ int main(int argc, char *argv[])
>  	struct kvm_run *run;
>  	vm_vaddr_t guest_0_page;
>  
> +	ksft_print_header();
> +	ksft_set_plan(NUM_STAGES - 1);	/* STAGE_END is not counted, thus - 1 */
> +
>  	vm = vm_create_default(VCPU_ID, 0, guest_code);
>  	run = vcpu_state(vm, VCPU_ID);
>  
> @@ -213,7 +219,7 @@ int main(int argc, char *argv[])
>  
>  	guest_0_page = vm_vaddr_alloc(vm, PAGE_SIZE, 0);
>  	if (guest_0_page != 0)
> -		print_skip("Did not allocate page at 0 for fetch protection override tests");
> +		ksft_print_msg("Did not allocate page at 0 for fetch protection override tests\n");

will this print a skip, though?

or you don't want to print a skip because then the numbering in the
planning doesn't match anymore? in which case, is there an easy way to
fix it?

>  	HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
>  	if (guest_0_page == 0)
>  		mprotect(addr_gva2hva(vm, (vm_vaddr_t)0), PAGE_SIZE, PROT_READ);
> @@ -224,4 +230,8 @@ int main(int argc, char *argv[])
>  	run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
>  	run->kvm_dirty_regs = KVM_SYNC_CRS;
>  	HOST_SYNC(vm, TEST_STORAGE_PROT_OVERRIDE);
> +
> +	kvm_vm_free(vm);
> +
> +	ksft_finished();
>  }

