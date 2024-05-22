Return-Path: <linux-kselftest+bounces-10585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE08CC557
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33517B225DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0731422AE;
	Wed, 22 May 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HBnV2ChT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523431F17B;
	Wed, 22 May 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397666; cv=none; b=otKL69xQy5NdnKNIVakdXpSWy+GJFHmjE90ZLKTFJiz6BUynueVRmxRuQbzx4gf4a/L2mXlols/ebnKNT8tJv981gjc7+4GUr8LRlhDxamg3nzQRvgtQ3GRGDHXEkB2aLKi/Cc0vOxFdU3cr7crtgad3s2l6OEK0arn8MTKlgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397666; c=relaxed/simple;
	bh=/kt+NqBwmu9PAbUDYn6qhBk39YQggcMNamNlMPFBDJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ivL1iUTlqYMFURB3AQ1tLqrP9NUnPAeLQ02zT+uLweVbQ0xyZ1okBuQyL7b995YtrlH/xo6Z//7fXg1cy26qo6kIhqfOfvkR0TLY15C1Ab5U/8jCoIxjC3j7h2la5YyTm4rRpTO9mBCiURGwo/7v3bF5hqDlrOWDx6RjvUIq1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HBnV2ChT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716397662;
	bh=/kt+NqBwmu9PAbUDYn6qhBk39YQggcMNamNlMPFBDJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=HBnV2ChTSuVUyx1gZvBatJ3jZWQU8fvjLE2KcRbYDhn8hhepV235/Cq8ZYf+3h6QX
	 mTA/uphi+W1KwQInP/Kf/q/DfuyiuAUk8ujcIjiRT2xVTqfcnqAkcrBMqLjVCpxb8u
	 4nKXqcm7doHJt6YOaMB7ZSKhd19yFdg/bKk6Z1SeGMC6d8jI2qpNr7wyoRKyVpekMY
	 afHlWY+lGqgK5rpzQdYuw4YmujEDQSE92aP8c4e5vdNnqYkdC/jEKpn6lLxsIjmxhS
	 3pA2xoJqWukhfUy2zGxPkVFaqH2qVkVnPaCGZeC///JSG19LHrqkrEotPuOCLuj52q
	 g/eNV/Ifjortg==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B2A82378216B;
	Wed, 22 May 2024 17:07:40 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/thermel/intel: conform the test to TAP output
Date: Wed, 22 May 2024 10:06:48 -0700
Message-Id: <20240522170655.2879712-1-usama.anjum@collabora.com>
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

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../intel/workload_hint/workload_hint_test.c  | 98 ++++++++-----------
 1 file changed, 39 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index 217c3a641c537..d107c2d6f3a22 100644
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
@@ -93,63 +85,51 @@ int main(int argc, char **argv)
 
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
 
-			if (read(fd, index_str, sizeof(index_str)) < 0)
-				exit(0);
+			if (read(fd, index_str, sizeof(index_str)) < 0) {
+				ksft_test_result_pass("Successfully read\n");
+				ksft_finished();
+			}
 
 			ret = sscanf(index_str, "%d", &index);
 			if (ret < 0)
 				break;
 			if (index > WORKLOAD_TYPE_MAX_INDEX)
-				printf("Invalid workload type index\n");
+				ksft_print_msg("Invalid workload type index\n");
 			else
-				printf("workload type:%s\n", workload_types[index]);
+				ksft_print_msg("workload type:%s\n", workload_types[index]);
 		}
 
 		close(fd);
-- 
2.39.2


