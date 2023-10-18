Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411327CD21C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 04:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJRCFf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 22:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRCFe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 22:05:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04573F7;
        Tue, 17 Oct 2023 19:05:28 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9DdG44J3zrSNb;
        Wed, 18 Oct 2023 10:02:42 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 10:05:19 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <skhan@linuxfoundation.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <rostedt@goodmis.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <shuah@kernel.org>,
        <mhiramat@kernel.org>
Subject: [RESEND PATCH 0/2] add loongarch and riscv support for kprobe args test
Date:   Wed, 18 Oct 2023 10:08:56 +0800
Message-ID: <20231018020858.1304218-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Yu Liao (2):
  selftests/ftrace: add loongarch support for kprobe args char tests
  selftests/ftrace: Add riscv support for kprobe arg tests

 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc      | 6 ++++++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc    | 3 +++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc    | 4 ++++
 3 files changed, 13 insertions(+)

-- 
2.25.1

