Return-Path: <linux-kselftest+bounces-4449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0155A84F7A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D6E1C211BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84044128376;
	Fri,  9 Feb 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py2oq7OI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A17128372;
	Fri,  9 Feb 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489154; cv=none; b=dRDooECvdFxQ8OK6i5iNWwyy3Eyau22f6aEJmPEJJu6am51aEVMgbPQBpu6gAP9s90EXO5KXyAzP7/KihPKQAr9iSypA2avXftA3TvdXZP77ZyySvnFUFjC41pGMp/dsifEpoAjnMsCgL1oXa8OxToCcxT6tn0RgNeVRvP90cu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489154; c=relaxed/simple;
	bh=n2TkytHIU4mJGTYx0ffPU1nCUw4lDwT3it9P2hgZMPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0oiLhkHQM4OpTWtFywK8FmuR5LnOHNLsdF/YabXnSurqU5TPutCaKJMz3ni6WkxgOEDgqgKiJlsbwRSZ4Cffe3m7GJPBhIKAue+uyOnf7O1rctcA0Je/5soL46Gy6JBXV7g8sU1Vya23p3r03B4AiV3MPku3pIWVvhULRcT7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py2oq7OI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEFAC433C7;
	Fri,  9 Feb 2024 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707489153;
	bh=n2TkytHIU4mJGTYx0ffPU1nCUw4lDwT3it9P2hgZMPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Py2oq7OIoqGE1rDSbcY4ohm7stPtta09azzXhVmXoVzbO/0KaU7eC/gGaa5B2uJya
	 ghfwSgvu1WyV3AssZpBArKxQ+NDKA/FkPwQvRLA33obpvD//AicUslTMbDNKPdwq/7
	 3pSxLNPShKyL2QxN8mYrPjn3R1lPMGA5WQtFU3k5y3hsBmtb/zWUPtAlYtmo7OwXaw
	 JqG6H1X3af1LE34qRQrwvFYTyzxlZPAvFngqjXCuvVBtzSAF8Hm7Fa1f9h78yRmHj+
	 QXZM6J/xZVntBQ2Sj2l4MtSYTOFd9Elk7ZC5ZpculubiLP4Pl0A5AeXzXhy12MtCNY
	 ZSO7PdsEOP+oA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Feb 2024 14:30:04 +0000
Subject: [PATCH 2/2] selftests/mm: Log a consistent test name for
 check_compaction
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-kselftest-mm-cleanup-v1-2-a3c0386496b5@kernel.org>
References: <20240209-kselftest-mm-cleanup-v1-0-a3c0386496b5@kernel.org>
In-Reply-To: <20240209-kselftest-mm-cleanup-v1-0-a3c0386496b5@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Ryan Roberts <Ryan.Roberts@arm.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=n2TkytHIU4mJGTYx0ffPU1nCUw4lDwT3it9P2hgZMPQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlxjd2eHrNdRwA/quROZ5aC1w1CkozU3y7OQRiA
 QsCxUdoBAWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcY3dgAKCRAk1otyXVSH
 0DfUB/95u6qaCHLmx6YhkYZFy0UOyUJinhJLQsXirmJrQvvovBbB+oDXMGLdYsHMTg7Li2TMAgS
 s9uH/dAJDcoVtf0eEPwd+ztweDP26Q9sz6YzdJee6nPykOnyult75zLJnVo5KKEf0QWOyCwWMIy
 MZkfeqsEkVfnsKnsrHIhM/y0iLAN/4mBO6IyPqFgDGHsmebtxKqR1AikuvhFWufo5KGG+9IxCh3
 N5qgNq9ClC9mYgUoSc1eWSiK3bXEYPNilDhvNBJL+6y8GxPQEnMrp0hfSkWUx/1Uzx1ClkjOvYU
 kpSQ9jSaMDI5CrpuDlvw5E3MutDaeJHBIC+Avx/EqSx5H9FA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Every test result report in the compaction test prints a distinct log
messae, and some of the reports print a name that varies at runtime. This
causes problems for automation since a lot of automation software uses the
printed string as the name of the test, if the name varies from run to run
and from pass to fail then the automation software can't identify that a
test changed result or that the same tests are being run.

Refactor the logging to use a consistent name when printing the result of
the test, printing the existing messages as diagnostic information instead
so they are still available for people trying to interpret the results.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/compaction_test.c | 35 +++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 30150929c8c5..533999b6c284 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -95,21 +95,22 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
-		ksft_test_result_fail("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
-		return -1;
+		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		ret = -1;
+		goto out;
 	}
 
 	if (read(fd, initial_nr_hugepages, sizeof(initial_nr_hugepages)) <= 0) {
-		ksft_test_result_fail("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
 	/* Start with the initial condition of 0 huge pages*/
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
-		ksft_test_result_fail("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
@@ -118,16 +119,16 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 	/* Request a large number of huge pages. The Kernel will allocate
 	   as much as it can */
 	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		ksft_test_result_fail("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
 	lseek(fd, 0, SEEK_SET);
 
 	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
-		ksft_test_result_fail("Failed to re-read from /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to re-read from /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
@@ -139,24 +140,26 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
 	    != strlen(initial_nr_hugepages)) {
-		ksft_test_result_fail("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+		ksft_print_msg("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
 		goto close_fd;
 	}
 
+	ksft_print_msg("Number of huge pages allocated = %d\n",
+		       atoi(nr_hugepages));
+
 	if (compaction_index > 3) {
 		ksft_print_msg("ERROR: Less that 1/%d of memory is available\n"
 			       "as huge pages\n", compaction_index);
-		ksft_test_result_fail("No of huge pages allocated = %d\n", (atoi(nr_hugepages)));
 		goto close_fd;
 	}
 
-	ksft_test_result_pass("Memory compaction succeeded. No of huge pages allocated = %d\n",
-			      (atoi(nr_hugepages)));
 	ret = 0;
 
  close_fd:
 	close(fd);
+ out:
+	ksft_test_result(ret == 0, "check_compaction\n");
 	return ret;
 }
 

-- 
2.39.2


