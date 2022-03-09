Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1946E4D2797
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 05:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiCIBap (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 20:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiCIBap (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 20:30:45 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F774130E;
        Tue,  8 Mar 2022 17:29:47 -0800 (PST)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KCvj30fh4zdZMk;
        Wed,  9 Mar 2022 09:28:23 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 09:29:45 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 09:29:44 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <brendanhiggins@google.com>, <glider@google.com>,
        <elver@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>
CC:     <wangkefeng.wang@huawei.com>, <liupeng256@huawei.com>
Subject: [PATCH 0/3] kunit: fix a UAF bug and do some optimization
Date:   Wed, 9 Mar 2022 01:47:02 +0000
Message-ID: <20220309014705.1265861-1-liupeng256@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series is to fix UAF when running kfence test case test_gfpzero,
which is time costly. This UAF bug can be easily triggered by setting
CONFIG_KFENCE_DYNAMIC_OBJECTS = 65535. Furthermore, some optimization
for kunit tests has been done.

Peng Liu (3):
  kunit: fix UAF when run kfence test case test_gfpzero
  kunit: make kunit_test_timeout compatible with comment
  kfence: test: try to avoid test_gfpzero trigger rcu_stall

 lib/kunit/try-catch.c   | 3 ++-
 mm/kfence/kfence_test.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.18.0.huawei.25

