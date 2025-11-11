Return-Path: <linux-kselftest+bounces-45281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A16C4B940
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 06:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AB124E6B80
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 05:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0563C28506B;
	Tue, 11 Nov 2025 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Piw1UqTX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241D527CB04
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762840735; cv=none; b=Bk54Z4VxDPpn1ku6S6Lf1FSz+18dRG3wqGCzVZKT8NnsqEmnME79eYwOtbQfoOqTM86FWxsQlgGY9///HWleAYk3kFTTQDFcFL20QyPMMS+iKHzh2iA/D5tPxE60RzfVa4BoXVXsmUL5s02Bb3s3tkf9ncu1R76tZgeZDVPCUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762840735; c=relaxed/simple;
	bh=5jnWpbWQQnlXG7OiNGwnG/0W4ah2GK8HKHu0tCa/bkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2FZR40FMwj87r1QqbYzKmJA8PgcUJV44e66mRM/3hJxhr96ta1+CFiZgJlWyKEuLwkYg1YncCUO+n4qzDB2+QrcUjoV4W9OE1cwUe/U1YA391WFt/jEPeQaJU8P5jTJubr65UXBU5YF6UkEB0xLsMru4eC6GrLFgstLaakYgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Piw1UqTX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso3784000a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 21:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762840732; x=1763445532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IN4rRfnCOfr9RMuoqowEQ8Wlb2hMDvz+fZbNk629L0=;
        b=Piw1UqTXSPfNXFA34ixERBT5beLcppKt7q84JCa42KPuYFB6xfoDPTxrpYowmnf9nl
         aVRmjDK4LPEi5XhhTjlZQ+I0yG7BR6rwXaJsPvHNY0Toxz4wEXqDasXVSKmzzqbtJkZo
         PTj+7XIitGodMf4kZwwt84R6fN3Kel66WKcy8ZznagJTXA6p0jsneus/V93QtM3DjgM4
         4380zJygSRmy3/q1fcRZUxLmxMicRfVEBDKsqrMjsnDsIzZjukLFCP1YPbWPyI2RSnaF
         gyP8ko9uGWDhXoNE4RXwGF6kn4Yd5RyeKwxHlWYE/JEbX1y5kD4uaK/xnltddajkgWFT
         30RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762840732; x=1763445532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4IN4rRfnCOfr9RMuoqowEQ8Wlb2hMDvz+fZbNk629L0=;
        b=NrqgWMRKNVHxYxUV525Z6GDr6FwT2w3xUylcD2EMJJwSQOJm2VL1fTM9UEuyPlbUdW
         yirM+rboDC/Wr5ca8TDX3QOfpZUQlEyWHpiXXLbtVmMgZTpD4HE6KF3bw2IDNYfkNcKw
         yZubzHb3Ri+fxcOwP9vhEIch3FvArMXqyf3tTmNDo+CWvmMszcJLPzkbP2hkLg/iLoAX
         Fhcn+RDJMcE2foueoVHgHbVAEFkYp9xLMJ6TgtC2eR+tB2y4cSRp1daYAzE9YNS4ODMU
         nD7o+kP36rLTWAROtHpQmG08iuT3z9KT5rziHBNhtJrakHI7XwrNUw3w9CW7iKnw/4Do
         YfUw==
X-Forwarded-Encrypted: i=1; AJvYcCWK3zd2ohFixoVfziRsHPQrB7MP1rriCq7p1ESC17ItEdTjds3mvn1I+Q7/i3nSv/liOUD2SPzrxXlvKxJP/XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWsRQ88pPxNKGlbjtOkizjfZc3nGmJEbPP2YggtfOBc4yZSsQ
	8mgku7KmtwNxLZXeiUc2g8B47UxmEQofaQkX7DP44lCB8Thgpci7Jj/f5vo6U1HtjAHIRaRyJKE
	5uxFi9sqkboIHya7IReIbLi6vIBit9DybBm82QQ/LSA==
X-Gm-Gg: ASbGncsY/lztybDQLGuSiUQOhALKGLY/ePYyFuur2Xq5Do2wAJnhpZidT9OKeNsAy3E
	F5VU1ascZdJ6Q78UnbzOl0Ko73VmkVQ+1BecdTJJ125TZac0LJ/QltdHcgv2yUN/oNkXEeDmkHx
	BNtUTfSQhMbStq9lZG5UAZsH2VuANYWbuxmbI2VAvCH3GxWeCfCtfiOwahn5UdSLSfhcJXWfriQ
	nWbAdiWwoZU0zXbhBfdUlSKtbKs7BqCY0MboseZG/j2GZVKfvSt3uKurzGsJDI77wDLEO9YIA==
X-Google-Smtp-Source: AGHT+IHHZP/aE/tVJZyLz+gOc0YU9Sc0i9PZJYzJ42dLOfI9Sr7WDBO2F0DsSawtvDJdjI2jksVRQSbzge+KnP9adhY=
X-Received: by 2002:a17:907:1c21:b0:b70:a9fd:1170 with SMTP id
 a640c23a62f3a-b72e05725a4mr966508366b.65.1762840728609; Mon, 10 Nov 2025
 21:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com> <20251023-v5_user_cfi_series-v22-25-1935270f7636@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-25-1935270f7636@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 11 Nov 2025 13:58:37 +0800
X-Gm-Features: AWmQ_bmwbidNFRD3Ln7UsJWJk61pCiG6pfhUPXDjXSV4C1IEKiwyDYyiO7oQK-g
Message-ID: <CANXhq0oEpCow0G+KsJ6ZPuwsxmAFVqoKGEzygiwSmxFsmntiWg@mail.gmail.com>
Subject: Re: [PATCH v22 25/28] riscv: create a config for shadow stack and
 landing pad instr support
To: debug@rivosinc.com
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

On Fri, Oct 24, 2025 at 12:51=E2=80=AFAM Deepak Gupta via B4 Relay
<devnull+debug.rivosinc.com@kernel.org> wrote:
>
> From: Deepak Gupta <debug@rivosinc.com>
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
>  arch/riscv/Kconfig                  | 22 ++++++++++++++++++++++
>  arch/riscv/configs/hardening.config |  4 ++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0c6038dc5dfd..4f9f9358e6e3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1146,6 +1146,28 @@ config RANDOMIZE_BASE
>
>            If unsure, say N.
>
> +config RISCV_USER_CFI
> +       def_bool y
> +       bool "riscv userspace control flow integrity"
> +       depends on 64BIT && $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zic=
fiss) && \
> +                           $(cc-option,-fcf-protection=3Dfull)

Hi Deepak,
I noticed that you added a $(cc-option,-fcf-protection=3Dfull) check in
this version. I think this check will fail by a cc1 warning when using
a newer toolchain, because -fcf-protection cannot be used alone, it
must be specified together with the appropriate -march option.
For example:
  1. -fcf-protection=3Dbranch requires -march=3D..._zicfilp
  2. -fcf-protection=3Dreturn requires -march=3D..._zicfiss
  3. -fcf-protection=3Dfull requires -march=3D..._zicfilp_zicfiss


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
> +         default y.
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
>

