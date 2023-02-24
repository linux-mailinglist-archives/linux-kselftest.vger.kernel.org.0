Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5C6A15FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 05:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBXElQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 23:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBXElN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 23:41:13 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D994ECFE
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 20:41:10 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 05A317B74EDA; Thu, 23 Feb 2023 20:40:59 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org
Subject: [PATCH v3 1/3] mm: add new api to enable ksm per process
Date:   Thu, 23 Feb 2023 20:39:58 -0800
Message-Id: <20230224044000.3084046-2-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230224044000.3084046-1-shr@devkernel.io>
References: <20230224044000.3084046-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds a new prctl to API to enable and disable KSM on a per process
basis instead of only at the VMA basis (with madvise).

1) Introduce new MMF_VM_MERGE_ANY flag

This introduces the new flag MMF_VM_MERGE_ANY flag. When this flag is
set, kernel samepage merging (ksm) gets enabled for all vma's of a
process.

2) add flag to __ksm_enter

This change adds the flag parameter to __ksm_enter. This allows to
distinguish if ksm was called by prctl or madvise.

3) add flag to __ksm_exit call

This adds the flag parameter to the __ksm_exit() call. This allows to
distinguish if this call is for an prctl or madvise invocation.

4) invoke madvise for all vmas in scan_get_next_rmap_item

If the new flag MMF_VM_MERGE_ANY has been set for a process, iterate
over all the vmas and enable ksm if possible. For the vmas that can be
ksm enabled this is only done once.

5) support disabling of ksm for a process

This adds the ability to disable ksm for a process if ksm has been
enabled for the process.

6) add new prctl option to get and set ksm for a process

This adds two new options to the prctl system call
- enable ksm for all vmas of a process (if the vmas support it).
- query if ksm has been enabled for a process.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/ksm.h            | 14 ++++---
 include/linux/sched/coredump.h |  1 +
 include/uapi/linux/prctl.h     |  2 +
 kernel/sys.c                   | 29 +++++++++++++++
 mm/ksm.c                       | 67 ++++++++++++++++++++++++++++++----
 5 files changed, 101 insertions(+), 12 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 7e232ba59b86..d38a05a36298 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -18,20 +18,24 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
-int __ksm_enter(struct mm_struct *mm);
-void __ksm_exit(struct mm_struct *mm);
+int __ksm_enter(struct mm_struct *mm, int flag);
+void __ksm_exit(struct mm_struct *mm, int flag);
=20
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm=
)
 {
+	if (test_bit(MMF_VM_MERGE_ANY, &oldmm->flags))
+		return __ksm_enter(mm, MMF_VM_MERGE_ANY);
 	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
-		return __ksm_enter(mm);
+		return __ksm_enter(mm, MMF_VM_MERGEABLE);
 	return 0;
 }
=20
 static inline void ksm_exit(struct mm_struct *mm)
 {
-	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
-		__ksm_exit(mm);
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		__ksm_exit(mm, MMF_VM_MERGE_ANY);
+	else if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
+		__ksm_exit(mm, MMF_VM_MERGEABLE);
 }
=20
 /*
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredum=
p.h
index 0e17ae7fbfd3..0ee96ea7a0e9 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -90,4 +90,5 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
=20
+#define MMF_VM_MERGE_ANY	29
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 1312a137f7fb..759b3f53e53f 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -290,4 +290,6 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
=20
+#define PR_SET_MEMORY_MERGE		67
+#define PR_GET_MEMORY_MERGE		68
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index b3cab94545ed..495bab3ed2ad 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -15,6 +15,7 @@
 #include <linux/highuid.h>
 #include <linux/fs.h>
 #include <linux/kmod.h>
+#include <linux/ksm.h>
 #include <linux/perf_event.h>
 #include <linux/resource.h>
 #include <linux/kernel.h>
@@ -2659,6 +2660,34 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error =3D prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+#ifdef CONFIG_KSM
+	case PR_SET_MEMORY_MERGE:
+		if (!capable(CAP_SYS_RESOURCE))
+			return -EPERM;
+
+		if (arg2) {
+			if (mmap_write_lock_killable(me->mm))
+				return -EINTR;
+
+			if (test_bit(MMF_VM_MERGEABLE, &me->mm->flags))
+				error =3D -EINVAL;
+			else if (!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags))
+				error =3D __ksm_enter(me->mm, MMF_VM_MERGE_ANY);
+			mmap_write_unlock(me->mm);
+		} else {
+			__ksm_exit(me->mm, MMF_VM_MERGE_ANY);
+		}
+		break;
+	case PR_GET_MEMORY_MERGE:
+		if (!capable(CAP_SYS_RESOURCE))
+			return -EPERM;
+
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+
+		error =3D !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
+		break;
+#endif
 	default:
 		error =3D -EINVAL;
 		break;
diff --git a/mm/ksm.c b/mm/ksm.c
index 56808e3bfd19..23d6944f78ad 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1063,6 +1063,7 @@ static int unmerge_and_remove_all_rmap_items(void)
=20
 			mm_slot_free(mm_slot_cache, mm_slot);
 			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 			mmdrop(mm);
 		} else
 			spin_unlock(&ksm_mmlist_lock);
@@ -2329,6 +2330,17 @@ static struct ksm_rmap_item *get_next_rmap_item(st=
ruct ksm_mm_slot *mm_slot,
 	return rmap_item;
 }
=20
+static bool vma_ksm_mergeable(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_MERGEABLE)
+		return true;
+
+	if (test_bit(MMF_VM_MERGE_ANY, &vma->vm_mm->flags))
+		return true;
+
+	return false;
+}
+
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
@@ -2405,8 +2417,20 @@ static struct ksm_rmap_item *scan_get_next_rmap_it=
em(struct page **page)
 		goto no_vmas;
=20
 	for_each_vma(vmi, vma) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
+		if (!vma_ksm_mergeable(vma))
 			continue;
+		if (!(vma->vm_flags & VM_MERGEABLE)) {
+			unsigned long flags =3D vma->vm_flags;
+
+			/* madvise failed, use next vma */
+			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &fla=
gs))
+				continue;
+			/* vma, not supported as being mergeable */
+			if (!(flags & VM_MERGEABLE))
+				continue;
+
+			vm_flags_set(vma, VM_MERGEABLE);
+		}
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address =3D vma->vm_start;
 		if (!vma->anon_vma)
@@ -2491,6 +2515,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
=20
 		mm_slot_free(mm_slot_cache, mm_slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
@@ -2595,8 +2620,9 @@ int ksm_madvise(struct vm_area_struct *vma, unsigne=
d long start,
 			return 0;
 #endif
=20
-		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
-			err =3D __ksm_enter(mm);
+		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags) &&
+		    !test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
+			err =3D __ksm_enter(mm, MMF_VM_MERGEABLE);
 			if (err)
 				return err;
 		}
@@ -2622,7 +2648,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigne=
d long start,
 }
 EXPORT_SYMBOL_GPL(ksm_madvise);
=20
-int __ksm_enter(struct mm_struct *mm)
+int __ksm_enter(struct mm_struct *mm, int flag)
 {
 	struct ksm_mm_slot *mm_slot;
 	struct mm_slot *slot;
@@ -2655,7 +2681,7 @@ int __ksm_enter(struct mm_struct *mm)
 		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	set_bit(MMF_VM_MERGEABLE, &mm->flags);
+	set_bit(flag, &mm->flags);
 	mmgrab(mm);
=20
 	if (needs_wakeup)
@@ -2664,12 +2690,39 @@ int __ksm_enter(struct mm_struct *mm)
 	return 0;
 }
=20
-void __ksm_exit(struct mm_struct *mm)
+static void unmerge_vmas(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+
+	vma_iter_init(&vmi, mm, 0);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma->vm_flags & VM_MERGEABLE) {
+			unsigned long flags =3D vma->vm_flags;
+
+			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_UNMERGEABLE, &f=
lags))
+				continue;
+
+			vm_flags_clear(vma, VM_MERGEABLE);
+		}
+	}
+	mmap_read_unlock(mm);
+}
+
+void __ksm_exit(struct mm_struct *mm, int flag)
 {
 	struct ksm_mm_slot *mm_slot;
 	struct mm_slot *slot;
 	int easy_to_free =3D 0;
=20
+	if (!(current->flags & PF_EXITING) && flag =3D=3D MMF_VM_MERGE_ANY &&
+		test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
+		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
+		unmerge_vmas(mm);
+	}
+
 	/*
 	 * This process is exiting: if it's straightforward (as is the
 	 * case when ksmd was never running), free mm_slot immediately.
@@ -2696,7 +2749,7 @@ void __ksm_exit(struct mm_struct *mm)
=20
 	if (easy_to_free) {
 		mm_slot_free(mm_slot_cache, mm_slot);
-		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		clear_bit(flag, &mm->flags);
 		mmdrop(mm);
 	} else if (mm_slot) {
 		mmap_write_lock(mm);
--=20
2.30.2

