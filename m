Return-Path: <linux-kselftest+bounces-32021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10594AA44F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 10:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257EB1BA107E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260D215F5F;
	Wed, 30 Apr 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SoVdaUFp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF786AD3
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000997; cv=none; b=eSOTG56gi8P6h+xafzvBM6dyCMcM2RFm+XA74bycsAgVN5hSV2A0L2Pifcilh00pL6D1AMgSYi7ioVQZTwnRq71zcAuXzSw7A8jfNrTo2UG5ezo9gqlNVJv8rT8BCSxhJcitV+xv7YzHmccf4aLKhk9q9U5nSZh7lIaLZL1Lvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000997; c=relaxed/simple;
	bh=Fp3GCul0xLHijr/kSvFB7BX5T/aXnL8fUJ9m9B3qidg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VAQxu1kTT3OGfHoL+b8tpuexO9PSJjXkwB00QJ+Hxe+wp35ONDPzc9tlwFPS3Ed4O3CR+g6TdaN6TC4krZQXv9inEXLuCgh8Yj+94IUbjzA557Ak9pufg09f0lvEWsc16qPZPm4zxuhO1UWJM81Nw0ohf6cjperqhpCkEmlHS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SoVdaUFp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736b0c68092so6060922b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746000994; x=1746605794; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsXzG0OPFSj9Y/N7ILSDxyejpILMY8rt11Cw8ETnit0=;
        b=SoVdaUFpU8Euu4kN22zzABwj7RTqH+sw67jyoOFXhmddQV4uQz1f5dS1E8+b75jc1Z
         WNJarKsmS1lZxqDjl1S1JJVIdOfA5k+8YG/cqnzSCMzC6Uxd7qRYKFPbEdkdN3j9TFep
         iCNSo2ViHZIAjptPBRhHo8GbTkOQR/jsO2i8edivf4rJ1wmZpymiZgIZm0Fz6fiCU+gQ
         0551SjaQJ8inJXP33vC8y/C2AE8jFQqm0+fpvI+JfNv5ErARxsWaD+Y0WThclTTwodZJ
         aYz7LM/nLhpVd+CXSBYsAQJVOEEoYCBR3CljnPnS6Dvy+T1RUzBpZgkQcqRokMCCrenY
         UxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000994; x=1746605794;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsXzG0OPFSj9Y/N7ILSDxyejpILMY8rt11Cw8ETnit0=;
        b=pAJ7QXeGpWsgwjOYBNvpZipzJ0mmm0SHH1C/5gXJhCiIlQKjYEvK9aqzWOaK2Yjdj1
         2KsDsO8CSVusFX2FvI91vLZAzQXlNGySRixWXAZhGOuqkecvJ875IfycRtdaSpGobUhh
         BWF0cVi3PzeM26bxdeC3MQ6xZCOMvQ43gfyFC8r7xPlLHZPZnUGd9jduaWxdtkkO/dI/
         Fpy5qbNY48CPbf+S9L3xXrlaEQX8y97ujXRz5+Mvqrvjlp0ajpGEfSku4Qli3C4Bi4gD
         jwhwjhDHj0rrlgkZBJqqhVs0ACtx2c6QGdRYbjXjQTg/SP1eZ39m2nrpGsyauAqHbKWc
         svqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/HtOJ3bUgE9kSBFknuodbhJ/c0b7RgsVgMlGZ+JSRSgtRLjdpQqjXLzNWg06QdotIjFh3PrUTadkaRCgD5k0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/+A830vZGD00FMpDH9wFUH1naNX8FMp9M539eR5zcAGSTs5Z
	bvaKHKy2fvZohnwpbuYxUq7+sQ/H8RXlWVcpJgYV1EDPuaZeyTxfeDa+N4HQrEM=
X-Gm-Gg: ASbGncvSz2do23AorKoPCXJet9IXQfyK7kaPgn/mMNQitMpqFEIpXhFGyI79XIhkK5X
	AcMqSjJH+nsqhtmrPDy7JAlPTrr462ZcOsvdvPXSs9StF8NGKEURau7O9peZnvddcKlqlQ68lus
	pdbflx4Gr9qw9OYwHSKf2xtps7OK5WJXn/UYTvgsG254H7nf1EzYGaU/lLuCmSzfXpKZttiW/n9
	52lKDm+lXZJoajKprNJxmMqDp0kazTk5kilqNeU+EpWXG9Z6DfQJoNZ2mEs4L+nTwosrywUlbJ9
	MEucdf/J3d5f5GPbAaNUJedqOhlQhyACi0oTdOi5BYdHn53D8eWHjA==
X-Google-Smtp-Source: AGHT+IH6seQgwJqi/FP/vswGEFmbX1nzlJ/wu6PVrapojvhfM+Yipa5sWjHxHBJfv7qDYrJjbCoowA==
X-Received: by 2002:a05:6a00:1146:b0:736:7270:4d18 with SMTP id d2e1a72fcca58-740389bbc36mr3347820b3a.14.1746000994070;
        Wed, 30 Apr 2025 01:16:34 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a309edsm1073084b3a.91.2025.04.30.01.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:16:33 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v3 0/3] RISC-V KVM selftests improvements
Date: Wed, 30 Apr 2025 01:16:27 -0700
Message-Id: <20250430-kvm_selftest_improve-v3-0-eea270ff080b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvcEWgC/4XNSwrCMBCA4auUrI3k1WpceQ+R0jYTO2iakpSgl
 N7dtBtBEJf/MPPNTCIEhEhOxUwCJIzohxxyV5Cub4YbUDS5iWCiZFIoek+ujvCwE8SpRjcGn4D
 qFkyrLWsqI0k+HQNYfG7s5Zq7xzj58Nq+JL5O/4CJU0bLo6zyGtdG2XPA5CMO3b7zjqxmEh9HC
 f3DEavDD1xazYGp5stZluUNvbqg9gMBAAA=
X-Change-ID: 20250324-kvm_selftest_improve-9bedb9f0a6d3
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

This series improves the following tests.
1. Get-reg-list : Adds vector support
2. SBI PMU test : Distinguish between different types of illegal exception

The first patch is just helper patch that adds stval support during
exception handling.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes in v3:
- Dropped the redundant macros and rv32 specific csr details. 
- Changed to vcpu_get_reg from __vcpu_get_reg based on suggestion from Drew.
- Added RB tags from Drew.
- Link to v2: https://lore.kernel.org/r/20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com

Changes in v2:
- Rebased on top of Linux 6.15-rc4
- Changed from ex_regs to pt_regs based on Drew's suggestion. 
- Dropped Anup's review on PATCH1 as it is significantly changed from last review.
- Moved the instruction decoding macros to a common header file.
- Improved the vector reg list test as per the feedback.
- Link to v1: https://lore.kernel.org/r/20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com

---
Atish Patra (3):
      KVM: riscv: selftests: Align the trap information wiht pt_regs
      KVM: riscv: selftests: Decode stval to identify exact exception type
      KVM: riscv: selftests: Add vector extension tests

 .../selftests/kvm/include/riscv/processor.h        |  23 +++-
 tools/testing/selftests/kvm/lib/riscv/handlers.S   | 139 +++++++++++----------
 tools/testing/selftests/kvm/lib/riscv/processor.c  |   2 +-
 tools/testing/selftests/kvm/riscv/arch_timer.c     |   2 +-
 tools/testing/selftests/kvm/riscv/ebreak_test.c    |   2 +-
 tools/testing/selftests/kvm/riscv/get-reg-list.c   | 132 +++++++++++++++++++
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |  24 +++-
 7 files changed, 247 insertions(+), 77 deletions(-)
---
base-commit: f15d97df5afae16f40ecef942031235d1c6ba14f
change-id: 20250324-kvm_selftest_improve-9bedb9f0a6d3
--
Regards,
Atish patra


