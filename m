Return-Path: <linux-kselftest+bounces-10246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F18C63CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CF7285280
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38595A4D5;
	Wed, 15 May 2024 09:37:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801DE58AA5;
	Wed, 15 May 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765824; cv=none; b=e1UAueIrebyMfvIwC894q35veK/pZdIky0xfH24IeIRmKBHiXqw3bRS/zDSij9ZjZlzqeOT2ayPoEm6PPbQn4oihT0EVIpqBf1rWxvRQFPsQnMNBq2u+VoYdLZY30T7cStUNTyFFD4kJWmAKQL/H/emwTCk3/avqF4Ytn5hrucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765824; c=relaxed/simple;
	bh=BLRpEBdNNvjNMlAsjo9g7f89XRvo43IQU4onZx6YhTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0LahQJgRVOgd3O8kIpi4P1NyJr8qL2TWLuMEKPJCcDldBKW9NlYtTwlzGsZw2Ul/uMSpswrPQK2jHMZcYcaRcu2VkjddhD/uwiC8JHkXkK1049YrsAIg7Nq+m7XYjPEFXLAqhN+WLy2+tBjzOeB9L3StAfhJDCrAST+r08z4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2FDD1474;
	Wed, 15 May 2024 02:37:26 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2AD63F7A6;
	Wed, 15 May 2024 02:36:58 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	sjayaram@akamai.com,
	Dev Jain <dev.jain@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] selftests/mm: compaction_test: Fix trivial test success and reduce probability of OOM-killer invocation
Date: Wed, 15 May 2024 15:06:33 +0530
Message-Id: <20240515093633.54814-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515093633.54814-1-dev.jain@arm.com>
References: <20240515093633.54814-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset nr_hugepages to zero before the start of the test.

If a non-zero number of hugepages is already set before the start of the
test, the following problems arise:

 - The probability of the test getting OOM-killed increases.
Proof: The test wants to run on 80% of available memory to prevent
OOM-killing (see original code comments). Let the value of mem_free at the
start of the test, when nr_hugepages = 0, be x. In the other case, when
nr_hugepages > 0, let the memory consumed by hugepages be y. In the former
case, the test operates on 0.8 * x of memory. In the latter, the test
operates on 0.8 * (x - y) of memory, with y already filled, hence, memory
consumed is y + 0.8 * (x - y) = 0.8 * x + 0.2 * y > 0.8 * x. Q.E.D

 - The probability of a bogus test success increases.
Proof: Let the memory consumed by hugepages be greater than 25% of x,
with x and y defined as above. The definition of compaction_index is
c_index = (x - y)/z where z is the memory consumed by hugepages after
trying to increase them again. In check_compaction(), we set the number
of hugepages to zero, and then increase them back; the probability that
they will be set back to consume at least y amount of memory again is
very high (since there is not much delay between the two attempts of
changing nr_hugepages). Hence, z >= y > (x/4) (by the 25% assumption).
Therefore,
c_index = (x - y)/z <= (x - y)/y = x/y - 1 < 4 - 1 = 3
hence, c_index can always be forced to be less than 3, thereby the test
succeeding always. Q.E.D

NOTE: This patch depends on the previous one.

Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/compaction_test.c | 72 ++++++++++++++------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index c5be395f8363..2ae059989771 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -82,12 +82,15 @@ int prereq(void)
 	return -1;
 }
 
-int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
+int check_compaction(unsigned long mem_free, unsigned int hugepage_size,
+		     int initial_nr_hugepages)
 {
 	int fd, ret = -1;
 	int compaction_index = 0;
-	char initial_nr_hugepages[10] = {0};
 	char nr_hugepages[10] = {0};
+	char init_nr_hugepages[10] = {0};
+
+	sprintf(init_nr_hugepages, "%d", initial_nr_hugepages);
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
@@ -101,23 +104,6 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 		goto out;
 	}
 
-	if (read(fd, initial_nr_hugepages, sizeof(initial_nr_hugepages)) <= 0) {
-		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
-		goto close_fd;
-	}
-
-	lseek(fd, 0, SEEK_SET);
-
-	/* Start with the initial condition of 0 huge pages*/
-	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
-		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
-		goto close_fd;
-	}
-
-	lseek(fd, 0, SEEK_SET);
-
 	/* Request a large number of huge pages. The Kernel will allocate
 	   as much as it can */
 	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
@@ -140,8 +126,8 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	lseek(fd, 0, SEEK_SET);
 
-	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
-	    != strlen(initial_nr_hugepages)) {
+	if (write(fd, init_nr_hugepages, strlen(init_nr_hugepages))
+	    != strlen(init_nr_hugepages)) {
 		ksft_print_msg("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
 			       strerror(errno));
 		goto close_fd;
@@ -165,6 +151,42 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 	return ret;
 }
 
+int set_zero_hugepages(int *initial_nr_hugepages)
+{
+	int fd, ret = -1;
+	char nr_hugepages[10] = {0};
+
+	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
+	if (fd < 0) {
+		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		goto out;
+	}
+
+	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
+		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		goto close_fd;
+	}
+
+	lseek(fd, 0, SEEK_SET);
+
+	/* Start with the initial condition of 0 huge pages */
+	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
+		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		goto close_fd;
+	}
+
+	*initial_nr_hugepages = atoi(nr_hugepages);
+	ret = 0;
+
+ close_fd:
+	close(fd);
+
+ out:
+	return ret;
+}
 
 int main(int argc, char **argv)
 {
@@ -175,6 +197,7 @@ int main(int argc, char **argv)
 	unsigned long mem_free = 0;
 	unsigned long hugepage_size = 0;
 	long mem_fragmentable_MB = 0;
+	int initial_nr_hugepages;
 
 	ksft_print_header();
 
@@ -183,6 +206,10 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(1);
 
+	/* start the test without hugepages reducing mem_free */
+	if (set_zero_hugepages(&initial_nr_hugepages))
+		return ksft_exit_fail();
+
 	lim.rlim_cur = RLIM_INFINITY;
 	lim.rlim_max = RLIM_INFINITY;
 	if (setrlimit(RLIMIT_MEMLOCK, &lim))
@@ -226,7 +253,8 @@ int main(int argc, char **argv)
 		entry = entry->next;
 	}
 
-	if (check_compaction(mem_free, hugepage_size) == 0)
+	if (check_compaction(mem_free, hugepage_size,
+			     initial_nr_hugepages) == 0)
 		return ksft_exit_pass();
 
 	return ksft_exit_fail();
-- 
2.30.2


