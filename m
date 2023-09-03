Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34A0790B1A
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjICHK6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 03:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjICHK5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 03:10:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F2F197
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 00:10:53 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RdjWp4XKKzQjKw;
        Sun,  3 Sep 2023 15:07:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 3 Sep
 2023 15:10:50 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <jk@codeconstruct.com.au>,
        <dlatypov@google.com>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2 0/4] kunit: Fix some bugs in kunit_filter_suites()
Date:   Sun, 3 Sep 2023 15:10:24 +0800
Message-ID: <20230903071028.1518913-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The state handle in kunit_module_notify() is not correct when
the mod->state switch from MODULE_STATE_COMING to MODULE_STATE_GOING.

And it's necessary to check NULL for kzalloc() in
kunit_parse_glob_filter().

The order in which memory is released in err path in kunit_filter_suites()
is also problematic.

And there is a possible memory leak in kunit_filter_suites().

This patchset fix the above issues.

Changes in v2:
- Adjust the 4th patch to be the second.
- Add goto labels in kunit_filter_suites() and adapt to it.
- Fix the issue in the third patch.
- Update the commit message and title.

Jinjie Ruan (4):
  kunit: Fix wild-memory-access bug in kunit_free_suite_set()
  kunit: Fix the wrong err path and add goto labels in
    kunit_filter_suites()
  kunit: Fix possible null-ptr-deref in kunit_parse_glob_filter()
  kunit: Fix possible memory leak in kunit_filter_suites()

 lib/kunit/executor.c | 48 ++++++++++++++++++++++++++++++--------------
 lib/kunit/test.c     |  3 ++-
 2 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.34.1

