Return-Path: <linux-kselftest+bounces-37401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B99A5B06BF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 05:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0966D189E1C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 03:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A730F286897;
	Wed, 16 Jul 2025 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wyU0Y/Uz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B46285C99
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635173; cv=none; b=krACjUVFVMKorXEeyK1jnNL9s5HlJ1CsDaWkdevubft5vkFULT1Vo9cu7O7LQOPVfD+AR7hYlLPmB0dDxAOremPt+6OfyqA8KiUwekqwlJOCccoYJ3dXbwwRJ2yHFN3Iaokt6Hl2O7Ljdv4PFDb7Bmpj3zjZAnYsbJRG1dy9i/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635173; c=relaxed/simple;
	bh=WMdtgrr0/nAUiC/6BwG7uLPF5Tm6Y08FEzL5Ntj1PoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UAPZyr0D8s/3AGXYK2KprN4wMCRADdLrumTIfpZVcjHkDS9oOjLJEKnoWRktuHMhOhg6mDVEqaJPI2jnQ9jmankBMC+Oiigvu76rIQ27c0sS1CIQdkS6q8xSO+rYJ4oxf3+JwjMJXjlylxK30ukNbsAsYwa7nTVoNjj4fceLsG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wyU0Y/Uz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so10008200a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 20:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752635171; x=1753239971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+EEGEPDve4y58hrdp46uj5UK2kmzvt0af85C6yPTlxY=;
        b=wyU0Y/UzRzmW9FcRJ0tQn3+KYN2lPUo9OSxZizFMPzxRUB7hidCcvTA+RLvImtn7ng
         53W0rC1F0Be3psQnXwne0U8QLeexF3Kbsad8fAyTrwvhWqnlzZ/I3wBz7rPnmWU9+20W
         P0Pu9+H+xiYFZf0EQtNQgp35X5KHyOv3gOmYbKmg+VHeJez33jn7OK6af6S1qziQc6Wq
         IKtt7AX5LERkf9tOnrldiabdEUNdzMeWTZH56NDGEkmoPA4UFt5Au5QVgXPxC0JLOmuJ
         jjDSy/1dikeURAKi/UrxeUAaVJr3QQx8fGx4XVAvaRdmuek79Q/EVlWTRtXVkmvS1k5l
         4Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635171; x=1753239971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EEGEPDve4y58hrdp46uj5UK2kmzvt0af85C6yPTlxY=;
        b=Nc6nA0UwWNM1MgVp5WjBn6+lZnCFaRFvv207aXe6U43/EZ8mhdzRFVqIxBryAKNwNY
         q0SmwCZxjM1qIYYgTyUmVv/0RWgNssissc/jB1jc0igXj9PE0woClcLBdsCE+PXnIWPZ
         wT6TUNwuAx8ma4n11IqxFjBjH/mf8mMXU1ONk7Q9DeQYwDbWrese1Fxc0SS+3uBEtzG8
         KfYnjYIk0U9pYDCSk5+9mWLQpW7/psZeVEA41C55m8f47c4m2Eb/H9XphlHkMoOXg4Dd
         +rEgFltgCIQ4fFrvZarNc0ZiZftY2I0IxIkdAJadhviqsi6WX2ELW8XnaHd+nlDImkcz
         GWUw==
X-Forwarded-Encrypted: i=1; AJvYcCVJQE4oMaPPLnUqxI7pi/ipbeYnMvBplfKOLNANeyV/U2Jrxgg2XAxfPm1p9wCASn6MTz2+6f4nm2StXbOMTbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyas+6CrLH/vdFWmkgBLCHuApC6f5oTVwMEtqQii+ZdfoimLYMT
	xJzZhngPl5US0j9rOWAaBoI1/+wnOHTxb67fn6ARaE5gp0DdfDcDwztm3vFAuZiAOWBCjYGjq35
	F05tlKg==
X-Google-Smtp-Source: AGHT+IEb/63ti7d4Q2qcu9whEMcfzkbMdhtts3srSHto5sREd8kxF2Vw4VbGHfvo4ixP5EDqUO+ceN5/tWk=
X-Received: from pjbsm16.prod.google.com ([2002:a17:90b:2e50:b0:31a:a0b3:5f6])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f49:b0:31a:b92c:d679
 with SMTP id 98e67ed59e1d1-31c9f44e3c1mr1397320a91.35.1752635171211; Tue, 15
 Jul 2025 20:06:11 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:05:54 -0700
In-Reply-To: <20250716030557.1547501-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716030557.1547501-6-surenb@google.com>
Subject: [PATCH v7 5/7] selftests/proc: add verbose more for tests to
 facilitate debugging
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Add verbose mode to the proc tests to print debugging information.
Usage: proc-pid-vm -v

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 159 ++++++++++++++++--
 1 file changed, 146 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 6acdafdac9db..5f912fedd6cf 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -39,6 +39,7 @@
 
 static unsigned long test_duration_sec = 5UL;
 static int page_size;
+static bool verbose;
 
 /* /proc/pid/maps parsing routines */
 struct page_content {
@@ -207,6 +208,99 @@ static void stop_vma_modifier(struct vma_modifier_info *mod_info)
 	signal_state(mod_info, SETUP_MODIFY_MAPS);
 }
 
+static void print_first_lines(char *text, int nr)
+{
+	const char *end = text;
+
+	while (nr && (end = strchr(end, '\n')) != NULL) {
+		nr--;
+		end++;
+	}
+
+	if (end) {
+		int offs = end - text;
+
+		text[offs] = '\0';
+		printf(text);
+		text[offs] = '\n';
+		printf("\n");
+	} else {
+		printf(text);
+	}
+}
+
+static void print_last_lines(char *text, int nr)
+{
+	const char *start = text + strlen(text);
+
+	nr++; /* to ignore the last newline */
+	while (nr) {
+		while (start > text && *start != '\n')
+			start--;
+		nr--;
+		start--;
+	}
+	printf(start);
+}
+
+static void print_boundaries(const char *title,
+			     struct page_content *page1,
+			     struct page_content *page2)
+{
+	if (!verbose)
+		return;
+
+	printf("%s", title);
+	/* Print 3 boundary lines from each page */
+	print_last_lines(page1->data, 3);
+	printf("-----------------page boundary-----------------\n");
+	print_first_lines(page2->data, 3);
+}
+
+static bool print_boundaries_on(bool condition, const char *title,
+				struct page_content *page1,
+				struct page_content *page2)
+{
+	if (verbose && condition)
+		print_boundaries(title, page1, page2);
+
+	return condition;
+}
+
+static void report_test_start(const char *name)
+{
+	if (verbose)
+		printf("==== %s ====\n", name);
+}
+
+static struct timespec print_ts;
+
+static void start_test_loop(struct timespec *ts)
+{
+	if (verbose)
+		print_ts.tv_sec = ts->tv_sec;
+}
+
+static void end_test_iteration(struct timespec *ts)
+{
+	if (!verbose)
+		return;
+
+	/* Update every second */
+	if (print_ts.tv_sec == ts->tv_sec)
+		return;
+
+	printf(".");
+	fflush(stdout);
+	print_ts.tv_sec = ts->tv_sec;
+}
+
+static void end_test_loop(void)
+{
+	if (verbose)
+		printf("\n");
+}
+
 static void capture_mod_pattern(int maps_fd,
 				struct vma_modifier_info *mod_info,
 				struct page_content *page1,
@@ -218,18 +312,24 @@ static void capture_mod_pattern(int maps_fd,
 				struct line_content *restored_last_line,
 				struct line_content *restored_first_line)
 {
+	print_boundaries("Before modification", page1, page2);
+
 	signal_state(mod_info, SETUP_MODIFY_MAPS);
 	wait_for_state(mod_info, SETUP_MAPS_MODIFIED);
 
 	/* Copy last line of the first page and first line of the last page */
 	read_boundary_lines(maps_fd, page1, page2, mod_last_line, mod_first_line);
 
+	print_boundaries("After modification", page1, page2);
+
 	signal_state(mod_info, SETUP_RESTORE_MAPS);
 	wait_for_state(mod_info, SETUP_MAPS_RESTORED);
 
 	/* Copy last line of the first page and first line of the last page */
 	read_boundary_lines(maps_fd, page1, page2, restored_last_line, restored_first_line);
 
+	print_boundaries("After restore", page1, page2);
+
 	mod_info->vma_mod_check(mod_last_line, mod_first_line,
 				restored_last_line, restored_first_line);
 
@@ -301,6 +401,7 @@ static void test_maps_tearing_from_split(int maps_fd,
 	mod_info->vma_restore = merge_vma;
 	mod_info->vma_mod_check = check_split_result;
 
+	report_test_start("Tearing from split");
 	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
 			    &split_last_line, &split_first_line,
 			    &restored_last_line, &restored_first_line);
@@ -313,6 +414,7 @@ static void test_maps_tearing_from_split(int maps_fd,
 	struct timespec start_ts, end_ts;
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	start_test_loop(&start_ts);
 	do {
 		bool last_line_changed;
 		bool first_line_changed;
@@ -332,12 +434,18 @@ static void test_maps_tearing_from_split(int maps_fd,
 			 * In that case new first line will be the same as the
 			 * last restored line.
 			 */
-			assert(!strcmp(new_first_line.text, split_first_line.text) ||
-			       !strcmp(new_first_line.text, restored_last_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_first_line.text, split_first_line.text) &&
+					strcmp(new_first_line.text, restored_last_line.text),
+					"Split result invalid", page1, page2));
 		} else {
 			/* The vmas should be consistent with merge results */
-			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
-			       !strcmp(new_first_line.text, restored_first_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_last_line.text, restored_last_line.text),
+					"Merge result invalid", page1, page2));
+			assert(!print_boundaries_on(
+					strcmp(new_first_line.text, restored_first_line.text),
+					"Merge result invalid", page1, page2));
 		}
 		/*
 		 * First and last lines should change in unison. If the last
@@ -362,7 +470,9 @@ static void test_maps_tearing_from_split(int maps_fd,
 			vma_end == split_first_line.end_addr));
 
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+		end_test_iteration(&end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+	end_test_loop();
 
 	/* Signal the modifyer thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
@@ -409,6 +519,7 @@ static void test_maps_tearing_from_resize(int maps_fd,
 	mod_info->vma_restore = expand_vma;
 	mod_info->vma_mod_check = check_shrink_result;
 
+	report_test_start("Tearing from resize");
 	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
 			    &shrunk_last_line, &shrunk_first_line,
 			    &restored_last_line, &restored_first_line);
@@ -421,6 +532,7 @@ static void test_maps_tearing_from_resize(int maps_fd,
 	struct timespec start_ts, end_ts;
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	start_test_loop(&start_ts);
 	do {
 		unsigned long vma_start;
 		unsigned long vma_end;
@@ -437,12 +549,18 @@ static void test_maps_tearing_from_resize(int maps_fd,
 			 * again. In that case new first line will be the same
 			 * as the last restored line.
 			 */
-			assert(!strcmp(new_first_line.text, shrunk_first_line.text) ||
-			       !strcmp(new_first_line.text, restored_last_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_first_line.text, shrunk_first_line.text) &&
+					strcmp(new_first_line.text, restored_last_line.text),
+					"Shrink result invalid", page1, page2));
 		} else {
 			/* The vmas should be consistent with the original/resored state */
-			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
-			       !strcmp(new_first_line.text, restored_first_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_last_line.text, restored_last_line.text),
+					"Expand result invalid", page1, page2));
+			assert(!print_boundaries_on(
+					strcmp(new_first_line.text, restored_first_line.text),
+					"Expand result invalid", page1, page2));
 		}
 
 		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
@@ -456,7 +574,9 @@ static void test_maps_tearing_from_resize(int maps_fd,
 			vma_end - vma_start == page_size));
 
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+		end_test_iteration(&end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+	end_test_loop();
 
 	/* Signal the modifyer thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
@@ -512,6 +632,7 @@ static void test_maps_tearing_from_remap(int maps_fd,
 	mod_info->vma_restore = patch_vma;
 	mod_info->vma_mod_check = check_remap_result;
 
+	report_test_start("Tearing from remap");
 	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
 			    &remapped_last_line, &remapped_first_line,
 			    &restored_last_line, &restored_first_line);
@@ -524,6 +645,7 @@ static void test_maps_tearing_from_remap(int maps_fd,
 	struct timespec start_ts, end_ts;
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	start_test_loop(&start_ts);
 	do {
 		unsigned long vma_start;
 		unsigned long vma_end;
@@ -540,12 +662,18 @@ static void test_maps_tearing_from_remap(int maps_fd,
 			 * again. In that case new first line will be the same
 			 * as the last restored line.
 			 */
-			assert(!strcmp(new_first_line.text, remapped_first_line.text) ||
-			       !strcmp(new_first_line.text, restored_last_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_first_line.text, remapped_first_line.text) &&
+					strcmp(new_first_line.text, restored_last_line.text),
+					"Remap result invalid", page1, page2));
 		} else {
 			/* The vmas should be consistent with the original/resored state */
-			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
-			       !strcmp(new_first_line.text, restored_first_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_last_line.text, restored_last_line.text),
+					"Remap restore result invalid", page1, page2));
+			assert(!print_boundaries_on(
+					strcmp(new_first_line.text, restored_first_line.text),
+					"Remap restore result invalid", page1, page2));
 		}
 
 		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
@@ -561,7 +689,9 @@ static void test_maps_tearing_from_remap(int maps_fd,
 			vma_end - vma_start == page_size));
 
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+		end_test_iteration(&end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+	end_test_loop();
 
 	/* Signal the modifyer thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
@@ -571,6 +701,7 @@ int usage(void)
 {
 	fprintf(stderr, "Userland /proc/pid/{s}maps race test cases\n");
 	fprintf(stderr, "  -d: Duration for time-consuming tests\n");
+	fprintf(stderr, "  -v: Verbose mode\n");
 	fprintf(stderr, "  -h: Help screen\n");
 	exit(-1);
 }
@@ -588,9 +719,11 @@ int main(int argc, char **argv)
 	pid_t pid;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "d:h")) != -1) {
+	while ((opt = getopt(argc, argv, "d:vh")) != -1) {
 		if (opt == 'd')
 			test_duration_sec = strtoul(optarg, NULL, 0);
+		else if (opt == 'v')
+			verbose = true;
 		else if (opt == 'h')
 			usage();
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog


