Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81D378ACA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjH1Kld (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjH1Kl3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:41:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F7C119;
        Mon, 28 Aug 2023 03:41:27 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SABuZ5031648;
        Mon, 28 Aug 2023 05:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=a
        dptGb/WfXkWF/5gMdIyYCn0kSpTmfqyg0jDIXzIcRA=; b=AahwV8w92Q+QOqeUf
        z9h9XGmrS9pfL2b5btpSvLGNXYiT45J+x11Xx5UYNWG4AsGptHqak/Wy/rbLFOW7
        rCaMPucTmUrolTzoFb6ynyXkkrXHLUzyx1z2ZgSSCL66tORk5ZA4JbZ4kXNZjOOS
        UXrss1ltLSYcW9VMVzGe+I1PV9kJoezoOaI8LVciHNLUZhmE+uTVCVa23mmccGeo
        e2tH7WOUq+1wbMhjwnfu33JczFEwwNvOSBSjW5kumaPrxCSqh88mf3RmOe4R1Tj6
        HflPE7uNMOcUQBhAwokwAji3ao/IeLUkRH7q4qsQ/VBQysGbWG+PK9nxmwjgH2bq
        VSF9A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj1my9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:41:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 11:41:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 11:41:12 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E9AD511AA;
        Mon, 28 Aug 2023 10:41:11 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v6 00/10] kunit: Add dynamically-extending log
Date:   Mon, 28 Aug 2023 11:41:01 +0100
Message-ID: <20230828104111.2394344-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s-tTiMRa_hO7PSTRpzdFfwjpQ_C9RW4_
X-Proofpoint-GUID: s-tTiMRa_hO7PSTRpzdFfwjpQ_C9RW4_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch chain changes the logging implementation to use string_stream
so that the log will grow dynamically.

The first 8 patches add test code for string_stream, and make some
changes to string_stream needed to be able to use it for the log.

The final patch adds a performance report of string_stream.

CHANGES SINCE V5:
Patch 2:
- Avoid cast warning when using KUNIT_EXPECT_EQ() on a gfp_t. Instead pass
  the result of the comparison to KUNIT_EXPECT_TRUE(). While it would be
  nice to use KUNIT_EXPECT_EQ(), it's probably better to avoid introducing
  build or sparse warnings.

- In string_stream_append_test() rename original_content to
  stream1_content_before_append.

Patch 7:
- Make string_stream_clear() public (in v5 this was done in patch #8).
- In string-stream-test.c add a wrapper for kfree() to prevent a cast
  warning when calling kunit_add_action().

Patch 8:
- Fix memory leak when calling the redirected string_stream_destroy_stub().

Patch 9:
- In kunit-test.c: add wrapper function around kfree() to prevent cast
  warning when calling kunit_add_action().
- Fix unused variable warning in kunit_log_test() when built as a module.

Richard Fitzgerald (10):
  kunit: string-stream: Don't create a fragment for empty strings
  kunit: string-stream: Improve testing of string_stream
  kunit: string-stream: Add option to make all lines end with newline
  kunit: string-stream-test: Add cases for string_stream newline
    appending
  kunit: Don't use a managed alloc in is_literal()
  kunit: string-stream: Add kunit_alloc_string_stream()
  kunit: string-stream: Decouple string_stream from kunit
  kunit: string-stream: Add tests for freeing resource-managed
    string_stream
  kunit: Use string_stream for test log
  kunit: string-stream: Test performance of string_stream

 include/kunit/test.h           |  14 +-
 lib/kunit/assert.c             |  14 +-
 lib/kunit/debugfs.c            |  36 ++-
 lib/kunit/kunit-test.c         |  56 +++-
 lib/kunit/string-stream-test.c | 525 +++++++++++++++++++++++++++++++--
 lib/kunit/string-stream.c      | 100 +++++--
 lib/kunit/string-stream.h      |  16 +-
 lib/kunit/test.c               |  50 +---
 8 files changed, 688 insertions(+), 123 deletions(-)

-- 
2.30.2

