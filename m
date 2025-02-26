Return-Path: <linux-kselftest+bounces-27567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3484A455A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17AA7A3C4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC1268C55;
	Wed, 26 Feb 2025 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Pa8yLKt5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F725B678
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551542; cv=none; b=LM101MgRbmnzppwO9ZhZ3rQ7H0yhd4G5XgrttuE3Hw3l/WckvfercKmyjZfyyehDidjLT+42n34zHTPTp097AsnzXTE6SzkPNEd/1JwrhWnwju8xJB1ywRrxUlNuab6ZLqFS1qPN4CS2MxoOcuFwTeGbE39wfdA+2PwG4EruLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551542; c=relaxed/simple;
	bh=O/Cgz/sNloT4p2sEDuZ9Z/7WzZX+Hiv6oAtunAv14gs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Ul/WJrvezXgqMkV2Rps0wMFmqmoSngVc/pMTuQmyMlRkyxc5ldJCV9rSDB8ZcaGwPgUUhHpQfn0ewBVrMUs3Ov11hWlRG6UixK0o59N+NMURhle8gm/iYLfzgVwZyvzBcXI8nRYOAHNzdCw8gBE8YCjXHQ0PVqWHIB265iRj358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Pa8yLKt5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fcc99efe9bso9943781a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 22:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740551539; x=1741156339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QtUWquMOJu8M6vXYzl7Hez8XDGzXf5hk21OpP0Wr4oE=;
        b=Pa8yLKt5PVImOj0oTJv/2yk6WXgJ2K9pQAPfhk4o729b4mu21AddPsfiOftZeVagrD
         b11Vx4AOUHK8oV3xXT1ZLgrJTLaQPng2rFF4yuVJ5CtV2hzi5vAOjCFL6D4HqzL3IL36
         1aaIfQNvJUvhRB1FV62JiIPuvNWAOxeL5uM2b3spIxHLHOl9UjfBie5HaiZqiAT1CHPV
         n+BS/4lTzF+50dEfybh4l2NfGDV2Ib0mDtrCgBzYv0t1ADWCAXTJ59dyeDC63fDWqr56
         +T+4uepWx1OzQQnsn8I6CJDg8Ttjwi+4xkUhvBw29oBAGHBWXbFwA5Aa5XR9AKqfNWaq
         VTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551539; x=1741156339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtUWquMOJu8M6vXYzl7Hez8XDGzXf5hk21OpP0Wr4oE=;
        b=BTVr3m3bOiGFXKI7yyhfuiXmYEPn75swpH5+F0PdSvvizRInXn4FPNN27bWpkMOfp8
         EMywBHLdOcGqXF5CTLgNG3euNxkW7Rf+VeDxCQT7RZjGpZWRIDr08eqcVVdLCXN4U0tV
         YmnNyGd6NUjl2oqyYNtKMxyu8b4z0scSJjB7E92xev7kb75V5et+v5pZbrC2ijpQtTmb
         i1YBUGoCLfjTnJmimV36fgt6Nt8LFBGmuPHKZ7iFCbEMd8qLBhrCEh3iWbchp8CoZc5m
         ka21MnkyO4Ah/BatvaF/8obkpbEiocqjRDfWc+0r8AgOhLavIyXRoYGvO9YQMerBP6hj
         qzbA==
X-Forwarded-Encrypted: i=1; AJvYcCU0DqWof4+rcpCkFCIQGsqMtRW5jhPA8u+aXFsGqCnVNCnYBlYshlF1dRn0c3KSnz6wv4QEQNbsAFYXMHoYxdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzsF6Mc+tYSBTKJXvButjufCwiEz4refZ30rQEn822j0TkUr1
	ys7x8V7EQfli5Bmk07gzHS+8vJ8U7bVuWmfRXrTmupi1DCdVscUD86bKGXMnSig=
X-Gm-Gg: ASbGnctsX3TdK4aOHCMzCMnO4rSJs6X6b3vkt5QsMmUJsejX9Y6Jg84IgosXRYIOyee
	0WBxCyrjSt016almPrN3nrfqUH/ijtxv5KWZ6RmPcvz9qcTT33jPcjubs3UUii3V7yKemX+2CYi
	Oc5bwH8jRChta0j6LqTC5QwMw0cb2Tw+yDXHNVdHdRDPTjyGRO06Qu+dXLa+wKwGKLJlMJmHZ7Z
	blneYsNiSafiNS65jGH7glUx9M68y3js+vwZ+1w1pCPhMvg+voDiGA8KydQ/YvwlIRG6R/iVd2k
	+6Tg0/R2AY64L5/Io+yp0mubJ+1vVGvTOT0w0pj7KkytoF8aKrKqflK0PEdM
X-Google-Smtp-Source: AGHT+IG2mAiXspI0vkCYd+e4u0ND+Y2lMAuAlqRh2tnsq4uOKE0Trc7s5XDT5FmuMUha5uITuEAAhQ==
X-Received: by 2002:a17:90b:3e8a:b0:2f1:4715:5987 with SMTP id 98e67ed59e1d1-2fce86ae503mr34768209a91.9.1740551538640;
        Tue, 25 Feb 2025 22:32:18 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f152sm682599a91.46.2025.02.25.22.32.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Feb 2025 22:32:18 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v7 0/3] Enable Zicbom in usermode
Date: Wed, 26 Feb 2025 14:32:03 +0800
Message-Id: <20250226063206.71216-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1/v2:
There is only the first patch: RISC-V: Enable cbo.clean/flush in usermode,
which mainly removes the enabling of cbo.inval in user mode.

v3:
Add the functionality of Expose Zicbom and selftests for Zicbom.

v4:
Modify the order of macros, The test_no_cbo_inval function is added
separately.

v5:
1. Modify the order of RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE in hwprobe.rst
2. "TEST_NO_ZICBOINVAL" -> "TEST_NO_CBO_INVAL"

v6:
Change hwprobe_ext0_has's second param to u64.

v7:
Rebase to the latest code of linux-next.

Yunhui Cui (3):
  RISC-V: Enable cbo.clean/flush in usermode
  RISC-V: hwprobe: Expose Zicbom extension and its block size
  RISC-V: selftests: Add TEST_ZICBOM into CBO tests

 Documentation/arch/riscv/hwprobe.rst        |  6 ++
 arch/riscv/include/asm/hwprobe.h            |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h       |  2 +
 arch/riscv/kernel/cpufeature.c              |  8 +++
 arch/riscv/kernel/sys_hwprobe.c             |  8 ++-
 tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++----
 6 files changed, 79 insertions(+), 13 deletions(-)

-- 
2.39.2


