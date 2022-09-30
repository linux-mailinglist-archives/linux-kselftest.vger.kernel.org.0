Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924515F0D57
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiI3OVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 10:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiI3OUk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 10:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC411730C5
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664547634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYManVlpCvt6iYiv3mntijvloAa1rW/lzIzdVimSiKE=;
        b=JTzJoDQqs4PlJXMuoarUXx8vYGSWUunWePDdnNEMrqWSFRXgjVt2rd44sEPHMy8tkIBhxu
        75ebUq20rQhXq4hHPcwEitPNQxzQjAWHvqewZSXL9ztjUGpl7CC7JBcrKErCMYwjrRlFFe
        uv5RgWc8iH2l8gr4roOX1Vbsb7b+SYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-QCmRDKFMPtK1hafPaPCFGA-1; Fri, 30 Sep 2022 10:20:31 -0400
X-MC-Unique: QCmRDKFMPtK1hafPaPCFGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31D02101A52A;
        Fri, 30 Sep 2022 14:20:30 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 691AE112132E;
        Fri, 30 Sep 2022 14:20:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v1 4/7] mm/ksm: fix KSM COW breaking with userfaultfd-wp via FAULT_FLAG_UNSHARE
Date:   Fri, 30 Sep 2022 16:19:28 +0200
Message-Id: <20220930141931.174362-5-david@redhat.com>
In-Reply-To: <20220930141931.174362-1-david@redhat.com>
References: <20220930141931.174362-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's stop breaking COW via a fake write fault and let's use
FAULT_FLAG_UNSHARE instead. This avoids any wrong side effects of the fake
write fault, such as mapping the PTE writable and marking the pte
dirty/softdirty.

Also, this fixes KSM interaction with userfaultfd-wp: when we have a KSM
page that's write-protected by userfaultfd, break_ksm()->handle_mm_fault()
will fail with VM_FAULT_SIGBUS and will simpy return in break_ksm() with 0.
The warning in dmesg indicates this wrong handling:

[  230.096368] FAULT_FLAG_ALLOW_RETRY missing 881
[  230.100822] CPU: 1 PID: 1643 Comm: ksm-uffd-wp [...]
[  230.110124] Hardware name: [...]
[  230.117775] Call Trace:
[  230.120227]  <TASK>
[  230.122334]  dump_stack_lvl+0x44/0x5c
[  230.126010]  handle_userfault.cold+0x14/0x19
[  230.130281]  ? tlb_finish_mmu+0x65/0x170
[  230.134207]  ? uffd_wp_range+0x65/0xa0
[  230.137959]  ? _raw_spin_unlock+0x15/0x30
[  230.141972]  ? do_wp_page+0x50/0x590
[  230.145551]  __handle_mm_fault+0x9f5/0xf50
[  230.149652]  ? mmput+0x1f/0x40
[  230.152712]  handle_mm_fault+0xb9/0x2a0
[  230.156550]  break_ksm+0x141/0x180
[  230.159964]  unmerge_ksm_pages+0x60/0x90
[  230.163890]  ksm_madvise+0x3c/0xb0
[  230.167295]  do_madvise.part.0+0x10c/0xeb0
[  230.171396]  ? do_syscall_64+0x67/0x80
[  230.175157]  __x64_sys_madvise+0x5a/0x70
[  230.179082]  do_syscall_64+0x58/0x80
[  230.182661]  ? do_syscall_64+0x67/0x80
[  230.186413]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

--------------------------------------------------------------------------

 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
 #include <sys/mman.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
 #include <linux/userfaultfd.h>

 #define MMAP_SIZE (2 * 1024 * 1024u)

 static char *map;
 int uffd;

 static int setup_uffd(void)
 {
 	struct uffdio_api uffdio_api;
 	struct uffdio_register uffdio_register;
 	struct uffdio_writeprotect uffd_writeprotect;
 	struct uffdio_range uffd_range;

 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
 	if (uffd < 0) {
 		fprintf(stderr, "syscall() failed: %d\n", errno);
 		return -errno;
 	}

 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
 	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
 		fprintf(stderr, "UFFDIO_API failed: %d\n", errno);
 		return -errno;
 	}

 	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
 		fprintf(stderr, "UFFD_FEATURE_WRITEPROTECT missing\n");
 		return -ENOSYS;
 	}

 	/* Register UFFD-WP */
 	uffdio_register.range.start = (unsigned long) map;
 	uffdio_register.range.len = MMAP_SIZE;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) < 0) {
 		fprintf(stderr, "UFFDIO_REGISTER failed: %d\n", errno);
 		return -errno;
 	}

 	/* Writeprotect the range. */
 	uffd_writeprotect.range.start = (unsigned long) map;
 	uffd_writeprotect.range.len = MMAP_SIZE;
 	uffd_writeprotect.mode = UFFDIO_WRITEPROTECT_MODE_WP;
 	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &uffd_writeprotect)) {
 		fprintf(stderr, "UFFDIO_WRITEPROTECT failed: %d\n", errno);
 		return -errno;
 	}

 	return 0;
 }

 int main(int argc, char **argv)
 {
 	int ksm_fd, ret;

 	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
 	if (ksm_fd < 0) {
 		fprintf(stderr, "KSM not available\n");
 		return -errno;
 	}

 	map = mmap(NULL, MMAP_SIZE, PROT_READ|PROT_WRITE,
 		   MAP_PRIVATE|MAP_ANON, -1, 0);
 	if (map == MAP_FAILED) {
 		fprintf(stderr, "mmap() failed\n");
 		return -errno;
 	}
 	ret = madvise(map, MMAP_SIZE, MADV_NOHUGEPAGE);
 	if (ret) {
 		fprintf(stderr, "MADV_NOHUGEPAGE failed\n");
 		return -errno;
 	}

 	/* Fill with same value and trigger merging. */
 	memset(map, 0xff, MMAP_SIZE);
 	ret = madvise(map, MMAP_SIZE, MADV_MERGEABLE);
 	if (ret) {
 		fprintf(stderr, "MADV_MERGEABLE failed\n");
 		return -errno;
 	}

 	/*
 	 * Run KSM to trigger merging and wait a bit until merging should be
 	 * done.
 	 */
 	if (write(ksm_fd, "1", 1) != 1) {
 		fprintf(stderr, "Running KSM failed\n");
 	}
 	sleep(10);

 	/* Write-protect the range with UFFD. */
 	if (setup_uffd())
 		return 1;

 	/* Trigger unsharing. */
 	ret = madvise(map, MMAP_SIZE, MADV_UNMERGEABLE);
 	if (ret) {
 		fprintf(stderr, "MADV_UNMERGEABLE failed\n");
 		return -errno;
 	}

 	return 0;
 }

--------------------------------------------------------------------------

Consequently, we will no longer trigger a fake write fault and break COW
without any such side-effects.

This is primarily a fix for KSM+userfaultfd-wp, however, the fake write
fault was always questionable. As this fix is not easy to backport and it's
not very critical, let's not cc stable.

Fixes: 529b930b87d9 ("userfaultfd: wp: hook userfault handler to write protection fault")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index e8d987fb379e..4d7bcf7da7c3 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -453,17 +453,15 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 }
 
 /*
- * We use break_ksm to break COW on a ksm page: it's a stripped down
+ * We use break_ksm to break COW on a ksm page by triggering unsharing,
+ * such that the ksm page will get replaced by an exclusive anonymous page.
  *
- *	if (get_user_pages(addr, 1, FOLL_WRITE, &page, NULL) == 1)
- *		put_page(page);
- *
- * but taking great care only to touch a ksm page, in a VM_MERGEABLE vma,
+ * We take great care only to touch a ksm page, in a VM_MERGEABLE vma,
  * in case the application has unmapped and remapped mm,addr meanwhile.
  * Could a ksm page appear anywhere else?  Actually yes, in a VM_PFNMAP
  * mmap of /dev/mem, where we would not want to touch it.
  *
- * FAULT_FLAG/FOLL_REMOTE are because we do this outside the context
+ * FAULT_FLAG_REMOTE/FOLL_REMOTE are because we do this outside the context
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
@@ -487,7 +485,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 		if (!ksm_page)
 			return 0;
 		ret = handle_mm_fault(vma, addr,
-				      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
+				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
 				      NULL);
 	} while (!(ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
 	/*
-- 
2.37.3

