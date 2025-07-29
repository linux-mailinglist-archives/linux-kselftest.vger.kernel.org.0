Return-Path: <linux-kselftest+bounces-38068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB564B154A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 23:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0051B3BCAF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392E279917;
	Tue, 29 Jul 2025 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lhsW2pTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7B2561C5
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753824523; cv=none; b=FaTFYHGA1lM+tlyqkwzK5qHBUikIA7xCS2oq5ikrtdQGyDni9ENRJguW33Dz7f2q32NAIVBF1Ixlh7YSLYni3lutzJh7AQh/bFw8mEa4Rf1QlWLod4ImAKvkS0zYwHH5LjV26/tn6vY6V0oIH8cca19XPIor3B+39OecMAOxa8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753824523; c=relaxed/simple;
	bh=wWr0PMMX8zXIq+UZH9Hw6e+QTKOqH5uI2PfCLe/lLZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luKlDVVT6roSMRLCzOgYDzUY7lbsLTIts5EqpnZRvTpkAyoixkDanlxK0qBWI5dHRgVHH1xAoF05MYQnGNhGH92NimHLGfZaaek0ZUM9l9jRHcfv5OuYigc3jhyL7hrxiTFy9X6UZuX4pDxiT3iAWCD/5AfNEOY4H+/DBUKwpQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lhsW2pTc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Jul 2025 14:28:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753824508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NR9slzoUcFOnPOoSMrOV4yposz1NlG4bkgRYfak492c=;
	b=lhsW2pTcB10VQHQ789IqoXJswxckQki4VJ3/2loOEW2BzG6PgAfa2kj9NJPn524jv0WgfP
	MjYAlqeTx1ZzRP990X7EM/qgcaHk5t/9IMRbFKRswJP+taDNsnL+hGCJ99RzwPHiQQ/vVN
	YBCJ0Z4l9hzEspcc7A/hA8yTNEKhxYc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	duenwen@google.com, rananta@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 1/6] KVM: arm64: VM exit to userspace to handle SEA
Message-ID: <aIk88sBA2eIEF7w-@linux.dev>
References: <20250604050902.3944054-1-jiaqiyan@google.com>
 <20250604050902.3944054-2-jiaqiyan@google.com>
 <aHFohmTb9qR_JG1E@linux.dev>
 <CACw3F509B=AHhpaTcuH9O851rrDdHh1baC8uRYy7bDa7BSMhgg@mail.gmail.com>
 <aHK-DPufhLy5Dtuk@linux.dev>
 <CACw3F53TYZ1KFv0Yc-GCyOxn7TF3iYjTNSE8bd3nte=KaCN0UQ@mail.gmail.com>
 <CACw3F50Q_G75wf2rBm-P-NkyyO72i1NKqR9se99QrgipfD62yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F50Q_G75wf2rBm-P-NkyyO72i1NKqR9se99QrgipfD62yg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 25, 2025 at 03:54:10PM -0700, Jiaqi Yan wrote:
> On Sat, Jul 19, 2025 at 2:24 PM Jiaqi Yan <jiaqiyan@google.com> wrote:
> >
> > On Sat, Jul 12, 2025 at 12:57 PM Oliver Upton <oliver.upton@linux.dev> wrote:
> > >
> > > On Fri, Jul 11, 2025 at 04:59:11PM -0700, Jiaqi Yan wrote:
> > > > >  - Add some detail about FEAT_RAS where we may still exit to userspace
> > > > >    for host-controlled memory, as we cannot differentiate between a
> > > > >    stage-1 or stage-2 TTW SEA when taken on the descriptor PA
> > > >
> > > > Ah, IIUC, you are saying even if the FSC code tells fault is on TTW
> > > > (esr_fsc_is_secc_ttw or esr_fsc_is_sea_ttw), it can either be guest
> > > > stage-1's or stage-2's descriptor PA, and we can tell which from
> > > > which.
> > > >
> > > > However, if ESR_ELx_S1PTW is set, we can tell this is a sub-case of
> > > > stage-2 descriptor PA, their usage is for stage-1 PTW but they are
> > > > stage-2 memory.
> > > >
> > > > Is my current understanding right?
> > >
> > > Yep, that's exactly what I'm getting at. As you note, stage-2 aborts
> > > during a stage-1 walk are sufficiently described, but not much else.
> >
> > Got it, thanks!
> >
> > >
> > > > > +/*
> > > > > + * Returns true if the SEA should be handled locally within KVM if the abort is
> > > > > + * caused by a kernel memory allocation (e.g. stage-2 table memory).
> > > > > + */
> > > > > +static bool host_owns_sea(struct kvm_vcpu *vcpu, u64 esr)
> > > > > +{
> > > > > +       /*
> > > > > +        * Without FEAT_RAS HCR_EL2.TEA is RES0, meaning any external abort
> > > > > +        * taken from a guest EL to EL2 is due to a host-imposed access (e.g.
> > > > > +        * stage-2 PTW).
> > > > > +        */
> > > > > +       if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
> > > > > +               return true;
> > > > > +
> > > > > +       /* KVM owns the VNCR when the vCPU isn't in a nested context. */
> > > > > +       if (is_hyp_ctxt(vcpu) && (esr & ESR_ELx_VNCR))
> > > > > +               return true;
> > > > > +
> > > > > +       /*
> > > > > +        * Determining if an external abort during a table walk happened at
> > > > > +        * stage-2 is only possible with S1PTW is set. Otherwise, since KVM
> > > > > +        * sets HCR_EL2.TEA, SEAs due to a stage-1 walk (i.e. accessing the PA
> > > > > +        * of the stage-1 descriptor) can reach here and are reported with a
> > > > > +        * TTW ESR value.
> > > > > +        */
> > > > > +       return esr_fsc_is_sea_ttw(esr) && (esr & ESR_ELx_S1PTW);
> > > >
> > > > Should we include esr_fsc_is_secc_ttw? like
> > > >   (esr_fsc_is_sea_ttw(esr) || esr_fsc_is_secc_ttw(esr)) && (esr & ESR_ELx_S1PTW)
> > >
> > > Parity / ECC errors are not permitted if FEAT_RAS is implemented (which
> > > is tested for up front).
> >
> > Ah, thanks for pointing this out.
> >
> > >
> > > > > +}
> > > > > +
> > > > >  int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
> > > > >  {
> > > > > +       u64 esr = kvm_vcpu_get_esr(vcpu);
> > > > > +       struct kvm_run *run = vcpu->run;
> > > > > +       struct kvm *kvm = vcpu->kvm;
> > > > > +       u64 esr_mask = ESR_ELx_EC_MASK  |
> > > > > +                      ESR_ELx_FnV      |
> > > > > +                      ESR_ELx_EA       |
> > > > > +                      ESR_ELx_CM       |
> > > > > +                      ESR_ELx_WNR      |
> > > > > +                      ESR_ELx_FSC;
> > > >
> > > > Do you (and why) exclude ESR_ELx_IL on purpose?
> > >
> > > Unintended :)
> >
> > Will add into my patch.
> >
> > >
> > > > BTW, if my previous statement about TTW SEA is correct, then I also
> > > > understand why we need to explicitly exclude ESR_ELx_S1PTW.
> > >
> > > Right, we shouldn't be exposing genuine stage-2 external aborts to userspace.
> > >
> > > > > +       u64 ipa;
> > > > > +
> > > > > +
> > > > >         /*
> > > > >          * Give APEI the opportunity to claim the abort before handling it
> > > > >          * within KVM. apei_claim_sea() expects to be called with IRQs
> > > > > @@ -1824,7 +1864,32 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
> > > > >         if (apei_claim_sea(NULL) == 0)
> > > >
> > > > I assume kvm should still lockdep_assert_irqs_enabled(), right? That
> > > > is, a WARN_ON_ONCE is still useful in case?
> > >
> > > Ah, this is diffed against my VNCR prefix which has this context. Yes, I
> > > want to preserve the lockdep assertion.
> >
> > Thanks for sharing the patch! Should I wait for you to send and queue
> > to kvmarm/next and rebase my v3 to it? Or should I insert it into my
> > v3 patch series with you as the commit author, and Signed-off-by you?
> 
> Friendly ping for this question, my v3 is ready but want to confirm
> the best option here.
> 
> Recently we found even the newer ARM64 platforms used by our org has
> to rely on KVM to more gracefully handle SEA (lacking support from
> APEI), so we would really want to work with upstream to lock down the
> proposed approach/UAPI asap.

Posted the VNCR fix which I plan on taking in 6.17. Feel free to rebase
your work on top of kvmarm-6.17 or -rc1 when it comes out.

https://lore.kernel.org/kvmarm/20250729182342.3281742-1-oliver.upton@linux.dev/

Thanks,
Oliver

