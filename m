Return-Path: <linux-kselftest+bounces-44660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75733C2D262
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 17:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B2D54E6470
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1EA31AF3C;
	Mon,  3 Nov 2025 16:32:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B131AF1B;
	Mon,  3 Nov 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187562; cv=none; b=nQO5dyV0q8ivCZfcEgNg91yDVUJ7O0uTQH5pcSKY43mFyJlg4viPRWaCUFs6OTGqb1V4Ff4tgdPeC9d3hgJhT2+lk2EHvvCv71XyoiOM5KG3YbgK/w0aLfmR9eeTXFzBGuyYiuArsXn33+vzzDCRSdAse9s6BI/StPhg2nQz6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187562; c=relaxed/simple;
	bh=dCRw6WmlS1EPXO9RXPpnEeqeKYu5DaXOb+yI5nu93NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGqO5OWfQIV3M7ee0QtUqF3pg1kze+eMg9z5L9CmErfn4L6v3v3qsNhfbVjj9c4J1gFHNQN9KsUxXkrvyXKbRvi9POwTJv3CynZwoYhoqlaPhMtmW6ob03z1yjSjPs628FfY8845NoLLnvrqDRaUHS/Q7qcnHsRZfjveRdrzjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64A242BCB;
	Mon,  3 Nov 2025 08:32:32 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 056783F694;
	Mon,  3 Nov 2025 08:32:36 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	miko.lenczewski@arm.com,
	kevin.brodsky@arm.com,
	ardb@kernel.org,
	suzuki.poulose@arm.com,
	lpieralisi@kernel.org,
	yangyicong@hisilicon.com,
	scott@os.amperecomputing.com,
	joey.gouly@arm.com,
	yuzenghui@huawei.com,
	pbonzini@redhat.com,
	shuah@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v10 3/9] KVM: arm64: kselftest: set_id_regs: add test for FEAT_LSUI
Date: Mon,  3 Nov 2025 16:32:18 +0000
Message-Id: <20251103163224.818353-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103163224.818353-1-yeoreum.yun@arm.com>
References: <20251103163224.818353-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test coverage for FEAT_LSUI.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 5e24f77868b5..f5ba72127464 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -125,6 +125,7 @@ static const struct reg_ftr_bits ftr_id_aa64isar2_el1[] = {
 
 static const struct reg_ftr_bits ftr_id_aa64isar3_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, FPRCVT, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, LSUI, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, LSFE, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, FAMINMAX, 0),
 	REG_FTR_END,
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


