Return-Path: <linux-kselftest+bounces-43385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93BBEA6ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735C11AE22BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8612F12D9;
	Fri, 17 Oct 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FeTQgWZc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F554330B0F
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716778; cv=none; b=eu2x5wGZg+H68RJe788VZSc0ZNGQsf1T/ss4zehxJm1uKKjHbCItnZV7bNqRaCE64g+R3fl0GWmPhWz10eXd3M7DB3ftgnuy9sHokFDF4ktTmXStgjw5CGJFrE7kxvCZ8p5MmPngCSzqkEkZ8yOdsU0x26H7kck/gu9RDqHmcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716778; c=relaxed/simple;
	bh=SiL9tMUEqqm31R8lR6ocLt10DXUHORIUaPfGbfxWyMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOnNqw2LFK2sdM6LAJazsVKPSdpCk+zAIypADZpy3K8Dz+aZ/+BfFPv5QZcEAHqa88PE/b8txn0lALY4hl4q5ovyg74dV7LooXj9r3O0zLmsz9xAdj5rxEv8PsWZPC6vKazMBvBr1ia1U3z32ir02PW+q2gwix9pHA7XixMr3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FeTQgWZc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7841da939deso2079842b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760716776; x=1761321576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3sebnt8lI1uLFunjh62A3i8Z6IjtTbQpyFes/e/NfQ=;
        b=FeTQgWZcGHJZPphb3NsAuJ8Uo/cTPIEfAlzdeNy2ZscfojwaPw0P58f8/7RXT7uO1Y
         AYOnKNFNvrRs7yfsGP/EsD3jExz+MIKHkS/FWf5j1fvZL+HnuVTNRx47yvsKhTAPLnpu
         LU1unRzYrF3Ffp67Hkdx10RzYyrsrlOXBx9HXGO2Y1VT5awf8GdSVn8nsX5oKpfXDqO2
         9Ek3G1NlXhofPkvkCG5qc7YXeS8p80C5X0ru6JoK3gYKGZkDiN+/wPwXDd5ytXbReVF/
         2dPYTcUDWmRkQT7Vn2jfZTwKKECp5LPY3uBq9qDwcMTACucDtmfyBNoS/ehukmz1LHjW
         dqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716776; x=1761321576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3sebnt8lI1uLFunjh62A3i8Z6IjtTbQpyFes/e/NfQ=;
        b=b0bRV62tZx9zGBz9CxW/RUiYzqtrg80FF3EDch32/3DvjLzNzXccZR6EcUCWGKDrcy
         NNDq0TjGp9KwVlceaJWaxBO5Y0JLfQS78OzPPsdNQsuikOgpSgYjK+zkPmCCfVw1bJ+u
         sALo00RplTptaWMMzBt0vg1qG43yomR6IpBm+YT6TKRo2zFkm3Ch2278sZkTv0Xxlwsm
         u1jxjb1+4K4CRd0BlyJCBx54Eng6t6wxazJkbKDQbFOIfGUha11urBOtAAvbOiThC2kh
         aV3uzxzF+bd0QewoLf6o3IN2Nqd7IPvLO9lmbMOXdlsk1OoEtNZZzfdKswtJEYwYEarC
         SqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpeGGPh66RWbT+lGG0Yap3UPOfcSiG6XiiPVXMSA9pmah9eNENujVHefG6vpS3JJ8XsctpJEXjKyb09mA5EVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyn1MWzeLIGh25jVyZNXV5idUlnuuy6p+CfuoxGz2bYDaZs3b4
	C9Aa2DsGU7IEm9ZwTcRlozS5CwUNCg3G3wsI51U65W4zgmFSD2iTjYhlpk3PNa8UvwE=
X-Gm-Gg: ASbGncvnzHdutKbF4TTm0/mlPZRXwhTlz8OnkajSp9X//K8M++XOZaiS5bn0+qAiAkg
	25rvRwHj6TrReLQJTHkq+htMJAjo3D0wMT7IV3mbQE/7hjRGs9IWMRLAhk+8yX7ZJ57YtHH0iq5
	wTczVuR9mtIv7oXqH0Jgpn4lPo4DN+Fz+QhiRbovokF2gin3zqOTZhNlm9kJdcn/JIUnmMyM4P4
	xz5F0Aue94s+M6yetzSMdXbFs0xY21BGPUzTw8b/e73mevvIBZVZzKuLdasKF2vZb+3oNcDBP63
	LYJJ/zMfK8dmzBVNVutRzvNMaUZ95X0hklWYayMf+aq7N+TKXqVgNr6JqRHdjbo3MZ6Kaqg781z
	DXMWs/jpA0LN+8oHzRAC3VLXNzKb8fDe0dstMj3NV5jkkpzVrv88fKz46xcygIVPxD0HUfwpZHZ
	6YwwPfpp1SpkLfpIDKTEv29+9MCJTLRDCAsXP2Zxy/ZZE=
X-Google-Smtp-Source: AGHT+IGXVOTATy+D04tW0ZdHIUpLbiat0j1Zpq3tC7lF/XTd5JaW53iu75rTOxxNbuFmzr3SM4KXPg==
X-Received: by 2002:a05:6a21:6d99:b0:334:9861:ba67 with SMTP id adf61e73a8af0-334a85fd82amr5481874637.34.1760716776216;
        Fri, 17 Oct 2025 08:59:36 -0700 (PDT)
Received: from localhost.localdomain ([122.171.18.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm151067a12.18.2025.10.17.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:59:35 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/4] SBI MPXY support for KVM Guest
Date: Fri, 17 Oct 2025 21:29:21 +0530
Message-ID: <20251017155925.361560-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds SBI MPXY support for KVM Guest/VM which will
enable QEMU-KVM or KVMTOOL to emulate RPMI MPXY channels for the
Guest/VM.

These patches can also be found in riscv_kvm_sbi_mpxy_v1 branch
at: https://github.com/avpatel/linux.git

Anup Patel (4):
  RISC-V: KVM: Convert kvm_riscv_vcpu_sbi_forward() into extension
    handler
  RISC-V: KVM: Add separate source for forwarded SBI extensions
  RISC-V: KVM: Add SBI MPXY extension support for Guest
  KVM: riscv: selftests: Add SBI MPXY extension to get-reg-list

 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  5 ++-
 arch/riscv/include/uapi/asm/kvm.h             |  1 +
 arch/riscv/kvm/Makefile                       |  1 +
 arch/riscv/kvm/vcpu_sbi.c                     | 10 +++++-
 arch/riscv/kvm/vcpu_sbi_base.c                | 28 +--------------
 arch/riscv/kvm/vcpu_sbi_forward.c             | 34 +++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_replace.c             | 32 -----------------
 arch/riscv/kvm/vcpu_sbi_system.c              |  4 +--
 arch/riscv/kvm/vcpu_sbi_v01.c                 |  3 +-
 .../selftests/kvm/riscv/get-reg-list.c        |  4 +++
 10 files changed, 56 insertions(+), 66 deletions(-)
 create mode 100644 arch/riscv/kvm/vcpu_sbi_forward.c

-- 
2.43.0


