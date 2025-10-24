Return-Path: <linux-kselftest+bounces-44029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AD9C08583
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 01:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82E6B4EEE85
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 23:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B330E83A;
	Fri, 24 Oct 2025 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGDt3+7L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCD30F81A
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349460; cv=none; b=O/nft+7uTKOCBE66ZwrLkd3JUgoDt8Teb1XvB9v6vVKlWquheFTU/AYBwIkVqGDH+g1MOHHOBkuvgCzNhUrox1I6Dnc14G9/eb3WEE7S6QGC7IwcHxz0N29G/g5iyGSC+DvOpyRX8MxHj6dOQR2Y+cAxLkEUbt/TBF7KM82nZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349460; c=relaxed/simple;
	bh=+NEftr7VWmliQcXUqkaO9sJG2DgzF/Yaw8WY6cHdu/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXsMuRHZtQVyUsUhEpZBWJhCdpW0nkZtClUmgsBDslZpvVhH2yfcaYlOI2g4/p9LK9w7zrqk+wu1WVdOPdMevxfi7x1aZhYGFKQFE8/jAeqnOr+DDSzPz4eXUOChUCHHsa2K0uA0WvVfJeSg9kUjrEWeML9sB1a8qesWp8ZKCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGDt3+7L; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b4539dddd99so530396766b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761349457; x=1761954257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qshgmZlkIM4+vcn2er+R5ZwtdRF9Gko5Hx8ZyCDhMI=;
        b=YGDt3+7LCiRHSVxSFwaU3RvmV/hFEuPoVT9SVFK4moIN+drLr/RdVC091AFFdcXGmN
         xNPGMSGfEOzfpYg+sFF7/IXUrr6GDNbidsxXzUat/8RUW6xg046+b91gFtEFZ481T6a/
         L5pWEBlfSTSySDHqyM/nbyP8OkLej5/dZFi+apmghLagPGstJhwbHeiLsw+j2iItpX+L
         eGWDFQ9SU2Y6pc0BaLs0t1FhjIA0ygHe0lsvl2mcVIp0EP9FBKa55ZFGtOD/o1U/nuKg
         bB1g3JTvkLw/WNCJgXw6ppGcOIdK/A/Z6Aasyx4rzElTHH2cPg+aN7F1uQzkUV/30gnz
         d2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761349457; x=1761954257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qshgmZlkIM4+vcn2er+R5ZwtdRF9Gko5Hx8ZyCDhMI=;
        b=B7umtiUsMnVWhqny4CkQHuJ8f4aCm+fTewYwPoMl/zpFpMLLiNehB+JL6BXXRT32db
         nT4/ALIXC6Gdq5MGk4fiaqwh+rFT1uZqZ5NAuACVk6UVBEOq1xeKtVOCmE4YklNLmeQs
         UiRgcX7S9KFLmb1/iNXX2ImuXILbhfOXmZn/lX8VHjuMK7YFDcR3mIL9r7JF2r482cY1
         GTEco8F2a8EY8dk51Vd9j10WZJ1K4/BuYFXzynXxElhDx6SW2imMD/UDbLJtLahFQwUN
         3pR1JGAEqf4t6gudMYOC0yIRYyUVPqqMBwPCKQ8J/Ce2E82vG7g/YiYcqUwLjvFXiwcw
         T52w==
X-Forwarded-Encrypted: i=1; AJvYcCWiD1A/Ksz+l5dUXxKRCXMmIWo0FfFY5wixOEpQK+o9M02q2zwXUOQTG4TJByJnvNwEofoKsfLqha+FkMCy+s8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1rj7AxeZKSvwpynl+KIaaApdpfv+VsZiVnXxqtIqLATBQqXC
	Dp47JeYTS7eIf6QMrNyS3fXCibHITvbsMN77AnDE8RFcE8Nnbd5gpTIRNF+orA==
X-Gm-Gg: ASbGncth3HknHBRKmW6WgN2A2iCO4g2WGoe7bphUI6b6s5z+x91uwheJtg6kULB4Nyl
	WNUXVdm7eaWT77JIdUs7ioywDvCK2mQAM6gCwswWUCzHXHsmv8qgG6QHNDn7fquFa7rla++K6j5
	hduZAtB7EBK9WAAsnN+whFHOPGWBjIAajakZbThDUMmpmYkFOjLktpv5fZp8jqEDpgxQ35dP20L
	eqQTbfuuUAGYjpIQj6quFnAzoJSqKls4uyu52LsfSyic1qcyfi7ePHhglGYKs2FSgqaXdsfiXQl
	ISeDNVOQXpoJGAkwBroob2QwLRGh4iLpXaqxEUgqd5VBwF1vKCZ52+OB2vlBtv70f2ILvAgliad
	9IcP29MOdlqXU1l19EvJ1LpxE/K6PHqVxGEiDV//nPqMyq6OqNmYbF+cuRilLstGA4gpqqZw=
X-Google-Smtp-Source: AGHT+IEQw0TA1CC7no4fMAMA9oQRoUt9Lgbn+Uft1azRKrTnyGz7lCiyNuO6p2GHKFOC05VVJ/iKvw==
X-Received: by 2002:a05:600c:4f89:b0:471:a98:99a6 with SMTP id 5b1f17b1804b1-475cafae164mr64272055e9.11.1761342429974;
        Fri, 24 Oct 2025 14:47:09 -0700 (PDT)
Received: from andrea ([31.189.53.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d4b923sm89676705e9.14.2025.10.24.14.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:47:09 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:47:04 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
	anup@brainfault.org, atish.patra@linux.dev, pbonzini@redhat.com,
	shuah@kernel.org, ajones@ventanamicro.com, brs@rivosinc.com,
	guoren@kernel.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com
Subject: Re: [PATCH v4 00/10] riscv: Add Zalasr ISA extension support
Message-ID: <aPvz2Pb6RuWnw9Ht@andrea>
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020042056.30283-1-luxu.kernel@bytedance.com>

On Mon, Oct 20, 2025 at 12:20:46PM +0800, Xu Lu wrote:
> This patch adds support for the Zalasr ISA extension, which supplies the
> real load acquire/store release instructions.
> 
> The specification can be found here:
> https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc
> 
> This patch seires has been tested with ltp on Qemu with Brensan's zalasr
> support patch[1].
> 
> Some false positive spacing error happens during patch checking. Thus I
> CCed maintainers of checkpatch.pl as well.
> 
> [1] https://lore.kernel.org/all/CAGPSXwJEdtqW=nx71oufZp64nK6tK=0rytVEcz4F-gfvCOXk2w@mail.gmail.com/
> 
> v4:
>  - Apply acquire/release semantics to arch_atomic operations. Thanks
>  to Andrea.

Perhaps I wasn't clear enough, sorry, but I did mean my suggestion
(specifically, the use of .aq/.rl annotations) to be conditional on
zalasr.  Same observation for xchg/cmpxchg below.  IOW, I really
expected this series to introduce _no changes_ to our lowerings when
!zalasr.  If any !zalasr-changes are needed, I'd suggest isolating
/submitting them in dedicated patches.

But other than that, this looks pretty good to me.  Perhaps something
else to consider for zalasr is our lowering of smp_cond_load_acquire()
(can't spot an actual bug now, but recall the principle "zalasr -> use
.aq/.rl annotations ..."): riscv currently uses the "generic", fence-
based implementation from include/asm-generic/barrier.h; compare that
with e.g. the implementation from arch/arm64/include/asm/barrier.h .

  Andrea


> v3:
>  - Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
>  so as to ensure FENCE.TSO ordering between operations which precede the
>  UNLOCK+LOCK sequence and operations which follow the sequence. Thanks
>  to Andrea.
>  - Support hwprobe of Zalasr.
>  - Allow Zalasr extensions for Guest/VM.
> 
> v2:
>  - Adjust the order of Zalasr and Zalrsc in dt-bindings. Thanks to
>  Conor.
> 
> Xu Lu (10):
>   riscv: Add ISA extension parsing for Zalasr
>   dt-bindings: riscv: Add Zalasr ISA extension description
>   riscv: hwprobe: Export Zalasr extension
>   riscv: Introduce Zalasr instructions
>   riscv: Apply Zalasr to smp_load_acquire/smp_store_release
>   riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg
>     operations
>   riscv: Apply acquire/release semantics to arch_atomic operations
>   riscv: Remove arch specific __atomic_acquire/release_fence
>   RISC-V: KVM: Allow Zalasr extensions for Guest/VM
>   RISC-V: KVM: selftests: Add Zalasr extensions to get-reg-list test
> 
>  Documentation/arch/riscv/hwprobe.rst          |   5 +-
>  .../devicetree/bindings/riscv/extensions.yaml |   5 +
>  arch/riscv/include/asm/atomic.h               |  70 ++++++++-
>  arch/riscv/include/asm/barrier.h              |  91 +++++++++--
>  arch/riscv/include/asm/cmpxchg.h              | 144 +++++++++---------
>  arch/riscv/include/asm/fence.h                |   4 -
>  arch/riscv/include/asm/hwcap.h                |   1 +
>  arch/riscv/include/asm/insn-def.h             |  79 ++++++++++
>  arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
>  arch/riscv/include/uapi/asm/kvm.h             |   1 +
>  arch/riscv/kernel/cpufeature.c                |   1 +
>  arch/riscv/kernel/sys_hwprobe.c               |   1 +
>  arch/riscv/kvm/vcpu_onereg.c                  |   2 +
>  .../selftests/kvm/riscv/get-reg-list.c        |   4 +
>  14 files changed, 314 insertions(+), 95 deletions(-)
> 
> -- 
> 2.20.1
> 

