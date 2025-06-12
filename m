Return-Path: <linux-kselftest+bounces-34784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D0FAD6638
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 05:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6693AD51C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 03:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A831F0E20;
	Thu, 12 Jun 2025 03:36:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4DD1EFF8D;
	Thu, 12 Jun 2025 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749699368; cv=none; b=Ww267lYjTA/ZM+2glpkamIKfbsw048jkl4X7ex48wsZFTy+n6iaTBocRLjKuZhYbUz0rCuTi7QRslIIL4cWXVRJaAzkMC8mu5Sze4zTuZ1bGyHzEyc1Sh/CRySa8DTzD32tcexwkPDhaq6p6ScraqKmPSydUPy5QJeuOzIYznGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749699368; c=relaxed/simple;
	bh=uMLZZIGntfima+Z+v7TifEE3E+4sqrRZ2e8DOcSjaoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kehYj1p32Tc87BYeVOuyVXxLz8e8DjoUWtWk1nV/0eJt6XGUdS5IBVVHwP1vkcERVxO2d8mqisfBmnYe+37YKYABQUQzFdLKZ1QazZjD948/lXjcuZP3wQIO7yHRQLpNxOTC3ak00Q8QxDI+wWzjzEJ5Sx8S8dFpiQIbEFAcyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55ECA1595;
	Wed, 11 Jun 2025 20:35:46 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 544983F66E;
	Wed, 11 Jun 2025 20:36:02 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH V4 2/2] KVM: selftests: Change MDSCR_EL1 register holding variables as uint64_t
Date: Thu, 12 Jun 2025 09:05:47 +0530
Message-Id: <20250612033547.480952-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250612033547.480952-1-anshuman.khandual@arm.com>
References: <20250612033547.480952-1-anshuman.khandual@arm.com>
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


