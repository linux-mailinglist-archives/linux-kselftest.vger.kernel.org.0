Return-Path: <linux-kselftest+bounces-44536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89077C25FEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CE556425F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989A2F362D;
	Fri, 31 Oct 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXxUaBUt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F192C3774
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926482; cv=none; b=ufgQH95vqqy6OaCYgz0QPNmYdHG5YMEwVT4K9W0ZQzi9KEF7b4yDQrXgl4mxLRZzVYNr7psboZC+7/uk74CXRqfAtjcj8d2K2i0hT+JtY1CS3DbXft87rda92E0z9mgAuxEZ5U7jEmMyRQhkQDx7961M/mhnSrhFiGjUNgQFQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926482; c=relaxed/simple;
	bh=wuKNCAR9naLzRJVbZqK3vQEn3ShjHJSZ+aUJj/wLF/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PaVr3cC6FZeynRw1De1bbZ1JbUnSsh/wo7AQWeTrzgK9TMJbeWWI0NWa19B5vgsJAtiyi4KnZ9AEOqV62wTK3GeqDQkBMwkLX6WasZ5A+cB96wm6QWgDuF6ivZhB1s3tXbDKs/B71OFGSplNfvlNtoivD/c+r8gDIqh7LmpS0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXxUaBUt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33baef12edaso2906008a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761926480; x=1762531280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7n91hXfbqKaOek1a4KMSPayojDdoFizoG6Fs60W75tE=;
        b=oXxUaBUtFgpumjp4cM009snif40Njw9KDdRruFtXYQdPf3KdXkLEVmZNitMBenRbs4
         1mn/jH751V6UYun6lc7ApaaThhiT515kEt7QYFXjrxA81wpZiVH/tH3P1yCn/ewAj1WO
         Xceg7g0pqHTU1oKRtrIHPp3XlYcJI5tDxfmzJdmnteSIQ0wm4jaSxpNILdyBOx9yV4sD
         WbPtEMbaSTKEsL7Hn5FGnh+e/hzbthC8a4fhU4vzoGasC7azgXfh6p1Dg85LPs1yD3Op
         5o7Xf/g7FSPBPuNdyAQ0ZvBTD8bcJ1/WLIDstGflB5B5uim4T+oUFOl2RAFOPyVmwpHs
         Ty6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926480; x=1762531280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7n91hXfbqKaOek1a4KMSPayojDdoFizoG6Fs60W75tE=;
        b=LQOUYY68+J/uURdYbSmRwQ1j2Ru5DzHd6aetukeAbj65k8wQ7AqCsbVSIVXnYXcRd/
         vtNo3om9KU6QElItXRP0bIusGK+KFvBwC9uPOa6g+BNYRnRsm24S9N3vpsCHqvj9luHa
         +PayWxylMoJJDnVrUakjFGUQNJ64RAUaan/hQ4w/rTQeQ+HzJXQuPa2QZfst4KqtqpZn
         j+dIs2IsDVUlKDNZXPZQmWTlNqZih7E39OX+mLYuaP4qnwZhn5hcVXDYhNZsqNUvfW4q
         AzNBm5yAhQy4yQcBrzLBuZXhuY3td4C//XuulquUxQdNXW8cIftvsCHn5Cj5CvEdGlP2
         UfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRVYCYQCHRAy8q+We2JgCcqBuNlUHwW8lT0hXaDO2ZB4Z/LIM7IIexNP48fhglZaHaRDtHvG7Quzum6CLzMTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTr0zDwmwmhX/VxEUdnvsLdSe/WkBEr+ZvJmBX0SSBt7SCTSi
	fGSNaeQzmHaipuz57SljPyLtJiBE8abiTrUAGH0HfgdaLkb9k9tjCT71xqG7kJyguqC+zgFWxfR
	wc1T1IA==
X-Google-Smtp-Source: AGHT+IGhHC2El9WaUCCKm1Hj44ZgCrLgqsu/dbQUIstiiUukjm24CUn9fckX5YB+/0S+hCO8nrSQ+VvX1+s=
X-Received: from pjbip4.prod.google.com ([2002:a17:90b:3144:b0:33b:be14:2b6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc1:b0:340:99fd:9676
 with SMTP id 98e67ed59e1d1-34099fd96edmr2583925a91.10.1761926479886; Fri, 31
 Oct 2025 09:01:19 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:01:18 -0700
In-Reply-To: <aQTSdk3JtFu1qOMj@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com> <20251028212052.200523-21-sagis@google.com>
 <6904c3834e3c0_231474100ca@iweiny-mobl.notmuch> <aQTSdk3JtFu1qOMj@google.com>
Message-ID: <aQTdTkMIukzt-YlA@google.com>
Subject: Re: [PATCH v12 20/23] KVM: selftests: Add support for TDX TDCALL from guest
From: Sean Christopherson <seanjc@google.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 31, 2025, Sean Christopherson wrote:
> On Fri, Oct 31, 2025, Ira Weiny wrote:
> > Sagi Shahar wrote:
> > > From: Erdem Aktas <erdemaktas@google.com>
> > > 
> > > Add support for TDX guests to issue TDCALLs to the TDX module.
> > 
> > Generally it is nice to have more details.  As someone new to TDX I
> > have to remind myself what a TDCALL is.  And any random kernel developer
> > reading this in the future will likely have even less clue than me.
> > 
> > Paraphrased from the spec:
> > 
> > TDCALL is the instruction used by the guest TD software (in TDX non-root
> > mode) to invoke guest-side TDX functions.  TDG.VP.VMCALL helps invoke
> > services from the host VMM.
> > 
> > Add support for TDX guests to invoke services from the host VMM.
> 
> Eh, at some point a baseline amount of knowledge is required.  I highly doubt
> regurgitating the spec is going to make a huge difference
> 
> I also dislike the above wording, because it doesn't help understand _why_ KVM
> selftests need to support TDCALL, or _how_ the functionality will be utilized.
> E.g. strictly speaking, we could write KVM selftests without ever doing a single
> TDG.VP.VMCALL, because we control both sides (guest and VMM).  And I have a hard
> time belive name-dropping TDG.VP.VMCALL is going to connect the dots between
> TDCALL and the "tunneling" scheme defined by the GHCI for requesting emulation
> of "legacy" functionality".
> 
> What I would like to know is why selftests are copy-pasting the kernel's scheme
> for marshalling data to/from the registers used by TDCALL, 

I almost forgot.  I detest the "throw everything into a structure" approach,
which the kernel used largely so that it could share code between SEAMCALLs and
TDCALLs.  Unless there's a good reason no to, I would much rather have prototypes
like

  uint64_t __tdvmcall(<all the args>)
  uint64_t tdvmcall_1(uint64_t arg1);
  uint64_t tdvmcall_2(uint64_t arg1, uint64_t arg2);
  uint64_t tdvmcall_3(...);
  uint65_t tdvmcall_4(...);
  uint64_t tdvmcall_5(...);
  uint64_t tdvmcall_6(...);

