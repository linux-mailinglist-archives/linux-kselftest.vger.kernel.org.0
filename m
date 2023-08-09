Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14056776472
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 17:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjHIPy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHIPy5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 11:54:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8A01729;
        Wed,  9 Aug 2023 08:54:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379EvsGJ002928;
        Wed, 9 Aug 2023 10:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=Z
        kHLOZxL/zUPQBtzRZ/2aFe1CQ5Jd2Dy1yhV/zJ7Hmc=; b=Q6HJWnFnruMMnKLJR
        yKwQKMR8mw+7hlCHMyfisCNTz3Ixfrfx2DRbqbrNx9pP96OzPK2GCZ41D3HhKF1J
        SY0yjnrBH4xXH7PPikPOltTqfxMM/3VWjLC8Vitsxwf42+Iz0spOaDT96GOLkELp
        19C0kXeHQiDr8RNz5ihtRWKuNcxi+a/LWRrqr6p2Ej4Qrssvh1/zzeGm3WOzY+me
        P83ocp8eoMHXstRzox2sJzPOC76+1KgwP9SmXT6hep9YR+nwkMyeY6uyvWC+sPzG
        WoJRz8WvBCwMmyOfzoBy377zf8YH36glV6vsycjL2vbrk9l7bqThgcweFOtiQCNZ
        WPlDw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhuvg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 10:54:47 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 16:54:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 16:54:45 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2DFEA45D;
        Wed,  9 Aug 2023 15:54:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 0/7] kunit: Add dynamically-extending log
Date:   Wed, 9 Aug 2023 16:54:31 +0100
Message-ID: <20230809155438.22470-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UHPPCzpg6K0WlTYlIn4MYqd5wjRRPUcl
X-Proofpoint-ORIG-GUID: UHPPCzpg6K0WlTYlIn4MYqd5wjRRPUcl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the original fixed-size log buffer with a dynamically-
extending log.

Patch 1 provides the basic implementation. The following patches
add test cases, support for logging long strings, and an optimization
to the string formatting that is now more thoroughly testable.

Changes since v2:
- Fixed uninitialized string bug in get_concatenated_log().
- Moved get_concatenated_log() into first patch so that
  kunit_log_newline_test() dumps the entire log on error.
- Moved kunit_log_frag_sized_line_test() to the correct point in
  the chain, after the change that it depends on. Also log another
  line after the long line to test that the log extends correctly.
- Added kunit_log_init_frag_test() to test kunit_init_log_frag()
  instead of testing it as part of every other test.

Richard Fitzgerald (7):
  kunit: Replace fixed-size log with dynamically-extending buffer
  kunit: kunit-test: Add test cases for extending log buffer
  kunit: Handle logging of lines longer than the fragment buffer size
  kunit: kunit-test: Test logging a line that exactly fills a fragment
  kunit: kunit-test: Add test cases for logging very long lines
  kunit: kunit-test: Add test of logging only a newline
  kunit: Don't waste first attempt to format string in
    kunit_log_append()

 include/kunit/test.h   |  25 ++-
 lib/kunit/debugfs.c    |  65 ++++++--
 lib/kunit/kunit-test.c | 339 ++++++++++++++++++++++++++++++++++++++++-
 lib/kunit/test.c       | 127 ++++++++++++---
 4 files changed, 507 insertions(+), 49 deletions(-)

-- 
2.30.2
