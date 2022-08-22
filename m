Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34459BEEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiHVLv0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiHVLuO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 07:50:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBA01145B;
        Mon, 22 Aug 2022 04:50:12 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MB9Yv2LcjzkWgq;
        Mon, 22 Aug 2022 19:46:43 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 19:50:11 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH -next 0/5] landlock: add chmod and chown support
Date:   Mon, 22 Aug 2022 19:46:56 +0800
Message-ID: <20220822114701.26975-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hi,
  this patchset adds chmod and chown support for landlock

Xiu Jianfeng (5):
  landlock: expand access_mask_t to u32 type
  landlock: add chmod and chown support
  landlock/selftests: add selftests for chmod and chown
  landlock/samples: add chmod and chown support
  landlock: update chmod and chown support in document

 Documentation/userspace-api/landlock.rst     |   8 +-
 include/uapi/linux/landlock.h                |   8 +-
 samples/landlock/sandboxer.c                 |  12 +-
 security/landlock/fs.c                       |  16 +-
 security/landlock/limits.h                   |   2 +-
 security/landlock/ruleset.h                  |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 234 ++++++++++++++++++-
 9 files changed, 274 insertions(+), 12 deletions(-)

-- 
2.17.1

