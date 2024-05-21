Return-Path: <linux-kselftest+bounces-10466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF388CA93D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 09:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794841F22130
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE853362;
	Tue, 21 May 2024 07:44:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B095A524D6;
	Tue, 21 May 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277473; cv=none; b=iXunw374rYHDiqxcGSoVWLQn6u06uKWljM0fyyrM3pkWiCjfVei3sBKaTXq4bLiW1umsysj3B2CvgtcNZxitKqiZ1txcpOnsq5kXnbrrz4x0aCEk3Fc0BIqYRGUOS1P8FowutIgwxufnybPrEFv6TvnlJz7UMMtqq5jP7L74mtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277473; c=relaxed/simple;
	bh=8Szx0nFBFoPukBaSuQkk99ZleFt5zW1I8Vmw94Mnvn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnn5GvUrPgnXhRiR50PV/MOItr4iBPGZcjTx+j3p+PtL69LDUkviaSwb7YFNpNWo9xllfrjkPLgugK0D7S96fKGYP22/FLAZp+Zn//C7DLR7R/1HUB0PhDFIGSd3I007L8cuXYYmTe1WJTuAxYkFyhmzQor0VJZRq/4Ea1q3Vng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED9D8DA7;
	Tue, 21 May 2024 00:44:54 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF2A93F641;
	Tue, 21 May 2024 00:44:27 -0700 (PDT)
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
Subject: [PATCH v2 3/3] selftests/mm: compaction_test: Fix bogus test success and reduce probability of OOM-killer invocation
Date: Tue, 21 May 2024 13:13:58 +0530
Message-Id: <20240521074358.675031-4-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521074358.675031-1-dev.jain@arm.com>
References: <20240521074358.675031-1-dev.jain@arm.com>
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

Changes in v2:
- Handle unsigned long number of hugepages

v1:
- https://lore.kernel.org/all/20240515093633.54814-3-dev.jain@arm.com/

NOTE: This patch depends on the previous one.

Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/compaction_test.c | 71 ++++++++++++++------
 1 file changed, 49 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 5e9bd1da9370..e140558e6f53 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -82,13 +82,16 @@ int prereq(void)
 	return -1;
 }
 
-int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
+int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
+		     unsigned long initial_nr_hugepages)
 {
 	unsigned long nr_hugepages_ul;
 	int fd, ret = -1;
 	int compaction_index = 0;
-	char initial_nr_hugepages[20] = {0};
 	char nr_hugepages[20] = {0};
+	char init_nr_hugepages[20] = {0};
+
+	sprintf(init_nr_hugepages, "%lu", initial_nr_hugepages);
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
@@ -102,23 +105,6 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
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
@@ -146,8 +132,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 
 	lseek(fd, 0, SEEK_SET);
 
-	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
-	    != strlen(initial_nr_hugepages)) {
+	if (write(fd, init_nr_hugepages, strlen(init_nr_hugepages))
+	    != strlen(init_nr_hugepages)) {
 		ksft_print_msg("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
 			       strerror(errno));
 		goto close_fd;
@@ -171,6 +157,41 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 	return ret;
 }
 
+int set_zero_hugepages(unsigned long *initial_nr_hugepages)
+{
+	int fd, ret = -1;
+	char nr_hugepages[20] = {0};
+
+	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
+	if (fd < 0) {
+		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		goto out;
+	}
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
+	*initial_nr_hugepages = strtoul(nr_hugepages, NULL, 10);
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
@@ -181,6 +202,7 @@ int main(int argc, char **argv)
 	unsigned long mem_free = 0;
 	unsigned long hugepage_size = 0;
 	long mem_fragmentable_MB = 0;
+	unsigned long initial_nr_hugepages;
 
 	ksft_print_header();
 
@@ -189,6 +211,10 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(1);
 
+	/* Start the test without hugepages reducing mem_free */
+	if (set_zero_hugepages(&initial_nr_hugepages))
+		ksft_exit_fail();
+
 	lim.rlim_cur = RLIM_INFINITY;
 	lim.rlim_max = RLIM_INFINITY;
 	if (setrlimit(RLIMIT_MEMLOCK, &lim))
@@ -232,7 +258,8 @@ int main(int argc, char **argv)
 		entry = entry->next;
 	}
 
-	if (check_compaction(mem_free, hugepage_size) == 0)
+	if (check_compaction(mem_free, hugepage_size,
+			     initial_nr_hugepages) == 0)
 		ksft_exit_pass();
 
 	ksft_exit_fail();
-- 
2.34.1


