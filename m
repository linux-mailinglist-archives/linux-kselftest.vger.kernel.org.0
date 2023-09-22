Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE577AA9D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 09:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjIVHLI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 03:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjIVHLG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 03:11:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F75C192
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:10:59 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RsNfS3BFjzrT09;
        Fri, 22 Sep 2023 15:08:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 22 Sep
 2023 15:10:57 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <rmoar@google.com>, <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v3 0/4] kunit: Fix some bugs in kunit
Date:   Fri, 22 Sep 2023 15:10:16 +0800
Message-ID: <20230922071020.2554677-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test_cases is not freed in kunit_free_suite_set().

And the copy pointer may be moved in kunit_filter_suites().

The filtered_suite and filtered_suite->test_cases allocated in the last
kunit_filter_attr_tests() in last inner for loop may be leaked if
kunit_filter_suites() fails.

If kunit_filter_suites() succeeds, not only copy but also filtered_suite
and filtered_suite->test_cases should be freed.

Changes in v3:
- Update the kfree_at_end() to use kunit_free_suite_set() for 4th patch.
- Update the commit message for the 4th patch.

Changes in v2:
- Add Reviewed-by.
- Add the memory leak backtrace for the 4th patch.
- Remove the unused func kernel test robot noticed for the 4th patch.
- Update the commit message for the 4th patch.

Jinjie Ruan (4):
  kunit: Fix missed memory release in kunit_free_suite_set()
  kunit: Fix the wrong kfree of copy for kunit_filter_suites()
  kunit: Fix possible memory leak in kunit_filter_suites()
  kunit: test: Fix the possible memory leak in executor_test

 lib/kunit/executor.c      | 23 +++++++++++++++++------
 lib/kunit/executor_test.c | 35 ++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 19 deletions(-)

-- 
2.34.1

