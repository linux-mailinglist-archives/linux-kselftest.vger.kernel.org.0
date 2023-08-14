Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F19177B9F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjHNN2j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjHNN2g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:28:36 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707021715
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 06:28:32 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37EBX0QW010808;
        Mon, 14 Aug 2023 08:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=R
        9IR6nMh0ngh6Bv7iNtA/5Z0sgh77bKDUoglSCnPwhU=; b=K7iwZAnjnUgn86Npf
        WtFN+uUtrR/tvK14X0A3X5f+tlaRZxvkkkW/n56fnUJVhkWsunK4Ng6xwRWhQwLU
        p9iax0j+SWvgQeI7ao6Sr9MISdNIvNOT0NLYlPIRvbFeYlW2BFown6Sr5mfOkoNs
        tlNeJRKgR2Kao7YQLWPNqjtOJqawgizLsQlEYR+4ToOgArNMLdxZIuilopjXW6OH
        bgS97cIVqQ8Qv1XfGervJgP7YWAuCPKmzI8Th8IDvO4lCudlplCn+2wfb2r5qDaA
        lwLrgKeE3vzxJppwUIryZBCPeUS0su6HjtDpND+0HlSvj/uHCdLqrsg7zP/T+4AO
        lfsNg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhhvdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:23:13 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 14:23:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 14 Aug 2023 14:23:11 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 70759458;
        Mon, 14 Aug 2023 13:23:11 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 00/10] kunit: Add dynamically-extending log
Date:   Mon, 14 Aug 2023 14:22:59 +0100
Message-ID: <20230814132309.32641-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8Jih5ue5vraZN-04bVM6xMogy14Z2A6L
X-Proofpoint-ORIG-GUID: 8Jih5ue5vraZN-04bVM6xMogy14Z2A6L
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

CHANGES SINCE V3:

Completely rewritten to use string_stream instead of implementing a
separate extending-buffer implementation for logging.

I have used the performance test from the final patch on my original
fixed-size-fragment implementation from V3 to get a comparison of the
two implementations (run on i3-8145UE CPU @ 2.20GHz):

                        string_stream     V3 fixed-size-buffer
Time elapsed:           7748 us           3251 us
Total string length:    573890            573890
Bytes requested:        823994            728336
Actual bytes allocated: 1061440           728352

I don't think the difference is enough to be worth complicating the
string_stream implementation with my fixed-fragment implementation from
V3 of this patch chain.

Richard Fitzgerald (10):
  kunit: string-stream: Improve testing of string_stream
  kunit: string-stream: Don't create a fragment for empty strings
  kunit: string-stream: Add cases for adding empty strings to a
    string_stream
  kunit: string-stream: Add option to make all lines end with newline
  kunit: string-stream: Add cases for string_stream newline appending
  kunit: string-stream: Pass struct kunit to string_stream_get_string()
  kunit: string-stream: Decouple string_stream from kunit
  kunit: string-stream: Add test for freeing resource-managed
    string_stream
  kunit: Use string_stream for test log
  kunit: string-stream: Test performance of string_stream

 include/kunit/test.h           |  14 +-
 lib/kunit/Makefile             |   5 +-
 lib/kunit/debugfs.c            |  36 ++-
 lib/kunit/kunit-test.c         |  52 +---
 lib/kunit/log-test.c           |  72 ++++++
 lib/kunit/string-stream-test.c | 447 +++++++++++++++++++++++++++++++--
 lib/kunit/string-stream.c      | 129 +++++++---
 lib/kunit/string-stream.h      |  22 +-
 lib/kunit/test.c               |  48 +---
 9 files changed, 656 insertions(+), 169 deletions(-)
 create mode 100644 lib/kunit/log-test.c

-- 
2.30.2

