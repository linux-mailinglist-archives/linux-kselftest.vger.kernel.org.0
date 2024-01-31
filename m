Return-Path: <linux-kselftest+bounces-3841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7536844150
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2F1F2E1D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7486141;
	Wed, 31 Jan 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y5pQ9du2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9684A5F;
	Wed, 31 Jan 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709939; cv=none; b=tCPYqhjNf4fg45r50fNhgkwS8he6bx8VYLiWQ1Kd4Y30BpAW556aJ3vm6+GSy5p82SJujla1Nvo5Nj5rkuSl0N8SIWWwOqk0NQv0gP84C7esOIhUeO6i/i6qzGnHCMzuhD6IMm7LhTv79AJ2KjJARHu6hNfgm+xAfjLBlPaUAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709939; c=relaxed/simple;
	bh=Qz1hYpXZ0ZArWwJNMRoiOZt8O4/weesIABzDbZYxCC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrpwxrY3XCvkANnZonvUQPvoVsmR3cgcjBnNySryCy5v5xkISwN3rAnnOv2DWsPT47DeN/4LsuKNzwD6mxEO4FUx7WM8XWNacX3VVb20DOINuqEys9cDav+U+y7189zUxXOuI2mY7ZxLE7pB2PWe7BvyC5d2YA3SE2VtswvtZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y5pQ9du2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706709936;
	bh=Qz1hYpXZ0ZArWwJNMRoiOZt8O4/weesIABzDbZYxCC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5pQ9du2FKfMQPOxu64NoVlqah6eSuWUHY5+FBrkKanpFPShFX5b3UutJy6s/vvdA
	 WwVo6144/79OXPuwuz9aHuk7y5vvrchSQBPaBeNGhDbxG8FNUMN8QewODzOZTt6gIQ
	 bhFh5SO8/Vst+A1DbHoirNZnYkfpahdulHbOKy+6k/5EVuQaXJA7+x1Y2UBnVmJbMr
	 QtuKFBQ2x3POfXWyubTuk1EbpCHeKnYvAcK8Dl40kuoScttAKMJNZVmqbSHnE3ESC8
	 nG3JCuJnDoyAAN0dltBDedl3XQgFUQMTC0VTt0JCvSXWuvDrSDJS+V0szzUS8LVT1A
	 RLKaFkFqQrsyg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5F4073781FCF;
	Wed, 31 Jan 2024 14:05:34 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] selftests/mm: thp_settings: conform to TAP format output
Date: Wed, 31 Jan 2024 19:05:19 +0500
Message-ID: <20240131140528.320252-9-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240131140528.320252-1-usama.anjum@collabora.com>
References: <20240131140528.320252-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/khugepaged.c   |   3 +-
 tools/testing/selftests/mm/thp_settings.c | 123 ++++++++--------------
 tools/testing/selftests/mm/thp_settings.h |   4 +-
 3 files changed, 47 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index d51fdaee7dc6a..3f202da0867c5 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -152,8 +152,7 @@ static void get_finfo(const char *dir)
 		     major(path_stat.st_dev), minor(path_stat.st_dev)) >= sizeof(path))
 		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
 
-	if (read_file(path, buf, sizeof(buf)) < 0)
-		ksft_exit_fail_msg("read_file(read_num): %s\n", strerror(errno));
+	read_file(path, buf, sizeof(buf));
 
 	if (strstr(buf, "DEVTYPE=disk")) {
 		/* Found it */
diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
index a4163438108ec..273a95d025285 100644
--- a/tools/testing/selftests/mm/thp_settings.c
+++ b/tools/testing/selftests/mm/thp_settings.c
@@ -5,7 +5,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <errno.h>
 
+#include "../kselftest.h"
 #include "thp_settings.h"
 
 #define THP_SYSFS "/sys/kernel/mm/transparent_hugepage/"
@@ -42,58 +44,45 @@ static const char * const shmem_enabled_strings[] = {
 	NULL
 };
 
-int read_file(const char *path, char *buf, size_t buflen)
+void read_file(const char *path, char *buf, size_t buflen)
 {
 	int fd;
 	ssize_t numread;
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
-		return 0;
+		ksft_exit_fail_msg("%s open failed: %s\n", path, strerror(errno));
 
 	numread = read(fd, buf, buflen - 1);
 	if (numread < 1) {
 		close(fd);
-		return 0;
+		ksft_exit_fail_msg("No data read\n");
 	}
 
 	buf[numread] = '\0';
 	close(fd);
-
-	return (unsigned int) numread;
 }
 
-int write_file(const char *path, const char *buf, size_t buflen)
+void write_file(const char *path, const char *buf, size_t buflen)
 {
 	int fd;
 	ssize_t numwritten;
 
 	fd = open(path, O_WRONLY);
-	if (fd == -1) {
-		printf("open(%s)\n", path);
-		exit(EXIT_FAILURE);
-		return 0;
-	}
+	if (fd == -1)
+		ksft_exit_fail_msg("%s open failed\n", path);
 
 	numwritten = write(fd, buf, buflen - 1);
 	close(fd);
-	if (numwritten < 1) {
-		printf("write(%s)\n", buf);
-		exit(EXIT_FAILURE);
-		return 0;
-	}
-
-	return (unsigned int) numwritten;
+	if (numwritten < 1)
+		ksft_exit_fail_msg("write failed (%s)\n", buf);
 }
 
 const unsigned long read_num(const char *path)
 {
 	char buf[21];
 
-	if (read_file(path, buf, sizeof(buf)) < 0) {
-		perror("read_file()");
-		exit(EXIT_FAILURE);
-	}
+	read_file(path, buf, sizeof(buf));
 
 	return strtoul(buf, NULL, 10);
 }
@@ -103,10 +92,7 @@ void write_num(const char *path, unsigned long num)
 	char buf[21];
 
 	sprintf(buf, "%ld", num);
-	if (!write_file(path, buf, strlen(buf) + 1)) {
-		perror(path);
-		exit(EXIT_FAILURE);
-	}
+	write_file(path, buf, strlen(buf) + 1);
 }
 
 int thp_read_string(const char *name, const char * const strings[])
@@ -117,30 +103,22 @@ int thp_read_string(const char *name, const char * const strings[])
 	int ret;
 
 	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
-	if (ret >= PATH_MAX) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
+	if (ret >= PATH_MAX)
+		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
 
-	if (!read_file(path, buf, sizeof(buf))) {
-		perror(path);
-		exit(EXIT_FAILURE);
-	}
+	read_file(path, buf, sizeof(buf));
 
 	c = strchr(buf, '[');
-	if (!c) {
-		printf("%s: Parse failure\n", __func__);
-		exit(EXIT_FAILURE);
-	}
+	if (!c)
+		ksft_exit_fail_msg("%s: Parse failure\n", __func__);
 
 	c++;
 	memmove(buf, c, sizeof(buf) - (c - buf));
 
 	c = strchr(buf, ']');
-	if (!c) {
-		printf("%s: Parse failure\n", __func__);
-		exit(EXIT_FAILURE);
-	}
+	if (!c)
+		ksft_exit_fail_msg("%s: Parse failure\n", __func__);
+
 	*c = '\0';
 
 	ret = 0;
@@ -150,8 +128,8 @@ int thp_read_string(const char *name, const char * const strings[])
 		ret++;
 	}
 
-	printf("Failed to parse %s\n", name);
-	exit(EXIT_FAILURE);
+	ksft_exit_fail_msg("Failed to parse %s\n", name);
+	return -1;
 }
 
 void thp_write_string(const char *name, const char *val)
@@ -160,15 +138,10 @@ void thp_write_string(const char *name, const char *val)
 	int ret;
 
 	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
-	if (ret >= PATH_MAX) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
+	if (ret >= PATH_MAX)
+		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
 
-	if (!write_file(path, val, strlen(val) + 1)) {
-		perror(path);
-		exit(EXIT_FAILURE);
-	}
+	write_file(path, val, strlen(val) + 1);
 }
 
 const unsigned long thp_read_num(const char *name)
@@ -177,10 +150,9 @@ const unsigned long thp_read_num(const char *name)
 	int ret;
 
 	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
-	if (ret >= PATH_MAX) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
+	if (ret >= PATH_MAX)
+		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
+
 	return read_num(path);
 }
 
@@ -190,10 +162,9 @@ void thp_write_num(const char *name, unsigned long num)
 	int ret;
 
 	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
-	if (ret >= PATH_MAX) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
+	if (ret >= PATH_MAX)
+		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
+
 	write_num(path, num);
 }
 
@@ -275,29 +246,26 @@ void thp_write_settings(struct thp_settings *settings)
 
 struct thp_settings *thp_current_settings(void)
 {
-	if (!settings_index) {
-		printf("Fail: No settings set");
-		exit(EXIT_FAILURE);
-	}
+	if (!settings_index)
+		ksft_exit_fail_msg("Fail: No settings set\n");
+
 	return settings_stack + settings_index - 1;
 }
 
 void thp_push_settings(struct thp_settings *settings)
 {
-	if (settings_index >= MAX_SETTINGS_DEPTH) {
-		printf("Fail: Settings stack exceeded");
-		exit(EXIT_FAILURE);
-	}
+	if (settings_index >= MAX_SETTINGS_DEPTH)
+		ksft_exit_fail_msg("Fail: Settings stack exceeded\n");
+
 	settings_stack[settings_index++] = *settings;
 	thp_write_settings(thp_current_settings());
 }
 
 void thp_pop_settings(void)
 {
-	if (settings_index <= 0) {
-		printf("Fail: Settings stack empty");
-		exit(EXIT_FAILURE);
-	}
+	if (settings_index <= 0)
+		ksft_exit_fail_msg("Fail: Settings stack empty\n");
+
 	--settings_index;
 	thp_write_settings(thp_current_settings());
 }
@@ -335,14 +303,11 @@ unsigned long thp_supported_orders(void)
 	for (i = 0; i < NR_ORDERS; i++) {
 		ret = snprintf(path, PATH_MAX, THP_SYSFS "hugepages-%ukB/enabled",
 			(getpagesize() >> 10) << i);
-		if (ret >= PATH_MAX) {
-			printf("%s: Pathname is too long\n", __func__);
-			exit(EXIT_FAILURE);
-		}
+		if (ret >= PATH_MAX)
+			ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
 
-		ret = read_file(path, buf, sizeof(buf));
-		if (ret)
-			orders |= 1UL << i;
+		read_file(path, buf, sizeof(buf));
+		orders |= 1UL << i;
 	}
 
 	return orders;
diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
index 71cbff05f4c7f..04a6a7bbd08f8 100644
--- a/tools/testing/selftests/mm/thp_settings.h
+++ b/tools/testing/selftests/mm/thp_settings.h
@@ -56,8 +56,8 @@ struct thp_settings {
 	struct hugepages_settings hugepages[NR_ORDERS];
 };
 
-int read_file(const char *path, char *buf, size_t buflen);
-int write_file(const char *path, const char *buf, size_t buflen);
+void read_file(const char *path, char *buf, size_t buflen);
+void write_file(const char *path, const char *buf, size_t buflen);
 const unsigned long read_num(const char *path);
 void write_num(const char *path, unsigned long num);
 
-- 
2.42.0


