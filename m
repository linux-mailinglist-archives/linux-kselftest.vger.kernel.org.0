Return-Path: <linux-kselftest+bounces-8420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC998AADE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 13:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37131F21CDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ACD82D99;
	Fri, 19 Apr 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FlJAu8fM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97931200D3;
	Fri, 19 Apr 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527408; cv=none; b=RDC+SiEviz2RzzvQhYqF6hf8SKjfQKOpmxrVSt6mEMnXqx7o+C4IQKDy1SVbLu5r+wK4gZeixNeYf9lmAL+1lxhu+Rioj2GyAcJdOHJFxhvplgK+Bp/VfX5ubZXCjoqskHdjVj/sYBmDhpP9t1bGq+O1R68sIOmJ0Jl9tM46zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527408; c=relaxed/simple;
	bh=Lep34Beis5C2ihwH+Dc5DzCkhyzByh/1RyjpIIWrCf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyJoaRNFZwtFCB6NoRxyCYUKSSWNiHHy8N2KYfPZ4yfB7gz40AeWP4D+maq0g6tl8fKorOZ5rQe/91k3d/A/v0EbWc6xfgyZZwMkZZsiyFn+10EHoUxDT3NLodG2UZ5ri+iGVlk1cIliWgeRR/tv7CP22qy1mI+gbUUop7VISb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FlJAu8fM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713527404;
	bh=Lep34Beis5C2ihwH+Dc5DzCkhyzByh/1RyjpIIWrCf0=;
	h=From:To:Cc:Subject:Date:From;
	b=FlJAu8fMvcBak3ke9sp8Ks2GnEYU/NmHOnQcAFdOzNcwCHpIbjM32jwOdl9axlvmV
	 fyHkSXvfa+bmxWoj/ssL4MmdQ+oKK2gOu4Efn4B+n/pNiTUn+lhFZTxHuu/oieYpfI
	 lb14UsrWh0T+fHyHYx7L6g6Bn29GOL4t3w3SEueYGWa01LoN9lPO9Tn3m0147Hal+G
	 2VrPIBhgtUieTPiUjnTJSfl/VrHzbYazcI3yOjgeVJO/PDgt8RJFIXZUYIOBdV0qqC
	 z1UcE3SS3dv2ItyrMafEVg3JZE/I+zVf3SzFQvQFNKx8dsUygSbAod8JHvoE3NN6H5
	 OXT8xwapuKQwQ==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 919A7378214D;
	Fri, 19 Apr 2024 11:50:01 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	Joey Gouly <joey.gouly@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: mm: protection_keys: save/restore nr_hugepages value from launch script
Date: Fri, 19 Apr 2024 16:50:27 +0500
Message-Id: <20240419115027.3848958-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The save/restore of nr_hugepages was added to the test itself by using
the atexit() functionality. But it is broken as parent exits after
creating child. Hence calling the atexit() function early. That's not
it. The child exits after creating its child and so on.

The parent cannot wait to get the termination status for its children as
it'll keep on holding the resources until the new pkey allocation fails.
It is impossible to wait for exits of all the grand and great grand
children. Hence the restoring of nr_hugepages value from parent is
wrong.

Let's save/restore the nr_hugepages settings in the launch script
instead of doing it in the test.

Fixes: c52eb6db7b7d ("selftests: mm: restore settings from only parent process")
Reported-by: Joey Gouly <joey.gouly@arm.com>
Closes: https://lore.kernel.org/all/20240418125250.GA2941398@e124191.cambridge.arm.com
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/protection_keys.c | 38 --------------------
 tools/testing/selftests/mm/run_vmtests.sh    |  2 ++
 2 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 374a308174d2b..48dc151f8fca8 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -54,7 +54,6 @@ int test_nr;
 u64 shadow_pkey_reg;
 int dprint_in_signal;
 char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
-char buf[256];
 
 void cat_into_file(char *str, char *file)
 {
@@ -1745,42 +1744,6 @@ void pkey_setup_shadow(void)
 	shadow_pkey_reg = __read_pkey_reg();
 }
 
-pid_t parent_pid;
-
-void restore_settings_atexit(void)
-{
-	if (parent_pid == getpid())
-		cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
-}
-
-void save_settings(void)
-{
-	int fd;
-	int err;
-
-	if (geteuid())
-		return;
-
-	fd = open("/proc/sys/vm/nr_hugepages", O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "error opening\n");
-		perror("error: ");
-		exit(__LINE__);
-	}
-
-	/* -1 to guarantee leaving the trailing \0 */
-	err = read(fd, buf, sizeof(buf)-1);
-	if (err < 0) {
-		fprintf(stderr, "error reading\n");
-		perror("error: ");
-		exit(__LINE__);
-	}
-
-	parent_pid = getpid();
-	atexit(restore_settings_atexit);
-	close(fd);
-}
-
 int main(void)
 {
 	int nr_iterations = 22;
@@ -1788,7 +1751,6 @@ int main(void)
 
 	srand((unsigned int)time(NULL));
 
-	save_settings();
 	setup_handlers();
 
 	printf("has pkeys: %d\n", pkeys_supported);
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 223c2304f885c..3157204b90476 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -390,6 +390,7 @@ CATEGORY="ksm_numa" run_test ./ksm_tests -N -m 0
 CATEGORY="ksm" run_test ./ksm_functional_tests
 
 # protection_keys tests
+nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
 if [ -x ./protection_keys_32 ]
 then
 	CATEGORY="pkey" run_test ./protection_keys_32
@@ -399,6 +400,7 @@ if [ -x ./protection_keys_64 ]
 then
 	CATEGORY="pkey" run_test ./protection_keys_64
 fi
+echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 if [ -x ./soft-dirty ]
 then
-- 
2.39.2


