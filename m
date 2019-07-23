Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC73F71E79
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2019 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391268AbfGWR7V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jul 2019 13:59:21 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:52843 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391261AbfGWR7U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jul 2019 13:59:20 -0400
Received: by mail-qk1-f202.google.com with SMTP id r200so37149294qke.19
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2019 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AkbJvDAOuVzgBhtZb883Z6kAaHzqiKQW54Ip7ZSyDSQ=;
        b=q4SIjzbblqeI44AwtclbDFRtQ9wdJy9gPXjSP5D6CdGec7GwqRgc0qKMP+S9kknKlU
         82fY8UfjDM6LghjHC28q6xcrb5XyIrOY2+w3WNydAgovI5kIS1vpjE5ULtrqoDRfxPtv
         zexvQyPzU4/fT0I0rupHVHVtbPsNH+ejeSr+2n5DT43Fq4f+3Y34+AINUwgLVB/IpeWl
         2qiXbpB8hAKqk1Ls/rzeOI5t8QaLZwI3CzXqXR93GSUwR46IrtzAa49DUYYvDSaVfKfg
         X0K4wZzWqZQQjEWjIdDvveS7FBsn9qKvSIsR6zka2FAuEw6n9xebOF/L+bYdctZFTEvn
         BIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AkbJvDAOuVzgBhtZb883Z6kAaHzqiKQW54Ip7ZSyDSQ=;
        b=e7SqqbMWZLKv6SDFSkIvkskiBujJnLtcAqHY3hCZRV2mgj1G0/oxrjIYXNjE6LssVg
         aJmlbSm5OADHvfCGh5BW9oAZN6arpa5ETv9tOfWn1cqxeBFj4zUzjxA4XDRgIRVFBEA6
         vSW8I1ybTGU0OJlnT4ipwaFAU7VBXQoGUUSAVVL5xEP5gqZCSZgbSgYX9BnjucZVrRk+
         /Vd8WORcRa6vP+xYokZSg+haOQGdxB9C5oqPIC1GOQ+WF9MpMOCE1AOfSm7eHzhG2rNM
         KBOfRR3SPNNkfD3bebu5EWmHh7CvKtZIkiVMvCKHhPQfQUgwG9jiWq2q/gc5qj6iy3XP
         xZ+g==
X-Gm-Message-State: APjAAAWzvMt/Qianswz/57m+8yQgWXoEZH3PI5Eulwn/rwO3G2gxMiJ+
        Xv6S9YZ3lKZ0+CS7aGGVMtphiraFsvh4sdk2
X-Google-Smtp-Source: APXvYqyEBnxjs/QWPPehEo5rVljMjvkTMucPtveM7x8Do5mUgC0Wj7RnkMWK4mXW3q6nZowCoKSh8LTGEiBYy9qe
X-Received: by 2002:a37:4914:: with SMTP id w20mr50637396qka.156.1563904758910;
 Tue, 23 Jul 2019 10:59:18 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:58:41 +0200
In-Reply-To: <cover.1563904656.git.andreyknvl@google.com>
Message-Id: <aaf0c0969d46b2feb9017f3e1b3ef3970b633d91.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v19 04/15] mm: untag user pointers passed to memory syscalls
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch is a part of a series that extends kernel ABI to allow to pass
tagged user pointers (with the top byte set to something else other than
0x00) as syscall arguments.

This patch allows tagged pointers to be passed to the following memory
syscalls: get_mempolicy, madvise, mbind, mincore, mlock, mlock2, mprotect,
mremap, msync, munlock, move_pages.

The mmap and mremap syscalls do not currently accept tagged addresses.
Architectures may interpret the tag as a background colour for the
corresponding vma.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/madvise.c   | 2 ++
 mm/mempolicy.c | 3 +++
 mm/migrate.c   | 2 +-
 mm/mincore.c   | 2 ++
 mm/mlock.c     | 4 ++++
 mm/mprotect.c  | 2 ++
 mm/mremap.c    | 7 +++++++
 mm/msync.c     | 2 ++
 8 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 968df3aa069f..4b102a61bfbf 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -810,6 +810,8 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	size_t len;
 	struct blk_plug plug;
 
+	start = untagged_addr(start);
+
 	if (!madvise_behavior_valid(behavior))
 		return error;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f48693f75b37..74c134d0c84e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1360,6 +1360,7 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	int err;
 	unsigned short mode_flags;
 
+	start = untagged_addr(start);
 	mode_flags = mode & MPOL_MODE_FLAGS;
 	mode &= ~MPOL_MODE_FLAGS;
 	if (mode >= MPOL_MAX)
@@ -1517,6 +1518,8 @@ static int kernel_get_mempolicy(int __user *policy,
 	int uninitialized_var(pval);
 	nodemask_t nodes;
 
+	addr = untagged_addr(addr);
+
 	if (nmask != NULL && maxnode < nr_node_ids)
 		return -EINVAL;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 8992741f10aa..8f59c24cb141 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1609,7 +1609,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			goto out_flush;
 		if (get_user(node, nodes + i))
 			goto out_flush;
-		addr = (unsigned long)p;
+		addr = (unsigned long)untagged_addr(p);
 
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
diff --git a/mm/mincore.c b/mm/mincore.c
index 4fe91d497436..3cfa120ba0eb 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -257,6 +257,8 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
 	unsigned long pages;
 	unsigned char *tmp;
 
+	start = untagged_addr(start);
+
 	/* Check the start address: needs to be page-aligned.. */
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
diff --git a/mm/mlock.c b/mm/mlock.c
index a90099da4fb4..a72c1eeded77 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -674,6 +674,8 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	unsigned long lock_limit;
 	int error = -ENOMEM;
 
+	start = untagged_addr(start);
+
 	if (!can_do_mlock())
 		return -EPERM;
 
@@ -735,6 +737,8 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 {
 	int ret;
 
+	start = untagged_addr(start);
+
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index bf38dfbbb4b4..19f981b733bc 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -465,6 +465,8 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	const bool rier = (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 
+	start = untagged_addr(start);
+
 	prot &= ~(PROT_GROWSDOWN|PROT_GROWSUP);
 	if (grows == (PROT_GROWSDOWN|PROT_GROWSUP)) /* can't be both */
 		return -EINVAL;
diff --git a/mm/mremap.c b/mm/mremap.c
index fc241d23cd97..64c9a3b8be0a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -606,6 +606,13 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
 
+	/*
+	 * Architectures may interpret the tag passed to mmap as a background
+	 * colour for the corresponding vma. For mremap we don't allow tagged
+	 * new_addr to preserve similar behaviour to mmap.
+	 */
+	addr = untagged_addr(addr);
+
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		return ret;
 
diff --git a/mm/msync.c b/mm/msync.c
index ef30a429623a..c3bd3e75f687 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -37,6 +37,8 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 	int unmapped_error = 0;
 	int error = -EINVAL;
 
+	start = untagged_addr(start);
+
 	if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
 		goto out;
 	if (offset_in_page(start))
-- 
2.22.0.709.g102302147b-goog

