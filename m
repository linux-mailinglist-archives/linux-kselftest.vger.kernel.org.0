Return-Path: <linux-kselftest+bounces-15526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4BF954DD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605C01F2533A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97541BD4F9;
	Fri, 16 Aug 2024 15:33:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1311BDA83
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822388; cv=none; b=qzSJ/l4kS3qUN83Oh77QDhjPMKoENtRMZriYzc+7C2TQw5yhKKx5ExDmlfasbR+rqy4sqZdUzJ6aSe54qpKTiDSKKhHlye7OHs7FZy30S5UhUt1BoJr6noQJ1JFrY2sHlBvH5Y96gVqBF5YC25ZO+o2B/3S9wTFBmQWW+bJal5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822388; c=relaxed/simple;
	bh=c3Nel51DPL5mR5Cen2A6ubfKea42D4QiWE9HgNp5cVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZw0XkRDyM1+wCf0vnLBhNI5HFDLZ3F23SHbfDnge7e30qAFug5ZEewWL8n8aHNRa7rq6umX2Ylz7vRsxgMLWSmdM4Kw8K8NbhjpBv1/7y7e8gKNtoIEyFMh8SMsUEtUfbvl3Gt8N+jVDRzW9wTugxMFsjTcxGvbAjj5SISXn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D208C1474;
	Fri, 16 Aug 2024 08:33:32 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A6613F6A8;
	Fri, 16 Aug 2024 08:33:05 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 5/8] kselftest/arm64: mte: fix printf type warning about mask
Date: Fri, 16 Aug 2024 16:32:48 +0100
Message-Id: <20240816153251.2833702-6-andre.przywara@arm.com>
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

When masking the return value of a prctl, which is clearly an "int", we
use a uapi header provided mask, which is defined using an "UL" modifier,
so the whole expression is promoted to a long. This upsets the compiler's
printf type checker, because we use "%x" in the format string.

While we could simply upgrade this to a "%lx", it sounds wrong to
promote the "ret" variable, that is clearly an int.
Downcast the mask instead, to keep the type correct.

Fixes: e2d9642a5a51 ("kselftest/arm64: Add simple test for MTE prctl")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/check_prctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_prctl.c b/tools/testing/selftests/arm64/mte/check_prctl.c
index f139a33a43ef4..a16d7005affdf 100644
--- a/tools/testing/selftests/arm64/mte/check_prctl.c
+++ b/tools/testing/selftests/arm64/mte/check_prctl.c
@@ -81,11 +81,11 @@ void set_mode_test(const char *name, int hwcap2, int mask)
 		return;
 	}
 
-	if ((ret & PR_MTE_TCF_MASK) == mask) {
+	if ((ret & (int)PR_MTE_TCF_MASK) == mask) {
 		ksft_test_result_pass("%s\n", name);
 	} else {
 		ksft_print_msg("Got %x, expected %x\n",
-			       (ret & PR_MTE_TCF_MASK), mask);
+			       (ret & (int)PR_MTE_TCF_MASK), mask);
 		ksft_test_result_fail("%s\n", name);
 	}
 }
-- 
2.25.1


