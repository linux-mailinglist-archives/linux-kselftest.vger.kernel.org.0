Return-Path: <linux-kselftest+bounces-15525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5013E954DD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9D41F25345
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66461BD013;
	Fri, 16 Aug 2024 15:33:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD71BE248
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822386; cv=none; b=aQuXm842n2TIf1RrHOeUwllG3lwWToIw+vx9SZrUUJ2PFrzN4pGZlWUSwvoIpOj/x0OJ5rxsUUATjmGVrKPq5TdYLR2LVHnfCGwP8ZFzSLuf6NJNEJ0Iq/9vDglHc28W3l62b4OJ6TGiMZYCBgXER/kRmp/7HtNGc4QGHA2M9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822386; c=relaxed/simple;
	bh=ApJeYtbxNSArFUB0Ue8DX4cCm69RtmcINMhpQK4gS2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fM/RtBs/f61Z4RukWv4+M44maE4JCD8EKwuz+juBs+Y1IdrFnNUo1GucUMnRY02SuNHM7PA0zt4TF25F0VwQRdLn6JuigbWGOTtYyKNnol16+BtPVyuVeQFh0yfJeTCYOudlxpntnTgSMRFBch5I7seSf3FNLmDTz49XHIk5Ofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E3A513D5;
	Fri, 16 Aug 2024 08:33:31 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF0683F6A8;
	Fri, 16 Aug 2024 08:33:03 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/8] kselftest/arm64: mte: use string literal for printf-style functions
Date: Fri, 16 Aug 2024 16:32:47 +0100
Message-Id: <20240816153251.2833702-5-andre.przywara@arm.com>
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

Using pointers for the format specifier strings in printf-style
functions can create potential security problems, as the number of
arguments to be parsed could vary from call to call. Most compilers
consequently warn about those:
"format not a string literal and no format arguments [-Wformat-security]"

If we only want to print a constant string, we can just use a fixed "%s"
format instead, and pass the string as an argument.

Fixes: e9b60476bea0 ("kselftest/arm64: Add utilities and a test to validate mte memory")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/mte_common_util.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.h b/tools/testing/selftests/arm64/mte/mte_common_util.h
index 2d3e71724e55c..a0017a303beb2 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.h
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.h
@@ -77,13 +77,13 @@ static inline void evaluate_test(int err, const char *msg)
 {
 	switch (err) {
 	case KSFT_PASS:
-		ksft_test_result_pass(msg);
+		ksft_test_result_pass("%s", msg);
 		break;
 	case KSFT_FAIL:
-		ksft_test_result_fail(msg);
+		ksft_test_result_fail("%s", msg);
 		break;
 	case KSFT_SKIP:
-		ksft_test_result_skip(msg);
+		ksft_test_result_skip("%s", msg);
 		break;
 	default:
 		ksft_test_result_error("Unknown return code %d from %s",
-- 
2.25.1


