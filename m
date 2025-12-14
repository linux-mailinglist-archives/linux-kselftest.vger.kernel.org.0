Return-Path: <linux-kselftest+bounces-47564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B1CBBD72
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C63623004CD1
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B409B2580D1;
	Sun, 14 Dec 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVpOnH7g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11891E1E00
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730147; cv=none; b=b/8TsgRxzpRraA5MxjPgwRP6yN0rmQash88eZfMYTcsPs5oWMyeO5AWuUN8r1H/IfqNUidejhsULMCSTqNHgBkTe4DvOpSVO+b1M/bz+IBNViFY2YxlKbPUOw3ufNp2rPYnWsonNWxO9WTlXvcHFbd/oCdPJKg9hQMukqsgADRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730147; c=relaxed/simple;
	bh=AilalJvyzrbLh//upEdwxFdU5Ag0Ak9V0tS0tcvk790=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2wH4KNCHcy58mMCQpkuNZlWlmTMUM29qG0LhyQ9JtYaKW7qk7b47ifDMP2D3pc7NgVZkAD/sa92jLAqHAIcJ7An0GLrNq2m/KtFibOS36z98kYpZFzW7OACBmGCZoHcerH0qjC+AyY0gQXVsJbEhy6iR7s4yUP96OfomeWs5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVpOnH7g; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5958187fa55so2198212e87.3
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730144; x=1766334944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KW14eOIkaYwqJSzWMg8OOBiyNxtSIoZ6QzdhSZdq80k=;
        b=mVpOnH7g6J9fr4YTJH52ozVYSUdIRAlpIh7i1Pt0vu0mxTs7tzhEKerV5Cxrqg0miE
         sG1V+tR08gPXiafcwX1Lsn8Emy6WioDFBDnVXWZeNeDfiKDLRldLmaLlfY2yUI54wMC3
         dqOIG6+xGh2Ag3v8oXva/9DZuRtcLCellAyDLVRTXI45PbpZx+0dWqVtBzpAvOnFmZ4l
         Pp4BmsNYw4XVOqGgyCor7fk8l4/Ks6qp24Bzp8YWQT/0bBtsFWBCm2o9IdfJvO787GOD
         HXyymaPe1cz4tNP/gH7pEPD9kr8u4IbUlyGvPnUVSt4qN6xEtdKB6vj6GHyIPq8yS3Iu
         /kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730144; x=1766334944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW14eOIkaYwqJSzWMg8OOBiyNxtSIoZ6QzdhSZdq80k=;
        b=hm+Ul+P9G79XTAwU9AbZ18dgSga3M21YEzf4P5O+acnA+uAoq2WusblgMMNL5pR8El
         3tSuhxPrnm7iGpE5oevr8vnOL5yMWIlh2inu9Xkfmh/xDEDc62Dg0HHCHsQKhLI8xdZ4
         gfheJtyV8Ncs3hiWQXGL2v1JaAQeq03Zv5imXqj63mqID/l5tOT/XZjfkjhUUXVRHilq
         W/tjc9HcfMY0OcFJaZw1guiGH9v23sKwCP1g2jEN2k7iMQ+qAP8ibnNcdOujMNGUo7ol
         fBtCCfWdo3APqMi4P0vJWhKb1l27VFd3QqJJ92Gr4zPx2AEKD41vKLIjECL852OcYo01
         aTig==
X-Forwarded-Encrypted: i=1; AJvYcCVj9bLb3frM6FwuUilLZLQFJ/N1ROR1PIZhj5ailfiikfBSbIYFBafh73wt76ctV/IXf+onr2UqoSR7L8XjCXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQA/y1WXfbj9tX/BuUClhHo8xqQqtXWI6k8wxlj6ZOZNg9b5g
	1rcEdbhHMJs9j2mfNqudAEjOyisz/bcX4D2UdYOrSCK2OPFlppzvrfQg
X-Gm-Gg: AY/fxX4LcDUucr8dmxg6rf/FBkoDT80WD1C3kruD/Vr2VxIveAHCNMQnxHIrCpWJsG8
	oLZNVcfyyPC/RWc5Wvs3OfZ8C+0PV5sM8BGTRFudj1t7Gxs+NnlilQoSnEgfDylsGw5+53E1ZMQ
	x/w73mUSc6TLPPxjNs/dz3d19VLuDplGaEGZm58qDywzbCvfa3mjLqGIqN6Ngs4oZGakRTIh2P5
	EF9qqo+N9dq/fB1YXkr+vOhHsjvqrAFV/k0VKOtmg9iqihBvC7lcl90I2ZI/SsQdfzGj37nIHn8
	2DAX3OVIzoV5szqPtjBDUNb3XZALtuDb/NNl6qwSn0f2JQdNXcxpEpKVF9Dlnrg+nLREEAXmHF5
	nkyr6T/rzqvKGVuxKT4RrN1uwIZYDTKLxI2FynQngjC/ublqVHavuPYAeLP4yE84pamloPU1789
	R71w==
X-Google-Smtp-Source: AGHT+IF0fXC+uv8d2AkqLZUwN0Kj5Ka9OMORJEEFQOxcLCnJNaAOH3tMwrpqZgf74HUK7PX9yUcEbA==
X-Received: by 2002:a05:6512:39ce:b0:595:7d40:df10 with SMTP id 2adb3069b0e04-598faa8effbmr2438191e87.40.1765730143778;
        Sun, 14 Dec 2025 08:35:43 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:35:41 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
	Guo Ren <guoren@kernel.org>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v5 0/9] riscv: vector: misc ptrace fixes for debug use-cases
Date: Sun, 14 Dec 2025 19:35:04 +0300
Message-ID: <20251214163537.1054292-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.52.0
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
suite validate_v_ptrace is added to the tools/testing/selftests/riscv/vector
to verify some of the vector ptrace functionality and corner cases.

So far tested on the following platforms:
- test in QEMU rv32/rv64
- test on c908 (BananaPi CanMV K230D Zero)
- test on c906 (MangoPi MQ Pro)

Previous versions:
- v4: https://lore.kernel.org/linux-riscv/20251108194207.1257866-1-geomatsi@gmail.com/T/#u
- v3: https://lore.kernel.org/linux-riscv/20251025210655.43099-1-geomatsi@gmail.com/T/#u
- v2: https://lore.kernel.org/linux-riscv/20250821173957.563472-1-geomatsi@gmail.com/T/#u
- v1: https://lore.kernel.org/linux-riscv/20251007115840.2320557-1-geomatsi@gmail.com/T/#u

Changes in v5:
- add support and minimal set of tests for XTheadVector

Changes in v4:
The form 'vsetvli x0, x0, ...' can only be used if VLMAX remains
unchanged, see spec 6.2. This condition was not met by the initial
values in the selftests w.r.t. the initial zeroed context. QEMU accepted
such values, but actual hardware (c908, BananaPi CanMV Zero board) did
not, setting vill. So fix the selftests after testing on hardware:
- replace 'vsetvli x0, x0, ...' by 'vsetvli rd, x0, ...' 
- fixed instruction returns VLMAX, so use it in checks as well
- replace fixed vlenb == 16 in the syscall test

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
  riscv: vector: init vector context with proper vlenb
  riscv: csr: define vtype register elements
  riscv: ptrace: validate input vector csr registers
  selftests: riscv: test ptrace vector interface
  selftests: riscv: verify initial vector state with ptrace
  selftests: riscv: verify syscalls discard vector context
  selftests: riscv: verify ptrace rejects invalid vector csr inputs
  selftests: riscv: verify ptrace accepts valid vector csr values

 arch/riscv/include/asm/csr.h                  |  17 +
 arch/riscv/kernel/ptrace.c                    |  98 +-
 arch/riscv/kernel/vector.c                    |  12 +-
 .../testing/selftests/riscv/vector/.gitignore |   2 +
 tools/testing/selftests/riscv/vector/Makefile |  10 +-
 .../selftests/riscv/vector/v_helpers.c        |  23 +
 .../selftests/riscv/vector/v_helpers.h        |   2 +
 .../riscv/vector/validate_v_ptrace.c          | 919 ++++++++++++++++++
 8 files changed, 1075 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/vector/validate_v_ptrace.c


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.52.0


