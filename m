Return-Path: <linux-kselftest+bounces-23773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA79FD143
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 08:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D7C7A18BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3581494A5;
	Fri, 27 Dec 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7rL/1Cg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E0146D6E;
	Fri, 27 Dec 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284567; cv=none; b=oKx98qreZMfEiHRjgHkcDRJiFli6YNGCKcsEN3DOGiebuo7S/u22izKqW3JvW5IEqnG2Glbxzc6x9lZNhxplwl2P4LNZAR2HRYkM5qdjYZhGcY1QzoaaQwJ8mCUYysDZgx28mPc8DLy4v/nZv8Mg+xVBqIEZ9tlGWFYixfcjZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284567; c=relaxed/simple;
	bh=eadd2fhesnrBbYUtyPuDOjZKluNBdPkoQ6My17z11ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvCIUg6mJYP6389ZP9TSb0G1MeoRJxV3zbmfIErsQlqOXC1Wudk8mOAtPV4yt9XxqEn5S80MTCUrH8lotLd1CHPDb2p07aaUruveLA/am8oF1eF+g9CCd0pnb+JVTug/zdzmKU8LwpO8PrfCOo7Hk2OmU/yUJt6+hwuTwL7aP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7rL/1Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41ABC4CED7;
	Fri, 27 Dec 2024 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284566;
	bh=eadd2fhesnrBbYUtyPuDOjZKluNBdPkoQ6My17z11ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7rL/1CgjCZvQAHg7NIcED5Na02EGjDigmzncnfAGdsE4oPXN9GFMNUqOgGKcIAxK
	 hSznXGjRdJakuaXWQ8k1hzlFSbmpLCpkjLNAHE9LAlkf8Pyn2im17Lax3zToCNnlDO
	 sF35OhD0vR+mDq6BWIXP/rORjFkoB2OmxqrXTUnH03R297ViXYi/DxGzjgG/PiNdu0
	 UHjn6xvvqWwhXwUiJ2EvGaz72tB1oOF/eaVLHsZ/Slq/nm9qigaXwYR1thVtB6yGTd
	 HfkagPFgCDXBJAQttID2sWzOm9fw+FJoE9uewLZw8sH2jQV7a2Ah68AXl/hMetNBpC
	 0CKPg/BqE8lzg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Daniel Thompson <danielt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	live-patching@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 4/8] execmem: add API for temporal remapping as RW and restoring ROX afterwards
Date: Fri, 27 Dec 2024 09:28:21 +0200
Message-ID: <20241227072825.1288491-5-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227072825.1288491-1-rppt@kernel.org>
References: <20241227072825.1288491-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Using a writable copy for ROX memory is cumbersome and error prone.

Add API that allow temporarily remapping of ranges in the ROX cache as
writable  and then restoring their read-only-execute permissions.

This API will be later used in modules code and will allow removing nasty
games with writable copy in alternatives patching on x86.

The restoring of the ROX permissions relies on the ability of architecture
to reconstruct large pages in its set_memory_rox() method.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/execmem.h |  31 +++++++++++
 mm/execmem.c            | 118 +++++++++++++++++++++++++++++++++-------
 2 files changed, 130 insertions(+), 19 deletions(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 64130ae19690..65655a5d1be2 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -65,6 +65,37 @@ enum execmem_range_flags {
  * Architectures that use EXECMEM_ROX_CACHE must implement this.
  */
 void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable);
+
+/**
+ * execmem_make_temp_rw - temporarily remap region with read-write
+ *			  permissions
+ * @ptr:	address of the region to remap
+ * @size:	size of the region to remap
+ *
+ * Remaps a part of the cached large page in the ROX cache in the range
+ * [@ptr, @ptr + @size) as writable and not executable. The caller must
+ * have exclusive ownership of this range and ensure nothing will try to
+ * execute code in this range.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int execmem_make_temp_rw(void *ptr, size_t size);
+
+/**
+ * execmem_restore_rox - restore read-only-execute permissions
+ * @ptr:	address of the region to remap
+ * @size:	size of the region to remap
+ *
+ * Restores read-only-execute permissions on a range [@ptr, @ptr + @size)
+ * after it was temporarily remapped as writable. Relies on architecture
+ * implementation of set_memory_rox() to restore mapping using large pages.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int execmem_restore_rox(void *ptr, size_t size);
+#else
+static inline int execmem_make_temp_rw(void *ptr, size_t size) { return 0; }
+static inline int execmem_restore_rox(void *ptr, size_t size) { return 0; }
 #endif
 
 /**
diff --git a/mm/execmem.c b/mm/execmem.c
index 317b6a8d35be..be6b234c032e 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -89,6 +89,12 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_ARCH_HAS_EXECMEM_ROX
+struct execmem_area {
+	struct vm_struct *vm;
+	unsigned int rw_mappings;
+	size_t size;
+};
+
 struct execmem_cache {
 	struct mutex mutex;
 	struct maple_tree busy_areas;
@@ -135,7 +141,7 @@ static void execmem_cache_clean(struct work_struct *work)
 	struct maple_tree *free_areas = &execmem_cache.free_areas;
 	struct mutex *mutex = &execmem_cache.mutex;
 	MA_STATE(mas, free_areas, 0, ULONG_MAX);
-	void *area;
+	struct execmem_area *area;
 
 	mutex_lock(mutex);
 	mas_for_each(&mas, area, ULONG_MAX) {
@@ -143,11 +149,12 @@ static void execmem_cache_clean(struct work_struct *work)
 
 		if (IS_ALIGNED(size, PMD_SIZE) &&
 		    IS_ALIGNED(mas.index, PMD_SIZE)) {
-			struct vm_struct *vm = find_vm_area(area);
+			struct vm_struct *vm = area->vm;
 
 			execmem_set_direct_map_valid(vm, true);
 			mas_store_gfp(&mas, NULL, GFP_KERNEL);
-			vfree(area);
+			vfree(vm->addr);
+			kfree(area);
 		}
 	}
 	mutex_unlock(mutex);
@@ -155,30 +162,31 @@ static void execmem_cache_clean(struct work_struct *work)
 
 static DECLARE_WORK(execmem_cache_clean_work, execmem_cache_clean);
 
-static int execmem_cache_add(void *ptr, size_t size)
+static int execmem_cache_add(void *ptr, size_t size, struct execmem_area *area)
 {
 	struct maple_tree *free_areas = &execmem_cache.free_areas;
 	struct mutex *mutex = &execmem_cache.mutex;
 	unsigned long addr = (unsigned long)ptr;
 	MA_STATE(mas, free_areas, addr - 1, addr + 1);
+	struct execmem_area *lower_area = NULL;
+	struct execmem_area *upper_area = NULL;
 	unsigned long lower, upper;
-	void *area = NULL;
 	int err;
 
 	lower = addr;
 	upper = addr + size - 1;
 
 	mutex_lock(mutex);
-	area = mas_walk(&mas);
-	if (area && mas.last == addr - 1)
+	lower_area = mas_walk(&mas);
+	if (lower_area && lower_area == area && mas.last == addr - 1)
 		lower = mas.index;
 
-	area = mas_next(&mas, ULONG_MAX);
-	if (area && mas.index == addr + size)
+	upper_area = mas_next(&mas, ULONG_MAX);
+	if (upper_area && upper_area == area && mas.index == addr + size)
 		upper = mas.last;
 
 	mas_set_range(&mas, lower, upper);
-	err = mas_store_gfp(&mas, (void *)lower, GFP_KERNEL);
+	err = mas_store_gfp(&mas, area, GFP_KERNEL);
 	mutex_unlock(mutex);
 	if (err)
 		return err;
@@ -209,7 +217,8 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 	MA_STATE(mas_busy, busy_areas, 0, ULONG_MAX);
 	struct mutex *mutex = &execmem_cache.mutex;
 	unsigned long addr, last, area_size = 0;
-	void *area, *ptr = NULL;
+	struct execmem_area *area;
+	void *ptr = NULL;
 	int err;
 
 	mutex_lock(mutex);
@@ -228,20 +237,18 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 
 	/* insert allocated size to busy_areas at range [addr, addr + size) */
 	mas_set_range(&mas_busy, addr, addr + size - 1);
-	err = mas_store_gfp(&mas_busy, (void *)addr, GFP_KERNEL);
+	err = mas_store_gfp(&mas_busy, area, GFP_KERNEL);
 	if (err)
 		goto out_unlock;
 
 	mas_store_gfp(&mas_free, NULL, GFP_KERNEL);
 	if (area_size > size) {
-		void *ptr = (void *)(addr + size);
-
 		/*
 		 * re-insert remaining free size to free_areas at range
 		 * [addr + size, last]
 		 */
 		mas_set_range(&mas_free, addr + size, last);
-		err = mas_store_gfp(&mas_free, ptr, GFP_KERNEL);
+		err = mas_store_gfp(&mas_free, area, GFP_KERNEL);
 		if (err) {
 			mas_store_gfp(&mas_busy, NULL, GFP_KERNEL);
 			goto out_unlock;
@@ -257,16 +264,21 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 static int execmem_cache_populate(struct execmem_range *range, size_t size)
 {
 	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
+	struct execmem_area *area;
 	unsigned long start, end;
 	struct vm_struct *vm;
 	size_t alloc_size;
 	int err = -ENOMEM;
 	void *p;
 
+	area = kzalloc(sizeof(*area), GFP_KERNEL);
+	if (!area)
+		return err;
+
 	alloc_size = round_up(size, PMD_SIZE);
 	p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
 	if (!p)
-		return err;
+		goto err_free_area;
 
 	vm = find_vm_area(p);
 	if (!vm)
@@ -289,7 +301,9 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 	if (err)
 		goto err_free_mem;
 
-	err = execmem_cache_add(p, alloc_size);
+	area->size = alloc_size;
+	area->vm = vm;
+	err = execmem_cache_add(p, alloc_size, area);
 	if (err)
 		goto err_free_mem;
 
@@ -297,6 +311,8 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 
 err_free_mem:
 	vfree(p);
+err_free_area:
+	kfree(area);
 	return err;
 }
 
@@ -305,6 +321,9 @@ static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
 	void *p;
 	int err;
 
+	/* make sure everything in the cache is page aligned */
+	size = PAGE_ALIGN(size);
+
 	p = __execmem_cache_alloc(range, size);
 	if (p)
 		return p;
@@ -322,8 +341,8 @@ static bool execmem_cache_free(void *ptr)
 	struct mutex *mutex = &execmem_cache.mutex;
 	unsigned long addr = (unsigned long)ptr;
 	MA_STATE(mas, busy_areas, addr, addr);
+	struct execmem_area *area;
 	size_t size;
-	void *area;
 
 	mutex_lock(mutex);
 	area = mas_walk(&mas);
@@ -338,12 +357,73 @@ static bool execmem_cache_free(void *ptr)
 
 	execmem_fill_trapping_insns(ptr, size, /* writable = */ false);
 
-	execmem_cache_add(ptr, size);
+	execmem_cache_add(ptr, size, area);
 
 	schedule_work(&execmem_cache_clean_work);
 
 	return true;
 }
+
+int execmem_make_temp_rw(void *ptr, size_t size)
+{
+	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
+	unsigned int nr = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	struct mutex *mutex = &execmem_cache.mutex;
+	unsigned long addr = (unsigned long)ptr;
+	MA_STATE(mas, busy_areas, addr, addr);
+	struct execmem_area *area;
+	int ret = -ENOMEM;
+
+	mutex_lock(mutex);
+	area = mas_walk(&mas);
+	if (!area)
+		goto out;
+
+	ret = set_memory_nx(addr, nr);
+	if (ret)
+		goto out;
+
+	/*
+	 * If a split of large page was required, it already happened when
+	 * we marked the pages NX which guarantees that this call won't
+	 * fail
+	 */
+	set_memory_rw(addr, nr);
+	area->rw_mappings++;
+
+out:
+	mutex_unlock(mutex);
+	return ret;
+}
+
+int execmem_restore_rox(void *ptr, size_t size)
+{
+	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
+	struct mutex *mutex = &execmem_cache.mutex;
+	unsigned long addr = (unsigned long)ptr;
+	MA_STATE(mas, busy_areas, addr, addr);
+	struct execmem_area *area;
+	int err = 0;
+
+	size = PAGE_ALIGN(size);
+
+	mutex_lock(mutex);
+	mas_for_each(&mas, area, addr + size - 1) {
+		area->rw_mappings--;
+		if (!area->rw_mappings) {
+			unsigned int nr = area->size >> PAGE_SHIFT;
+
+			addr = (unsigned long)area->vm->addr;
+			err = set_memory_rox(addr, nr);
+			if (err)
+				break;
+		}
+	}
+	mutex_unlock(mutex);
+
+	return err;
+}
+
 #else /* CONFIG_ARCH_HAS_EXECMEM_ROX */
 static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
 {
-- 
2.45.2


