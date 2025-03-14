Return-Path: <linux-kselftest+bounces-29096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9A8A61F04
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305E1188EF22
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E9A2147F8;
	Fri, 14 Mar 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c5aXYrxA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D2205AB3
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988425; cv=none; b=fPRyi9UmHaEK9rA7lOtfnH6TH0cUre2wzxaVG6a6rK51FIG4cTwJ8i87kg3Z4VXTnNPVaFQiL5/Zj0qt9W5U//7yyCtDAcm35KeKZBDZP4l41H9KWrMTgAT9s/saxLUng4d9sCJ6ofT9i0y8GWpWsY53U2gF6+pFJCtzZmkzuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988425; c=relaxed/simple;
	bh=7rQTgCVlXKdn1fwvud/1DTeAEnp2BYyBinw4QH1Ga2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4cDxBVmOhEGX5O0bOcgp0nADSIMzCG5tbybOamumAhejN15D6QDXx1GIK7eP+DPJVihNc8B/Hl8j5uyDAg+mbGR2s6blfqDcrze6p3kTBhKsAiH5iBuhlHLtYGegN2+hLbMszhd0kAoHScFreleFHnc3wrLX1AiyhoyL3aow30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c5aXYrxA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22401f4d35aso50707705ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988422; x=1742593222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxaplZUgROh7QEyvXgaGSGBpfUL9KoHoiOWsJ+5Erjg=;
        b=c5aXYrxAWVVfr5rGOnJouijxUr7mj5Bh1MsiIfcBCLNKhOqaLv7RU41Ua7wl3GNNI6
         iSAxig1W8KrpftvSBvx3HejhvzT8XPPpENrSnUYiKjJpH0n9TEXxsPnUH2xpjgKBYtSX
         4C6tfRfXSYLljegv8oHklJ7t6e07sORxadEuCB6L+xvAwWM85h/SjqczmNZUk0QcxJoC
         7vKpEP5kSRQKXXVOqrcCO4uD54SY0VgFU/nk+4kST0QOLfxRf9PGbnLOcLMpsWMo4xzm
         jQImOKQ70LxRsTKBZShvbKwCmaVR2VqBF69yIIE/oJY7VUd/ITgPRb/e5JtUYDGVsiSg
         i84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988422; x=1742593222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxaplZUgROh7QEyvXgaGSGBpfUL9KoHoiOWsJ+5Erjg=;
        b=pLCB+Rf+6dxJIM3iM8QvH3PhgtgprTkn3xXQJKdZIhUS9z2uNdRPHdD3r61/BwXgds
         YDGn6UNF9dYQZcBfZMmpmT++bHqJ6VdDKjKhBYVSEc9BT0MZwOOcnKKI78Am6HJLiIGn
         kn5hE/pfUjYvHGU6ux6sP/xmVpSAERC85fddSCCM7+XjxN83YVenwyVytGgSaoQVbHT4
         WZ8Jc9A/obRv/rNjZeEQaD+VNCeiefIH9W/j22VUc6gCmTKLmchVHrnu7lsjklBrARjA
         aGl64XBIzpEG4i9qjN0HFlipk9dcixM5dsI06W02XiDdbIK2dBN99KOE05qJ1up7mRhw
         oHXg==
X-Forwarded-Encrypted: i=1; AJvYcCVLilTkbBq9TfZ5Esguwpy8EwKI/k6GYwhPJiIuD6xtPGQ7nqiOIprRBjgXAlgOofCaJPNqqeAvPTR6poNzsL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2iF+RGyJDfc2C8TbLxAgENwWi9d893rM+Emc0jbKX/1DZFcPf
	Njng1DnKM5FGAomjPUBJFOV+0MdKJ346J/lfdXt2oe5618/u68T4/AfBpwhuc10=
X-Gm-Gg: ASbGncu6+l0La2eVCJYG9pGwVgcydUukF04s7tDyjxY+ZdDuttCe30hPQ9t2cbLGmiK
	wDHCOLOfPzgX05wXnhzckT+lXcp3Zwb/nWRQXGkmP9BosovjGaDKA7F/eDgFoj7gfsEJncmMhWC
	0yrF2iDlxcMNX6LOjw6x6UA9XYOMn6scDpI4FVjrKYi6d+kd4U9p2LW42Tbgz8lTjW+KkD5A2w0
	hEI4yxgr46ahNpvqUMdQ/FfVKfzAnfB2uDY3v5BN7rOQ3tkvosR47GAYJ6pYNgMoHQsYradYiW4
	seQo+OzCBOhD596g/Sg1Q6PsjSt7cVZZgn5KSFigzx0g3TwmYf7ZLCM=
X-Google-Smtp-Source: AGHT+IFnWo7zLhMGwvu4KurXEf7kIkAyH1HMaWOYapOqu0jjJNCjRbXuH7ozNEXPbffeeQud8LolDg==
X-Received: by 2002:a17:902:fc84:b0:223:fb3a:8647 with SMTP id d9443c01a7336-225e0aee9c6mr56406685ad.41.1741988422612;
        Fri, 14 Mar 2025 14:40:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:40:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:40 -0700
Subject: [PATCH v12 21/28] riscv: Add Firmware Feature SBI extensions
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-v5_user_cfi_series-v12-21-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>
X-Mailer: b4 0.14.0

From: Clément Léger <cleger@rivosinc.com>

Add necessary SBI definitions to use the FWFT extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/sbi.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 3d250824178b..23bfb254e3f4 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -35,6 +35,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
+	SBI_EXT_FWFT = 0x46574654,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -401,6 +402,31 @@ enum sbi_ext_nacl_feature {
 
 #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
 #define SBI_NACL_SHMEM_SRET_X_LAST		31
+/* SBI function IDs for FW feature extension */
+#define SBI_EXT_FWFT_SET		0x0
+#define SBI_EXT_FWFT_GET		0x1
+
+enum sbi_fwft_feature_t {
+	SBI_FWFT_MISALIGNED_EXC_DELEG		= 0x0,
+	SBI_FWFT_LANDING_PAD			= 0x1,
+	SBI_FWFT_SHADOW_STACK			= 0x2,
+	SBI_FWFT_DOUBLE_TRAP			= 0x3,
+	SBI_FWFT_PTE_AD_HW_UPDATING		= 0x4,
+	SBI_FWFT_LOCAL_RESERVED_START		= 0x5,
+	SBI_FWFT_LOCAL_RESERVED_END		= 0x3fffffff,
+	SBI_FWFT_LOCAL_PLATFORM_START		= 0x40000000,
+	SBI_FWFT_LOCAL_PLATFORM_END		= 0x7fffffff,
+
+	SBI_FWFT_GLOBAL_RESERVED_START		= 0x80000000,
+	SBI_FWFT_GLOBAL_RESERVED_END		= 0xbfffffff,
+	SBI_FWFT_GLOBAL_PLATFORM_START		= 0xc0000000,
+	SBI_FWFT_GLOBAL_PLATFORM_END		= 0xffffffff,
+};
+
+#define SBI_FWFT_GLOBAL_FEATURE_BIT		(1 << 31)
+#define SBI_FWFT_PLATFORM_FEATURE_BIT		(1 << 30)
+
+#define SBI_FWFT_SET_FLAG_LOCK			(1 << 0)
 
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1

-- 
2.34.1


