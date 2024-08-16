Return-Path: <linux-kselftest+bounces-15529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FF2954DDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C422819C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567ED1BE250;
	Fri, 16 Aug 2024 15:33:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56EC1BE222
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822393; cv=none; b=mdcB0jmRQFYqiwBDEF7Xq5kQf2bPm1JJAimjBZ3wlbyFS+SC4L1vnRrfrASCoSFzIIbO6pCjJ2NCm3C29B4pEYI0fdyniGSoHYySy56Q/qtcPVHF7YJjNmQ16llGB48WrjK1RsZULWEeQs9nDUq4h9XS2hz3QnFo8S/buQ3FsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822393; c=relaxed/simple;
	bh=4HHmRTp93GqmEj63AFFtg7untqaNisvZ6t9lb6n1DIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lP4cUzRgPmnLwHda0GYxY9/6/Gxo0ZpPlbuggMccMc1SSN1ejzl3ZWCA3iDQDfPOAjde2aeKtHUxVMCHCR/XIzGOopPKO0nfr+9iI31/l1jRnckZwUQbIl77tkw7gnQQawIt2CWCKVKgyvIyh+sSf8UVdNTDUNvFos/2Zx7GKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84DF1143D;
	Fri, 16 Aug 2024 08:33:37 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4191B3F6A8;
	Fri, 16 Aug 2024 08:33:10 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 8/8] kselftest/arm64: mte: fix printf type warnings about longs
Date: Fri, 16 Aug 2024 16:32:51 +0100
Message-Id: <20240816153251.2833702-9-andre.przywara@arm.com>
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

When checking MTE tags, we print some diagnostic messages when the tests
fail. Some variables uses there are "longs", however we only use "%x"
for the format specifier.

Update the format specifiers to "%lx", to match the variable types they
are supposed to print.

Fixes: f3b2a26ca78d ("kselftest/arm64: Verify mte tag inclusion via prctl")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
index 2b1425b92b699..a3d1e23fe02af 100644
--- a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
+++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
@@ -65,7 +65,7 @@ static int check_single_included_tags(int mem_type, int mode)
 			ptr = mte_insert_tags(ptr, BUFFER_SIZE);
 			/* Check tag value */
 			if (MT_FETCH_TAG((uintptr_t)ptr) == tag) {
-				ksft_print_msg("FAIL: wrong tag = 0x%x with include mask=0x%x\n",
+				ksft_print_msg("FAIL: wrong tag = 0x%lx with include mask=0x%x\n",
 					       MT_FETCH_TAG((uintptr_t)ptr),
 					       MT_INCLUDE_VALID_TAG(tag));
 				result = KSFT_FAIL;
@@ -97,7 +97,7 @@ static int check_multiple_included_tags(int mem_type, int mode)
 			ptr = mte_insert_tags(ptr, BUFFER_SIZE);
 			/* Check tag value */
 			if (MT_FETCH_TAG((uintptr_t)ptr) < tag) {
-				ksft_print_msg("FAIL: wrong tag = 0x%x with include mask=0x%x\n",
+				ksft_print_msg("FAIL: wrong tag = 0x%lx with include mask=0x%lx\n",
 					       MT_FETCH_TAG((uintptr_t)ptr),
 					       MT_INCLUDE_VALID_TAGS(excl_mask));
 				result = KSFT_FAIL;
-- 
2.25.1


