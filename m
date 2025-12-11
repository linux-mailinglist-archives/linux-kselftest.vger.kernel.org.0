Return-Path: <linux-kselftest+bounces-47417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE70BCB6A0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 18:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A63300B2BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79F314B93;
	Thu, 11 Dec 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="e6f64MLd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D33305E3E
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473203; cv=none; b=rQ4ex7EoP/RTUWWo2JwddO8oxPov9BbdJftoEZhXe1qhKYEvJjXhoZmhRNWbIttWWtDaDkqqydhncrPQx9ehgwidW09b9vsQJa+l6M23EeT61sesSkYr2IgOA7KUNR3DIu2NFoYS+O/ipYzWuc1pI/9UtwP4vwaqxr5/DIsgeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473203; c=relaxed/simple;
	bh=8eJeVSDMC2OXA8/c1hedw2Ay8kqSusEdqdEXbNb4yss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbT0B03JuXysm9GilPRZ9HypV7CxlADNyHr1MObPI0pBi0RV66kYrpzm+NjzVrQerPVmzVFbNsKvkFa3e5b19YNH+ap9yAj4HR/sZ+VyicAW3GbRDy8/cztcePbzoPScrbTDcbitEKAVmvqDPJU54r2tLW+xXHG5V98616bUcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=e6f64MLd; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640f88b8613so283153d50.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 09:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1765473200; x=1766078000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgsqjP5OdKf2pfViq8wHSszLchDHEA8k2q0YnXN+A5g=;
        b=e6f64MLd2MbEBff4BHorsHzanEbrMQAu8wJXMFvB5usQtYutEDcxhEAG9rFaanAo7M
         SlIMSfbi/CvsCZpN0IkOUEwAv5EuWNPrrc7z2HrxxnTThwWz13oqN9+fwU6QQkCawE9v
         KIn2GIqp2ruyHGxMV6X4q/JDLzQimoMsHz+1+RoPuAvTNSSJAayZEEbhrD1YFctw12VL
         hyuU4oZ0W3A2PKZa6TaacLnq43A1Du6F8AMlyw0IQyCcYEtMaJL7cCz+aoCTGOziUpqg
         O8bxAFT2rvuq47dSG93/Hw5wgQH/PXNZx73lJAb8zDzj3nrInoQj0ZCuvngwDEglabuE
         ZyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473200; x=1766078000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XgsqjP5OdKf2pfViq8wHSszLchDHEA8k2q0YnXN+A5g=;
        b=iCWKHu3Q8adL2BVG8cofhvw++UvB8SJKs/jG2S8ZZ41iXyu7farmB7iaOCbV5XeSBe
         sqNqAl3MDe3Vt1njXZx8sDMRcYifeKtqa9sLOoVAwrl3q+vEk2N92taHiPune9VFsff7
         fysWkWvSqJ40Db25iu7DUnzmRW5G96GQEoZ6NxRg8abfhPdxi9RtFfcG3bU3En/TtNvX
         YYaFjrczRyhCoiZvLFx8JJEEPghloSRV16BiRkygmfIqSrbu0nEWIF8qedEShHxSq5yI
         jpmdLkRt0TMvTfHvw6Teda/coQizomMqZ1PTbkQCLHryP7P8BZCQ2J8ApGlEH4BwB0pB
         feBA==
X-Forwarded-Encrypted: i=1; AJvYcCUz9CspZ+6/i16T99gpJc5ujp6RaKLqUhyV2f6/HBO1hnhKRdkmx5j1eLHpS1MpxZLIzkMc++vmYMjJnhPqrhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKo7Mj1+nGJ+OeOKEXD1x+GTMjUu63tqeRFgRd9LIWUtDrBchF
	ctcwA5f+3D4oD81yBf6DlQ5pIYJGXexuJlUIGF/rhhsTeF3XLEOEQcHDjSWPdw/uzPZIBLU0PNe
	g0In02ol0NYtvNUJGWfuSsRS2g4Xi4T6N7GcLNmLFZg==
X-Gm-Gg: AY/fxX4XOzq8bA+LhGjusRyRmJVONaqh+DEzXt1ZVs8npBy4uwUEWCddXvUqprTO1GC
	4R5VMy3M6XKRoYYBSKtosjMo6QTSKX06PByKaFkxExPlpsO5aLsvQht60E4mU2apMZDLUyWXVbA
	nNSuzkS0NMFB5pwWMwE0dBdqBx3uUuem37knmNH7jv/OD7R7kcljCQzfYx/fD9gV4YtJiTjU1zx
	sMSrpZZGErjT2xOq9/BA5MROFOeqlAmLv7cPli9AsCsM/7t4y1Go7zItMoxZDrPeveCgcAA
X-Google-Smtp-Source: AGHT+IEDvxO44/POz7bnaB+zrKXCNOOS/WPSTW3GIVXm1upC0YATz2kq4R7kn6XsCe0YNeacKDOWMUqKTxb574ExUiM=
X-Received: by 2002:a05:690e:2514:20b0:63b:8e09:7a47 with SMTP id
 956f58d0204a3-6446e97b295mr4684556d50.19.1765473200251; Thu, 11 Dec 2025
 09:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-v5_user_cfi_series-v25-0-1a07c0127361@rivosinc.com>
 <20251205-v5_user_cfi_series-v25-6-1a07c0127361@rivosinc.com> <b2acb9ca-1320-ab42-3937-2ea17153fac2@kernel.org>
In-Reply-To: <b2acb9ca-1320-ab42-3937-2ea17153fac2@kernel.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 11 Dec 2025 09:13:01 -0800
X-Gm-Features: AQt7F2rXBhYBRubaxsEthZTktAJEjMnbT8BXdFrJ84aaWwsz26es8ubAplXa-kc
Message-ID: <CAKC1njTfn-5ZeAV7x5819kXUqitVgO0HkKQi1S6UvZyiuroxvg@mail.gmail.com>
Subject: Re: [PATCH v25 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
To: Paul Walmsley <pjw@kernel.org>
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
	rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>, 
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
	Valentin Haudiquet <valentin.haudiquet@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 12:47=E2=80=AFAM Paul Walmsley <pjw@kernel.org> wro=
te:
>
> On Fri, 5 Dec 2025, Deepak Gupta via B4 Relay wrote:
>
> > From: Deepak Gupta <debug@rivosinc.com>
> >
> > `arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
> > VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
> > updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
> > This is to make sure that any existing apps using PROT_WRITE still work=
.
> >
> > Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encoding=
s.
> > Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
> > encodings for shadow stack. Above changes ensure that existing apps
> > continue to work because underneath kernel will be picking
> > `protection_map[VM_WRITE|VM_READ]` PTE encodings.
> >
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This Signed-off-by: doesn't look right.  It doesn't look like Arnd
> developed this patch, and it doesn't appear that he replied with a
> Signed-off-by: to the list regarding a patch that you wrote.  Did I miss
> it?  Did you mean Co-developed-by: or some other tag?
>

Seems like b4 messed it up. I'll fix it up.

