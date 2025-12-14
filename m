Return-Path: <linux-kselftest+bounces-47558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB40CBBA49
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 12:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DEBD302EA23
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 11:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C914B31329C;
	Sun, 14 Dec 2025 11:23:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66E31352E;
	Sun, 14 Dec 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765711391; cv=none; b=H6HRWEcDheBXmcq3+aaujWV/SCIqr9OLguYExmzLKufB42KjqRXtGNTuR/TrWf0H4oASI2g5K4SvUHGc7ExFp7zLHgFdaCPRUkO980r3NqSQMni3iklISsUIDsTT1CDPz4ssIhwHHFqJVMmjea5DEnHSgRDRNy4Taj+gBTnosNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765711391; c=relaxed/simple;
	bh=7VsUcbzGs9P7EOJt4iMkJPSvEPgm4d8IU1/ZhDNemAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCKCDImoz8O5LcblxdE7voVKosK7SHV7vvTH8ym+tUwHs77ObBunt+A/uHhqMDshq36QgwwtmccvLr6B16myvVL+fWm+lyBv8fKPiEQx+Ka65LruhpF20QXaYb5QGUSMGPmxLyGV0KMTu46Q2cAfQ8cXWNEY2SE7qSCAG4xJzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 616541063;
	Sun, 14 Dec 2025 03:23:02 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 408853F73B;
	Sun, 14 Dec 2025 03:23:06 -0800 (PST)
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
	mark.rutland@arm.com,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v11 RESEND 4/9] arm64: Kconfig: Detect toolchain support for LSUI
Date: Sun, 14 Dec 2025 11:22:43 +0000
Message-Id: <20251214112248.901769-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251214112248.901769-1-yeoreum.yun@arm.com>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Armv9.6, FEAT_LSUI supplies the load/store instructions for
previleged level to access to access user memory without clearing
PSTATE.PAN bit.
It's enough to add CONFIG_AS_HAS_LSUI only because the code for LSUI uses
individual `.arch_extension` entries.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93173f0a09c7..36e87a1a1b5c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2227,6 +2227,11 @@ config ARM64_GCS

 endmenu # "ARMv9.4 architectural features"

+config AS_HAS_LSUI
+	def_bool $(as-instr,.arch_extension lsui)
+	help
+	  Supported by LLVM 20+ and binutils 2.45+.
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


