Return-Path: <linux-kselftest+bounces-14728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEBC946154
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FD21C20C89
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB441A34BD;
	Fri,  2 Aug 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIHRQVJe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC921A34AC
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614638; cv=none; b=s5+z3Lte2gIyT/TGHWvoy2Y23LE0BloDEnPI0UAfCQQZIRAZGBkfPkIi48j26U+rYJpxE1gX6bw9GUQDtyfmQG0Nl1iYVsV8KFAmP47WOLq04caeM6Fv5HpKhlmgA0iwy+56IenLrcyD25ragcoubPyNwQMFQjLwdBKFFMtJUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614638; c=relaxed/simple;
	bh=D5cezDh4A5XyfwFkC2BlahwYraXx3RdiYvjPIXTBfDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA5vn+5iAhYEzQdyXPKp5LgOW7QGcRmk6VcEYvKGCx3WeLxAO6gsefAY2d4GMK0ZMNb5aQ93dgMVBlWFyfTBSbPan7/10IsECYnqrmk7iObPm1TDEBYL518Jgo/r1MmJjzd58Qr1aVze6mHFAh2Ivf88MH025QBlp5MpDL7pnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KIHRQVJe; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so12147350e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722614634; x=1723219434; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaYp+4ySrYqox0C2LwNhC4Vws80twAVdjJbOgnZz/S0=;
        b=KIHRQVJe6Y/MjOKVb2whdHIVWcldHEUXi2MJeyXvjM4BHLaYUig0jy1s7X2FkuHKSY
         p1YBW9iggKrlP0ONUk6twLdFR8BzPW8lX5v3z9gYbk0dbi5xtlXcc8mfxCMgvxgfWW30
         2gJjuMpjnPFtW3id7aK7XakxTF6uD+b/lCp8BEsKsXe/YCUastne6o8wzHi5hbeBkzro
         DvVWPl9FjX3W3JxYk+aM8WoJlpG0+5WJHShAjylf9wW9awbubLcPEDWSJ8ey6v/r3Ude
         FagQ6FBlfm9ub0v2nYoS9RKYyc6yiBmxmuwO21Tm0NOMTSFGycV/lJUxr2UOp5sq16/K
         yfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614634; x=1723219434;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaYp+4ySrYqox0C2LwNhC4Vws80twAVdjJbOgnZz/S0=;
        b=lLOc8Q6bkG2JfSbFKOPkXMUwshkueckE8TXb4ijxDKMhEveWb89yFTZbBQlP5yDbUD
         bQr3j1wCLl3kEnatVM9BQJgJ6Q8j11PytubmOm3eXLQ1Z9M4a6oYoM2RMnSnyVsFIjPU
         rRFjlYS6f02vJRDV3bYoSfV/SlevPBd1CByaoYcLZtGIipd5H2DEH0Kz1yyw3i0ASsaG
         5ha0C/0afGrgKzdYRLp4SfNN8dOKazkMlk3MHdY8a4aRpQLuJ6NxYxQw401UBwdhSUso
         3YhXvsEqSRatwyuGUuLiLXBPHi/b1KvHtKtqVXvQHC2mPZjebQgJy0cyQy5zHBSG9peB
         6iWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX69TiodTd79RTFi1f7Y6LbKikBIKGcN48hO8tlzRXv6Nhr6rB7e+FUU765+WZNE4ypO9K6uGv8Q62FTVlb4B6AFdzXIXZ5zqCAeoAmgJKX
X-Gm-Message-State: AOJu0YzYsDY8tcdjkvwAPnsNFAsbFPXdw6kyIJWvNDCRrHAkdHO6J2wM
	3+fgWnVONE9zj6LkwrkDh8ICmYuskKASQ022WIiSmPuy5QoxlzFb+n0b07wNQPQ=
X-Google-Smtp-Source: AGHT+IHar+PPGcrxDNcjSr1um3g+3xRCfTrmLOXPeIhwAHJBP67s3XLeWwHx6hWOKLC6el1844qAfg==
X-Received: by 2002:a05:6512:3ba0:b0:52f:c14e:2533 with SMTP id 2adb3069b0e04-530bb3c79e9mr2525031e87.48.1722614633808;
        Fri, 02 Aug 2024 09:03:53 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07dc7sm266293e87.16.2024.08.02.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:03:44 -0700 (PDT)
Date: Fri, 2 Aug 2024 18:03:27 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 00/40] arm64/gcs: Provide support for GCS in userspace
Message-ID: <20240802160326.GA36502@mutt>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On 2024-08-01 13:06, Mark Brown wrote:
> The arm64 Guarded Control Stack (GCS) feature provides support for
> hardware protected stacks of return addresses, intended to provide
> hardening against return oriented programming (ROP) attacks and to make
> it easier to gather call stacks for applications such as profiling.
> 
> When GCS is active a secondary stack called the Guarded Control Stack is
> maintained, protected with a memory attribute which means that it can
> only be written with specific GCS operations.  The current GCS pointer
> can not be directly written to by userspace.  When a BL is executed the
> value stored in LR is also pushed onto the GCS, and when a RET is
> executed the top of the GCS is popped and compared to LR with a fault
> being raised if the values do not match.  GCS operations may only be
> performed on GCS pages, a data abort is generated if they are not.
> 
> The combination of hardware enforcement and lack of extra instructions
> in the function entry and exit paths should result in something which
> has less overhead and is more difficult to attack than a purely software
> implementation like clang's shadow stacks.
> 
> This series implements support for use of GCS by userspace, along with
> support for use of GCS within KVM guests.  It does not enable use of GCS
> by either EL1 or EL2, this will be implemented separately.  Executables
> are started without GCS and must use a prctl() to enable it, it is
> expected that this will be done very early in application execution by
> the dynamic linker or other startup code.  For dynamic linking this will
> be done by checking that everything in the executable is marked as GCS
> compatible.
> 
> x86 has an equivalent feature called shadow stacks, this series depends
> on the x86 patches for generic memory management support for the new
> guarded/shadow stack page type and shares APIs as much as possible.  As
> there has been extensive discussion with the wider community around the
> ABI for shadow stacks I have as far as practical kept implementation
> decisions close to those for x86, anticipating that review would lead to
> similar conclusions in the absence of strong reasoning for divergence.
> 
> The main divergence I am concious of is that x86 allows shadow stack to
> be enabled and disabled repeatedly, freeing the shadow stack for the
> thread whenever disabled, while this implementation keeps the GCS
> allocated after disable but refuses to reenable it.  This is to avoid
> races with things actively walking the GCS during a disable, we do
> anticipate that some systems will wish to disable GCS at runtime but are
> not aware of any demand for subsequently reenabling it.
> 
> x86 uses an arch_prctl() to manage enable and disable, since only x86
> and S/390 use arch_prctl() a generic prctl() was proposed[1] as part of a
> patch set for the equivalent RISC-V Zicfiss feature which I initially
> adopted fairly directly but following review feedback has been revised
> quite a bit.
> 
> We currently maintain the x86 pattern of implicitly allocating a shadow
> stack for threads started with shadow stack enabled, there has been some
> discussion of removing this support and requiring the use of clone3()
> with explicit allocation of shadow stacks instead.  I have no strong
> feelings either way, implicit allocation is not really consistent with
> anything else we do and creates the potential for errors around thread
> exit but on the other hand it is existing ABI on x86 and minimises the
> changes needed in userspace code.
> 
> glibc and bionic changes using this ABI have been implemented and
> tested.  Headless Android systems have been validated and Ross Burton
> has used this code has been used to bring up a Yocto system with GCS
> enabed as standard, a test implementation of V8 support has also been
> done.
> 
> There is an open issue with support for CRIU, on x86 this required the
> ability to set the GCS mode via ptrace.  This series supports
> configuring mode bits other than enable/disable via ptrace but it needs
> to be confirmed if this is sufficient.
> 
> The series depends on support for shadow stacks in clone3(), that series
> includes the addition of ARCH_HAS_USER_SHADOW_STACK.
> 
>    https://lore.kernel.org/r/20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org
> 

Verified this patchset on a FVP.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


Cheers,
Anders

