Return-Path: <linux-kselftest+bounces-21051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C709B57D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642581C229EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 23:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E4215C66;
	Tue, 29 Oct 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wl+1rBYr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CD21503A
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245526; cv=none; b=MtBQzG0+yBC9j56krlKQ5r72YdYMTi6vsDIMeja8tBGwkG8d0kLDg6WlerFHzm2L9+W8FF+ymIjsuT/xWCF73kGSx4pm05nkZAJhs8Nes2bjCsLam5reQVah5GRTHyMN6djiT4wHP1FkJXm+BBM688JAepIQUwSJX4E0Sqt5siU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245526; c=relaxed/simple;
	bh=npdjbdQ9OiznYboXySJA7nsTUXQsbon7kndWJUIFVYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0gXOUgh5JQCC2Gm+5yr5OwrL0URXHPHssrE9mAA+CCII3iqdl3GnCVRg1na+1f0Nj5UvDL4fmQ74Gl/SCdQLEcQZrQPw9UOZ6YPsZw3N8LN40XkAq3I+oAqFgQZxCMf+BZzfuvLXYX/upZQRtUYYz3nTt4VCHos9mPe2yUVPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wl+1rBYr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e467c3996so4617845b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245524; x=1730850324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vRNSIBiNXIf2UJE+KhXd4ECbBBsrxcPJxpg99mApzo=;
        b=wl+1rBYrIzBTIjBxkPFFknrSKB0jUyrigEFzLOTBni7SCfSJ+u7U/RM/wRLcjz5Xxq
         3gSS+eq/3o2u7gqgvN0KdysO3XZ6nymlZx28ap7dpI7/4MCBWLz+VqPTTI+ut4YSb3bx
         zPp+QgI3wkI8C9FNG6QwW0jSj0+FYqDofgZpjR5JlvWl11m+2PAZE63MUTbaS/tjavsD
         9BuEXlw2ilT2IrPApfxHBnEBb7qmdGNI66vv9UPMvpSA/MC+CklKce2K5rXMwdRQd6Sl
         KCRdjF6asxFtriwUhhMU0SV7bWmDgwsmXkYC47HJdy7yc9D3jbQOcjq0dvT8LwLL5llK
         j9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245524; x=1730850324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vRNSIBiNXIf2UJE+KhXd4ECbBBsrxcPJxpg99mApzo=;
        b=QM9zmcLv/JZs9gYxpR5kPRIlqMmmr4QepBZtccqWAR7tWOZDk6fgxq/3bN6U0Uk+Xv
         Kh/iHT3KBZ6Eeu6C7FlbBvSKMMnyNIQ0XcdIfUOp6BMfxxxJjhMUI3xpfa8HpoSP4gEm
         78Iyr3Btrk1EZFiuZELvOVZYo1vYxAlEGvkJF0jJ+yu8TyEPvTVCZRuqdKnT/eCdJaEC
         +ulmN+CpLnAqPHwDJT7Fb+kfH7+Rn4hMMJ58y1g7kMEvS6Y/zmWAp5FrxmQu8jPxFRKE
         dqiGZd7pYNjcnNSCAssf6ajzVJAawbMT/ZtS+xf0OH6ArtHR/nsCTQWgknL2wSD/vk5k
         wZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCXrhtiKfd4VvraWRVbNLkYXdUZoAz66zu5Q4xJPCZzHZgDuZPppkZi46WDHBAIf584RxQi0TSvT4ERl1JJhU3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBv1bld8eRpT0yShs7uXtANy8q5LqRo6kMdxI8JReV93fd6Z+K
	L4jCaWODtyh5BjSNzAoa8spWTAKgiNkuQ4TkvGI6tnnX1/eyxS+VTREfmw2Euxs=
X-Google-Smtp-Source: AGHT+IEYWYuZ3O/cciBKJ5slqaSkPGyDa205Q6lm+0Ith+W/z7NIQt+rMOIaCZW78WCxle4V1PPCdg==
X-Received: by 2002:a05:6a21:3998:b0:1d9:ab7:a835 with SMTP id adf61e73a8af0-1d9a84d990cmr18634439637.33.1730245523952;
        Tue, 29 Oct 2024 16:45:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:45:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:26 -0700
Subject: [PATCH v7 26/32] riscv: Add Firmware Feature SBI extensions
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241029-v5_user_cfi_series-v7-26-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com
X-Mailer: b4 0.14.0

From: Clément Léger <cleger@rivosinc.com>

Add necessary SBI definitions to use the FWFT extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 98f631b051db..754e5cdabf46 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -34,6 +34,7 @@ enum sbi_ext_id {
 	SBI_EXT_PMU = 0x504D55,
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_FWFT = 0x46574654,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -281,6 +282,32 @@ struct sbi_sta_struct {
 
 #define SBI_SHMEM_DISABLE		-1
 
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
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24

-- 
2.34.1


