Return-Path: <linux-kselftest+bounces-32856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC156AB360A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5F717B796
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86FE292933;
	Mon, 12 May 2025 11:41:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B325B1E3;
	Mon, 12 May 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050100; cv=none; b=Ye7KK4MLDEmj5XWIntyjge/gj/liQJsm4qHuaCXvQ6lRTaAD8/C/t/xnvUMeGOCCSnbNY4REObNQWZqa2aKDHtOvu1FVCtPljks7pp06kdfgb0XSTNaQht19BgdJd/cQRGZAHedcuV1q5JthBUQnZuzFfqIV9YDF894IMSyCZ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050100; c=relaxed/simple;
	bh=wHTey9QES+7TBCCs12VEYIzamkYQTCFcXGKfYKmAobE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i77liELleM1/SllxuPnmFwGw4oJ2lCH/nTEZNU3Lx/2hArxcQNJ7mBLZYox87YrzOUg3+BX6ltvWVw8SKkSIuSU4AO3ZM187nwxWMPHJzdslXwPfDoQc+4zy6VeqwUq1AmhOZvk0XGtUIOR+hn38Rt9Xx2xosEO9CjbAVNkOcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCBB11515;
	Mon, 12 May 2025 04:41:25 -0700 (PDT)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 64C8A3F5A1;
	Mon, 12 May 2025 04:41:34 -0700 (PDT)
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
Subject: [RFC PATCH v2 1/3] arm64/sysreg: Expose MTE_frac so that it is visible to KVM
Date: Mon, 12 May 2025 12:41:10 +0100
Message-ID: <20250512114112.359087-2-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512114112.359087-1-ben.horgan@arm.com>
References: <20250512114112.359087-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM exposes the sanitised ID registers to guests. Currently these ignore
the ID_AA64PFR1_EL1.MTE_frac field, meaning guests always see a value of
zero.

This is a problem for platforms without the MTE_ASYNC feature where
ID_AA64PFR1_EL1.MTE==0x2 and ID_AA64PFR1_EL1.MTE_frac==0xf. KVM forces
MTE_frac to zero, meaning the guest believes MTE_ASYNC is supported, when
no async fault will ever occur.

Before KVM can fix this, the architecture needs to sanitise the ID
register field for MTE_frac.

Linux itself does not use MTE_frac field and just assumes MTE async faults
can be generated if MTE is supported.

Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9c4d6d552b25..e952f4b07ce1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -298,6 +298,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_GCS),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_GCS_SHIFT, 4, 0),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_MTE_frac_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_SME_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_MPAM_frac_SHIFT, 4, 0),
-- 
2.43.0


