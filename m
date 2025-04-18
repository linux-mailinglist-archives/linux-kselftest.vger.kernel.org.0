Return-Path: <linux-kselftest+bounces-31165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F7A93C3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E985177AD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42321D3EF;
	Fri, 18 Apr 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kqc3qt20"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109821CA16
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998608; cv=none; b=LmzwA27z6Zedz83h8UBid26nLk6tDQMXEzpxUCoxKEIdyCT93qM914klTNriay2aMq2HR7rjEsezpLyMllswVIo7g8XL9VvW93Fz1rGhObxSjNadzzOqpH3nxFgaHyooElLhGbbLVlp34ssT2ZuA6+oZzpA2LVS03Cs4rj8HHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998608; c=relaxed/simple;
	bh=D5KVUKAoJwS0XGSathwFmHbGtyOBmVYW2dpOpzCywz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BXfjzm2lJMJvICXwix2DZ+sQP/U1+EXtTn6SVO3v4RvttXzpqyygd8bfHjkIuKfc0Lsuu2v7/GiQGS76nUczWT3T4+CoJE/UVExU6kjfg5EF4eyHQItRXgoxR3EJW6WuYDer9+CsDkER3C/ZPJk4w/z8kOJ0QyVsP8d2HCiHO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kqc3qt20; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so1457115a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744998606; x=1745603406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgDRBr7EHzoWVxJpYPL/4eCyatCNp0mNaqALeY1G7/4=;
        b=Kqc3qt20lL/CU4/+HXo/ml5kHVhJF1HegPx0f/2aHqeqxUFoF4S/IfJ9GC1pd2nF4k
         tTkErM39YAHapTZ9k/kGJ1HMsR7lNKllLHL+hEJIrDSTjBhgC/ElM7zAD3EWJ3YfpBra
         97skXNe76tBFeZn/y5qIfqIfPRf9xlcDfOkNKwNFEp5vOVm3XgNpzMn/p9KEHILlL8CC
         DTHYpzYgQoB6RWThOXxfH+ih98oTPnM4tM5p0iIp9eFYjC3F5NP7WXJs0ieB6hrFfNEO
         tl4jCs2MEW/copOMksNubOvIBi8wXYvh9UwzfKJl4wLCZ+T36jaVRgwRTivbDNo1h/n9
         NBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998606; x=1745603406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgDRBr7EHzoWVxJpYPL/4eCyatCNp0mNaqALeY1G7/4=;
        b=HNFQr2gh3+j1y4CfDYv3GHS8dhk5AAVgtWH5Ej4oBZEKP+Dd8fqkPolVHkdJ9hDAi8
         IqRY4h9JWSY/tpwEDWEhCQWDilWTAHZCEdrn8sWJVxbT0Yr3JuR2SpU+hhu6Cg0mm+bj
         YinJBBWYFTU3oalDBPTmnA/nDlCRyd9vWnrhEbLbRqvJMzGfVZTqo6SUVyYu1V6szUlf
         jTNIG1JJHtWODDdU3ZWu6ZbhD4DPZ6jx+Fx46ath8U6Cec9EqAhLZkUIzOTtUE1PUbyL
         4jY3/BpqQaeVvdtW9lQHXI8JLeRwb9CRGjpol4Kho/rYL9SAWBmBfi9CwtmC9zqbwwdE
         YobQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/WG/jP/FM6xoBwarvgjOAcsupBA0QWrgoShIyp39Fgx3vobapn0EOeGhulYz955M92pR4ukehTCTGfPE/Uv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01gIeYOuguDFCRq9UkNp6HclLBKvdNXXdJYVa4i9yE/VM1jlc
	UC+cIJMobtVcmhXD/rnhkm6whlTw6/rNdGelqBQAO/T4ZDD55dd/kN3w6JLGqrUES7bTyzmaHxF
	OLg==
X-Google-Smtp-Source: AGHT+IHcSsp6fTq+P5mdogx2xA//Oy5g0EOLyOHv8vpLXb30G0tARWpAdcWwAIgGOvySdxYbnBMETRGuhIU=
X-Received: from pjbnb11.prod.google.com ([2002:a17:90b:35cb:b0:2fc:201d:6026])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b90:b0:2fe:80cb:ac05
 with SMTP id 98e67ed59e1d1-3087bb48d7bmr5606678a91.9.1744998605831; Fri, 18
 Apr 2025 10:50:05 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:49:52 -0700
In-Reply-To: <20250418174959.1431962-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418174959.1431962-2-surenb@google.com>
Subject: [PATCH v3 1/8] selftests/proc: add /proc/pid/maps tearing from vma
 split test
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

The content of /proc/pid/maps is generated page-by-page with mmap_lock
read lock (or other synchronization mechanism) being dropped in between
these pages. This means that the reader can occasionally retrieve
inconsistent information if the data used for file generation is being
concurrently changed. For /proc/pid/maps that means it's possible to
read inconsistent data if vmas or vma tree are concurrently modified.
A simple example is when a vma gets split or merged. If such action
happens while /proc/pid/maps is read and this vma happens to be at the
edge of the two pages being generated, the readers can see the same vma
twice: once before it got modified and second time after the modification.
This is considered acceptable if the same vma is seen twice and userspace
can deal with this situation. What is unacceptable is if we see a hole in
the place occupied by a vma, for example as a result of a vma being
replaced with another one, leaving the space temporarily empty.
Implement a test that reads /proc/pid/maps of a forked child process and
checks data consistency at the edge of two pages. Child process constantly
modifies its address space in a way that affects the vma located at the
end of the first page when /proc/pid/maps is read by the parent process.
The parent checks the last vma of the first page and the first vma of the
last page for consistency with the split/merge results.
Since the test is designed to create a race between the file reader and
vma tree modifier, we need multiple iterations to catch invalid results.
To limit the time test is run, introduce a command line parameter
specifying the duration of the test in seconds. For example, the following
command will allow this concurrency test to run for 10 seconds:

proc-pid-vm -d 10

The default test duration is set to 5 seconds.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 430 ++++++++++++++++++++-
 1 file changed, 429 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index d04685771952..6e3f06376a1f 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -27,6 +27,7 @@
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdbool.h>
@@ -34,6 +35,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -70,6 +72,8 @@ static void make_private_tmp(void)
 	}
 }
 
+static unsigned long test_duration_sec = 5UL;
+static int page_size;
 static pid_t pid = -1;
 static void ate(void)
 {
@@ -281,11 +285,431 @@ static void vsyscall(void)
 	}
 }
 
-int main(void)
+/* /proc/pid/maps parsing routines */
+struct page_content {
+	char *data;
+	ssize_t size;
+};
+
+#define LINE_MAX_SIZE		256
+
+struct line_content {
+	char text[LINE_MAX_SIZE];
+	unsigned long start_addr;
+	unsigned long end_addr;
+};
+
+static void read_two_pages(int maps_fd, struct page_content *page1,
+			   struct page_content *page2)
+{
+	ssize_t  bytes_read;
+
+	assert(lseek(maps_fd, 0, SEEK_SET) >= 0);
+	bytes_read = read(maps_fd, page1->data, page_size);
+	assert(bytes_read > 0 && bytes_read < page_size);
+	page1->size = bytes_read;
+
+	bytes_read = read(maps_fd, page2->data, page_size);
+	assert(bytes_read > 0 && bytes_read < page_size);
+	page2->size = bytes_read;
+}
+
+static void copy_first_line(struct page_content *page, char *first_line)
+{
+	char *pos = strchr(page->data, '\n');
+
+	strncpy(first_line, page->data, pos - page->data);
+	first_line[pos - page->data] = '\0';
+}
+
+static void copy_last_line(struct page_content *page, char *last_line)
+{
+	/* Get the last line in the first page */
+	const char *end = page->data + page->size - 1;
+	/* skip last newline */
+	const char *pos = end - 1;
+
+	/* search previous newline */
+	while (pos[-1] != '\n')
+		pos--;
+	strncpy(last_line, pos, end - pos);
+	last_line[end - pos] = '\0';
+}
+
+/* Read the last line of the first page and the first line of the second page */
+static void read_boundary_lines(int maps_fd, struct page_content *page1,
+				struct page_content *page2,
+				struct line_content *last_line,
+				struct line_content *first_line)
+{
+	read_two_pages(maps_fd, page1, page2);
+
+	copy_last_line(page1, last_line->text);
+	copy_first_line(page2, first_line->text);
+
+	assert(sscanf(last_line->text, "%lx-%lx", &last_line->start_addr,
+		      &last_line->end_addr) == 2);
+	assert(sscanf(first_line->text, "%lx-%lx", &first_line->start_addr,
+		      &first_line->end_addr) == 2);
+}
+
+/* Thread synchronization routines */
+enum test_state {
+	INIT,
+	CHILD_READY,
+	PARENT_READY,
+	SETUP_READY,
+	SETUP_MODIFY_MAPS,
+	SETUP_MAPS_MODIFIED,
+	SETUP_RESTORE_MAPS,
+	SETUP_MAPS_RESTORED,
+	TEST_READY,
+	TEST_DONE,
+};
+
+struct vma_modifier_info;
+
+typedef void (*vma_modifier_op)(const struct vma_modifier_info *mod_info);
+typedef void (*vma_mod_result_check_op)(struct line_content *mod_last_line,
+					struct line_content *mod_first_line,
+					struct line_content *restored_last_line,
+					struct line_content *restored_first_line);
+
+struct vma_modifier_info {
+	int vma_count;
+	void *addr;
+	int prot;
+	void *next_addr;
+	vma_modifier_op vma_modify;
+	vma_modifier_op vma_restore;
+	vma_mod_result_check_op vma_mod_check;
+	pthread_mutex_t sync_lock;
+	pthread_cond_t sync_cond;
+	enum test_state curr_state;
+	bool exit;
+	void *child_mapped_addr[];
+};
+
+static void wait_for_state(struct vma_modifier_info *mod_info, enum test_state state)
+{
+	pthread_mutex_lock(&mod_info->sync_lock);
+	while (mod_info->curr_state != state)
+		pthread_cond_wait(&mod_info->sync_cond, &mod_info->sync_lock);
+	pthread_mutex_unlock(&mod_info->sync_lock);
+}
+
+static void signal_state(struct vma_modifier_info *mod_info, enum test_state state)
+{
+	pthread_mutex_lock(&mod_info->sync_lock);
+	mod_info->curr_state = state;
+	pthread_cond_signal(&mod_info->sync_cond);
+	pthread_mutex_unlock(&mod_info->sync_lock);
+}
+
+/* VMA modification routines */
+static void *child_vma_modifier(struct vma_modifier_info *mod_info)
+{
+	int prot = PROT_READ | PROT_WRITE;
+	int i;
+
+	for (i = 0; i < mod_info->vma_count; i++) {
+		mod_info->child_mapped_addr[i] = mmap(NULL, page_size * 3, prot,
+				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		assert(mod_info->child_mapped_addr[i] != MAP_FAILED);
+		/* change protection in adjacent maps to prevent merging */
+		prot ^= PROT_WRITE;
+	}
+	signal_state(mod_info, CHILD_READY);
+	wait_for_state(mod_info, PARENT_READY);
+	while (true) {
+		signal_state(mod_info, SETUP_READY);
+		wait_for_state(mod_info, SETUP_MODIFY_MAPS);
+		if (mod_info->exit)
+			break;
+
+		mod_info->vma_modify(mod_info);
+		signal_state(mod_info, SETUP_MAPS_MODIFIED);
+		wait_for_state(mod_info, SETUP_RESTORE_MAPS);
+		mod_info->vma_restore(mod_info);
+		signal_state(mod_info, SETUP_MAPS_RESTORED);
+
+		wait_for_state(mod_info, TEST_READY);
+		while (mod_info->curr_state != TEST_DONE) {
+			mod_info->vma_modify(mod_info);
+			mod_info->vma_restore(mod_info);
+		}
+	}
+	for (i = 0; i < mod_info->vma_count; i++)
+		munmap(mod_info->child_mapped_addr[i], page_size * 3);
+
+	return NULL;
+}
+
+static void stop_vma_modifier(struct vma_modifier_info *mod_info)
+{
+	wait_for_state(mod_info, SETUP_READY);
+	mod_info->exit = true;
+	signal_state(mod_info, SETUP_MODIFY_MAPS);
+}
+
+static void capture_mod_pattern(int maps_fd,
+				struct vma_modifier_info *mod_info,
+				struct page_content *page1,
+				struct page_content *page2,
+				struct line_content *last_line,
+				struct line_content *first_line,
+				struct line_content *mod_last_line,
+				struct line_content *mod_first_line,
+				struct line_content *restored_last_line,
+				struct line_content *restored_first_line)
+{
+	signal_state(mod_info, SETUP_MODIFY_MAPS);
+	wait_for_state(mod_info, SETUP_MAPS_MODIFIED);
+
+	/* Copy last line of the first page and first line of the last page */
+	read_boundary_lines(maps_fd, page1, page2, mod_last_line, mod_first_line);
+
+	signal_state(mod_info, SETUP_RESTORE_MAPS);
+	wait_for_state(mod_info, SETUP_MAPS_RESTORED);
+
+	/* Copy last line of the first page and first line of the last page */
+	read_boundary_lines(maps_fd, page1, page2, restored_last_line, restored_first_line);
+
+	mod_info->vma_mod_check(mod_last_line, mod_first_line,
+				restored_last_line, restored_first_line);
+
+	/*
+	 * The content of these lines after modify+resore should be the same
+	 * as the original.
+	 */
+	assert(strcmp(restored_last_line->text, last_line->text) == 0);
+	assert(strcmp(restored_first_line->text, first_line->text) == 0);
+}
+
+static inline void split_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(mmap(mod_info->addr, page_size, mod_info->prot | PROT_EXEC,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
+		    -1, 0) != MAP_FAILED);
+}
+
+static inline void merge_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(mmap(mod_info->addr, page_size, mod_info->prot,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
+		    -1, 0) != MAP_FAILED);
+}
+
+static inline void check_split_result(struct line_content *mod_last_line,
+				      struct line_content *mod_first_line,
+				      struct line_content *restored_last_line,
+				      struct line_content *restored_first_line)
+{
+	/* Make sure vmas at the boundaries are changing */
+	assert(strcmp(mod_last_line->text, restored_last_line->text) != 0);
+	assert(strcmp(mod_first_line->text, restored_first_line->text) != 0);
+}
+
+static void test_maps_tearing_from_split(int maps_fd,
+					 struct vma_modifier_info *mod_info,
+					 struct page_content *page1,
+					 struct page_content *page2,
+					 struct line_content *last_line,
+					 struct line_content *first_line)
+{
+	struct line_content split_last_line;
+	struct line_content split_first_line;
+	struct line_content restored_last_line;
+	struct line_content restored_first_line;
+
+	wait_for_state(mod_info, SETUP_READY);
+
+	/* re-read the file to avoid using stale data from previous test */
+	read_boundary_lines(maps_fd, page1, page2, last_line, first_line);
+
+	mod_info->vma_modify = split_vma;
+	mod_info->vma_restore = merge_vma;
+	mod_info->vma_mod_check = check_split_result;
+
+	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
+			    &split_last_line, &split_first_line,
+			    &restored_last_line, &restored_first_line);
+
+	/* Now start concurrent modifications for test_duration_sec */
+	signal_state(mod_info, TEST_READY);
+
+	struct line_content new_last_line;
+	struct line_content new_first_line;
+	struct timespec start_ts, end_ts;
+
+	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	do {
+		bool last_line_changed;
+		bool first_line_changed;
+
+		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
+
+		/* Check if we read vmas after split */
+		if (!strcmp(new_last_line.text, split_last_line.text)) {
+			/*
+			 * The vmas should be consistent with split results,
+			 * however if vma was concurrently restored after a
+			 * split, it can be reported twice (first the original
+			 * split one, then the same vma but extended after the
+			 * merge) because we found it as the next vma again.
+			 * In that case new first line will be the same as the
+			 * last restored line.
+			 */
+			assert(!strcmp(new_first_line.text, split_first_line.text) ||
+			       !strcmp(new_first_line.text, restored_last_line.text));
+		} else {
+			/* The vmas should be consistent with merge results */
+			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
+			       !strcmp(new_first_line.text, restored_first_line.text));
+		}
+		/*
+		 * First and last lines should change in unison. If the last
+		 * line changed then the first line should change as well and
+		 * vice versa.
+		 */
+		last_line_changed = strcmp(new_last_line.text, last_line->text) != 0;
+		first_line_changed = strcmp(new_first_line.text, first_line->text) != 0;
+		assert(last_line_changed == first_line_changed);
+
+		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+
+	/* Signal the modifyer thread to stop and wait until it exits */
+	signal_state(mod_info, TEST_DONE);
+}
+
+static int test_maps_tearing(void)
+{
+	struct vma_modifier_info *mod_info;
+	pthread_mutexattr_t mutex_attr;
+	pthread_condattr_t cond_attr;
+	int shared_mem_size;
+	char fname[32];
+	int vma_count;
+	int maps_fd;
+	int status;
+	pid_t pid;
+
+	/*
+	 * Have to map enough vmas for /proc/pid/maps to containt more than one
+	 * page worth of vmas. Assume at least 32 bytes per line in maps output
+	 */
+	vma_count = page_size / 32 + 1;
+	shared_mem_size = sizeof(struct vma_modifier_info) + vma_count * sizeof(void *);
+
+	/* map shared memory for communication with the child process */
+	mod_info = (struct vma_modifier_info *)mmap(NULL, shared_mem_size,
+		    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	assert(mod_info != MAP_FAILED);
+
+	/* Initialize shared members */
+	pthread_mutexattr_init(&mutex_attr);
+	pthread_mutexattr_setpshared(&mutex_attr, PTHREAD_PROCESS_SHARED);
+	assert(!pthread_mutex_init(&mod_info->sync_lock, &mutex_attr));
+	pthread_condattr_init(&cond_attr);
+	pthread_condattr_setpshared(&cond_attr, PTHREAD_PROCESS_SHARED);
+	assert(!pthread_cond_init(&mod_info->sync_cond, &cond_attr));
+	mod_info->vma_count = vma_count;
+	mod_info->curr_state = INIT;
+	mod_info->exit = false;
+
+	pid = fork();
+	if (!pid) {
+		/* Child process */
+		child_vma_modifier(mod_info);
+		return 0;
+	}
+
+	sprintf(fname, "/proc/%d/maps", pid);
+	maps_fd = open(fname, O_RDONLY);
+	assert(maps_fd != -1);
+
+	/* Wait for the child to map the VMAs */
+	wait_for_state(mod_info, CHILD_READY);
+
+	/* Read first two pages */
+	struct page_content page1;
+	struct page_content page2;
+
+	page1.data = malloc(page_size);
+	assert(page1.data);
+	page2.data = malloc(page_size);
+	assert(page2.data);
+
+	struct line_content last_line;
+	struct line_content first_line;
+
+	read_boundary_lines(maps_fd, &page1, &page2, &last_line, &first_line);
+
+	/*
+	 * Find the addresses corresponding to the last line in the first page
+	 * and the first line in the last page.
+	 */
+	mod_info->addr = NULL;
+	mod_info->next_addr = NULL;
+	for (int i = 0; i < mod_info->vma_count; i++) {
+		if (mod_info->child_mapped_addr[i] == (void *)last_line.start_addr) {
+			mod_info->addr = mod_info->child_mapped_addr[i];
+			mod_info->prot = PROT_READ;
+			/* Even VMAs have write permission */
+			if ((i % 2) == 0)
+				mod_info->prot |= PROT_WRITE;
+		} else if (mod_info->child_mapped_addr[i] == (void *)first_line.start_addr) {
+			mod_info->next_addr = mod_info->child_mapped_addr[i];
+		}
+
+		if (mod_info->addr && mod_info->next_addr)
+			break;
+	}
+	assert(mod_info->addr && mod_info->next_addr);
+
+	signal_state(mod_info, PARENT_READY);
+
+	test_maps_tearing_from_split(maps_fd, mod_info, &page1, &page2,
+				     &last_line, &first_line);
+
+	stop_vma_modifier(mod_info);
+
+	free(page2.data);
+	free(page1.data);
+
+	for (int i = 0; i < vma_count; i++)
+		munmap(mod_info->child_mapped_addr[i], page_size);
+	close(maps_fd);
+	waitpid(pid, &status, 0);
+	munmap(mod_info, shared_mem_size);
+
+	return 0;
+}
+
+int usage(void)
+{
+	fprintf(stderr, "Userland /proc/pid/{s}maps test cases\n");
+	fprintf(stderr, "  -d: Duration for time-consuming tests\n");
+	fprintf(stderr, "  -h: Help screen\n");
+	exit(-1);
+}
+
+int main(int argc, char **argv)
 {
 	int pipefd[2];
 	int exec_fd;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "d:h")) != -1) {
+		if (opt == 'd')
+			test_duration_sec = strtoul(optarg, NULL, 0);
+		else if (opt == 'h')
+			usage();
+	}
 
+	page_size = sysconf(_SC_PAGESIZE);
 	vsyscall();
 	switch (g_vsyscall) {
 	case 0:
@@ -578,6 +1002,10 @@ int main(void)
 		assert(err == -ENOENT);
 	}
 
+	/* Test tearing in /proc/$PID/maps */
+	if (test_maps_tearing())
+		return 1;
+
 	return 0;
 }
 #else
-- 
2.49.0.805.g082f7c87e0-goog


