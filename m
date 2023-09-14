Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFD7A02FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjINLrX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 07:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjINLrW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 07:47:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0FEBB
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 04:47:18 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rmb773gFjzGpr5;
        Thu, 14 Sep 2023 19:43:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 19:47:14 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <rmoar@google.com>, <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH 0/4] kunit: Fix some bugs in kunit
Date:   Thu, 14 Sep 2023 19:46:25 +0800
Message-ID: <20230914114629.1517650-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
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

Jinjie Ruan (4):
  kunit: Fix missed memory release in kunit_free_suite_set()
  kunit: Fix the wrong kfree of copy for kunit_filter_suites()
  kunit: Fix possible memory leak in kunit_filter_suites()
  kunit: test: Fix the possible memory leak in executor_test

 lib/kunit/executor.c      | 23 +++++++++++++++++------
 lib/kunit/executor_test.c | 24 ++++++++++++++++++------
 2 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.34.1

