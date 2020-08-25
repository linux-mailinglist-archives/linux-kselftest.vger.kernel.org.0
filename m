Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0729C251145
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Aug 2020 07:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgHYFFt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Aug 2020 01:05:49 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:54698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725287AbgHYFFr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Aug 2020 01:05:47 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 94468800B28B
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Aug 2020 04:57:43 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D89A0180A7FD3;
        Tue, 25 Aug 2020 04:57:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:305:327:355:379:541:800:960:968:973:988:989:1260:1311:1314:1345:1359:1437:1515:1605:1730:1747:1777:1792:1801:2393:2538:2559:2562:2897:2898:2899:3138:3139:3140:3141:3142:3867:3868:3870:3871:3874:4250:4321:4605:5007:6119:6261:7875:7903:8531:8603:10004:11026:11473:11657:11658:11914:12043:12296:12297:12438:12555:12663:12895:12986:13894:13972:14394:21080:21324:21611:21627:21987:21990:30003:30029:30030:30054:30056:30070:30079,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: oven52_591853927059
X-Filterd-Recvd-Size: 21532
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:36 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 29/29] tools: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:26 -0700
Message-Id: <52b68acfeb441b483de188f7e100600291f8c3ec.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 tools/lib/subcmd/help.c                    |  10 +-
 tools/power/cpupower/utils/cpufreq-set.c   |  14 +-
 tools/testing/selftests/vm/gup_benchmark.c |  18 +-
 tools/testing/selftests/vm/userfaultfd.c   | 296 +++++++++++++--------
 4 files changed, 210 insertions(+), 128 deletions(-)

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
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 31f8bb086907..1d4359341e44 100644
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
-- 
2.26.0

