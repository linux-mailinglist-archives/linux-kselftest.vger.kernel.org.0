Return-Path: <linux-kselftest+bounces-3389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F94D838808
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 08:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95839B22310
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C386524C1;
	Tue, 23 Jan 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yjpWZT5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8262B9C0;
	Tue, 23 Jan 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995385; cv=none; b=krWzgM4FqPHh5Po0mufSiSyaacuimKHGQq7ElIPDXMwvfbSgKoTazetK3NSTaTXEKawbhBik6MicIKLzoOgVF9WwSDgWRoTDDtnyjzDOyjo3p6VyZ198yfjqRPPYOsw0feyURrrwsz3RSqN5Pq2zdosQlHXhXhq3yoSrHab59oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995385; c=relaxed/simple;
	bh=RONb+w30PwJfAdE6WvIlbcO0ThwKw/iY7UkyK1YT6Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTcvDzcO7331pntdLJW1mtxMfKxEDpaVarmc8w3WPOWjLD/ZkqAOtXemDmLVmzduXRM8QOleMHadJDtg6/aJjaF1R7e+2WOAeO4kzEW4s/Ez4bvcIAmxp8O6Zz6jyrdovhm0cwuvcSQPFDefShLZ8AKY9yTCNPU0YtuWDm0GjFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yjpWZT5I; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705995382;
	bh=RONb+w30PwJfAdE6WvIlbcO0ThwKw/iY7UkyK1YT6Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yjpWZT5I4L21f59z0O8zIlh3zXmK/YWUjiAx/7ueI/Zd/8fzpzx9EyJkeF+KLQxpV
	 vYU+3lqu8MSK6lbJK9tjM8HgnJNmO5eFLAAc+s9IbfiMyy7LdN76x1ZCccJ/NvAS9B
	 0sghzR1FFnrI6Td4+IGjpfqNHJQH1BFUmFBfwESp7vwo8WJknodVYqX03iQ+s+KQVE
	 NPiR8VXkg0hH2iNY0461oBv9e9Spi5dpz8kIJTZud2qFLW5Jyip0Jueurt8qnEcqxH
	 yhFrRSttKNvBTHS2ovlN8vB49CAVl4OQthwORC7KKiCJOvnQKPJKfC0nxTqjPQp2jK
	 CEva9SZ+eibnA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D553F3782066;
	Tue, 23 Jan 2024 07:36:19 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/mm: run_vmtests: remove sudo and conform to tap
Date: Tue, 23 Jan 2024 12:36:14 +0500
Message-ID: <20240123073615.920324-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123073615.920324-1-usama.anjum@collabora.com>
References: <20240123073615.920324-1-usama.anjum@collabora.com>
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
index 12754af00b39c..863bbc2015332 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -294,7 +294,7 @@ echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 CATEGORY="compaction" run_test ./compaction_test
 
-CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
+CATEGORY="mlock" run_test ./on-fault-limit
 
 CATEGORY="mmap" run_test ./map_populate
 
-- 
2.42.0


