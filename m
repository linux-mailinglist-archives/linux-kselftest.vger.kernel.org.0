Return-Path: <linux-kselftest+bounces-39172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B2B292FA
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 14:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400DF207240
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D1676025;
	Sun, 17 Aug 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Oi98nZUz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA779F2
	for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755434022; cv=none; b=uRs0fdx/+IJ5/92DN1Uqu3GJKv8xw0X3iVqFjyz52t6mEsnkVNNWu64EM3B2VnTM2eIZ0oatyNuR6l7utLsmreIswTv39edDMdVW5nbC12xQalZvffv0lecm6pnI7IWEiZqJmbayL1lprz9j1QyGhsxKgG+1eekguoGCFfoEmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755434022; c=relaxed/simple;
	bh=ECKA1N0ozZJky6qyb2l/wy6+UK0bWtlFcU0qrSDIIRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPfYr1QPt8WQbYbDZ8ZJOL9aKw96N+PCqfSU9LxI4oK816szEeBtiCmJuPcNEZWYtmunalr8D+6/GYPCA4vJZhpP6DmfC0TOg0HclvS5RLNgUOApty52chFo5B+exqJtJ3asUiq60J4Bfn/8XuXGfFOm1+sBFEuFVSPw1WYxXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Oi98nZUz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso2916392a91.1
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755434021; x=1756038821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WbiJIeRAyXPasTR+StFJQvgx7M5MTQOS33x2RRGox8=;
        b=Oi98nZUz3eFNu6StdJOhD12R2OhNoCrURlEhYdQkxKC5OaV6aV8jhT0lr32WEx11DA
         UQOZvYVP/UkMFehC9ZosdQN9Uw4U4V0ccpvZyL0jxJfo0Fc60By5nB3pEysZTUq2U1o0
         LUDOowDwSPNSjlqrefxDghYkSjijpxTa/xpmigKWZqTr7WnuLFn806/6eLoGveWO2bTx
         cGbda4Wl2Wa0nuA/0s/vC10J2WPluqlYxoI8Sp095mXdnzR02rWXY5SVJ2Hg7oi/FgmP
         hATlvHirGYWAtH4BFJWCOKZrFWnJrx1iVhFbPf3Vc2OiY46yCxSekMcU3nmlCKC1u3FS
         vOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755434021; x=1756038821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WbiJIeRAyXPasTR+StFJQvgx7M5MTQOS33x2RRGox8=;
        b=DSysxYjThnA7R62IqhvaSZcdgmDpfsQYXTXuYg58TkNqIJnfMwwCNb5cRaLOFtmieV
         6s+JvaM6RGY/+l6zg8WvOK2Mp26RL1SxZlJFe0H7AXAFIZ9BNdmDLSO+IYX0LFJjWKuD
         M8ksuAgF1tEmSfGJzp1XuNGoF1NdAMCjGs15bYbVA5cWoJ3hQaztvmmig4A0fR6/PhSC
         +mAYL4BqvVuh9uOt3AtqDNyuyagRshdYR49Xq0lhykak1PVUKSXmCndqyIhBO3w6ABwP
         ybngPr1oZT6kLGYSw3mhKUg5CXGQG8cWy7ckMrKi+JqD5kxJVgCspx1Rsq2lxi23cC1L
         V/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc6qn/aqP6bNTeCCL9oE3ITqIptdV9GyWPGJLf6YZrCN9FnkDzlJsXSiR7j9VRdKwl6JonFCRKxER2dQ+xuHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0WN6jeHyncESqoXx7iaew2yvwkCz6LfHminmw0pJkx/vA6qFt
	yccB56rxHWvHWda8TKy87KNZ4BvuvOcZtBmpp1JyFSrjJXoinuxt4g41gbFDLGu2gRw=
X-Gm-Gg: ASbGncsNZD+94lhFtp9Lig2Pe2TieVCQKdVv64fHazUOtlMayC1Sxh2poVcGCDkmpjK
	aABlBO9tQX86q5yieYVshPuR74y2mZRlx0R3W/fDEVnDc88FnyNccnsZrwTjgoiogUajc5/GtcC
	zkYrrd3NKnyq+vclQvAF7igR6TVoSfb9zZzmeNJ2Wim1yxIpEOTv7M0qyEik6WyZ9b6r7hMdSYR
	uisVAwTPr1QZN7nUwk2h6siNW6mllimMV4h1KjO1B766T7wItZAqdaVv2/0XgyEOvKeys/iFuaY
	MAca9lnAwSclR//gbelOYQ1puj9wfr3yvaN069uxwXm79Nm5evptNN0ND5tdr6iWDtuW/4AHfzn
	QIxBiEQ7m+a+J9OmSBix5Twodw/DAVPQ05KvcrJjHudFVS/TMON1y2QrgSZ3vHEvuDw==
X-Google-Smtp-Source: AGHT+IFVbDDjII11gSvR9Q4jewkTQtbKL3ViUFZFZq0yfpKxvIKgRxHNfx519E/5M9iV986Io2UJ3g==
X-Received: by 2002:a17:90b:3c8c:b0:320:e145:26f3 with SMTP id 98e67ed59e1d1-323296f24bdmr20313460a91.8.1755434020703;
        Sun, 17 Aug 2025 05:33:40 -0700 (PDT)
Received: from localhost.localdomain ([122.171.23.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232b291449sm4480912a91.0.2025.08.17.05.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 05:33:40 -0700 (PDT)
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
Subject: [PATCH v2 0/6] ONE_REG interface for SBI FWFT extension
Date: Sun, 17 Aug 2025 18:03:18 +0530
Message-ID: <20250817123324.239423-1-apatel@ventanamicro.com>
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

These patches can also be found in the riscv_kvm_fwft_one_reg_v2 branch
at: https://github.com/avpatel/linux.git

Changes since v1:
 - Dropped have_state in PATCH4 as suggested by Drew
 - Added Drew's Reviewed-by in appropriate patches

Anup Patel (6):
  RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
  RISC-V: KVM: Introduce feature specific reset for SBI FWFT
  RISC-V: KVM: Introduce optional ONE_REG callbacks for SBI extensions
  RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI implementation
  RISC-V: KVM: Implement ONE_REG interface for SBI FWFT state
  KVM: riscv: selftests: Add SBI FWFT to get-reg-list test

 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  22 +-
 arch/riscv/include/uapi/asm/kvm.h             |  14 ++
 arch/riscv/kvm/vcpu.c                         |   3 +-
 arch/riscv/kvm/vcpu_onereg.c                  |  60 +-----
 arch/riscv/kvm/vcpu_sbi.c                     | 172 ++++++++++++---
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 198 ++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi_sta.c                 |  63 ++++--
 .../selftests/kvm/riscv/get-reg-list.c        |  28 +++
 8 files changed, 433 insertions(+), 127 deletions(-)

-- 
2.43.0


