Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460D978E711
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjHaHRN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 03:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHaHRN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 03:17:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47D1A3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 00:17:10 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RbsqN5SxtzVkCs;
        Thu, 31 Aug 2023 15:14:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 31 Aug
 2023 15:17:08 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <jk@codeconstruct.com.au>,
        <dlatypov@google.com>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH 0/4] kunit: Fix some bugs in kunit_filter_suites()
Date:   Thu, 31 Aug 2023 15:16:51 +0800
Message-ID: <20230831071655.2907683-1-ruanjinjie@huawei.com>
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

The state handle in kunit_module_notify() is not correct when
the mod->state switch from MODULE_STATE_COMING to MODULE_STATE_GOING.

And it's necessary to check NULL for kzalloc() in
kunit_parse_glob_filter().

The order in which memory is released in err path in kunit_filter_suites()
is also problematic.

And there is a possible memory leak in kunit_filter_suites().

This patchset fix the above issues.

Jinjie Ruan (4):
  kunit: Fix wild-memory-access bug in kunit_free_suite_set()
  kunit: Fix possible null-ptr-deref in kunit_parse_glob_filter()
  kunit: Fix possible memory leak in kunit_filter_suites()
  kunit: Fix the wrong error path in kunit_filter_suites()

 lib/kunit/executor.c | 39 +++++++++++++++++++++++++++------------
 lib/kunit/test.c     |  3 ++-
 2 files changed, 29 insertions(+), 13 deletions(-)

-- 
2.34.1

