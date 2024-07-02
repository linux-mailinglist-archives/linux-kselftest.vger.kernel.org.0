Return-Path: <linux-kselftest+bounces-13047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B2923B20
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 12:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99E8283C8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44ED1581EF;
	Tue,  2 Jul 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0tclhjDb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14873157493;
	Tue,  2 Jul 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915247; cv=none; b=oUBxbQqGBNJ9009ak8MvZiVyadoobGI8+kPPeZTOIcBNDoEH4JJJBCxW67P2SoCLO+9C/Tl14KxLi5V1TyFTI4zgvFmNJhaUS7/8lqPASHDkD6HVKtteCKZBCiT6LS03GZsmW+ZJClfQyYE6/exwhEfTDFD7AJASPEOEJ+kIqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915247; c=relaxed/simple;
	bh=cXBW4k+LFtbqeY3R4gWzZ7cHioln/0kjtKo1pO9erV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYD5FftkLyarmnROT1zICVdWwVpTZZd0BopwXGomlmVsuSejhCGQjJB/HVYAkXOgGAyWQg1wacq74UFsl1C9hSrx0P6055UCR5ojeYOY56LMz8lY9YNsVOvEgDgLfypmfeAAyOW65ll/XGwUNJKgsKUfXUeeYs0xYxr8Fw2olSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0tclhjDb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719915244;
	bh=cXBW4k+LFtbqeY3R4gWzZ7cHioln/0kjtKo1pO9erV0=;
	h=From:To:Cc:Subject:Date:From;
	b=0tclhjDbZqKGfRHfKV6z4ixp8io+RohuioDODtMI9ZRkBNitiOYLoIlgTb+679TZ7
	 m1gzk4gDgOE54YN4PHvY5+F2UDHpqT0mReKBiH55lVYomf+esNSixXEPah58JTt/WQ
	 oprgpNVYzTHloDFEHbMQmXcGYD/3IqP7UkXUiJjB+aO+JTumAnE+Q2ZyCKqkDGW8Lu
	 6bA0hG1UoRA8UBPy6RM3ZXvn5m1lvu/0NkTkH1HdM2Ywii8/kySNVrUyimAlS16YFX
	 3E+aUmSbetjLTsnTmpNblvgQFPjTuazzmZHzeW2Z/Yq8ULH/PgG9Ok9TzFBloUDa5L
	 L02JvTVm0HefA==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5F7683782194;
	Tue,  2 Jul 2024 10:13:58 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/thermel/intel: conform the test to TAP output
Date: Tue,  2 Jul 2024 15:12:52 +0500
Message-Id: <20240702101259.1251377-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

The test has infitie loop to read the value of index_str. Break the loop
after successfully reading the value once and finished the test.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Use ksft_exit_fail_perror if read() returns error
- Break the infinite loop after printing index_str
---
 .../intel/workload_hint/workload_hint_test.c  | 103 ++++++++----------
 1 file changed, 43 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index 217c3a641c537..0e5f07efc8a2b 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <poll.h>
 #include <signal.h>
+#include "../../../kselftest.h"
 
 #define WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/notification_delay_ms"
 #define WORKLOAD_ENABLE_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_hint_enable"
@@ -31,17 +32,13 @@ void workload_hint_exit(int signum)
 	/* Disable feature via sysfs knob */
 
 	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
-	if (fd < 0) {
-		perror("Unable to open workload type feature enable file\n");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_perror("Unable to open workload type feature enable file");
 
-	if (write(fd, "0\n", 2) < 0) {
-		perror("Can' disable workload hints\n");
-		exit(1);
-	}
+	if (write(fd, "0\n", 2) < 0)
+		ksft_exit_fail_perror("Can' disable workload hints");
 
-	printf("Disabled workload type prediction\n");
+	ksft_print_msg("Disabled workload type prediction\n");
 
 	close(fd);
 }
@@ -54,32 +51,27 @@ int main(int argc, char **argv)
 	char delay_str[64];
 	int delay = 0;
 
-	printf("Usage: workload_hint_test [notification delay in milli seconds]\n");
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	ksft_print_msg("Usage: workload_hint_test [notification delay in milli seconds]\n");
 
 	if (argc > 1) {
 		ret = sscanf(argv[1], "%d", &delay);
-		if (ret < 0) {
-			printf("Invalid delay\n");
-			exit(1);
-		}
+		if (ret < 0)
+			ksft_exit_fail_perror("Invalid delay");
 
-		printf("Setting notification delay to %d ms\n", delay);
+		ksft_print_msg("Setting notification delay to %d ms\n", delay);
 		if (delay < 0)
-			exit(1);
-
-		sprintf(delay_str, "%s\n", argv[1]);
+			ksft_exit_fail_msg("delay can never be negative\n");
 
 		sprintf(delay_str, "%s\n", argv[1]);
 		fd = open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE, O_RDWR);
-		if (fd < 0) {
-			perror("Unable to open workload notification delay\n");
-			exit(1);
-		}
+		if (fd < 0)
+			ksft_exit_fail_perror("Unable to open workload notification delay");
 
-		if (write(fd, delay_str, strlen(delay_str)) < 0) {
-			perror("Can't set delay\n");
-			exit(1);
-		}
+		if (write(fd, delay_str, strlen(delay_str)) < 0)
+			ksft_exit_fail_perror("Can't set delay");
 
 		close(fd);
 	}
@@ -93,65 +85,56 @@ int main(int argc, char **argv)
 
 	/* Enable feature via sysfs knob */
 	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
-	if (fd < 0) {
-		perror("Unable to open workload type feature enable file\n");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_perror("Unable to open workload type feature enable file");
 
-	if (write(fd, "1\n", 2) < 0) {
-		perror("Can' enable workload hints\n");
-		exit(1);
-	}
+	if (write(fd, "1\n", 2) < 0)
+		ksft_exit_fail_perror("Can' enable workload hints");
 
 	close(fd);
 
-	printf("Enabled workload type prediction\n");
+	ksft_print_msg("Enabled workload type prediction\n");
 
 	while (1) {
 		fd = open(WORKLOAD_TYPE_INDEX_ATTRIBUTE, O_RDONLY);
-		if (fd < 0) {
-			perror("Unable to open workload type file\n");
-			exit(1);
-		}
+		if (fd < 0)
+			ksft_exit_fail_perror("Unable to open workload type file");
 
-		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
-			fprintf(stderr, "Failed to set pointer to beginning\n");
-			exit(1);
-		}
+		if ((lseek(fd, 0L, SEEK_SET)) < 0)
+			ksft_exit_fail_perror("Failed to set pointer to beginning");
 
-		if (read(fd, index_str, sizeof(index_str)) < 0) {
-			fprintf(stderr, "Failed to read from:%s\n",
-			WORKLOAD_TYPE_INDEX_ATTRIBUTE);
-			exit(1);
-		}
+		if (read(fd, index_str, sizeof(index_str)) < 0)
+			ksft_exit_fail_perror("Failed to read from: workload_type_index");
 
 		ufd.fd = fd;
 		ufd.events = POLLPRI;
 
 		ret = poll(&ufd, 1, -1);
 		if (ret < 0) {
-			perror("poll error");
-			exit(1);
+			ksft_exit_fail_perror("poll error");
 		} else if (ret == 0) {
-			printf("Poll Timeout\n");
+			ksft_print_msg("Poll Timeout\n");
 		} else {
-			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
-				fprintf(stderr, "Failed to set pointer to beginning\n");
-				exit(1);
-			}
+			if ((lseek(fd, 0L, SEEK_SET)) < 0)
+				ksft_exit_fail_perror("Failed to set pointer to beginning");
 
 			if (read(fd, index_str, sizeof(index_str)) < 0)
-				exit(0);
+				ksft_exit_fail_perror("Failed to read");
 
 			ret = sscanf(index_str, "%d", &index);
 			if (ret < 0)
+				ksft_exit_fail_msg("Read negative value unexpectedly\n");
+			if (index > WORKLOAD_TYPE_MAX_INDEX) {
+				ksft_print_msg("Invalid workload type index\n");
+			} else {
+				ksft_print_msg("workload type:%s\n", workload_types[index]);
 				break;
-			if (index > WORKLOAD_TYPE_MAX_INDEX)
-				printf("Invalid workload type index\n");
-			else
-				printf("workload type:%s\n", workload_types[index]);
+			}
 		}
 
 		close(fd);
 	}
+
+	ksft_test_result_pass("Successfully read\n");
+	ksft_finished();
 }
-- 
2.39.2


