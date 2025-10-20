Return-Path: <linux-kselftest+bounces-43528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D1BEF43F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B33D188B592
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 04:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8862C11E1;
	Mon, 20 Oct 2025 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HS0Lm+Hu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E02C0F89
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934339; cv=none; b=MSvfNzTIk/VvCfW45cDu7fuJofrzFxcbKr8j6V0dHDLWghHGoz+LbX6HTN6iHlNKD8CFXS5MD3Fv2fH4hrbjYpeGRy0ILuXpwAzBUmJGSjpW1W2pnk84mkuzifO7iNRmKMFFGyaSAZlxKEqZTWwmCb4OdLmoiB/t2DcT17NbTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934339; c=relaxed/simple;
	bh=8hNEznhKZts7nsJ+/Md1hqEm+KtJGCPHkBh501JLIEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gY8s1GY6P2PKY2PLFpwZxq0vxQyJNgZzGRFqZDWrYE7hcYc6VarHj7JtbLxsguqqDF+Yn+ih2vYfyzlNo6P6ZzBpEKwPdQ5Pz+4e6yLZ6MHfDToEN/Hg7PiZOp6V3Yv7P+YD6BRD7JpoGbE/OxNFMqN9lbY6LFACMMJEBRLyImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HS0Lm+Hu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b593def09e3so2615791a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 21:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934337; x=1761539137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dx3bjUZwp+FDi5HGHRvFmbVTrXXeKiS0FzRK/EiFHI=;
        b=HS0Lm+HuTSD4i5hvL9CQ9ytADQXsRFR1cPjHPajiubjud360Fkx1TcXGaSjzi9FLw/
         wwWjLjixKTPC88RV1bQS0x8JYG1IIyq7pcyxinNdrUmzfbuhoc2MqnO3QUZ0JuxRV3+Z
         ONHTmMhE1UDPGordAMVX4PXlkCycZrSivGHvKydjA24Mdj9r8cH5Ks1/3nh9L/Ak0WjK
         /LLN/Z3YeH50Cg7s4dHje39XCABV9LxI0HtgThtWeSthEP0Xhge7XlMraNyb5eJpFWXP
         +YZn9DewDgzxf6t7c19bdAgMlh+1qgioV9fvcFjWpLRDZjWXumHdUov68A9ZKhfZKKUK
         3GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934337; x=1761539137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Dx3bjUZwp+FDi5HGHRvFmbVTrXXeKiS0FzRK/EiFHI=;
        b=sn3H52aVABk18VXaEe9z5Uu9ARWUWzLSPHMFPre9D//V+WIJACnbhA7Bw42tdVG05K
         W8rCJAFKHCjruPyQ8TYyY4lY/Z/NI2v/WtoSankAiqcZGoUOUkgsLscIGeNMxicOH6V4
         Cu5WeRuCEB7NX6a9iewxRQLsvm7trUN0dmPkjuVAtJjRerhE6TftMTSclNHYJE1I+rkD
         wWabTPBfBsvkpCy5rBArt1jPqdPstjQAL9oe0uBH50bSXBUIRBhdykzOUiWCcaPK9Aeo
         Eb2C8ea6u9i8Q9h1se+xgh6IrjL67Z8GOlp/0hWwQV/x3vCjK6fNhmfHDBo4fyu3Ag+f
         Xlgw==
X-Forwarded-Encrypted: i=1; AJvYcCWw+CscnwpkihdtgSXem2trcn6wHzxjdXa0Dz7RYVQYp4vhtHrqWCyxgS4kvImwX8eM08eZrgHJVyG8hZohg0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAem+2IVyZ2iEW48FP6o/7ZPDZPTMcFm/v4TM1wMsmYIA6NJCW
	qaw8E9534A8Bv9UMKkXzwqi65D0AjT0hWJ0GN4784H/wqoxwuNAmUPDLSfiaqJ07C4c=
X-Gm-Gg: ASbGncu+JsHJ8VvKq/qe3eFLkC8Dc7DgK8Q+kKyZ4DyTIW0YbFTWRvNwSGWck8Thtzr
	c3Ie0dHXO+MlcjbVH0bF6XnWUAiSleZyuW66uP0M5i8hR7w2fz7IHGxGK0aQfyk6fifVAJuIqf8
	m9P6rni3TZSHYbH2II4fHQVprupqGjUITNgKJPUA7EFJEkKb7r3sITqv3O+dFPcUV/M6IorGLlr
	Ycct5kauRQLIO9eaDpIgbGS7yl3cXMSsD69aNR3YwAAmxlHGdZAQa65nYKDr8KbfXQAwCqdDTXJ
	s/meQiGLfdCTYv6ADUGhSVKc4J9uEgSRwNiepUoapBfjUmAumwRkrpc2mMquKAtZNdGUeQBO8Bt
	ljYnTShNFs7YiQcHCtsGTv+IRA3k1QFSywYPCWSG1ksvYQ73Vu9bPoCHXNLm1/WxDrw9Rjl3Sk+
	2ATdv6oiMxN4xsDPIQY10LLbQuo81l4A0A4/C5dCGT5jwjukDnXysWyIxy6/StHc4=
X-Google-Smtp-Source: AGHT+IHd1kF3POpTVpfQwriGdz/AzJEchqY/kwdyjm7t3VNt+rro2wzxG/dmQOsLktQwlvjqL1Trmw==
X-Received: by 2002:a17:903:b48:b0:290:29ba:340f with SMTP id d9443c01a7336-290cb17c05fmr150708105ad.42.1760934336328;
        Sun, 19 Oct 2025 21:25:36 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm68319325ad.7.2025.10.19.21.25.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:25:36 -0700 (PDT)
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
Subject: [PATCH v4 08/10] riscv: Remove arch specific __atomic_acquire/release_fence
Date: Mon, 20 Oct 2025 12:24:55 +0800
Message-ID: <20251020042457.30915-4-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020042457.30915-1-luxu.kernel@bytedance.com>
References: <20251020042457.30915-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove arch specific __atomic_acquire/release_fence() operations since
they use fence instruction to simulate acquire/release order and can not
work well with real acquire/release instructions.

The default generic __atomic_acuire/release_fence() now provide sequential
order via 'fennce rw, rw'. They are rarely called since we use real
acquire/release instructions in most of times.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/atomic.h | 6 ------
 arch/riscv/include/asm/fence.h  | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 86291de07de62..6ed50a283bf8b 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -18,12 +18,6 @@
 
 #include <asm/cmpxchg.h>
 
-#define __atomic_acquire_fence()					\
-	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
-
-#define __atomic_release_fence()					\
-	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
-
 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
 	return READ_ONCE(v->counter);
diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
index 182db7930edc2..9ce83e4793948 100644
--- a/arch/riscv/include/asm/fence.h
+++ b/arch/riscv/include/asm/fence.h
@@ -7,12 +7,8 @@
 	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
 
 #ifdef CONFIG_SMP
-#define RISCV_ACQUIRE_BARRIER		RISCV_FENCE_ASM(r, rw)
-#define RISCV_RELEASE_BARRIER		RISCV_FENCE_ASM(rw, w)
 #define RISCV_FULL_BARRIER		RISCV_FENCE_ASM(rw, rw)
 #else
-#define RISCV_ACQUIRE_BARRIER
-#define RISCV_RELEASE_BARRIER
 #define RISCV_FULL_BARRIER
 #endif
 
-- 
2.20.1


