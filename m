Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43BB4BA78B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 18:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiBQRy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 12:54:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbiBQRy6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 12:54:58 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF52B1039
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 09:54:43 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id q20so2318903ioi.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e5+j39i13fFYZEoD3DCwP8XttAEX4sDat27MGjT25cA=;
        b=WfLn02BFrCw1wY2L0Idi3skV3nRf6FNMvdRR1KwMO4frJ+Z3I3V1WuMy+CRlyxdIu2
         L15JTX+C5MHZS4esxx//5VzgfkFgyDlVvvAoZP8lAblXyoGhoCNsFP6fu8Ivjgux6HfE
         cawsUNnrWE7tEiNMW1Hl8eq2eejTilBwdVWlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5+j39i13fFYZEoD3DCwP8XttAEX4sDat27MGjT25cA=;
        b=pVi1MWohjNoLQ52SENz5mZnENkrcgSY6fGVi0/NKWHmZD/yCnp2ZBJM6Bc6ckkvvXr
         WRInN0U4hv8XsZqjlWeNHqdxf1TisIrwArUIAevmenoxJ+N9odWtLrEWAm7ASP3xNL4u
         Y1RVRvtVrfHf/d1SHAvChx/AnW2SA58J8jlnyLiV0q5B4KcGbveIqqHMhdQ3eUIjDsIL
         ob3i7d0LAU67gGwI6904YRqDpHt8kbeAZSUkjbfXpcqstCAYFCZ64hzTs0mw6HRmK/X1
         NyGNMjsPq96Ze9mspwU3q6xXp1hzFyHypVHICq4nkUkuOlYtR5kcOAA1/7LuDfGiUkbH
         4UHg==
X-Gm-Message-State: AOAM531vBbz8cV/H5+QTsz/dtbjhVHsWp+o7WzZbstFxpB1NtOd7fO37
        9EGycyjUgjxLFtTqc6X9IqJ87w==
X-Google-Smtp-Source: ABdhPJxSu1A/OTw4VzSbhU1MEBNMeS2u06JBywtGIaM6G4sX/h2cM7wD49LlSZPRoVsAthdhGIigeg==
X-Received: by 2002:a02:6a0f:0:b0:30e:e62e:1148 with SMTP id l15-20020a026a0f000000b0030ee62e1148mr2694652jac.316.1645120482467;
        Thu, 17 Feb 2022 09:54:42 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e15sm2251575iov.53.2022.02.17.09.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:54:42 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: s390: selftests: Test vm and vcpu memop with
 keys
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220217145336.1794778-1-scgl@linux.ibm.com>
 <20220217145336.1794778-3-scgl@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d0b5b03-21f4-0402-779a-788d4bd58071@linuxfoundation.org>
Date:   Thu, 17 Feb 2022 10:54:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220217145336.1794778-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/17/22 7:53 AM, Janis Schoetterl-Glausch wrote:
> Test storage key checking for both vm and vcpu MEM_OP ioctls.
> Test both error and non error conditions.
> 

This patch seems to combine restructuring the code and new code.
e,g test_errors() was added in the last patch, only to be redone
in this patch with test_errors split into test_common_errors()

Doing restructure in a separate patch and then adding new code
makes it easier to review and also keep them simpler patches.

Please split the code in these two patches to just do restructure
and then add new code.

I also would like to have good reasons to change existing code and
make them into macros.
  
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 342 +++++++++++++++++++++-
>   1 file changed, 328 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 4510418d73e6..bc12a9238967 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -201,6 +201,8 @@ static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
>   #define PAGE_SHIFT 12
>   #define PAGE_SIZE (1ULL << PAGE_SHIFT)
>   #define PAGE_MASK (~(PAGE_SIZE - 1))
> +#define CR0_FETCH_PROTECTION_OVERRIDE	(1UL << (63 - 38))
> +#define CR0_STORAGE_PROTECTION_OVERRIDE	(1UL << (63 - 39))
>   
>   #define ASSERT_MEM_EQ(p1, p2, size) \
>   	TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
> @@ -235,6 +237,11 @@ static struct test_default test_default_init(void *guest_code)
>   	return t;
>   }
>   
> +static vm_vaddr_t test_vaddr_alloc(struct test_vcpu vm, size_t size, vm_vaddr_t vaddr_min)
> +{
> +	return vm_vaddr_alloc(vm.vm, size, vaddr_min);
> +}
> +

What is the value of adding a new routine that simply calls another?
Do you see this routine changing in the future to do more?

thanks,
-- Shuah
