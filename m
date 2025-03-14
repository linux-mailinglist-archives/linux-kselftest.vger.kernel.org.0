Return-Path: <linux-kselftest+bounces-29014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3B9A60BB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 09:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F99416F86D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591721B85FD;
	Fri, 14 Mar 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Btwlg3gQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56818A924
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941184; cv=none; b=oXum/6gTcYHWF1DHI4O8EEld+u+FxlTKIxPPzr92zmRU3i6KpFbD9Xf6+wSRW1xlqR4Zcq01+YOfeZBKPxrIA+fjhgbfBsLEjjEqbm7hTsVQCSnePA/QVyZXmge+pcWf0S1RcS8PdNGJpYI2AWtrGQVcfR5jVoQxXFk0rLAxNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941184; c=relaxed/simple;
	bh=xu5967BJsmCni8bG3U0wXv5e5cioeeVqhN7TGp+1s6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOZRo1Vsq5qhv0ruKCemCvpu9oKuFF5g5wt+/zeKEyHbKkG3aipYn1il/WY7CPPZvJiNX+HoCH5b07ds63HkwKX/ZZUPpQU3ZOAP1ueXEq04ygsHqjrSYmpvzcKDA9l81WJREDgoYt2xe7auIljIIX1c+fckDLTunqdv8huCjgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Btwlg3gQ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d445a722b9so10672975ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741941181; x=1742545981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV+0B9PMq9Sjr8aBQyixXXym4Bdz4psV6MbgJ2u7viA=;
        b=Btwlg3gQgAztUdFtEpHuxg8zMhCONXa2XtIaK2uQniS/aYGF4CkUwspO0nPi80ZJEe
         SUQti+198JpYXtmjZi4rCaxmTuXwMOlVGawT6wwy/L8YMIjzEbXH2e8u4nwXAAvsb/LW
         C9KyinUbMrXBGG+SFUfnZ3odUJzWH+CmElUJgYC7d1oCjg0pWSBrbKB/2BB3V4/dK/Yp
         7s7JIJQ23PPEbpcb8Ch07qNUwnpBt7ELuPrG9ZYnnfTHNrSK795AFHwwkz7sZ46+/48/
         JkpPHlCTWe/7ZoGt2YhfEMFA2dz3lYslt6wpFtgLFaAcyjk7bR6VmcA762tMYCIcpSjr
         nAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941181; x=1742545981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CV+0B9PMq9Sjr8aBQyixXXym4Bdz4psV6MbgJ2u7viA=;
        b=cczFXgyIozeWCiHOYwY1nAvXPO5DlVEVG1NHF93c3DX28KcN8LEL89cxX6rpsNPbV8
         Y4ZVspb+IfoJSNQUso55BWtkIoUnNyJNxIqMTs3t033cDYuYElxq1MCo4ZMKUiom+evP
         j8BfnKrlqhIvxG7TjsirVk5CFx3ze4bbHSByCmyZApdQobbM/r2NAAAV6tq78v1zJnQu
         hbs+nmQYdGrpAe6l8ECZM8qYqrOOq2p0QyKIkzCMetLGe9Gtl/HFbRCBOhEk3L2lLWz8
         pbyGBee9Lk8w8UNpPRYDACEdcOBnBt5WGCtH9hnM2sxKFmLKxVf7TNXaYZmKymBVBxiB
         354Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2lPzLhYwi9+VWpkByhowm/fC/NCp4kOntvG9hLQALUTDA3ny7GgeX6RE2oxjvfZFuigxUUxkem98+rjvGULs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+vOTbCLzmF5Y4Qv10y184TVg0TYeOpsWO0ee4cLRC/x+7g4w
	XskWIxiADw/Uh5ZqbBl/KDLpuS3JSpqQKmpDj4Q888xaHu8bgCZB1tqccoUIuNbjhhA783JNCqQ
	gNthvhbgsl9tt6CPVj2m4PfCMZd+bc8CSkOd6Og==
X-Gm-Gg: ASbGncteu35vfA0IMgiMKCzKZ3kIAcQeVFlV/3+yePXYCf63iSWgwRLdaGsULo7ks9D
	KPrx9BMJNYDTimvmKLylB1ZbUBzzcwusM8gCCXwY8ZxolCPVyVpvhIjrU4SG96WRfcZumW+u/Fp
	DQbckB7TpQv9HadEXTf04VuBA9oBs=
X-Google-Smtp-Source: AGHT+IEK8x1+7mzx/mnDrC0M1b3ETC4HGejLwUZPvYTs3VLjL6kfJlzbOoQCxNSGwzcmIdWjSKb0aGOGjwHoH1VTRPk=
X-Received: by 2002:a05:6e02:1747:b0:3d4:3ab3:e1a4 with SMTP id
 e9e14a558f8ab-3d483a8a2femr13198795ab.22.1741941181448; Fri, 14 Mar 2025
 01:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-20-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-20-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:32:50 +0800
X-Gm-Features: AQ5f1JroBVweXAVM7x9VC6V9Zhe5tUAc0jIbedQxG7U-9QMDJKkaaRUA9PVo_hg
Message-ID: <CANXhq0oC4mgVRjQ0ZCdnqZupitJaGOb1_=Goad8bbqkAY_bqbg@mail.gmail.com>
Subject: Re: [PATCH v11 20/27] riscv: Add Firmware Feature SBI extensions definitions
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
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:42=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>
> Add necessary SBI definitions to use the FWFT extension.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 3d250824178b..23bfb254e3f4 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -35,6 +35,7 @@ enum sbi_ext_id {
>         SBI_EXT_DBCN =3D 0x4442434E,
>         SBI_EXT_STA =3D 0x535441,
>         SBI_EXT_NACL =3D 0x4E41434C,
> +       SBI_EXT_FWFT =3D 0x46574654,
>
>         /* Experimentals extensions must lie within this range */
>         SBI_EXT_EXPERIMENTAL_START =3D 0x08000000,
> @@ -401,6 +402,31 @@ enum sbi_ext_nacl_feature {
>
>  #define SBI_NACL_SHMEM_SRET_X(__i)             ((__riscv_xlen / 8) * (__=
i))
>  #define SBI_NACL_SHMEM_SRET_X_LAST             31
> +/* SBI function IDs for FW feature extension */
> +#define SBI_EXT_FWFT_SET               0x0
> +#define SBI_EXT_FWFT_GET               0x1
> +
> +enum sbi_fwft_feature_t {
> +       SBI_FWFT_MISALIGNED_EXC_DELEG           =3D 0x0,
> +       SBI_FWFT_LANDING_PAD                    =3D 0x1,
> +       SBI_FWFT_SHADOW_STACK                   =3D 0x2,
> +       SBI_FWFT_DOUBLE_TRAP                    =3D 0x3,
> +       SBI_FWFT_PTE_AD_HW_UPDATING             =3D 0x4,
> +       SBI_FWFT_LOCAL_RESERVED_START           =3D 0x5,
> +       SBI_FWFT_LOCAL_RESERVED_END             =3D 0x3fffffff,
> +       SBI_FWFT_LOCAL_PLATFORM_START           =3D 0x40000000,
> +       SBI_FWFT_LOCAL_PLATFORM_END             =3D 0x7fffffff,
> +
> +       SBI_FWFT_GLOBAL_RESERVED_START          =3D 0x80000000,
> +       SBI_FWFT_GLOBAL_RESERVED_END            =3D 0xbfffffff,
> +       SBI_FWFT_GLOBAL_PLATFORM_START          =3D 0xc0000000,
> +       SBI_FWFT_GLOBAL_PLATFORM_END            =3D 0xffffffff,
> +};
> +
> +#define SBI_FWFT_GLOBAL_FEATURE_BIT            (1 << 31)
> +#define SBI_FWFT_PLATFORM_FEATURE_BIT          (1 << 30)
> +
> +#define SBI_FWFT_SET_FLAG_LOCK                 (1 << 0)
>
>  /* SBI spec version fields */
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>

LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

