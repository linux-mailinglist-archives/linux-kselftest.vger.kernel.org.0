Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044085BEE05
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 21:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiITTvS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 15:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiITTvR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 15:51:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849116FA2E
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Sep 2022 12:51:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 78so3711404pgb.13
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Sep 2022 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DTuwHmur8BQ7UzvYXiSfhG6hoCLOFlEZLc+v/yhwyjc=;
        b=RBtwoayj+pMK/J5jSI0mvoHQG0BJON5T+gf4rKX8Rq65AY9XUeli1UUam9cEOdwCAC
         x8gHFCFL/icqEGcNeWXHYdTE02bXSyc+MV5I6e+kPHCYobDuk8E18tp7lCpTuJHGrllN
         fbxAe321lGeeHrzc+Ra82RYS1HVvMLDfTirYcgq/8rboWH0JckIn6jecDWxBKEDr/SGw
         i0Vquzu9V1zci54lVCEK9NvAHru6Jcbfa3XI7Y1FLDGHulIX+dwJ1kLrCyBMkOuqvzfw
         2oK92I1Bd+apQXpZ6IMsdy7zCALZAtqKt4nDiO7GtPdba0vXE4LR7n8j8mDCrSyBDLl8
         jDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DTuwHmur8BQ7UzvYXiSfhG6hoCLOFlEZLc+v/yhwyjc=;
        b=Ecn46NUyxD6zf1BTV9lGNRX8N//19KoMlqa9lOM0KSY8FGNHTtCSuc39usfROqxI0O
         bqw9OO9eePLqVhwMSZhOwjYKcHyMcZjuScbQkpgyVU7SXswB9qZGemvuRVDaCq0Yr7AC
         GvjOvMAOw8KZCK9uarsG0dBR3geyjKj+wPIfQlKCN1oBIUe+uY8smMD0ABBd7Pux4MaD
         pXpbdw+BG7epPwZhXNoV/g3QPTEKdeDi+FtfNYA0T29RmlvwYyWZEGuRiFqGW4UcmwFp
         32XfzBTOkQG9O7rvcvwqLw43S1IO2Z00MLveZsNBAaYlRTTr3SvGxyt0cBDKrXc6odsS
         0ncw==
X-Gm-Message-State: ACrzQf1F9JO9eRncZ9mUINRfL3NvHbo3iVWuFGVquogQe5COXqe19497
        I9GMKrvB2UnLm21ECrQetLbgcQ==
X-Google-Smtp-Source: AMsMyM7jex9Q5arTcLqho5hOOC6Z04y67nCb26iNt51DRVTZbuq+ew/XjLCTxS9HZwnDheQ8q64NMw==
X-Received: by 2002:a63:1455:0:b0:438:e26b:ab1f with SMTP id 21-20020a631455000000b00438e26bab1fmr20977346pgu.183.1663703475946;
        Tue, 20 Sep 2022 12:51:15 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a7f8100b002008ba3a74csm256802pjl.52.2022.09.20.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:51:15 -0700 (PDT)
Date:   Tue, 20 Sep 2022 19:51:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     pbonzini@redhat.com, shuah@kernel.org, guang.zeng@intel.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/kvm: Use num_vcpus when testing ICR in the
 xapic_state_test
Message-ID: <YyoZr9rXSSMEtdh5@google.com>
References: <20220903073901.73862-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903073901.73862-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 03, 2022, Gautam Menghani wrote:
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

Hrm, this is a bad TODO, which is 100% my fault.  I think past me wanted to play
nice with the possibility of creating multiple vCPUs, but using the number of
vCPUs to do that is the wrong approach as it makes assumptions on the vcpu_id.
One of the goals of the refactoring that led to vm_create_with_one_vcpu() was
to have tests stop making assumptions about vCPU IDs.

What would make sense though is to not assume vcpu_id == 0, i.e.

	if (i = 0; i < 0xff; i++) {
		if (i == vcpu->id)
			continue;

		for (j = 0; j < 8; j++)
			__test_icr(x, i << (32 + 24) | icr | (j << 8));

	}

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

Computing the number of vCPUs created is rather silly, the test _knows_ that it
has created exacty one vCPU.  Should be a moot point though.
