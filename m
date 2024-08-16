Return-Path: <linux-kselftest+bounces-15523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A8A954DD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB66C1F252EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375A31BE242;
	Fri, 16 Aug 2024 15:33:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F01B86C0
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822384; cv=none; b=qVSh5xZQ9xhIvncx0VlAIPfrLJ1Nyu9WBb9Yj4qwZ0RFOfHcld7HpBdaMA3YvGfcEzei8fTE4T0AhW7P16Q9FwO0nmNYuR5SB/8txFCPzM4+Nn6U91w27BCHe5VpZml+LovVXD182JGdQrEfXlJ33An8VQzVWwf1TiABXBWCH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822384; c=relaxed/simple;
	bh=F4A6iB7NuJUWyvRfmnQhO/95DGm8UrBlcxTGeIFvXjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaLjCb1hIeSDXTaX9UgbXum7iovo2aVv/vR0IftD9tejN8q+zlSQyYDkJR+iQw+4feb10xEC2P5J7Eh6TTs5BdjZdlbPiVElMgdDZ/S+8fzyqbg15tOvH6WncMAH1qze8YpR1lMkHEwYB83oQSB6NPb8X3P0rz3eR0SX+1KqQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 257DA13D5;
	Fri, 16 Aug 2024 08:33:28 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3C383F6A8;
	Fri, 16 Aug 2024 08:33:00 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/8] kselftest/arm64: hwcap: fix f8dp2 cpuinfo name
Date: Fri, 16 Aug 2024 16:32:45 +0100
Message-Id: <20240816153251.2833702-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816153251.2833702-1-andre.przywara@arm.com>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The F8DP2 DPISA extension has a separate cpuinfo field, named
accordingly.
Change the erroneously placed name of "f8dp4" to "f8dp2".

Fixes: 44d10c27bd75 ("kselftest/arm64: Add 2023 DPISA hwcap test coverage")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index d8909b2b535a0..41c245478e412 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -484,7 +484,7 @@ static const struct hwcap_data {
 		.name = "F8DP2",
 		.at_hwcap = AT_HWCAP2,
 		.hwcap_bit = HWCAP2_F8DP2,
-		.cpuinfo = "f8dp4",
+		.cpuinfo = "f8dp2",
 		.sigill_fn = f8dp2_sigill,
 	},
 	{
-- 
2.25.1


