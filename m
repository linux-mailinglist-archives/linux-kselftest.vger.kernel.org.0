Return-Path: <linux-kselftest+bounces-43530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC2ABEF4C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2166188A9EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 04:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABA82D5959;
	Mon, 20 Oct 2025 04:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NSs58go0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876EC2D592F
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934559; cv=none; b=I9TAM0JuCmVCIkrOrmkncTSFZKZy557gzeB59QEz+011Q1dKbI7o55AVRtYUENmb4yy2PBAJ7d3O+zKB0uOL47tDjD7etDabvd05kpvA24YQLvCRrYlsA9t/oNAomTmWxSnyvkuLaI/XYWw23WbOD+TlzLqd4jRSaI0spqz37Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934559; c=relaxed/simple;
	bh=c191XMGekjwyT0k1fIaZ95ZvPfNZBLAH+N5NWD52kwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3LlrsXZiVUy+9x9yqoGQOLpVYKK+YhfLFfSutkMF/TWX5C6rFseN2TcLBuJlROol5zt7G6Nt9wrvPZU7vEjw1Ux0NNdWuqXVtY+7YBaNBpAIZdajsvrBXNt3oUYLM9jEY0Ol8BtnZoQAsn9i3HOBwXH3ZM1tdqXPoxe72Wxdm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NSs58go0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290deb0e643so25032385ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 21:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934557; x=1761539357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/wZtJxRjsPgsFT1TZQP06vJqUDEl57iCFv88CuZkP4=;
        b=NSs58go0HdBRQ83pu6c38OEJRSDMhRpsd+KZ2YVjUlboshhfT/vxGd/2WLOMHiKz0v
         0AogOMMMB4f0CDGLoVD4P9emzk6WlUT9U1UtCMKz8FAEVcPifE4x5uPWzdE4WqaPYa5G
         CleVhyKg/Cna92SjsvQezDjAyGaLRsjr5nxdzmc1nT6nYom6JJZvNRtnBu+nfRtcVGHX
         Y52Rmcaqt0eEE9bfrivHoDfP2C4US5v0vUq3THvEBYWZiOaVBGLVdP+vLIXjtHa2lj1K
         6U75MmoNuW5JzafRxxBVACIFaAlWuUMIZSJkdilwdiUFGWQpD3XPYc9EFjQwUy6M8EAE
         kyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934557; x=1761539357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/wZtJxRjsPgsFT1TZQP06vJqUDEl57iCFv88CuZkP4=;
        b=k3QT9IY1iwDo/B8a7M+VBDbC8GQIcRnNGaxF4OZgBF3GgvjyI31w6OP5G0Rp88XLKF
         BOMHIGbrgbQnkXrcy/bPJHnl8l48TIj4THuwFZ5TbVH/mqs8plxTuzSJbND07hymCpVm
         3jHpj+x9K+/gupzlglbT35sx6eXHlR0baOujJ1dEcFOV3+FmJZ9AVvcDLd91JhOrUv1J
         i6v0lj3QV9U+ZdGs43JSUCksB7dVYadw79N56H8H3RdGMK16crPg/cekM0Hj4Tg85ku5
         VPsWS6TgyLB9ihZSZ+a9GLOPNhUAvABNOZoe4Z9tfp5jTf5aNmU4MS8Ji64nMNyqwh1p
         WLYg==
X-Forwarded-Encrypted: i=1; AJvYcCUjAd738mr4/zNZM1HmaECVzruohBVqV2vkoB9KkauQQT4HDVTCI4XiCYNyyMZjwIGktn/Y5UFkxgoYnJTGBh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKN958tdRMwwMVE/pA6NvIpvp1FjUxYsu9TaU9FzQy0V5CSMoJ
	/ilmAmCkHDLjdk6V/H/IEhQBSBjURd5wnIBmgy3ASqFzAnPpBwQQ5RZwlVdy6xQQm28=
X-Gm-Gg: ASbGncvRighGtQGVlE/19AXg5qp7QRGYU3UlyfWMQkOn619WPkIYCx+pOQKFPl6fMtT
	GDN54K7W5XPb1EcXbXkKApkWh6WkB7rVBtwQV6PcA9wcfXmogDbs3rZwkmtcsQZEEUyo2TVJjki
	AICm7ryAgrPGTKMqQV9RgDrdYsQUbVLMtpJj6pet+vTtPcO7qjWeJglboDlt6z5B8RhfP/s1QTH
	yNt0L2shCbRMID+y9I3jSYKwGjfw1Exp6kC6Wx1/f5lexqFuEVZo/1azHPy/q7jgfGYlI0gB1/6
	komnjb+WE0PDgwp6H+xYNLjxhD7YUVvmVpUV4QaVFO3QLHxf4jwlZ64ZiI1Bn5ik2Gzl12/6lPs
	0Nw4Q6flavYnKvzH9etMs14heAZJBtNRh/q8DH3RoZ9oEEFN28KkR+QjTDE1PKVl4xafREf3pfR
	0CQ1aUIZpXbbZT5ZAXi1260fm56JWKbtn1SmWKJOzgyFZE2beRpJrTekH4+MTfyOI=
X-Google-Smtp-Source: AGHT+IFpyzb2lc+FEvYmYTlRzjGRaKAbU2/1KopbwUla+EaFbZIWmZ4VSEnrtlloLabkn4dzpBObsg==
X-Received: by 2002:a17:902:e5cf:b0:290:9576:d6ef with SMTP id d9443c01a7336-290cba423b1mr160239305ad.54.1760934556712;
        Sun, 19 Oct 2025 21:29:16 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b35dadsm6932872a12.26.2025.10.19.21.29.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:29:16 -0700 (PDT)
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
Subject: [PATCH v4 10/10] RISC-V: KVM: selftests: Add Zalasr extensions to get-reg-list test
Date: Mon, 20 Oct 2025 12:29:04 +0800
Message-ID: <20251020042904.32096-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Zalasr extensions for Guest/VM so add these
extensions to get-reg-list test.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index a0b7dabb50406..3020e37f621ba 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -65,6 +65,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZAAMO:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZABHA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZACAS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZALASR:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZALRSC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZAWRS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBA:
@@ -517,6 +518,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZAAMO),
 		KVM_ISA_EXT_ARR(ZABHA),
 		KVM_ISA_EXT_ARR(ZACAS),
+		KVM_ISA_EXT_ARR(ZALASR),
 		KVM_ISA_EXT_ARR(ZALRSC),
 		KVM_ISA_EXT_ARR(ZAWRS),
 		KVM_ISA_EXT_ARR(ZBA),
@@ -1112,6 +1114,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(svvptc, SVVPTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zaamo, ZAAMO);
 KVM_ISA_EXT_SIMPLE_CONFIG(zabha, ZABHA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zacas, ZACAS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zalasr, ZALASR);
 KVM_ISA_EXT_SIMPLE_CONFIG(zalrsc, ZALRSC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zawrs, ZAWRS);
 KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
@@ -1187,6 +1190,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zabha,
 	&config_zacas,
 	&config_zalrsc,
+	&config_zalasr,
 	&config_zawrs,
 	&config_zba,
 	&config_zbb,
-- 
2.20.1


