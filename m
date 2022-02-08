Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A08A4ADB41
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 15:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbiBHOfb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 09:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378205AbiBHOfa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 09:35:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 611F8C03FEEC
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 06:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644330927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSRpjshv+kbhfh/GFUgZiARyP3KS+Ne997kfmQ3mHmo=;
        b=OTjPg+wasgVc3x7treLC9iNCyjYssgbSGodNPTFO5ZyKUIs5EbY8nL5guXgAl3rFd/wq1W
        tWHNsQZ/qy2Hvt4pvELRBzfB2OzJbg3GkUCrlhuBPnlM/P4Xt+MlymmORiK3ZNotVHIuUE
        pWjThNHXidF3yqZ0Fit+V5Zc2XQNKkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-p86_F2L_OamJatwilZ8pFg-1; Tue, 08 Feb 2022 09:35:24 -0500
X-MC-Unique: p86_F2L_OamJatwilZ8pFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9280814405;
        Tue,  8 Feb 2022 14:35:21 +0000 (UTC)
Received: from starship (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB0387C0C1;
        Tue,  8 Feb 2022 14:35:15 +0000 (UTC)
Message-ID: <b35376a91f31256035c361cfaa2456f67c7f797a.camel@redhat.com>
Subject: Re: [PATCH v3 3/6] KVM: SVM: implement
 force_intercept_exceptions_mask
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 08 Feb 2022 16:35:14 +0200
In-Reply-To: <YTELOvhj5lERBKeC@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
         <20210811122927.900604-4-mlevitsk@redhat.com>
         <73f3eff092ca9624ebd55bc02193b39f248c8877.camel@redhat.com>
         <YTELOvhj5lERBKeC@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2021-09-02 at 17:34 +0000, Sean Christopherson wrote:
> On Wed, Aug 11, 2021, Maxim Levitsky wrote:
> > On Wed, 2021-08-11 at 15:29 +0300, Maxim Levitsky wrote:
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index e45259177009..19f54b07161a 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -233,6 +233,8 @@ static const u32 msrpm_ranges[] = {0, 0xc0000000, 0xc0010000};
> > >  #define MSRS_RANGE_SIZE 2048
> > >  #define MSRS_IN_RANGE (MSRS_RANGE_SIZE * 8 / 2)
> > >  
> > > +static int svm_handle_invalid_exit(struct kvm_vcpu *vcpu, u64 exit_code);
> > > +
> > >  u32 svm_msrpm_offset(u32 msr)
> > >  {
> > >  	u32 offset;
> > > @@ -1153,6 +1155,22 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu,
> > >  	}
> > >  }
> > >  
> > > +static void svm_init_force_exceptions_intercepts(struct vcpu_svm *svm)
> > > +{
> > > +	int exc;
> > > +
> > > +	svm->force_intercept_exceptions_mask = force_intercept_exceptions_mask;
> 
> Ah, the param is being snapshotted on vCPU creation, hence the writable module
> param.  That works, though it'd be better to snapshot it on a per-VM basic, not
> per-vCPU, and do so in common x86 code so that the param doesn't need to be
> exported.

I have nothing against that.

> 
> > > +	for (exc = 0 ; exc < 32 ; exc++) {
> 
> for_each_set_bit()
I used a helper function instead, IMHO a bit cleaner.

> 
> > > +		if (!(svm->force_intercept_exceptions_mask & (1 << exc)))
> > > +			continue;
> > > +
> > > +		/* Those are defined to have undefined behavior in the SVM spec */
> > > +		if (exc != 2 && exc != 9)
> 
> Maybe add a pr_warn_once() to let the user know they done messed up?
> 
> And given that there are already intercepts with undefined behavior, it's probably
> best to disallow intercepting anything we aren't 100% postive will be handled
> correctly, e.g. intercepting vector 31 is nonsensical at this time.

Or I think I'll just drop this check altogether - this is a debug feature anyway.

> 
> > > +			continue;
> > > +		set_exception_intercept(svm, exc);
> 
> ...
> 
> > > +static int gen_exc_interception(struct kvm_vcpu *vcpu)
> > > +{
> > > +	/*
> > > +	 * Generic exception intercept handler which forwards a guest exception
> > > +	 * as-is to the guest.
> > > +	 * For exceptions that don't have a special intercept handler.
> > > +	 *
> > > +	 * Used only for 'force_intercept_exceptions_mask' KVM debug feature.
> > > +	 */
> > > +	struct vcpu_svm *svm = to_svm(vcpu);
> > > +	int exc = svm->vmcb->control.exit_code - SVM_EXIT_EXCP_BASE;
> > > +
> > > +	/* SVM doesn't provide us with an error code for the #DF */
> > > +	u32 err_code = exc == DF_VECTOR ? 0 : svm->vmcb->control.exit_info_1;
> 
> Might be better to handle this in the x86_exception_has_error_code() path to
> avoid confusing readers with respect to exceptions that don't have an error code,
> e.g.
> 
> 	else if (x86_exception_has_error_code(exc)) {
> 		/* SVM doesn't provide the error code on #DF :-( */
> 		if (exc == DF_VECTOR)
> 			kvm_queue_exception_e(vcpu, exc, 0);
> 		else
> 			kvm_queue_exception_e(vcpu, exc, svm->vmcb->control.exit_info_1);
> 	} else {
> 		...
> 	}
> 
> Alternatively, can we zero svm->vmcb->control.exit_info_1 on #DF to make it more
> obvious that SVM leaves stale data in exit_info_1 (assuming that's true)?  E.g.
> 
> 	...
> 
> 	if (exc == TS_VECTOR) {
> 		...
> 	} else if (x86_exception_has_error_code(exc)) {
> 		/* SVM doesn't provide the error code on #DF :-( */
> 		if (exc == DF_VECTOR)
> 			svm->vmcb->control.exit_info_1 = 0;
> 
> 		kvm_queue_exception_e(vcpu, exc, svm->vmcb->control.exit_info_1);
> 	} else {
> 		...
> 	}

Makes sense.

> 
> 		
> > > +
> > > +	if (!(svm->force_intercept_exceptions_mask & (1 << exc)))
> 
> BIT(exc)
I added a helper function in common x86 code for this.

> 
> > > +		return svm_handle_invalid_exit(vcpu, svm->vmcb->control.exit_code);
> > > +
> > > +	if (exc == TS_VECTOR) {
> > > +		/*
> > > +		 * SVM doesn't provide us with an error code to be able to
> > > +		 * re-inject the #TS exception, so just disable its
> > > +		 * intercept, and let the guest re-execute the instruction.
> > > +		 */
> > > +		vmcb_clr_intercept(&svm->vmcb01.ptr->control,
> > > +				   INTERCEPT_EXCEPTION_OFFSET + TS_VECTOR);
> 
> Maybe just disallow intercepting #TS altogether?  Or does this fall into your
> Win98 use case? :-)

Win98 does indeed generate few #TS exceptions but so far I haven't noticed
any issues related to task switches. Anyway I would like to intercept
as much as possible since this is a debug feature. A single interception
is still better that nothing.


> 
> > > +		recalc_intercepts(svm);
> > > +	} else if (x86_exception_has_error_code(exc))
> > > +		kvm_queue_exception_e(vcpu, exc, err_code);
> > > +	else
> > > +		kvm_queue_exception(vcpu, exc);
> > > +	return 1;
> > > +}
> > > +
> > >  static bool is_erratum_383(void)
> > >  {
> > >  	int err, i;
> > > @@ -3065,6 +3131,10 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
> > >  	[SVM_EXIT_WRITE_DR5]			= dr_interception,
> > >  	[SVM_EXIT_WRITE_DR6]			= dr_interception,
> > >  	[SVM_EXIT_WRITE_DR7]			= dr_interception,
> > > +
> > > +	[SVM_EXIT_EXCP_BASE ...
> > > +	SVM_EXIT_EXCP_BASE + 31]		= gen_exc_interception,
> 
> This generates a Sparse warning due to the duplicate initializer.  IMO that's a
> very good warning as I have zero idea how the compiler actually handles this
> particular scenario, e.g. do later entries take priority, is it technically
> "undefined" behavior, etc...
> 
> arch/x86/kvm/svm/svm.c:3065:10: warning: Initializer entry defined twice
> arch/x86/kvm/svm/svm.c:3067:29:   also defined here
> 
> I don't have a clever solution though :-('

Good catch. I thought that this would make sense but standards never make sense.
I'll do this manually.

> 
> > > +
> > >  	[SVM_EXIT_EXCP_BASE + DB_VECTOR]	= db_interception,
> > >  	[SVM_EXIT_EXCP_BASE + BP_VECTOR]	= bp_interception,
> > >  	[SVM_EXIT_EXCP_BASE + UD_VECTOR]	= ud_interception,
> > > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > > index 524d943f3efc..187ada7c5b03 100644
> > > --- a/arch/x86/kvm/svm/svm.h
> > > +++ b/arch/x86/kvm/svm/svm.h
> > > @@ -196,6 +196,7 @@ struct vcpu_svm {
> > >  	bool ghcb_sa_free;
> > >  
> > >  	bool guest_state_loaded;
> > > +	u32 force_intercept_exceptions_mask;
> > >  };
> > >  
> > >  struct svm_cpu_data {
> > > @@ -351,8 +352,11 @@ static inline void clr_exception_intercept(struct vcpu_svm *svm, u32 bit)
> > >  	struct vmcb *vmcb = svm->vmcb01.ptr;
> > >  
> > >  	WARN_ON_ONCE(bit >= 32);
> > > -	vmcb_clr_intercept(&vmcb->control, INTERCEPT_EXCEPTION_OFFSET + bit);
> > >  
> > > +	if ((1 << bit) & svm->force_intercept_exceptions_mask)
> 
> BIT(bit)
Fixed with helper function as well.

> 
> > > +		return;
> > > +
> > > +	vmcb_clr_intercept(&vmcb->control, INTERCEPT_EXCEPTION_OFFSET + bit);
> > >  	recalc_intercepts(svm);
> > >  }


Thanks for the review!
Best regards,
	Maxim Levitsky

