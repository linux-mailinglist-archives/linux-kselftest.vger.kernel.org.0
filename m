Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D023FF25C
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346668AbhIBRfz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 13:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbhIBRfy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 13:35:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BF2C061757
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Sep 2021 10:34:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso1990938pjq.4
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Sep 2021 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kuxbSrJC7raCjCUG7LcB8YHVpag242X34QlRVBQEJck=;
        b=Qz1JtxK/pZoFgGuAbj5ok/V6BdH4SNaUT0cKQyYvHFapEjheOiI0V1dmLqkEhLpRjc
         PgDWnKnhzn0LqSnm65THcoYdBpQ02rtkl9jynSOqt18yD+GXKqlfo7sZzQY6ul/QeocB
         9SWc/o9T0R70mbqBqOiC0m8ivO+EJlbbDddTJjJhP9iHQeCjhocVeDcg3ob6HPQIu3Yy
         34/e8WkJ6Vv1KZc2kuJCz1o0zIbWhcMMnK/6dFbNCtCmrBRsIInyQeKKtec1vieRwuL+
         C8Kjz16NnffK8oQQjWjxwDpT3epVz++uQVOUpkcRcKTXwRiRpX6wwJz21f5oIw+OE1Mj
         dOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kuxbSrJC7raCjCUG7LcB8YHVpag242X34QlRVBQEJck=;
        b=QR5XSNxpIS4oERN22hYq26prOF2n2a7RhnAaolUN2UXDUzFA4IQr/JmtjPhw9VTrZM
         IZwmZqdpKpvuHD0jBh7ev4lDrA/8epy4vJBlLm/ks7eKzUk5utC4MOKz4clIGU2tv9PI
         rO0U1khjNXyjYWVeyXc4OHxEa7mKFOvuqOY9rGy7GpUqbGGeUOj3jIAQd6/IAAZ8xGd+
         luhD75D28J9ZsAs47RBZg6dg+e8B6g9vZV70mxaZvKY1zSsOy9gOHFKXD9zBqpBRuGMV
         u/GOb26vn+BAsv0acbkWiaxr8++3tY3Tcnvqic/JLAOl6pugNwizTp+OjOyi/q/MhqBb
         00mg==
X-Gm-Message-State: AOAM5317sBgqkYs6fWXp2dOxE6SNQu0q4KYBLv4MJPcEv7qMNH/8DLwQ
        pBmmJEaNF0WEY1mVVyf9UQBfrA==
X-Google-Smtp-Source: ABdhPJzikB/whUMv0CGvwxBEkqeGMSm9SVinoKW03uCXHvCgtKkl9lYMXN2IL/CRuNFSIuqIGEGsfA==
X-Received: by 2002:a17:90a:af88:: with SMTP id w8mr5157122pjq.104.1630604095117;
        Thu, 02 Sep 2021 10:34:55 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g4sm3268835pgs.42.2021.09.02.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 10:34:54 -0700 (PDT)
Date:   Thu, 2 Sep 2021 17:34:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
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
Subject: Re: [PATCH v3 3/6] KVM: SVM: implement
 force_intercept_exceptions_mask
Message-ID: <YTELOvhj5lERBKeC@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-4-mlevitsk@redhat.com>
 <73f3eff092ca9624ebd55bc02193b39f248c8877.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f3eff092ca9624ebd55bc02193b39f248c8877.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 11, 2021, Maxim Levitsky wrote:
> On Wed, 2021-08-11 at 15:29 +0300, Maxim Levitsky wrote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index e45259177009..19f54b07161a 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -233,6 +233,8 @@ static const u32 msrpm_ranges[] = {0, 0xc0000000, 0xc0010000};
> >  #define MSRS_RANGE_SIZE 2048
> >  #define MSRS_IN_RANGE (MSRS_RANGE_SIZE * 8 / 2)
> >  
> > +static int svm_handle_invalid_exit(struct kvm_vcpu *vcpu, u64 exit_code);
> > +
> >  u32 svm_msrpm_offset(u32 msr)
> >  {
> >  	u32 offset;
> > @@ -1153,6 +1155,22 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu,
> >  	}
> >  }
> >  
> > +static void svm_init_force_exceptions_intercepts(struct vcpu_svm *svm)
> > +{
> > +	int exc;
> > +
> > +	svm->force_intercept_exceptions_mask = force_intercept_exceptions_mask;

Ah, the param is being snapshotted on vCPU creation, hence the writable module
param.  That works, though it'd be better to snapshot it on a per-VM basic, not
per-vCPU, and do so in common x86 code so that the param doesn't need to be
exported.

> > +	for (exc = 0 ; exc < 32 ; exc++) {

for_each_set_bit()

> > +		if (!(svm->force_intercept_exceptions_mask & (1 << exc)))
> > +			continue;
> > +
> > +		/* Those are defined to have undefined behavior in the SVM spec */
> > +		if (exc != 2 && exc != 9)

Maybe add a pr_warn_once() to let the user know they done messed up?

And given that there are already intercepts with undefined behavior, it's probably
best to disallow intercepting anything we aren't 100% postive will be handled
correctly, e.g. intercepting vector 31 is nonsensical at this time.

> > +			continue;
> > +		set_exception_intercept(svm, exc);

...

> > +static int gen_exc_interception(struct kvm_vcpu *vcpu)
> > +{
> > +	/*
> > +	 * Generic exception intercept handler which forwards a guest exception
> > +	 * as-is to the guest.
> > +	 * For exceptions that don't have a special intercept handler.
> > +	 *
> > +	 * Used only for 'force_intercept_exceptions_mask' KVM debug feature.
> > +	 */
> > +	struct vcpu_svm *svm = to_svm(vcpu);
> > +	int exc = svm->vmcb->control.exit_code - SVM_EXIT_EXCP_BASE;
> > +
> > +	/* SVM doesn't provide us with an error code for the #DF */
> > +	u32 err_code = exc == DF_VECTOR ? 0 : svm->vmcb->control.exit_info_1;

Might be better to handle this in the x86_exception_has_error_code() path to
avoid confusing readers with respect to exceptions that don't have an error code,
e.g.

	else if (x86_exception_has_error_code(exc)) {
		/* SVM doesn't provide the error code on #DF :-( */
		if (exc == DF_VECTOR)
			kvm_queue_exception_e(vcpu, exc, 0);
		else
			kvm_queue_exception_e(vcpu, exc, svm->vmcb->control.exit_info_1);
	} else {
		...
	}

Alternatively, can we zero svm->vmcb->control.exit_info_1 on #DF to make it more
obvious that SVM leaves stale data in exit_info_1 (assuming that's true)?  E.g.

	...

	if (exc == TS_VECTOR) {
		...
	} else if (x86_exception_has_error_code(exc)) {
		/* SVM doesn't provide the error code on #DF :-( */
		if (exc == DF_VECTOR)
			svm->vmcb->control.exit_info_1 = 0;

		kvm_queue_exception_e(vcpu, exc, svm->vmcb->control.exit_info_1);
	} else {
		...
	}

		
> > +
> > +	if (!(svm->force_intercept_exceptions_mask & (1 << exc)))

BIT(exc)

> > +		return svm_handle_invalid_exit(vcpu, svm->vmcb->control.exit_code);
> > +
> > +	if (exc == TS_VECTOR) {
> > +		/*
> > +		 * SVM doesn't provide us with an error code to be able to
> > +		 * re-inject the #TS exception, so just disable its
> > +		 * intercept, and let the guest re-execute the instruction.
> > +		 */
> > +		vmcb_clr_intercept(&svm->vmcb01.ptr->control,
> > +				   INTERCEPT_EXCEPTION_OFFSET + TS_VECTOR);

Maybe just disallow intercepting #TS altogether?  Or does this fall into your
Win98 use case? :-)

> > +		recalc_intercepts(svm);
> > +	} else if (x86_exception_has_error_code(exc))
> > +		kvm_queue_exception_e(vcpu, exc, err_code);
> > +	else
> > +		kvm_queue_exception(vcpu, exc);
> > +	return 1;
> > +}
> > +
> >  static bool is_erratum_383(void)
> >  {
> >  	int err, i;
> > @@ -3065,6 +3131,10 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
> >  	[SVM_EXIT_WRITE_DR5]			= dr_interception,
> >  	[SVM_EXIT_WRITE_DR6]			= dr_interception,
> >  	[SVM_EXIT_WRITE_DR7]			= dr_interception,
> > +
> > +	[SVM_EXIT_EXCP_BASE ...
> > +	SVM_EXIT_EXCP_BASE + 31]		= gen_exc_interception,

This generates a Sparse warning due to the duplicate initializer.  IMO that's a
very good warning as I have zero idea how the compiler actually handles this
particular scenario, e.g. do later entries take priority, is it technically
"undefined" behavior, etc...

arch/x86/kvm/svm/svm.c:3065:10: warning: Initializer entry defined twice
arch/x86/kvm/svm/svm.c:3067:29:   also defined here

I don't have a clever solution though :-(

> > +
> >  	[SVM_EXIT_EXCP_BASE + DB_VECTOR]	= db_interception,
> >  	[SVM_EXIT_EXCP_BASE + BP_VECTOR]	= bp_interception,
> >  	[SVM_EXIT_EXCP_BASE + UD_VECTOR]	= ud_interception,
> > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > index 524d943f3efc..187ada7c5b03 100644
> > --- a/arch/x86/kvm/svm/svm.h
> > +++ b/arch/x86/kvm/svm/svm.h
> > @@ -196,6 +196,7 @@ struct vcpu_svm {
> >  	bool ghcb_sa_free;
> >  
> >  	bool guest_state_loaded;
> > +	u32 force_intercept_exceptions_mask;
> >  };
> >  
> >  struct svm_cpu_data {
> > @@ -351,8 +352,11 @@ static inline void clr_exception_intercept(struct vcpu_svm *svm, u32 bit)
> >  	struct vmcb *vmcb = svm->vmcb01.ptr;
> >  
> >  	WARN_ON_ONCE(bit >= 32);
> > -	vmcb_clr_intercept(&vmcb->control, INTERCEPT_EXCEPTION_OFFSET + bit);
> >  
> > +	if ((1 << bit) & svm->force_intercept_exceptions_mask)

BIT(bit)

> > +		return;
> > +
> > +	vmcb_clr_intercept(&vmcb->control, INTERCEPT_EXCEPTION_OFFSET + bit);
> >  	recalc_intercepts(svm);
> >  }
