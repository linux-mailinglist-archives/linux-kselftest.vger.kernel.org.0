Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA375E556A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 23:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiIUVrw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 17:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiIUVrv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 17:47:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21A0A6C23
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 14:47:50 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u132so7319960pfc.6
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=86et5oX9RjueDiAyOv4gfnVvcOwRUYxdctcYkvL3N04=;
        b=s3ECOrjNOsIGfAQfM9KSc6LpIJEW4/MzxpA5fiQxl5a4IUab6wnWUllhcoq7mkSBQ6
         6ln5MGfcQaiaLRgC8sDqihKGU7MFWexUsQSiPFAdHrpr8mMCfuV07NZHN8R2tjkzN94s
         nkk7yGMn1IgUKmBOu4XsDxblxqoW4f8k9Z/xAArg5/i7FN29xWCw3yMqmAKNHcqskrTS
         +JOp+muZvRJmN8cYRL5PAhNlj9dL1r3yQCCBc54NLXCRYYT1tTauLoUMiVCnCpo8muaI
         YoUBrDSP8fa22tT/NhDXymagNbGCL4WvrVFW/7ChdgMk6ZEyT3e07IRodE7FiZrmU4Gd
         zFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=86et5oX9RjueDiAyOv4gfnVvcOwRUYxdctcYkvL3N04=;
        b=C39noAFmyy4CF186ifF/jGAlf69Hb8E3SaJSBFysnpHFIRWZgNOTGw/D3ibBFSZpNP
         bxY04ZTaP0w39a4PYNIOucEvyA4kC/48AfXxgx1S1z1jeOtHYf0lVpcDHAjgkM5gM72N
         451C7lUJ+c69rwu2DWado433VeUFqLR5Lb5hAJUx0C6v+Bh46J/N038ptAiucKEP7zOe
         okYrUFf2/o3PQy8kXLaIVzM6bMb21z3Sf8eT6s9LTrSvzkvW5a4YIhVT0hT3s3YH1Nhd
         ty1Ep7x7RAeGmdC1ip60Y/YEZgGrpvr5crwktxHHgF6fzhJFDFuwrJAAKbujb2rn6bH/
         CnlA==
X-Gm-Message-State: ACrzQf0hsHASXtbZH91tn9YZOADtoyJx3ixG31Q8Ckvd03WixyTHYtVN
        Y5CKl/8DlWXR+Pk2PM4xbN4kBQ==
X-Google-Smtp-Source: AMsMyM4OIhPecKa5vHTMHD6zPtR31nkmpuSYWKAzsa78E6FoHT6I29a4/YPheOoTVNL4OntaPcG5SQ==
X-Received: by 2002:a05:6a00:99c:b0:54c:27c4:3acb with SMTP id u28-20020a056a00099c00b0054c27c43acbmr205368pfg.22.1663796869975;
        Wed, 21 Sep 2022 14:47:49 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id p67-20020a622946000000b00528bd940390sm2532928pfp.153.2022.09.21.14.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:47:49 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:47:45 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com
Subject: Re: [V2 PATCH 8/8] KVM: selftests: x86: xen: Execute cpu specific
 vmcall instruction
Message-ID: <YyuGgX/wA+wvLiOg@google.com>
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-9-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915000448.1674802-9-vannapurve@google.com>
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

On Thu, Sep 15, 2022 at 12:04:48AM +0000, Vishal Annapurve wrote:
> Update xen specific hypercall invocation to execute cpu specific vmcall
> instructions.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../selftests/kvm/x86_64/xen_shinfo_test.c    | 64 +++++++------------
>  .../selftests/kvm/x86_64/xen_vmcall_test.c    | 14 ++--
>  2 files changed, 34 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> index 8a5cb800f50e..92ed07f1c772 100644
> --- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> @@ -145,6 +145,23 @@ static void guest_wait_for_irq(void)
>  	guest_saw_irq = false;
>  }
>  
> +static unsigned long vmcall_helper(unsigned long reg_a, unsigned long reg_di,
> +	unsigned long reg_si)
> +{
> +	unsigned long ret;
> +
> +	if (is_amd_cpu())
> +		__asm__ __volatile__ ("vmmcall" :
> +			"=a" (ret) :
> +			"a" (reg_a), "D" (reg_di), "S" (reg_si));
> +	else
> +		__asm__ __volatile__ ("vmcall" :
> +			"=a" (ret) :
> +			"a" (reg_a), "D" (reg_di), "S" (reg_si));
> +
> +	return ret;
> +}
> +
>  static void guest_code(void)
>  {
>  	struct vcpu_runstate_info *rs = (void *)RUNSTATE_VADDR;
> @@ -217,12 +234,7 @@ static void guest_code(void)
>  	 * EVTCHNOP_send hypercall. */
>  	unsigned long rax;
>  	struct evtchn_send s = { .port = 127 };
> -	__asm__ __volatile__ ("vmcall" :
> -			      "=a" (rax) :
> -			      "a" (__HYPERVISOR_event_channel_op),
> -			      "D" (EVTCHNOP_send),
> -			      "S" (&s));
> -
> +	rax = vmcall_helper(__HYPERVISOR_event_channel_op, EVTCHNOP_send, (unsigned long)&s);
>  	GUEST_ASSERT(rax == 0);
>  
>  	guest_wait_for_irq();
> @@ -232,12 +244,7 @@ static void guest_code(void)
>  	/* Deliver "outbound" event channel to an eventfd which
>  	 * happens to be one of our own irqfds. */
>  	s.port = 197;
> -	__asm__ __volatile__ ("vmcall" :
> -			      "=a" (rax) :
> -			      "a" (__HYPERVISOR_event_channel_op),
> -			      "D" (EVTCHNOP_send),
> -			      "S" (&s));
> -
> +	rax = vmcall_helper(__HYPERVISOR_event_channel_op, EVTCHNOP_send, (unsigned long)&s);
>  	GUEST_ASSERT(rax == 0);
>  
>  	guest_wait_for_irq();
> @@ -245,10 +252,7 @@ static void guest_code(void)
>  	GUEST_SYNC(13);
>  
>  	/* Set a timer 100ms in the future. */
> -	__asm__ __volatile__ ("vmcall" :
> -			      "=a" (rax) :
> -			      "a" (__HYPERVISOR_set_timer_op),
> -			      "D" (rs->state_entry_time + 100000000));
> +	rax = vmcall_helper(__HYPERVISOR_set_timer_op, (rs->state_entry_time + 100000000), 0);
>  	GUEST_ASSERT(rax == 0);
>  
>  	GUEST_SYNC(14);
> @@ -271,36 +275,21 @@ static void guest_code(void)
>  		.timeout = 0,
>  	};
>  
> -	__asm__ __volatile__ ("vmcall" :
> -			      "=a" (rax) :
> -			      "a" (__HYPERVISOR_sched_op),
> -			      "D" (SCHEDOP_poll),
> -			      "S" (&p));
> -
> +	rax = vmcall_helper(__HYPERVISOR_sched_op, SCHEDOP_poll, (unsigned long)&p);
>  	GUEST_ASSERT(rax == 0);
>  
>  	GUEST_SYNC(17);
>  
>  	/* Poll for an unset port and wait for the timeout. */
>  	p.timeout = 100000000;
> -	__asm__ __volatile__ ("vmcall" :
> -			      "=a" (rax) :
> -			      "a" (__HYPERVISOR_sched_op),
> -			      "D" (SCHEDOP_poll),
> -			      "S" (&p));
> -
> +	rax = vmcall_helper(__HYPERVISOR_sched_op, SCHEDOP_poll, (unsigned long)&p);
>  	GUEST_ASSERT(rax == 0);
>  
>  	GUEST_SYNC(18);
>  
>  	/* A timer will wake the masked port we're waiting on, while we poll */
>  	p.timeout = 0;
> -	__asm__ __volatile__ ("vmcall" :
> -			      "=a" (rax) :
> -			      "a" (__HYPERVISOR_sched_op),
> -			      "D" (SCHEDOP_poll),
> -			      "S" (&p));
> -
> +	rax = vmcall_helper(__HYPERVISOR_sched_op, SCHEDOP_poll, (unsigned long)&p);
>  	GUEST_ASSERT(rax == 0);
>  
>  	GUEST_SYNC(19);
> @@ -309,12 +298,7 @@ static void guest_code(void)
>  	 * actual interrupt, while we're polling on a different port. */
>  	ports[0]++;
>  	p.timeout = 0;
> -	__asm__ __volatile__ ("vmcall" :
> -			      "=a" (rax) :
> -			      "a" (__HYPERVISOR_sched_op),
> -			      "D" (SCHEDOP_poll),
> -			      "S" (&p));
> -
> +	rax = vmcall_helper(__HYPERVISOR_sched_op, SCHEDOP_poll, (unsigned long)&p);
>  	GUEST_ASSERT(rax == 0);
>  
>  	guest_wait_for_irq();
> diff --git a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
> index 88914d48c65e..e78f1b5d3af8 100644
> --- a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
> @@ -37,10 +37,16 @@ static void guest_code(void)
>  	register unsigned long r9 __asm__("r9") = ARGVALUE(6);
>  
>  	/* First a direct invocation of 'vmcall' */
> -	__asm__ __volatile__("vmcall" :
> -			     "=a"(rax) :
> -			     "a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
> -			     "r"(r10), "r"(r8), "r"(r9));
> +	if (is_amd_cpu())
> +		__asm__ __volatile__("vmmcall" :
> +			"=a"(rax) :
> +			"a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
> +			"r"(r10), "r"(r8), "r"(r9));
> +	else
> +		__asm__ __volatile__("vmcall" :
> +			"=a"(rax) :
> +			"a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
> +			"r"(r10), "r"(r8), "r"(r9));

Can we create common helper functions or macros for doing hypercalls to
reduce the amount of duplicated inline assembly?

>  	GUEST_ASSERT(rax == RETVALUE);
>  
>  	/* Fill in the Xen hypercall page */
> -- 
> 2.37.2.789.g6183377224-goog
> 
