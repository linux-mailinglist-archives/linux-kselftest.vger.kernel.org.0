Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841AF545CF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jun 2022 09:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbiFJHNO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 03:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346385AbiFJHNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 03:13:11 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292FB0A50;
        Fri, 10 Jun 2022 00:13:02 -0700 (PDT)
X-QQ-mid: bizesmtp75t1654845175tfa8xrcm
Received: from localhost.localdomain ( [117.176.187.14])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 10 Jun 2022 15:12:50 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: xoS364mEyr1DaoeVNVatJwYFrEvA7K7CSbv/9wrGw9REx7cj7dDejJqDnGol/
        FfD3U3O/mIp8raKSuLeMm465lRxnK7UKCB7hufoYq8bGHgYODDbtE/lL9+meRex3h966Nlq
        ozACF9Wq6B81UdE6duggN4pBWTEgEoxFb0rBGAzYetkNAF3pbF2UFMWFr6xlYPS4oKOXcFs
        sjwFGX/kE+uNkaBux8sjGpHjPw1/DhdfDEGV347eMVsVXaXL3MoymtWQ05GFHmuErxX5TYg
        wCJX9LmWrxiwEUWCcBf1277lWANM7Jw77/EpJAGI01P1elIGbhnrvwzjh8t5eHOhX93befB
        Jr1jydX38+AR1xhq97pTtp5fFEpvQ==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] userfaultfd/selftests: Fix typo in comment
Date:   Fri, 10 Jun 2022 15:12:44 +0800
Message-Id: <20220610071244.59679-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 0bdfc1955229..4bc24581760d 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -860,7 +860,7 @@ static int stress(struct uffd_stats *uffd_stats)
 	/*
 	 * Be strict and immediately zap area_src, the whole area has
 	 * been transferred already by the background treads. The
-	 * area_src could then be faulted in in a racy way by still
+	 * area_src could then be faulted in a racy way by still
 	 * running uffdio_threads reading zeropages after we zapped
 	 * area_src (but they're guaranteed to get -EEXIST from
 	 * UFFDIO_COPY without writing zero pages into area_dst
-- 
2.36.1

