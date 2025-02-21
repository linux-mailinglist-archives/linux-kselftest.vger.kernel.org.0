Return-Path: <linux-kselftest+bounces-27147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B53A3F05D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD69A188FE7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09FA201017;
	Fri, 21 Feb 2025 09:33:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986391FFC6A
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130417; cv=none; b=PS+RzxU86sGVYxcRkQAewFOUksFW/YALEi0mlpOJivihClOR5ZBISD2117bHrDA3zyiyKeiU57Xw8h0AR2JCOWoblVjqPcwIVEZO+WQV4hDbOGHNBduBCT2qcvQxhkEg2wKP4YH7BpY93ufp2ogLWBzoHnD/sKFWFO6lLyPkeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130417; c=relaxed/simple;
	bh=rB3sKCNcAvS2k2MiPjdBaQ4gAzv+DXj2dzV8m3LLkjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMEs064/iNlBrvq+j2Q/Y4E1ZtigjDOremdG1ev0HEJG5tp+17H6Af27Q9IidfQIyDAhrxiFSSkg5BmOfUs0lN27DcyyYLJINf3CqQsnXe8/uDDgd0PM+b1QUyDOryYzFVEsDubJ9Jcv91OEZNeG25yih6ZUsjgJVdWeo87zXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DD2C4CEDD;
	Fri, 21 Feb 2025 09:33:35 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 1/2] kselftest/arm64: mte: Use the correct naming for tag check modes in check_hugetlb_options.c
Date: Fri, 21 Feb 2025 09:33:30 +0000
Message-Id: <20250221093331.2184245-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221093331.2184245-1-catalin.marinas@arm.com>
References: <20250221093331.2184245-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The architecture doesn't define precise/imprecise MTE tag check modes,
only synchronous and asynchronous. Use the correct naming and also
ensure they match the MTE_{ASYNC,SYNC}_ERR type.

Fixes: 27879e8cb6b0 ("selftests: arm64: add hugetlb mte tests")
Cc: Yang Shi <yang@os.amperecomputing.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 tools/testing/selftests/arm64/mte/check_hugetlb_options.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
index 303260a6dc65..11f812635b51 100644
--- a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
+++ b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
@@ -270,13 +270,13 @@ int main(int argc, char *argv[])
 	"Check clear PROT_MTE flags with private mapping and sync error mode and mmap/mprotect memory\n");
 
 	evaluate_test(check_child_hugetlb_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
-		"Check child hugetlb memory with private mapping, precise mode and mmap memory\n");
+		"Check child hugetlb memory with private mapping, sync error mode and mmap memory\n");
 	evaluate_test(check_child_hugetlb_memory_mapping(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
-		"Check child hugetlb memory with private mapping, precise mode and mmap memory\n");
+		"Check child hugetlb memory with private mapping, async error mode and mmap memory\n");
 	evaluate_test(check_child_hugetlb_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
-		"Check child hugetlb memory with private mapping, precise mode and mmap/mprotect memory\n");
+		"Check child hugetlb memory with private mapping, sync error mode and mmap/mprotect memory\n");
 	evaluate_test(check_child_hugetlb_memory_mapping(USE_MPROTECT, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
-		"Check child hugetlb memory with private mapping, precise mode and mmap/mprotect memory\n");
+		"Check child hugetlb memory with private mapping, async error mode and mmap/mprotect memory\n");
 
 	mte_restore_setup();
 	free_hugetlb();

