Return-Path: <linux-kselftest+bounces-31331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A1BA9729C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499523AD1EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3930293469;
	Tue, 22 Apr 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MX8rfLpZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CC82918FF
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339033; cv=none; b=F0vcEMWuG/MWnCGy7ZLCzwMC7/qSNzKXi9PT4RtZN2+hYFMkmotevK4tV8p1Oz010wy4Zvt1XbP7EyV4IHaNy3c8UjMP0/1tURJTyD4cniEkMskCj6AwDua9ir0KQVGVgOa5KcllWn8ukbAOCva9r61Fx1Res/uTIWKq+qaslLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339033; c=relaxed/simple;
	bh=V1few9iADl3Jql37d2sSjWVyST8COex3O6hgsGvnL9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WSzov7rDT1Mx65RqrQ797AnQAarC8vvTmWYn27JuGNJytoArlHQrqMIQ368pnujxo5xTJ/mnIme6ZvtCCefIOJF6G5jjVO/jhzWmOGiVrm6Q7FeXILhtSKbxSU6RjhcvVPOIZQdVSPMBt+1/4K/FSgbOHom2g3Qb6RbpWK4THtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MX8rfLpZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b350a22cso4372671b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745339030; x=1745943830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k21lSdGFw1ABvj7WqNf9xvlJy5uS9lN5lvHH4c8/sSI=;
        b=MX8rfLpZHlPbpZJhzgmC0WuqaXi5gxGij7pWSEGOirRq98iMFMu2Hv+p4PAiluJiFi
         /HcLY6neH9zdv2SLPPxxVwaONKT+i7rGXlyYE9PTb2CmODuKukgmQPz9mGpJYS0QgJGl
         btDD2N8z6z05fNwJ++UYUr5RjcvFVMYs5OMBnjShQ2kHoznC5xLTdDfb+Dh4JUZxrVG+
         v1mheup4GYh1v0IdcyeUH6ERa8ng8Bj9v6gLdDnm81UOw1rC985JT8bYBYKOC25YTNeI
         VWI0ZUKj+APOg66+a8+R3aAoA94MwiEyoBEuW3RVayt9QIBkxOZmSXejSsjxt69qiXyM
         UrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339030; x=1745943830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k21lSdGFw1ABvj7WqNf9xvlJy5uS9lN5lvHH4c8/sSI=;
        b=hQ7jMxbzGOeGDA7DTde3TSSaicCEOyxSL5aHw7XuNbbSGg6b5Lp+WHay52iR5WfIjM
         w305C5DaVyGp3xELLn9laJlxk2TW0Q0HKlixRmEc65qTyiqtwPGt6AljBGmHwtCkwEnd
         hMLDwYW3R8hFhe3a9IFu8I070vzL6jsYhzyrfmn4lNt5R7d3/hHN6dWKUztE7dy6BnPw
         /eopHwP0fbVMsbm8MelrSQwJbPU/hnnghtl6LMxaVCVZqCi4aABMS2f7IiDWisTT6ZLt
         IR79zrkrpbMprDhEp6C99nmtTl8WsAWm7ySWWAZAxVEV6XrBBtSMLJ/ZEz8Fx9iSxHIQ
         ogSA==
X-Forwarded-Encrypted: i=1; AJvYcCVpTWBGQwOw5LTwanKxi5CpZ4SqkLyyK6i24XcK7oBq0+hhsmpFs4ztWeReTIXrNe8VkJVpoJPlCUrrh4PFXpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJEIF9nWDQ9W9BxpyCStetgJwWnDnz9od01I8Xsy7EEBgAw6N
	i3oKWoiO+Gbv+WR/F7k4GsjQva7jN1KhGxLQdMd7HyAJA+OkTU89S/J7abAeEFQ=
X-Gm-Gg: ASbGnct95hKAA8VGNelJ5H2a29wmF7LafgpRZGYFHfGdnQvxE9JWINXr65ry8dJ1UfR
	DueXt9oE7wnueYGb16WwAyEBiA2ze6XTcyvK5lbUicFCZcTD5qc8CewZqNilMN0/dCZnbci+Cyg
	MoxsXxXnlBcMUy91fg0/zANxa16WQiNwk3BYxuZibcWnJMh+BA+8gk3Bq1NQuKcxxCUTGLJDQlW
	meFcAEkqs9lTHgxfroNMjHz/+s/HqAgoNSsDv8Evi8++NHl9moXSuq/kN0UU0Oj7V38rRrOBQ3e
	7NiYW7ivIO1q+lQMH/Ums5znUL+by8vu5c8XJsrBaMqDlhd93qwm
X-Google-Smtp-Source: AGHT+IGBaYB+zcFYNZod6Dyq/XeUaZqkUk/RN2FexFvjQuv/xDbjUf/BD8XILM+dfMbhssRMX5dz+g==
X-Received: by 2002:a05:6a00:b4e:b0:736:5504:e8b4 with SMTP id d2e1a72fcca58-73dc156b0c4mr22113079b3a.19.1745339030561;
        Tue, 22 Apr 2025 09:23:50 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e13e1sm8850825b3a.46.2025.04.22.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:23:49 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 0/5] riscv: misaligned: fix interruptible context and add tests
Date: Tue, 22 Apr 2025 18:23:07 +0200
Message-ID: <20250422162324.956065-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes misaligned access handling when in non interruptible
context by reenabling interrupts when possible. A previous commit
changed raw_copy_from_user() with copy_from_user() which enables page
faulting and thus can sleep. While correct, a warning is now triggered
due to being called in an invalid context (sleeping in
non-interruptible). This series fixes that problem by factorizing
misaligned load/store entry in a single function than reenables
interrupt if the interrupted context had interrupts enabled.
In order for misaligned handling problems to be caught sooner, add a
kselftest for all the currently supported instructions .

Note: these commits were actually part of another larger series for
misaligned request delegation but was split since it isn't directly
required.

V2:
 - Use an array of struct to simplify misaligned load/store selection
 - Revert use of irqentry_enter()/exit() to irqentry_nmi_enter() for
   kernel space.

Clément Léger (5):
  riscv: misaligned: factorize trap handling
  riscv: misaligned: enable IRQs while handling misaligned accesses
  riscv: misaligned: use get_user() instead of __get_user()
  Documentation/sysctl: add riscv to unaligned-trap supported archs
  selftests: riscv: add misaligned access testing

 Documentation/admin-guide/sysctl/kernel.rst   |   4 +-
 arch/riscv/kernel/traps.c                     |  64 +++--
 arch/riscv/kernel/traps_misaligned.c          |   2 +-
 .../selftests/riscv/misaligned/.gitignore     |   1 +
 .../selftests/riscv/misaligned/Makefile       |  12 +
 .../selftests/riscv/misaligned/common.S       |  33 +++
 .../testing/selftests/riscv/misaligned/fpu.S  | 180 +++++++++++++
 tools/testing/selftests/riscv/misaligned/gp.S | 103 +++++++
 .../selftests/riscv/misaligned/misaligned.c   | 254 ++++++++++++++++++
 9 files changed, 623 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/misaligned/.gitignore
 create mode 100644 tools/testing/selftests/riscv/misaligned/Makefile
 create mode 100644 tools/testing/selftests/riscv/misaligned/common.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/fpu.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/gp.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/misaligned.c

-- 
2.49.0


