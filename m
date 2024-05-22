Return-Path: <linux-kselftest+bounces-10586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B938CC559
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 19:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B91C21377
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 17:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23431422C8;
	Wed, 22 May 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Al5qSITR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440331F17B;
	Wed, 22 May 2024 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397671; cv=none; b=OL8GoAoH8KVvJjiZ9gL3LjwEfnfw4t0HK4a+PwM+xDernQq/q/WOS2aodf9OF7acTqRhhOIVP5vnQqbIisb9Kq3AE5pcH2u4F2YQvJn2Pcl1c73/IjRU/NPJy3BczqoWqQ/ExKx4OtngHiZpQrQGiMu9zy0ki/05uiiiK7sMiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397671; c=relaxed/simple;
	bh=Q5eimIUAh2hCMIAuK6asuJ6RF1m3Dp6LF57HRl79KzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dda0wf6AnjUEkaMlkNOFd96HjmVT4q3Z1Al5TBAL5IPTp2Qmw9SF7jg+E4b9xspXOylrtT16RO5D9yMDujCpOxBv/EhupfXz2vQIZ1RP/UP7lCtSsxhzCAib0E3Rblr2MJHV9+efaKXZy0SpP7GDRfAJVZDoEidumsusHcEEzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Al5qSITR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716397668;
	bh=Q5eimIUAh2hCMIAuK6asuJ6RF1m3Dp6LF57HRl79KzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Al5qSITRus5LO4elT1QOmpA0adoZ7FmZokOzdLcJ2nxwJeh+wY5QbDoYL922by/zM
	 NLCeEwaMvqozCpO5yEn1UHUoJTtm8yPovJuAcSaClpTd3HN3d7oqO969Lgqp8kVphG
	 w7CrOWAXhJattII5moPUfnahfF0xKiM1RVlh/vm/87Ke8Z5H2/8sRK4hU+8BConVca
	 4+bMiKYyInLtx43Hp7HyigTsKAw4snt7Gho8T6b/4ZVV/xev4iYeHp1N9GbiwXXslz
	 y0D1H2sWzQ0hgtPdTLQkJjex7qaTPxMk7Yy98T7UscCS4U+LuU25lcQ3TtfwALpZLF
	 R5jSbBmNcKefw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 37668378216B;
	Wed, 22 May 2024 17:07:47 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/thermel/intel: conform the test to TAP output
Date: Wed, 22 May 2024 10:06:49 -0700
Message-Id: <20240522170655.2879712-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522170655.2879712-1-usama.anjum@collabora.com>
References: <20240522170655.2879712-1-usama.anjum@collabora.com>
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
 .../intel/power_floor/power_floor_test.c      | 68 ++++++++-----------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
index 0326b39a11b91..1626c6d92e621 100644
--- a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
+++ b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <poll.h>
 #include <signal.h>
+#include "../../../kselftest.h"
 
 #define POWER_FLOOR_ENABLE_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_enable"
 #define POWER_FLOOR_STATUS_ATTRIBUTE  "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_status"
@@ -20,17 +21,13 @@ void power_floor_exit(int signum)
 	/* Disable feature via sysfs knob */
 
 	fd = open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
-	if (fd < 0) {
-		perror("Unable to open power floor enable file\n");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_perror("Unable to open power floor enable file");
 
-	if (write(fd, "0\n", 2) < 0) {
-		perror("Can' disable power floor notifications\n");
-		exit(1);
-	}
+	if (write(fd, "0\n", 2) < 0)
+		ksft_exit_fail_perror("Can' disable power floor notifications");
 
-	printf("Disabled power floor notifications\n");
+	ksft_print_msg("Disabled power floor notifications\n");
 
 	close(fd);
 }
@@ -41,6 +38,9 @@ int main(int argc, char **argv)
 	char status_str[3];
 	int fd, ret;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	if (signal(SIGINT, power_floor_exit) == SIG_IGN)
 		signal(SIGINT, SIG_IGN);
 	if (signal(SIGHUP, power_floor_exit) == SIG_IGN)
@@ -50,57 +50,45 @@ int main(int argc, char **argv)
 
 	/* Enable feature via sysfs knob */
 	fd = open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
-	if (fd < 0) {
-		perror("Unable to open power floor enable file\n");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_perror("Unable to open power floor enable file");
 
-	if (write(fd, "1\n", 2) < 0) {
-		perror("Can' enable power floor notifications\n");
-		exit(1);
-	}
+	if (write(fd, "1\n", 2) < 0)
+		ksft_exit_fail_perror("Can' enable power floor notifications");
 
 	close(fd);
 
-	printf("Enabled power floor notifications\n");
+	ksft_print_msg("Enabled power floor notifications\n");
 
 	while (1) {
 		fd = open(POWER_FLOOR_STATUS_ATTRIBUTE, O_RDONLY);
-		if (fd < 0) {
-			perror("Unable to power floor status file\n");
-			exit(1);
-		}
+		if (fd < 0)
+			ksft_exit_fail_perror("Unable to power floor status file");
 
-		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
-			fprintf(stderr, "Failed to set pointer to beginning\n");
-			exit(1);
-		}
+		if ((lseek(fd, 0L, SEEK_SET)) < 0)
+			ksft_exit_fail_perror("Failed to set pointer to beginning\n");
 
 		if (read(fd, status_str, sizeof(status_str)) < 0) {
-			fprintf(stderr, "Failed to read from:%s\n",
-			POWER_FLOOR_STATUS_ATTRIBUTE);
-			exit(1);
-		}
+			ksft_exit_fail_perror(stderr, "Failed to read from: power_floor_status");
 
 		ufd.fd = fd;
 		ufd.events = POLLPRI;
 
 		ret = poll(&ufd, 1, -1);
 		if (ret < 0) {
-			perror("poll error");
-			exit(1);
+			ksft_exit_fail_msg("Poll error\n");
 		} else if (ret == 0) {
-			printf("Poll Timeout\n");
+			ksft_print_msg("Poll Timeout\n");
 		} else {
-			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
-				fprintf(stderr, "Failed to set pointer to beginning\n");
-				exit(1);
-			}
+			if ((lseek(fd, 0L, SEEK_SET)) < 0)
+				ksft_exit_fail_msg("Failed to set pointer to beginning\n");
 
-			if (read(fd, status_str, sizeof(status_str)) < 0)
-				exit(0);
+			if (read(fd, status_str, sizeof(status_str)) < 0) {
+				ksft_test_result_pass("Successfully read\n");
+				ksft_finished();
+			}
 
-			printf("power floor status: %s\n", status_str);
+			ksft_print_msg("power floor status: %s\n", status_str);
 		}
 
 		close(fd);
-- 
2.39.2


