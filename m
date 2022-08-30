Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA07F5A5E2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiH3Id6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiH3Id6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 04:33:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30927B5E7D;
        Tue, 30 Aug 2022 01:33:56 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH0rw4dhqznTsG;
        Tue, 30 Aug 2022 16:31:28 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 16:33:53 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <shuah@kernel.org>, <akpm@linux-foundation.org>,
        <akinobu.mita@gmail.com>, Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next 0/5] Optimize and bugfix for cpu-on-off-test.sh
Date:   Tue, 30 Aug 2022 16:30:23 +0800
Message-ID: <20220830083028.45504-1-zhaogongyi@huawei.com>
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
2. Replace exit with return to make the test exit gracefully
3. Delete fault injection related code
4. Reserve one cpu online when the test offline all cpus
5. Add log info when run full test successfully

Zhao Gongyi (5):
  selftests/cpu-hotplug: Correct log info
  selftests/cpu-hotplug: Replace exit with return
  selftests/cpu-hotplug: Delete fault injection related code
  selftests/cpu-hotplug: Reserve one cpu online at least
  selftests/cpu-hotplug: Add log info when test success

 tools/testing/selftests/cpu-hotplug/Makefile  |   2 +-
 tools/testing/selftests/cpu-hotplug/config    |   1 -
 .../selftests/cpu-hotplug/cpu-on-off-test.sh  | 150 ++++--------------
 3 files changed, 29 insertions(+), 124 deletions(-)
 delete mode 100644 tools/testing/selftests/cpu-hotplug/config

--
2.17.1

