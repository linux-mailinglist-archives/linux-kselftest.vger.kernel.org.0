Return-Path: <linux-kselftest+bounces-19780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB9699F781
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 21:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16267284679
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDA21B85DB;
	Tue, 15 Oct 2024 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iJsQDIgB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7CA824A0;
	Tue, 15 Oct 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021963; cv=none; b=XvrQHrV+V3RgctFhYG78R6PAGgTqj1MLCW+6dNTiDQH+31SEWXF+0vIWk4yBEbVKk8AOO5WFBkIjzSqcyikwOZap/WwjMoBT9CS7xk0l92zEfV8eTSo2I9Zg/XYWeVXQo9z+3hH/gp7k4Myp9ZB3UbmDuxUAX1yHndJFty9z/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021963; c=relaxed/simple;
	bh=983aXsk+k0099873GgO6EK7TO2lUtkaxWzxJ+aOzIUE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC6YidsKgeHC7+bYy0r+LSP80SgfNzmGIXC36CTxob+XiEYXZhdY4RDEGteVpHBRZGgnJvljLB0SWE4+kohgFY/JseTLnfWLUW3Yv6dhpFpQwhirgInOC8HKit/NXHHN1QkUFRm0QZZshkgS3vAkac4R8WBpQb2a0UwZ8JhwuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iJsQDIgB; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729021959; x=1760557959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lvzBMQNDz/N7fgI9TS5YkDPvuViLouR7Wge+YfhL9Ko=;
  b=iJsQDIgB6kLtHt/jMHV5RP7T8svNq14FOrhdYuvfIAv9eyT+FuKJI580
   3V4gdzDMbJd+im4pQuYk2tFfwPgldZJpvp54gpwhw6Yb5Oo7qBhbiqsD6
   PmdeiRdcBcjHkYsNyA0esed9mYYaVRaYGLahtMCj3Wtqg/Px/WBDtDh7u
   4=;
X-IronPort-AV: E=Sophos;i="6.11,206,1725321600"; 
   d="scan'208";a="461040843"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 19:52:32 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:10123]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.200:2525] with esmtp (Farcaster)
 id 63d632d6-a45b-4d78-b54a-26912426c2cc; Tue, 15 Oct 2024 19:52:29 +0000 (UTC)
X-Farcaster-Flow-ID: 63d632d6-a45b-4d78-b54a-26912426c2cc
Received: from EX19D033EUC002.ant.amazon.com (10.252.61.215) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 19:52:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D033EUC002.ant.amazon.com (10.252.61.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 19:52:29 +0000
Received: from email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 15 Oct 2024 19:52:28 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com (Postfix) with ESMTP id 32F5B40489;
	Tue, 15 Oct 2024 19:52:28 +0000 (UTC)
Received: by dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (Postfix, from userid 29210185)
	id DF2CEAB4E; Tue, 15 Oct 2024 19:52:27 +0000 (UTC)
Date: Tue, 15 Oct 2024 19:52:27 +0000
From: Ivan Orlov <iorlov@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <tglx@linutronix.de>,
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <x86@kernel.org>, <jalliste@amazon.com>,
	<nh-open-source@amazon.com>, <pdurrant@amazon.co.uk>
Subject: Re: [PATCH 1/3] KVM: x86, vmx: Add function for event delivery error
 generation
Message-ID: <20241015195227.GA18617@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
References: <20240927161657.68110-1-iorlov@amazon.com>
 <20240927161657.68110-2-iorlov@amazon.com>
 <Zwmyzg5WiKKvySS1@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zwmyzg5WiKKvySS1@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Sean,

On Fri, Oct 11, 2024 at 04:20:46PM -0700, Sean Christopherson wrote:
> "KVM: VMX:" for the scope.  See "Shortlog" in Documentation/process/maintainer-kvm-x86.rst
>

Ah, will update in the next version, thanks!

> On Fri, Sep 27, 2024, Ivan Orlov wrote:
> > Extract KVM_INTERNAL_ERROR_DELIVERY_EV internal error generation into
> > the SVM/VMX-agnostic 'kvm_prepare_ev_delivery_failure_exit' function, as
> > it is done for KVM_INTERNAL_ERROR_EMULATION.
> 
> Use the changelog to provide a human readable summary of the change.  There are
> definitely situations where calling out functions, variables, defines, etc. by
> name is necessary, but this isn't one such situation.
>
> > The order of internal.data array entries is preserved as is, so it is going
> > to be the same on VMX platforms (vectoring info, full exit reason, exit
> > qualification, GPA if error happened due to MMIO and last_vmentry_cpu of the
> > vcpu).
> 
> Similar to the above, let the code speak.  The "No functional change intended"
> makes it clear that the intent is to preserve the order and behavior.
> 
> > Having it as a separate function will help us to avoid code duplication
> 
> Avoid pronouns as much as possible, and no "we" or "us" as a hard rule.  E.g. this
> can all be distilled down to:
>

Yeah, makes sense. Will reformulate the message in the next version to consider
all of the changes you suggested.

> --
> Extract VMX's code for reporting an unhandleable VM-Exit during event
> delivery to userspace, so that the boilerplate code can be shared by SVM.
> 
> No functional change intended.
> --
> 

Awesome, thanks for the example!

> 
> Please wrap at 80 columns.  While checkpatch doesn't complaing until 100, my
> preference is to default to wrapping at 80, and poking past 80 only when it yields
> more readable code (which is obviously subjective, but it shouldn't be too hard
> to figure out KVM x86's preferred style).
>

Alright, will do, thanks! These rules vary from one subsystem to another, and
I'll try to keep the style consistent in the future.

> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index c67e448c6ebd..afd785e7f3a3 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6550,19 +6550,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
> >  	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
> >  	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
> >  	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
> > -		int ndata = 3;
> > +		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> > +		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
> 
> There's no need for is_mmio, just pass INVALID_GPA when the GPA isn't known.
> 

Ah alright, then we definitely don't need an is_mmio field. I assume we
can't do MMIO at GPA=0, right?

> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 83fe0a78146f..8ee67fc23e5d 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -8828,6 +8828,28 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu)
> >  }
> >  EXPORT_SYMBOL_GPL(kvm_prepare_emulation_failure_exit);
> >  
> > +void kvm_prepare_ev_delivery_failure_exit(struct kvm_vcpu *vcpu, gpa_t gpa, bool is_mmio)
> 
> Hmm, I don't love the name.  I really don't like that event is abbreviated, and
> I suspect many readers will be misinterpret "event delivery failure" to mean that
> _KVM_ failed to deliver an event.  Which is kinda sorta true, but it's more
> accurate to say that the CPU triggered a VM-Exit when vectoring/delivery an event,
> and KVM doesn't have code to robustly handle the situation.
> 
> Maybe kvm_prepare_event_vectoring_exit()?  Vectoring is quite specific in Intel
> terminology.
> 

Yep, sounds good, I like that the name you suggested doesn't contain 'failure'
part as essentially it is not a failure but an MMIO exit. Will update in V2.

> > +{
> > +	struct kvm_run *run = vcpu->run;
> > +	int ndata = 0;
> > +	u32 reason, intr_info, error_code;
> > +	u64 info1, info2;
> 
> Reverse fir/x-mas tree for variables.  See "Coding Style" in
> Documentation/process/maintainer-kvm-x86.rst (which will redirect you to
> Documentation/process/maintainer-tip.rst, specifically "Variable declarations").
> 

Great, didn't know about that, thanks!

> > +
> > +	kvm_x86_call(get_exit_info)(vcpu, &reason, &info1, &info2, &intr_info, &error_code);
> 
> Wrap.  Though calling back into vendor code is silly.  Pass the necessary info
> as parameters.  E.g. error_code and intr_info are unused, so the above is wasteful
> and weird.
> 

I use it here as this function gets called from the common for svm/vmx
code in the next patch, but as I can see from the next email you've already
noticed that :)

> > +
> > +	run->internal.data[ndata++] = info2;
> > +	run->internal.data[ndata++] = reason;
> > +	run->internal.data[ndata++] = info1;
> > +	if (is_mmio)
> 
> And this is where keying off MMIO gets weird.
> 

We still need to exclude one of the data elements when GPA is not known to be
backwards compatible, so we can get rid of the `is_mmio` argument, but
not from this `if` (unfortunately).

Thank you so much for the review!

Kind regards,
Ivan Orlov

