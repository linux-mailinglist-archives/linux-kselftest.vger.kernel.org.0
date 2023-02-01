Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F72368267A
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 09:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjAaIdu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 03:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjAaIdm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 03:33:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E243646164;
        Tue, 31 Jan 2023 00:33:26 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C03B6602EB0;
        Tue, 31 Jan 2023 08:33:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675154005;
        bh=KJbGh1Bj17VTFv93jkKBVRsISoOlHjybxqWUawq2KpM=;
        h=From:To:Cc:Subject:Date:From;
        b=FgmYI6UHF9aE+H/Q9eWdIsL8FW3r28LAZWQNElm3eXbBy43/sDcHD/kQ5TqsN3KbH
         +VrKH+jmlsPAU9InrYkH0b/hMiqQ+yBrq5xWeaDrDxLvORP3M/FToXn+yAKzZ/BlWN
         YPp+abd3tSTJDGoIjw0Qv0q3O/sFpJ410vthcreUyVZcX6itZIXep1faELKGYTumCW
         fST3kqqvg2VzmjZdBkzWO5LNivh/01maQJSAALglRzWqBRpZC+HuYsl8Tl/0XnpnCa
         zDewz6NMShnGS9Nkw+d9hnxmjpEpjMaCaCjmUl9pw03vaoR7w9yG1JIiQ9o1W7Nzn7
         7BTt58Ukh0NnA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v9 0/3] Implement IOCTL to get and/or the clear info about PTEs
Date:   Tue, 31 Jan 2023 13:32:54 +0500
Message-Id: <20230131083257.3302830-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
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

*Changes in v9:*
- Correct fault resolution for userfaultfd wp async
- Fix build warnings and errors which were happening on some configs
- Simplify pagemap ioctl's code

*Changes in v8:*
- Update uffd async wp implementation
- Improve PAGEMAP_IOCTL implementation

*Changes in v7:*
- Add uffd wp async
- Update the IOCTL to use uffd under the hood instead of soft-dirty
  flags

Hello,

Note:
Soft-dirty pages and pages which have been written-to are synonyms. As
kernel already has soft-dirty feature inside which we have given up to
use, we are using written-to terminology while using UFFD async WP under
the hood.

This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
the info about page table entries. The following operations are
supported in this ioctl:
- Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
  file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
  (PAGE_IS_SWAPPED).
- Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
  pages have been written-to.
- Find pages which have been written-to and write protect the pages
  (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)

It is possible to find and clear soft-dirty pages entirely in userspace.
But it isn't efficient:
- The mprotect and SIGSEGV handler for bookkeeping
- The userfaultfd wp (synchronous) with the handler for bookkeeping

Some benchmarks can be seen here[1]. This series adds features that weren't
present earlier:
- There is no atomic get soft-dirty/Written-to status and clear present in
  the kernel.
- The pages which have been written-to can not be found in accurate way.
  (Kernel's soft-dirty PTE bit + sof_dirty VMA bit shows more soft-dirty
  pages than there actually are.)

Historically, soft-dirty PTE bit tracking has been used in the CRIU
project. The procfs interface is enough for finding the soft-dirty bit
status and clearing the soft-dirty bit of all the pages of a process.
We have the use case where we need to track the soft-dirty PTE bit for
only specific pages on-demand. We need this tracking and clear mechanism
of a region of memory while the process is running to emulate the
getWriteWatch() syscall of Windows.

*(Moved to using UFFD instead of soft-dirtyi feature to find pages which
have been written-to from v7 patch series)*:
Stop using the soft-dirty flags for finding which pages have been
written to. It is too delicate and wrong as it shows more soft-dirty
pages than the actual soft-dirty pages. There is no interest in
correcting it [2][3] as this is how the feature was written years ago.
It shouldn't be updated to changed behaviour. Peter Xu has suggested
using the async version of the UFFD WP [4] as it is based inherently
on the PTEs.

So in this patch series, I've added a new mode to the UFFD which is
asynchronous version of the write protect. When this variant of the
UFFD WP is used, the page faults are resolved automatically by the
kernel. The pages which have been written-to can be found by reading
pagemap file (!PM_UFFD_WP). This feature can be used successfully to
find which pages have been written to from the time the pages were
write protected. This works just like the soft-dirty flag without
showing any extra pages which aren't soft-dirty in reality.

The information related to pages if the page is file mapped, present and
swapped is required for the CRIU project [5][6]. The addition of the
required mask, any mask, excluded mask and return masks are also required
for the CRIU project [5].

The IOCTL returns the addresses of the pages which match the specific masks.
The page addresses are returned in struct page_region in a compact form.
The max_pages is needed to support a use case where user only wants to get
a specific number of pages. So there is no need to find all the pages of
interest in the range when max_pages is specified. The IOCTL returns when
the maximum number of the pages are found. The max_pages is optional. If
max_pages is specified, it must be equal or greater than the vec_size.
This restriction is needed to handle worse case when one page_region only
contains info of one page and it cannot be compacted. This is needed to
emulate the Windows getWriteWatch() syscall.

The patch series include the detailed selftest which can be used as an example
for the uffd async wp test and PAGEMAP_IOCTL. It shows the interface usages as
well.

[1] https://lore.kernel.org/lkml/54d4c322-cd6e-eefd-b161-2af2b56aae24@collabora.com/
[2] https://lore.kernel.org/all/20221220162606.1595355-1-usama.anjum@collabora.com
[3] https://lore.kernel.org/all/20221122115007.2787017-1-usama.anjum@collabora.com
[4] https://lore.kernel.org/all/Y6Hc2d+7eTKs7AiH@x1n
[5] https://lore.kernel.org/all/YyiDg79flhWoMDZB@gmail.com/
[6] https://lore.kernel.org/all/20221014134802.1361436-1-mdanylo@google.com/

Regards,
Muhammad Usama Anjum

Muhammad Usama Anjum (3):
  userfaultfd: Add UFFD WP Async support
  fs/proc/task_mmu: Implement IOCTL to get and/or the clear info about
    PTEs
  selftests: vm: add pagemap ioctl tests

 fs/proc/task_mmu.c                         | 290 +++++++
 fs/userfaultfd.c                           |  11 +
 include/linux/userfaultfd_k.h              |   6 +
 include/uapi/linux/fs.h                    |  50 ++
 include/uapi/linux/userfaultfd.h           |   8 +-
 mm/memory.c                                |  23 +-
 tools/include/uapi/linux/fs.h              |  50 ++
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   5 +-
 tools/testing/selftests/vm/pagemap_ioctl.c | 881 +++++++++++++++++++++
 10 files changed, 1319 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c

-- 
2.30.2

