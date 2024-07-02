Return-Path: <linux-kselftest+bounces-13048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F400923B23
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 12:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF652848D2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9A157A5A;
	Tue,  2 Jul 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tGmKiQR3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AC157492;
	Tue,  2 Jul 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915260; cv=none; b=Ou+Ja4VZ7/GETIxvl34ZDX3BMtvUJb2sg3FAIQ8WInFPy+pqFwMP1x+Jb5r3KHK4rM4jlgZn+dN6lgAbGWnk6u35pNk2HrdE2CGmok6ChNdKCj/0Ak0+OrxMqnSEQBamDFBprr8zSUixdHX1oqYLrc1Xj0g92PI1OR+cjIPhCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915260; c=relaxed/simple;
	bh=MnEfz1/l/s2PrKTuxm4/iG3t0pUcQA7Ilg20un9eIrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMfUjks6SXXIoq9cLLWP1wMAfnAtzqwsiSk4wKJxumKZc/VtnjPDJQnuuGQkr+Hl/rVmYBnNbUEUhe48zgzBlQ/+HP+cj1IutgO8FrwO0nNf2KOSbcfGsAq3ADcBv/UkN8dDx63YZ0k3cx2nkkS9GQrAfvzd6tIhT4XPfy8txsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tGmKiQR3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719915257;
	bh=MnEfz1/l/s2PrKTuxm4/iG3t0pUcQA7Ilg20un9eIrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGmKiQR31/nISSUeCzbvyNpKm1dTt2e37TVuLXYXG8sVt3MQ854Td+smENoXtSCfX
	 oOSadk2+qR1Nk+15jYCqWXjqDtziLo3eSwAHldhE+SF554qcDtYjdtI0apnKUNnGTb
	 7vbtR5stKWkTVJkUTFVsz5IR5d1ZyhWD+Vv9lFWWyuS4fSnViHbNCF+ovkMPNoIGw7
	 01A5nrtcI9+fPiF4eZhylNYc1VIa4MlM4Vt/OmbxWdB0DlRyKJHHq1cmwbr/RZSOvK
	 rvua0QRhuUQM3rLHTeGjao+UmJb/qbwAmRCJrGG6FaLpjUL4L6J85yeIYve3+dY2M9
	 xY/Cu23SgVU2g==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 109E53782139;
	Tue,  2 Jul 2024 10:14:10 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/thermel/intel: conform the test to TAP output
Date: Tue,  2 Jul 2024 15:12:53 +0500
Message-Id: <20240702101259.1251377-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702101259.1251377-1-usama.anjum@collabora.com>
References: <20240702101259.1251377-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

The test has infinite loop to read the value of status_str. Break the
loop after getting the value once and finish the test.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Use ksft_exit_fail_perror if read() returns error
- Break the infinite loop after printing status_str
---
 .../intel/power_floor/power_floor_test.c      | 70 ++++++++-----------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
index 0326b39a11b91..c06b275acd36b 100644
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
@@ -50,59 +50,49 @@ int main(int argc, char **argv)
 
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
 
-		if (read(fd, status_str, sizeof(status_str)) < 0) {
-			fprintf(stderr, "Failed to read from:%s\n",
-			POWER_FLOOR_STATUS_ATTRIBUTE);
-			exit(1);
-		}
+		if (read(fd, status_str, sizeof(status_str)) < 0)
+			ksft_exit_fail_perror("Failed to read from: power_floor_status");
 
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
 
 			if (read(fd, status_str, sizeof(status_str)) < 0)
-				exit(0);
+				ksft_exit_fail_perror("Failed to read");
 
-			printf("power floor status: %s\n", status_str);
+			ksft_print_msg("power floor status: %s\n", status_str);
+			break;
 		}
 
 		close(fd);
 	}
+
+	ksft_test_result_pass("Successfully read\n");
+	ksft_finished();
 }
-- 
2.39.2


