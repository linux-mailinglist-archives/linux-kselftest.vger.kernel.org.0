Return-Path: <linux-kselftest+bounces-1261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE5806C30
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA891C20BB0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8392E654;
	Wed,  6 Dec 2023 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZYQWFgG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC70D4B
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 02:37:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db539c987e0so6842739276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701859030; x=1702463830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1m+fAfmNhLIONbOjkWQQKWRbqhbbihQEwxB4uoft6eI=;
        b=FZYQWFgGbKczoT3ooq3aEQ8GrWRrVoq2OqRml9kP+aNuA62TnFOQtxHW5ph1yX1Gc9
         I41RuFJSzlHbK0qgHcqXdmQWd07NFpZvYjpKw1EPAVWmThg1iZaG9089eZDhYpGs0Gzt
         GuN9BiyaNaZOaXV57aKnbk3B0Ek2lCkY0sT8WwB6UWsdt40c9tcGhKt+zkMapmoSAnCu
         inX+oLmImSphNZzoYIv9UW09gXp3X7L98ZZ4w+AE9pfTOKWzlGmP3JzbDaF7Z6Rl99sJ
         dqYKKbLRnCHCJVcyABKbvgsNNBEz42Iw3r7ojZJqEw5OFxNytPbWHBGEBuNOFm712zqP
         9epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859030; x=1702463830;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1m+fAfmNhLIONbOjkWQQKWRbqhbbihQEwxB4uoft6eI=;
        b=xVGxFKetXSgFq/6UQHiyqh1mRfKhHuGBg/hOV2Fe5pct1dVGLbi6AJy7bATQtR0Goa
         NU/r1U20ApIQMayECnv4yo479gqYvEK7EHvsmDkv14MR8MDSIPoj0gHHtax7pe/3l1dj
         U04X1axECATI1vmb6sDFoI2j1QKA5b8V2NRYFx9CJr2XmOLxh3cFZ765IjREXVdLYv1L
         91vkolsf5rACG6j8xqdPvOIO4655/lNxyXJdPTZkJjQ79macWYJmhStj0VmEj5MAHpYT
         0ba8/bQswHXvr9RTt4Y+0GM6U+SYsI6dlUn6g/eSpCAZMQ4G6ua8RHybZKHGy9loD0t7
         eYbA==
X-Gm-Message-State: AOJu0YxP0mhRZg2aMq5AGV5l9ldRNSG1y81fbY+7S4vZyDLcoF2alD9D
	/bSwkzXS9S5vcHH07ScIDzBx2JJgizk=
X-Google-Smtp-Source: AGHT+IE/2+gixRsV1fXkFej8Rl4B7gEAlABGjtRE2KjHe0XWh9Ru/OR46ApI8ofMCJcTY8FQbRHOo5uB9RM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:73f6:b5e2:415:6ba5])
 (user=surenb job=sendgmr) by 2002:a25:d288:0:b0:db5:4a39:feb8 with SMTP id
 j130-20020a25d288000000b00db54a39feb8mr4990ybg.8.1701859029918; Wed, 06 Dec
 2023 02:37:09 -0800 (PST)
Date: Wed,  6 Dec 2023 02:36:56 -0800
In-Reply-To: <20231206103702.3873743-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231206103702.3873743-3-surenb@google.com>
Subject: [PATCH v6 2/5] userfaultfd: UFFDIO_MOVE uABI
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Andrea Arcangeli <aarcange@redhat.com>

Implement the uABI of UFFDIO_MOVE ioctl.
UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the application
needs pages to be allocated [1]. However, with UFFDIO_MOVE, if pages are
available (in userspace) for recycling, as is usually the case in heap
compaction algorithms, then we can avoid the page allocation and memcpy
(done by UFFDIO_COPY). Also, since the pages are recycled in the
userspace, we avoid the need to release (via madvise) the pages back to
the kernel [2].
We see over 40% reduction (on a Google pixel 6 device) in the compacting
thread=E2=80=99s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY. This=
 was
measured using a benchmark that emulates a heap compaction implementation
using userfaultfd (to allow concurrent accesses by application threads).
More details of the usecase are explained in [2].
Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
touching them within the same vma. Today, it can only be done by mremap,
however it forces splitting the vma.

[1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@r=
edhat.com/
[2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqx=
RCyjniNVjp0Aw@mail.gmail.com/

Update for the ioctl_userfaultfd(2)  manpage:

   UFFDIO_MOVE
       (Since Linux xxx)  Move a continuous memory chunk into the
       userfault registered range and optionally wake up the blocked
       thread. The source and destination addresses and the number of
       bytes to move are specified by the src, dst, and len fields of
       the uffdio_move structure pointed to by argp:

           struct uffdio_move {
               __u64 dst;    /* Destination of move */
               __u64 src;    /* Source of move */
               __u64 len;    /* Number of bytes to move */
               __u64 mode;   /* Flags controlling behavior of move */
               __s64 move;   /* Number of bytes moved, or negated error */
           };

       The following value may be bitwise ORed in mode to change the
       behavior of the UFFDIO_MOVE operation:

       UFFDIO_MOVE_MODE_DONTWAKE
              Do not wake up the thread that waits for page-fault
              resolution

       UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
              Allow holes in the source virtual range that is being moved.
              When not specified, the holes will result in ENOENT error.
              When specified, the holes will be accounted as successfully
              moved memory. This is mostly useful to move hugepage aligned
              virtual regions without knowing if there are transparent
              hugepages in the regions or not, but preventing the risk of
              having to split the hugepage during the operation.

       The move field is used by the kernel to return the number of
       bytes that was actually moved, or an error (a negated errno-
       style value).  If the value returned in move doesn't match the
       value that was specified in len, the operation fails with the
       error EAGAIN.  The move field is output-only; it is not read by
       the UFFDIO_MOVE operation.

       The operation may fail for various reasons. Usually, remapping of
       pages that are not exclusive to the given process fail; once KSM
       might deduplicate pages or fork() COW-shares pages during fork()
       with child processes, they are no longer exclusive. Further, the
       kernel might only perform lightweight checks for detecting whether
       the pages are exclusive, and return -EBUSY in case that check fails.
       To make the operation more likely to succeed, KSM should be
       disabled, fork() should be avoided or MADV_DONTFORK should be
       configured for the source VMA before fork().

       This ioctl(2) operation returns 0 on success.  In this case, the
       entire area was moved.  On error, -1 is returned and errno is
       set to indicate the error.  Possible errors include:

       EAGAIN The number of bytes moved (i.e., the value returned in
              the move field) does not equal the value that was
              specified in the len field.

       EINVAL Either dst or len was not a multiple of the system page
              size, or the range specified by src and len or dst and len
              was invalid.

       EINVAL An invalid bit was specified in the mode field.

       ENOENT
              The source virtual memory range has unmapped holes and
              UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.

       EEXIST
              The destination virtual memory range is fully or partially
              mapped.

       EBUSY
              The pages in the source virtual memory range are either
              pinned or not exclusive to the process. The kernel might
              only perform lightweight checks for detecting whether the
              pages are exclusive. To make the operation more likely to
              succeed, KSM should be disabled, fork() should be avoided
              or MADV_DONTFORK should be configured for the source virtual
              memory area before fork().

       ENOMEM Allocating memory needed for the operation failed.

       ESRCH
              The target process has exited at the time of a UFFDIO_MOVE
              operation.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst |   3 +
 fs/userfaultfd.c                             |  72 +++
 include/linux/rmap.h                         |   5 +
 include/linux/userfaultfd_k.h                |  11 +
 include/uapi/linux/userfaultfd.h             |  29 +-
 mm/huge_memory.c                             | 122 ++++
 mm/khugepaged.c                              |   3 +
 mm/rmap.c                                    |   6 +
 mm/userfaultfd.c                             | 614 +++++++++++++++++++
 9 files changed, 864 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/a=
dmin-guide/mm/userfaultfd.rst
index 203e26da5f92..e5cc8848dcb3 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -113,6 +113,9 @@ events, except page fault notifications, may be generat=
ed:
   areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
   support for shmem virtual memory areas.
=20
+- ``UFFD_FEATURE_MOVE`` indicates that the kernel supports moving an
+  existing page contents from userspace.
+
 The userland application should set the feature flags it intends to use
 when invoking the ``UFFDIO_API`` ioctl, to request that those features be
 enabled if supported.
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e8af40b05549..6e2a4d6a0d8f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2005,6 +2005,75 @@ static inline unsigned int uffd_ctx_features(__u64 u=
ser_features)
 	return (unsigned int)user_features | UFFD_FEATURE_INITIALIZED;
 }
=20
+static int userfaultfd_move(struct userfaultfd_ctx *ctx,
+			    unsigned long arg)
+{
+	__s64 ret;
+	struct uffdio_move uffdio_move;
+	struct uffdio_move __user *user_uffdio_move;
+	struct userfaultfd_wake_range range;
+	struct mm_struct *mm =3D ctx->mm;
+
+	user_uffdio_move =3D (struct uffdio_move __user *) arg;
+
+	if (atomic_read(&ctx->mmap_changing))
+		return -EAGAIN;
+
+	if (copy_from_user(&uffdio_move, user_uffdio_move,
+			   /* don't copy "move" last field */
+			   sizeof(uffdio_move)-sizeof(__s64)))
+		return -EFAULT;
+
+	/* Do not allow cross-mm moves. */
+	if (mm !=3D current->mm)
+		return -EINVAL;
+
+	ret =3D validate_range(mm, uffdio_move.dst, uffdio_move.len);
+	if (ret)
+		return ret;
+
+	ret =3D validate_range(mm, uffdio_move.src, uffdio_move.len);
+	if (ret)
+		return ret;
+
+	if (uffdio_move.mode & ~(UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES|
+				  UFFDIO_MOVE_MODE_DONTWAKE))
+		return -EINVAL;
+
+	if (mmget_not_zero(mm)) {
+		mmap_read_lock(mm);
+
+		/* Re-check after taking mmap_lock */
+		if (likely(!atomic_read(&ctx->mmap_changing)))
+			ret =3D move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
+					 uffdio_move.len, uffdio_move.mode);
+		else
+			ret =3D -EINVAL;
+
+		mmap_read_unlock(mm);
+		mmput(mm);
+	} else {
+		return -ESRCH;
+	}
+
+	if (unlikely(put_user(ret, &user_uffdio_move->move)))
+		return -EFAULT;
+	if (ret < 0)
+		goto out;
+
+	/* len =3D=3D 0 would wake all */
+	VM_WARN_ON(!ret);
+	range.len =3D ret;
+	if (!(uffdio_move.mode & UFFDIO_MOVE_MODE_DONTWAKE)) {
+		range.start =3D uffdio_move.dst;
+		wake_userfault(ctx, &range);
+	}
+	ret =3D range.len =3D=3D uffdio_move.len ? 0 : -EAGAIN;
+
+out:
+	return ret;
+}
+
 /*
  * userland asks for a certain API version and we return which bits
  * and ioctl commands are implemented in this kernel for such API
@@ -2097,6 +2166,9 @@ static long userfaultfd_ioctl(struct file *file, unsi=
gned cmd,
 	case UFFDIO_ZEROPAGE:
 		ret =3D userfaultfd_zeropage(ctx, arg);
 		break;
+	case UFFDIO_MOVE:
+		ret =3D userfaultfd_move(ctx, arg);
+		break;
 	case UFFDIO_WRITEPROTECT:
 		ret =3D userfaultfd_writeprotect(ctx, arg);
 		break;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b26fe858fd44..8034eda972e5 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -121,6 +121,11 @@ static inline void anon_vma_lock_write(struct anon_vma=
 *anon_vma)
 	down_write(&anon_vma->root->rwsem);
 }
=20
+static inline int anon_vma_trylock_write(struct anon_vma *anon_vma)
+{
+	return down_write_trylock(&anon_vma->root->rwsem);
+}
+
 static inline void anon_vma_unlock_write(struct anon_vma *anon_vma)
 {
 	up_write(&anon_vma->root->rwsem);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index f2dc19f40d05..e4056547fbe6 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -93,6 +93,17 @@ extern int mwriteprotect_range(struct mm_struct *dst_mm,
 extern long uffd_wp_range(struct vm_area_struct *vma,
 			  unsigned long start, unsigned long len, bool enable_wp);
=20
+/* move_pages */
+void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
+void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
+ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
+		   unsigned long dst_start, unsigned long src_start,
+		   unsigned long len, __u64 flags);
+int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_p=
md, pmd_t dst_pmdval,
+			struct vm_area_struct *dst_vma,
+			struct vm_area_struct *src_vma,
+			unsigned long dst_addr, unsigned long src_addr);
+
 /* mm helpers */
 static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *=
vma,
 					struct vm_userfaultfd_ctx vm_ctx)
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaul=
tfd.h
index 0dbc81015018..2841e4ea8f2c 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -41,7 +41,8 @@
 			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
 			   UFFD_FEATURE_WP_UNPOPULATED |	\
 			   UFFD_FEATURE_POISON |		\
-			   UFFD_FEATURE_WP_ASYNC)
+			   UFFD_FEATURE_WP_ASYNC |		\
+			   UFFD_FEATURE_MOVE)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -50,6 +51,7 @@
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
+	 (__u64)1 << _UFFDIO_MOVE |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
 	 (__u64)1 << _UFFDIO_POISON)
@@ -73,6 +75,7 @@
 #define _UFFDIO_WAKE			(0x02)
 #define _UFFDIO_COPY			(0x03)
 #define _UFFDIO_ZEROPAGE		(0x04)
+#define _UFFDIO_MOVE			(0x05)
 #define _UFFDIO_WRITEPROTECT		(0x06)
 #define _UFFDIO_CONTINUE		(0x07)
 #define _UFFDIO_POISON			(0x08)
@@ -92,6 +95,8 @@
 				      struct uffdio_copy)
 #define UFFDIO_ZEROPAGE		_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,	\
 				      struct uffdio_zeropage)
+#define UFFDIO_MOVE		_IOWR(UFFDIO, _UFFDIO_MOVE,	\
+				      struct uffdio_move)
 #define UFFDIO_WRITEPROTECT	_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
 				      struct uffdio_writeprotect)
 #define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
@@ -222,6 +227,9 @@ struct uffdio_api {
 	 * asynchronous mode is supported in which the write fault is
 	 * automatically resolved and write-protection is un-set.
 	 * It implies UFFD_FEATURE_WP_UNPOPULATED.
+	 *
+	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an
+	 * existing page contents from userspace.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -239,6 +247,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
 #define UFFD_FEATURE_POISON			(1<<14)
 #define UFFD_FEATURE_WP_ASYNC			(1<<15)
+#define UFFD_FEATURE_MOVE			(1<<16)
 	__u64 features;
=20
 	__u64 ioctls;
@@ -347,6 +356,24 @@ struct uffdio_poison {
 	__s64 updated;
 };
=20
+struct uffdio_move {
+	__u64 dst;
+	__u64 src;
+	__u64 len;
+	/*
+	 * Especially if used to atomically remove memory from the
+	 * address space the wake on the dst range is not needed.
+	 */
+#define UFFDIO_MOVE_MODE_DONTWAKE		((__u64)1<<0)
+#define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES	((__u64)1<<1)
+	__u64 mode;
+	/*
+	 * "move" is written by the ioctl and must be at the end: the
+	 * copy_from_user will not read the last 8 bytes.
+	 */
+	__s64 move;
+};
+
 /*
  * Flags for the userfaultfd(2) system call itself.
  */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f542444a91f..315968db1ca4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1964,6 +1964,128 @@ int change_huge_pmd(struct mmu_gather *tlb, struct =
vm_area_struct *vma,
 	return ret;
 }
=20
+#ifdef CONFIG_USERFAULTFD
+/*
+ * The PT lock for src_pmd and the mmap_lock for reading are held by
+ * the caller, but it must return after releasing the page_table_lock.
+ * Just move the page from src_pmd to dst_pmd if possible.
+ * Return zero if succeeded in moving the page, -EAGAIN if it needs to be
+ * repeated by the caller, or other errors in case of failure.
+ */
+int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_p=
md, pmd_t dst_pmdval,
+			struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+			unsigned long dst_addr, unsigned long src_addr)
+{
+	pmd_t _dst_pmd, src_pmdval;
+	struct page *src_page;
+	struct folio *src_folio;
+	struct anon_vma *src_anon_vma;
+	spinlock_t *src_ptl, *dst_ptl;
+	pgtable_t src_pgtable;
+	struct mmu_notifier_range range;
+	int err =3D 0;
+
+	src_pmdval =3D *src_pmd;
+	src_ptl =3D pmd_lockptr(mm, src_pmd);
+
+	lockdep_assert_held(src_ptl);
+	mmap_assert_locked(mm);
+
+	/* Sanity checks before the operation */
+	if (WARN_ON_ONCE(!pmd_none(dst_pmdval)) || WARN_ON_ONCE(src_addr & ~HPAGE=
_PMD_MASK) ||
+	    WARN_ON_ONCE(dst_addr & ~HPAGE_PMD_MASK)) {
+		spin_unlock(src_ptl);
+		return -EINVAL;
+	}
+
+	if (!pmd_trans_huge(src_pmdval)) {
+		spin_unlock(src_ptl);
+		if (is_pmd_migration_entry(src_pmdval)) {
+			pmd_migration_entry_wait(mm, &src_pmdval);
+			return -EAGAIN;
+		}
+		return -ENOENT;
+	}
+
+	src_page =3D pmd_page(src_pmdval);
+	if (unlikely(!PageAnonExclusive(src_page))) {
+		spin_unlock(src_ptl);
+		return -EBUSY;
+	}
+
+	src_folio =3D page_folio(src_page);
+	folio_get(src_folio);
+	spin_unlock(src_ptl);
+
+	flush_cache_range(src_vma, src_addr, src_addr + HPAGE_PMD_SIZE);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, src_addr,
+				src_addr + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	folio_lock(src_folio);
+
+	/*
+	 * split_huge_page walks the anon_vma chain without the page
+	 * lock. Serialize against it with the anon_vma lock, the page
+	 * lock is not enough.
+	 */
+	src_anon_vma =3D folio_get_anon_vma(src_folio);
+	if (!src_anon_vma) {
+		err =3D -EAGAIN;
+		goto unlock_folio;
+	}
+	anon_vma_lock_write(src_anon_vma);
+
+	dst_ptl =3D pmd_lockptr(mm, dst_pmd);
+	double_pt_lock(src_ptl, dst_ptl);
+	if (unlikely(!pmd_same(*src_pmd, src_pmdval) ||
+		     !pmd_same(*dst_pmd, dst_pmdval))) {
+		err =3D -EAGAIN;
+		goto unlock_ptls;
+	}
+	if (folio_maybe_dma_pinned(src_folio) ||
+	    !PageAnonExclusive(&src_folio->page)) {
+		err =3D -EBUSY;
+		goto unlock_ptls;
+	}
+
+	if (WARN_ON_ONCE(!folio_test_head(src_folio)) ||
+	    WARN_ON_ONCE(!folio_test_anon(src_folio))) {
+		err =3D -EBUSY;
+		goto unlock_ptls;
+	}
+
+	folio_move_anon_rmap(src_folio, dst_vma);
+	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+
+	src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
+	/* Folio got pinned from under us. Put it back and fail the move. */
+	if (folio_maybe_dma_pinned(src_folio)) {
+		set_pmd_at(mm, src_addr, src_pmd, src_pmdval);
+		err =3D -EBUSY;
+		goto unlock_ptls;
+	}
+
+	_dst_pmd =3D mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
+	/* Follow mremap() behavior and treat the entry dirty after the move */
+	_dst_pmd =3D pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
+	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
+
+	src_pgtable =3D pgtable_trans_huge_withdraw(mm, src_pmd);
+	pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
+unlock_ptls:
+	double_pt_unlock(src_ptl, dst_ptl);
+	anon_vma_unlock_write(src_anon_vma);
+	put_anon_vma(src_anon_vma);
+unlock_folio:
+	/* unblock rmap walks */
+	folio_unlock(src_folio);
+	mmu_notifier_invalidate_range_end(&range);
+	folio_put(src_folio);
+	return err;
+}
+#endif /* CONFIG_USERFAULTFD */
+
 /*
  * Returns page table lock pointer if a given pmd maps a thp, NULL otherwi=
se.
  *
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 064654717843..0da6937572cf 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1139,6 +1139,9 @@ static int collapse_huge_page(struct mm_struct *mm, u=
nsigned long address,
 	 * Prevent all access to pagetables with the exception of
 	 * gup_fast later handled by the ptep_clear_flush and the VM
 	 * handled by the anon_vma lock + PG_lock.
+	 *
+	 * UFFDIO_MOVE is prevented to race as well thanks to the
+	 * mmap_lock.
 	 */
 	mmap_write_lock(mm);
 	result =3D hugepage_vma_revalidate(mm, address, true, &vma, cc);
diff --git a/mm/rmap.c b/mm/rmap.c
index 525c5bc0b0b3..de9426ad0f1b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -490,6 +490,12 @@ void __init anon_vma_init(void)
  * page_remove_rmap() that the anon_vma pointer from page->mapping is vali=
d
  * if there is a mapcount, we can dereference the anon_vma after observing
  * those.
+ *
+ * NOTE: the caller should normally hold folio lock when calling this.  If
+ * not, the caller needs to double check the anon_vma didn't change after
+ * taking the anon_vma lock for either read or write (UFFDIO_MOVE can modi=
fy it
+ * concurrently without folio lock protection). See folio_lock_anon_vma_re=
ad()
+ * which has already covered that, and comment above remap_pages().
  */
 struct anon_vma *folio_get_anon_vma(struct folio *folio)
 {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0b6ca553bebe..9ec814e47e99 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -842,3 +842,617 @@ int mwriteprotect_range(struct mm_struct *dst_mm, uns=
igned long start,
 	mmap_read_unlock(dst_mm);
 	return err;
 }
+
+
+void double_pt_lock(spinlock_t *ptl1,
+		    spinlock_t *ptl2)
+	__acquires(ptl1)
+	__acquires(ptl2)
+{
+	spinlock_t *ptl_tmp;
+
+	if (ptl1 > ptl2) {
+		/* exchange ptl1 and ptl2 */
+		ptl_tmp =3D ptl1;
+		ptl1 =3D ptl2;
+		ptl2 =3D ptl_tmp;
+	}
+	/* lock in virtual address order to avoid lock inversion */
+	spin_lock(ptl1);
+	if (ptl1 !=3D ptl2)
+		spin_lock_nested(ptl2, SINGLE_DEPTH_NESTING);
+	else
+		__acquire(ptl2);
+}
+
+void double_pt_unlock(spinlock_t *ptl1,
+		      spinlock_t *ptl2)
+	__releases(ptl1)
+	__releases(ptl2)
+{
+	spin_unlock(ptl1);
+	if (ptl1 !=3D ptl2)
+		spin_unlock(ptl2);
+	else
+		__release(ptl2);
+}
+
+
+static int move_present_pte(struct mm_struct *mm,
+			    struct vm_area_struct *dst_vma,
+			    struct vm_area_struct *src_vma,
+			    unsigned long dst_addr, unsigned long src_addr,
+			    pte_t *dst_pte, pte_t *src_pte,
+			    pte_t orig_dst_pte, pte_t orig_src_pte,
+			    spinlock_t *dst_ptl, spinlock_t *src_ptl,
+			    struct folio *src_folio)
+{
+	int err =3D 0;
+
+	double_pt_lock(dst_ptl, src_ptl);
+
+	if (!pte_same(*src_pte, orig_src_pte) ||
+	    !pte_same(*dst_pte, orig_dst_pte)) {
+		err =3D -EAGAIN;
+		goto out;
+	}
+	if (folio_test_large(src_folio) ||
+	    folio_maybe_dma_pinned(src_folio) ||
+	    !PageAnonExclusive(&src_folio->page)) {
+		err =3D -EBUSY;
+		goto out;
+	}
+
+	folio_move_anon_rmap(src_folio, dst_vma);
+	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+
+	orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte);
+	/* Folio got pinned from under us. Put it back and fail the move. */
+	if (folio_maybe_dma_pinned(src_folio)) {
+		set_pte_at(mm, src_addr, src_pte, orig_src_pte);
+		err =3D -EBUSY;
+		goto out;
+	}
+
+	orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_page_prot);
+	/* Follow mremap() behavior and treat the entry dirty after the move */
+	orig_dst_pte =3D pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
+
+	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
+out:
+	double_pt_unlock(dst_ptl, src_ptl);
+	return err;
+}
+
+static int move_swap_pte(struct mm_struct *mm,
+			 unsigned long dst_addr, unsigned long src_addr,
+			 pte_t *dst_pte, pte_t *src_pte,
+			 pte_t orig_dst_pte, pte_t orig_src_pte,
+			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
+{
+	if (!pte_swp_exclusive(orig_src_pte))
+		return -EBUSY;
+
+	double_pt_lock(dst_ptl, src_ptl);
+
+	if (!pte_same(*src_pte, orig_src_pte) ||
+	    !pte_same(*dst_pte, orig_dst_pte)) {
+		double_pt_unlock(dst_ptl, src_ptl);
+		return -EAGAIN;
+	}
+
+	orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
+	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
+	double_pt_unlock(dst_ptl, src_ptl);
+
+	return 0;
+}
+
+/*
+ * The mmap_lock for reading is held by the caller. Just move the page
+ * from src_pmd to dst_pmd if possible, and return true if succeeded
+ * in moving the page.
+ */
+static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src=
_pmd,
+			  struct vm_area_struct *dst_vma,
+			  struct vm_area_struct *src_vma,
+			  unsigned long dst_addr, unsigned long src_addr,
+			  __u64 mode)
+{
+	swp_entry_t entry;
+	pte_t orig_src_pte, orig_dst_pte;
+	pte_t src_folio_pte;
+	spinlock_t *src_ptl, *dst_ptl;
+	pte_t *src_pte =3D NULL;
+	pte_t *dst_pte =3D NULL;
+
+	struct folio *src_folio =3D NULL;
+	struct anon_vma *src_anon_vma =3D NULL;
+	struct mmu_notifier_range range;
+	int err =3D 0;
+
+	flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
+				src_addr, src_addr + PAGE_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+retry:
+	dst_pte =3D pte_offset_map_nolock(mm, dst_pmd, dst_addr, &dst_ptl);
+
+	/* Retry if a huge pmd materialized from under us */
+	if (unlikely(!dst_pte)) {
+		err =3D -EAGAIN;
+		goto out;
+	}
+
+	src_pte =3D pte_offset_map_nolock(mm, src_pmd, src_addr, &src_ptl);
+
+	/*
+	 * We held the mmap_lock for reading so MADV_DONTNEED
+	 * can zap transparent huge pages under us, or the
+	 * transparent huge page fault can establish new
+	 * transparent huge pages under us.
+	 */
+	if (unlikely(!src_pte)) {
+		err =3D -EAGAIN;
+		goto out;
+	}
+
+	/* Sanity checks before the operation */
+	if (WARN_ON_ONCE(pmd_none(*dst_pmd)) ||	WARN_ON_ONCE(pmd_none(*src_pmd)) =
||
+	    WARN_ON_ONCE(pmd_trans_huge(*dst_pmd)) || WARN_ON_ONCE(pmd_trans_huge=
(*src_pmd))) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	spin_lock(dst_ptl);
+	orig_dst_pte =3D *dst_pte;
+	spin_unlock(dst_ptl);
+	if (!pte_none(orig_dst_pte)) {
+		err =3D -EEXIST;
+		goto out;
+	}
+
+	spin_lock(src_ptl);
+	orig_src_pte =3D *src_pte;
+	spin_unlock(src_ptl);
+	if (pte_none(orig_src_pte)) {
+		if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
+			err =3D -ENOENT;
+		else /* nothing to do to move a hole */
+			err =3D 0;
+		goto out;
+	}
+
+	/* If PTE changed after we locked the folio them start over */
+	if (src_folio && unlikely(!pte_same(src_folio_pte, orig_src_pte))) {
+		err =3D -EAGAIN;
+		goto out;
+	}
+
+	if (pte_present(orig_src_pte)) {
+		/*
+		 * Pin and lock both source folio and anon_vma. Since we are in
+		 * RCU read section, we can't block, so on contention have to
+		 * unmap the ptes, obtain the lock and retry.
+		 */
+		if (!src_folio) {
+			struct folio *folio;
+
+			/*
+			 * Pin the page while holding the lock to be sure the
+			 * page isn't freed under us
+			 */
+			spin_lock(src_ptl);
+			if (!pte_same(orig_src_pte, *src_pte)) {
+				spin_unlock(src_ptl);
+				err =3D -EAGAIN;
+				goto out;
+			}
+
+			folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
+			if (!folio || !PageAnonExclusive(&folio->page)) {
+				spin_unlock(src_ptl);
+				err =3D -EBUSY;
+				goto out;
+			}
+
+			folio_get(folio);
+			src_folio =3D folio;
+			src_folio_pte =3D orig_src_pte;
+			spin_unlock(src_ptl);
+
+			if (!folio_trylock(src_folio)) {
+				pte_unmap(&orig_src_pte);
+				pte_unmap(&orig_dst_pte);
+				src_pte =3D dst_pte =3D NULL;
+				/* now we can block and wait */
+				folio_lock(src_folio);
+				goto retry;
+			}
+
+			if (WARN_ON_ONCE(!folio_test_anon(src_folio))) {
+				err =3D -EBUSY;
+				goto out;
+			}
+		}
+
+		/* at this point we have src_folio locked */
+		if (folio_test_large(src_folio)) {
+			err =3D split_folio(src_folio);
+			if (err)
+				goto out;
+		}
+
+		if (!src_anon_vma) {
+			/*
+			 * folio_referenced walks the anon_vma chain
+			 * without the folio lock. Serialize against it with
+			 * the anon_vma lock, the folio lock is not enough.
+			 */
+			src_anon_vma =3D folio_get_anon_vma(src_folio);
+			if (!src_anon_vma) {
+				/* page was unmapped from under us */
+				err =3D -EAGAIN;
+				goto out;
+			}
+			if (!anon_vma_trylock_write(src_anon_vma)) {
+				pte_unmap(&orig_src_pte);
+				pte_unmap(&orig_dst_pte);
+				src_pte =3D dst_pte =3D NULL;
+				/* now we can block and wait */
+				anon_vma_lock_write(src_anon_vma);
+				goto retry;
+			}
+		}
+
+		err =3D move_present_pte(mm,  dst_vma, src_vma,
+				       dst_addr, src_addr, dst_pte, src_pte,
+				       orig_dst_pte, orig_src_pte,
+				       dst_ptl, src_ptl, src_folio);
+	} else {
+		entry =3D pte_to_swp_entry(orig_src_pte);
+		if (non_swap_entry(entry)) {
+			if (is_migration_entry(entry)) {
+				pte_unmap(&orig_src_pte);
+				pte_unmap(&orig_dst_pte);
+				src_pte =3D dst_pte =3D NULL;
+				migration_entry_wait(mm, src_pmd, src_addr);
+				err =3D -EAGAIN;
+			} else
+				err =3D -EFAULT;
+			goto out;
+		}
+
+		err =3D move_swap_pte(mm, dst_addr, src_addr,
+				    dst_pte, src_pte,
+				    orig_dst_pte, orig_src_pte,
+				    dst_ptl, src_ptl);
+	}
+
+out:
+	if (src_anon_vma) {
+		anon_vma_unlock_write(src_anon_vma);
+		put_anon_vma(src_anon_vma);
+	}
+	if (src_folio) {
+		folio_unlock(src_folio);
+		folio_put(src_folio);
+	}
+	if (dst_pte)
+		pte_unmap(dst_pte);
+	if (src_pte)
+		pte_unmap(src_pte);
+	mmu_notifier_invalidate_range_end(&range);
+
+	return err;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline bool move_splits_huge_pmd(unsigned long dst_addr,
+					unsigned long src_addr,
+					unsigned long src_end)
+{
+	return (src_addr & ~HPAGE_PMD_MASK) || (dst_addr & ~HPAGE_PMD_MASK) ||
+		src_end - src_addr < HPAGE_PMD_SIZE;
+}
+#else
+static inline bool move_splits_huge_pmd(unsigned long dst_addr,
+					unsigned long src_addr,
+					unsigned long src_end)
+{
+	/* This is unreachable anyway, just to avoid warnings when HPAGE_PMD_SIZE=
=3D=3D0 */
+	return false;
+}
+#endif
+
+static inline bool vma_move_compatible(struct vm_area_struct *vma)
+{
+	return !(vma->vm_flags & (VM_PFNMAP | VM_IO |  VM_HUGETLB |
+				  VM_MIXEDMAP | VM_SHADOW_STACK));
+}
+
+static int validate_move_areas(struct userfaultfd_ctx *ctx,
+			       struct vm_area_struct *src_vma,
+			       struct vm_area_struct *dst_vma)
+{
+	/* Only allow moving if both have the same access and protection */
+	if ((src_vma->vm_flags & VM_ACCESS_FLAGS) !=3D (dst_vma->vm_flags & VM_AC=
CESS_FLAGS) ||
+	    pgprot_val(src_vma->vm_page_prot) !=3D pgprot_val(dst_vma->vm_page_pr=
ot))
+		return -EINVAL;
+
+	/* Only allow moving if both are mlocked or both aren't */
+	if ((src_vma->vm_flags & VM_LOCKED) !=3D (dst_vma->vm_flags & VM_LOCKED))
+		return -EINVAL;
+
+	/*
+	 * For now, we keep it simple and only move between writable VMAs.
+	 * Access flags are equal, therefore cheching only the source is enough.
+	 */
+	if (!(src_vma->vm_flags & VM_WRITE))
+		return -EINVAL;
+
+	/* Check if vma flags indicate content which can be moved */
+	if (!vma_move_compatible(src_vma) || !vma_move_compatible(dst_vma))
+		return -EINVAL;
+
+	/* Ensure dst_vma is registered in uffd we are operating on */
+	if (!dst_vma->vm_userfaultfd_ctx.ctx ||
+	    dst_vma->vm_userfaultfd_ctx.ctx !=3D ctx)
+		return -EINVAL;
+
+	/* Only allow moving across anonymous vmas */
+	if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
+		return -EINVAL;
+
+	/*
+	 * Ensure the dst_vma has a anon_vma or this page
+	 * would get a NULL anon_vma when moved in the
+	 * dst_vma.
+	 */
+	if (unlikely(anon_vma_prepare(dst_vma)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * move_pages - move arbitrary anonymous pages of an existing vma
+ * @ctx: pointer to the userfaultfd context
+ * @mm: the address space to move pages
+ * @dst_start: start of the destination virtual memory range
+ * @src_start: start of the source virtual memory range
+ * @len: length of the virtual memory range
+ * @mode: flags from uffdio_move.mode
+ *
+ * Must be called with mmap_lock held for read.
+ *
+ * move_pages() remaps arbitrary anonymous pages atomically in zero
+ * copy. It only works on non shared anonymous pages because those can
+ * be relocated without generating non linear anon_vmas in the rmap
+ * code.
+ *
+ * It provides a zero copy mechanism to handle userspace page faults.
+ * The source vma pages should have mapcount =3D=3D 1, which can be
+ * enforced by using madvise(MADV_DONTFORK) on src vma.
+ *
+ * The thread receiving the page during the userland page fault
+ * will receive the faulting page in the source vma through the network,
+ * storage or any other I/O device (MADV_DONTFORK in the source vma
+ * avoids move_pages() to fail with -EBUSY if the process forks before
+ * move_pages() is called), then it will call move_pages() to map the
+ * page in the faulting address in the destination vma.
+ *
+ * This userfaultfd command works purely via pagetables, so it's the
+ * most efficient way to move physical non shared anonymous pages
+ * across different virtual addresses. Unlike mremap()/mmap()/munmap()
+ * it does not create any new vmas. The mapping in the destination
+ * address is atomic.
+ *
+ * It only works if the vma protection bits are identical from the
+ * source and destination vma.
+ *
+ * It can remap non shared anonymous pages within the same vma too.
+ *
+ * If the source virtual memory range has any unmapped holes, or if
+ * the destination virtual memory range is not a whole unmapped hole,
+ * move_pages() will fail respectively with -ENOENT or -EEXIST. This
+ * provides a very strict behavior to avoid any chance of memory
+ * corruption going unnoticed if there are userland race conditions.
+ * Only one thread should resolve the userland page fault at any given
+ * time for any given faulting address. This means that if two threads
+ * try to both call move_pages() on the same destination address at the
+ * same time, the second thread will get an explicit error from this
+ * command.
+ *
+ * The command retval will return "len" is successful. The command
+ * however can be interrupted by fatal signals or errors. If
+ * interrupted it will return the number of bytes successfully
+ * remapped before the interruption if any, or the negative error if
+ * none. It will never return zero. Either it will return an error or
+ * an amount of bytes successfully moved. If the retval reports a
+ * "short" remap, the move_pages() command should be repeated by
+ * userland with src+retval, dst+reval, len-retval if it wants to know
+ * about the error that interrupted it.
+ *
+ * The UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES flag can be specified to
+ * prevent -ENOENT errors to materialize if there are holes in the
+ * source virtual range that is being remapped. The holes will be
+ * accounted as successfully remapped in the retval of the
+ * command. This is mostly useful to remap hugepage naturally aligned
+ * virtual regions without knowing if there are transparent hugepage
+ * in the regions or not, but preventing the risk of having to split
+ * the hugepmd during the remap.
+ *
+ * If there's any rmap walk that is taking the anon_vma locks without
+ * first obtaining the folio lock (the only current instance is
+ * folio_referenced), they will have to verify if the folio->mapping
+ * has changed after taking the anon_vma lock. If it changed they
+ * should release the lock and retry obtaining a new anon_vma, because
+ * it means the anon_vma was changed by move_pages() before the lock
+ * could be obtained. This is the only additional complexity added to
+ * the rmap code to provide this anonymous page remapping functionality.
+ */
+ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
+		   unsigned long dst_start, unsigned long src_start,
+		   unsigned long len, __u64 mode)
+{
+	struct vm_area_struct *src_vma, *dst_vma;
+	unsigned long src_addr, dst_addr;
+	pmd_t *src_pmd, *dst_pmd;
+	long err =3D -EINVAL;
+	ssize_t moved =3D 0;
+
+	/* Sanitize the command parameters. */
+	if (WARN_ON_ONCE(src_start & ~PAGE_MASK) ||
+	    WARN_ON_ONCE(dst_start & ~PAGE_MASK) ||
+	    WARN_ON_ONCE(len & ~PAGE_MASK))
+		goto out;
+
+	/* Does the address range wrap, or is the span zero-sized? */
+	if (WARN_ON_ONCE(src_start + len <=3D src_start) ||
+	    WARN_ON_ONCE(dst_start + len <=3D dst_start))
+		goto out;
+
+	/*
+	 * Make sure the vma is not shared, that the src and dst remap
+	 * ranges are both valid and fully within a single existing
+	 * vma.
+	 */
+	src_vma =3D find_vma(mm, src_start);
+	if (!src_vma || (src_vma->vm_flags & VM_SHARED))
+		goto out;
+	if (src_start < src_vma->vm_start ||
+	    src_start + len > src_vma->vm_end)
+		goto out;
+
+	dst_vma =3D find_vma(mm, dst_start);
+	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
+		goto out;
+	if (dst_start < dst_vma->vm_start ||
+	    dst_start + len > dst_vma->vm_end)
+		goto out;
+
+	err =3D validate_move_areas(ctx, src_vma, dst_vma);
+	if (err)
+		goto out;
+
+	for (src_addr =3D src_start, dst_addr =3D dst_start;
+	     src_addr < src_start + len;) {
+		spinlock_t *ptl;
+		pmd_t dst_pmdval;
+		unsigned long step_size;
+
+		/*
+		 * Below works because anonymous area would not have a
+		 * transparent huge PUD. If file-backed support is added,
+		 * that case would need to be handled here.
+		 */
+		src_pmd =3D mm_find_pmd(mm, src_addr);
+		if (unlikely(!src_pmd)) {
+			if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
+				err =3D -ENOENT;
+				break;
+			}
+			src_pmd =3D mm_alloc_pmd(mm, src_addr);
+			if (unlikely(!src_pmd)) {
+				err =3D -ENOMEM;
+				break;
+			}
+		}
+		dst_pmd =3D mm_alloc_pmd(mm, dst_addr);
+		if (unlikely(!dst_pmd)) {
+			err =3D -ENOMEM;
+			break;
+		}
+
+		dst_pmdval =3D pmdp_get_lockless(dst_pmd);
+		/*
+		 * If the dst_pmd is mapped as THP don't override it and just
+		 * be strict. If dst_pmd changes into TPH after this check, the
+		 * move_pages_huge_pmd() will detect the change and retry
+		 * while move_pages_pte() will detect the change and fail.
+		 */
+		if (unlikely(pmd_trans_huge(dst_pmdval))) {
+			err =3D -EEXIST;
+			break;
+		}
+
+		ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
+		if (ptl) {
+			if (pmd_devmap(*src_pmd)) {
+				spin_unlock(ptl);
+				err =3D -ENOENT;
+				break;
+			}
+
+			/* Check if we can move the pmd without splitting it. */
+			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
+			    !pmd_none(dst_pmdval)) {
+				struct folio *folio =3D pfn_folio(pmd_pfn(*src_pmd));
+
+				if (!folio || !PageAnonExclusive(&folio->page)) {
+					spin_unlock(ptl);
+					err =3D -EBUSY;
+					break;
+				}
+
+				spin_unlock(ptl);
+				split_huge_pmd(src_vma, src_pmd, src_addr);
+				/* The folio will be split by move_pages_pte() */
+				continue;
+			}
+
+			err =3D move_pages_huge_pmd(mm, dst_pmd, src_pmd,
+						  dst_pmdval, dst_vma, src_vma,
+						  dst_addr, src_addr);
+			step_size =3D HPAGE_PMD_SIZE;
+		} else {
+			if (pmd_none(*src_pmd)) {
+				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
+					err =3D -ENOENT;
+					break;
+				}
+				if (unlikely(__pte_alloc(mm, src_pmd))) {
+					err =3D -ENOMEM;
+					break;
+				}
+			}
+
+			if (unlikely(pte_alloc(mm, dst_pmd))) {
+				err =3D -ENOMEM;
+				break;
+			}
+
+			err =3D move_pages_pte(mm, dst_pmd, src_pmd,
+					     dst_vma, src_vma,
+					     dst_addr, src_addr, mode);
+			step_size =3D PAGE_SIZE;
+		}
+
+		cond_resched();
+
+		if (fatal_signal_pending(current)) {
+			/* Do not override an error */
+			if (!err || err =3D=3D -EAGAIN)
+				err =3D -EINTR;
+			break;
+		}
+
+		if (err) {
+			if (err =3D=3D -EAGAIN)
+				continue;
+			break;
+		}
+
+		/* Proceed to the next page */
+		dst_addr +=3D step_size;
+		src_addr +=3D step_size;
+		moved +=3D step_size;
+	}
+
+out:
+	VM_WARN_ON(moved < 0);
+	VM_WARN_ON(err > 0);
+	VM_WARN_ON(!moved && !err);
+	return moved ? moved : err;
+}
--=20
2.43.0.rc2.451.g8631bc7472-goog


