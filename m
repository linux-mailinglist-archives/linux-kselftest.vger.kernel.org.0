Return-Path: <linux-kselftest+bounces-34540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C115AAD2D53
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 07:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DC97A3BE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 05:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D325F7B4;
	Tue, 10 Jun 2025 05:31:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFE625EF9F;
	Tue, 10 Jun 2025 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533509; cv=none; b=QTHyVAxfBbj7T00DZCpSUEZNi+oR9lTS5ET/zhXMzaZ5koxo+YmLbvvvojBAeff2fXWsSWgmOXud1xfGupEnyavw7Bvb1r3efBVap482xrRKUdFEuS+3uHNX1WjOzyY9llGV4paPWIBrLgaQ+Wj5/egsVzHEw2PG8/wtkqlu3NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533509; c=relaxed/simple;
	bh=uMLZZIGntfima+Z+v7TifEE3E+4sqrRZ2e8DOcSjaoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qp+J0/P6tXOfEpQFUPTqWGF9TjgtObAuEz6Ee3UFj1fASMlcK0raS4liYj9Ms3UcS46L80qbAhfA831zVKcBnatbMcv97rd4UK3TlIyFZJ8WmrLIGv2KFKjzK1juxFB/J1NL0eO19Bn2QoJ6vN2i7uGexF6v5yIEJtc/y+LpWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAD9C2680;
	Mon,  9 Jun 2025 22:31:27 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F34723F59E;
	Mon,  9 Jun 2025 22:31:42 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH V3 2/2] KVM: selftests: Change MDSCR_EL1 register holding variables as uint64_t
Date: Tue, 10 Jun 2025 11:01:28 +0530
Message-Id: <20250610053128.4118784-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610053128.4118784-1-anshuman.khandual@arm.com>
References: <20250610053128.4118784-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change MDSCR_EL1 register holding local variables as uint64_t that reflects
its true register width as well.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: kvm@vger.kernel.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/testing/selftests/kvm/arm64/debug-exceptions.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/debug-exceptions.c b/tools/testing/selftests/kvm/arm64/debug-exceptions.c
index c7fb55c9135b..e34963956fbc 100644
--- a/tools/testing/selftests/kvm/arm64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/arm64/debug-exceptions.c
@@ -140,7 +140,7 @@ static void enable_os_lock(void)
 
 static void enable_monitor_debug_exceptions(void)
 {
-	uint32_t mdscr;
+	uint64_t mdscr;
 
 	asm volatile("msr daifclr, #8");
 
@@ -223,7 +223,7 @@ void install_hw_bp_ctx(uint8_t addr_bp, uint8_t ctx_bp, uint64_t addr,
 
 static void install_ss(void)
 {
-	uint32_t mdscr;
+	uint64_t mdscr;
 
 	asm volatile("msr daifclr, #8");
 
-- 
2.25.1


