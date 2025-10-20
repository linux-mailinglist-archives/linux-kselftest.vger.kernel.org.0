Return-Path: <linux-kselftest+bounces-43525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF9BEF40F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608191887FFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 04:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448522BEC2E;
	Mon, 20 Oct 2025 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TI7PAg8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F129D270
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934314; cv=none; b=pGac46yzHdNE1Fy4bj1XTW6X42/jQFqYcwN8zgoKIRMKWCLMVsrqgZdCXtWu4uizF8KIytJfi5rULlzMFJwCyXvxWuLBiSNgpnMT9lEQvRy61PuXtOS1uEoq9i8aMrvtCJejv4D3JQmPzVsWnfbO+o5DoAzFOdAYnfTr+sRUNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934314; c=relaxed/simple;
	bh=2UrLom+8S0YfMeVr+t5kLx1uY2+UanG/i4doYApCDfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6zFGY5Kyyn25qsLLunh3Yelx8Ho9EDElF+DBK3Xi6nqNlKSvSiQShlbHXDhQnqe4UhSBpj1iL4EFjrtIYhE3uwM2Ot4l1LeMP8SclDJCBWs0pe/DQkGbS7//9fI4WSn9DbAYxN3dMwIgywt1CbX0FLYDtto94+ETqXlmNrdDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TI7PAg8e; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2907948c1d2so42059115ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 21:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934311; x=1761539111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPcskIG/1ay0sXA6LTmEjesE/nyn+okHLSoMKeTK/t4=;
        b=TI7PAg8etcfGL3hzAEpu7CylxGLeoIKdbrIdxkjRnZ25lrDKDceBjE+6QcDpnWxYKA
         UdsZJSYCghNutnaP1nfYyoQsdyMVyBYHImZmZ78/T0QJKMz3lKvfbi4URxsCtMHroFMF
         2BU9+0yRwNwOVEfxC+z6t+NDe6lM4u9uRmc35kVU01wIL2V3vFCcMwTuHd846XigF8nw
         nDhfatDjSv6aq76ZXOyJEOanV1Ofsr6siwXu6EfwDPRgSDXCOyAfRNujsGZtly4VqxKZ
         F9K/i3E8YXfhbsdbvxexNTTVnIbGqsrFexIvoIvvvI6Lq8qeDr0J6mF+stcpKsG/niKA
         yacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934311; x=1761539111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPcskIG/1ay0sXA6LTmEjesE/nyn+okHLSoMKeTK/t4=;
        b=hmIMwmiowsn70xGoXQ3AOq1ZddC1JhZVDh3fMlYgfLl2jEgr54/kBb3OWQRa3eYs76
         Y1LMP6LvJa0ctmqoU3m7SvWGhD6gVYSkIvLvH1OGaSvje3VWgJORZy29cna8T7gBK2/g
         HNpatab4tI9/7UMyXcPTB7aTgjyNgfBrsc7jObJy9i4Q0M4/vL/p3Le8YIF7StdMcFou
         gVX57RiYiaXh5y50j+CgEYfWekjyntxzEzCN+ziJkGIwezqHcEZCcNiDiJTyoSYEfqoQ
         rBhdajDGgNIBT/UWSHyFQFWIXHfmR3KRgt3N1Otys0ouNXfNigTRmwNcb317PpVNek4/
         0b2w==
X-Forwarded-Encrypted: i=1; AJvYcCWdHJYkNoTbUN7oNu+gpPdeUpJ/BFTU9FTfAZvFPOsIehcWrqc93doE7cqYUC2OGC0/A4Qo/4Jbn3iGP8QzwT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwrHnCDo8OpMc0egTNSR3YItoJbbYogtayBtAPoEOkG73Bg8es
	MuDUthD7OLfGpnTXz0PFXzPhaVRia/ad/ZzOtwQ7lA3BtxqR77Nsu6byXiogKKV4j4k=
X-Gm-Gg: ASbGnct6TlZKfqMUFJX88zScFiHEE+VIoGL6KNBVJKXrdpkNhU8Uu9V23Ts5bPj5UY1
	tBA1hQBGQQszyqpTF09CUS6psuvieIUaCF2V/i8ggesahSWf3qMs6k2n0ZSCO1fCkVBFTR+yyqs
	gWiXDWIW6StbPLWqCl3qqup0s2AFGPmrdVch0PRNGJWhNU07CghfYK7GCk8irSL1MoPSXj7ocPI
	IA9fnAYIu2WRy1G8OewN247W1/HoItfUS+zcmaS1i+wpSzd/vVnxx4VncA2Q7Ib36cECpMJkgjs
	DNZukh1T4b/gFyMDTXoCivZYT643EWIa66fdFy4BX/G3XLa9VMuOBMYnuRAa1C3P3/Wrp8UzbVU
	69n3mhEBs0RdJU12nDASALJN9lxZHjHg9hU1omsooBw/eSlpUfn7/vlrD20brNe0v4VkJbBA/RB
	rPGucLKkCy1+mCWehLsCZiLHl2dVvyeQQuej8Tl5f50tSDm2EqZXa7kgDxGcLj9Vl3VqkMy0jAo
	mTHEXyyw/IT
X-Google-Smtp-Source: AGHT+IEujhnClojcicPbj3y6ytDrc6WWv+RwekLkEKlFozxNxVRIRtmsdedEqStzjhfQZMJDA0LXfw==
X-Received: by 2002:a17:902:f647:b0:24b:11c8:2d05 with SMTP id d9443c01a7336-290cb65c5b1mr125810595ad.45.1760934311032;
        Sun, 19 Oct 2025 21:25:11 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm68319325ad.7.2025.10.19.21.25.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:25:10 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	guoren@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4 05/10] riscv: Apply Zalasr to smp_load_acquire/smp_store_release
Date: Mon, 20 Oct 2025 12:24:52 +0800
Message-ID: <20251020042457.30915-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace fence instructions with Zalasr instructions during
smp_load_acquire() and smp_store_release() operations.

|----------------------------------|
|    |     __smp_store_release     |
|    |-----------------------------|
|    | zalasr        | !zalasr     |
| rl |-----------------------------|
|    | s{b|h|w|d}.rl | fence rw, w |
|    |               | s{b|h|w|d}  |
|----------------------------------|
|    |    __smp_load_acquire       |
|    |-----------------------------|
|    | zalasr        | !zalasr     |
| aq |-----------------------------|
|    | l{b|h|w|d}.aq | l{b|h|w|d}  |
|    |               | fence r, rw |
|----------------------------------|

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/barrier.h | 91 ++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index b8c5726d86acb..9eaf94a028096 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -51,19 +51,88 @@
  */
 #define smp_mb__after_spinlock()	RISCV_FENCE(iorw, iorw)
 
-#define __smp_store_release(p, v)					\
-do {									\
-	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(rw, w);						\
-	WRITE_ONCE(*p, v);						\
+extern void __bad_size_call_parameter(void);
+
+#define __smp_store_release(p, v)						\
+do {										\
+	typeof(p) __p = (p);							\
+	union { typeof(*p) __val; char __c[1]; } __u =				\
+		{ .__val = (__force typeof(*p)) (v) };				\
+	compiletime_assert_atomic_type(*p);					\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsb %0, 0(%1)\t\n",	\
+					 SB_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (*(__u8 *)__u.__c), "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 2:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsh %0, 0(%1)\t\n",	\
+					 SH_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (*(__u16 *)__u.__c), "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 4:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsw %0, 0(%1)\t\n",	\
+					 SW_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (*(__u32 *)__u.__c), "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 8:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsd %0, 0(%1)\t\n",	\
+					 SD_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (*(__u64 *)__u.__c), "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	default:								\
+		__bad_size_call_parameter();					\
+		break;								\
+	}									\
 } while (0)
 
-#define __smp_load_acquire(p)						\
-({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
-	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(r, rw);						\
-	___p1;								\
+#define __smp_load_acquire(p)							\
+({										\
+	union { typeof(*p) __val; char __c[1]; } __u;				\
+	typeof(p) __p = (p);							\
+	compiletime_assert_atomic_type(*p);					\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		asm volatile(ALTERNATIVE("lb %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LB_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (*(__u8 *)__u.__c) : "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 2:									\
+		asm volatile(ALTERNATIVE("lh %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LH_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (*(__u16 *)__u.__c) : "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 4:									\
+		asm volatile(ALTERNATIVE("lw %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LW_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (*(__u32 *)__u.__c) : "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 8:									\
+		asm volatile(ALTERNATIVE("ld %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LD_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (*(__u64 *)__u.__c) : "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	default:								\
+		__bad_size_call_parameter();					\
+		break;								\
+	}									\
+	__u.__val;								\
 })
 
 #ifdef CONFIG_RISCV_ISA_ZAWRS
-- 
2.20.1


