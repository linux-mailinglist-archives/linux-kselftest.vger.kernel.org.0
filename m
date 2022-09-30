Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F308F5F0D4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiI3OT6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 10:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiI3OTy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 10:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCF7481F5
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664547589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eksXkTT4hqG/3veGcAG1lXhndJ/4JYD7d1ML/eQwqI0=;
        b=ROt3wsSubHEuqDx+EdV8tVJalSUbNKXaXEMWudfairjOT/Qz7Ki6DlhjlGj4LxWFMQmrD7
        GU9b6d4niqsbbKNTqC0IXz68NYOr9gBI+soR34E9jWqN5Wc2wg757GWiWQFyC3f33oSej4
        1tkZg20Z6AeptN6bhJ7RdVOXdFfwOyc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-WVKMxLXMOA-eW7lYh1eiHA-1; Fri, 30 Sep 2022 10:19:46 -0400
X-MC-Unique: WVKMxLXMOA-eW7lYh1eiHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 765C3101A528;
        Fri, 30 Sep 2022 14:19:45 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6DCF1121315;
        Fri, 30 Sep 2022 14:19:32 +0000 (UTC)
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
Subject: [PATCH v1 0/7] mm/ksm: break_ksm() cleanups and fixes
Date:   Fri, 30 Sep 2022 16:19:24 +0200
Message-Id: <20220930141931.174362-1-david@redhat.com>
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

This series cleans up and fixes break_ksm(). In summary, we no longer
use fake write faults to break COW but instead FAULT_FLAG_UNSHARE. Further,
we move away from using follow_page() [that we can hopefully remove
completely at one point] and use new walk_page_range_vma() instead.

Fortunately, we can get rid of VM_FAULT_WRITE and FOLL_MIGRATION in common
code now.

Add a selftest to measure MADV_UNMERGEABLE performance. In my setup
(AMD Ryzen 9 3900X), running the KSM selftest to test unmerge performance
on 2 GiB (taskset 0x8 ./ksm_tests -D -s 2048), this results in a
performance degradation of ~8% -- 9% (old: ~5250 MiB/s, new: ~4800 MiB/s).
I don't think we particularly care for now, but it's good to be aware
of the implication.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>

David Hildenbrand (7):
  selftests/vm: add test to measure MADV_UNMERGEABLE performance
  mm/ksm: simplify break_ksm() to not rely on VM_FAULT_WRITE
  mm: remove VM_FAULT_WRITE
  mm/ksm: fix KSM COW breaking with userfaultfd-wp via
    FAULT_FLAG_UNSHARE
  mm/pagewalk: add walk_page_range_vma()
  mm/ksm: convert break_ksm() to use walk_page_range_vma()
  mm/gup: remove FOLL_MIGRATION

 include/linux/mm.h                     |   1 -
 include/linux/mm_types.h               |   3 -
 include/linux/pagewalk.h               |   3 +
 mm/gup.c                               |  55 ++-----------
 mm/huge_memory.c                       |   2 +-
 mm/ksm.c                               | 103 +++++++++++++++++++------
 mm/memory.c                            |   9 +--
 mm/pagewalk.c                          |  27 +++++++
 tools/testing/selftests/vm/ksm_tests.c |  76 +++++++++++++++++-
 9 files changed, 192 insertions(+), 87 deletions(-)

-- 
2.37.3

