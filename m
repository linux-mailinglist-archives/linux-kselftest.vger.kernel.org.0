Return-Path: <linux-kselftest+bounces-30676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D5A880A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698B9188CDBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5292BE7B8;
	Mon, 14 Apr 2025 12:41:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4D265609
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634489; cv=none; b=Ovz1S36cHrCaWUzPgeXxfQ8KqP3m61RBeHm3/vj5P2/NzFRZj6PYm/pEpFLGuv7yDxfKZUIKHkauDRv/TDjp1dx4uUmMepxQSNdkA8pUEu9n/e4cWtR6CwVtKClvU4bJQlodmm2LIAXJsYExyiINXHFmtf3Ju48tTHc2udaNf5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634489; c=relaxed/simple;
	bh=MMGJcrit5E+8HKltqSIE+k6eVkjbOsIYZB0n+a/Ah/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+68yXeLLUCWf+Vrj2E6nPm74uzS8gZWI48CgxDfWqZB1xeT8f9fXewlXjDnedyXrkOsTnlX4CVGebio2yFBSCaGPQFX55sAGqPhyxpW7/r7vGJV1Vg5WPrVu4KvLy1rekhTRHu4DdC4WIAH81zZaWC6zJvzxySis2sMcAs/tRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EB091007;
	Mon, 14 Apr 2025 05:41:25 -0700 (PDT)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91BAA3F59E;
	Mon, 14 Apr 2025 05:41:24 -0700 (PDT)
From: Ben Horgan <ben.horgan@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Cc: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	shuah@kernel.org,
	Ben Horgan <ben.horgan@arm.com>
Subject: [RFC PATCH 0/3] KVM: arm64: Don't claim MTE_ASYNC if not supported
Date: Mon, 14 Apr 2025 13:40:56 +0100
Message-ID: <20250414124059.1938303-1-ben.horgan@arm.com>
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

Ben Horgan (3):
  arm64/sysreg: Expose MTE_frac so that it is visible to KVM
  KVM: arm64: Make MTE_frac masking conditional on MTE capability
  KVM: selftests: Confirm exposing MTE_frac does not break migration

 arch/arm64/kernel/cpufeature.c                |  1 +
 arch/arm64/kvm/sys_regs.c                     | 26 ++++++-
 .../testing/selftests/kvm/arm64/set_id_regs.c | 77 ++++++++++++++++++-
 3 files changed, 101 insertions(+), 3 deletions(-)


base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
-- 
2.43.0


