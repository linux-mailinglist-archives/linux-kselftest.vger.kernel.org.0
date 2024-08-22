Return-Path: <linux-kselftest+bounces-16100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63F95B9EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7C2B2322D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167E1CCB23;
	Thu, 22 Aug 2024 15:13:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DAA1CCEC6;
	Thu, 22 Aug 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339607; cv=none; b=dD9VPiCYLFyGVIYG/NvldH9lmKowF3DKUs5194xN5BOR1I4owNacCKnJlDOd5cecU/zv3POZ3EPVcxZps79nE3233iajgQr4bVZLvUY+E/PbOMjohUUaXpD+TdjAw4TjhklaGTwMUH3KMIZDg22d6dNQoyvCQU/KHu6Wsv7I0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339607; c=relaxed/simple;
	bh=b67WGb9A0sEvTu2uiZmSdX8VMQfwpwjxrlOqQTIUen0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9eMMTnUzjSur0gZCEqbhMlH86dNAR4cOJngPyKfa3SHc5PpG3YTK3ZYsgpf+Wdft51U8e14zJCWV6wmm2XpfnYOcbLDYpKmpdrEWz18lyU3nQ7CEh1MoWTkiP5AEHJYrH/dgdeljEsraDE87U5y7jJQvVZ/Ve6fluKYEH8gR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7664D168F;
	Thu, 22 Aug 2024 08:13:51 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 580D03F58B;
	Thu, 22 Aug 2024 08:13:21 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 28/30] kselftest/arm64: parse POE_MAGIC in a signal frame
Date: Thu, 22 Aug 2024 16:11:11 +0100
Message-Id: <20240822151113.1479789-29-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822151113.1479789-1-joey.gouly@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the signal frame parsing about the new POE frame, avoids warning when it
is generated.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git tools/testing/selftests/arm64/signal/testcases/testcases.c tools/testing/selftests/arm64/signal/testcases/testcases.c
index e4331440fed0..e6daa94fcd2e 100644
--- tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -161,6 +161,10 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			if (head->size != sizeof(struct esr_context))
 				*err = "Bad size for esr_context";
 			break;
+		case POE_MAGIC:
+			if (head->size != sizeof(struct poe_context))
+				*err = "Bad size for poe_context";
+			break;
 		case TPIDR2_MAGIC:
 			if (head->size != sizeof(struct tpidr2_context))
 				*err = "Bad size for tpidr2_context";
-- 
2.25.1


