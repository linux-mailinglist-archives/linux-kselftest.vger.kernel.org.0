Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF245B77F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiIMRak (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiIMRaO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 13:30:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC4836DE0;
        Tue, 13 Sep 2022 09:19:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w20so265607ply.12;
        Tue, 13 Sep 2022 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JRpSe51gO9elcRpNLQ13XpR1BjhyoW7VoSIpUC+x7RI=;
        b=Eonuy6tP0PQq6FJE+yAdGYE4n7+/QEnfURtlysVXZkisYqC6MQK8pg4FSKqNDfNend
         OeX/Tu38DpQzJf/kaFZkBZgFegcxev/dClMV7FHVh7bO9ezKK+2I92MkHjic6QqaIiH2
         wMM5mt1u0ueFdumkSmKOV/boMIur2vQLfPICJOUl7LjeBk9QhuIggiewGGVlfhRdpCNy
         SYCXv0IV9Kd8C03Dx2kHyy5W36X83WC6mjHzGw/mKaGP9yc0hCY/JyHyAHP2sOnC43Le
         gQ2Cok7GMNbUgE/a3EkIOr2FBDLWzHcxkpa4J886i3fVUPYH2oww+ylvu9LjSOmWw7/0
         a4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JRpSe51gO9elcRpNLQ13XpR1BjhyoW7VoSIpUC+x7RI=;
        b=H/kO+vdHf5Q+wZOTDrJ/bqydO5vaPkLc1G3VJaJnFocdZrUm2HSE508Z5tGRonFlQ0
         Ow47wnXaejEjVmmgxtDrXvO5HbueNAc0dYP8zknCjd//5ZCG9cK6L9ZehRFFvwo1fI5t
         sqmc8LOsJnLiKmPHLtpOKAya/mckbIZYChq85oIKwbZqpL3gB9bytHlmfSIWNmNR44LL
         cT9yi94oARCQ0Zz7ryeb0kPIr86fL7q4fQI9s9EiXzOhC6EDl4ENIptvenspEX3+6wVi
         R6nsMy/VFW5MZjR51+vgXuZ8wb/8DXy8i4DeOZVp3knvA7y6NqzxfAmwZLkP2OeHzpa0
         c/zg==
X-Gm-Message-State: ACrzQf2uewmdtkLCh4/MY1fZ72PyHxlfffOcrqqw+G3zlgwtyiRsL5om
        UYCkCTaMILHX0Z2CRik+m6Q=
X-Google-Smtp-Source: AMsMyM5t1BxKo7mB4oo2cqqSwlWl3t+9pzST0FUwIknMPIUKkYQGfi4+HWWZNiyQ/6X522JJR731MA==
X-Received: by 2002:a17:90a:e60c:b0:202:6ef8:4b52 with SMTP id j12-20020a17090ae60c00b002026ef84b52mr81315pjy.236.1663085956264;
        Tue, 13 Sep 2022 09:19:16 -0700 (PDT)
Received: from biggie ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ac68c00b002009c05b802sm7459286pjt.2.2022.09.13.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:19:15 -0700 (PDT)
Date:   Tue, 13 Sep 2022 21:49:10 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     seanjc@google.com, guang.zeng@intel.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/kvm: Use num_vcpus when testing ICR in the
 xapic_state_test
Message-ID: <YyCtfu8zvvTKKs1u@biggie>
References: <20220903073901.73862-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903073901.73862-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 03, 2022 at 01:09:01PM +0530, Gautam Menghani wrote:
> A TODO in xapic_state_test asks to use number of vCPUs instead of
> vcpu.id + 1 in test_icr(). This patch adds support to get the number 
> of vCPUs from the VM created and use it.
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  .../selftests/kvm/x86_64/xapic_state_test.c     | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> index 6f7a5ef66718..de934e8e5e41 100644
> --- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> @@ -96,9 +96,8 @@ static void __test_icr(struct xapic_vcpu *x, uint64_t val)
>  	____test_icr(x, val & ~(u64)APIC_ICR_BUSY);
>  }
>  
> -static void test_icr(struct xapic_vcpu *x)
> +static void test_icr(struct xapic_vcpu *x, int num_vcpus)
>  {
> -	struct kvm_vcpu *vcpu = x->vcpu;
>  	uint64_t icr, i, j;
>  
>  	icr = APIC_DEST_SELF | APIC_INT_ASSERT | APIC_DM_FIXED;
> @@ -110,11 +109,11 @@ static void test_icr(struct xapic_vcpu *x)
>  		__test_icr(x, icr | i);
>  
>  	/*
> -	 * Send all flavors of IPIs to non-existent vCPUs.  TODO: use number of
> -	 * vCPUs, not vcpu.id + 1.  Arbitrarily use vector 0xff.
> +	 * Send all flavors of IPIs to non-existent vCPUs. Arbitrarily use vector 0xff.
>  	 */
> +
>  	icr = APIC_INT_ASSERT | 0xff;
> -	for (i = vcpu->id + 1; i < 0xff; i++) {
> +	for (i = num_vcpus; i < 0xff; i++) {
>  		for (j = 0; j < 8; j++)
>  			__test_icr(x, i << (32 + 24) | icr | (j << 8));
>  	}
> @@ -137,9 +136,13 @@ int main(int argc, char *argv[])
>  		.is_x2apic = true,
>  	};
>  	struct kvm_vm *vm;
> +	struct list_head *iter;
> +	int nr_vcpus_created = 0;
>  
>  	vm = vm_create_with_one_vcpu(&x.vcpu, x2apic_guest_code);
> -	test_icr(&x);
> +	list_for_each(iter, &vm->vcpus)
> +		nr_vcpus_created++;
> +	test_icr(&x, nr_vcpus_created);
>  	kvm_vm_free(vm);
>  
>  	/*
> @@ -153,6 +156,6 @@ int main(int argc, char *argv[])
>  	vcpu_clear_cpuid_feature(x.vcpu, X86_FEATURE_X2APIC);
>  
>  	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
> -	test_icr(&x);
> +	test_icr(&x, nr_vcpus_created);
>  	kvm_vm_free(vm);
>  }
> -- 
> 2.34.1
> 

Hi,

Please review the above patch and let me know if any change is required.

Thanks,
Gautam
