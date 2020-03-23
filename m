Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3218F8F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 16:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCWPvR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 11:51:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40374 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCWPvR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 11:51:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id f3so17703538wrw.7;
        Mon, 23 Mar 2020 08:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J7zQuQy5+8+0I6Vo5KwwDu2wVxfGzEroOlryLsbHJ/Q=;
        b=ENYnB8wU6+TGWPjMvK8ARguKVI4EMVoccJizgsVPc1td93qFs2JE97F3nM7U5mcYJW
         OV99qxRxTGvmTljf5prsAMUplbiuVjodqbXppIpJvzJBMmiaiJMQZPV1/L35NvXZckl/
         TTP49x7iMhY+0bq3vhEsbpyYi4HxR0wxjRCg7ZoHUdpcEjohjD92CJHKzaktorDMyo1i
         YHDMldw6dJaiXxQkhPFC/yIWn5gD7h5T3QtahsS5GvPk35m1uKM0Wmi1zdmFWxrYKlPN
         5MVOm/+DOfIUfXejk+UB8X5tERZAn72jdzuACWInG1ZwbOTIlvoCeW0w472NgxwfQKbN
         7KHA==
X-Gm-Message-State: ANhLgQ2fPozAgUc4jsK+7I4nwrGumdsKEvtsFuXDBVJvjjZmEgP0ckl8
        Okh0/t6jrMQxmvyUV5UEgwc=
X-Google-Smtp-Source: ADFU+vvFRpreT07kZe5+oryOf4pm10y30nLufTOMF7FoXbwvYrZrBXOKLc2ocUaJmBbYjlGQz3ey+g==
X-Received: by 2002:adf:fd4e:: with SMTP id h14mr30641296wrs.221.1584978673282;
        Mon, 23 Mar 2020 08:51:13 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id w11sm24591696wrv.86.2020.03.23.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:51:12 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:51:11 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323155111.GQ7524@dhcp22.suse.cz>
References: <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s>
 <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
 <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
 <20200323075208.GC7524@dhcp22.suse.cz>
 <20200323144240.GB23364@optiplex-lnx>
 <20200323145106.GM7524@dhcp22.suse.cz>
 <20200323150259.GD23364@optiplex-lnx>
 <20200323151256.GP7524@dhcp22.suse.cz>
 <20200323154159.GF23364@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323154159.GF23364@optiplex-lnx>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 23-03-20 11:41:59, Rafael Aquini wrote:
> On Mon, Mar 23, 2020 at 04:12:56PM +0100, Michal Hocko wrote:
> > On Mon 23-03-20 11:02:59, Rafael Aquini wrote:
[...]
> > > The selftest also checks the kernel visible effect, via
> > > /proc/kpageflags, and that's where it fails after 9c4e6b1a7027f.
> > 
> > I really fail to see your point. Even if you are right that the self
> > test is somehow evaluating the kernel implementation which I am not sure
> > is the scope of the selft thest but anyway. The mere fact that the
> > kernel test fails on a perfectly valid change should just suggest that
> > the test is leading to false positives and therefore should be fixed.
> > Your proposed fix is simply suboptimal because it relies on yet another
> > side effect which might change anytime in the future and still lead to a
> > correctly behaving kernel. See my point?
> >
> 
> OK, I concede your point on the bogusness of checking the page flags in
> this particular test and expect certain valuse there, given that no other 
> selftest seems to be doing that level of inner kenrel detail scrutiny.
> 
> I'll repost this fix suggestion getting rif of those related
> checkpoints.

Here is what I have after I had to context switch to something else
before finishing it. Feel free to reuse if you feel like. It is likely
to not even compile.

diff --git a/tools/testing/selftests/vm/mlock2-tests.c b/tools/testing/selftests/vm/mlock2-tests.c
index 637b6d0ac0d0..9fb1638a4d33 100644
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
@@ -179,44 +120,43 @@ static bool is_vma_lock_on_fault(unsigned long addr)
 		goto out;
 	}
 
-	while (getline(&line, &size, smaps) > 0) {
-		if (!strstr(line, SIZE)) {
+	while (getline(&line, &size, file) > 0) {
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
+}
+
+static bool is_vma_lock_on_fault(unsigned long addr)
+{
+	bool locked;
+	unsigned long vma_size, vma_rss;
+
+	locked = is_vmflag_set(addr, LOCKED);
+	if (!locked)
+		return false
+
+	vma_size = get_value_for_name(addr, SIZE);
+	vma_rss = get_value_for_name(addr, RSS);
+
+	/* only one page is faulted in */
+	return (vma_rss < vma_size);
 }
 
 #define PRESENT_BIT     0x8000000000000000ULL
@@ -225,40 +165,18 @@ static bool is_vma_lock_on_fault(unsigned long addr)
 
 static int lock_check(char *map)
 {
-	unsigned long page_size = getpagesize();
-	uint64_t page1_flags, page2_flags;
-
-	page1_flags = get_pageflags((unsigned long)map);
-	page2_flags = get_pageflags((unsigned long)map + page_size);
-
-	/* Both pages should be present */
-	if (((page1_flags & PRESENT_BIT) == 0) ||
-	    ((page2_flags & PRESENT_BIT) == 0)) {
-		printf("Failed to make both pages present\n");
-		return 1;
-	}
-
-	page1_flags = get_kpageflags(page1_flags & PFN_MASK);
-	page2_flags = get_kpageflags(page2_flags & PFN_MASK);
-
-	/* Both pages should be unevictable */
-	if (((page1_flags & UNEVICTABLE_BIT) == 0) ||
-	    ((page2_flags & UNEVICTABLE_BIT) == 0)) {
-		printf("Failed to make both pages unevictable\n");
-		return 1;
-	}
+	bool locked;
+	FILE *smaps = NULL;
+	unsigned long vma_size, vma_rss;
 
-	if (!is_vmflag_set((unsigned long)map, LOCKED)) {
-		printf("VMA flag %s is missing on page 1\n", LOCKED);
-		return 1;
-	}
+	locked = is_vmflag_set(addr, LOCKED);
+	if (!locked)
+		return false;
 
-	if (!is_vmflag_set((unsigned long)map + page_size, LOCKED)) {
-		printf("VMA flag %s is missing on page 2\n", LOCKED);
-		return 1;
-	}
+	vma_size = get_value_for_name(SIZE, smaps);
+	vma_rss = get_value_for_name(RSS, smaps);
 
-	return 0;
+	return (vma_rss == vma_size);
 }
 
 static int unlock_lock_check(char *map)
@@ -266,16 +184,6 @@ static int unlock_lock_check(char *map)
 	unsigned long page_size = getpagesize();
 	uint64_t page1_flags, page2_flags;
 
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
@@ -333,36 +241,7 @@ static int onfault_check(char *map)
 	unsigned long page_size = getpagesize();
 	uint64_t page1_flags, page2_flags;
 
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
@@ -381,14 +260,6 @@ static int unlock_onfault_check(char *map)
 	unsigned long page_size = getpagesize();
 	uint64_t page1_flags;
 
-	page1_flags = get_pageflags((unsigned long)map);
-	page1_flags = get_kpageflags(page1_flags & PFN_MASK);
-
-	if (page1_flags & UNEVICTABLE_BIT) {
-		printf("Page 1 is still marked unevictable after unlock\n");
-		return 1;
-	}
-
 	if (is_vma_lock_on_fault((unsigned long)map) ||
 	    is_vma_lock_on_fault((unsigned long)map + page_size)) {
 		printf("VMA is still lock on fault after unlock\n");
@@ -465,17 +336,6 @@ static int test_lock_onfault_of_present()
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

-- 
Michal Hocko
SUSE Labs
