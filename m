Return-Path: <linux-kselftest+bounces-43524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEDFBEF3FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41C004EB578
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 04:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559E12C0263;
	Mon, 20 Oct 2025 04:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HcriZPmb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C929D270
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934107; cv=none; b=k2JPWjNmRENzd5hbiTwql/BWTB49I1Ei8iZM5zY0DndHCX0DUz6TpOYHVgOxS36anCgMn97O0xar79Ou2rnv6eSeyHfbpo3PKcglNJJEj63UkLGdRthxI02dEHSvREq6BfFeUKAJ5eB7TNSbyq+PV+XYZVpPkn1NC8fOYh30VD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934107; c=relaxed/simple;
	bh=HFpqts/W53QUbSMz1faFreS+L9DMcn6zulFxd1eY3xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YINwZRLnK43lQR31xE58VH2XmePOgQKu/3jvgfJ6Gj1aNeiXNrThXta9KOSnIzSwpRkMhN4kJdl/39ZHQrvIfSFFfu3jlVUdnbIrnilCYUlttgyZ3SrdEdRpIi8w9TEZON2sLLPnGZJUyPuM+6iwpe4w5h135m3ywsVbElB9evc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HcriZPmb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2897522a1dfso38754935ad.1
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 21:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934105; x=1761538905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+193yncmANzEfIfweyuJi14B+CiP/3dMuVzUWsZjMz4=;
        b=HcriZPmbGc6f5kx3AsrQgXFgT448MrrhfzeCGYAuyn8n6IYSMx3k7tG+VKGVUvTGCe
         pTCr2IblLfY5FGJAv64N3efjzUu6FalM6V9gEpGN87M7o2Hj2fxvBx49ZVF71S4qRAkP
         PygZVFruklfZRdsEjDvw+ugIz6gyewARzconSSSe0o1wdkvFB99ATFsfxdn+1UhrWKN7
         7jvBzlnprrSzQFDBensWEOLKXq7co99z0oBI4oEJGwy97g4FJ6U8J4JJpVGt5fdW4M+9
         1tflyTNA5B5R1cCQT9ciSdedexcD1MH4jhF6O4VE1ur6I2MZKuHvU8SxjxYoqcIJ56Wz
         9H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934105; x=1761538905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+193yncmANzEfIfweyuJi14B+CiP/3dMuVzUWsZjMz4=;
        b=avlGgbWT2p26l3xKFUpNwaEHcRaBVDJB4LIy/Wf/NZqdXgrhuyblZz5yPdH0jPncxM
         kP67llxLSeFZnwtuLrLcOOmZ8/WoKie7jXwHaWXXjs7GmgYblLQP1v+LwEkSLUlRs6Oy
         mPJ+Hp3W1mAggN1DQsHHhlDk5OCTiRJLhwnIwZ6B3Z8/Vlu+1otUfoWBPibnkPWeiHnS
         97/vc3S+ZPZ2cFnFWr6stj8Tw1ugkjBN2YWLb1J4hQ9jTTrWBgijqC1L/9RzMynyPLGl
         X0IO2QCcbISVvL2Gu6RCNwYyxublDzLM7SqUTi2gvZqiI+XnT6rTQMqg6Hcz5YT//xm3
         zSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl18bASwFRKBAQALvY+NljcSB8zpof9BB0b8EFAw2lSP/uAQaLvAiH3wXtfWqbdyTHJEuceFiO7a1+eRfrIeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx74q9xrqgxdpiwh+J3oPOEiX103cqTM+aXT3t5n823tcKYquj
	O1jsWqWgVnsoAB6OJKXrAQwq/eAY3xqrUl/p8prpN96EdzsvY2pvQ+CaEjfjf17pBNQ=
X-Gm-Gg: ASbGncs8B1AewcotUSxfvuUUR/4HVmyz/0xBhSH2gY/GpHPYxlark/P4yN/X0gv05yn
	az4HamvSigwNg+oSzRXtxEt6bq1JOzvF3d8dvip9Tg0IQYF7HJtu4AjG30qYO1z0dJnzXy2n+HU
	MXlp83zwPV5QFOq9gWzYtECS/52NN9Q0vUxzi5gJO3H+rUjPzKNLFffXHrBJNzSPvRY0IkxeYOl
	JHcVshITpCxplvRdtwdYfRYJBPP9KwzcjE2VfajJ3XpXPBfbLpbYiNob1BESQHyxbKunLh2qF2O
	f3tKhVQtFArafZr53+ADVHHqopm36+l3MJQc8qouRvxIQgwvmtBQszAfceBMwgBcetUQv7mqChx
	2bFEKXxLp5oFP1nfmAenwBlPyUyvOELG3S+WKrsplfOvs0ePMYXzADEfLHGzQY8Xr1tqxa3lLPr
	MghkOrC2ccuHN2bK1kO/xGlRPDVGeiK5MuQrLZ3Sg+qvkfB2rrAKYQeBLfAqABiOI=
X-Google-Smtp-Source: AGHT+IF2KqRso1vGWBuxjKtXDzGr3i1rYvJFvWFqIw1C4cToJJg4q9dybEBrOykVwphfwE8jll43DA==
X-Received: by 2002:a17:902:e5c9:b0:273:daa6:cdf9 with SMTP id d9443c01a7336-290c9cdd599mr133996615ad.22.1760934104704;
        Sun, 19 Oct 2025 21:21:44 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec14e9sm68762035ad.9.2025.10.19.21.21.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:21:44 -0700 (PDT)
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
Subject: [PATCH v4 04/10] riscv: Introduce Zalasr instructions
Date: Mon, 20 Oct 2025 12:20:50 +0800
Message-ID: <20251020042056.30283-5-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020042056.30283-1-luxu.kernel@bytedance.com>
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce l{b|h|w|d}.{aq|aqrl} and s{b|h|w|d}.{rl|aqrl} instruction
encodings.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/insn-def.h | 79 +++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index d5adbaec1d010..3fec7e66ce50f 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -179,6 +179,7 @@
 #define RV___RS1(v)		__RV_REG(v)
 #define RV___RS2(v)		__RV_REG(v)
 
+#define RV_OPCODE_AMO		RV_OPCODE(47)
 #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
 #define RV_OPCODE_OP_IMM	RV_OPCODE(19)
 #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
@@ -208,6 +209,84 @@
 	__ASM_STR(.error "hlv.d requires 64-bit support")
 #endif
 
+#define LB_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LB_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LH_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LH_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LW_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LW_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define SB_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SB_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SH_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SH_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SW_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SW_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#ifdef CONFIG_64BIT
+#define LD_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LD_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define SD_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SD_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+#else
+#define LD_AQ(dest, addr)					\
+	__ASM_STR(.error "ld.aq requires 64-bit support")
+
+#define LD_AQRL(dest, addr)					\
+	__ASM_STR(.error "ld.aqrl requires 64-bit support")
+
+#define SD_RL(dest, addr)					\
+	__ASM_STR(.error "sd.rl requires 64-bit support")
+
+#define SD_AQRL(dest, addr)					\
+	__ASM_STR(.error "sd.aqrl requires 64-bit support")
+#endif
+
 #define SINVAL_VMA(vaddr, asid)					\
 	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(11),		\
 	       __RD(0), RS1(vaddr), RS2(asid))
-- 
2.20.1


