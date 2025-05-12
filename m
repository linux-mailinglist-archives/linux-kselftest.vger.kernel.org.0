Return-Path: <linux-kselftest+bounces-32855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749CBAB3614
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 13:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A7A3BDFF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA76D292932;
	Mon, 12 May 2025 11:41:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE519F101;
	Mon, 12 May 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050092; cv=none; b=AlxqbRJa3ogXDXvdaotsXy1eIQF2N9/Yu2J+FsxS6SdJ2x2IEloEshj8rxtIHWxCWs2SZUbnBWQm5b5XKcu8UaYTpddTwfBe/kwDeKT7doVUfT1HgT1yNv9Go0ZZ47ecRClajT0LdhTzgGwkIumm+4YlbQATUmZfynEUqO49HRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050092; c=relaxed/simple;
	bh=mWYcgjGOa+RvdxWeiM3aiO+amws/xXynTcpOsBkdzkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2NDQ3PxvoYwSNpvcQ+TVO/S8m98qy6UFOW77NNIr1QTVXxCN1glTzjliZxI5Os4Hvl6+8EGgqFHJmZLn/lW8+OQEUsimdvvwugEyUie2M6maKCmeKL8AyaOADXtUIb3wchACIP/Tludk2x04fLl/vqpiggO40tc5CsLS/0P+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B04B150C;
	Mon, 12 May 2025 04:41:19 -0700 (PDT)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E57673F5A1;
	Mon, 12 May 2025 04:41:27 -0700 (PDT)
From: Ben Horgan <ben.horgan@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	pbonzini@redhat.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: james.morse@arm.com,
	Ben Horgan <ben.horgan@arm.com>
Subject: [RFC PATCH v2 0/3] KVM: arm64: Don't claim MTE_ASYNC if not supported
Date: Mon, 12 May 2025 12:41:09 +0100
Message-ID: <20250512114112.359087-1-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ID_AA64PFR1_EL1.MTE_frac field is currently hidden from KVM.
However, when ID_AA64PFR1_EL1.MTE==2, ID_AA64PFR1_EL1.MTE_frac==0
indicates that MTE_ASYNC is supported. On a host with
ID_AA64PFR1_EL1.MTE==2 but without MTE_ASYNC support a guest with the
MTE capability enabled will incorrectly see MTE_ASYNC advertised as
supported. This series fixes that.

This was found by inspection and the current behaviour is not known to
break anything. Linux doesn't check MTE_frac, and wrongly, assumes
MTE async faults can be generated whenever MTE is supported. This is
a separate problem and not addressed here.

I am looking for feedback on whether this change is valuable or
otherwise.

Changes since v1:
        Only pass MTE_Frac hw value to the guest when it is the exact failure case.
        Changed base commit to v6.15-rc5 but still applies on v6.16-rc2 as well.

Ben Horgan (3):
  arm64/sysreg: Expose MTE_frac so that it is visible to KVM
  KVM: arm64: Make MTE_frac masking conditional on MTE capability
  KVM: selftests: Confirm exposing MTE_frac does not break migration

 arch/arm64/kernel/cpufeature.c                |  1 +
 arch/arm64/kvm/sys_regs.c                     | 28 ++++++-
 .../testing/selftests/kvm/arm64/set_id_regs.c | 77 ++++++++++++++++++-
 3 files changed, 103 insertions(+), 3 deletions(-)


base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.43.0


