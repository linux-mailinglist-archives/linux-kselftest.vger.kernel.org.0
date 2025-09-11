Return-Path: <linux-kselftest+bounces-41247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214C9B53449
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DE318901E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82F324B33;
	Thu, 11 Sep 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbT2x4cC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D962C1F03C5;
	Thu, 11 Sep 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598580; cv=none; b=gGCPiFwaJzzPg/kguZCLDVlttB3HTl+L3VrLNPSV8m39spagjhaMdMLe02bAGiPFtL+Rb5jvcaNXzf6KncsHFbaGP4OsA4D9VRd183esDvsphbo7PgA3GZJ2JcBv/yvxla3/jpcGGVAU+jsEc0OrjHl8e6Y3HTF0HScyRpM6v3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598580; c=relaxed/simple;
	bh=T8VtWbZoh0VIipzuyBrHjr9wwGoQSoHS3Ynzhj6XMgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DEs431QpzrAZMBF93OvU33iE/e4+lMHY4pUA8TxL+XipXzsjPhJ9XLoGUVJZEMSePPr9lVWiHbbrrxreU0n2UNcZNRewU0J9HqiziG+qEZsI/gHrQd0mjeYHrZYnZETCcCFKXx+9sHkus6AjADojLSk8kh0XPTlWCS1erBQpOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbT2x4cC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so459154f8f.2;
        Thu, 11 Sep 2025 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598577; x=1758203377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEbc34OfcWsmZ87K3FZrtli36glSfRnoXSobn53PJa0=;
        b=HbT2x4cC4bNjR/QYhSReIWByOFl75zoZ/5YsLd7pi964+gaFuBGuQ7PzYP/+ywC4ai
         3gg78gEsDryBmeX9TDZEPA1nn0+UG257sM3sDtXbgL3MV+Ry9Dx/gfQXT0uthdYo45Qb
         aCI8pzpPiG/KPhDmsKKiy0Hll5TvBQvBT6cKD3DTdIGVV8hahWjUH57025Hv6ieqDIaG
         vQH0YzNniC41EZvkOwa29w7hD0K0cYY3fYu50/3mc5hLHYAjfjLPReIlcoot5z35kCFs
         M+lHlIk8e3IgzxBfQPF0+pCnFkT7sNzhbQpYHJ67o77vOrovU2s1Gg05bWPtVQaq2ayX
         XENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598577; x=1758203377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEbc34OfcWsmZ87K3FZrtli36glSfRnoXSobn53PJa0=;
        b=ZSq7SGQcfiet8KxYkorwNFVAFPF/hlZqFmzHCp7e9H04H9eQmzr4lO3GFV2tfLI2JV
         L9TdF2SPfbg+3xRnFG/94Auico3mLHELSD4JDkhIDkZLouZyohzavkC1gsRHCZXXBC+E
         AXyIXaJgsIbuyOS4d2FmbDqhluQsgsB2PVhtw1/Tz5bH99QU6FjuoekMNyYrwTVNETPO
         6i6jtrFXWmrZC31JXe6v8cpyz4jMMg6s3MvdDdqn4KT22cHxR1bP6MBTfdom08QyxXlA
         7wsx7crMBgLDNtiNdth2SmMAMB2IJOvjYrV/cVnwtXWKOhdSRU9LnN7mAbvYqdYs1DK7
         XKcA==
X-Forwarded-Encrypted: i=1; AJvYcCUCgi9FEjnoKT7fAbIk66PEu2PwbaTlWz2Ir18nmf5Taq9eauUrM5RgEpjjkduiH6zRBDt4PpRpkCS9uwI=@vger.kernel.org, AJvYcCVrV3IsXNWIKmn0FNnJtKvyf8huvfZ2x+h5cMenOFghxDvoCPd0E50k2HOmaZ8glUwPEUDYkNvPVnQZ/6lkPjtv@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0OKJqhn9Ql8sIOtjRYG+tqteyHMCMoAxjpVD2P1AOY/jemji
	yz7b0Ki2hCYWFcYGBfgg8dKkxj6mwO0SWKz2TDwkwDNq1JuMgYvR61co
X-Gm-Gg: ASbGncs8ZTrQqr7vKLHgg60RUZJWyPIoEzJzEonIM1vj0Gt9+Zr+sk8qe3tjT2F4UM1
	xBXYENzf9yeT+GSQGkCuLXkmErSXneRearhKu9Si6azdZc4utyhuvBrMvBIUl7ceEm7hHS78/iu
	etK8vPisuUo17HRA7YCoPDpmc0vNWYkauXyxLuBLjMtA/0HZVR1VlvKOP07RXdy4y1XmTXeThVx
	28+GvgHI+cMnI22iIax63FgE7rOwxW89iLd+NIOkIojaVHKApzGhU9v+Jtk3tQwrUAgfs/aCdzP
	vkg5l3Q3mKYzeA+QNllPwyAVgou28BT40qB5dNFsee3dhZQn/EB/OWwQ5O/y58lEjn4sWv6MC7d
	6aCXkuMyvyclBVE/KIRS4m9ws9YwG6PCQdaIJ/mt4IfYN+EgsxcZPIGvQ/3zhzXpwTrmHyhgabn
	7HpKc+/A8=
X-Google-Smtp-Source: AGHT+IFuIFRdqHBZCko8vFOdNi4YwrG+SNtH2f5JJFAo5fww3TZYrgIbpWxJK/MEue66sSX1sYEkLQ==
X-Received: by 2002:a05:6000:1ac6:b0:3df:f065:ca13 with SMTP id ffacd0b85a97d-3e64392b761mr17129810f8f.33.1757598577050;
        Thu, 11 Sep 2025 06:49:37 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760778915sm2608361f8f.12.2025.09.11.06.49.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Sep 2025 06:49:36 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH 0/6] KVM ARM64 pre_fault_memory
Date: Thu, 11 Sep 2025 14:46:42 +0100
Message-Id: <20250911134648.58945-1-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Overview:

This patch series adds ARM64 support for the KVM_PRE_FAULT_MEMORY
feature, which was previously only available on x86 [1]. This allows
a reduction in the number of stage-2 faults during execution. This is
beneficial in post-copy migration scenarios, particularly in memory
intensive applications, where high latencies are experienced due to
the stage-2 faults when pre-populating memory via UFFD / memcpy.

Patch Overview:

 - The first patch is a preparatory refactor.

 - The second patch is adding a page walk flag for pre-faulting.

 - The third patch adds support for the KVM_PRE_FAULT_MEMORY ioctl
   on arm64.

 - The fourth patch fixes an issue with unaligned mmap allocations
   in the selftests.

 - The fifth patch updates the pre_fault_memory_test to support
   arm64.

 - The last patch extends the pre_fault_memory_test to cover
   different vm memory backings.

[1]: https://lore.kernel.org/kvm/20240710174031.312055-1-pbonzini@redhat.com

Jack Thomson (6):
  KVM: arm64: Add __gmem_abort and __user_mem_abort
  KVM: arm64: Add KVM_PGTABLE_WALK_PRE_FAULT walk flag
  KVM: arm64: Add pre_fault_memory implementation
  KVM: selftests: Fix unaligned mmap allocations
  KVM: selftests: Enable pre_fault_memory_test for arm64
  KVM: selftests: Add option for different backing in pre-fault tests

 arch/arm64/include/asm/kvm_pgtable.h          |   3 +
 arch/arm64/kvm/Kconfig                        |   1 +
 arch/arm64/kvm/arm.c                          |   1 +
 arch/arm64/kvm/hyp/pgtable.c                  |   6 +-
 arch/arm64/kvm/mmu.c                          |  97 +++++++++++++--
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +-
 .../selftests/kvm/pre_fault_memory_test.c     | 110 +++++++++++++-----
 8 files changed, 186 insertions(+), 45 deletions(-)


base-commit: 42188667be387867d2bf763d028654cbad046f7b
-- 
2.43.0


