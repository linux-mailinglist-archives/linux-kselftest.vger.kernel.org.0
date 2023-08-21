Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75513782B56
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjHUOP5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjHUOPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 10:15:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAEAF7;
        Mon, 21 Aug 2023 07:15:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.45.215.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EAFB166071B1;
        Mon, 21 Aug 2023 15:15:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692627350;
        bh=0PvPtg6Np8yn/JNmm3Y8kc1Y3Fh9upjOkcGeHoRcVG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFk83em7qVrEj4KalUfXncSC9JdoLxXreEyGh+8COK5tTBtg0ImsSXJMzQsyEdxmw
         1eftXuHF25gIamtN2ZnUfR+fdbYe0cyY48vGXbEYnNb0FMxsYMPGx7Or4voSNSfjRN
         xS7g15/NmtDK22tb5JTHHvj4Xz4wrY1HWTqiPPA45+I8cQC9PYSV+hsSMULeiLEsda
         ChJrrQ4bSxnFUB5R8ekhgpmnC4XEfFB/RwBYdG6WbLA6yWWc2chb4lAoeycI7cqCTk
         iAhQr/nB/4D9Z2dQYimjolK6OWRJTgI6UyGsm6dpcCzamnfVDJVn4vbL6DrCVuy0qO
         v6MbzzWnUz85Q==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v33 1/6] userfaultfd: UFFD_FEATURE_WP_ASYNC
Date:   Mon, 21 Aug 2023 19:15:13 +0500
Message-Id: <20230821141518.870589-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821141518.870589-1-usama.anjum@collabora.com>
References: <20230821141518.870589-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

This patch adds a new userfaultfd-wp feature UFFD_FEATURE_WP_ASYNC, that
allows userfaultfd wr-protect faults to be resolved by the kernel directly.

It can be used like a high accuracy version of soft-dirty, without vma
modifications during tracking, and also with ranged support by default
rather than for a whole mm when reset the protections due to existence of
ioctl(UFFDIO_WRITEPROTECT).

Several goals of such a dirty tracking interface:

1. All types of memory should be supported and tracable. This is nature
   for soft-dirty but should mention when the context is userfaultfd,
   because it used to only support anon/shmem/hugetlb. The problem is for
   a dirty tracking purpose these three types may not be enough, and it's
   legal to track anything e.g. any page cache writes from mmap.

2. Protections can be applied to partial of a memory range, without vma
   split/merge fuss.  The hope is that the tracking itself should not
   affect any vma layout change.  It also helps when reset happens because
   the reset will not need mmap write lock which can block the tracee.

3. Accuracy needs to be maintained.  This means we need pte markers to work
   on any type of VMA.

One could question that, the whole concept of async dirty tracking is not
really close to fundamentally what userfaultfd used to be: it's not "a
fault to be serviced by userspace" anymore. However, using userfaultfd-wp
here as a framework is convenient for us in at least:

1. VM_UFFD_WP vma flag, which has a very good name to suite something like
   this, so we don't need VM_YET_ANOTHER_SOFT_DIRTY. Just use a new
   feature bit to identify from a sync version of uffd-wp registration.

2. PTE markers logic can be leveraged across the whole kernel to maintain
   the uffd-wp bit as long as an arch supports, this also applies to this
   case where uffd-wp bit will be a hint to dirty information and it will
   not go lost easily (e.g. when some page cache ptes got zapped).

3. Reuse ioctl(UFFDIO_WRITEPROTECT) interface for either starting or
   resetting a range of memory, while there's no counterpart in the old
   soft-dirty world, hence if this is wanted in a new design we'll need a
   new interface otherwise.

We can somehow understand that commonality because uffd-wp was
fundamentally a similar idea of write-protecting pages just like
soft-dirty.

This implementation allows WP_ASYNC to imply WP_UNPOPULATED, because so far
WP_ASYNC seems to not usable if without WP_UNPOPULATE.  This also gives us
chance to modify impl of WP_ASYNC just in case it could be not depending on
WP_UNPOPULATED anymore in the future kernels. It's also fine to imply that
because both features will rely on PTE_MARKER_UFFD_WP config option, so
they'll show up together (or both missing) in an UFFDIO_API probe.

vma_can_userfault() now allows any VMA if the userfaultfd registration is
only about async uffd-wp. So we can track dirty for all kinds of memory
including generic file systems (like XFS, EXT4 or BTRFS).

One trick worth mention in do_wp_page() is that we need to manually update
vmf->orig_pte here because it can be used later with a pte_same() check -
this path always has FAULT_FLAG_ORIG_PTE_VALID set in the flags.

The major defect of this approach of dirty tracking is we need to populate
the pgtables when tracking starts. Soft-dirty doesn't do it like that.
It's unwanted in the case where the range of memory to track is huge and
unpopulated (e.g., tracking updates on a 10G file with mmap() on top,
without having any page cache installed yet). One way to improve this is
to allow pte markers exist for larger than PTE level for PMD+. That will
not change the interface if to implemented, so we can leave that for later.

Co-developed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
Changes in v30:
- Rebase on top of next-20230815 and resolve conflict in mm/memory.c

Changes in v24:
- Rebase on top of next-20230710
- UFFD_FEATURE_WP_ASYNC has been defined to be (1 << 15) after the
  rebase

Changes in v18:
- Rebase on top of next-20230613 (use ptep_get)

Changes in v17:
- Rebase on top of next-20230525

Changes in v12:
- Peter added the hugetlb support and revamped some other implementation
- Transferred the authorship to Peter
- Merge documentation to this patch

Changes in v11:
- Fix return code in userfaultfd_register() and minor changes here and
  there
- Rebase on top of next-20230307
- Base patches on UFFD_FEATURE_WP_UNPOPULATED https://lore.kernel.org/all/20230306213925.617814-1-peterx@redhat.com
- UFFD_FEATURE_WP_ASYNC depends on UFFD_FEATURE_WP_UNPOPULATED to work
  (correctly)

Changes in v10:
- Build fix
- Update comments and add error condition to return error from uffd
  register if hugetlb pages are present when wp async flag is set

Changes in v9:
- Correct the fault resolution with code contributed by Peter

Changes in v7:
- Remove UFFDIO_WRITEPROTECT_MODE_ASYNC_WP and add UFFD_FEATURE_WP_ASYNC
- Handle automatic page fault resolution in better way (thanks to Peter)
---
 Documentation/admin-guide/mm/userfaultfd.rst | 35 ++++++++++++++++++++
 fs/userfaultfd.c                             | 26 ++++++++++++---
 include/linux/userfaultfd_k.h                | 21 +++++++++++-
 include/uapi/linux/userfaultfd.h             |  9 ++++-
 mm/hugetlb.c                                 | 32 ++++++++++--------
 mm/memory.c                                  | 28 ++++++++++++++--
 6 files changed, 129 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 4349a8c2b9783..203e26da5f920 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -244,6 +244,41 @@ write-protected (so future writes will also result in a WP fault). These ioctls
 support a mode flag (``UFFDIO_COPY_MODE_WP`` or ``UFFDIO_CONTINUE_MODE_WP``
 respectively) to configure the mapping this way.
 
+If the userfaultfd context has ``UFFD_FEATURE_WP_ASYNC`` feature bit set,
+any vma registered with write-protection will work in async mode rather
+than the default sync mode.
+
+In async mode, there will be no message generated when a write operation
+happens, meanwhile the write-protection will be resolved automatically by
+the kernel.  It can be seen as a more accurate version of soft-dirty
+tracking and it can be different in a few ways:
+
+  - The dirty result will not be affected by vma changes (e.g. vma
+    merging) because the dirty is only tracked by the pte.
+
+  - It supports range operations by default, so one can enable tracking on
+    any range of memory as long as page aligned.
+
+  - Dirty information will not get lost if the pte was zapped due to
+    various reasons (e.g. during split of a shmem transparent huge page).
+
+  - Due to a reverted meaning of soft-dirty (page clean when uffd-wp bit
+    set; dirty when uffd-wp bit cleared), it has different semantics on
+    some of the memory operations.  For example: ``MADV_DONTNEED`` on
+    anonymous (or ``MADV_REMOVE`` on a file mapping) will be treated as
+    dirtying of memory by dropping uffd-wp bit during the procedure.
+
+The user app can collect the "written/dirty" status by looking up the
+uffd-wp bit for the pages being interested in /proc/pagemap.
+
+The page will not be under track of uffd-wp async mode until the page is
+explicitly write-protected by ``ioctl(UFFDIO_WRITEPROTECT)`` with the mode
+flag ``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault
+that was tracked by async mode userfaultfd-wp is invalid.
+
+When userfaultfd-wp async mode is used alone, it can be applied to all
+kinds of memory.
+
 Memory Poisioning Emulation
 ---------------------------
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 1091cb4617474..1763d597d0ed3 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -123,6 +123,11 @@ static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
 	return ctx->features & UFFD_FEATURE_INITIALIZED;
 }
 
+static bool userfaultfd_wp_async_ctx(struct userfaultfd_ctx *ctx)
+{
+	return ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC);
+}
+
 /*
  * Whether WP_UNPOPULATED is enabled on the uffd context.  It is only
  * meaningful when userfaultfd_wp()==true on the vma and when it's
@@ -1329,6 +1334,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
 	struct vma_iterator vmi;
+	bool wp_async = userfaultfd_wp_async_ctx(ctx);
 	pgoff_t pgoff;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
@@ -1403,7 +1409,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 		/* check not compatible vmas */
 		ret = -EINVAL;
-		if (!vma_can_userfault(cur, vm_flags))
+		if (!vma_can_userfault(cur, vm_flags, wp_async))
 			goto out_unlock;
 
 		/*
@@ -1464,7 +1470,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vm_flags));
+		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
 		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
 		       vma->vm_userfaultfd_ctx.ctx != ctx);
 		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
@@ -1565,6 +1571,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
+	bool wp_async = userfaultfd_wp_async_ctx(ctx);
 	pgoff_t pgoff;
 
 	ret = -EFAULT;
@@ -1619,7 +1626,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 * provides for more strict behavior to notice
 		 * unregistration errors.
 		 */
-		if (!vma_can_userfault(cur, cur->vm_flags))
+		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
 			goto out_unlock;
 
 		found = true;
@@ -1635,7 +1642,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
+		BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
@@ -2022,6 +2029,11 @@ static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long
 	return ret;
 }
 
+bool userfaultfd_wp_async(struct vm_area_struct *vma)
+{
+	return userfaultfd_wp_async_ctx(vma->vm_userfaultfd_ctx.ctx);
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
@@ -2055,6 +2067,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	ret = -EPERM;
 	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
 		goto err_out;
+
+	/* WP_ASYNC relies on WP_UNPOPULATED, choose it unconditionally */
+	if (features & UFFD_FEATURE_WP_ASYNC)
+		features |= UFFD_FEATURE_WP_UNPOPULATED;
+
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
@@ -2067,6 +2084,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
 	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
+	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ac8c6854097cd..c98df391bfd8f 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -161,11 +161,22 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 }
 
 static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     unsigned long vm_flags)
+				     unsigned long vm_flags,
+				     bool wp_async)
 {
+	vm_flags &= __VM_UFFD_FLAGS;
+
 	if ((vm_flags & VM_UFFD_MINOR) &&
 	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
 		return false;
+
+	/*
+	 * If wp async enabled, and WP is the only mode enabled, allow any
+	 * memory type.
+	 */
+	if (wp_async && (vm_flags == VM_UFFD_WP))
+		return true;
+
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
@@ -175,6 +186,8 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
 		return false;
 #endif
+
+	/* By default, allow any of anon|shmem|hugetlb */
 	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
 	    vma_is_shmem(vma);
 }
@@ -197,6 +210,7 @@ extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
+extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
 
 #else /* CONFIG_USERFAULTFD */
 
@@ -297,6 +311,11 @@ static inline bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_wp_async(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 62151706c5a38..0dbc81015018b 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -40,7 +40,8 @@
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
 			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
 			   UFFD_FEATURE_WP_UNPOPULATED |	\
-			   UFFD_FEATURE_POISON)
+			   UFFD_FEATURE_POISON |		\
+			   UFFD_FEATURE_WP_ASYNC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -216,6 +217,11 @@ struct uffdio_api {
 	 * (i.e. empty ptes).  This will be the default behavior for shmem
 	 * & hugetlbfs, so this flag only affects anonymous memory behavior
 	 * when userfault write-protection mode is registered.
+	 *
+	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
+	 * asynchronous mode is supported in which the write fault is
+	 * automatically resolved and write-protection is un-set.
+	 * It implies UFFD_FEATURE_WP_UNPOPULATED.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -232,6 +238,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
 #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
 #define UFFD_FEATURE_POISON			(1<<14)
+#define UFFD_FEATURE_WP_ASYNC			(1<<15)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5f498e8025cc5..7ed95353c46a7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6197,21 +6197,27 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	/* Handle userfault-wp first, before trying to lock more pages */
 	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
-		struct vm_fault vmf = {
-			.vma = vma,
-			.address = haddr,
-			.real_address = address,
-			.flags = flags,
-		};
+		if (!userfaultfd_wp_async(vma)) {
+			struct vm_fault vmf = {
+				.vma = vma,
+				.address = haddr,
+				.real_address = address,
+				.flags = flags,
+			};
 
-		spin_unlock(ptl);
-		if (pagecache_folio) {
-			folio_unlock(pagecache_folio);
-			folio_put(pagecache_folio);
+			spin_unlock(ptl);
+			if (pagecache_folio) {
+				folio_unlock(pagecache_folio);
+				folio_put(pagecache_folio);
+			}
+			hugetlb_vma_unlock_read(vma);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			return handle_userfault(&vmf, VM_UFFD_WP);
 		}
-		hugetlb_vma_unlock_read(vma);
-		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		return handle_userfault(&vmf, VM_UFFD_WP);
+
+		entry = huge_pte_clear_uffd_wp(entry);
+		set_huge_pte_at(mm, haddr, ptep, entry);
+		/* Fallthrough to CoW */
 	}
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index 3b4aaa0d2fff8..fcae9aab7893a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1,3 +1,4 @@
+
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  *  linux/mm/memory.c
@@ -3356,11 +3357,28 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = NULL;
+	pte_t pte;
 
 	if (likely(!unshare)) {
 		if (userfaultfd_pte_wp(vma, ptep_get(vmf->pte))) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return handle_userfault(vmf, VM_UFFD_WP);
+			if (!userfaultfd_wp_async(vma)) {
+				pte_unmap_unlock(vmf->pte, vmf->ptl);
+				return handle_userfault(vmf, VM_UFFD_WP);
+			}
+
+			/*
+			 * Nothing needed (cache flush, TLB invalidations,
+			 * etc.) because we're only removing the uffd-wp bit,
+			 * which is completely invisible to the user.
+			 */
+			pte = pte_clear_uffd_wp(ptep_get(vmf->pte));
+
+			set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
+			/*
+			 * Update this to be prepared for following up CoW
+			 * handling
+			 */
+			vmf->orig_pte = pte;
 		}
 
 		/*
@@ -4892,8 +4910,11 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 
 	if (vma_is_anonymous(vma)) {
 		if (likely(!unshare) &&
-		    userfaultfd_huge_pmd_wp(vma, vmf->orig_pmd))
+		    userfaultfd_huge_pmd_wp(vma, vmf->orig_pmd)) {
+			if (userfaultfd_wp_async(vmf->vma))
+				goto split;
 			return handle_userfault(vmf, VM_UFFD_WP);
+		}
 		return do_huge_pmd_wp_page(vmf);
 	}
 
@@ -4909,6 +4930,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 		}
 	}
 
+split:
 	/* COW or write-notify handled on pte level: split pmd. */
 	__split_huge_pmd(vma, vmf->pmd, vmf->address, false, NULL);
 
-- 
2.40.1

