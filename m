Return-Path: <linux-kselftest+bounces-7559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6042D89EE8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE367B24704
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F615FA6D;
	Wed, 10 Apr 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="H0S06gwr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84D15EFC5
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740288; cv=none; b=ip1c1mb/cxU/Ke4Y/Cd2Y/hc/L7GzTtUtpbaeokHIsI6f6R6JMtK9qZE2XYTNuQzuMkEjEIAROSjoACKw77c9Rg9+sEie6mz6EQLngmHcK9dsEOXM1p4/aZ1A5rYmeoB1aygq5A2BRbieOL914LWOE8ZF3KgJRQ0IVrLChTj3HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740288; c=relaxed/simple;
	bh=dIKOQ7+8Gx69BlGHAWDa8bC1hIUZKhgNODc1wgGNviA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSNmKcWfiEom0uTJIHIOXlxFu+pdu1eBH0wAdv63CSTZ/o6lTIWTdcdy+RqD3R0yiiVY5AbSaunHyacem+h52jaxORoupOV1lkr9L7+wk6EJ2sU8OeOx9okbo5QlL8/R34EccYS8CYHYYKM9sI/F8f6VFlQ6iUoU/LZl4Hd899U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=H0S06gwr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d585c60bso1576423e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712740283; x=1713345083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKIlCd7jL5ol5qvLgWGPfJLjgIu96MFC3958FRvJI8w=;
        b=H0S06gwrd6ANiW4jrbHvPyJjGiOIaqcVz4LTDzaaXw9vRTwJxBwCfRaGBDPwmq4Yh1
         cBUW/u2wEhyEo9Jjf0PG0vUrX5/JP9IR8f0e77aLywkf6tipp3gm0/Neyknnz1mRcygn
         wcW7z1Jt5Moi45dYyMjMdMIP5X4jTjC6YrgUu9d2Wbv4MJgq+GRzDQ7RQ1p0GBl5sFbN
         HYLFNUl/oZWw3kGA35H0eIAj4ljEzRdZHtyEKD8UnuU2xUBtxUuddWs+BoSNp4XZFUXt
         GrHm/05lsIvlPjaczukw+t6PGpG8GRwJGms9l/cS+ioiUrohW8mvEjAnZybyHId1GbdJ
         5/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740283; x=1713345083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKIlCd7jL5ol5qvLgWGPfJLjgIu96MFC3958FRvJI8w=;
        b=pbK8W9a5kDcvxLce2W1nKmAUtq/nJlnHAbXFrupE8yxTzjyLGkS58GDG8cdiKIdZFu
         h5QZyT28etd92LXqwkby9BvHSZ3cuZgLA7mbjbpJ62sm4+jnYHlqJp6ZhGxPnr4Qcjk2
         llAPnYYfsvcYfnIcigVETbNpe1dOr19pi/4U7ktEzXNWRrPIS/ZcP4HzOrs2uGpRtkCW
         HSNmFoCZNOEk0ZsUaURP/UeR2Fp5NVcvw5jrLUSCLvvJbvpLQl7gJJM12aK/jGwKUc0B
         2PfQHKkiW3eY6r15w1EmlHGK85FpBu8/V9Cb5Ht1AVRDb3gUksr850U6XAApQrNSYe6z
         bjxA==
X-Forwarded-Encrypted: i=1; AJvYcCVL/Hw78HEtzEArLPXEY2SMLIveLBpFku4Hz5d4edHynqfuTBSRAzQ2A/ca+kpA6R5DgzgbPHkdl79pUC0aD+f/d4FOtwNJjp0Pwj6EDcms
X-Gm-Message-State: AOJu0YyTnagdpb3aDOy9jt6YbpLcKCIF7ECNs6F1vT9j7FV3tg2Au3bq
	jgRnqnz5lamJX96uPRRf4dWgOwYP0GyUYE8BEi6YS3h9EfeoB+vdo479geQa7gc=
X-Google-Smtp-Source: AGHT+IGArQ/ya3SIwEsTsgk2V3XdyzaxCK6c7Q9P5Y6CwIgF+pnuGurqpRxGE7Q7fP5In4aquwsCLQ==
X-Received: by 2002:ac2:484a:0:b0:513:c1b0:dcb2 with SMTP id 10-20020ac2484a000000b00513c1b0dcb2mr1173103lfy.3.1712740283581;
        Wed, 10 Apr 2024 02:11:23 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm9079086wrx.93.2024.04.10.02.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:11:22 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 10/10] KVM: riscv: selftests: Add Zcmop extension to get-reg-list test
Date: Wed, 10 Apr 2024 11:11:03 +0200
Message-ID: <20240410091106.749233-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410091106.749233-1-cleger@rivosinc.com>
References: <20240410091106.749233-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Zcmop extension for Guest/VM so add this
extension to get-reg-list test.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 61cad4514197..9604c8ece787 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -59,6 +59,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCD:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCF:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCMOP:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFHMIN:
@@ -429,6 +430,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZCB),
 		KVM_ISA_EXT_ARR(ZCD),
 		KVM_ISA_EXT_ARR(ZCF),
+		KVM_ISA_EXT_ARR(ZCMOP),
 		KVM_ISA_EXT_ARR(ZFA),
 		KVM_ISA_EXT_ARR(ZFH),
 		KVM_ISA_EXT_ARR(ZFHMIN),
@@ -957,6 +959,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA),
 KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB),
 KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD),
 KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF),
+KVM_ISA_EXT_SIMPLE_CONFIG(zcmop, ZCMOP);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
@@ -1017,6 +1020,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zcb,
 	&config_zcd,
 	&config_zcf,
+	&config_zcmop,
 	&config_zfa,
 	&config_zfh,
 	&config_zfhmin,
-- 
2.43.0


