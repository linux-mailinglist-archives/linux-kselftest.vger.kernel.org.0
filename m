Return-Path: <linux-kselftest+bounces-19895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53A9A1601
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 01:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702182853B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78041D4618;
	Wed, 16 Oct 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFNmuXDn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEA1534E6
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729120327; cv=none; b=o6JyZOEJmf9NuZnpdL/fOSG/WIGj4b0k83iXGnbGhtYFCYQNl62pET5GXmHE6YhxqGaLFE1lOw2Trd/TLs/4KKAzGSz6fpkHVqhR2Ik6fWxSZh3I2L8ympWDnePr2is3sZqbw1Fv4+DZjoLgb4D0sbvbbFh2wT5MIDumkJuSVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729120327; c=relaxed/simple;
	bh=4jimESXMglt3C4dgLPgoc2d9/PyAujIOsVwhjSeRzmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aTJhN2+qMWOY88RD6S4kA+B3iN4sUPatp+hSL0io4LTUMAMoC8LvVYAU6kYywR62QBNLwCFCY9B8vHct3Qk0bMUY3R6h/BS1jtMN3drNyaCOEAk2SBFCQJsRc6eh684U8l8/W6Wy2+XOc2pzVUF2lyX/1iI6xg//d33PV5AoFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFNmuXDn; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea6efcd658so246383a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729120326; x=1729725126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=asq4qoImjXKLpbhxAG4pEPBNHXufTwu7kIdzRGlX14Q=;
        b=AFNmuXDn+7H62sBcavR2XWIg5iDjsV+eDe5HTk2Jjif2mKcR8rEjpJ9qcB0wUX9KBE
         eGEZ2KpnS1C6vwpudfgXcGLA6OgXIfDYhur5tKWnHm+cIG5JrN0gRlrwBQ+al5FyIu3X
         Oq+0usyJ5nREOL2d5eR3GgdS32n7Qj9QDlfazu/O2qlWSv52PaXiHa94vhc7SBFdfq5S
         y/v3ALfTUvHncdwUBLWgJxrfJUfhCq/wTftK7jOh+8DUcLvCLdVsvlaIbLgm46WRJHP0
         3XIqymJndqbN4FU6mAWW6kDXRHcE2wPfxlGNY2ajrkA+g7veIe2FwFcFVayYMLf8ZhBB
         SC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729120326; x=1729725126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asq4qoImjXKLpbhxAG4pEPBNHXufTwu7kIdzRGlX14Q=;
        b=CA35ZcBsZ28XcnIY1gED2AglloXjgxqaOj6BcPU6sdrvDSGBORVrTYtKwDr65ir/gm
         HBHmmZrqGyJ2gcdZ8lieyqRwg0Jk+SkHfUvTrgaD3j/SZ3/K1sLvd72kM/ePOMeG95ds
         ZPBolRZdj2IP7fjzGeQ94aHyKOx+U9RDTpZNmHvjbb14hvKnPsvWIVLQcPKVhvJKbiak
         jusOIb/EZVy7EJNAC8xtoiyisK3wq4oldBAhq0L8aFE10uWXOTHAJDwwmBvcX5FoGSgs
         FUho7fK20uKrmbPfcrpHpTKnotv/Pi+/2XAAEOi9MW1kHdLb70EScaH8B7mMMTJKv+LZ
         SOQw==
X-Forwarded-Encrypted: i=1; AJvYcCWaiQPNVBOnRttuNR40uB0EUv1NUmCuAiwBD+S7wz141jFLhSnNeliRCZnpFskE7RhrX720B37eUwRTXiWAjSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dYxicu+XTCOhFJ8/GctjbEzSdvt+uN4AoFEpZ9ZFUE4eQODX
	FsFgFfxx1Pw4ON/Q/wL3teACYWTaGITuXAfuzZmeZuCi9aEGikxZsZzZ+Ux3GYUr6PeHGVVcy3A
	Bgg==
X-Google-Smtp-Source: AGHT+IF4f9vHPzJElZHwQ3Q0ugMTcoTL7+B+jz869SaB0yhY2ERDFIAr8gAYsGeJM7vKDA1wlffqf1eUsrg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:24c5:0:b0:7ea:6d63:1071 with SMTP id
 41be03b00d2f7-7eaa6caa805mr4776a12.7.1729120325365; Wed, 16 Oct 2024 16:12:05
 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:12:04 -0700
In-Reply-To: <cea2040f-7214-41cb-9e9c-98895bf5a1ec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240927161657.68110-1-iorlov@amazon.com> <20240927161657.68110-2-iorlov@amazon.com>
 <Zwmyzg5WiKKvySS1@google.com> <20241015195227.GA18617@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
 <ZxAqscbrROD1_szG@google.com> <cea2040f-7214-41cb-9e9c-98895bf5a1ec@gmail.com>
Message-ID: <ZxBIRBB0Ibx9J5TN@google.com>
Subject: Re: [PATCH 1/3] KVM: x86, vmx: Add function for event delivery error generation
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Ivan Orlov <iorlov@amazon.com>, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, jalliste@amazon.com, 
	nh-open-source@amazon.com, pdurrant@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 16, 2024, Ivan Orlov wrote:
> On 10/16/24 22:05, Sean Christopherson wrote:
> > On Tue, Oct 15, 2024, Ivan Orlov wrote:
> > > > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > > > index c67e448c6ebd..afd785e7f3a3 100644
> > > > > --- a/arch/x86/kvm/vmx/vmx.c
> > > > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > > > @@ -6550,19 +6550,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
> > > > >   	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
> > > > >   	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
> > > > >   	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
> > > > > -		int ndata = 3;
> > > > > +		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> > > > > +		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
> > > > 
> > > > There's no need for is_mmio, just pass INVALID_GPA when the GPA isn't known.
> > > 
> > > Ah alright, then we definitely don't need an is_mmio field. I assume we
> > > can't do MMIO at GPA=0, right?
> > 
> > Wrong :-)
> > 
> 
> Then getting rid of `is_mmio` will make distinguishing between vectoring
> error due to MMIO with GPA=0 and non-mmio vectoring error quite hard for the
> error reporti
> 
> Passing INVALID_GPA into the userspace due to non-mmio vectoring error will
> change the existing internal.data order, but I can do it if it's fine. Sorry
> for nitpicking :)

KVM's existing ABI is rather awful, though arguably the intent was that there is
no ABI, i.e. that KVM is dumping info to try to be helpful.  E.g. the existing
behavior is that data[3] contains a GPA only for EPT_MISCONFIG, but for everything
else, data[3] contains last_vmentry_cpu.

And because it's so awful, I doubt any userspace actually has code that acts on
the layout of data[].  So, I suspect we can do the simple and sane thing, and
fill data[3] with -1ull if the GPA is invalid, and then document that that's the
behavior (if we're feeling generous). 

