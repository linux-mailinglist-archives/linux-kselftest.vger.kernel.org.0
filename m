Return-Path: <linux-kselftest+bounces-21187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2783B9B6F89
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4992822E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAC721A4DB;
	Wed, 30 Oct 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lsPxMLfj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7301D0E0D
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324565; cv=none; b=rNhVFzoRVzX5eNVvddQO314WMswTNS+BswcW2nCqrCl9XAXHkLpfCu4ocaggHGeAipaCfWdTi1bysbXlOQtvmIerPFO93uSZeMdL5WJnKh1o9bm90crwpjPmxMOp0cpxl1KeMQUuw13Y3gLoDu34raVOwuCPNyxrQx2L0FsyyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324565; c=relaxed/simple;
	bh=rucg5whNbj0MIf+KsFVqBycgNaOxrJPN8Sa8dKhqJn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJpE/lzNlwjh+VQ4Rg0FYzZLILzrYExy4/NDcB5YuGsI6vQ5hPh0u7kbabWEUWqgIRBx64kaBT9ag4QHPKFsz3S/ixMqz32I+mWNCToTKrymWQoh7hQq7EBRJ2dWkEVR16hLEkv0iiUJdZTS53ybo8B8yOWjM499gQ33kqB+1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lsPxMLfj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso1099314a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730324562; x=1730929362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BdQ8I1/iVHZTqbEU+uI3XwCIW70vWl0AHAkkkOUHa4=;
        b=lsPxMLfjdqektbm+albSHd1yo/8FqT7xiv9N1GLeNw/v8+SLsNrn2xkGk27y0taG0i
         wGTm7xRMqMHtMKZn89uMHRi7fbTX4NMKAOhKKpyq3KRVSFIt4yDNNY6MfdAZDmfp/0ot
         q/BZP7p2MTHXRU/3L9p0MzhxvC87mAYttH4GgY3t0dHsyHf405DXJhHthdTF65KgGtjc
         PSUBl1Rpe6o0/S8hFZPrDFbW1LHOj0fO78y6NYawPVxvigOLifO7QZBFKubIFqgPXWRB
         xWO9oecgBfSrJ6At8GEHsrnRvYpJLT3L/D5gKQnPSu+cajYHMVxWCShCfyQng+gBlgsK
         RT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730324562; x=1730929362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BdQ8I1/iVHZTqbEU+uI3XwCIW70vWl0AHAkkkOUHa4=;
        b=JMBbXkGQ5S0uciwVZ2QGniKb0LPKEfTwxRYqgo+alz8EErfX12ms1H+PgIUjPD2BPg
         bOhC+JMXNu76/V/huDir2aMoK5KB1M7F6nXvFyaZcnj81PVH3MVelPM831VII0c+J8x3
         TkWgxbaYbvFJz54NCZ8olGCtjf2wi+0dlPkRsPn36Ir7OSolNGTyhd9Fzs9R229swkwA
         bSctfPFWXQzr29Zj5/OvAsWg7cZZOBzPl6O2fobEm1e1mu9MkRa/ecDbAKvbX//1WVmz
         EQ2B+Rj8PhhARI0qJAP0sFVRLAoKNSjobpm41Fq3oR56C/RxWuclGAaxtO1tnrHN+rtR
         Yq0w==
X-Forwarded-Encrypted: i=1; AJvYcCWpDfkOJb+MMwjxitFpHr1NgDxmgi1jtl01kJY1Vc5yDEYfH11UJw4Idk2SB3KL3M8MNZ83nV/kZEPhS6fVFN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx401K1AIYk5aHrZ4kPiCf5hbwraCJn8ADz7X1B8kBa24teOqS6
	utCZzwpSSMoKeAoSDNrn+IqZonfW8Ouj6u62eEKsaE3z718mCDd7XR7Xomd6l+Y=
X-Google-Smtp-Source: AGHT+IFy/kVyXGrqtNtAvxVjR4gsi2Os3+luFSdpZIwpcWZFvkvKwsZgpNzjHfWBEiMYl3HDGVYUug==
X-Received: by 2002:a17:90b:51cc:b0:2e2:af80:8f7a with SMTP id 98e67ed59e1d1-2e93e0fd8f4mr220918a91.20.1730324562278;
        Wed, 30 Oct 2024 14:42:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe0252sm2400168a91.45.2024.10.30.14.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:42:41 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:42:39 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFT v11 2/8] Documentation: userspace-api: Add shadow
 stack API documentation
Message-ID: <ZyKoT00lI3d2rpYc@debug.ba.rivosinc.com>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
 <20241005-clone3-shadow-stack-v11-2-2a6a2bd6d651@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241005-clone3-shadow-stack-v11-2-2a6a2bd6d651@kernel.org>

On Sat, Oct 05, 2024 at 11:31:29AM +0100, Mark Brown wrote:
>There are a number of architectures with shadow stack features which we are
>presenting to userspace with as consistent an API as we can (though there
>are some architecture specifics). Especially given that there are some
>important considerations for userspace code interacting directly with the
>feature let's provide some documentation covering the common aspects.
>
>Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>Reviewed-by: Kees Cook <kees@kernel.org>
>Tested-by: Kees Cook <kees@kernel.org>
>Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>Signed-off-by: Mark Brown <broonie@kernel.org>
>---
> Documentation/userspace-api/index.rst        |  1 +
> Documentation/userspace-api/shadow_stack.rst | 41 ++++++++++++++++++++++++++++
> 2 files changed, 42 insertions(+)
>
>diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
>index 274cc7546efc2a042d2dc00aa67c71c52372179a..c39709bfba2c5682d0d1a22444db17c17bcf01ce 100644
>--- a/Documentation/userspace-api/index.rst
>+++ b/Documentation/userspace-api/index.rst
>@@ -59,6 +59,7 @@ Everything else
>
>    ELF
>    netlink/index
>+   shadow_stack
>    sysfs-platform_profile
>    vduse
>    futex2
>diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
>new file mode 100644
>index 0000000000000000000000000000000000000000..c576ad3d7ec12f0f75bffa4e2bafd0c9d7230c9f
>--- /dev/null
>+++ b/Documentation/userspace-api/shadow_stack.rst
>@@ -0,0 +1,41 @@
>+=============
>+Shadow Stacks
>+=============
>+
>+Introduction
>+============
>+
>+Several architectures have features which provide backward edge
>+control flow protection through a hardware maintained stack, only
>+writeable by userspace through very limited operations.  This feature
>+is referred to as shadow stacks on Linux, on x86 it is part of Intel
>+Control Enforcement Technology (CET), on arm64 it is Guarded Control
>+Stacks feature (FEAT_GCS) and for RISC-V it is the Zicfiss extension.
>+It is expected that this feature will normally be managed by the
>+system dynamic linker and libc in ways broadly transparent to
>+application code, this document covers interfaces and considerations.
>+
>+
>+Enabling
>+========
>+
>+Shadow stacks default to disabled when a userspace process is
>+executed, they can be enabled for the current thread with a syscall:
>+
>+ - For x86 the ARCH_SHSTK_ENABLE arch_prctl()

I know when you started out, gcs and risc-v shadow stack patches were
only catching up. But now that gcs patches are in -next and risc-v
patches have also reached some maturity. And considering this generic
generic shadow stack documentation, may be it's worth to mention
arch agnostic prctls here for shadow stack (that will be used by arm64
and riscv)? What do you think?

>+
>+It is expected that this will normally be done by the dynamic linker.
>+Any new threads created by a thread with shadow stacks enabled will
>+themselves have shadow stacks enabled.
>+
>+
>+Enablement considerations
>+=========================
>+
>+- Returning from the function that enables shadow stacks without first
>+  disabling them will cause a shadow stack exception.
nit:
s/shadow stack exception/arch specific exception indicating control flow
violation

>+ This includes
>+  any syscall wrapper or other library functions, the syscall will need
>+  to be inlined.
>+- A lock feature allows userspace to prevent disabling of shadow stacks.
>+- Those that change the stack context like longjmp() or use of ucontext
>+  changes on signal return will need support from libc.
>
>-- 
>2.39.2
>

