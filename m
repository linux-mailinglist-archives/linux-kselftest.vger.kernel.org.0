Return-Path: <linux-kselftest+bounces-16490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01696961E90
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 07:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7D71F24ECC
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 05:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBF2158848;
	Wed, 28 Aug 2024 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ULGwyoHr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E532158535
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824189; cv=none; b=eLHGry5VDcUAFGPm3dXN8qwvynl4ouI+wLr1nzQ2E6dk7Gkn8sn7Ln4B6JtNlEZkNGKUVEVC9lc7IBHz9BjweLnXJg0W0sefLN6+91Cfs1+QANiQiOz2/mGqgTr7o0Rdz0fQYU4pESP1y1Nibbmvd5vx1AxY05RYvlm2C7t3Hik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824189; c=relaxed/simple;
	bh=ib/vcnYDgaY2P7lUbSF3YkIC17EmCG0vvapvjDW6XVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5JoFLuHfcO2sieKD1qo6QHD1aAkbvf7RC1/HUZd1Zale7VuOX/2/wmK/79rL3Turcjh4uWnFoWzpAFGnP+5/licowQZuyfFwzg17xQmxVRBr+ebDHOikOHRVPLgkq19U2PhVPEGD8e47ZCgU/3nyjSMWrXzWsjy6W6cyA/Y7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ULGwyoHr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202146e9538so56959965ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 22:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824187; x=1725428987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVwUzK3Wi136bLF1beJbPIYrhSgOvSQiUtDec+6VrAU=;
        b=ULGwyoHrD09zX+/631qHxxwvdPI8iaUy78Esakrmx6yMvAVH0+TZLKTulSFhvMaH6D
         i3pWgAvtwUf5bcm9Sj6OEaWx4mDnB8ywMFmehi5dTSTS30CiBKw3XGfnS93bYa2c+fgi
         ++U92Az0H4KzZ/Pmv5QhwDwNY9TZ1CaNCtp19JZ3PeTP6Ql2m3jGNfY6WdEjxjKu+jHn
         jzVpbJRylgf79FnevycVdcgkZkZh4XZuwgQPE7Wk7/V0sUriDrb2FTpSy0lfntm7QhdL
         vt4sOWAsMOoXnoF/TwmhzZXqO1UvuCwINPHPbkEmG7O5JKHFDYZvuVj1BXkjFIbqN55v
         6m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824187; x=1725428987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVwUzK3Wi136bLF1beJbPIYrhSgOvSQiUtDec+6VrAU=;
        b=pynuA6eaUMHR0r4JjlJiIy0Q/MWVXFEZ9z7hQ2MBoczcVIUIQ2OmH2vWnMuXaK1zFc
         zuSFTiMqj64ky3BV3NYgtNa42kbhmgouecnc75Fz7+MuXdZKUvbfU8nb4YXFBXkhUaus
         bBDvsDgBZm1egjKdKPeAfWW+Pkl+QpInD8Ub2fYl1yIqAsav71C06M+kt5O0kisdZ1IU
         OuNFyZnIsWdsQaXxRo137ZBHW6A8AVaPqxqa5wsu94ygWALrhUeYckAm4KEWtFpyT3Yp
         Hg7cJnW+hIS/38U87xbXBni/YRFi4PmUsLSg4ItmNx/U/hHnglFn/8uENdsG2SdKDDPb
         u/XA==
X-Forwarded-Encrypted: i=1; AJvYcCVvuJP2e5FQj91/tsdrjMm7XJNDOqyI7BniEJnpExuiNfdtHfQ4h+hNFUSa/WtEZEZRka6BM5Af4YeFL7en8e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZLkXmTXZQqQ1dITGgkQ4G5yPNlmzaO9JPpfeXc+WeppxBKKN
	AvqBQUIHEMieRC9K+tGD7bb59NVqyFs7eUROGhg/6z/m0uO4n/tJuLCZn5WZgnE=
X-Google-Smtp-Source: AGHT+IFs6bhbKPqiE/XUyq+o9y28MS2XMnZalJw5Zqf2sXjfONhgRAKfe8uENwidGpxKTHXbXFBJcg==
X-Received: by 2002:a17:903:41d1:b0:202:54a5:deaf with SMTP id d9443c01a7336-2039e4fbd80mr220740285ad.57.1724824186699;
        Tue, 27 Aug 2024 22:49:46 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:45 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:12 -0700
Subject: [PATCH 06/16] arm64: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-6-46ff2eb9022d@rivosinc.com>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ib/vcnYDgaY2P7lUbSF3YkIC17EmCG0vvapvjDW6XVw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XXGJ67WyV1982VXredvh0ENd1glLC4s4HJVXs9RbW
 X20a7/aUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwETa9BkZOnYYvlBTj2FUnbDH
 vODh/SmrdzHc++GxrUXG77agmXy8LCPDkyuNIo53Hzx7czND5bWgC3vzEimd+TtdNE+3T847GKz
 FAwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add support for MAP_BELOW_HINT to arch_get_mmap_base() and
arch_get_mmap_end().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/arm64/include/asm/processor.h | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index a67ca119bb91..39aabb1619f6 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -92,12 +92,36 @@
 #endif /* CONFIG_COMPAT */
 
 #ifndef CONFIG_ARM64_FORCE_52BIT
-#define arch_get_mmap_end(addr, len, flags) \
-		(((addr) > DEFAULT_MAP_WINDOW) ? TASK_SIZE : DEFAULT_MAP_WINDOW)
+#define arch_get_mmap_end(addr, len, flags)							\
+({												\
+	unsigned long mmap_end;									\
+	typeof(flags) _flags = (flags);								\
+	typeof(addr) _addr = (addr);								\
+	typeof(len) _len = (len);								\
+	if (_flags & MAP_BELOW_HINT && _addr != 0 && ((_addr + _len) > BIT(VA_BITS - 1)))	\
+		mmap_end = (_addr + _len);							\
+	else											\
+		mmap_end = ((_addr > DEFAULT_MAP_WINDOW) ? TASK_SIZE : DEFAULT_MAP_WINDOW);	\
+	mmap_end										\
+})
+
+#define arch_get_mmap_base(addr, len, base, flags)					\
+({											\
+	unsigned long mmap_base;							\
+	typeof(flags) _flags = (flags);							\
+	typeof(addr) _addr = (addr);							\
+	typeof(base) _base = (base);							\
+	typeof(len) _len = (len);							\
+	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);				\
+	if (_flags & MAP_BELOW_HINT && _addr != 0 && ((_addr + _len) > BIT(VA_BITS - 1)))\
+		mmap_base = (_addr + _len) - rnd_gap;					\
+	else										\
+		mmap_end = ((_addr > DEFAULT_MAP_WINDOW) ?				\
+				_base + TASK_SIZE - DEFAULT_MAP_WINDOW :		\
+				_base);							\
+	mmap_end									\
+})
 
-#define arch_get_mmap_base(addr, len, base, flags) ((addr > DEFAULT_MAP_WINDOW) ? \
-					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
-					base)
 #endif /* CONFIG_ARM64_FORCE_52BIT */
 
 extern phys_addr_t arm64_dma_phys_limit;

-- 
2.45.0


