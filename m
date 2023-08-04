Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84070770074
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjHDMqu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 08:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjHDMqb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 08:46:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE5746BD;
        Fri,  4 Aug 2023 05:46:29 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHQRN68QnzrS0y;
        Fri,  4 Aug 2023 20:45:20 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 20:46:26 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <vnagarnaik@google.com>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH 0/2] tracing: Fix cpu buffers unavailable problem and add its testcase
Date:   Fri, 4 Aug 2023 20:45:47 +0800
Message-ID: <20230804124549.2562977-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, steve,

after some operations on file 'tracing_cpumask' and 'snapshot', trace
ring buffer can no longer record anything. This series contain a patch
to fix it and a constrived testcase to reproduce it.

I think the reproduction testcase is useful to help others to check if
their version has this problem and verify the bugfix. However, currently
in "tools/testing/selftests/ftrace/test.d", there seems no appropriate
subdirectory to put this kind reproductions.

So I now put the testcase in "00basic" because it is basicly simple. Or
would there be a new directory to collect simple reproduction testcases?

Zheng Yejian (2):
  tracing: Fix cpu buffers unavailable due to 'record_disabled' messed
  selftests/ftrace: Add a basic testcase for snapshot

 kernel/trace/trace.c                            |  2 ++
 .../ftrace/test.d/00basic/snapshot1.tc          | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc

-- 
2.25.1

