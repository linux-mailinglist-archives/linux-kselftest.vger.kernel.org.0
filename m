Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3135EC04F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiI0LC3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 07:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiI0LCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 07:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC7BB7C3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664276489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3xgDb8D/3EHICRWKuyfoBAlGnicVQATCL19Alr25P2c=;
        b=N2JjCpsbwMVdqxLgpGh5QveNw4DK0sWCZphk8G5c77P+A62rtyPjYqWWmNOwzubor19mm7
        lPiEQ6KncO3bOi9Usv4fgalatxFsOWD4yguM9NSCIXE8mqaB1nOBgVoTglnP/9UVR3JnaF
        IeXj/KKN0A4tV/ciUGh7LatujKGj3QI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-vgVRod4zOGm8GofJPuq0Hg-1; Tue, 27 Sep 2022 07:01:25 -0400
X-MC-Unique: vgVRod4zOGm8GofJPuq0Hg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 583E0800186;
        Tue, 27 Sep 2022 11:01:25 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2D58C15BAB;
        Tue, 27 Sep 2022 11:01:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>
Subject: [PATCH v1 0/7] selftests/vm: test COW handling of anonymous memory
Date:   Tue, 27 Sep 2022 13:01:13 +0200
Message-Id: <20220927110120.106906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On top of mm-stable.

This is my current set of tests for testing COW handling of anonymous
memory, especially when interacting with GUP. I developed these tests
while working on PageAnonExclusive and managed to clean them up just now.

On current upstream Linux, all tests pass except the hugetlb tests that
rely on vmsplice -- these tests should pass as soon as vmsplice properly
uses FOLL_PIN instead of FOLL_GET.

I'm working on additional tests for COW handling in private mappings,
focusing on long-term R/O pinning e.g., of the shared zeropage, pagecache
pages and KSM pages. These tests, however, will go into a different file.
So this is everything I have regarding tests for anonymous memory.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Christoph von Recklinghausen <crecklin@redhat.com>
Cc: Don Dutile <ddutile@redhat.com>

David Hildenbrand (7):
  selftests/vm: anon_cow: test COW handling of anonymous memory
  selftests/vm: factor out pagemap_is_populated() into vm_util
  selftests/vm: anon_cow: THP tests
  selftests/vm: anon_cow: hugetlb tests
  selftests/vm: anon_cow: add liburing test cases
  mm/gup_test: start/stop/read functionality for PIN LONGTERM test
  selftests/vm: anon_cow: add R/O longterm tests via gup_test

 mm/gup_test.c                              |  140 +++
 mm/gup_test.h                              |   12 +
 tools/testing/selftests/vm/.gitignore      |    1 +
 tools/testing/selftests/vm/Makefile        |   25 +-
 tools/testing/selftests/vm/anon_cow.c      | 1126 ++++++++++++++++++++
 tools/testing/selftests/vm/check_config.sh |   31 +
 tools/testing/selftests/vm/madv_populate.c |    8 -
 tools/testing/selftests/vm/run_vmtests.sh  |    3 +
 tools/testing/selftests/vm/vm_util.c       |   15 +
 tools/testing/selftests/vm/vm_util.h       |    2 +
 10 files changed, 1353 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/vm/anon_cow.c
 create mode 100644 tools/testing/selftests/vm/check_config.sh

-- 
2.37.3

