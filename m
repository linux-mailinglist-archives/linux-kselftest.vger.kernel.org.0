Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB94787196
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbjHXOco (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbjHXOcY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 10:32:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8341BD9;
        Thu, 24 Aug 2023 07:32:19 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37O7iEx5023063;
        Thu, 24 Aug 2023 09:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=Q
        T9wmDnyIPZIix0FVCJy1BAnUv35TfXqqfj6jSOzJII=; b=RiO8r32chI9P1tW/F
        10WZ2E9j95id3F6+ztdSSMG9ljA1ogYIfZhz7JOmN/i+S1G7E8FCigVWgUWC59Tw
        5wlgxyF5POP9SeuPkTF+XI6rMtw/YohzD8aGkoocnbpHmfj1H6PibU8DqOCrhrDC
        +/rYXAGTCXLci/xhVlWyyHSNchu/0ns66mSqfMc14r2F8jX68TUwGL3gWKeNvpc1
        qNpyY6uKAUDROWPRhZvy/CQDHRySHU6bOuapsS77HdtfABNKEOafV7oIi1YvVYV2
        ibkCjC4Xwk72Z1c5puCUrPfYtFUb3GLzKO1Eo9+O9HXFQiYXWRAwlWgnmAoUaqq0
        YFLGA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1rbghkk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:31:32 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 24 Aug
 2023 15:31:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 24 Aug 2023 15:31:29 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9F94146B;
        Thu, 24 Aug 2023 14:31:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v5 00/10] kunit: Add dynamically-extending log
Date:   Thu, 24 Aug 2023 15:31:19 +0100
Message-ID: <20230824143129.1957914-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1adOQUqH7F3QsOAiAWtohhGIbA89-12x
X-Proofpoint-GUID: 1adOQUqH7F3QsOAiAWtohhGIbA89-12x
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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

CHANGES SINCE V4:
- Re-ordered the first 3 patches from V4 to squash the first two sets
  of string_stream tests into a single patch.
- Changed is_literal() so it doesn't need a struct kunit.
- Split out the new resource-managed alloc and free functions into
  a pre-patch to reduce the amount of code churn when the string_stream
  is decoupled from kunit.
- Wrapped the call to string_stream_geT_string() in string-stream-test
  in a local function to reduce the amount of code churn when the
  string_stream is decoupled from kunit.
- Some minor changes to test implementations.
- string_stream is now completely separated from kunit and the 'test'
  member of struct string_stream has been eliminated.

Richard Fitzgerald (10):
  kunit: string-stream: Don't create a fragment for empty strings
  kunit: string-stream: Improve testing of string_stream
  kunit: string-stream: Add option to make all lines end with newline
  kunit: string-stream: Add cases for string_stream newline appending
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
 lib/kunit/kunit-test.c         |  46 ++-
 lib/kunit/string-stream-test.c | 508 +++++++++++++++++++++++++++++++--
 lib/kunit/string-stream.c      | 100 +++++--
 lib/kunit/string-stream.h      |  16 +-
 lib/kunit/test.c               |  50 +---
 8 files changed, 662 insertions(+), 122 deletions(-)

-- 
2.30.2

