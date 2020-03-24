Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1E019152C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgCXPmX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 11:42:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39898 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgCXPmW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 11:42:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id a9so4013872wmj.4;
        Tue, 24 Mar 2020 08:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4JldSzOOAQ1uFnO6uNHLIic9Y166PHtnRU+95Y+VD6I=;
        b=VA/9CaDWh/owfBDM+vucc2QmCMzr2aWIqK43HWGv1P8yMeoM3fzBR4lCGY45zqzyau
         BN3N5m9E8uuEzH4Y57h2Xkr2RMXoColDbQbQY83DdxcAbaobQpXipWkRdn6Hk8UukfjJ
         bPWyr4XZBUUW6XwX/o4MG7DzKtDqK4kYPeMsWjEqJreIQTHHjr1cxt+aO0bKOzjkWpGv
         UC0HmQGe2nYIYFL7ydGZHLBjfQdznoq8vP0GNiZmrQh6ST4+BqxQ8ynMlow1kkz/XCXP
         hsZforWuQ2tHKRM9QBjFkExfai6rmwnZU0RLKLL1jgFVeKSVSN7ZhalYP5GM3TPCQi/c
         FMXA==
X-Gm-Message-State: ANhLgQ2RUQz/7Ac76WziGINyxtS0UpnJ3Jy6jB40nv8qd6cy3NCChQmf
        YukLMxQ4HEMF3JbgVJxD0575JkLR
X-Google-Smtp-Source: ADFU+vvy8S8JrfAc5+9m22UHbkoUxAKyyp1YJFXtqfnz9F3n7tKmxiJwPzxxuz3hgBYXuVPXR9FnAg==
X-Received: by 2002:a05:600c:2050:: with SMTP id p16mr4480502wmg.23.1585064540625;
        Tue, 24 Mar 2020 08:42:20 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id w3sm23833673wrn.31.2020.03.24.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 08:42:19 -0700 (PDT)
Date:   Tue, 24 Mar 2020 16:42:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Eric B Munson <emunson@akamai.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200324154218.GS19542@dhcp22.suse.cz>
References: <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
 <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
 <20200323075208.GC7524@dhcp22.suse.cz>
 <20200323144240.GB23364@optiplex-lnx>
 <20200323145106.GM7524@dhcp22.suse.cz>
 <20200323150259.GD23364@optiplex-lnx>
 <20200323151256.GP7524@dhcp22.suse.cz>
 <20200323154159.GF23364@optiplex-lnx>
 <20200323155111.GQ7524@dhcp22.suse.cz>
 <20200323155449.GG23364@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323155449.GG23364@optiplex-lnx>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[Cc Eric - the email thread starts http://lkml.kernel.org/r/20200322013525.1095493-1-aquini@redhat.com]

On Mon 23-03-20 11:54:49, Rafael Aquini wrote:
[...]
> I'm OK with it, if you want to go ahead and do the kill.

See the patch below

From 07c08f387d036c70239d4060ffd30534cf77a0a5 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Mon, 23 Mar 2020 17:33:46 +0100
Subject: [PATCH] selftests: vm: drop dependencies on page flags from mlock2
 tests

It was noticed that mlock2 tests are failing after 9c4e6b1a7027f
("mm, mlock, vmscan: no more skipping pagevecs") because the patch has
changed the timing on when the page is added to the unevictable LRU list
and thus gains the unevictable page flag.

The test was just too dependent on the implementation details which were
true at the time when it was introduced. Page flags and the timing when
they are set is something no userspace should ever depend on. The test
should be testing only for the user observable contract of the tested
syscalls. Those are defined pretty well for the mlock and there are
other means for testing them. In fact this is already done and testing
for page flags can be safely dropped to achieve the aimed purpose.
Present bits can be checked by /proc/<pid>/smaps RSS field and the
locking state by VmFlags although I would argue that Locked: field would
be more appropriate.

Drop all the page flag machinery and considerably simplify the test.
This should be more robust for future kernel changes while checking the
promised contract is still valid.

Reported-by: Rafael Aquini <aquini@redhat.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 tools/testing/selftests/vm/mlock2-tests.c | 233 ++++------------------
 1 file changed, 37 insertions(+), 196 deletions(-)

diff --git a/tools/testing/selftests/vm/mlock2-tests.c b/tools/testing/selftests/vm/mlock2-tests.c
index 637b6d0ac0d0..11b2301f3aa3 100644
--- a/tools/testing/selftests/vm/mlock2-tests.c
+++ b/tools/testing/selftests/vm/mlock2-tests.c
@@ -67,59 +67,6 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
 	return ret;
 }
 
-static uint64_t get_pageflags(unsigned long addr)
-{
-	FILE *file;
-	uint64_t pfn;
-	unsigned long offset;
-
-	file = fopen("/proc/self/pagemap", "r");
-	if (!file) {
-		perror("fopen pagemap");
-		_exit(1);
-	}
-
-	offset = addr / getpagesize() * sizeof(pfn);
-
-	if (fseek(file, offset, SEEK_SET)) {
-		perror("fseek pagemap");
-		_exit(1);
-	}
-
-	if (fread(&pfn, sizeof(pfn), 1, file) != 1) {
-		perror("fread pagemap");
-		_exit(1);
-	}
-
-	fclose(file);
-	return pfn;
-}
-
-static uint64_t get_kpageflags(unsigned long pfn)
-{
-	uint64_t flags;
-	FILE *file;
-
-	file = fopen("/proc/kpageflags", "r");
-	if (!file) {
-		perror("fopen kpageflags");
-		_exit(1);
-	}
-
-	if (fseek(file, pfn * sizeof(flags), SEEK_SET)) {
-		perror("fseek kpageflags");
-		_exit(1);
-	}
-
-	if (fread(&flags, sizeof(flags), 1, file) != 1) {
-		perror("fread kpageflags");
-		_exit(1);
-	}
-
-	fclose(file);
-	return flags;
-}
-
 #define VMFLAGS "VmFlags:"
 
 static bool is_vmflag_set(unsigned long addr, const char *vmflag)
@@ -159,19 +106,13 @@ static bool is_vmflag_set(unsigned long addr, const char *vmflag)
 #define RSS  "Rss:"
 #define LOCKED "lo"
 
-static bool is_vma_lock_on_fault(unsigned long addr)
+static unsigned long get_value_for_name(unsigned long addr, const char *name)
 {
-	bool ret = false;
-	bool locked;
-	FILE *smaps = NULL;
-	unsigned long vma_size, vma_rss;
 	char *line = NULL;
-	char *value;
 	size_t size = 0;
-
-	locked = is_vmflag_set(addr, LOCKED);
-	if (!locked)
-		goto out;
+	char *value_ptr;
+	FILE *smaps = NULL;
+	unsigned long value = -1UL;
 
 	smaps = seek_to_smaps_entry(addr);
 	if (!smaps) {
@@ -180,112 +121,70 @@ static bool is_vma_lock_on_fault(unsigned long addr)
 	}
 
 	while (getline(&line, &size, smaps) > 0) {
-		if (!strstr(line, SIZE)) {
+		if (!strstr(line, name)) {
 			free(line);
 			line = NULL;
 			size = 0;
 			continue;
 		}
 
-		value = line + strlen(SIZE);
-		if (sscanf(value, "%lu kB", &vma_size) < 1) {
+		value_ptr = line + strlen(name);
+		if (sscanf(value_ptr, "%lu kB", &value) < 1) {
 			printf("Unable to parse smaps entry for Size\n");
 			goto out;
 		}
 		break;
 	}
 
-	while (getline(&line, &size, smaps) > 0) {
-		if (!strstr(line, RSS)) {
-			free(line);
-			line = NULL;
-			size = 0;
-			continue;
-		}
-
-		value = line + strlen(RSS);
-		if (sscanf(value, "%lu kB", &vma_rss) < 1) {
-			printf("Unable to parse smaps entry for Rss\n");
-			goto out;
-		}
-		break;
-	}
-
-	ret = locked && (vma_rss < vma_size);
 out:
-	free(line);
 	if (smaps)
 		fclose(smaps);
-	return ret;
+	free(line);
+	return value;
 }
 
-#define PRESENT_BIT     0x8000000000000000ULL
-#define PFN_MASK        0x007FFFFFFFFFFFFFULL
-#define UNEVICTABLE_BIT (1UL << 18)
-
-static int lock_check(char *map)
+static bool is_vma_lock_on_fault(unsigned long addr)
 {
-	unsigned long page_size = getpagesize();
-	uint64_t page1_flags, page2_flags;
+	bool locked;
+	unsigned long vma_size, vma_rss;
 
-	page1_flags = get_pageflags((unsigned long)map);
-	page2_flags = get_pageflags((unsigned long)map + page_size);
+	locked = is_vmflag_set(addr, LOCKED);
+	if (!locked)
+		return false;
 
-	/* Both pages should be present */
-	if (((page1_flags & PRESENT_BIT) == 0) ||
-	    ((page2_flags & PRESENT_BIT) == 0)) {
-		printf("Failed to make both pages present\n");
-		return 1;
-	}
+	vma_size = get_value_for_name(addr, SIZE);
+	vma_rss = get_value_for_name(addr, RSS);
 
-	page1_flags = get_kpageflags(page1_flags & PFN_MASK);
-	page2_flags = get_kpageflags(page2_flags & PFN_MASK);
+	/* only one page is faulted in */
+	return (vma_rss < vma_size);
+}
 
-	/* Both pages should be unevictable */
-	if (((page1_flags & UNEVICTABLE_BIT) == 0) ||
-	    ((page2_flags & UNEVICTABLE_BIT) == 0)) {
-		printf("Failed to make both pages unevictable\n");
-		return 1;
-	}
+#define PRESENT_BIT     0x8000000000000000ULL
+#define PFN_MASK        0x007FFFFFFFFFFFFFULL
+#define UNEVICTABLE_BIT (1UL << 18)
 
-	if (!is_vmflag_set((unsigned long)map, LOCKED)) {
-		printf("VMA flag %s is missing on page 1\n", LOCKED);
-		return 1;
-	}
+static int lock_check(unsigned long addr)
+{
+	bool locked;
+	unsigned long vma_size, vma_rss;
 
-	if (!is_vmflag_set((unsigned long)map + page_size, LOCKED)) {
-		printf("VMA flag %s is missing on page 2\n", LOCKED);
-		return 1;
-	}
+	locked = is_vmflag_set(addr, LOCKED);
+	if (!locked)
+		return false;
 
-	return 0;
+	vma_size = get_value_for_name(addr, SIZE);
+	vma_rss = get_value_for_name(addr, RSS);
+
+	return (vma_rss == vma_size);
 }
 
 static int unlock_lock_check(char *map)
 {
-	unsigned long page_size = getpagesize();
-	uint64_t page1_flags, page2_flags;
-
-	page1_flags = get_pageflags((unsigned long)map);
-	page2_flags = get_pageflags((unsigned long)map + page_size);
-	page1_flags = get_kpageflags(page1_flags & PFN_MASK);
-	page2_flags = get_kpageflags(page2_flags & PFN_MASK);
-
-	if ((page1_flags & UNEVICTABLE_BIT) || (page2_flags & UNEVICTABLE_BIT)) {
-		printf("A page is still marked unevictable after unlock\n");
-		return 1;
-	}
-
 	if (is_vmflag_set((unsigned long)map, LOCKED)) {
 		printf("VMA flag %s is present on page 1 after unlock\n", LOCKED);
 		return 1;
 	}
 
-	if (is_vmflag_set((unsigned long)map + page_size, LOCKED)) {
-		printf("VMA flag %s is present on page 2 after unlock\n", LOCKED);
-		return 1;
-	}
-
 	return 0;
 }
 
@@ -311,7 +210,7 @@ static int test_mlock_lock()
 		goto unmap;
 	}
 
-	if (lock_check(map))
+	if (!lock_check((unsigned long)map))
 		goto unmap;
 
 	/* Now unlock and recheck attributes */
@@ -330,64 +229,18 @@ static int test_mlock_lock()
 
 static int onfault_check(char *map)
 {
-	unsigned long page_size = getpagesize();
-	uint64_t page1_flags, page2_flags;
-
-	page1_flags = get_pageflags((unsigned long)map);
-	page2_flags = get_pageflags((unsigned long)map + page_size);
-
-	/* Neither page should be present */
-	if ((page1_flags & PRESENT_BIT) || (page2_flags & PRESENT_BIT)) {
-		printf("Pages were made present by MLOCK_ONFAULT\n");
-		return 1;
-	}
-
 	*map = 'a';
-	page1_flags = get_pageflags((unsigned long)map);
-	page2_flags = get_pageflags((unsigned long)map + page_size);
-
-	/* Only page 1 should be present */
-	if ((page1_flags & PRESENT_BIT) == 0) {
-		printf("Page 1 is not present after fault\n");
-		return 1;
-	} else if (page2_flags & PRESENT_BIT) {
-		printf("Page 2 was made present\n");
-		return 1;
-	}
-
-	page1_flags = get_kpageflags(page1_flags & PFN_MASK);
-
-	/* Page 1 should be unevictable */
-	if ((page1_flags & UNEVICTABLE_BIT) == 0) {
-		printf("Failed to make faulted page unevictable\n");
-		return 1;
-	}
-
 	if (!is_vma_lock_on_fault((unsigned long)map)) {
 		printf("VMA is not marked for lock on fault\n");
 		return 1;
 	}
 
-	if (!is_vma_lock_on_fault((unsigned long)map + page_size)) {
-		printf("VMA is not marked for lock on fault\n");
-		return 1;
-	}
-
 	return 0;
 }
 
 static int unlock_onfault_check(char *map)
 {
 	unsigned long page_size = getpagesize();
-	uint64_t page1_flags;
-
-	page1_flags = get_pageflags((unsigned long)map);
-	page1_flags = get_kpageflags(page1_flags & PFN_MASK);
-
-	if (page1_flags & UNEVICTABLE_BIT) {
-		printf("Page 1 is still marked unevictable after unlock\n");
-		return 1;
-	}
 
 	if (is_vma_lock_on_fault((unsigned long)map) ||
 	    is_vma_lock_on_fault((unsigned long)map + page_size)) {
@@ -445,7 +298,6 @@ static int test_lock_onfault_of_present()
 	char *map;
 	int ret = 1;
 	unsigned long page_size = getpagesize();
-	uint64_t page1_flags, page2_flags;
 
 	map = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
 		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
@@ -465,17 +317,6 @@ static int test_lock_onfault_of_present()
 		goto unmap;
 	}
 
-	page1_flags = get_pageflags((unsigned long)map);
-	page2_flags = get_pageflags((unsigned long)map + page_size);
-	page1_flags = get_kpageflags(page1_flags & PFN_MASK);
-	page2_flags = get_kpageflags(page2_flags & PFN_MASK);
-
-	/* Page 1 should be unevictable */
-	if ((page1_flags & UNEVICTABLE_BIT) == 0) {
-		printf("Failed to make present page unevictable\n");
-		goto unmap;
-	}
-
 	if (!is_vma_lock_on_fault((unsigned long)map) ||
 	    !is_vma_lock_on_fault((unsigned long)map + page_size)) {
 		printf("VMA with present pages is not marked lock on fault\n");
@@ -507,7 +348,7 @@ static int test_munlockall()
 		goto out;
 	}
 
-	if (lock_check(map))
+	if (!lock_check((unsigned long)map))
 		goto unmap;
 
 	if (munlockall()) {
@@ -549,7 +390,7 @@ static int test_munlockall()
 		goto out;
 	}
 
-	if (lock_check(map))
+	if (!lock_check((unsigned long)map))
 		goto unmap;
 
 	if (munlockall()) {
-- 
2.25.1

-- 
Michal Hocko
SUSE Labs
