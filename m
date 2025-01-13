Return-Path: <linux-kselftest+bounces-24319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E44A0B148
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE813A5A0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB235233D86;
	Mon, 13 Jan 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B4DrA2Mp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28178233134
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757465; cv=none; b=bcrOIhEFuKPR+SCILGKLKu3EPLbn6m1dhyXqRfJcSKJuZ/a0xOXkI7QK/dl9yKQz8FkAbh7qJCFtre3JZ6FHXHEPprDjG02FGN7ot0EMzF2mIWuvSX1+/owtntrufsP+vBcT8cVCVyFCLdX4EXDM9cfaEobjiAW4Mn4XB8Ckprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757465; c=relaxed/simple;
	bh=kN2FNI5tjS/SkVUOSzbQxNdDXKPB0v0FXY6myAvsiS8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTm5lP13Xve0bvE6HKaE4OPr/+g/p3bkOetkZqZQTC9aVSL+r5Ohx42bnr4cLECrk1xjmH+OlGCNXAMDoLblnYK/sHwwUUtBaH+iE1twhLTCDGgguiSHE0gu1cY9+6ErQSvlbVaPHVzQ0nSAEoDWHBaarM7gsTwLo5vkyK1xXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B4DrA2Mp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2165448243fso82250125ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736757463; x=1737362263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJXI8b6ff8wiNA8cdLu9hBvsj5PggOwQ7lAxRYtj+CM=;
        b=B4DrA2MpqSxzPFtER4lXArFAC+THT3LdKOFp8a980KfDnwmZsP0i22WDe000CilKRG
         CFyqEKgBX26Kx97fBhAjG0EtvVYZ30UsDRxFf+pPN37mipG0TnPy1i0952JtcXYIhZQQ
         BR+l4LRIdE2RmfYJWsr+eeIxKQQHHHp43fi1unAfmQqXBe3X9nD6yakBHb2Oa9eWU3wH
         nA9hVjsb1D0iiIHHr4/EOBkEJkzyrENcW3NJ0ivNMRW+yRUwWpCJqfWFt/pmhtKnYj18
         z2NXv/FRxmLsJKnVplS398i00hH08pPEt3SomqbfIsP3LVIHF7e7my+ni9VBdd0yaUEs
         28QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736757463; x=1737362263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJXI8b6ff8wiNA8cdLu9hBvsj5PggOwQ7lAxRYtj+CM=;
        b=Ep3e96AfTlm3ziFyxLt2MKKj+Qdr47COOIy3mLuWNbBZ2Pz6m46Sp6Rk+QYxaA8FS/
         dmNj7BqYhb9kmKHM4Wt60CqjMlq677fRSC524daUwby9aRVa9nbxYCK8N1FI7K4wJSaQ
         Edx7845ReSkYKEjTxMY3Mu1w6phxsNWPR3Qg9tMt7ervF7wv/SaYPANEjeAA8W9bq4oJ
         hLA2sbm/Dp1JMrWtdi6d7CHBNSj/oVq9yLDG9P7MkC1lJjnD/2UXpgsz+TBXEfF9TxuK
         Lt/o7LdXozAEETWwxkppWthpGcFoIRS5+kubjA+toa7nwrwV6XqV9LSAWNkU/povlasN
         50tg==
X-Forwarded-Encrypted: i=1; AJvYcCX9m+51qNZRww9jgLzv0AsCXsEfWY4Lb31VJX75WYqoCj90g8B1CD0gfSy4yHa+bSPmCw6rr9rTBOOXeoeBCaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lqFP8ngn2akA2cHYDOn3ZfRocha9+2TU/P1qDlCRszaaTp7u
	rR0VQr1ooLnR5k57ytg4Yun3smJ37zLAji+TlBIXyhRoPkq2Q9zMmor8jZA0R3o=
X-Gm-Gg: ASbGncsZVr7oGNpgUR2yjpn2j9CxcwAgnVxonim1Xwg1Z+FqbGNncrg4TV9gLz9jjMq
	HCxGWQYcrljJ0leJwsATFVgvcXzo30qvivY6QD5z8SkuONDQC1xIUxbPlNEhHyGSsT1SGDthP4+
	Tm6juY8IXJXX0f20ACEvVnrYD/VhuOdl73NDTtG756A7AQybhD5uPpFhM297Cxxn4oGme2dG3Xd
	n+Ur8t43Og+DKnLAfRu7hl2HI7EEgXHQfOmYb7csB8Y03EZ/cwPDIOUgMmWAUdikgbPxX8lEnis
	WbHYmqCz0wjHIIY=
X-Google-Smtp-Source: AGHT+IFtz8wCzJ8bWXX/3s5qBZWyQyvLgQzl4lgPk6ejyOwy8z7pnyLJogLi0etOSTCHQkUeGmH/OA==
X-Received: by 2002:a05:6a00:2e97:b0:729:49a:2da6 with SMTP id d2e1a72fcca58-72d21f1ac4emr31951733b3a.3.1736757463405;
        Mon, 13 Jan 2025 00:37:43 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07ceedsm6427433a12.6.2025.01.13.00.37.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 00:37:43 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v3 2/3] RISC-V: hwprobe: Expose Zicbom extension and its block size
Date: Mon, 13 Jan 2025 16:36:34 +0800
Message-Id: <20250113083635.73826-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250113083635.73826-1-cuiyunhui@bytedance.com>
References: <20250113083635.73826-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose Zicbom through hwprobe and also provide a key to extract its
respective block size.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 955fbcd19ce9..7a47cbdbcf8e 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -94,6 +94,9 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Zicboz extension is supported, as
        ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOM`: The Zicbom extension is supported, as
+       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
   * :c:macro:`RISCV_HWPROBE_EXT_ZBC` The Zbc extension is supported, as defined
        in version 1.0 of the Bit-Manipulation ISA extensions.
 
@@ -273,6 +276,9 @@ The following keys are defined:
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
 
+* :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int which
+  represents the size of the Zicbom block in bytes.
+
 * :c:macro:`RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS`: An unsigned long which
   represent the highest userspace virtual address usable.
 
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 1ce1df6d0ff3..89379f9a2e6e 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 10
+#define RISCV_HWPROBE_MAX_KEY 11
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 3af142b99f77..892dd71a3793 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
 #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICBOM	(1ULL << 50)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
@@ -90,6 +91,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_SCALAR_FAST		3
 #define		RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED	4
 #define RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF	10
+#define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE	11
 #define		RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN		0
 #define		RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW		2
 #define		RISCV_HWPROBE_MISALIGNED_VECTOR_FAST		3
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cb93adfffc48..affcc3e58df9 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -107,6 +107,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);
@@ -278,6 +279,11 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
 			pair->value = riscv_cboz_block_size;
 		break;
+	case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
+		pair->value = 0;
+		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
+			pair->value = riscv_cbom_block_size;
+		break;
 	case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
 		pair->value = user_max_virt_addr();
 		break;
-- 
2.39.2


