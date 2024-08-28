Return-Path: <linux-kselftest+bounces-16491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C7961E9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 07:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5488CB23349
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 05:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6A715575D;
	Wed, 28 Aug 2024 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xHkxY+Tq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C931158D80
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824194; cv=none; b=siR/4bdFA4Cklyo0DbrS18aDIAeDgtRdyVEeH/53+yYJK0AviMEzfrUPi3zGnETAesOHnzEyry1eHk4X+DJ7TCE8MzjIetLBnTkbiUxrGZyF33CybAjL08MfqnJe41NsYbNKiGJMhUs1nu36qs+JRGw2P8cMyJ3a7N5/8tTizJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824194; c=relaxed/simple;
	bh=efrv8gA6WD0kUzxMoz7FX/k/QnHAbRwwUgR0y2hEUd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DY2IEtZmmPaQgLLfUGtHLm5ycnnjip3tKbJImDvrk86qrgvWazvHijuX0WobmuNI8ybGAhpuzctQdeKa5RVw4wvT8Xsk5Mbzq7hnS8COxCAR9ApAjngjbHLV0NZx2lBUorl/wAUkqSrVYoV796SEhbR+LAs5/xDhnpETYKIqBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xHkxY+Tq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201f7fb09f6so54511765ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 22:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824190; x=1725428990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01svQ9ue7Mr4CWZ3Wn0HVoOhr4xAPnLaZCO9CnTXUgc=;
        b=xHkxY+Tqnax3ywVHWyBD2R9IZoxXX5+jyVDhT2/MUchy1ONegKg5Ar80c8eSI2FTDf
         80ls4IqX4MGlY2JzotSBJ+SF+TM7FY2AxxhZ3Fp/6DNPeFT3w49bVLFcSNnmNxSiZE8H
         aEPiTcZcL0d5zdp/O0XDYpti9mVBtQ3TCgU3EbPU913l1kqN0YZYsCAS+MPOQLejk3p8
         hN+W9PO+c57qRYomlNUudAb3zf+54Rka8BMVWKwOjHiUBnbRAjSUBW/89EOE5/VEnWI4
         QGJE0gqm+mD1f36EgQpgszxOPaK2RwsXjKUCZHDdm/9DUPTISZrdWs2vdYnctq0C61Jc
         UaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824190; x=1725428990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01svQ9ue7Mr4CWZ3Wn0HVoOhr4xAPnLaZCO9CnTXUgc=;
        b=eeSWCT4TbkdSGsp3ZPZTmC45FGRYn2UreH2TsxD7TGo032za6QoPkaaTz7oFi4XwHb
         fKqy0Jt99DKQkl1FnEPb2ugrgCla8XZMO0d8qfnecxjP1EleX99e1SrprzdRx3q8kPSL
         czKmNhpfbhEM/SmvVFYGLZx+AzFKmybzwm5EICD9O3koTS3yolSeZFivmjbJZxIGERhq
         V2QSHIM8Whf/iOu9W77kl07sRc79yIpfN8nDBbdjb37YmGOcli01SXGyKrwra0FMvM7u
         pfZqwiOc2OHFdImn5QQpwinE8FwrHbg+KKVPSU4yUDOMBaYk7bWr9yZ4PdcdR3PzeEdr
         18ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVGhsRlm2heta4vPkXBgCQTKX3ZxItHC532BKqRgFHmFIabTJLW+eAoJSvyYm7KGgn7SsFej8YE9UgFWvu6r6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiEjEz5Jz9NK0+b617Xk8LY0G4F52/khbgYFf8aBwqk6+ouuw
	Imr4h+6Tbxi8nFkqRfv9M/MRePC3SvDfWqU0DD9NYFRfM6rE0My6B6AsBvIpSzQ=
X-Google-Smtp-Source: AGHT+IFEjwUM/ElshIB7y6tneVtatsCyua8fDLSA2/rXWwDoWBaTV3bT3kKjnxkFupcj6i3KTQazzg==
X-Received: by 2002:a17:903:41c6:b0:1fa:449:1dd6 with SMTP id d9443c01a7336-2039e510e6emr137316635ad.48.1724824190164;
        Tue, 27 Aug 2024 22:49:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:13 -0700
Subject: [PATCH 07/16] powerpc: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-7-46ff2eb9022d@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=efrv8gA6WD0kUzxMoz7FX/k/QnHAbRwwUgR0y2hEUd8=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XfETrh9IO7T/uFjUxMhNQooG1iuWi1pdtJg6YcLD7
 VUZ209HdpSyMIhxMMiKKbLwXGtgbr2jX3ZUtGwCzBxWJpAhDFycAjARbV+GvyIzjrH36plzvXDr
 3H/Wo2jj7SdL50ufO/vC42XF9noOjvuMDF8DvSaxHlpya2VRHMuNXyrdOxW6nj44wHJxyn8TwWv
 XdrEDAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add support for MAP_BELOW_HINT to arch_get_mmap_base() and
arch_get_mmap_end().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/powerpc/include/asm/task_size_64.h | 36 +++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
index 239b363841aa..a37a5a81365d 100644
--- a/arch/powerpc/include/asm/task_size_64.h
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -72,12 +72,36 @@
 #define STACK_TOP_MAX TASK_SIZE_USER64
 #define STACK_TOP (is_32bit_task() ? STACK_TOP_USER32 : STACK_TOP_USER64)
 
-#define arch_get_mmap_base(addr, len, base, flags) \
-	(((addr) > DEFAULT_MAP_WINDOW) ? (base) + TASK_SIZE - DEFAULT_MAP_WINDOW : (base))
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
+	mmap_end;									\
+})
 
-#define arch_get_mmap_end(addr, len, flags) \
-	(((addr) > DEFAULT_MAP_WINDOW) || \
-	 (((flags) & MAP_FIXED) && ((addr) + (len) > DEFAULT_MAP_WINDOW)) ? TASK_SIZE : \
-									    DEFAULT_MAP_WINDOW)
+#define arch_get_mmap_end(addr, len, flags)							\
+({												\
+	unsigned long mmap_end;									\
+	typeof(flags) _flags = (flags);								\
+	typeof(addr) _addr = (addr);								\
+	typeof(len) _len = (len);								\
+	if (_flags & MAP_BELOW_HINT && _addr != 0 && ((_addr + _len) > BIT(VA_BITS - 1)))	\
+		mmap_end = (_addr + _len);							\
+	else											\
+		mmap_end = (((_addr) > DEFAULT_MAP_WINDOW) ||					\
+				(((_flags) & MAP_FIXED) && ((_addr) + (_len) > DEFAULT_MAP_WINDOW))\
+				? TASK_SIZE : DEFAULT_MAP_WINDOW)				\
+	mmap_end;										\
+})
 
 #endif /* _ASM_POWERPC_TASK_SIZE_64_H */

-- 
2.45.0


