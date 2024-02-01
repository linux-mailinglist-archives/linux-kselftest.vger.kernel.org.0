Return-Path: <linux-kselftest+bounces-3937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1042845864
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 14:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F4C1C27C35
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD228665E;
	Thu,  1 Feb 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bp06Xi6v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA2D86645;
	Thu,  1 Feb 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792738; cv=none; b=NTd2lpx0ztARkaf5gDMqpUlm/b1/MG0Cwg8S7Cs+fpYpXYs9uuSQDyQNX8kAFt118W9tiVgt+9fx0oVRpeB2KemfLuDQqid761YUu50+/EOMj2BWlrfqCKZ81yxmPPubUJ8MZ5Jc5Z5Qt67Ngj/I7BBAOL9ZTcFr8MgMpG3hybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792738; c=relaxed/simple;
	bh=s4vhoRvfEvFZwOisdM2aMqjEVJFakRY46t1Nik7WI30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTdszv/6vX34wiZpFPdDJu707qRkcga8Nfl7ZKCxpv3CKVqaf0oeayrgNFTcydEt9AlSRQz+29s5lOKC13Zl5N8lvnmf1d7vtqWjvZ4QUMhzY+ysfdoKGN1Nqfihc2Frts9Y38ntE6zzwPO/C3ywFmkcfTrSz0XZBIv6/OgC6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bp06Xi6v; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706792735;
	bh=s4vhoRvfEvFZwOisdM2aMqjEVJFakRY46t1Nik7WI30=;
	h=From:To:Cc:Subject:Date:From;
	b=bp06Xi6v1KuIBWxidHRBmia8CUyfh5utC2lT8FJaXct0Fy0lE4hde7U/u7qCBDaYS
	 7oCMDDSOfk1vufGTLTFHBPVmHchkvHGHijgXWkKvfL/XT+/4o3dYq1X+5ZsJQU/15U
	 wTJnPZ45xte/wvW1KTIwQU6+oWZdAvbmR9od12+3tLz8gdg2ZGmaw54726qxjRhBY8
	 YZQ5feLlratEx4yb2lh/SVs4wBEFkAKF5I+R+Z+hZBCaRj8boGPQcN5ttyHYCOt7E+
	 yEduhbGfhMSjG13psjRBy4M+6lRSuxiviI/uM2EK3CSeTCaZQT5Dl/Qw95CgMUHneE
	 rNVJJQRP9RZqg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D56C0378047F;
	Thu,  1 Feb 2024 13:05:32 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	ryan.roberts@arm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/mm: on-fault-limit: run test without root privileges otherwise skip
Date: Thu,  1 Feb 2024 18:05:36 +0500
Message-ID: <20240201130538.1404897-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmap() respects rlimit only for normal users. This test should be
run as normal user, without root privileges. Also add back the sudo -u
nobody as run_vmtests.sh is run as root most of the times. Skip the test
instead if sudo isn't present to lower the privileges.

Fixes: b6221771d468 ("selftests/mm: run_vmtests: remove sudo and conform to tap")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Please fold this patch in the Fixes patch if needed.
---
 tools/testing/selftests/mm/on-fault-limit.c | 6 +++---
 tools/testing/selftests/mm/run_vmtests.sh   | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
index 0ea98ffab3589..431c1277d83a1 100644
--- a/tools/testing/selftests/mm/on-fault-limit.c
+++ b/tools/testing/selftests/mm/on-fault-limit.c
@@ -21,7 +21,7 @@ static void test_limit(void)
 	map = mmap(NULL, 2 * lims.rlim_max, PROT_READ | PROT_WRITE,
 		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
 
-	ksft_test_result(map == MAP_FAILED, "Failed mmap\n");
+	ksft_test_result(map == MAP_FAILED, "The map failed respecting mlock limits\n");
 
 	if (map != MAP_FAILED)
 		munmap(map, 2 * lims.rlim_max);
@@ -33,8 +33,8 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(1);
 
-	if (getuid())
-		ksft_test_result_skip("Require root privileges to run\n");
+	if (!getuid())
+		ksft_test_result_skip("The test must be run from a normal user\n");
 	else
 		test_limit();
 
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 55898d64e2ebf..edd73f871c79a 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -303,7 +303,12 @@ echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 CATEGORY="compaction" run_test ./compaction_test
 
-CATEGORY="mlock" run_test ./on-fault-limit
+if command -v sudo &> /dev/null;
+then
+	CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
+else
+	echo "# SKIP ./on-fault-limit"
+fi
 
 CATEGORY="mmap" run_test ./map_populate
 
-- 
2.42.0


