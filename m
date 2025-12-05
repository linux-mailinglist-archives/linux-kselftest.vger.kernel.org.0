Return-Path: <linux-kselftest+bounces-47141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC8CA8CDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 19:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4251E30021CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC293344022;
	Fri,  5 Dec 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="N4VXFbW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AE325724
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959057; cv=none; b=YgEMEU3+hOFD5FgIlEP1ZCijpelWHme/W83h9Xv7mfHlxkuhH9HaWTuyhPEG6dWAcnom+4SI+F4PxN0GzBzPqL9nibRrj8Ra019WnXifRsuYzGxTyoHFZ0yfcxrfx6Eo704tnjB2UOLKaxK997I+4AMsSJ9GXGHDJl8d089LBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959057; c=relaxed/simple;
	bh=NVR+U3jG2tQbxbWsFur6YJo3TCvjT6tp/C+uJQCGLEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/T2EL7vbXgIHt6PIuudKs029lz2s3mPO3CJcyCDPkRtvRQ/AyUUoVtxWVCN/bgLk2UC/OeEN9CpF1UJepZoK5RXQu3Cdntd71kWBSs2qDbfhC6bsKa2PnuDLOQvsEsJOB1FDf2fvXy3LeEn0oOOLTbhZpa1tABJH2HQBWeFmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=N4VXFbW5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-298250d7769so19794005ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959055; x=1765563855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8W7GJchcQ4zk/poJ1GR6L1BtfcBrmnZJJRAQLqexSM=;
        b=N4VXFbW52VVrQmp8Uuu7vQuE1a3Et5buPSLuzNdHCCAyg7nc/qiIyWzT8/SreCHd5S
         m8VQNza1Guld4QsxgE3GrczagDJcSuWWeQ/2mWhbjmn7++weUnqqNo1n8CIPoNy1Qif6
         4L3ziOogGMN9AGdDD/RYVMmXac8LKMIteAt1x+OMzUjs8gPaR3BFeL8IThAdRuNWstj3
         /rLT1VOsaqQSz1ShQ95wQqfwHOxvvfHHzQoUx+sWJ6mPNChCC3203ZiSATfR0xVX7FoA
         hXPF8SUy7ib/7ttMhHa3XBA9PP+00NUiIQqPm3gIR5mtdm1EWNKPmjUW2PK3S42VtL5I
         Uo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959055; x=1765563855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8W7GJchcQ4zk/poJ1GR6L1BtfcBrmnZJJRAQLqexSM=;
        b=koctcv2C2Vq/Pa8XG+eWRm8sQXgxLkmQmC1Tpm8k/PM37OtIiHE0vboStVB9Zvf32v
         l5XUj3tkgtZlP/WPetGA7PmE7totD8kobW1O9xjK39Zl6wWXZ9CeS5lNAIbeLk+6CfBf
         S8C1IWNWCWdceB1jLN44amkMZjfwaD5ArUv6fKpHDqVF2AzDmqnZM9LQBLRCdEZANECn
         8Yn0KvF+Eb496ITwCAA9WjyFD642G0qM8+W6B434v9vHihTWyrJHBBXxae4YetDaOHTM
         fGAi3rTR9XTnIur8eaJK6wyhokW5Fk7+WiuR2jcieXtlHWKJohJ1zmYjY37n2GRxnEpW
         xg4w==
X-Forwarded-Encrypted: i=1; AJvYcCWwAmrwnUTO6JfDLAyBRXqaIbAf+PHohcjLF5AVIoVsaB95dM8EevWjRrt2rhtBlNn7a5Tdds6NPKb5O8uP8mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrjdEwjIDMiVmI6K9zdRWtaNIF6XLD7BlWfZ7M3R7nQ6Rphi9G
	ZjH948cT2JQLN+S4n2A9Hspr0khqf6Cgr3G5liLrejgW+mtBxS/VacsZQpr/CYkKtYA=
X-Gm-Gg: ASbGncuqU+2NY5eIGxAXr8xRWGr3B3/f80S0arpkcpZZJO+K6G1lHR6OraWRoAALMeP
	6FGQ4zaeuey3Qzz1/H28S5fZ/gQ7eJWUsHjq1AQg7CCXajYNtqNvSD0B1bLwFHyO5nGm1UdnNs2
	MxGObZPRPMguhkzyG7KvqFplGccN6AXx0siH7xNbzVny0k/pwyVsOaAdhfP0Ge/cL44xw0RA/vk
	+ERDGGFurAXto7tohv1OYUiKhSzeVoaDy9/jX9Nd5l0rSTd/7FaX3qrNIlmDWzgIvZPViYYBhiP
	V3YFPQOc3cE9pAmT0cqsLyvqXopv/NNCbQlqx+YDsI2BkArPtBPhcKTKdNCF5SGIv9kpD09f3wk
	VkY7xQPrWPbLc4nQVt9Y788q4y9yyKC/cFb3D1m3ySRyH8whJsTYchBbHsWrSpuNoJup2eAyOyp
	G6KiszBgUW54wVQGPGukKT
X-Google-Smtp-Source: AGHT+IHZMCsXUTCjOVQ3AFVu8onlvt7po3LO4OEVVdk3jTNgtLDl44M+FmDz1C3tnLg32Vfv9eEpZQ==
X-Received: by 2002:a17:903:11c8:b0:269:4759:904b with SMTP id d9443c01a7336-29d6848df81mr135161565ad.58.1764959054851;
        Fri, 05 Dec 2025 10:24:14 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4a13d2sm54863235ad.9.2025.12.05.10.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:24:14 -0800 (PST)
Date: Fri, 5 Dec 2025 10:24:11 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>,
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>,
	Valentin Haudiquet <valentin.haudiquet@canonical.com>
Subject: Re: [PATCH v24 25/28] riscv: create a config for shadow stack and
 landing pad instr support
Message-ID: <aTMjS-Ok-DrJJjQY@debug.ba.rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
 <20251204-v5_user_cfi_series-v24-25-ada7a3ba14dc@rivosinc.com>
 <b5feba48-7e7c-4ab9-a193-072f3980f525@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b5feba48-7e7c-4ab9-a193-072f3980f525@infradead.org>

On Thu, Dec 04, 2025 at 02:17:27PM -0800, Randy Dunlap wrote:
>
>
>On 12/4/25 12:04 PM, Deepak Gupta wrote:
>> This patch creates a config for shadow stack support and landing pad instr
>> support. Shadow stack support and landing instr support can be enabled by
>> selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
>> up path to enumerate CPU support and if cpu support exists, kernel will
>> support cpu assisted user mode cfi.
>>
>> If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
>> `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
>>
>> Reviewed-by: Zong Li <zong.li@sifive.com>
>> Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
>> Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig                  | 22 ++++++++++++++++++++++
>>  arch/riscv/configs/hardening.config |  4 ++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 0c6038dc5dfd..f5574c6f66d8 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -1146,6 +1146,28 @@ config RANDOMIZE_BASE
>>
>>            If unsure, say N.
>>
>> +config RISCV_USER_CFI
>> +	def_bool y
>> +	bool "riscv userspace control flow integrity"
>> +	depends on 64BIT && \
>> +		$(cc-option,-mabi=lp64 -march=rv64ima_zicfiss_zicfilp -fcf-protection=full)
>> +	depends on RISCV_ALTERNATIVE
>> +	select RISCV_SBI
>> +	select ARCH_HAS_USER_SHADOW_STACK
>> +	select ARCH_USES_HIGH_VMA_FLAGS
>> +	select DYNAMIC_SIGFRAME
>> +	help
>> +	  Provides CPU assisted control flow integrity to userspace tasks.
>
>	           CPU-assisted
>
>> +	  Control flow integrity is provided by implementing shadow stack for
>> +	  backward edge and indirect branch tracking for forward edge in program.
>> +	  Shadow stack protection is a hardware feature that detects function
>> +	  return address corruption. This helps mitigate ROP attacks.
>> +	  Indirect branch tracking enforces that all indirect branches must land
>> +	  on a landing pad instruction else CPU will fault. This mitigates against
>> +	  JOP / COP attacks. Applications must be enabled to use it, and old user-
>> +	  space does not get protection "for free".
>> +	  default y.
>
>	  Default is y if hardware supports it.
>?

No default Y means support is built in the kernel for cfi.
If hardware doesn't support CFI instructions, then kernel will do following

- prctls to manage shadow stack/landing pad enable/disable will fail.
- vDSO will not have shadow stack instructions in it.


>
>> +
>>  endmenu # "Kernel features"
>
>
>-- 
>~Randy
>

