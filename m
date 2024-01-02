Return-Path: <linux-kselftest+bounces-2550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B23821770
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 06:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6ECA282251
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 05:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA810F8;
	Tue,  2 Jan 2024 05:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="whSikbQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC46257C;
	Tue,  2 Jan 2024 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704174008;
	bh=z6qn03b6LeS1LR8vScT4yPeTy8AttWujLJP3TbJX0Vw=;
	h=From:To:Cc:Subject:Date:From;
	b=whSikbQ41Fkmk4oTuvRCSAHHiZgyXRal1tLdj4xqOMH2SvWKPFQuxBSnI+uK4u8fS
	 sOC1yGTVaDpdMee+w00DPVirYc8EzYNrShQ6Mu8EbxZPKlJBcJZ9AH7EvhjGm6s4Ox
	 v9A/gJGT2v5dkXNxGAps9I1dpKJFHl0f6tRYTDzJCO9dBBd9EHVsv+VYoavGRqYWHf
	 3TAioQSAxXhTxF2twGpgxmqDzYP9LHjtC/UoVQk+hiigpnpLDNsKIYG0caIQxaILsK
	 6WZPXDJHLTVs7y1wICaZLsrMv18WBtTMk/BlnLyiVO2dr/FnZ9Jipm1qf0yqtPy1+h
	 RAsZZoYMidT6g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A5C0A3780FC7;
	Tue,  2 Jan 2024 05:40:06 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [Patch v2] selftests/mm: gup_test: conform test to TAP format output
Date: Tue,  2 Jan 2024 10:38:06 +0500
Message-ID: <20240102053807.2114200-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
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
Changes since v1:
- Fix typo
- Update subject
---
 tools/testing/selftests/mm/gup_test.c | 65 ++++++++++++++-------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index ec2229136384..cbe99594d319 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -50,39 +50,41 @@ static char *cmd_to_str(unsigned long cmd)
 void *gup_thread(void *data)
 {
 	struct gup_test gup = *(struct gup_test *)data;
-	int i;
+	int i, status;
 
 	/* Only report timing information on the *_BENCHMARK commands: */
 	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
 	     (cmd == PIN_LONGTERM_BENCHMARK)) {
 		for (i = 0; i < repeats; i++) {
 			gup.size = size;
-			if (ioctl(gup_fd, cmd, &gup))
-				perror("ioctl"), exit(1);
+			status = ioctl(gup_fd, cmd, &gup);
+			if (status)
+				break;
 
 			pthread_mutex_lock(&print_mutex);
-			printf("%s: Time: get:%lld put:%lld us",
-			       cmd_to_str(cmd), gup.get_delta_usec,
-			       gup.put_delta_usec);
+			ksft_print_msg("%s: Time: get:%lld put:%lld us",
+				       cmd_to_str(cmd), gup.get_delta_usec,
+				       gup.put_delta_usec);
 			if (gup.size != size)
-				printf(", truncated (size: %lld)", gup.size);
-			printf("\n");
+				ksft_print_msg(", truncated (size: %lld)", gup.size);
+			ksft_print_msg("\n");
 			pthread_mutex_unlock(&print_mutex);
 		}
 	} else {
 		gup.size = size;
-		if (ioctl(gup_fd, cmd, &gup)) {
-			perror("ioctl");
-			exit(1);
-		}
+		status = ioctl(gup_fd, cmd, &gup);
+		if (status)
+			goto return_;
 
 		pthread_mutex_lock(&print_mutex);
-		printf("%s: done\n", cmd_to_str(cmd));
+		ksft_print_msg("%s: done\n", cmd_to_str(cmd));
 		if (gup.size != size)
-			printf("Truncated (size: %lld)\n", gup.size);
+			ksft_print_msg("Truncated (size: %lld)\n", gup.size);
 		pthread_mutex_unlock(&print_mutex);
 	}
 
+return_:
+	ksft_test_result(!status, "ioctl status %d\n", status);
 	return NULL;
 }
 
@@ -170,7 +172,7 @@ int main(int argc, char **argv)
 			touch = 1;
 			break;
 		default:
-			return -1;
+			ksft_exit_fail_msg("Wrong argument\n");
 		}
 	}
 
@@ -198,11 +200,12 @@ int main(int argc, char **argv)
 		}
 	}
 
+	ksft_print_header();
+	ksft_set_plan(nthreads);
+
 	filed = open(file, O_RDWR|O_CREAT);
-	if (filed < 0) {
-		perror("open");
-		exit(filed);
-	}
+	if (filed < 0)
+		ksft_exit_fail_msg("Unable to open %s: %s\n", file, strerror(errno));
 
 	gup.nr_pages_per_call = nr_pages;
 	if (write)
@@ -213,27 +216,24 @@ int main(int argc, char **argv)
 		switch (errno) {
 		case EACCES:
 			if (getuid())
-				printf("Please run this test as root\n");
+				ksft_print_msg("Please run this test as root\n");
 			break;
 		case ENOENT:
-			if (opendir("/sys/kernel/debug") == NULL) {
-				printf("mount debugfs at /sys/kernel/debug\n");
-				break;
-			}
-			printf("check if CONFIG_GUP_TEST is enabled in kernel config\n");
+			if (opendir("/sys/kernel/debug") == NULL)
+				ksft_print_msg("mount debugfs at /sys/kernel/debug\n");
+			ksft_print_msg("check if CONFIG_GUP_TEST is enabled in kernel config\n");
 			break;
 		default:
-			perror("failed to open " GUP_TEST_FILE);
+			ksft_print_msg("failed to open %s: %s\n", GUP_TEST_FILE, strerror(errno));
 			break;
 		}
-		exit(KSFT_SKIP);
+		ksft_test_result_skip("Please run this test as root\n");
+		return ksft_exit_pass();
 	}
 
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, filed, 0);
-	if (p == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (p == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 	gup.addr = (unsigned long)p;
 
 	if (thp == 1)
@@ -264,7 +264,8 @@ int main(int argc, char **argv)
 		ret = pthread_join(tid[i], NULL);
 		assert(ret == 0);
 	}
+
 	free(tid);
 
-	return 0;
+	return ksft_exit_pass();
 }
-- 
2.42.0


