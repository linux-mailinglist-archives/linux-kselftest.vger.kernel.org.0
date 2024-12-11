Return-Path: <linux-kselftest+bounces-23224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1039ED94B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 23:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45D42802AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8351EC4D6;
	Wed, 11 Dec 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bm/Z+KBn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3897A1C4A20
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954703; cv=none; b=PTeZE7IHtbZE9YMQiqoZhA07uocXWJZ9b01uwbvQdOWdJC+P5d97k53I3SC19Z92AvcWXk2a/1kZ2zRUOO+hzD2Dja33Yxm7rD7P6BBZg4zG4Ob5h/91HCzSF/X3ARQm22UfAzWP7axDqwsHF1NmfuJxvcLOHA1Lwvy1GUWlcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954703; c=relaxed/simple;
	bh=48hZYgsKO6dztb1elGN9mIv03OaAS788aLKUsXNGgy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OPgh1pJ8YuEzeX41FNBq6f6ARdkvBDoye21nmuejMBftRU2tlspdRCb1udeIP+KDsjt8CcufYuXQbKLKketxgL/ZZCgBvDojliJDIMYWfNSrJBYOACcO7TztfNf6J4rRpmTUSBKFVwVOQJcXSAM6O6FjfYGAuOOid4wYTfDSEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bm/Z+KBn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so7007886a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 14:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733954701; x=1734559501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUq2+HHfD0MZnKG6S4yv713N9r4cWKPzp2/GucLxJ8U=;
        b=Bm/Z+KBnws/B9Xb40wlHAK4gw33tR9F7jtsM1TIoOl+tIsS62Jy7Q+vS4Vk0JH1NeV
         5NfrrhgpZrxzyQYquNHjwrBwTOivIt+5r0PBBSpkuzhY7HebWMvSMplyNiB5/RjJDGxE
         dNE1kv2Psmmq/j/u0xWWrmUW7K9q08Zp+I/rnLyKajWJTbeei/NtUBWC5fmte/hDN3sJ
         QP0W97Yl0LVC8nIfzALWRVwKAZRRg6zyyCsayibbXJaWZyIjk7RicpvkoeVIJSWQXA8b
         i3RtwqmU+smN1JeqWvBxRcLRbTJDxmLsOIrDj/q7ZTHQ3dZQRbfJPzHz5R/QAhXa+DSf
         7PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954701; x=1734559501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUq2+HHfD0MZnKG6S4yv713N9r4cWKPzp2/GucLxJ8U=;
        b=fVHT89Tvl5wGMi4AIQBlNb5O6rIQLIArogV+cmSM0a9DigaB8pOxa3ZYCjHckzSnli
         G/LDTzi2REPbcJgEkOA4J/y9G12QPQf8G0NPZyzMxirKPCv0mESxejVIFBRRK9XSRKcn
         SZ3qSRWcCiy7j8ZbpRCmBJ5N/D0Nxm4ojnehe7nmZ/JVGDqy6QHfx62Fo3HZVq8W6LGZ
         A+eJVFECjEG/W1xBEgR2Yj1uR0HBoXL7vq0szM3V1Jx/GDFi0AQ+VleOi8M8oKdeTMUa
         2IDldqVIJ++Z3YnJ3aXWgkys2KoZAbTKCu46C1z2igNI7vi1Dba8b34SAHBPWWJCTcFC
         Tsew==
X-Forwarded-Encrypted: i=1; AJvYcCWssORN578h/WHpmwy1XnYx6xKNGngz6bbF30Iwma6tl+CSyTVv7IR8E0Tyl1BCAyx3Ba5ktzSdWRiQuxK0PEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZphLPI0VUgnIFfSZFXZXF7FdKsdzqm/894JpbN/6x6FY1nr1/
	cfKdT9SiWH3uerUv9Z8CiapozJ/ws+1SqYPmdgrYFt63Mzx0CZS5IwRrqQq9/wLxX4o0YW9BX58
	w6w==
X-Google-Smtp-Source: AGHT+IEyb50yMKacPTznxoijQx7BN35QC5SQoHLR54g34UBhOfC2yU2PDiXYsV/JHqrTw/B7nLThww6z3/A=
X-Received: from pjbnb8.prod.google.com ([2002:a17:90b:35c8:b0:2ee:4f3a:d07d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e46:b0:2ee:8439:dc8
 with SMTP id 98e67ed59e1d1-2f1280e2a8amr6417546a91.34.1733954701643; Wed, 11
 Dec 2024 14:05:01 -0800 (PST)
Date: Wed, 11 Dec 2024 14:05:00 -0800
In-Reply-To: <20240910152207.38974-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910152207.38974-1-nikwip@amazon.de>
Message-ID: <Z1oMjKa3gExDxsCN@google.com>
Subject: Re: [PATCH 00/15] KVM: x86: Introduce new ioctl KVM_TRANSLATE2
From: Sean Christopherson <seanjc@google.com>
To: Nikolas Wipper <nikwip@amazon.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf <graf@amazon.de>, James Gowans <jgowans@amazon.com>, 
	nh-open-source@amazon.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 10, 2024, Nikolas Wipper wrote:
> This series introduces a new ioctl KVM_TRANSLATE2, which expands on
> KVM_TRANSLATE. It is required to implement Hyper-V's
> HvTranslateVirtualAddress hyper-call as part of the ongoing effort to
> emulate HyperV's Virtual Secure Mode (VSM) within KVM and QEMU. The hyper-
> call requires several new KVM APIs, one of which is KVM_TRANSLATE2, which
> implements the core functionality of the hyper-call. The rest of the
> required functionality will be implemented in subsequent series.
> 
> Other than translating guest virtual addresses, the ioctl allows the
> caller to control whether the access and dirty bits are set during the
> page walk. It also allows specifying an access mode instead of returning
> viable access modes, which enables setting the bits up to the level that
> caused a failure. Additionally, the ioctl provides more information about
> why the page walk failed, and which page table is responsible. This
> functionality is not available within KVM_TRANSLATE, and can't be added
> without breaking backwards compatiblity, thus a new ioctl is required.

...

>  Documentation/virt/kvm/api.rst                | 131 ++++++++
>  arch/x86/include/asm/kvm_host.h               |  18 +-
>  arch/x86/kvm/hyperv.c                         |   3 +-
>  arch/x86/kvm/kvm_emulate.h                    |   8 +
>  arch/x86/kvm/mmu.h                            |  10 +-
>  arch/x86/kvm/mmu/mmu.c                        |   7 +-
>  arch/x86/kvm/mmu/paging_tmpl.h                |  80 +++--
>  arch/x86/kvm/x86.c                            | 123 ++++++-
>  include/linux/kvm_host.h                      |   6 +
>  include/uapi/linux/kvm.h                      |  33 ++
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/kvm_translate2.c     | 310 ++++++++++++++++++
>  virt/kvm/kvm_main.c                           |  41 +++
>  13 files changed, 724 insertions(+), 47 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_translate2.c

...

> The simple reason for keeping this functionality in KVM, is that it already
> has a mature, production-level page walker (which is already exposed) and
> creating something similar QEMU would take a lot longer and would be much
> harder to maintain than just creating an API that leverages the existing
> walker.

I'm not convinced that implementing targeted support in QEMU (or any other VMM)
would be at all challenging or a burden to maintain.  I do think duplicating
functionality across multiple VMMs is undesirable, but that's an argument for
creating modular userspace libraries for such functionality.  E.g. I/O APIC
emulation is another one I'd love to move to a common library.

Traversing page tables isn't difficult.  Checking permission bits isn't complex.
Tedious, perhaps.  But not complex.  KVM's rather insane code comes from KVM's
desire to make the checks as performant as possible, because eking out every little
bit of performance matters for legacy shadow paging.  I doubt VSM needs _that_
level of performance.

I say "targeted", because I assume the only use case for VSM is 64-bit non-nested
guests.  QEMU already has a rudimentary supporting for walking guest page tables,
and that code is all of 40 LoC.  Granted, it's heinous and lacks permission checks
and A/D updates, but I would expect a clean implementation with permission checks
and A/D support would clock in around 200 LoC.  Maybe 300.

And ignoring docs and selftests, that's roughly what's being added in this series.
Much of the code being added is quite simple, but there are non-trivial changes
here as well.  E.g. the different ways of setting A/D bits.

My biggest concern is taking on ABI that restricts what KVM can do in its walker.
E.g. I *really* don't like the PKU change.  Yeah, Intel doesn't explicitly define
architectural behavior, but diverging from hardware behavior is rarely a good idea.

Similarly, the behavior of FNAME(protect_clean_gpte)() probably isn't desirable
for the VSM use case.

