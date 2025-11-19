Return-Path: <linux-kselftest+bounces-45995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A67C6FE7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34EBD3682D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34636C0A0;
	Wed, 19 Nov 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlCX45z3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2FB36C0C8
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567367; cv=none; b=SH4WfB9qwhLvagVtdR5rCbByGFYafuR3SswudNM77JaoM3S5jKqHLVXvB+P2X2zFyTY3mC4xdHuEa5su6rshexQclCZUrZOPQUreVQf1w9Q/dxDwhzDxc5lbzeI6b28wMiiHAszfu9YP4eF9BfwnZ0IjFCZHVwCcoCFFxaGKr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567367; c=relaxed/simple;
	bh=e9o1/GNMLjcy+Zk5rqn6PgwLxkXMSjNL5BWwJUqnu/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hs3+R4KBeB8y8NsUC1NhJGHodCKknLy1rcM45IkcmuwFd+6o9Go2NPf89q5INFfK5RVQKXFO/yeb5OtY+e6Dzee+ojQookF+VA3aBp9kwVWkELaPj0YgMXnbcTPuG0Vrb8X8psPj8AplfYV6DP6zrg3gpYcbMByQwAAS6kO42S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlCX45z3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b427cda88so4952748f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763567364; x=1764172164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zsMgANA5eM7ZKAX6n6+aWoRlKM8M0oaGArWvq51zEek=;
        b=nlCX45z326861M0Ts/dYSqIsTqwIWlt6Rz5v0Gqss+9sGUMLX96Ogm7lu1ktG0c+sA
         f1zeL0Of8o6tf+NHcLeTiY99fgnMsWyBRt90KvqYEVOjRUcF6jwlVv4OSVbORdWpJvMc
         gKKG9J5eXy38J9IsjA0ShakNLUdQM9Xg7XAHLfmbZA8Yn8J0d5B7mL18YHOP3NQN1Wqy
         SKnIsRz3XIHkmDDlbIO/lKxfNQdmsyhPztm+ZsuCEw+XdafSd3NXLHZRyRQ8D6s29BuQ
         W0P5xVisnuElScH1mG3uzn5KS7JXpXwaYLRPMuUFo3+1bB3M0SefsrhkwpPQEbyHsbKG
         BWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567364; x=1764172164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsMgANA5eM7ZKAX6n6+aWoRlKM8M0oaGArWvq51zEek=;
        b=FiUyBYwYxwT9oLIV+kaUJGOhEbOM//FA/lICzqP166e1obv86qz140OeJnSPxdurTe
         HZTUgp6hj02ZxxwkL5N2DxRDWiNAy0TvMbpBDWL0wzw0FmFmKrTDACLPIKyADbYzLJv6
         iLliJUgbLR7/IhKX816HeA9ZgOGxhNbaGNLQNW3GzsW1SsKAIdPcpy2v44rTvNYLk5Vg
         mQpKnCAXz3vi8TPPeFmgGZgoDkDYfXpdV1dyK+Ju4uELI0sHZjQ0k0G8DQXe686qLyiR
         HKBqEz7vp05eOK+xJHwoV3Jq9oCy6niXZ772Axt2sg06/LSqe7PWvnSDknhCH1KBGhMf
         /Isw==
X-Forwarded-Encrypted: i=1; AJvYcCWIBhsdTyU4XNe0ktQTj4KaMvOJDkQiRBh9P8b20x/PTVqiQnTIGM/rwB89hQI3E/Gv/kBnO8zEHobFoft479c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3kNIbxK3+3YKJB5a0vuVtquUJA8v7Yx5wnTLpi+t400+1qVY
	e25lewmIquEwWb+HSNp5QA690gsRLLi644XOSM+zjXU1PJrqU6wGFvbZ
X-Gm-Gg: ASbGncszd6qFB3Bv/zzCWXcgABc2im1qh16sGBrw6psirOlPq8BLjQesv2pX6Fw5CON
	+d7WACoFaGqSiBRxS4JDbPkHaq2t/1oBDEyXDIHq2xv1vEMVgF5Vyoptl4T0ymLqivoGqGsnEDk
	itleuv2FvMxk6Nenr8OR5bZ5xesA+tVshitzB35757v5/W7G9d8UTdUsYXP5p0bUk9JtW51268F
	m8c4A4/03N1HA8oOn9FaUSe06Yx1uKernnORAbW4G7+HFsMc0++914GKQknZLNAieby7I79FRBI
	X9m+HRmgVOj70vF37us781uQZ4kH9RlDd6JMgzEEzbuo+tpxs4BdRmktE6lMJVAshbzf2NGhTFL
	ZzwRDuJEoj7lk+IP5dcwKse8bya7PaaYet4i4RqPn6YUSoSpNGR47bip96nFWD24geApTCwqIAt
	AafewUQP0hf0lVcHmZMkHI87VkDNxcGzbOCzjfsAGdDpuiXCPUTf/+Wj2OPqa82nn6VQ==
X-Google-Smtp-Source: AGHT+IHKBCKSyXwqmqDibyNSehgzgh3KJ1v3HqV1svmFXRruujCX1mFQdmNmlH2lr9fy9Bcfr5S55w==
X-Received: by 2002:a05:6000:4024:b0:42b:2dd5:42be with SMTP id ffacd0b85a97d-42b593234e0mr18915716f8f.8.1763567364171;
        Wed, 19 Nov 2025 07:49:24 -0800 (PST)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42c9628ebacsm25969755f8f.30.2025.11.19.07.49.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Nov 2025 07:49:23 -0800 (PST)
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
	xmarcalx@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH v3 0/3] KVM ARM64 pre_fault_memory
Date: Wed, 19 Nov 2025 15:49:07 +0000
Message-ID: <20251119154910.97716-1-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

This patch series adds ARM64 support for the KVM_PRE_FAULT_MEMORY
feature, which was previously only available on x86 [1]. This allows us
to reduce the number of stage-2 faults during execution. This is of
benefit in post-copy migration scenarios, particularly in memory
intensive applications, where we are experiencing high latencies due to
the stage-2 faults.

Patch Overview:

 - The first patch adds support for the KVM_PRE_FAULT_MEMORY ioctl
   on arm64.

 - The second patch updates the pre_fault_memory_test to support
   arm64.

 - The last patch extends the pre_fault_memory_test to cover
   different vm memory backings.

=== Changes Since v2 [2] ===

 - Update fault info synthesize value. Thanks Suzuki
 - Remove change to selftests for unaligned mmap allocations. Thanks
   Sean

[1]: https://lore.kernel.org/kvm/20240710174031.312055-1-pbonzini@redhat.com
[2]: https://lore.kernel.org/linux-arm-kernel/20251013151502.6679-1-jackabt.amazon@gmail.com

Jack Thomson (3):
  KVM: arm64: Add pre_fault_memory implementation
  KVM: selftests: Enable pre_fault_memory_test for arm64
  KVM: selftests: Add option for different backing in pre-fault tests

 Documentation/virt/kvm/api.rst                |   3 +-
 arch/arm64/kvm/Kconfig                        |   1 +
 arch/arm64/kvm/arm.c                          |   1 +
 arch/arm64/kvm/mmu.c                          |  73 +++++++++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/pre_fault_memory_test.c     | 110 ++++++++++++++----
 6 files changed, 159 insertions(+), 30 deletions(-)


base-commit: 8a4821412cf2c1429fffa07c012dd150f2edf78c
-- 
2.43.0


