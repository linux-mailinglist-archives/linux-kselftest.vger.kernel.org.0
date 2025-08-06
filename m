Return-Path: <linux-kselftest+bounces-38361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95897B1C2EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 11:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B9A3A602E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8B289810;
	Wed,  6 Aug 2025 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="XEsBx9IL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06892AD2F;
	Wed,  6 Aug 2025 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471476; cv=none; b=Abxu57uklSxvEFlZblivOnQ/5uP1nCDoZOSXy0fBHi+oewhornODAXwHw8PIj3xNP3Xkvoh+oEdxV12oOzTJaXPMzoPW2+NWZf3KiTQyoiU/u0ZF+OodErAs/xutYzcls4Ev61iHcEWGIJ6xsXfaMyJE4a6bXPvNJtdNNPHL3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471476; c=relaxed/simple;
	bh=31I6WjXhRwY1ZO5yYnIVtAEAXW02SAJ1j4oJyCrK7cU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jnqtmrXMdnjTZ47iOczjDEq0UaEMjaH0BnWNYFsGzWHUBrRIECqd6bN31G7u0h5dNkKzkZHZTACgrVLqRalK3ypwYXv1Q2etzFle28Ut/v5kCrqraHIiw8lje0yGlueb5SOAXiajcAPk1R9kyhxRcDhrWNL82WDlWXHanDG1Aas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=XEsBx9IL reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5769A4Q3005818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 6 Aug 2025 18:10:13 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=04SbAc//VYkDj1IMLyHG/BmwbhPG6uTcl3uHd/dz/BI=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Subject:Date:Message-Id:To;
        s=rs20250326; t=1754471413; v=1;
        b=XEsBx9IL1udj/IyQHko/lhxsGUKJnAMTGyD6LZOzTQNNIBBMmB+owrZBhNRAY3Zt
         DCl7SGKRwTdo0a/DCr88QNE4yZrv4Y4qiMvLI8Ba48/tWugukGW0HkDvgp1brHEY
         WMAGmkFQHI3jbtf3vHTgRpLTMVbCrMhB/NQVPTDKJ0JdM6hwuRB50Memt2+KbBTE
         UbiasCzNdvjQSKAKqJi7qqwybDdmOLx6wgUtcpV/fMk/2TKAaSTBx9s6LfhA+qEi
         L/Ly7LCfvGHHUshrmn+2UFUI4eqTLbNHiWdAiTdysMPTWcuWwPe5gb63gFtw9E9y
         4fxayjyrq+lW7QIi7WGvPA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH RFC v2 0/2] KVM: arm64: PMU: Use multiple host PMUs
Date: Wed, 06 Aug 2025 18:09:53 +0900
Message-Id: <20250806-hybrid-v2-0-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOEbk2gC/zWOyw6CMBBFf4XM2pK28oisTEz8ALeGRWEGmQWgL
 TYQwr/bVF3eOyfnzgaOLJODKtnAkmfH0xiCPiTQ9mZ8kGAMGbTUudQ6E/3aWEYhFeZdl5WEqCH
 AT0sdL1F0h9v1AvW3tPR6B+n8uzTGkWinYeC5SnyRqiKCPbt5smv8wqtIxsGjOv0HvRJKZKgMG
 iWplPkZzTrykgYb1Pu+fwAs6cmzywAAAA==
X-Change-ID: 20250224-hybrid-01d5ff47edd2
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2

On heterogeneous arm64 systems, KVM's PMU emulation is based on the
features of a single host PMU instance. When a vCPU is migrated to a
pCPU with an incompatible PMU, counters such as PMCCNTR_EL0 stop
incrementing.

Although this behavior is permitted by the architecture, Windows does
not handle it gracefully and may crash with a division-by-zero error.

The current workaround requires VMMs to pin vCPUs to a set of pCPUs
that share a compatible PMU. This is difficult to implement correctly in
QEMU/libvirt, where pinning occurs after vCPU initialization, and it
also restricts the guest to a subset of available pCPUs.

This patch introduces the KVM_ARM_VCPU_PMU_V3_COMPOSITION attribute to
create a "composite" PMU. When set, KVM exposes a PMU that is compatible
with all pCPUs by advertising only a single cycle counter, a feature
common to all PMUs.

This allows Windows guests to run reliably on heterogeneous systems
without crashing, even without vCPU pinning, and enables VMMs to
schedule vCPUs across all available pCPUs, making full use of the host
hardware.

A QEMU patch that demonstrates the usage of the new attribute is
available at:
https://lore.kernel.org/qemu-devel/20250806-kvm-v1-1-d1d50b7058cd@rsg.ci.i.u-tokyo.ac.jp/
("[PATCH RFC] target/arm/kvm: Choose PMU backend")

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Added the KVM_ARM_VCPU_PMU_V3_COMPOSITION attribute to opt in the
  feature.
- Added code to handle overflow.
- Link to v1: https://lore.kernel.org/r/20250319-hybrid-v1-1-4d1ada10e705@daynix.com

---
Akihiko Odaki (2):
      KVM: arm64: PMU: Introduce KVM_ARM_VCPU_PMU_V3_COMPOSITION
      KVM: arm64: selftests: Test guest PMUv3 composition

 Documentation/virt/kvm/devices/vcpu.rst            |  30 ++
 arch/arm64/include/asm/kvm_host.h                  |   2 +
 arch/arm64/include/uapi/asm/kvm.h                  |   1 +
 arch/arm64/kvm/arm.c                               |   5 +-
 arch/arm64/kvm/pmu-emul.c                          | 495 +++++++++++++--------
 arch/arm64/kvm/sys_regs.c                          |   2 +-
 include/kvm/arm_pmu.h                              |  12 +-
 .../selftests/kvm/arm64/vpmu_counter_access.c      | 148 ++++--
 8 files changed, 461 insertions(+), 234 deletions(-)
---
base-commit: 8ec6d99a41e3d1dbdff2bdb3aa42951681e1e76c
change-id: 20250224-hybrid-01d5ff47edd2

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


