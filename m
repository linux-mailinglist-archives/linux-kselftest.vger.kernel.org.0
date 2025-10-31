Return-Path: <linux-kselftest+bounces-44524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B5C25CB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9163B011B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185BB2848A0;
	Fri, 31 Oct 2025 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEhbT09j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA7284689
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923719; cv=none; b=Q6KSyDwB8VMn+k6KqZ+YQqm3vfoI0mGcMKfTE2998MfrLzJyQpZ7aWpja3VhKU51nmFkclf9qwH8rm739uy7T6hzfZAtX1hQnDamgvHRoDY1j8MUL8J9pC7Eq+5uDRiTnc9GVR1b7Fzit5z0w2H9MAK8XMszSqhkq+WTPNSXnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923719; c=relaxed/simple;
	bh=KgBp8FhM9f9q9BUTKStGqPI5OTONzHa9S5jC6JtY25s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YtMOOVgNADzeoaWMcwUEmmB8PIIlPe15RCRh/JABnyN75nXaUblJcKyG0e/A09dBiKBYXJSFvTq74Nf1+k6snblzoGD+gEBOqwJ7OyOqs8ZB9A88QkTzSVBvnbl/Z2Da4FpEar2s8y7SmAJvMYhIwstMnrUKHpBIpgfhH0iLlFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEhbT09j; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a28ccb4c8aso2116577b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761923717; x=1762528517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYtMKrJOozoAeEJB2gcJ3hDhAS5XuhdxERWLpHapYz4=;
        b=oEhbT09j1IaiJZmTB0Z6TMMuIfkcVhHP7YlWtVomJAlZLuxO1SqTePnv7CJRjis/+Z
         irBGkwCx3ZUz8pM0Q+IvPmIayNOxpUkDeSSQ2+qAdRW8SBGxqEfCKqMs3uWJz+FJzfLM
         XDq5KCKMy+yOaCzSPSBc0a/zOqbUBFpKZ25LH59oKYjjBHNtQSLiME+131Zy1d4BtRAB
         klbQKXmV16GbJF9m7zPnWRV35Mcp2ydoESbqvhzKI13LFpXXYxrURFndeN3ne3ru0uZu
         7TLe2JqEXyzkpWVvBy3Sy1EMl52uHQjb/Hg/Aoxun/xpz7qHAbyQTg2m1pW1EE2GTqcw
         vD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923717; x=1762528517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYtMKrJOozoAeEJB2gcJ3hDhAS5XuhdxERWLpHapYz4=;
        b=X2/XsHeeLaXLdgVS273yRFBoVqMV2vg38uvLqGSTqO6OeEelEDg+ReySv6XRkM9WCQ
         yfONMCKD85afnS6OJ6wmivKimjG0yGsDmpjwZAEmP2WVC+IrYwI2cDjI25cRkvCbiVkR
         HYk/vwYb8FfmAR5E8mspS8YWRG7l0SIOcS72WUn2jaJ/TRXgRt3nYZvU9se2iwZxZNCf
         VzBIunFe/og1gIoiZB7SBhgvBPH0DDSDFadtEWWvem0quqRhv/7PrANdmMZNcxuOeH14
         DKMXx4bv1HtZz5ax1DBhgOZg48I8x9QRObOii7wZSWuAizZZL7Ho7K2slbzj4eHCJ0B5
         3+9A==
X-Forwarded-Encrypted: i=1; AJvYcCVTxHj5Amybiv6AMkHe/1BuKCTE/VcLNieJgaoVQLHR+eLuddPhMyDvnH4ntiLjHwOjpz58CUszAJ3RSPYnupM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Yz3ZUAcCfRp9WyZNonsmx8ZZ2UjPrKPkXWB72pUZTMnVgZZq
	YzkqfqDSq/ixdoE5N7vS7FkQgU7FD3IKlBvpd/MLAfm+5onRcCXFbuzs8Z82oepZwNsnhE6rggC
	bSZ//vw==
X-Google-Smtp-Source: AGHT+IGu0+RuDjG7fahYkHkNKQddGZwwQcsvoxvmM3C/hsORdH5wnAldsc8/2z0NwByS/d/qu5QIxuFZHMU=
X-Received: from pjqf8.prod.google.com ([2002:a17:90a:a788:b0:340:3e18:b5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa8:b0:341:78fa:1514
 with SMTP id adf61e73a8af0-348cc8e4583mr4597570637.34.1761923716634; Fri, 31
 Oct 2025 08:15:16 -0700 (PDT)
Date: Fri, 31 Oct 2025 08:15:15 -0700
In-Reply-To: <6904c3834e3c0_231474100ca@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com> <20251028212052.200523-21-sagis@google.com>
 <6904c3834e3c0_231474100ca@iweiny-mobl.notmuch>
Message-ID: <aQTSdk3JtFu1qOMj@google.com>
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

On Fri, Oct 31, 2025, Ira Weiny wrote:
> Sagi Shahar wrote:
> > From: Erdem Aktas <erdemaktas@google.com>
> > 
> > Add support for TDX guests to issue TDCALLs to the TDX module.
> 
> Generally it is nice to have more details.  As someone new to TDX I
> have to remind myself what a TDCALL is.  And any random kernel developer
> reading this in the future will likely have even less clue than me.
> 
> Paraphrased from the spec:
> 
> TDCALL is the instruction used by the guest TD software (in TDX non-root
> mode) to invoke guest-side TDX functions.  TDG.VP.VMCALL helps invoke
> services from the host VMM.
> 
> Add support for TDX guests to invoke services from the host VMM.

Eh, at some point a baseline amount of knowledge is required.  I highly doubt
regurgitating the spec is going to make a huge difference

I also dislike the above wording, because it doesn't help understand _why_ KVM
selftests need to support TDCALL, or _how_ the functionality will be utilized.
E.g. strictly speaking, we could write KVM selftests without ever doing a single
TDG.VP.VMCALL, because we control both sides (guest and VMM).  And I have a hard
time belive name-dropping TDG.VP.VMCALL is going to connect the dots between
TDCALL and the "tunneling" scheme defined by the GHCI for requesting emulation
of "legacy" functionality".

What I would like to know is why selftests are copy-pasting the kernel's scheme
for marshalling data to/from the registers used by TDCALL, how selftests are
expected to utilize TDCALL, etc.  I'm confident that if someone actually took the
time to write a changelog explaining those details, then what TDCALL "is" will
be fairly clear, even if the reader doesn't know exactly what it is.

E.g. IMO this is ugly and lazy on multiple fronts:

uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
                                            uint64_t data_in)
{
       struct tdx_tdcall_args args = {
               .r10 = TDG_VP_VMCALL,
               .r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
               .r12 = size,
               .r13 = MMIO_WRITE,
               .r14 = address,
               .r15 = data_in,
       };

       return __tdx_tdcall(&args, 0);
}

First, these are KVM selftests, there's no need to provide a super fancy namespace
because we are "competing" with thousands upon thousands of lines of code from
other components and subsystems.

Similarly, tdg_vp_vmcall_ve_request_mmio_write() is absurdly verbose.  Referencing
#VE in any way is also flat out wrong.

It's also far too specific to TDX, which is going to be problematic when full
support for SEV-ES+ selftests comes along.  I.e. calling this from common code
is going to be a pain in the rear, bordering on unworkable.

And related to your comment about having enums for the sizes, there's absolutely
zero reason the caller should have to specify the size.

In short, don't simply copy what was done for the kernel.  The kernel is operating
under constraints that do not and should not ever apply to KVM selftests.  Except
for tests like set_memory_region_test.c that delete memslots while a vCPU is running
and thus _may_ generate MMIO accesses, our selftests should never, ever take a #VE
(or #VC) and then request MMIO in the handler.  If a test wants to do MMIO, then
do MMIO.

So, I want to see GUEST_MMIO_WRITE() and GUEST_MMIO_READ(), or probably even just
MMIO_WRITE() and MMIO_READ().  And then under the hood, wire up kvm_arch_mmio_write()
and kvm_arch_mmio_read() in kvm_util_arch.h.  And from there have x86 globally track
if it's TDX, SEV-ES+, or "normal".  That'd also give us a good reason+way to assert
on s390 if a test attempts MMIO, as s390 doesn't support emulated MMIO.

One potential hiccup is if/when KVM selftests get access to actual MMIO, i.e. don't
want to trigger emulation, e.g. for VFIO related selftests when accessing BARs.
Though the answer there is probably to just use WRITE/READ_ONCE() and call it good.

E.g.

#define MMIO_WRITE(addr, val)					\
	kvm_arch_mmio_write(addr, val);

#define kvm_arch_mmio_write(addr, val)				\
({								\
	if (guest_needs_tdvmcall)				\
		tdx_mmio_write(addr, val, sizeof(val));		\
	else if (guest_needs_vmgexit)				\
		sev_mmio_write(addr, val, sizeof(val));		\
	else							\
		WRITE_ONCE(addr, val);				\
})

#define MMIO_READ(addr, val)					\
	kvm_arch_mmio_read(addr, val);

#define kvm_arch_mmio_read(addr, val)				\
({								\
	if (guest_needs_tdvmcall)				\
		tdx_mmio_read(addr, &(val), sizeof(val));	\
	else if (guest_needs_vmgexit)				\
		sev_mmio_write(addr, &(val), sizeof(val));	\
	else							\
		(val) = READ_ONCE(addr);			\
})


