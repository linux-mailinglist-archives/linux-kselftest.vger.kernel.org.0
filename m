Return-Path: <linux-kselftest+bounces-43520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D847CBEF3C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A3D34E43C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 04:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998E12BEC26;
	Mon, 20 Oct 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NzraLz31"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819F1F0E32
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934072; cv=none; b=QocEMDaeG1mRjz/hdXuv88PPrBbaD1sRDlVoQNzERKCTBuYAS10X7qBPFthaSHFNwDN+kIw4pGiOm4CFUxS1JP0YK25jW0HgM+RFSRVPioEYcbExd78xMJ3GQ6mPorsg0RuKkX8JH6i1QGN0zehbGfIS1nDo230a91aQD+lEM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934072; c=relaxed/simple;
	bh=KSjoxuwSlFaFq4TJcoW0tRdCftkDMdzYUiOjhUqgUR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvXcS1L9M54Ynnops+3wEkLSOXE7rki5o+JOLc8xyBqBGzQvs4aJsMvwAENIkQXLzBNbXMGr6bP62eFMf9Ch0UOCL+B9Ao7/zuf7zGShq4HoQ/V/ipKz9nk38aVxl66jlfdtAgVYqHwZ05P7sxVMB2XTEtkJiuJXWeUydR0ohow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NzraLz31; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290b48e09a7so45316415ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 21:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934070; x=1761538870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=conQFyh0ywHaD293wZYZONSgw/GLLJWk5gnj1mP84r4=;
        b=NzraLz3102v6ehlBEAVRV9f1Ok1HDyPK+1tRUW79Wa0oG7FGeo7ruUdMP1CeyBjm8y
         n+0+oPEaUTPef9c6NFgmz4m4MqXFUxhpzQ+Rd+HjvzzA0m1PimfQR2oSTLDkTPyJurkD
         zS0TSjk/KWlXvSnRfN5W1cUH9C0upyQjZ6Sn1DacODGoLgQrM1w5tqvujyFMOPboYv/P
         CIT3qBZJkB+ri82n0Q3szP/QCDewqZ3A0FqMIC2aG4Lp9cumz7a+W3fqKy6SQdCqIi5s
         EHP3M9HW5Gb5shh5r/m6+YtFvn2/unBxzGZhMETpCv24FPAiLTLw7hmJ/i5HSVzcftrT
         oRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934070; x=1761538870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=conQFyh0ywHaD293wZYZONSgw/GLLJWk5gnj1mP84r4=;
        b=AOog0mZgUquoXqOT5YmtnrJM8lknLHSiazquI20jSsj5ieH1Yqgp7BPkZLrsN+eUcA
         Z9mSXkxJC7c+JmRpqVSJcPKgZLekD1x5BxGWhlqobzrtCjY6QfPVEneQ9pWUhZ85Ityd
         rgsjFzeutOJyjoSmzWQft18qorCu2o5V2IXFmgHBNL8SI1NySWy0BPR8WSza50GXoGQb
         ssPmfSqyHZvL/tzfk6xPeuAvVZETuAubzicCDrJl/bBguNL6y1b/+eEbEexTMOvZOq+Y
         pTnlBEbkPb+ZqfxaJgM902MvY9tU+0yweXNpf7JMWNKeYFB8sut3HYd+Sijw60NpWr3q
         E3fw==
X-Forwarded-Encrypted: i=1; AJvYcCVDxy5qzfM2DB41q0tZ2N4gxdgPFtm39mWO6zrGAqiFnWToAlg8sKk/l3M+JiAldzDALo56U+bQMpZB3wb1HZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigaX6CSZuZxrz+wVtgoo42eraL7/YKNQ0e06xnSsGsa1cu3zU
	wdjutrMVs/XSgK2545PgOC6Ldq51GzNhRJq56wposBV8l2BlHEvPkIjVHSVICGx9ujQ=
X-Gm-Gg: ASbGncvCXhhaE76kXBLzByQsOjvwiOdxiZ2+VAm9cjq8Nitmob9zmY4r7QB31CM+oeK
	7e65BEJLwHevXTs+UEH7TzFQyyGpkssUdZOQqd/3ccYf1XFChuK/yD5+njaiKZ9Llo2oOvCHyCn
	p55DIe9gM0MwGjU9D9LCvPvQ1uJddtYcaoQQQXoVruhBW3Y3D0gySXWih53XGiW9HtnglFF7sgK
	aXprPQ5ajC48H5WaLPsohtvd91Mtz/4i65c5oGfykkw6ioTcgIrWjG58zlyxsy4LbRUT3MJq92p
	aD6PtZNR6dSH9Ome7s+TXEGnPG8XRhHrveqFguY+FqDeLB85dMWsKt8IS1bRQIXB3zwXwRRZImJ
	bJ22f3vOssdlPxkGLhERKnTcznAcKPUU2rlGc4esCCewjEjxkotyIDiOknMNvzPwaweD/4wEBaa
	fR+04eXxbpZppI1iyc3UuNzt3Vcmc31kpPDupzWo+UFztKZTsqj2bGmDWha9Tm/G19P0R7Kpp7n
	Q==
X-Google-Smtp-Source: AGHT+IEdkgCehFcbIRaUApmCfafCEhZVkAa78hZZpBjec5gPS2C5TVHNU0zWNgu3Z2IjgaK3I7rtpw==
X-Received: by 2002:a17:902:f687:b0:26e:49e3:55f1 with SMTP id d9443c01a7336-290c9cbc867mr157233355ad.18.1760934069971;
        Sun, 19 Oct 2025 21:21:09 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec14e9sm68762035ad.9.2025.10.19.21.21.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:21:09 -0700 (PDT)
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
Subject: [PATCH v4 00/10] riscv: Add Zalasr ISA extension support
Date: Mon, 20 Oct 2025 12:20:46 +0800
Message-ID: <20251020042056.30283-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the Zalasr ISA extension, which supplies the
real load acquire/store release instructions.

The specification can be found here:
https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc

This patch seires has been tested with ltp on Qemu with Brensan's zalasr
support patch[1].

Some false positive spacing error happens during patch checking. Thus I
CCed maintainers of checkpatch.pl as well.

[1] https://lore.kernel.org/all/CAGPSXwJEdtqW=nx71oufZp64nK6tK=0rytVEcz4F-gfvCOXk2w@mail.gmail.com/

v4:
 - Apply acquire/release semantics to arch_atomic operations. Thanks
 to Andrea.

v3:
 - Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
 so as to ensure FENCE.TSO ordering between operations which precede the
 UNLOCK+LOCK sequence and operations which follow the sequence. Thanks
 to Andrea.
 - Support hwprobe of Zalasr.
 - Allow Zalasr extensions for Guest/VM.

v2:
 - Adjust the order of Zalasr and Zalrsc in dt-bindings. Thanks to
 Conor.

Xu Lu (10):
  riscv: Add ISA extension parsing for Zalasr
  dt-bindings: riscv: Add Zalasr ISA extension description
  riscv: hwprobe: Export Zalasr extension
  riscv: Introduce Zalasr instructions
  riscv: Apply Zalasr to smp_load_acquire/smp_store_release
  riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg
    operations
  riscv: Apply acquire/release semantics to arch_atomic operations
  riscv: Remove arch specific __atomic_acquire/release_fence
  RISC-V: KVM: Allow Zalasr extensions for Guest/VM
  RISC-V: KVM: selftests: Add Zalasr extensions to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          |   5 +-
 .../devicetree/bindings/riscv/extensions.yaml |   5 +
 arch/riscv/include/asm/atomic.h               |  70 ++++++++-
 arch/riscv/include/asm/barrier.h              |  91 +++++++++--
 arch/riscv/include/asm/cmpxchg.h              | 144 +++++++++---------
 arch/riscv/include/asm/fence.h                |   4 -
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/insn-def.h             |  79 ++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
 arch/riscv/include/uapi/asm/kvm.h             |   1 +
 arch/riscv/kernel/cpufeature.c                |   1 +
 arch/riscv/kernel/sys_hwprobe.c               |   1 +
 arch/riscv/kvm/vcpu_onereg.c                  |   2 +
 .../selftests/kvm/riscv/get-reg-list.c        |   4 +
 14 files changed, 314 insertions(+), 95 deletions(-)

-- 
2.20.1


