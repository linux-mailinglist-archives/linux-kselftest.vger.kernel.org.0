Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC076EBB5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 22:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDVUzW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Apr 2023 16:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDVUzU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Apr 2023 16:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA6132
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Apr 2023 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682196879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MmovEZDh3RRZ4TGij6AOUtYqNZkl+ysd7uj3ZrA1KLk=;
        b=bHwpml5+n/vwwqHROKthWCuS0ywhYIXouRq/cU09Xcgu1RNn2tr2F9xylbo/1BmiPm8tRh
        S+NgZRjdxeFkE1iNQH2xdAN6ppm2tC2bTRx+mqrU/IjeEC3rXS6aGChuouXv3TCyeAZAby
        qY8MEv7dCvUazsDovOJMJ206sk9KJFw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-6F8RbvXvPe2iBIeR5XH5sQ-1; Sat, 22 Apr 2023 16:54:35 -0400
X-MC-Unique: 6F8RbvXvPe2iBIeR5XH5sQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6D4D101A531;
        Sat, 22 Apr 2023 20:54:34 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F7F6492B03;
        Sat, 22 Apr 2023 20:54:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH mm-stable v2 0/3] mm/ksm: improve PR_SET_MEMORY_MERGE=0 handling and cleanup disabling KSM
Date:   Sat, 22 Apr 2023 22:54:17 +0200
Message-Id: <20230422205420.30372-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a follow-up to [1]:
	[PATCH v9 0/3] mm: process/cgroup ksm support

which is now in mm-stable. Ideally we'd get at least patch #1 into the
same kernel release as [1], so the semantics of setting
PR_SET_MEMORY_MERGE=0 are unchanged between kernel versions.

(1) Make PR_SET_MEMORY_MERGE=0 unmerge pages like setting MADV_UNMERGEABLE
does, (2) add a selftest for it and (3) factor out disabling of KSM from
s390/gmap code.

v1 -> v2:
- "mm/ksm: unmerge and clear VM_MERGEABLE when setting
   PR_SET_MEMORY_MERGE=0"
 -> Cleanup one if/else
 -> Add doc for ksm_disable_merge_any()
- Added ACKs

[1] https://lkml.kernel.org/r/20230418051342.1919757-1-shr@devkernel.io

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>

David Hildenbrand (3):
  mm/ksm: unmerge and clear VM_MERGEABLE when setting
    PR_SET_MEMORY_MERGE=0
  selftests/ksm: ksm_functional_tests: add prctl unmerge test
  mm/ksm: move disabling KSM from s390/gmap code to KSM code

 arch/s390/mm/gmap.c                           | 20 +-----
 include/linux/ksm.h                           |  7 ++
 kernel/sys.c                                  | 12 +---
 mm/ksm.c                                      | 70 +++++++++++++++++++
 .../selftests/mm/ksm_functional_tests.c       | 46 ++++++++++--
 5 files changed, 121 insertions(+), 34 deletions(-)

-- 
2.40.0

