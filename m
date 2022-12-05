Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B0A643402
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 20:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiLETlc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 14:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiLETlN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 14:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C727FE0
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 11:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670269045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SG9jSfaiIwodefymdaqqzOfJdZJ3sXwYH1OOltmMvGU=;
        b=SW9fdL/8KtpR3uXQhOzqzwSwOlRqgEqOxKraTUs1U3J69QCwLyIKxPfJ1qQLmxMNSfGqUw
        pTYJOL190Lt1A4wfXN6nxVPiF7bHbVhMq+mKfI0rEHW8qp5IJBl5tq+ToZrXI+6LlVOyyC
        PhwUQPg/9XE82Pdqz2zvynFuFnnpt3A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-d9IoJ0Z-P8qHkscsu6kfSw-1; Mon, 05 Dec 2022 14:37:22 -0500
X-MC-Unique: d9IoJ0Z-P8qHkscsu6kfSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB07D85A59D;
        Mon,  5 Dec 2022 19:37:21 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BD1A20290A6;
        Mon,  5 Dec 2022 19:37:19 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH mm-unstable v1 0/4] selftests/vm: fix some tests on 32bit
Date:   Mon,  5 Dec 2022 20:37:12 +0100
Message-Id: <20221205193716.276024-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I finally had the time to run some of the selftests written by me
(especially "cow") on x86 PAE. I found some unexpected "surprises" :)

With these changes, and with [1] on top of mm-unstable, the "cow" tests and
the "ksm_functional_tests" compile and pass as expected (expected failures
with hugetlb in the "cow" tests). "madv_populate" has one expected test
failure -- x86 does not support softdirty tracking.

#1-#3 fix commits with stable commit ids. #4 fixes a test that is not in
mm-stable yet.

A note that there are many other compile errors/warnings when compiling
on 32bit and with older Linux headers ... something for another day.

[1] https://lkml.kernel.org/r/20221205150857.167583-1-david@redhat.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Yang Li <yang.lee@linux.alibaba.com>

David Hildenbrand (4):
  mm/gup_test: fix PIN_LONGTERM_TEST_READ with highmem
  selftests/vm: madv_populate: fix missing MADV_POPULATE_(READ|WRITE)
    definitions
  selftests/vm: cow: fix compile warning on 32bit
  selftests/vm: ksm_functional_tests: fixes for 32bit

 mm/gup_test.c                                     | 10 +++++++---
 tools/testing/selftests/vm/cow.c                  |  4 ++--
 tools/testing/selftests/vm/ksm_functional_tests.c |  4 ++--
 tools/testing/selftests/vm/madv_populate.c        |  7 +++++++
 tools/testing/selftests/vm/vm_util.c              |  2 +-
 5 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.38.1

