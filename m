Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1A6DDDBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjDKO0O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDKO0M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2A212F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681223120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ElJXvy3GrdCHxap+2OiSZHKtp+/midD3ZXDx5TNtDM=;
        b=TldSL37mQif+k5HTAynacVan+j2GIcJ5D7cWlFywH0I+3HO0c9Td6CNK0Mw5sKKRju7OTq
        WjEqVoa23eQQ93RhTw5yy17Gt4RarMg6Aout178apEFcuZVarNJ3AkXpsN8FCl9cFW6OiV
        Bp/ksRwTzeLGKXnnmw2dFk/X1fjd+SQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-7XB9EyNpNM6h9LofAub74g-1; Tue, 11 Apr 2023 10:25:17 -0400
X-MC-Unique: 7XB9EyNpNM6h9LofAub74g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4100A1097B19;
        Tue, 11 Apr 2023 14:25:16 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC58F14171D5;
        Tue, 11 Apr 2023 14:25:13 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Shuah Khan <shuah@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Yu Zhao <yuzhao@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v1 RESEND 0/6] mm: (pte|pmd)_mkdirty() should not unconditionally allow for write access
Date:   Tue, 11 Apr 2023 16:25:06 +0200
Message-Id: <20230411142512.438404-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is the follow-up on [1], adding selftests (testing for known issues
we added workarounds for and other issues that haven't been fixed yet),
fixing sparc64, reverting the workarounds, and perform one cleanup.

The patch from [1] was modified slightly (updated/extended patch
description, dropped one unnecessary NOP instruction from the ASM in
__pte_mkhwwrite()).

Retested on x86_64 and sparc64 (sun4u in QEMU).

I scanned most architectures to make sure their (pte|pmd)_mkdirty()
handling is correct. To be sure, we can run the selftests and find out if
other architectures are still affectes (loongarch was fixed recently as
well).

Based on master for now. I don't expect surprises regarding mm-tress, but
I can rebase if there are any problems.

[1] https://lkml.kernel.org/r/20221212130213.136267-1-david@redhat.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Xu <peterx@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>

David Hildenbrand (6):
  selftests/mm: reuse read_pmd_pagesize() in COW selftest
  selftests/mm: mkdirty: test behavior of (pte|pmd)_mkdirty on VMAs
    without write permissions
  sparc/mm: don't unconditionally set HW writable bit when setting PTE
    dirty on 64bit
  mm/migrate: revert "mm/migrate: fix wrongly apply write bit after
    mkdirty on sparc64"
  mm/huge_memory: revert "Partly revert "mm/thp: carry over dirty bit
    when thp splits on pmd""
  mm/huge_memory: conditionally call maybe_mkwrite() and drop
    pte_wrprotect() in __split_huge_pmd_locked()

 arch/sparc/include/asm/pgtable_64.h           | 116 +++---
 mm/huge_memory.c                              |  16 +-
 mm/migrate.c                                  |   2 -
 tools/testing/selftests/mm/Makefile           |   2 +
 tools/testing/selftests/mm/cow.c              |  33 +-
 tools/testing/selftests/mm/khugepaged.c       |   4 +
 tools/testing/selftests/mm/mkdirty.c          | 379 ++++++++++++++++++
 tools/testing/selftests/mm/soft-dirty.c       |   3 +
 .../selftests/mm/split_huge_page_test.c       |   4 +
 tools/testing/selftests/mm/vm_util.c          |   4 +-
 10 files changed, 468 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/mm/mkdirty.c

-- 
2.39.2

