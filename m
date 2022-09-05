Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2F5AD31F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiIEMtJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiIEMtJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 08:49:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2FF1FB;
        Mon,  5 Sep 2022 05:49:07 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLpCK6JcvzjXlQ;
        Mon,  5 Sep 2022 20:45:33 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 20:49:05 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <shuah@kernel.org>, <akpm@linux-foundation.org>,
        <akinobu.mita@gmail.com>, Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next v2 0/5] Optimize and bugfix for cpu-on-off-test.sh
Date:   Mon, 5 Sep 2022 20:45:20 +0800
Message-ID: <20220905124525.130067-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

1. Correct log info
2. Add checking of invalid options
3. Replace exit with return to make the test exit gracefully
4. Delete fault injection related code
5. Reserve one cpu online when the test offline all cpus

Changes in v2:
  - Update change log of patch 2
  - Update exiting value to avoid incorrect report for patch 2
  - Keep online_cpu_expect_fail() and offline_cpu_expect_fail() for
    patch 3

Zhao Gongyi (5):
  selftests/cpu-hotplug: Correct log info
  selftests/cpu-hotplug: Use return instead of exit
  selftests/cpu-hotplug: Delete fault injection related code
  selftests/cpu-hotplug: Reserve one cpu online at least
  selftests/cpu-hotplug: Add log info when test success

 tools/testing/selftests/cpu-hotplug/Makefile  |   2 +-
 .../selftests/cpu-hotplug/cpu-on-off-test.sh  | 140 +++++-------------
 2 files changed, 37 insertions(+), 105 deletions(-)

--
2.17.1

