Return-Path: <linux-kselftest+bounces-3780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A52843281
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DC8284D56
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 01:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE6E1C2D;
	Wed, 31 Jan 2024 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AetxdBnL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC33641
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663229; cv=none; b=F3JNWqSccvBA2RzCTtOhbnstvaUiPpG+9/hcK8IcwzquMMeyUG7N+8a62TpPMWOupMPhvneuf9j+3Ypi3+fEoYBZSKh3Id2aaBfeTHhBxXToKPQ0CPA7sojuqgPBTC10tk5atNyjjByWdbHZy0//eR2UJgbsAhHa5sOsO20QXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663229; c=relaxed/simple;
	bh=O8gOkv0E1+A6kkia3nAEslnYUt3oCjYhoTGBKmBpp+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9uYTudVVjOLLtuGhGW9Rym+NgwhV/8uA5hC1OkcV3iCAuBikzqcOuPC7ejVxOwFUdjCJULw9jpRx006Z+MtCIEB962Gp3NhvMQR2jUSP35rUNwpjaXMCkti5euqOKNHypXrU0uIhy5AEpq0YfXLj3YU7cS/IROvEWcdk0c2giw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AetxdBnL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d8e7df6abcso17641965ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 17:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706663227; x=1707268027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13+B6LdTKTjt05jiAPVkvvRHYs5geOTb+j5SNg+p/UA=;
        b=AetxdBnLzV9bO2p4XF8L60ky4H9oUu3Sd3H/1MmTpRc7e7LzdB5gZ3zzr8mGvdV528
         91rCTTsBuO4BIHgtF+NkmEqKAFmmWEG58gzcGZ5ZdtaO4WtoGJ6c+mTE6wWPTB2AtgGt
         s7C9+a81bANmPvT8q2xK5BczVK3IVKGhyWUuvP7A+top7JE4/4AFouGjSwPjpHLJgt8k
         IxnK5SO7BSkyBLAa3xEh4bJUxZXDOt7dBfmOByFSbg01xrguhsEgC/CEun1mBGMV/23u
         Vdao0r1tE2NQeNL0pQGgMATz0X6KiH45kXeTesq20mtkjazR6GTOtGVr/l+fhAihnMwB
         l7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706663227; x=1707268027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13+B6LdTKTjt05jiAPVkvvRHYs5geOTb+j5SNg+p/UA=;
        b=FQ1L3T+iqZJrzPSr/C6TlJ2UwCR6aO/yBZiOh3PspK6H2X49WvMAxY6cEf1tG83Rbm
         02YGjhx/vac8kxt4JUUvmEQAIxc2j/jtg0HV1nt3+odWbUigPURmfdgEnCNo8vz+Lr5w
         7ur1hFY2L9FpgUC7q2g9x7XiGog7gICgT/EfpM9lFLmIHsUm1fnIR+bTKjSVQfYhtaFu
         paAFQ/RrMTyO1XrQBSJxbW2NljCyWqat5AUQzPuLYtmtbrFZqVzDQZbXFZ+RX2Y9fEaj
         ZcVmblUIul2v+f2JxGa176Puns8fXGXJ6YnBhp7ooNapAorTpG8hiBXxeqhC9ABbaUvt
         yxCg==
X-Gm-Message-State: AOJu0YynMO3xS9LHWE5uIo0Vw5QT5H5P14Ei5WV/HAj3z1yG+IUgXzuG
	FPwg4Ue1sFhm/9zQHAFmumi+rkqDTKNZ2gmPHcC7rlElhTDTibsJCO1tVc+1n3w=
X-Google-Smtp-Source: AGHT+IGIqOEFmF8Mu/FASfF7P65RQWGZzm9qTCAxZvpsz+0vbkzTgvcUN2KnnNMoLEzcUjvmf/0/0A==
X-Received: by 2002:a17:902:d4d2:b0:1d8:ebdf:182a with SMTP id o18-20020a170902d4d200b001d8ebdf182amr328261plg.44.1706663226858;
        Tue, 30 Jan 2024 17:07:06 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id r12-20020a170903410c00b001d8d3c276c4sm4970822pld.35.2024.01.30.17.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:07:06 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 30 Jan 2024 17:07:01 -0800
Subject: [PATCH v3 2/3] selftests: riscv: Generalize mm selftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-use_mmap_hint_address-v3-2-8a655cfa8bcb@rivosinc.com>
References: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
In-Reply-To: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706663222; l=8909;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=O8gOkv0E1+A6kkia3nAEslnYUt3oCjYhoTGBKmBpp+k=;
 b=WDJobdBUYFFYtVz4fM3mc2BW26h1VmQ6/aM6YFyqcKnkZdKdsSDlfHr/m8269BVavOJ6niR8o
 kbLZ7INj1slC1TxiJM+zGX+bV9o4qK/6r+wzMsvzUXhyAPr1DF8kVVD
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The behavior of mmap on riscv is defined to not provide an address that
uses more bits than the hint address, if provided. Make the tests
reflect that.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/riscv/mm/mmap_bottomup.c |  23 +----
 tools/testing/selftests/riscv/mm/mmap_default.c  |  23 +----
 tools/testing/selftests/riscv/mm/mmap_test.h     | 107 ++++++++++++++---------
 3 files changed, 67 insertions(+), 86 deletions(-)

diff --git a/tools/testing/selftests/riscv/mm/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
index 1757d19ca89b..7f7d3eb8b9c9 100644
--- a/tools/testing/selftests/riscv/mm/mmap_bottomup.c
+++ b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
@@ -6,30 +6,9 @@
 
 TEST(infinite_rlimit)
 {
-// Only works on 64 bit
-#if __riscv_xlen == 64
-	struct addresses mmap_addresses;
-
 	EXPECT_EQ(BOTTOM_UP, memory_layout());
 
-	do_mmaps(&mmap_addresses);
-
-	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
-
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
-	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
-#endif
+	TEST_MMAPS;
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/riscv/mm/mmap_default.c b/tools/testing/selftests/riscv/mm/mmap_default.c
index c63c60b9397e..2ba3ec990006 100644
--- a/tools/testing/selftests/riscv/mm/mmap_default.c
+++ b/tools/testing/selftests/riscv/mm/mmap_default.c
@@ -6,30 +6,9 @@
 
 TEST(default_rlimit)
 {
-// Only works on 64 bit
-#if __riscv_xlen == 64
-	struct addresses mmap_addresses;
-
 	EXPECT_EQ(TOP_DOWN, memory_layout());
 
-	do_mmaps(&mmap_addresses);
-
-	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
-
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
-	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
-#endif
+	TEST_MMAPS;
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 9b8434f62f57..36e78d991d5e 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -4,60 +4,83 @@
 #include <sys/mman.h>
 #include <sys/resource.h>
 #include <stddef.h>
+#include <strings.h>
+#include "../../kselftest_harness.h"
 
 #define TOP_DOWN 0
 #define BOTTOM_UP 1
 
-struct addresses {
-	int *no_hint;
-	int *on_37_addr;
-	int *on_38_addr;
-	int *on_46_addr;
-	int *on_47_addr;
-	int *on_55_addr;
-	int *on_56_addr;
+#if __riscv_xlen == 64
+uint64_t random_addresses[] = {
+	0x19764f0d73b3a9f0, 0x016049584cecef59, 0x3580bdd3562f4acd,
+	0x1164219f20b17da0, 0x07d97fcb40ff2373, 0x76ec528921272ee7,
+	0x4dd48c38a3de3f70, 0x2e11415055f6997d, 0x14b43334ac476c02,
+	0x375a60795aff19f6, 0x47f3051725b8ee1a, 0x4e697cf240494a9f,
+	0x456b59b5c2f9e9d1, 0x101724379d63cb96, 0x7fe9ad31619528c1,
+	0x2f417247c495c2ea, 0x329a5a5b82943a5e, 0x06d7a9d6adcd3827,
+	0x327b0b9ee37f62d5, 0x17c7b1851dfd9b76, 0x006ebb6456ec2cd9,
+	0x00836cd14146a134, 0x00e5c4dcde7126db, 0x004c29feadf75753,
+	0x00d8b20149ed930c, 0x00d71574c269387a, 0x0006ebe4a82acb7a,
+	0x0016135df51f471b, 0x00758bdb55455160, 0x00d0bdd949b13b32,
+	0x00ecea01e7c5f54b, 0x00e37b071b9948b1, 0x0011fdd00ff57ab3,
+	0x00e407294b52f5ea, 0x00567748c200ed20, 0x000d073084651046,
+	0x00ac896f4365463c, 0x00eb0d49a0b26216, 0x0066a2564a982a31,
+	0x002e0d20237784ae, 0x0000554ff8a77a76, 0x00006ce07a54c012,
+	0x000009570516d799, 0x00000954ca15b84d, 0x0000684f0d453379,
+	0x00002ae5816302b5, 0x0000042403fb54bf, 0x00004bad7392bf30,
+	0x00003e73bfa4b5e3, 0x00005442c29978e0, 0x00002803f11286b6,
+	0x000073875d745fc6, 0x00007cede9cb8240, 0x000027df84cc6a4f,
+	0x00006d7e0e74242a, 0x00004afd0b836e02, 0x000047d0e837cd82,
+	0x00003b42405efeda, 0x00001531bafa4c95, 0x00007172cae34ac4,
 };
+#else
+uint32_t random_addresses[] = {
+	0x8dc302e0, 0x929ab1e0, 0xb47683ba, 0xea519c73, 0xa19f1c90, 0xc49ba213,
+	0x8f57c625, 0xadfe5137, 0x874d4d95, 0xaa20f09d, 0xcf21ebfc, 0xda7737f1,
+	0xcedf392a, 0x83026c14, 0xccedca52, 0xc6ccf826, 0xe0cd9415, 0x997472ca,
+	0xa21a44c1, 0xe82196f5, 0xa23fd66b, 0xc28d5590, 0xd009cdce, 0xcf0be646,
+	0x8fc8c7ff, 0xe2a85984, 0xa3d3236b, 0x89a0619d, 0xc03db924, 0xb5d4cc1b,
+	0xb96ee04c, 0xd191da48, 0xb432a000, 0xaa2bebbc, 0xa2fcb289, 0xb0cca89b,
+	0xb0c18d6a, 0x88f58deb, 0xa4d42d1c, 0xe4d74e86, 0x99902b09, 0x8f786d31,
+	0xbec5e381, 0x9a727e65, 0xa9a65040, 0xa880d789, 0x8f1b335e, 0xfc821c1e,
+	0x97e34be4, 0xbbef84ed, 0xf447d197, 0xfd7ceee2, 0xe632348d, 0xee4590f4,
+	0x958992a5, 0xd57e05d6, 0xfd240970, 0xc5b0dcff, 0xd96da2c2, 0xa7ae041d,
+};
+#endif
 
-static inline void do_mmaps(struct addresses *mmap_addresses)
-{
-	/*
-	 * Place all of the hint addresses on the boundaries of mmap
-	 * sv39, sv48, sv57
-	 * User addresses end at 1<<38, 1<<47, 1<<56 respectively
-	 */
-	void *on_37_bits = (void *)(1UL << 37);
-	void *on_38_bits = (void *)(1UL << 38);
-	void *on_46_bits = (void *)(1UL << 46);
-	void *on_47_bits = (void *)(1UL << 47);
-	void *on_55_bits = (void *)(1UL << 55);
-	void *on_56_bits = (void *)(1UL << 56);
+#define PROT (PROT_READ | PROT_WRITE)
+#define FLAGS (MAP_PRIVATE | MAP_ANONYMOUS)
 
-	int prot = PROT_READ | PROT_WRITE;
-	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
+/* mmap must return a value that doesn't use more bits than the hint address. */
+static inline unsigned long get_max_value(unsigned long input)
+{
+	unsigned long max_bit = (1UL << (((sizeof(unsigned long) * 8) - 1 -
+					  __builtin_clzl(input))));
 
-	mmap_addresses->no_hint =
-		mmap(NULL, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_37_addr =
-		mmap(on_37_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_38_addr =
-		mmap(on_38_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_46_addr =
-		mmap(on_46_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_47_addr =
-		mmap(on_47_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_55_addr =
-		mmap(on_55_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_56_addr =
-		mmap(on_56_bits, 5 * sizeof(int), prot, flags, 0, 0);
+	return max_bit + (max_bit - 1);
 }
 
+#define TEST_MMAPS                                                            \
+	({                                                                    \
+		void *mmap_addr;                                              \
+		for (int i = 0; i < ARRAY_SIZE(random_addresses); i++) {      \
+			mmap_addr = mmap((void *)random_addresses[i],         \
+					 5 * sizeof(int), PROT, FLAGS, 0, 0); \
+			EXPECT_NE(MAP_FAILED, mmap_addr);                     \
+			EXPECT_GE((void *)get_max_value(random_addresses[i]), \
+				  mmap_addr);                                 \
+			mmap_addr = mmap((void *)random_addresses[i],         \
+					 5 * sizeof(int), PROT, FLAGS, 0, 0); \
+			EXPECT_NE(MAP_FAILED, mmap_addr);                     \
+			EXPECT_GE((void *)get_max_value(random_addresses[i]), \
+				  mmap_addr);                                 \
+		}                                                             \
+	})
+
 static inline int memory_layout(void)
 {
-	int prot = PROT_READ | PROT_WRITE;
-	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
-
-	void *value1 = mmap(NULL, sizeof(int), prot, flags, 0, 0);
-	void *value2 = mmap(NULL, sizeof(int), prot, flags, 0, 0);
+	void *value1 = mmap(NULL, sizeof(int), PROT, FLAGS, 0, 0);
+	void *value2 = mmap(NULL, sizeof(int), PROT, FLAGS, 0, 0);
 
 	return value2 > value1;
 }

-- 
2.43.0


