Return-Path: <linux-kselftest+bounces-43311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA8BE227A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 10:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EF919A4380
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AF83090EA;
	Thu, 16 Oct 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NUet8qN5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB7305053
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603405; cv=none; b=nMg1qVT218K7U+YHIWD3njWLJT8qI2IRdvA8jX7uecSqyAwsuPJ2YVeB47xKvNoEhoKbrgzPphegIwyX+lSy6t7UbAoDQ3EZputyHVlAUd3HxaOLr6u41aEMb/BiogZmLgSoC94DuM30RuGiyDWslvrkeywDcGGfXK8aPqxkltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603405; c=relaxed/simple;
	bh=k42KT1WkRBHWgkIIkqFIrWGAaoELe9bfpMASrrF8Y1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsbwZfoCoCeqGTGqqRk884q5AMROM2t/QVPwqT8QkMo4tkqVzZpPV56a5YFmdpV7Y3YZHjoCTxM1dtlLRtfxdq7+OmPNwG7hxZecZ2GTU4rXJs8N9bH0pNJAWtrM25owM64aHEZPzqAMoD9NUeYrr7EufiicncfG7LEdUTqqgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NUet8qN5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so681486a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 01:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760603400; x=1761208200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dZ3zNJcojA/sJlGgESgs39Z0uRLTeXYPBFHIy0pECs=;
        b=NUet8qN5qrIYpFMgTvxdLdaHAI3OmmhKtR6iYJUENg83HZukG96jRvxXWHpp7fsboa
         duwILzd8rnxNUv4SU1zkws1Ubu68LmBtvJ+js4M1KWNXYmXN4aZxH2Hys3d17hGSe8QI
         fncCtCpiimHCjHeGzhXiAOSFDhnHHLWQtz/cWbkzUdC9W4vDRsHwMC3Dw8GDvWA9phj5
         anl4TlmUvZnmvsY76VWE395cAdPlRewMgJWu6C1ceDKOlrJs9dDkmHWFSYaXPULnwFFO
         5bRjd9HJH8BvZ0JVkePiRFYyX8WskpSp4KqCDBErpH+sybEokKD8wbI66Po4KnAM0OsG
         EIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603400; x=1761208200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dZ3zNJcojA/sJlGgESgs39Z0uRLTeXYPBFHIy0pECs=;
        b=ihC3BdBz7H3yyC0jb4wt060UEGEzfDvJE84629WLMSShYS0m1uPEwqDZgN6n5QUdO9
         J2S0vs7B+HoBAVoZLz8enJELFEVD/sPXMAtz5EPuhv7wXGbhBUPKrrgI7oPos8XBNxeg
         w4pNmK+vXCqCMCMtEz9wglp/E95qhfENiTOLUtmkSsj70obsBsFO6HJBjaD3Ct/l9ndf
         5yE57cllWt2FLrlZpvLct2S70jWICvgBXeo7jIvnmY3klkor5m80Rn+kM1j8AzHasqLB
         GouNsRrBoE8vDVj9FqBM87UW03rhNTsWlneizJI8bWFn/5nqee+al2dLwLQ0b2oV3xPZ
         qhFg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7cOCmXSG/X4WAVHup827WQ2N6mabdtARGC+dh3JJdXyhA979aAqkd/QyxzgHev9X+/aOqlK/Nk39Yz8r0D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyykGXFWLSAx5Zz+02YwtGCSRhrK31h30o6Ev5k2LjG4FTY0tdy
	idqZeVLc43deTSZtg3yJayGqVbFdukfvcwlNGG2j6mkJLJ4WQe2FoEYtBkpiIwyBsChBdU1VQNq
	ADJG6nSLZNHCuVrGeubf6EeHbNAlcXSbUPIReTalkrQ==
X-Gm-Gg: ASbGnct4pdMrHQ7/yH/puLjvvatVCYUbSnJun9maABYaeoHcXe9OBcykP7DjoW3srtm
	zC6VZjDzmXFoEA8X/Hb2K69shN8bQwEd/QsNSKjJSgtYiwOKpimNt1zbBRQUmXBMMaTsp8At6og
	ZGIzCMPV+rJ20LBKaP6haId9AxznrVcBXH9RnEjhp6ZdwcmFAIDHVTi62MK2VbOyTh9ruANb5z1
	FK+PiDX+6Fm9Xma6kb//OCqex3Xe31zpnyeNp0JNgCN2Z34555/sMdKuPie80mNN68NPtjLzQ==
X-Google-Smtp-Source: AGHT+IGyB7jwp1R/sb2SSrLIrlHDUB3Rfhzku7rZfdn97lwiX7fw79YoDZXn2zqSu6ScM4J5e0VHXW4a+hMbV7/+6J0=
X-Received: by 2002:a05:6402:35d2:b0:63b:dff7:8956 with SMTP id
 4fb4d7f45d1cf-63bdff78c26mr7390999a12.7.1760603400109; Thu, 16 Oct 2025
 01:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com> <20251015-v5_user_cfi_series-v21-25-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-25-6a07856e90e7@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 16 Oct 2025 16:29:48 +0800
X-Gm-Features: AS18NWC3gX9SfykK7BeQoaaUJU9Tso-y_BcITA4tZMgogw7A7IijvQhu4Ma2nRQ
Message-ID: <CANXhq0qHT=nnwG3SX3s_D3G2QqKGmQBbdzFwiQ5MMkimxCHJHQ@mail.gmail.com>
Subject: Re: [PATCH v21 25/28] riscv: create a config for shadow stack and
 landing pad instr support
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:14=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> This patch creates a config for shadow stack support and landing pad inst=
r
> support. Shadow stack support and landing instr support can be enabled by
> selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wire=
s
> up path to enumerate CPU support and if cpu support exists, kernel will
> support cpu assisted user mode cfi.
>
> If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
> `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/Kconfig                  | 21 +++++++++++++++++++++
>  arch/riscv/configs/hardening.config |  4 ++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0c6038dc5dfd..aed033e2b526 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1146,6 +1146,27 @@ config RANDOMIZE_BASE
>
>            If unsure, say N.
>
> +config RISCV_USER_CFI
> +       def_bool y
> +       bool "riscv userspace control flow integrity"
> +       depends on 64BIT && $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zic=
fiss)
> +       depends on RISCV_ALTERNATIVE
> +       select RISCV_SBI
> +       select ARCH_HAS_USER_SHADOW_STACK
> +       select ARCH_USES_HIGH_VMA_FLAGS
> +       select DYNAMIC_SIGFRAME
> +       help
> +         Provides CPU assisted control flow integrity to userspace tasks=
.
> +         Control flow integrity is provided by implementing shadow stack=
 for
> +         backward edge and indirect branch tracking for forward edge in =
program.
> +         Shadow stack protection is a hardware feature that detects func=
tion
> +         return address corruption. This helps mitigate ROP attacks.
> +         Indirect branch tracking enforces that all indirect branches mu=
st land
> +         on a landing pad instruction else CPU will fault. This mitigate=
s against
> +         JOP / COP attacks. Applications must be enabled to use it, and =
old user-
> +         space does not get protection "for free".
> +         default n.

Maybe it is default 'y' instead of 'n'

> +
>  endmenu # "Kernel features"
>
>  menu "Boot options"
> diff --git a/arch/riscv/configs/hardening.config b/arch/riscv/configs/har=
dening.config
> new file mode 100644
> index 000000000000..089f4cee82f4
> --- /dev/null
> +++ b/arch/riscv/configs/hardening.config
> @@ -0,0 +1,4 @@
> +# RISCV specific kernel hardening options
> +
> +# Enable control flow integrity support for usermode.
> +CONFIG_RISCV_USER_CFI=3Dy
>
> --
> 2.43.0
>

