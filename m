Return-Path: <linux-kselftest+bounces-28103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED3A4CECE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 23:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3524B1898093
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF74323F272;
	Mon,  3 Mar 2025 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eC5Ah8SC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524123956D
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042395; cv=none; b=N1c+9ROmyQFHSZsA/AGUtfXgYuG+G5/YBveVp/UlKPbCeJRRjp7b2bqRRXohCjQKWE6i0TG0jMpc/YK5aNMCaNI/Juj88yYfcAeK9CChXlRCJtvn/o/Rdx6guc8B2m4rs09ysoC0HJkB8yyzAWaKlbUr78Y8sZrCuXxTURwjZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042395; c=relaxed/simple;
	bh=/5XukNlXJKyGVREeQdU7wG2r6Y2lbVhDem2XgJQlNlw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CnTc8cudYWiB3nY027wWQDSmrMeoGlsAqPDN30OOvV9AF7AqG3FJ+t11uMf2yRoOeg9Ep2hH/pizIE/F5h1w+Wd+5ldBvvWkwAUifolJ08rYF5pD10EGrHFiN1RC0lQc1lOEgnbfmn8j9baefkaY08vu1Svn7uSpszqyhvM6uQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eC5Ah8SC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22113560c57so95207995ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 14:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741042392; x=1741647192; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHRREGcSp2krqTtJr5eO01PBlpy/oFOdFDc6Qvhwm80=;
        b=eC5Ah8SC6TMYOUVmlaMcM1AwBDdWEVI5AmzthZHRqMyA8yy8WYZ5ktV6BBKAEeRCR6
         rwbNySYdv3leiCupxi9m9pMANdzLBLvC1a40wJzax/uSuWqf3Z5Xc2jKimK1QSKVLKC4
         fALS2U97NGJHd01JfqMxqQQ7LZX1q0SFNZMunQyerZp67EOQj2BetMoCYgaVrfGwWOCK
         RqUNunYS4RLoilcVkVvtbnKPU2vCB7yP5MrLkhaWTZSBlc5eUj6Y4XYA4hKJr3S1wJla
         FzAKSJglFqXgwoTe/0uGqBoc0zQK3wLvl6wP3LXIxcrgGtiTf0CPvVTt2eHcTxjWlS0R
         4dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741042392; x=1741647192;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHRREGcSp2krqTtJr5eO01PBlpy/oFOdFDc6Qvhwm80=;
        b=RSeBIC23t0OJ7bqfqCu+Q2FzyIMZ/+bXlSEmlbwrU0aFdQLLh38meVxQcRfYf4r09/
         4kdM29ciCmgcQn6Sz5cGss2ZzbMVoUMiUeoTwuI71rk3ak3yvQFd1awzUogEUx0SQehl
         dII0euZ9M6MP396Q9gZ/vD99/71s7Tmvz67n4pGHFNZLWmRjzt1r0KkDMMTTO+DpnO7f
         BiMXJPnXtV7dKSUjoVW9aAnZhNsHmUEH7CbJzdeRLqh19ioteq+aSU5CwdLKFvp56ngo
         Z9mSGKrjAfhBcfci20h2UCl/y658eDkmUGChTzSqa8XDGKA/6GN7feHqAHQd4cB6ZpI1
         o9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUspkB7/6zZFh0PbkH2zJLzVTw7umbEe13Sww+w2AeWI//DP90XFF6uGiMBx0eMKwAygKf0hZVJ8SLMZMWv+Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4qVeMiCNkWWs6sj05WtZCiyJaCzk+mKygQLRmGdNjgPbg0g4
	1lqjsVG982S/J8X5b8gg7DlCu8/+P85cwQ89GOhAkXgeUp9dFRCpUnxTb45hWiY=
X-Gm-Gg: ASbGncuJarUMck7TjKHIYVjcA7U+YbkFqbIpyvj5SPrb28VCnl7t0iFOqNtJapB0w8C
	ccjpBQcDROVQpQL/9oNOh3xdcMwDoiNvC1aXITIEdqiRfmzA+xWQzkOIE7aH8QVPh3SPFhUNBnt
	ZkiVTjinw+ajZN2+Gts8xMSBTyt60UvW0EaVh68BRzUXIgE44t7sY5W0AIWhQAg3lvIfkXuBJvA
	qivryq7JQMHmipBzPT3OXrECa3gyF95iVNNh0pMPXSvK5AlztnN8Dp1IPo1u4hCaFs16afwPwyE
	9ysX/D8zHAM03YDDVJl9YGJIobODO+QMoapSEjUvzIYvFVm14yNiJOayqQ==
X-Google-Smtp-Source: AGHT+IFTnPiC8gGn23TPq+Loy5LwqUVXrpZ/genl7BFYk1BAOqQRQeXw3l+mF/ky73QXi/CT689qMQ==
X-Received: by 2002:a05:6a00:a91:b0:731:e974:f9c2 with SMTP id d2e1a72fcca58-734abed5bbfmr23190306b3a.0.1741042391979;
        Mon, 03 Mar 2025 14:53:11 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb4fsm9440601b3a.129.2025.03.03.14.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:53:11 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2 0/4] RISC-V KVM PMU fix and selftest improvement
Date: Mon, 03 Mar 2025 14:53:05 -0800
Message-Id: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANEyxmcC/2WNywrCMBBFf6XM2kg6JrW48j+kFJuHHSRNSDQoJ
 f9uLLhyeQ7cc1dIJpJJcGpWiCZTIr9UwF0Dar4uN8NIVwbkKDmiZPfsxuCeI7kQfTbMWqv5oZ9
 QcAF1FaKx9NqKl6HyTOnh43s7yO3X/lrdXyu3jLOjUFz2Cifb6XOk7BMtaq+8g6GU8gGwP2/cs
 QAAAA==
X-Change-ID: 20250225-kvm_pmu_improve-fffd038b2404
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

This series adds a fix for KVM PMU code and improves the pmu selftest
by allowing generating precise number of interrupts. It also provided
another additional option to the overflow test that allows user to
generate custom number of LCOFI interrupts.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes in v2:
- Initialized the local overflow irq variable to 0 indicate that it's not a
  allowed value. 
- Moved the introduction of argument option `n` to the last patch. 
- Link to v1: https://lore.kernel.org/r/20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com

---
Atish Patra (4):
      RISC-V: KVM: Disable the kernel perf counter during configure
      KVM: riscv: selftests: Do not start the counter in the overflow handler
      KVM: riscv: selftests: Change command line option
      KVM: riscv: selftests: Allow number of interrupts to be configurable

 arch/riscv/kvm/vcpu_pmu.c                        |  1 +
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 81 ++++++++++++++++--------
 2 files changed, 57 insertions(+), 25 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250225-kvm_pmu_improve-fffd038b2404
--
Regards,
Atish patra


