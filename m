Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60C37094C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjESK2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 06:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjESK2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 06:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F04E66
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684492052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mshSl/L24cbHjgxG6vAxFgJ6bjemOrv24WU57BqqeIQ=;
        b=Rq7s38+BwZX/Z7byCFO2RqtC8V5eyBvAHNILQwivhPFcRejG/9pUp7XEhxaEcZJuO1urVR
        OEKILJVWTrQoe7EP32KB4lqaaUrM3W0QC8gMkOZ+nv4YBX5iezOA9aIetbiOJOggIUUYse
        PpRzOPHlIriIunaLfyXlKpUuaBvt4m4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-eT-fxRkTPiGN-URMWUCDig-1; Fri, 19 May 2023 06:27:26 -0400
X-MC-Unique: eT-fxRkTPiGN-URMWUCDig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B4FC185A792;
        Fri, 19 May 2023 10:27:26 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 163C62166B25;
        Fri, 19 May 2023 10:27:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v1 0/3] selftests/mm: new test for FOLL_LONGTERM on file mappings
Date:   Fri, 19 May 2023 12:27:20 +0200
Message-Id: <20230519102723.185721-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's add some selftests to make sure that:
* R/O long-term pinning always works of file mappings
* R/W long-term pinning always works in MAP_PRIVATE file mappings
* R/W long-term pinning only works in MAP_SHARED mappings with special
  filesystems (shmem, hugetlb) and fails with other filesystems (ext4, btrfs,
  xfs).

The tests make use of the gup_test kernel module to trigger ordinary GUP
and GUP-fast, and liburing (similar to our COW selftests). Test with memfd,
memfd hugetlb, tmpfile() and mkstemp(). The latter usually gives us a
"real" filesystem (ext4, btrfs, xfs) where long-term pinning is
expected to fail.

Note that these selftests don't contain any actual reproducers for data
corruptions in case R/W long-term pinning on problematic filesystems
"would" work.

Maybe we can later come up with a racy !FOLL_LONGTERM reproducer that can
reuse an existing interface to trigger short-term pinning (I'll look into
that next).

On current mm/mm-unstable:
	# ./gup_longterm
	# [INFO] detected hugetlb page size: 2048 KiB
	# [INFO] detected hugetlb page size: 1048576 KiB
	TAP version 13
	1..50
	# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd
	ok 1 Should have worked
	# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
	ok 2 Should have worked
	# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
	ok 3 Should have failed
	# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
	ok 4 Should have worked
	# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
	ok 5 Should have worked
	# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd
	ok 6 Should have worked
	# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with tmpfile
	ok 7 Should have worked
	# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with local tmpfile
	ok 8 Should have failed
	# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
	ok 9 Should have worked
	# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
	ok 10 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd
	ok 11 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
	ok 12 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
	ok 13 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
	ok 14 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
	ok 15 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd
	ok 16 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with tmpfile
	ok 17 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with local tmpfile
	ok 18 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
	ok 19 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
	ok 20 Should have worked
	# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
	ok 21 Should have worked
	# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfile
	ok 22 Should have worked
	# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with local tmpfile
	ok 23 Should have worked
	# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
	ok 24 Should have worked
	# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
	ok 25 Should have worked
	# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd
	ok 26 Should have worked
	# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
	ok 27 Should have worked
	# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
	ok 28 Should have worked
	# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
	ok 29 Should have worked
	# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
	ok 30 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
	ok 31 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfile
	ok 32 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with local tmpfile
	ok 33 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
	ok 34 Should have worked
	# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
	ok 35 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd
	ok 36 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
	ok 37 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
	ok 38 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
	ok 39 Should have worked
	# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
	ok 40 Should have worked
	# [RUN] io_uring fixed buffer with MAP_SHARED file mapping ... with memfd
	ok 41 Should have worked
	# [RUN] io_uring fixed buffer with MAP_SHARED file mapping ... with tmpfile
	ok 42 Should have worked
	# [RUN] io_uring fixed buffer with MAP_SHARED file mapping ... with local tmpfile
	ok 43 Should have failed
	# [RUN] io_uring fixed buffer with MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
	ok 44 Should have worked
	# [RUN] io_uring fixed buffer with MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
	ok 45 Should have worked
	# [RUN] io_uring fixed buffer with MAP_PRIVATE file mapping ... with memfd
	ok 46 Should have worked
	# [RUN] io_uring fixed buffer with MAP_PRIVATE file mapping ... with tmpfile
	ok 47 Should have worked
	# [RUN] io_uring fixed buffer with MAP_PRIVATE file mapping ... with local tmpfile
	ok 48 Should have worked
	# [RUN] io_uring fixed buffer with MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
	ok 49 Should have worked
	# [RUN] io_uring fixed buffer with MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
	ok 50 Should have worked
	# Totals: pass:50 fail:0 xfail:0 xpass:0 skip:0 error:0

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Peter Xu <peterx@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jan Kara <jack@suse.cz>

David Hildenbrand (3):
  selftests/mm: factor out detection of hugetlb page sizes into vm_util
  selftests/mm: gup_longterm: new functional test for FOLL_LONGTERM
  selftests/mm: gup_longterm: add liburing tests

 tools/testing/selftests/mm/Makefile       |   3 +
 tools/testing/selftests/mm/cow.c          |  29 +-
 tools/testing/selftests/mm/gup_longterm.c | 459 ++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |   4 +-
 tools/testing/selftests/mm/vm_util.c      |  27 ++
 tools/testing/selftests/mm/vm_util.h      |   1 +
 6 files changed, 495 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/mm/gup_longterm.c

-- 
2.40.1

