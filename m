Return-Path: <linux-kselftest+bounces-3578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FA83C729
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5972C1C2302B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8974E2D;
	Thu, 25 Jan 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bWAq2bSV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CD74E14;
	Thu, 25 Jan 2024 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197625; cv=none; b=CcRCBT0RdqRkJHapaPl4SWXfGGEPnbHwkIwDBTY3JB/JMnC9KyYbzdycu4Nv8LgBlYWLGn7awThvdBEGzjew6ws6SFdWRT77h67H1i7zDhO/TYIx8Myg6UVAnSWgW5/38UHYCoWU8R7x9VPO6XmKmjtDVJHPd1/dgtMIMeb39pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197625; c=relaxed/simple;
	bh=gyo185f2D57JFqFMORChf4Ercnde+3pA9Al2pF3TwpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYOpurKjUGhBit38wYhd7LNEvLqPOa2lqqCRsUUoWndXrjuG2Hji7DwdhDQUHalMmawIIz1Dt4nd1TJyj9teS90n+ck6FZS2BaJ9/wAJ9cL0/pMTRqQMN7JbudTssU4raOmD+bWY5LlmG3sTFOEpK8L8hrkke4Q8RZJjCKMfYd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bWAq2bSV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706197622;
	bh=gyo185f2D57JFqFMORChf4Ercnde+3pA9Al2pF3TwpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWAq2bSVSNCidNYDMrbqrdFFYzZv9pb2h4iaMc9m0oz1yYUMZ04MoVMg2XeWwcSjo
	 0lU9piRePhdrqJu0+OY3mJdi3xxUuIbomGx8+n6jXUyeQprrjSxTls49AQcw1M8LK4
	 4SUMj9IdkpS1cA++zEsNfbx7qU+CcHReDQoDQBFjzv5h+UInk3WPc7lzNZJ4QqveJo
	 DY7Svwdpco2q1EtJ+6cKdLlhsZCDDAKiYQiBnG2hwNXdwkW9O8h9Dh+REFQZPWiBov
	 zSX4aH9PFjdu/KAgVspHZ/74zXc6rAJrDlZUAja8f8TiW+lnTZKPpYzwEwT/fzogGX
	 wiUDegEf7obLw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 757F237820C2;
	Thu, 25 Jan 2024 15:46:59 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] selftests/mm: run_vmtests: remove sudo and conform to tap
Date: Thu, 25 Jan 2024 20:46:05 +0500
Message-ID: <20240125154608.720072-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125154608.720072-1-usama.anjum@collabora.com>
References: <20240125154608.720072-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove sudo as some test running environments may not have sudo
available. Instead skip the test if root privileges aren't available in
the test.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Added this patch in v2

We are allocating 2*RLIMIT_MEMLOCK.rlim_max memory and mmap() isn't
failing. This seems like true bug in the kernel. Even the root user
shouldn't be able to allocate more memory than allowed MEMLOCKed memory.
Any ideas?
---
 tools/testing/selftests/mm/on-fault-limit.c | 36 ++++++++++-----------
 tools/testing/selftests/mm/run_vmtests.sh   |  2 +-
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
index b5888d613f34e..0ea98ffab3589 100644
--- a/tools/testing/selftests/mm/on-fault-limit.c
+++ b/tools/testing/selftests/mm/on-fault-limit.c
@@ -5,40 +5,38 @@
 #include <string.h>
 #include <sys/time.h>
 #include <sys/resource.h>
+#include "../kselftest.h"
 
-static int test_limit(void)
+static void test_limit(void)
 {
-	int ret = 1;
 	struct rlimit lims;
 	void *map;
 
-	if (getrlimit(RLIMIT_MEMLOCK, &lims)) {
-		perror("getrlimit");
-		return ret;
-	}
+	if (getrlimit(RLIMIT_MEMLOCK, &lims))
+		ksft_exit_fail_msg("getrlimit: %s\n", strerror(errno));
 
-	if (mlockall(MCL_ONFAULT | MCL_FUTURE)) {
-		perror("mlockall");
-		return ret;
-	}
+	if (mlockall(MCL_ONFAULT | MCL_FUTURE))
+		ksft_exit_fail_msg("mlockall: %s\n", strerror(errno));
 
 	map = mmap(NULL, 2 * lims.rlim_max, PROT_READ | PROT_WRITE,
 		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
+
+	ksft_test_result(map == MAP_FAILED, "Failed mmap\n");
+
 	if (map != MAP_FAILED)
-		printf("mmap should have failed, but didn't\n");
-	else {
-		ret = 0;
 		munmap(map, 2 * lims.rlim_max);
-	}
-
 	munlockall();
-	return ret;
 }
 
 int main(int argc, char **argv)
 {
-	int ret = 0;
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	if (getuid())
+		ksft_test_result_skip("Require root privileges to run\n");
+	else
+		test_limit();
 
-	ret += test_limit();
-	return ret;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 246d53a5d7f28..e373d592dbf5c 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -291,7 +291,7 @@ echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 CATEGORY="compaction" run_test ./compaction_test
 
-CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
+CATEGORY="mlock" run_test ./on-fault-limit
 
 CATEGORY="mmap" run_test ./map_populate
 
-- 
2.42.0


