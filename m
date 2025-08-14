Return-Path: <linux-kselftest+bounces-38986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6BFB26BCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821AAAC0A98
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389223F43C;
	Thu, 14 Aug 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OPd0CK8Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825E8199924
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186963; cv=none; b=gOjqfqN/HSGA3/D1/OGGVWXZjc78TBiLCqxZqC+JZ/tcy/0ux9VcuX3OmD2JeMJmV8wt4jKIpt8yEwenzDel1ZPgu6F67D04r+DGAZ9RZC+rgJoaKtprd8XMdcGh6VZI6fkUqgYp/izvWtuy4MSFjyoe8KN9pBl1hMz7SD6LfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186963; c=relaxed/simple;
	bh=70C+wR2OGyGwLPTOfQiAUvSVN2h1Wr8pPgkJs2xIVQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/qBrfox5JsV70mezlgwcll04WaRkvQ4xbz3qyFceacsFI4HO8g5hYFDcKv+iR8o3JE8CbfnT7vYLjvqjd6z86tvM0KJIloyZwsnTrYyiAhIum7Ir+139s66JnIBKzprlbKlpmuYuEVqqe3AjtxPBTTSbwbLxb0LMM4cGGsDTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OPd0CK8Q; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4716fa7706so782200a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755186960; x=1755791760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbS0SnSfDCYNteBkAugCZAVezW6wYeQqbL6j1Y/9w2o=;
        b=OPd0CK8QfxBK+Iz6vzDibyRg7ZuChu7DR7rK//4Nv/RQ7qolecyzOubtoE0nRYJc+6
         0anEDeZUj1/te+RkxC7ZxzVPkywOZomjdMdVPfNRgnRyBKmve1A1/GlVbIgwfwWRu01e
         yUySYWUibjQyQJzjCbDjRm4tNXOinbAJEbrpyimTBWOBOddOSfrpvha/oGbLkQ3aBaMw
         zeG9BbhoCztB06JfUJ9XDQo6CSI1SNFaFDzS2SfEUb0QZYOeY6jdUP0DzHdsyID/J5WW
         QkhwxZ661DDUTWdQ4mUzhu02f/vfG5p1hdV5XYvemC2Dl6jhAyy+aU0bbnjXRZYjJl4p
         TltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186960; x=1755791760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbS0SnSfDCYNteBkAugCZAVezW6wYeQqbL6j1Y/9w2o=;
        b=GMUw/IP792lNTxbyCM68NszkwNNa5PvgR8yaEphsIPDe7IyPeWcSa8Dz6xVJvikNbJ
         NTP7OBM4/oUkiS1SW8WScHTfmk93hVvbhc5dvyi7OUo+1bGxM05daIadR6VrK/C4i+2i
         U7RjKVZGkMAKz+uyBvIOBXMtaaSiDGpkBgqo0yPaSQBlx1XvdkiRRpKzMBQlfWfCPkU/
         T4MVwKZZY7Z8udP3He0jyhsY01LEB89p+bb33tTWyPmRuGmTJS4CZhyDnkvx4Zw6p4wC
         Z+OrRYaxFRxGFdRIF76XskS7RZzWL4tM1Umq6IowkhEgeGgEo6BMDxY8qfABDCibaCJP
         0kCA==
X-Forwarded-Encrypted: i=1; AJvYcCXftYUsEgR5uSW9nvWyCGJED+SORo5AozFqlmrSxfVwkxsL2O/izGU2lGbF5WiIP3eobMbCCKHmg28PC65UJ+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLyCV8aY3dEZeZQglrsjwmDPqNHad/TBhMREB4VLGcBNXGfN1
	HKfSeZgLis69nAr3PJ+TL6JMSHdpdMq22IKDu/J6/p5wxlB76ICLh2RN2bacPbM1k5Q=
X-Gm-Gg: ASbGncv/PeF76/n5ccvFZshjkoADUWTcK4SOieUZaiovDQXwbmrqE/X4EHdbvKlasAN
	y7lDNHscym0wUNy2SJj7xDzEgzTJ7CP5xrqccShNvSmHbq/L7Rpz4GAlzKLM5TlgwjQpPnEcfhX
	tXISoIqRd0b8gIZt+dbcMsZa5EHgujeJ50kYqGbKeKP2mNfCEP51yrtAnOTQzgEZzAgHNPwZ2Gt
	FO9BClSlDxXKU4Ft+nynpolUnu1V7fbA7YY7OGj/XEz84VBym+xkxZjJ3ERshYoY7jX5Yp13yEM
	MAiaBoqttwC+gzfg8kIbKGNn/flcayO0VmE78YE2uXEGvjszDeqYgV6wrSsxLriz8STyNyxcRNy
	ta+97RJi0f4jUnfovlHxKCUhaNe67K2jUApav7s4gZCs494p034WuZ5eDPV3UUA==
X-Google-Smtp-Source: AGHT+IHiJ/C+iotNnCA3DhU4+fNK2fePBsmUyymIcxaNYom/9E0Z1/NWwsgFdX4eBUWW/qEOqDpszg==
X-Received: by 2002:a17:903:1a30:b0:242:fc4f:9fe3 with SMTP id d9443c01a7336-244586a18c8mr55450135ad.37.1755186959600;
        Thu, 14 Aug 2025 08:55:59 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233108e1d9sm2225500a91.29.2025.08.14.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:55:59 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/6] ONE_REG interface for SBI FWFT extension
Date: Thu, 14 Aug 2025 21:25:42 +0530
Message-ID: <20250814155548.457172-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds ONE_REG interface for SBI FWFT extension implemented
by KVM RISC-V. This was missed out in accepted SBI FWFT patches for
KVM RISC-V.

These patches can also be found in the riscv_kvm_fwft_one_reg_v1 branch
at: https://github.com/avpatel/linux.git

Anup Patel (6):
  RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
  RISC-V: KVM: Introduce feature specific reset for SBI FWFT
  RISC-V: KVM: Introduce optional ONE_REG callbacks for SBI extensions
  RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI implementation
  RISC-V: KVM: Implement ONE_REG interface for SBI FWFT state
  KVM: riscv: selftests: Add SBI FWFT to get-reg-list test

 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  23 +-
 arch/riscv/include/uapi/asm/kvm.h             |  14 ++
 arch/riscv/kvm/vcpu.c                         |   3 +-
 arch/riscv/kvm/vcpu_onereg.c                  |  60 +-----
 arch/riscv/kvm/vcpu_sbi.c                     | 172 ++++++++++++---
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 199 ++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi_sta.c                 |  64 ++++--
 .../selftests/kvm/riscv/get-reg-list.c        |  28 +++
 8 files changed, 436 insertions(+), 127 deletions(-)

-- 
2.43.0


