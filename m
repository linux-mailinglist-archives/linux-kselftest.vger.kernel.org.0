Return-Path: <linux-kselftest+bounces-42645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1BBAE716
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 21:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663F419403F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC128642E;
	Tue, 30 Sep 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeSikPyr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB433EC
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260588; cv=none; b=O3aVu0MikDn99+Gz98udoFVk5nuDeUJJDIkP5QdxN4b8w13QlU3qAX0vfEcsDRMxYJ1BkZdSwoX7joY7hEMbC583rAA8BUh9Q+AaretdMrmR+fPl4x+yslrxu2FJI/an6MLzmJPEu2POqWdaZg87z++SZKXcgnQOzsEwn98FZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260588; c=relaxed/simple;
	bh=P+qZ2fZAEXfL436ybjprlYZc2AIijh26vuzV2ZNtQnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KqlyVT23H+sFXmDl1GWlWFKxQ2J2ScpGNLUGtOKWf2OV/Ag7xQ+9YqoFROqLDlDwCd9f3L7MLbgnO5kf54vyhpQlXHZ7q0vN2EBHuEw0A7Bk4sl24FrgEjRnouJqKqLd/p7/BiDqwOIXZ+a+6j1dHhnkz05kt3lOLJm2AHja3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeSikPyr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2697c4e7354so1981095ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759260586; x=1759865386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRnlDy13lHDP7WqEGAF8ErlJ5mSCGwAed5lppIb8Dzg=;
        b=GeSikPyrgxxfW0mpkkwdm4MvCmz3F9ZjMnMgNRhrAGH+xdqAy3DG6wkzWRVKQpOpBY
         fgTZIWpOJLrdcqzHrTesUAEJcQil3WLdQx44hw6mXLx8u3/u33eyOdJAJOuiaxw3YdhT
         kY6TULqq6EYrFf6X2PcfyAlf83XKPp+3iwSOXSVcq8QGj79RtCXR9bSF7xomc5YQk9vc
         RChZZqSira0XQa397RG4a62vbXnCADMi6kKsL+oQzpKxIvmi4Uv521MmguVvStvBuuAV
         5lfwrxGGGRAy8E5FQE40TyoF8PMvsrN+EQUSIlINY79FDd6pg6FTfuxwfiqQMln9pW7X
         ePJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759260586; x=1759865386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRnlDy13lHDP7WqEGAF8ErlJ5mSCGwAed5lppIb8Dzg=;
        b=pB/TRktv/6nrU1iSegqh/6ln6NqUEWmE8YM5mMTg4X988EuUJGCbmMocEnjpRv1Rwt
         lwFVk4i9TpM7TXEvL2BI8kW5beBDzDxu6UIBB8ncMVYCIIbcZ7FOs7XfYi61/5aTUOBX
         vZtToDBi9YrxyCfu6f0h6TQ1CtWxR145HvAlo8EHM1kKPkh3cc0vzT/tR81FfT/uyuyY
         ylIcBDsU0g5lyl159oPZkUV7A/Xeax3K40G95V3PDAYxWRV0hdvfdTeY/0xzlA52j02z
         cL3qKM0vlAVxYayYmZvQQUfNd6fs38N39sZmaHMTefx/NG/gQioMacG3TbDnIU/J6EJn
         c20g==
X-Forwarded-Encrypted: i=1; AJvYcCW1Om7091jT4pSPlPj4JQhM4/5Btodmny8dZQ9qkxWRKmHpjdPdlmCsjSO9vSOI8rk6Hj2og0s3dt3cP4/mKiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOeQa2icSR/V+ohteQwAy9HhIuYfZ4ttL9mCftMTY30Y0b9I3
	PbxV6vi9VbN02YE58uGOVtn9g1RP9toDgR4VjB9UYiWibOxK+qLmEMhLWH9jdvn6ngytMBW7YN1
	laCgd3g==
X-Google-Smtp-Source: AGHT+IF5F3WIQ14BvXYYKK8coAqeR7NqeKnM/sNLJDk+1DZxPsJu3iO33ShTmyn79EL/jVws/rkPw3b2Mhs=
X-Received: from pjvi5.prod.google.com ([2002:a17:90a:dc05:b0:329:ccdd:e725])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f647:b0:269:aba9:ffd7
 with SMTP id d9443c01a7336-28d1713873fmr61157175ad.25.1759260586135; Tue, 30
 Sep 2025 12:29:46 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:29:44 -0700
In-Reply-To: <aNwgyhZO0BXQVExn@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825155203.71989-1-sebott@redhat.com> <aKy-9eby1OS38uqM@google.com>
 <87zfbnyvk9.wl-maz@kernel.org> <aKzRgp58vU6h02n6@google.com>
 <aKzX152737nAo479@linux.dev> <aK4CJnNxB6omPufp@google.com>
 <aK4J5EA10ufKJZsU@linux.dev> <aK4cAPeGgy0kXY98@google.com>
 <aNvzy5-lj3TBLT3I@google.com> <aNwgyhZO0BXQVExn@linux.dev>
Message-ID: <aNwvqAEZG9ustuDo@google.com>
Subject: Re: [PATCH] KVM: selftests: fix irqfd_test on arm64
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Sebastian Ott <sebott@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 30, 2025, Oliver Upton wrote:
> On Tue, Sep 30, 2025 at 08:14:19AM -0700, Sean Christopherson wrote:
> > > What about providing an API to do exactly that, instantiate and initialize a
> > > barebones GIC?  E.g.
> > > 
> > > 	void kvm_arch_init_barebones_irqchip(struct kvm_vm *vm)
> > > 
> > > Hmm, then we'd also need
> > > 
> > > 	void kvm_arch_vm_free(struct kvm_vm *vm)
> > > 
> > > to gracefully free the GIC, as done by dirty_log_perf_test.c.  Blech.  Though
> > > maybe we'll end up with that hook sooner or later?
> > > 
> > > All in all, I have no strong preference at this point.
> > 
> > Oliver, any thoughts?  This is causing noise in people's CIs, i.e. we should land
> > a fix sooner than later, even if it's not the "final" form. 
> 
> The lack of a default VGICv3 wound up getting in my way with some
> changes to promote selftests to run in VHE EL2, cc'ed you on that series
> since I wound up walking back my gripes here :)
> 
>   https://lore.kernel.org/kvmarm/20250917212044.294760-1-oliver.upton@linux.dev

Hah!  I saw the series but didn't read the cover letter. :-)

> That's now in Paolo's tree as of this morning. With that said, I think
> irqfd_test needs a bit more attention (below).
> 
> Thanks,
> Oliver
> 
> >From 4d0a035fb7e6cead74af4edb24fbcfdec076d321 Mon Sep 17 00:00:00 2001
> From: Oliver Upton <oliver.upton@linux.dev>
> Date: Tue, 30 Sep 2025 10:53:14 -0700
> Subject: [PATCH] KVM: selftests: Fix irqfd_test for non-x86 architectures
> 
> The KVM_IRQFD ioctl fails if no irqchip is present in-kernel, which
> isn't too surprising as there's not much KVM can do for an IRQ if it
> cannot resolve a destination.
> 
> As written the irqfd_test assumes that a 'default' VM created in
> selftests has an in-kernel irqchip created implicitly. That may be the
> case on x86 but it isn't necessarily true on other architectures.
> 
> Add an arch predicate indicating if 'default' VMs get an irqchip and
> make the irqfd_test depend on it. Work around arm64 VGIC initialization
> requirements by using vm_create_with_one_vcpu(), ignoring the created
> vCPU as it isn't used for the test.
> 
> Fixes: 7e9b231c402a ("KVM: selftests: Add a KVM_IRQFD test to verify uniqueness requirements")

Reported-by: Sebastian Ott <sebott@redhat.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

Acked-by: Sean Christopherson <seanjc@google.com>

