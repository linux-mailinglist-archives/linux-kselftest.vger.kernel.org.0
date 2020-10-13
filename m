Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9428D534
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 22:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgJMUJj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Oct 2020 16:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgJMUJj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Oct 2020 16:09:39 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D65C061755
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 13:09:39 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l16so1922925ilj.9
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=NXWC5CzBum2E0SJLBqCTTMt5gOogFp/ULBBxOq9oRjU=;
        b=egKUy8WCm8Lt+sv0QEKtFBvIAQqnkvdegpLABHMpoUObR894mMe6+6ApMIaLXcDVKR
         CfGXx51yb7XCM7Z4oKTF9QEzncBb6Clqn41TCKAAfvQcVVNHpOWuKgxx/gzlvXh4C+so
         oqfg7r6VnqnoKYHNKGKoiy+LZ09mbVbTOxjj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=NXWC5CzBum2E0SJLBqCTTMt5gOogFp/ULBBxOq9oRjU=;
        b=O2neRMhPVIdFbMry7RXw4pUQEUDBo0YH4H4ehRHFm3Zln/QjrkerysQJxuUtVV3LYt
         UDcVvjol47H30MQcgUgX71UYDFJU6qtfWvWJpCHXeFIX0TwOodxV6amD3tJcLbFoU5ii
         sB3eQJrIaM4KMOR4Ln+JmwfHBQjiAwr4FoI/baBMFawfQ7QEugpiUOuDempssvualR1R
         cIKgNRKH3ovq+ZfbaHBDKka6e839uc2FlyZZF6VoZixUzoRkUhqUhval9k/Jzb860t3e
         QBcLm5UyTvBwDzWaHGAThkv7u/BGTm2wyjVgq0c3zqCWoyiHN1fLcuysP1ZKOtvJDGHc
         R1YQ==
X-Gm-Message-State: AOAM5330rskHKY4zuqR0jUmZNvOTwVKeD+5fY7PXxvGiNICeCOn3fhyr
        rIVB31x9WzCyldQLOBUhynLKtTQOJpInVQ==
X-Google-Smtp-Source: ABdhPJx5m4BCAhDRJDez8Pog7uIDRSWoDgK65xb7OJI4Ib1LUr9DcEnk21SRwEmlnpXteZeRmoPRWQ==
X-Received: by 2002:a05:6e02:60c:: with SMTP id t12mr1158714ils.253.1602619778610;
        Tue, 13 Oct 2020 13:09:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t5sm737673ilf.17.2020.10.13.13.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 13:09:37 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.10-rc1
Message-ID: <5d868b5d-f3b9-7419-7049-bb2a620493fe@linuxfoundation.org>
Date:   Tue, 13 Oct 2020 14:09:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2DD99ED111DFC3D0B1633D7C"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------2DD99ED111DFC3D0B1633D7C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.10-rc1.

This kselftest fixes update consists of a selftests harness fix to
flush stdout before forking to avoid parent and child printing
duplicates messages. This is evident when test output is redirected
to a file.

The second fix is a tools/ wide change to avoid comma separated
statements from Joe Perches. This fix spans tools/lib,
tools/power/cpupower, and selftests.

diff is attached

Please note that there is a conflict in
   tools/testing/selftests/vm/gup_test.c

between commit:

   aa803771a80a ("tools: Avoid comma separated statements")

from the kselftest-fixes tree and commit:

   5c64830675a6 ("mm/gup_benchmark: rename to mm/gup_test")

from the akpm tree.

tools/testing/selftests/vm/gup_benchmark.c has been renamed
in 5c64830675a6 from akpm tree.

Stephen fixed this up in linux-next.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 5c1e4f7e9e49b6925b1fb5c507d2c614f3edb292:

   selftests/timers: Turn off timeout setting (2020-08-20 15:49:28 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-fixes-5.10-rc1

for you to fetch changes up to aa803771a80aa2aa2d5cdd38434b369066fbb8fc:

   tools: Avoid comma separated statements (2020-10-02 10:36:36 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.10-rc1

This kselftest fixes update consists of a selftests harness fix to
flush stdout before forking to avoid parent and child printing
duplicates messages. This is evident when test output is redirected
to a file.

The second fix is a tools/ wide change to avoid comma separated statements
from Joe Perches. This fix spans tools/lib, tools/power/cpupower, and
selftests.

----------------------------------------------------------------
Joe Perches (1):
       tools: Avoid comma separated statements

Michael Ellerman (1):
       selftests/harness: Flush stdout before forking

  tools/lib/subcmd/help.c                     |  10 +-
  tools/power/cpupower/utils/cpufreq-set.c    |  14 +-
  tools/testing/selftests/kselftest_harness.h |   5 +
  tools/testing/selftests/vm/gup_benchmark.c  |  18 +-
  tools/testing/selftests/vm/userfaultfd.c    | 296 
+++++++++++++++++-----------
  5 files changed, 215 insertions(+), 128 deletions(-)
----------------------------------------------------------------

--------------2DD99ED111DFC3D0B1633D7C
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.10-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.10-rc1.diff"

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 2859f107abc8..bf02d62a3b2b 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -65,12 +65,14 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	ci = cj = ei = 0;
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
-		if (cmp < 0)
+		if (cmp < 0) {
 			cmds->names[cj++] = cmds->names[ci++];
-		else if (cmp == 0)
-			ci++, ei++;
-		else if (cmp > 0)
+		} else if (cmp == 0) {
+			ci++;
 			ei++;
+		} else if (cmp > 0) {
+			ei++;
+		}
 	}
 
 	while (ci < cmds->cnt)
diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 6ed82fba5aaa..7b2164e07057 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -99,13 +99,17 @@ static unsigned long string_to_frequency(const char *str)
 		continue;
 
 	if (str[cp] == '.') {
-		while (power > -1 && isdigit(str[cp+1]))
-			cp++, power--;
+		while (power > -1 && isdigit(str[cp+1])) {
+			cp++;
+			power--;
+		}
 	}
-	if (power >= -1)	/* not enough => pad */
+	if (power >= -1) {		/* not enough => pad */
 		pad = power + 1;
-	else			/* to much => strip */
-		pad = 0, cp += power + 1;
+	} else {			/* too much => strip */
+		pad = 0;
+		cp += power + 1;
+	}
 	/* check bounds */
 	if (cp <= 0 || cp + pad > NORM_FREQ_LEN - 1)
 		return 0;
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4f78e4805633..f19804df244c 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -971,6 +971,11 @@ void __run_test(struct __fixture_metadata *f,
 
 	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+
+	/* Make sure output buffers are flushed before fork */
+	fflush(stdout);
+	fflush(stderr);
+
 	t->pid = fork();
 	if (t->pid < 0) {
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 43b4dfe161a2..d69f0eb0d8c0 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -105,12 +105,16 @@ int main(int argc, char **argv)
 		gup.flags |= FOLL_WRITE;
 
 	fd = open("/sys/kernel/debug/gup_benchmark", O_RDWR);
-	if (fd == -1)
-		perror("open"), exit(1);
+	if (fd == -1) {
+		perror("open");
+		exit(1);
+	}
 
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, filed, 0);
-	if (p == MAP_FAILED)
-		perror("mmap"), exit(1);
+	if (p == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
 	gup.addr = (unsigned long)p;
 
 	if (thp == 1)
@@ -123,8 +127,10 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < repeats; i++) {
 		gup.size = size;
-		if (ioctl(fd, cmd, &gup))
-			perror("ioctl"), exit(1);
+		if (ioctl(fd, cmd, &gup)) {
+			perror("ioctl");
+			exit(1);
+		}
 
 		printf("Time: get:%lld put:%lld us", gup.get_delta_usec,
 			gup.put_delta_usec);
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 61e5cfeb1350..9b0912a01777 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -227,8 +227,10 @@ static void hugetlb_allocate_area(void **alloc_area)
 				  huge_fd, *alloc_area == area_src ? 0 :
 				  nr_pages * page_size);
 		if (area_alias == MAP_FAILED) {
-			if (munmap(*alloc_area, nr_pages * page_size) < 0)
-				perror("hugetlb munmap"), exit(1);
+			if (munmap(*alloc_area, nr_pages * page_size) < 0) {
+				perror("hugetlb munmap");
+				exit(1);
+			}
 			*alloc_area = NULL;
 			return;
 		}
@@ -337,9 +339,10 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 	/* Undo write-protect, do wakeup after that */
 	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
 
-	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms))
-		fprintf(stderr, "clear WP failed for address 0x%Lx\n",
-			start), exit(1);
+	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms)) {
+		fprintf(stderr, "clear WP failed for address 0x%Lx\n", start);
+		exit(1);
+	}
 }
 
 static void *locking_thread(void *arg)
@@ -359,8 +362,10 @@ static void *locking_thread(void *arg)
 			seed += cpu;
 		bzero(&rand, sizeof(rand));
 		bzero(&randstate, sizeof(randstate));
-		if (initstate_r(seed, randstate, sizeof(randstate), &rand))
-			fprintf(stderr, "srandom_r error\n"), exit(1);
+		if (initstate_r(seed, randstate, sizeof(randstate), &rand)) {
+			fprintf(stderr, "srandom_r error\n");
+			exit(1);
+		}
 	} else {
 		page_nr = -bounces;
 		if (!(bounces & BOUNCE_RACINGFAULTS))
@@ -369,12 +374,16 @@ static void *locking_thread(void *arg)
 
 	while (!finished) {
 		if (bounces & BOUNCE_RANDOM) {
-			if (random_r(&rand, &rand_nr))
-				fprintf(stderr, "random_r 1 error\n"), exit(1);
+			if (random_r(&rand, &rand_nr)) {
+				fprintf(stderr, "random_r 1 error\n");
+				exit(1);
+			}
 			page_nr = rand_nr;
 			if (sizeof(page_nr) > sizeof(rand_nr)) {
-				if (random_r(&rand, &rand_nr))
-					fprintf(stderr, "random_r 2 error\n"), exit(1);
+				if (random_r(&rand, &rand_nr)) {
+					fprintf(stderr, "random_r 2 error\n");
+					exit(1);
+				}
 				page_nr |= (((unsigned long) rand_nr) << 16) <<
 					   16;
 			}
@@ -385,11 +394,13 @@ static void *locking_thread(void *arg)
 		start = time(NULL);
 		if (bounces & BOUNCE_VERIFY) {
 			count = *area_count(area_dst, page_nr);
-			if (!count)
+			if (!count) {
 				fprintf(stderr,
 					"page_nr %lu wrong count %Lu %Lu\n",
 					page_nr, count,
-					count_verify[page_nr]), exit(1);
+					count_verify[page_nr]);
+				exit(1);
+			}
 
 
 			/*
@@ -401,11 +412,12 @@ static void *locking_thread(void *arg)
 			 */
 #if 1
 			if (!my_bcmp(area_dst + page_nr * page_size, zeropage,
-				     page_size))
+				     page_size)) {
 				fprintf(stderr,
 					"my_bcmp page_nr %lu wrong count %Lu %Lu\n",
-					page_nr, count,
-					count_verify[page_nr]), exit(1);
+					page_nr, count, count_verify[page_nr]);
+				exit(1);
+			}
 #else
 			unsigned long loops;
 
@@ -437,7 +449,7 @@ static void *locking_thread(void *arg)
 			fprintf(stderr,
 				"page_nr %lu memory corruption %Lu %Lu\n",
 				page_nr, count,
-				count_verify[page_nr]), exit(1);
+				count_verify[page_nr]); exit(1);
 		}
 		count++;
 		*area_count(area_dst, page_nr) = count_verify[page_nr] = count;
@@ -461,12 +473,14 @@ static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
 				     offset);
 	if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
-		if (uffdio_copy->copy != -EEXIST)
+		if (uffdio_copy->copy != -EEXIST) {
 			fprintf(stderr, "UFFDIO_COPY retry error %Ld\n",
-				uffdio_copy->copy), exit(1);
+				uffdio_copy->copy);
+			exit(1);
+		}
 	} else {
 		fprintf(stderr,	"UFFDIO_COPY retry unexpected %Ld\n",
-			uffdio_copy->copy), exit(1);
+			uffdio_copy->copy); exit(1);
 	}
 }
 
@@ -474,9 +488,10 @@ static int __copy_page(int ufd, unsigned long offset, bool retry)
 {
 	struct uffdio_copy uffdio_copy;
 
-	if (offset >= nr_pages * page_size)
-		fprintf(stderr, "unexpected offset %lu\n",
-			offset), exit(1);
+	if (offset >= nr_pages * page_size) {
+		fprintf(stderr, "unexpected offset %lu\n", offset);
+		exit(1);
+	}
 	uffdio_copy.dst = (unsigned long) area_dst + offset;
 	uffdio_copy.src = (unsigned long) area_src + offset;
 	uffdio_copy.len = page_size;
@@ -487,12 +502,14 @@ static int __copy_page(int ufd, unsigned long offset, bool retry)
 	uffdio_copy.copy = 0;
 	if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
-		if (uffdio_copy.copy != -EEXIST)
+		if (uffdio_copy.copy != -EEXIST) {
 			fprintf(stderr, "UFFDIO_COPY error %Ld\n",
-				uffdio_copy.copy), exit(1);
+				uffdio_copy.copy);
+			exit(1);
+		}
 	} else if (uffdio_copy.copy != page_size) {
 		fprintf(stderr, "UFFDIO_COPY unexpected copy %Ld\n",
-			uffdio_copy.copy), exit(1);
+			uffdio_copy.copy); exit(1);
 	} else {
 		if (test_uffdio_copy_eexist && retry) {
 			test_uffdio_copy_eexist = false;
@@ -521,11 +538,11 @@ static int uffd_read_msg(int ufd, struct uffd_msg *msg)
 		if (ret < 0) {
 			if (errno == EAGAIN)
 				return 1;
-			else
-				perror("blocking read error"), exit(1);
+			perror("blocking read error");
 		} else {
-			fprintf(stderr, "short read\n"), exit(1);
+			fprintf(stderr, "short read\n");
 		}
+		exit(1);
 	}
 
 	return 0;
@@ -536,9 +553,10 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 {
 	unsigned long offset;
 
-	if (msg->event != UFFD_EVENT_PAGEFAULT)
-		fprintf(stderr, "unexpected msg event %u\n",
-			msg->event), exit(1);
+	if (msg->event != UFFD_EVENT_PAGEFAULT) {
+		fprintf(stderr, "unexpected msg event %u\n", msg->event);
+		exit(1);
+	}
 
 	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
 		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
@@ -546,8 +564,10 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 	} else {
 		/* Missing page faults */
 		if (bounces & BOUNCE_VERIFY &&
-		    msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
-			fprintf(stderr, "unexpected write fault\n"), exit(1);
+		    msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE) {
+			fprintf(stderr, "unexpected write fault\n");
+			exit(1);
+		}
 
 		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
 		offset &= ~(page_size-1);
@@ -574,25 +594,32 @@ static void *uffd_poll_thread(void *arg)
 
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
-		if (!ret)
-			fprintf(stderr, "poll error %d\n", ret), exit(1);
-		if (ret < 0)
-			perror("poll"), exit(1);
+		if (!ret) {
+			fprintf(stderr, "poll error %d\n", ret);
+			exit(1);
+		}
+		if (ret < 0) {
+			perror("poll");
+			exit(1);
+		}
 		if (pollfd[1].revents & POLLIN) {
-			if (read(pollfd[1].fd, &tmp_chr, 1) != 1)
-				fprintf(stderr, "read pipefd error\n"),
-					exit(1);
+			if (read(pollfd[1].fd, &tmp_chr, 1) != 1) {
+				fprintf(stderr, "read pipefd error\n");
+				exit(1);
+			}
 			break;
 		}
-		if (!(pollfd[0].revents & POLLIN))
+		if (!(pollfd[0].revents & POLLIN)) {
 			fprintf(stderr, "pollfd[0].revents %d\n",
-				pollfd[0].revents), exit(1);
+				pollfd[0].revents);
+			exit(1);
+		}
 		if (uffd_read_msg(uffd, &msg))
 			continue;
 		switch (msg.event) {
 		default:
 			fprintf(stderr, "unexpected msg event %u\n",
-				msg.event), exit(1);
+				msg.event); exit(1);
 			break;
 		case UFFD_EVENT_PAGEFAULT:
 			uffd_handle_page_fault(&msg, stats);
@@ -606,8 +633,10 @@ static void *uffd_poll_thread(void *arg)
 			uffd_reg.range.start = msg.arg.remove.start;
 			uffd_reg.range.len = msg.arg.remove.end -
 				msg.arg.remove.start;
-			if (ioctl(uffd, UFFDIO_UNREGISTER, &uffd_reg.range))
-				fprintf(stderr, "remove failure\n"), exit(1);
+			if (ioctl(uffd, UFFDIO_UNREGISTER, &uffd_reg.range)) {
+				fprintf(stderr, "remove failure\n");
+				exit(1);
+			}
 			break;
 		case UFFD_EVENT_REMAP:
 			area_dst = (char *)(unsigned long)msg.arg.remap.to;
@@ -879,8 +908,10 @@ static int faulting_process(int signal_test)
 
 	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
 			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
-	if (area_dst == MAP_FAILED)
-		perror("mremap"), exit(1);
+	if (area_dst == MAP_FAILED) {
+		perror("mremap");
+		exit(1);
+	}
 
 	for (; nr < nr_pages; nr++) {
 		count = *area_count(area_dst, nr);
@@ -888,7 +919,7 @@ static int faulting_process(int signal_test)
 			fprintf(stderr,
 				"nr %lu memory corruption %Lu %Lu\n",
 				nr, count,
-				count_verify[nr]), exit(1);
+				count_verify[nr]); exit(1);
 		}
 		/*
 		 * Trigger write protection if there is by writting
@@ -901,8 +932,10 @@ static int faulting_process(int signal_test)
 		return 1;
 
 	for (nr = 0; nr < nr_pages; nr++) {
-		if (my_bcmp(area_dst + nr * page_size, zeropage, page_size))
-			fprintf(stderr, "nr %lu is not zero\n", nr), exit(1);
+		if (my_bcmp(area_dst + nr * page_size, zeropage, page_size)) {
+			fprintf(stderr, "nr %lu is not zero\n", nr);
+			exit(1);
+		}
 	}
 
 	return 0;
@@ -916,12 +949,14 @@ static void retry_uffdio_zeropage(int ufd,
 				     uffdio_zeropage->range.len,
 				     offset);
 	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
-		if (uffdio_zeropage->zeropage != -EEXIST)
+		if (uffdio_zeropage->zeropage != -EEXIST) {
 			fprintf(stderr, "UFFDIO_ZEROPAGE retry error %Ld\n",
-				uffdio_zeropage->zeropage), exit(1);
+				uffdio_zeropage->zeropage);
+			exit(1);
+		}
 	} else {
 		fprintf(stderr, "UFFDIO_ZEROPAGE retry unexpected %Ld\n",
-			uffdio_zeropage->zeropage), exit(1);
+			uffdio_zeropage->zeropage); exit(1);
 	}
 }
 
@@ -933,9 +968,10 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 
 	has_zeropage = uffd_test_ops->expected_ioctls & (1 << _UFFDIO_ZEROPAGE);
 
-	if (offset >= nr_pages * page_size)
-		fprintf(stderr, "unexpected offset %lu\n",
-			offset), exit(1);
+	if (offset >= nr_pages * page_size) {
+		fprintf(stderr, "unexpected offset %lu\n", offset);
+		exit(1);
+	}
 	uffdio_zeropage.range.start = (unsigned long) area_dst + offset;
 	uffdio_zeropage.range.len = page_size;
 	uffdio_zeropage.mode = 0;
@@ -943,22 +979,26 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 	if (ret) {
 		/* real retval in ufdio_zeropage.zeropage */
 		if (has_zeropage) {
-			if (uffdio_zeropage.zeropage == -EEXIST)
-				fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n"),
-					exit(1);
-			else
+			if (uffdio_zeropage.zeropage == -EEXIST) {
+				fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n");
+				exit(1);
+			} else {
 				fprintf(stderr, "UFFDIO_ZEROPAGE error %Ld\n",
-					uffdio_zeropage.zeropage), exit(1);
+					uffdio_zeropage.zeropage);
+				exit(1);
+			}
 		} else {
-			if (uffdio_zeropage.zeropage != -EINVAL)
+			if (uffdio_zeropage.zeropage != -EINVAL) {
 				fprintf(stderr,
 					"UFFDIO_ZEROPAGE not -EINVAL %Ld\n",
-					uffdio_zeropage.zeropage), exit(1);
+					uffdio_zeropage.zeropage);
+				exit(1);
+			}
 		}
 	} else if (has_zeropage) {
 		if (uffdio_zeropage.zeropage != page_size) {
 			fprintf(stderr, "UFFDIO_ZEROPAGE unexpected %Ld\n",
-				uffdio_zeropage.zeropage), exit(1);
+				uffdio_zeropage.zeropage); exit(1);
 		} else {
 			if (test_uffdio_zeropage_eexist && retry) {
 				test_uffdio_zeropage_eexist = false;
@@ -970,7 +1010,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 	} else {
 		fprintf(stderr,
 			"UFFDIO_ZEROPAGE succeeded %Ld\n",
-			uffdio_zeropage.zeropage), exit(1);
+			uffdio_zeropage.zeropage); exit(1);
 	}
 
 	return 0;
@@ -1000,19 +1040,24 @@ static int userfaultfd_zeropage_test(void)
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 	if (test_uffdio_wp)
 		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
-		fprintf(stderr, "register failure\n"), exit(1);
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
+		fprintf(stderr, "register failure\n");
+		exit(1);
+	}
 
 	expected_ioctls = uffd_test_ops->expected_ioctls;
 	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
+	    expected_ioctls) {
 		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+			"unexpected missing ioctl for anon memory\n");
+		exit(1);
+	}
 
 	if (uffdio_zeropage(uffd, 0)) {
-		if (my_bcmp(area_dst, zeropage, page_size))
-			fprintf(stderr, "zeropage is not zero\n"), exit(1);
+		if (my_bcmp(area_dst, zeropage, page_size)) {
+			fprintf(stderr, "zeropage is not zero\n");
+			exit(1);
+		}
 	}
 
 	close(uffd);
@@ -1047,32 +1092,41 @@ static int userfaultfd_events_test(void)
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 	if (test_uffdio_wp)
 		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
-		fprintf(stderr, "register failure\n"), exit(1);
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
+		fprintf(stderr, "register failure\n");
+		exit(1);
+	}
 
 	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
-		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls) {
+		fprintf(stderr, "unexpected missing ioctl for anon memory\n");
+		exit(1);
+	}
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
-		perror("uffd_poll_thread create"), exit(1);
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats)) {
+		perror("uffd_poll_thread create");
+		exit(1);
+	}
 
 	pid = fork();
-	if (pid < 0)
-		perror("fork"), exit(1);
+	if (pid < 0) {
+		perror("fork");
+		exit(1);
+	}
 
 	if (!pid)
 		return faulting_process(0);
 
 	waitpid(pid, &err, 0);
-	if (err)
-		fprintf(stderr, "faulting process failed\n"), exit(1);
+	if (err) {
+		fprintf(stderr, "faulting process failed\n");
+		exit(1);
+	}
 
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
-		perror("pipe write"), exit(1);
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c)) {
+		perror("pipe write");
+		exit(1);
+	}
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
@@ -1110,38 +1164,49 @@ static int userfaultfd_sig_test(void)
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 	if (test_uffdio_wp)
 		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
-		fprintf(stderr, "register failure\n"), exit(1);
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
+		fprintf(stderr, "register failure\n");
+		exit(1);
+	}
 
 	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
-		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls) {
+		fprintf(stderr, "unexpected missing ioctl for anon memory\n");
+		exit(1);
+	}
 
-	if (faulting_process(1))
-		fprintf(stderr, "faulting process failed\n"), exit(1);
+	if (faulting_process(1)) {
+		fprintf(stderr, "faulting process failed\n");
+		exit(1);
+	}
 
 	if (uffd_test_ops->release_pages(area_dst))
 		return 1;
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
-		perror("uffd_poll_thread create"), exit(1);
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats)) {
+		perror("uffd_poll_thread create");
+		exit(1);
+	}
 
 	pid = fork();
-	if (pid < 0)
-		perror("fork"), exit(1);
+	if (pid < 0) {
+		perror("fork");
+		exit(1);
+	}
 
 	if (!pid)
 		exit(faulting_process(2));
 
 	waitpid(pid, &err, 0);
-	if (err)
-		fprintf(stderr, "faulting process failed\n"), exit(1);
+	if (err) {
+		fprintf(stderr, "faulting process failed\n");
+		exit(1);
+	}
 
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
-		perror("pipe write"), exit(1);
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c)) {
+		perror("pipe write");
+		exit(1);
+	}
 	if (pthread_join(uffd_mon, (void **)&userfaults))
 		return 1;
 
@@ -1395,7 +1460,7 @@ static void set_test_type(const char *type)
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
 	} else {
-		fprintf(stderr, "Unknown test type: %s\n", type), exit(1);
+		fprintf(stderr, "Unknown test type: %s\n", type); exit(1);
 	}
 
 	if (test_type == TEST_HUGETLB)
@@ -1403,12 +1468,15 @@ static void set_test_type(const char *type)
 	else
 		page_size = sysconf(_SC_PAGE_SIZE);
 
-	if (!page_size)
-		fprintf(stderr, "Unable to determine page size\n"),
-				exit(2);
+	if (!page_size) {
+		fprintf(stderr, "Unable to determine page size\n");
+		exit(2);
+	}
 	if ((unsigned long) area_count(NULL, 0) + sizeof(unsigned long long) * 2
-	    > page_size)
-		fprintf(stderr, "Impossible to run this test\n"), exit(2);
+	    > page_size) {
+		fprintf(stderr, "Impossible to run this test\n");
+		exit(2);
+	}
 }
 
 static void sigalrm(int sig)
@@ -1425,8 +1493,10 @@ int main(int argc, char **argv)
 	if (argc < 4)
 		usage();
 
-	if (signal(SIGALRM, sigalrm) == SIG_ERR)
-		fprintf(stderr, "failed to arm SIGALRM"), exit(1);
+	if (signal(SIGALRM, sigalrm) == SIG_ERR) {
+		fprintf(stderr, "failed to arm SIGALRM");
+		exit(1);
+	}
 	alarm(ALARM_INTERVAL_SECS);
 
 	set_test_type(argv[1]);

--------------2DD99ED111DFC3D0B1633D7C--
