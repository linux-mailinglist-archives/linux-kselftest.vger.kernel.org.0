Return-Path: <linux-kselftest+bounces-44045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E7C0A011
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 434A74E27AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5246529C33D;
	Sat, 25 Oct 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3EsoE0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225A280A20
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426431; cv=none; b=lWQezBcGByu+c2zmmSmL/kqTVZweP6OWeY7Agy6rL8txkpA9JigY/9V7bBqRRbOyeVcTqwe+dWLJ7THxq5riOC5AQ0CzrG0eY5hlDiItvVn33aTQrdpuN8fb/sSCuwDjZ18ejCiCq7h0NdYpvm7SlasOFvOs0YBcwB9vtQ2wqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426431; c=relaxed/simple;
	bh=8RdkWogzljVCUUb1BMp2fjK1Pb4SC1Y3SKwML5scyPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y19QabA7AypZsYZGI6KsFuUdiUBdoNCym2JM53Opw8RdiV/n3G7UomLMzmmcDbEXzpgFp164LCoPY+XLq2nyV5AjF/rV5QIwTCy5FqEWC4SLlyfoSag1nHDXbpTO/t0LJbOUrTIiitY+H+mTRyhUqIkgVSo/Nruo8AT4wSiLMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3EsoE0t; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so3949079e87.0
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426425; x=1762031225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrTy/fULfWQ/AuOkkZeBntBWMGO07F8iRNTCWK3FE8U=;
        b=C3EsoE0tq24VGEPTsvjKNpiQ4VWxxhLLZ+Y/OTYTSNWj6tpbUegOy/ZDJ5H50a27uS
         JhBdWZxnFaXtjpNLXSy8FJexItswpo03O6sidovAzTISuaMn8Z/K600mLl216+DUIKO/
         Sg95COAcizDSXDJXWQ8UiF0O4h/5Vu2Vhn5p4uaKi7igrF3+rHVdDpOz8bAAHosX3WFd
         YeQe5MKCzfl7F/2vhRKU21IHd+pk2RJ6JknBRStFoJy1UwUehLmWQEevtluyfA9jqRz0
         JXmbhMclKw+3WSQ8iuEAOR3n0CQna4qY+EccDu2jkjGSgXqYUkb1oKigWjyOmhSDRf2g
         oboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426425; x=1762031225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrTy/fULfWQ/AuOkkZeBntBWMGO07F8iRNTCWK3FE8U=;
        b=XApd/18GiK1Gh1zRZkMrtE8ngmvH98LTlHlDgQj+hNteltuMAcu4zSJjYjNGmvfTF0
         2GMIutiOvvvT2w/c6Ca0IFoWZVx0RRohQZ5oiwsFJ2GJIA++EQUkI5/jl0rrEBq0yNfN
         UKcfTMGevjeX2Lz7DiV0lbR7YvZpv6NboIv4nRh+FVVq4G2pNWCf0MYxHkXULlRSGUGl
         x5ZY5G1HFak/O14TiS91G7Uv+M+HSjm1N915oRQQufJF8oXyagGQWLKtJrGab8Onov41
         h/1SHGI5OD0QhBO8E4nHTk3ZNllvesztdF5TUioWPcFvYktQ+n3sbspsg3SRrn6Sm04d
         B01w==
X-Forwarded-Encrypted: i=1; AJvYcCV3Nx9TTsuxvUC3h2l5mfg3hXQuJyvjP1ZeTmuR+BO8fFVjJVTODzpBFLEUnfHTtL1+OaL0jVgKWJG4H1qk5SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaGMrzZAhNhk6W3dP7rf1IofM0TdFpRnjz2+fcddcRP38trwV
	JEmcGp/365jfBmHEb6AMLCtVbfDD0NWadcAS2kTG2UXtwuSJCov0fRtp
X-Gm-Gg: ASbGncs0fQQ31sH2oU3lgxXWKb26V5gNLwFpE+bCnYQ/UUorSeYw+qSAZbP22SFbpUN
	mXpO6wWyePvVr/pAym9+JDzh8fUXkVsQJACh5ck96Pdt+v6X6Rl0FSBvzW92qLamyvYiP+LRkVc
	3ZgrSxwxh2stR1L3d4aIuq9QKLCYXmWHvZl8LHHQI11giB+fizPHXGFIR/H81aKpRpoUWozW+gI
	PBESwgw31rPC5ZxFkPWgxng7a/k1aKSZ16x0ZZHPxQ+6KQqTnz2Mk4iVJchym6oULuDXbni4LMD
	CUtGDDCnMPJG5oOoPOAJWVOLW6oo1R+7ABAklRx7ioW1T4Oha0E76QlM9ofJiZ9Jg5+gABtlyIy
	IzVIR33Cq8h+vi0d5CIoOdN2sokZyDp4YQTrNAMCzB4BVZ8k3Q4WGwYK8XH2K9XWv+lw=
X-Google-Smtp-Source: AGHT+IGVmkvQikvMTRY2P+CBsoQX/dtGCo+IL2vMn6AXhs8QRoo32mt2Gun7dSC5qD6SHJZx3Jm6ZA==
X-Received: by 2002:a05:6512:3da6:b0:592:f7b7:2f6b with SMTP id 2adb3069b0e04-592f7b73090mr3904766e87.4.1761426425215;
        Sat, 25 Oct 2025 14:07:05 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:03 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v3 0/9] riscv: vector: misc ptrace fixes for debug use-cases
Date: Sun, 26 Oct 2025 00:06:33 +0300
Message-ID: <20251025210655.43099-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series suggests fixes for several corner cases in the RISC-V
vector ptrace implementation:

- init vector context with proper vlenb, to avoid reading zero vlenb
  by an early attached debugger

- follow gdbserver expectations and return ENODATA instead of EINVAL
  if vector extension is supported but not yet activated for the
  traced process

- validate input vector csr registers in ptrace, to maintain an accurate
  view of the tracee's vector context across multiple halt/resume
  debug cycles

For detailed description see the appropriate commit messages. A new test
suite v_ptrace is added into the tools/testing/selftests/riscv/vector
to verify some of the vector ptrace functionality and corner cases.

Previous versions:
- v2: https://lore.kernel.org/linux-riscv/20250821173957.563472-1-geomatsi@gmail.com/T/#u
- v1: https://lore.kernel.org/linux-riscv/20251007115840.2320557-1-geomatsi@gmail.com/T/#u

Changes in v3:
Address the review comments by Andy Chiu and rework the approach:
- drop forced vector context save entirely
- perform strict validation of vector csr regs in ptrace

Changes in v2:
- add thread_info flag to allow to force vector context save
- force vector context save after vector ptrace to ensure valid vector
  context in the next ptrace operations
- force vector context save on the first context switch after vector
  context init to get proper vlenb

---

Ilya Mamay (1):
  riscv: ptrace: return ENODATA for inactive vector extension

Sergey Matyukevich (8):
  selftests: riscv: test ptrace vector interface
  selftests: riscv: verify initial vector state with ptrace
  riscv: vector: init vector context with proper vlenb
  riscv: csr: define vector registers elements
  riscv: ptrace: validate input vector csr registers
  selftests: riscv: verify ptrace rejects invalid vector csr inputs
  selftests: riscv: verify ptrace accepts valid vector csr values
  selftests: riscv: verify syscalls discard vector context

 arch/riscv/include/asm/csr.h                  |  11 +
 arch/riscv/kernel/ptrace.c                    |  72 +-
 arch/riscv/kernel/vector.c                    |  12 +-
 .../testing/selftests/riscv/vector/.gitignore |   1 +
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../testing/selftests/riscv/vector/v_ptrace.c | 737 ++++++++++++++++++
 6 files changed, 830 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/vector/v_ptrace.c


base-commit: 72761a7e31225971d0b29d9195e0ffa986b77867
-- 
2.51.0


