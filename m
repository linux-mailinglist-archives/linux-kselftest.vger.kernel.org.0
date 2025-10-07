Return-Path: <linux-kselftest+bounces-42820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D44BC147E
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 13:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E2824EE4C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC792DC76A;
	Tue,  7 Oct 2025 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0uAdM15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7B39FD9
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838328; cv=none; b=axzyZZvNohFH5zQa1arOm3xBTpPHY6uFwzDSjzJdYWHRKVKMoxShqc/cNmp1Gwu6cOOrUig6v7VxT/jDqLUZkuQY3mKe6oezf4bbNh2qrdP9AZ7YL2F1EnFPAi8P0we4qxKWC5wwa3vBG5pw2ceFaA3J1kjxWdUNA0nyQWZXk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838328; c=relaxed/simple;
	bh=B28UriZIDHaPpeAMdw/A3PSTb2BtJpDt+bRHW5rPK7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qi9GuNzUTQEM9rt8x27DHdBkMZLsS8rTuxwDi7CvqNBFyaI+9WrGgKuGnZ97f4adcvUZptLgNCJDZ25va3JqChfm/lv6SiUF1R13bmzm9hlJM/XC22Ny2fWrrgqNp2Zk4zrYueg/og0WIDbMU2g2umbQyG+rkCMFUPbAMid5ge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0uAdM15; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57e03279bfeso8075030e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838324; x=1760443124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UHSTsWVgVFJryrJ3NLdWTjkzgi76W+AuTzj7De7nJs=;
        b=T0uAdM15QY3a/WCz2OJ/5T58Juyfu9jd3fJMhb5Cg07CkVpwXn6/1nqeKNPkw1cbL3
         0fjW5pPv2c1E9g7Q+cSSbYm5yofwUJMzrf9s/WWgifU0dS9EQh/SXE9JpjeBUa3kFtPD
         HR1nwB+o5nEkL3XaLA0L6gR/tF19NA0RmuSpikK+0uXwDEE2xtAH04YMfV1cfuOwtT31
         4V+y2JYT+SyR2i0MmxTg6SCo/1OMRA3R20zDNgpRSMTolksbZjFIGORi0wvousHac44T
         HDszxOPASCrq2dQPfH8Q943g+wC5QzdjWyyU3mouyLVn7CBvRyvYVi6i2ESUwQ+AIacL
         MnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838324; x=1760443124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UHSTsWVgVFJryrJ3NLdWTjkzgi76W+AuTzj7De7nJs=;
        b=Kz/0lzDcOkNoXhQX4WYvDHF+JW/BWM2sVFLuK5nIqCB/+HXHqQ8Pvz3CRFgGamMM2U
         8u0SL2jKsxeh88r01RoXbukWCGwdFnlQ/N+KmlWB5hPOVy1N7t2HBeJ1swiUEoEDZY9w
         u/Sq9d38xiwAB9VnSA3qN3MQLXQY5oYUlkuD10qWgzPB9z/N93YK3LZGJZ2K8SUl8uyx
         Y4/iLlh+7nJT+BYZ/9q7kJFxJ79PC7xWz2bRNBHf4QZNDJrcPBLAEWQqWoiMHbLFQTyX
         BjiNwtjIkN8nQeeB1TVo9XH6Y+4I7WV5UG7W7VSCGX7k6RCfbKSvWmSMrjuZvXLR/gWw
         HD7g==
X-Forwarded-Encrypted: i=1; AJvYcCWo4QrN1QNDYHJ5+M4sTm0d9YbtH0cn1TBm1Ky7TQL9h1xJMxcTfGax23/JOfPeRtvZeNVHnzwXUeZebknafhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMquSCdYExIuWA8Ryg1mB72q156/9Y1EKhfb9Q1ozMIsefFFZ
	nYIDKbgB4KEky7ha5prgkj48LLd2XTT++yIksDf/zXDF2xevp5+7fUQu
X-Gm-Gg: ASbGnctfpIrlNdVPklDMa2B8qJ1Z7PRuoMCSJxSzWJ3FfBPOZ3XL5YvCjFG3v4l6BU0
	zGgrLjmGaH+JiHkX4VtJgX9jC0RxAUSfnTR4b72FQAsJ/wZBfpe5F4CkFLcwCbzWGjoTUwqokR7
	0+WeGguvRdC5TRnSeOC+jG74IaVkgNRQ6yrPmCNBvPKiGzi9YZvhashAlQmoqNhFc5noqp3T839
	kEkBQbo1YDy+rvvy2rAYu5p19K9OxoCKhTJ/UVBIFx/FIuuPWF/YothQlNWoECwB1tWtJbbdsvn
	FY/BpYUXWL51xFfiWCLDMdgbRWh68kMu9XnJOiw5LhUyRoFRYJ9h3vLygZLs2VJ20TLxGKQ4o61
	toUfx6qx0FJ9tTbiBiE9wr4OaimKx8YHS7yYPOg==
X-Google-Smtp-Source: AGHT+IH7bnrkgnYWwbfbVsumwqkq4TDS5dWXB/mKRxP9HCltzhRMTTRuu0r7Qqnaw0RjDr3wioTn4A==
X-Received: by 2002:a05:6512:3987:b0:580:dda2:52f0 with SMTP id 2adb3069b0e04-5905e21c2a8mr974685e87.8.1759838323582;
        Tue, 07 Oct 2025 04:58:43 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:42 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 0/6] riscv: vector: misc ptrace fixes for debug use-cases
Date: Tue,  7 Oct 2025 14:58:16 +0300
Message-ID: <20251007115840.2320557-1-geomatsi@gmail.com>
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

- follow gdbserver expectations and return ENODATA instead of EINVAL if vector
  extension is supported but not yet activated for a traced process

- force vector context save on the next context switch after ptrace call that
  modified vector CSRs, to avoid reading stale values by the next ptrace calls

- force vector context save on the first context switch after vector context
  initialization, to avoid reading zero vlenb by an early attached debugger

For detailed description see the appropriate commit messages. A new test is
added into the tools/testing/selftests/riscv/vector to verify the fixes.
Each fix is accompanied by its own test case.

Initial version [1] of this series included only the last fix for zero vlenb.

[1] https://lore.kernel.org/linux-riscv/20250821173957.563472-1-geomatsi@gmail.com/T/#u


Ilya Mamay (1):
  riscv: ptrace: return ENODATA for inactive vector extension

Sergey Matyukevich (5):
  selftests: riscv: test ptrace vector interface
  selftests: riscv: set invalid vtype using ptrace
  riscv: vector: allow to force vector context save
  selftests: riscv: verify initial vector state with ptrace
  riscv: vector: initialize vlenb on the first context switch

 arch/riscv/include/asm/thread_info.h          |   2 +
 arch/riscv/include/asm/vector.h               |   3 +
 arch/riscv/kernel/process.c                   |   2 +
 arch/riscv/kernel/ptrace.c                    |  15 +-
 arch/riscv/kernel/vector.c                    |   4 +
 .../testing/selftests/riscv/vector/.gitignore |   1 +
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../testing/selftests/riscv/vector/v_ptrace.c | 302 ++++++++++++++++++
 8 files changed, 331 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/vector/v_ptrace.c


base-commit: c746c3b5169831d7fb032a1051d8b45592ae8d78
-- 
2.51.0


