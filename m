Return-Path: <linux-kselftest+bounces-21950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF329C7828
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A55D28180C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B91158A31;
	Wed, 13 Nov 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hy6CW1m7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E2156C5F
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513863; cv=none; b=rwI/rMJz7nWBWHniCoq1yf0aBaQAN0kuPRJMv6Kpe2D6orQ2PAAGE0DhWT0pvYMgVBdvKdRzycfXe9iSk4N4CPH6tfh4hlwn9td1sQYPLYx1/Ns5v0zUB1cQFgXZlWzWOcfEr3X2oqo7JAhhh6Vv9GN7AlzD3zYF1Jj1xoa71N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513863; c=relaxed/simple;
	bh=j+4l/wSQVmSpBciFADL4nWG86AbM4y+yt7ey2EHURFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bPUjTMXA56dk6eOkL8rmZ0eGWmpP92PYTtKWgUpKZ+ITkrTQNtB2C8WTvrYSdIRx0S0US5GUkt9XEWdGzYcHS8pm955uRodMwJ4XwdzKpv+QkEWULoWjRiIHnEb5OdQz37OkYzBeD2slGgNXDM9/yDAa2hcR+zT2g3J2nZBf7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hy6CW1m7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e380bf11daeso160662276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 08:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731513861; x=1732118661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=urWC9EqU/pYYrOCfPVIx7GG8orSXBZXreTHU0chNMKY=;
        b=hy6CW1m7cpfs/U36fCQzvLlKG4+sc8QibT3eQYJKnGDM/akS1WgEfI3Ul0v8oDarNt
         Mff971EFsYU4i/fVdSU9yTwVOPTQDX74wj8Zn9h8D5PMVQiNYT8C5RT5K5vLSCoT7qs2
         j7upp7Hkl9eVOcewX4Z0eXvbiY7csae0qVTCjO5YI9XJ7Jl09lyMshaQAfpN24B988oa
         Vcu0Wc1AhOgqlRHpss2BhL0gAETbXEPEC9awfb3fQZRUTdVuBywaPeQjIr+6eEe52riy
         IazwACA+nH4bw48+YJJ0D1NKAykPI+oPiCE908nmyF1B7z5ExnKKdix6bwAorBM4m3hK
         KJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513861; x=1732118661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urWC9EqU/pYYrOCfPVIx7GG8orSXBZXreTHU0chNMKY=;
        b=UQyaTbee/TS2o1Vm5RkfRAwP5yI2nDNL/ofT5ZM9Tt0HxztOmt4oi2moD5KxMPU9WQ
         0SenNdlZoEJTYQcEDVI2KoI+Jg+tK8e1lYVL/v5bYHVgWGDiUj9HQm/ux4vyObpFU6QN
         DZ5p2L4HzU/D1xW27bzkr0wyZGkTonLhHABJWEZV6VTQuFud3vDsUnSv+jeFisu1CDVE
         a4FAtg23YR8C6DreZmOObZ4apj1bSFjLQb2342FEmbZBGbm4M58C5z1g+KwKcHIFXuSF
         swPh3nA0MgHlJbjSaI8juFCB9DWY+w/erPJchip+1LQ5mXULGkrjx8rmtAb8MR330dmp
         4Xrw==
X-Forwarded-Encrypted: i=1; AJvYcCVtbQwR6u0IJILouMfks30/5hLDuSPXZ781rTd4fnExm4YmaYYpud0C1BfUgkVE5CYD9JpEntRXFc+mnX3tkLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhShAdAGXFF7Yf/mX1jl2J0BKDZdYPQp9rAvnhgoG0iKArgC7X
	dAAgNvUOQRmc/6RPwk8ziRQ+dp7SdMzBgmNlzCw9EQ0HgN5LXPCoJAOq9/l8tX1PBC1n9+wAG7I
	QnQ==
X-Google-Smtp-Source: AGHT+IGzsdMn9C2xm1NmHAMcXNshY/uEnHFAAvhfE/3YFglv4xHLxzOI2+wtc1WBfcA5ldcyGwFVBcfmrhY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:e0d3:0:b0:e28:ec75:75ed with SMTP id
 3f1490d57ef6-e337f7798b7mr41395276.0.1731513860606; Wed, 13 Nov 2024 08:04:20
 -0800 (PST)
Date: Wed, 13 Nov 2024 16:04:19 +0000
In-Reply-To: <CABgObfZrTyft-3vqMz5w0ZiAhp-v6c32brgftynZGJO8OafrdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABQX2QMR=Nsn23zojFdhemR7tvGUz6_UM8Rgf6WLsxwDqoFtxg@mail.gmail.com>
 <Zy0__5YB9F5d0eZn@google.com> <CABQX2QNxFDhH1frsGpSQjSs3AWSdTibkxPrjq1QC7FGZC8Go-Q@mail.gmail.com>
 <e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com> <CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com>
 <c3026876-8061-4ab2-9321-97cc05bad510@redhat.com> <CADH9ctBivnvP1tNcatLKzd8EDz8Oo6X65660j8ccxYzk3aFzCA@mail.gmail.com>
 <CABgObfZEyCQMiq6CKBOE7pAVzUDkWjqT2cgfbwjW-RseH8VkLw@mail.gmail.com>
 <CADH9ctA_C1dAOus1K+wOH_SOKTb=-X1sVawt5R=dkH1iGt8QUg@mail.gmail.com> <CABgObfZrTyft-3vqMz5w0ZiAhp-v6c32brgftynZGJO8OafrdA@mail.gmail.com>
Message-ID: <ZzTNk4G0sOd8_hn-@google.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Doug Covelli <doug.covelli@broadcom.com>, Zack Rusin <zack.rusin@broadcom.com>, 
	kvm <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 13, 2024, Paolo Bonzini wrote:
> Il mar 12 nov 2024, 21:44 Doug Covelli <doug.covelli@broadcom.com> ha
> scritto:
> 
> > > Split irqchip should be the best tradeoff. Without it, moves from cr8
> > > stay in the kernel, but moves to cr8 always go to userspace with a
> > > KVM_EXIT_SET_TPR exit. You also won't be able to use Intel
> > > flexpriority (in-processor accelerated TPR) because KVM does not know
> > > which bits are set in IRR. So it will be *really* every move to cr8
> > > that goes to userspace.
> >
> > Sorry to hijack this thread but is there a technical reason not to allow
> > CR8 based accesses to the TPR (not MMIO accesses) when the in-kernel local
> > APIC is not in use?
> 
> No worries, you're not hijacking :) The only reason is that it would be
> more code for a seldom used feature and anyway with worse performance. (To
> be clear, CR8 based accesses are allowed, but stores cause an exit in order
> to check the new TPR against IRR. That's because KVM's API does not have an
> equivalent of the TPR threshold as you point out below).
> 
> > Also I could not find these documented anywhere but with MSFT's APIC our
> > monitor relies on extensions for trapping certain events such as INIT/SIPI
> > plus LINT0 and SVR writes:
> >
> > UINT64 X64ApicInitSipiExitTrap    : 1; //
> > WHvRunVpExitReasonX64ApicInitSipiTrap
> > UINT64 X64ApicWriteLint0ExitTrap  : 1; //
> > WHvRunVpExitReasonX64ApicWriteTrap
> > UINT64 X64ApicWriteLint1ExitTrap  : 1; //
> > WHvRunVpExitReasonX64ApicWriteTrap
> > UINT64 X64ApicWriteSvrExitTrap    : 1; //
> > WHvRunVpExitReasonX64ApicWriteTrap
> >
> 
> There's no need for this in KVM's in-kernel APIC model. INIT and SIPI are
> handled in the hypervisor and you can get the current state of APs via
> KVM_GET_MPSTATE. LINT0 and LINT1 are injected with KVM_INTERRUPT and
> KVM_NMI respectively, and they obey IF/PPR and NMI blocking respectively,
> plus the interrupt shadow; so there's no need for userspace to know when
> LINT0/LINT1 themselves change. The spurious interrupt vector register is
> also handled completely in kernel.
> 
> > I did not see any similar functionality for KVM.  Does anything like that
> > exist?  In any case we would be happy to add support for handling CR8
> > accesses w/o exiting w/o the in-kernel APIC along with some sort of a way
> > to configure the TPR threshold if folks are not opposed to that.
> 
> As far I know everybody who's using KVM (whether proprietary or open
> source) has had no need for that, so I don't think it's a good idea to make
> the API more complex. 

+1

> Performance of Windows guests is going to be bad anyway with userspace APIC.

Heh, on modern hardware, performance of any guest is going to suck with a userspace
APIC, compared to what is possible with an in-kernel APIC.

More importantly, I really, really don't want to encourage non-trivial usage of
a local APIC in userspace.  KVM's support for a userspace local APIC is very
poorly tested these days.   I have zero desire to spend any amount of time reviewing
and fixing issues that are unique to emulating the local APIC in userspace.  And
long term, I would love to force an in-kernel local APIC, though I don't know if
that's entirely feasible.

