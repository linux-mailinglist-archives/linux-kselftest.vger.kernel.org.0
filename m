Return-Path: <linux-kselftest+bounces-26327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C386BA30270
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 05:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1997A3324
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 04:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AE81D63F6;
	Tue, 11 Feb 2025 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zVZ+f+bC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5F154BE0
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739246779; cv=none; b=QjpFOkTVH+1njscdzSCXLDcYZjw9mvbq5I9YvsdOSgFMntUe2VcWCjUvmKoJGOQ2x7p9BzTSBHuxgzkUpFXaBECKhkphRkg+rPYjNjkpsZC1l+kmkVexLBAsrtyGrrjus/TjTW4Ko031s6ailFAqRSlyR5h4lDNz/3QYoX5S0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739246779; c=relaxed/simple;
	bh=Y8Fb7c3oMJFhdqlpFFInDUQpR9IOTEPfZpM3xko40Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3Kawt3aA5VNTqtO899XPU+ar3e51szojDB70DsFvnEuFU/54S4Z+WmnQxXOWsIhrLi2zvM/SyhyVC7sOlQdB+Fd0bIjQxouW1Hkjxz/fJoOTfNyVS8cW1/rIVfCpgSZEv7Cef+AXgD1jVmJmkKH73RLrKK+Z4EL4JwVBuojmoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zVZ+f+bC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f61b01630so51256725ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 20:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739246776; x=1739851576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyKn8f6FlNrtiJWD+T1fk3XzsKPAFPZ0BSNq2D6GOdI=;
        b=zVZ+f+bCNBJ8qKlfMcYNOmMk/9ffVieJwJSW8z31ufAqZdoHUEnVzz9Afcm8HQg2iJ
         6s2FsqllFrWnxyxj60/30SiHaxFnKACuo7jkaxCCFkaH+oeu8+yDRl/Ss96A4A8ZEEHW
         ygtWO62NzHAiFvHrY4+Em2DwLZtoXmfM/LMlPqxt3iyw1l4UtkvUcj/dfETUk+yIMbq0
         yPG1F3h4DqN4EQ1a7eyL7FyAYlRhSYRtZ3xHLv6T4O25WjmC67BnT3mNZyrPGG34QjXG
         BoqWfliw32xZ4S2zZmyOIOc0UURQOHshI4xi1nrZ4p5Qlpcz5xYirSFbp0bPrWgCYnLe
         zEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739246776; x=1739851576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyKn8f6FlNrtiJWD+T1fk3XzsKPAFPZ0BSNq2D6GOdI=;
        b=D+W3RAhU4/hRjzWakdwefrvSXZXN6JnMsYOkpeCWCu9jiiSBbcSvKWjQdjhg7DqNHs
         kiHuGrTGS4ZMbt9bVn0yyW9td3cIHuB6UEVWtpabwyqbVTYuK5DRYkMoM1ZtgfArj1qV
         1SBfQvPJ08z4KwciDaNpST8dT4Ech2DioMLcp9yhSVC08xX+WkOAVkzWZJjxs3AcS4sA
         1xYCRB7ha9PzzmBGSVMw5G4+k40DSBcl2fjAttfP+Xy4BA1rV2QFESHImlAGRs5pgDNx
         Ojk3b8olo+0ZxL6mfGqUhZy+9btp8lVVoXaBOEgMl9YEY9zZQC5K3HfBvvDsXnyf6xiE
         RaRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF6+dpxJF3jhagBdtP184DYCorGuWJ+Y+q/4jJWZY6pLn6r77yL78AMmJ6AK9tjgDWeUhjXL0OA6KHND4KOY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6uxvQBVBM0kKGQENDVOBWd3erKiuBVuFyoQ6afBh4KmdBFba
	gvW4Mtu5DmSDMiVcVYLDAKRigtMNZQivJT1E+NaO/DUxe0O2DPVAljHTvSeZeAk=
X-Gm-Gg: ASbGncsyO9gguz54SEpBPP60R+DuDkSPSMMbQzLaxMacEcDWdYlkB9/6rdBMcD9Q5G2
	z1YyzE3PhWwZqkbstG1r/ayIMh+kxzJte1gt22CoK0bzbFXuE6mwznPdeA11ti83Oewd1JfiNk8
	tvPSRDoVTVFrtFXDyal81/vsoCT3UMl3qX11LI6MTPk3GVSYItlTIS5KMF6YyH+b1yRC0ckyRKW
	icKqV0LSeRAVy1KJAGm327U4uNlunkRiXrds10BhYRqeHf7ZkW5YqsQ9JtcT/n+azzELEPoiaSg
	ODi3hZ0xoaDlLs46tGgxY4FX7Q==
X-Google-Smtp-Source: AGHT+IGlh9j8ErK64T4ScD+I1yhp+hSLhhu8tQ8C1OBgFV46tBgTiWjpNTOBq5c7bhEw0dyoInj7tg==
X-Received: by 2002:a05:6a20:1591:b0:1ed:a4b1:9124 with SMTP id adf61e73a8af0-1ee4b5bfde2mr2966111637.8.1739246775980;
        Mon, 10 Feb 2025 20:06:15 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73085c8360asm3653872b3a.132.2025.02.10.20.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 20:06:15 -0800 (PST)
Date: Mon, 10 Feb 2025 20:06:12 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 01/15] riscv: add Firmware Feature (FWFT) SBI
 extensions definitions
Message-ID: <Z6rMtBud/hsKYYIw@debug.ba.rivosinc.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
 <20250210213549.1867704-2-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210213549.1867704-2-cleger@rivosinc.com>

On Mon, Feb 10, 2025 at 10:35:34PM +0100, Clément Léger wrote:
>The Firmware Features extension (FWFT) was added as part of the SBI 3.0
>specification. Add SBI definitions to use this extension.
>
>Signed-off-by: Clément Léger <cleger@rivosinc.com>
>Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
>Tested-by: Samuel Holland <samuel.holland@sifive.com>
>---
> arch/riscv/include/asm/sbi.h | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
>
>diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>index 3d250824178b..d373b5c08039 100644
>--- a/arch/riscv/include/asm/sbi.h
>+++ b/arch/riscv/include/asm/sbi.h
>@@ -35,6 +35,7 @@ enum sbi_ext_id {
> 	SBI_EXT_DBCN = 0x4442434E,
> 	SBI_EXT_STA = 0x535441,
> 	SBI_EXT_NACL = 0x4E41434C,
>+	SBI_EXT_FWFT = 0x46574654,
>
> 	/* Experimentals extensions must lie within this range */
> 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
>@@ -402,6 +403,33 @@ enum sbi_ext_nacl_feature {
> #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
> #define SBI_NACL_SHMEM_SRET_X_LAST		31
>
>+/* SBI function IDs for FW feature extension */
>+#define SBI_EXT_FWFT_SET		0x0
>+#define SBI_EXT_FWFT_GET		0x1
>+
>+enum sbi_fwft_feature_t {
>+	SBI_FWFT_MISALIGNED_EXC_DELEG		= 0x0,
>+	SBI_FWFT_LANDING_PAD			= 0x1,
>+	SBI_FWFT_SHADOW_STACK			= 0x2,
>+	SBI_FWFT_DOUBLE_TRAP			= 0x3,
>+	SBI_FWFT_PTE_AD_HW_UPDATING		= 0x4,
>+	SBI_FWFT_POINTER_MASKING_PMLEN		= 0x5,
>+	SBI_FWFT_LOCAL_RESERVED_START		= 0x6,
>+	SBI_FWFT_LOCAL_RESERVED_END		= 0x3fffffff,
>+	SBI_FWFT_LOCAL_PLATFORM_START		= 0x40000000,
>+	SBI_FWFT_LOCAL_PLATFORM_END		= 0x7fffffff,
>+
>+	SBI_FWFT_GLOBAL_RESERVED_START		= 0x80000000,
>+	SBI_FWFT_GLOBAL_RESERVED_END		= 0xbfffffff,
>+	SBI_FWFT_GLOBAL_PLATFORM_START		= 0xc0000000,
>+	SBI_FWFT_GLOBAL_PLATFORM_END		= 0xffffffff,
>+};
>+
>+#define SBI_FWFT_PLATFORM_FEATURE_BIT		(1 << 30)
>+#define SBI_FWFT_GLOBAL_FEATURE_BIT		(1 << 31)
>+
>+#define SBI_FWFT_SET_FLAG_LOCK			(1 << 0)
>+
> /* SBI spec version fields */
> #define SBI_SPEC_VERSION_DEFAULT	0x1
> #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>@@ -419,6 +447,11 @@ enum sbi_ext_nacl_feature {
> #define SBI_ERR_ALREADY_STARTED -7
> #define SBI_ERR_ALREADY_STOPPED -8
> #define SBI_ERR_NO_SHMEM	-9
>+#define SBI_ERR_INVALID_STATE	-10
>+#define SBI_ERR_BAD_RANGE	-11
>+#define SBI_ERR_TIMEOUT		-12

nit: Space mis-aligned(^)	^

otherwise
Reviewed-by: Deepak Gupta <debug@rivosinc.com>

>+#define SBI_ERR_IO		-13
>+#define SBI_ERR_DENIED_LOCKED	-14
>
> extern unsigned long sbi_spec_version;
> struct sbiret {
>-- 
>2.47.2
>
>

