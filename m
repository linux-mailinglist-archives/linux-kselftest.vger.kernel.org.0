Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEEC773CAA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjHHQIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjHHQGz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:55 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E2772B6;
        Tue,  8 Aug 2023 08:45:58 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378CIdoN005342;
        Tue, 8 Aug 2023 07:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=p
        NF9tnNCFcWCDXJjAENT/3aMUbHY2V9YRZasC7L4+y8=; b=PW72mRF5XJzcuHjCQ
        KNwi63fkAx97vDzHub4IlTM8UQX1Cx5pbYMF5PIZK097Fd6lAFCgEIG1BQ6/HIL7
        +GRByQVIOu+Bi+QFT+gxyoKSIT8ipdAhiEUdt82LYDonu4FOJijY6CWVsWezuC/x
        H5EeLS1JOg1CEek1pKPvOOdFyTxIIGmjre1U7BKgIGlyDjYZcJCVbz6uIOkuxmlV
        uwf3qV9J675tuT+GJFU4YQCP5xYiPyItxrPWtVbUuA+TJVuBCD8Hye8K4LBDgLEJ
        WZCMe7dRJRUb6OYvaNC3MiiliINQybjspeD5sQ8F6NPcae9X/H+Dkugo5dXRqua4
        bON6A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtjv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 07:35:33 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 13:35:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 13:35:32 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9EDC415B7;
        Tue,  8 Aug 2023 12:35:31 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/6] kunit: Add dynamically-extending log
Date:   Tue, 8 Aug 2023 13:35:23 +0100
Message-ID: <20230808123529.4725-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WjeADTKplpkN2fETfNyawX8LKahbHmNv
X-Proofpoint-ORIG-GUID: WjeADTKplpkN2fETfNyawX8LKahbHmNv
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

Richard Fitzgerald (6):
  kunit: Replace fixed-size log with dynamically-extending buffer
  kunit: kunit-test: Add test cases for extending log buffer
  kunit: Handle logging of lines longer than the fragment buffer size
  kunit: kunit-test: Add test cases for logging very long lines
  kunit: kunit-test: Add test of logging only a newline
  kunit: Don't waste first attempt to format string in
    kunit_log_append()

 include/kunit/test.h   |  25 +++-
 lib/kunit/debugfs.c    |  65 +++++++--
 lib/kunit/kunit-test.c | 321 ++++++++++++++++++++++++++++++++++++++++-
 lib/kunit/test.c       | 127 +++++++++++++---
 4 files changed, 489 insertions(+), 49 deletions(-)

-- 
2.30.2

