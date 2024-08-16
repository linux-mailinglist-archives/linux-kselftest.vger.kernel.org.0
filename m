Return-Path: <linux-kselftest+bounces-15528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61E954DDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252851F2502F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6501BDAA1;
	Fri, 16 Aug 2024 15:33:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86081BDA86
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822392; cv=none; b=CkBa/qYjS8S+7Y7WVF0PfX3vBUsPnn5HCAcQHzZn6XyNkEhfGhcBL+hqm3/+/HleqZw0wwYZP0TgMl2LCpq1WUKjIjit+S+4SN/dsbGpaiUN1I6qQ2OLRGajtPXg5wfK4hlrOGqj3rpXMHO6mwqKeOEo8UZihoj/YL1fsknJ+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822392; c=relaxed/simple;
	bh=HNAiVg+lI6HuX/A/AJG2V4sY2pCNtHiqmbeZeH6Jj1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7QZikdxbXRlRnQwo08nq3ZSfSdsYm3mpS5tzLTySbO31pOjZuCBSglFnCU0ySWEiSARuwJyW49ttQ8hlqkTVwdu3J5flflOdYU857aNtZBRp9bZllG549UWYDv47J7NenK7KfRuuO9PYW9NGLHKeNFbBzJSIY04cKOdMNlfkPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E97AD13D5;
	Fri, 16 Aug 2024 08:33:35 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5F5E3F6A8;
	Fri, 16 Aug 2024 08:33:08 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 7/8] kselftest/arm64: mte: fix printf type warnings about pointers
Date: Fri, 16 Aug 2024 16:32:50 +0100
Message-Id: <20240816153251.2833702-8-andre.przywara@arm.com>
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

When printing the value of a pointer, we should not use an integer
format specifier, but the dedicated "%p" instead.

Fixes: e9b60476bea0 ("kselftest/arm64: Add utilities and a test to validate mte memory")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/check_buffer_fill.c | 4 ++--
 tools/testing/selftests/arm64/mte/mte_common_util.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_buffer_fill.c b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
index 1dbbbd47dd501..2ee7f114d7fa8 100644
--- a/tools/testing/selftests/arm64/mte/check_buffer_fill.c
+++ b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
@@ -91,7 +91,7 @@ static int check_buffer_underflow_by_byte(int mem_type, int mode,
 		for (j = 0; j < sizes[i]; j++) {
 			if (ptr[j] != '1') {
 				err = true;
-				ksft_print_msg("Buffer is not filled at index:%d of ptr:0x%lx\n",
+				ksft_print_msg("Buffer is not filled at index:%d of ptr:0x%p\n",
 						j, ptr);
 				break;
 			}
@@ -189,7 +189,7 @@ static int check_buffer_overflow_by_byte(int mem_type, int mode,
 		for (j = 0; j < sizes[i]; j++) {
 			if (ptr[j] != '1') {
 				err = true;
-				ksft_print_msg("Buffer is not filled at index:%d of ptr:0x%lx\n",
+				ksft_print_msg("Buffer is not filled at index:%d of ptr:0x%p\n",
 						j, ptr);
 				break;
 			}
diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 9380edca29c7d..17fbe5cfe4724 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -100,7 +100,7 @@ void *mte_insert_tags(void *ptr, size_t size)
 	int align_size;
 
 	if (!ptr || (unsigned long)(ptr) & MT_ALIGN_GRANULE) {
-		ksft_print_msg("FAIL: Addr=%lx: invalid\n", ptr);
+		ksft_print_msg("FAIL: Addr=%p: invalid\n", ptr);
 		return NULL;
 	}
 	align_size = MT_ALIGN_UP(size);
@@ -112,7 +112,7 @@ void *mte_insert_tags(void *ptr, size_t size)
 void mte_clear_tags(void *ptr, size_t size)
 {
 	if (!ptr || (unsigned long)(ptr) & MT_ALIGN_GRANULE) {
-		ksft_print_msg("FAIL: Addr=%lx: invalid\n", ptr);
+		ksft_print_msg("FAIL: Addr=%p: invalid\n", ptr);
 		return;
 	}
 	size = MT_ALIGN_UP(size);
-- 
2.25.1


