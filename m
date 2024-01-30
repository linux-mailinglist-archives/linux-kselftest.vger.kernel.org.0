Return-Path: <linux-kselftest+bounces-3758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4239842C50
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8FC289BA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88FA157E64;
	Tue, 30 Jan 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P6S4PoqF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48178B76
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641477; cv=none; b=AXTP999Ap3DsdfU1BrmphGWtN5fxlSMCgaPiZmb8u37VmApCe5dLkfRBnM4IfPA19I4NMKtdI0QlfHk3sFWaJqvB5ryEXzUoKxF1YusaCvFQ2WTGXwYLr8K7+87GQ3a3M5YiNs+65I2f4DTH//tyFdjZZZrsbuys75DrLQEpu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641477; c=relaxed/simple;
	bh=FRDzzVwyS7nuVapUvX+XBqyYOrJdFna/LWspy9EPMlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddoEG4sZIQOiKmUB8Jz+Mgvgq30Hw3wZ+HFgTCmiCDFUtAR0Ig828pJMqvdpGtap5qxpU67PwlUwuvMD9/HRc3DU2rHeC18U3qHe8eiPvROmW+034ABU51u6aWBlEtQvZmFBxXNjunRJpzSY29vq6vk8+pWlnpb5i/K6JHyPG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P6S4PoqF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d911dac3dcso912285ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706641475; x=1707246275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4k3XgG6Vs4V2eymg6847wUAtUHshLOeTHqeR5jZPT4=;
        b=P6S4PoqFAW4DWIyBC02xOoR8PYEQ3oUSFwVEacf7w9HEBy8VmTDkHa0gsJfGpewsjz
         k2Gt8Rs0HI1IbTTybSRU3HpYI17esm0qyWzMu/fzR+dP1CqvfFzKsuxKxboNHIffy3LA
         cX3KYJnuTADR8OkgMc9kCohxlpdl4SRRJsbjWM4R3wgVY/EqZhlREip6q4i50BB6VUHb
         yv6NDUcL0HEt2Nw2tzu/6VqLOyPuSb/jpEO0gJTXf3ZlfrIg+PWF7T608+e0ZwaXPct9
         SAilWlQi5LQ4Y9c4C+YkKB4QxqDZwtnxCSuFdoev9dcC3OwiGXkVhn0UTeIKx2ers2uM
         +ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641475; x=1707246275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4k3XgG6Vs4V2eymg6847wUAtUHshLOeTHqeR5jZPT4=;
        b=rFgKocvnwWFJypXwxRQUHpdcQTzeX1qhqj8xX6YOGf8adScG7UOrxlDn2cqGRkqGXG
         wypSTVjaJmms9vSJFBSgLjyotQh1ZGpPRtCT5feYSmyqX7hSyuK/+NVeYjHB4vGY5BhA
         9W3VyBLlGtWwxHVf4GxvsONVSiHKvO7pJhHWwR7ca2fEayKgso4DH3F+NrBMdjlUOmHW
         k4NdO5BzhHZd4JImzSPnZuzSQm2HMqlqdmmysDTWndnooQ8MFoot5VYW+qLVEibEH91V
         kUrAXMFFIqrlH2Rojre+qb6vT6gSr5VIKkFL8kfyv1cCj5l27gcmPRUE8V06G1eW+q7k
         np8w==
X-Gm-Message-State: AOJu0YxkpKoxXv3RUGkLw1pyhoFbNZMx8NaMVsdB1XWiuc/H8SupOzYq
	PilVUQpadmbS1xcDCjx23gK3PBGs8yGB/Ze5WqjQKUi018RGEJhhHeGRYcB3C94=
X-Google-Smtp-Source: AGHT+IFgptya8Q1OvyF+I3gPETTKvinxvv5APyOAribhmdoFU4/DBbXE6gQ2fksCvo6oajrQfoMLLw==
X-Received: by 2002:a17:90b:38e:b0:295:4b25:212b with SMTP id ga14-20020a17090b038e00b002954b25212bmr2367613pjb.4.1706641475147;
        Tue, 30 Jan 2024 11:04:35 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090aec8600b00295c3bb9318sm1196541pjy.54.2024.01.30.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:04:34 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 30 Jan 2024 11:04:31 -0800
Subject: [PATCH v2 2/3] selftests: riscv: Generalize mm selftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-use_mmap_hint_address-v2-2-f34ebfd33053@rivosinc.com>
References: <20240130-use_mmap_hint_address-v2-0-f34ebfd33053@rivosinc.com>
In-Reply-To: <20240130-use_mmap_hint_address-v2-0-f34ebfd33053@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706641471; l=8041;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FRDzzVwyS7nuVapUvX+XBqyYOrJdFna/LWspy9EPMlc=;
 b=rSHBvYDxfdS3K26d2oaN4+tX7NILBW5lAv4B0A2eQz8EBV0f0LtHqjJKt61QbdAbheOm3eOie
 DHnjVcEZiPTCMJdRG/c7TW+3+fDluHKlANMAtpDO0C6sTPtDfef+wRW
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The behavior of mmap on riscv is defined to not provide an address that
uses more bits than the hint address, if provided. Make the tests
reflect that.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/riscv/mm/mmap_bottomup.c | 20 +----
 tools/testing/selftests/riscv/mm/mmap_default.c  | 20 +----
 tools/testing/selftests/riscv/mm/mmap_test.h     | 93 +++++++++++++-----------
 3 files changed, 53 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/riscv/mm/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
index 1757d19ca89b..bad8e854263d 100644
--- a/tools/testing/selftests/riscv/mm/mmap_bottomup.c
+++ b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
@@ -8,27 +8,9 @@ TEST(infinite_rlimit)
 {
 // Only works on 64 bit
 #if __riscv_xlen == 64
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
+	TEST_MMAPS;
 #endif
 }
 
diff --git a/tools/testing/selftests/riscv/mm/mmap_default.c b/tools/testing/selftests/riscv/mm/mmap_default.c
index c63c60b9397e..a3874778d795 100644
--- a/tools/testing/selftests/riscv/mm/mmap_default.c
+++ b/tools/testing/selftests/riscv/mm/mmap_default.c
@@ -8,27 +8,9 @@ TEST(default_rlimit)
 {
 // Only works on 64 bit
 #if __riscv_xlen == 64
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
+	TEST_MMAPS;
 #endif
 }
 
diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 9b8434f62f57..93face2b3118 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -4,60 +4,69 @@
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
+	0x0000002732f06b2b, 0x00000012cbf8fd0b, 0x0000001fcc6af0e8,
 };
 
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
 
-	int prot = PROT_READ | PROT_WRITE;
-	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
+#define PROT (PROT_READ | PROT_WRITE)
+#define FLAGS (MAP_PRIVATE | MAP_ANONYMOUS)
+
+/* mmap must return a value that doesn't use more bits than the hint address. */
+static inline unsigned long get_max_value(unsigned long input)
+{
+	unsigned long max_bit = (1UL << (ffsl(input) - 1));
 
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


