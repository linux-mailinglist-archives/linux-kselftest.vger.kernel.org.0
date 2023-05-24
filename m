Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C842270FD1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjEXRrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjEXRrk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:47:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E49E69;
        Wed, 24 May 2023 10:47:09 -0700 (PDT)
X-QQ-mid: bizesmtp74t1684950423t77e0lrx
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 01:47:01 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKZBlxy494Gp/CUTxDNxeJi9g6MNrUFAmf11ZBmaQQlpsB9yjSoP9
        kCNyyfNK4LVYRCC+QxI5nml5abQCRTMKoiHD1uZbPRTZ1RzErA2+ejZ5gCTE4aaBmHm5bj/
        ZQ1bgyUYryKHFl0PJWO5ymVDxnE2EuM41izSnz1UsJHmnDxwhtoG9KaU3OBjNXlgs+zbNtw
        5i9MDjM0WHVF2a96ojpLDypn3LHo2HPKKA40Q0jjS2qTrMgN6Fci78eZmVfBjVwe6Rx4Pj+
        NvUiNs0b9UznWltOOMBCnR8UPvdOzT4vkcsKKbIerPec1+SV01TSUsBd4hWFiKtvEnBRr9S
        KVY5EDSIESXpdffOq9gmaBnmtPOtzRkYz4oX4hJkkwSFjsyihUHNRYIIYhw7Um6ZkKDhbVj
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10920217601069788465
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 03/13] selftests/nolibc: print name instead of number for EOVERFLOW
Date:   Thu, 25 May 2023 01:46:54 +0800
Message-Id: <e3c9bf5ccdae920f0609486256c52de8233aecb6.1684949267.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

EOVERFLOW will be used in the coming time64 syscalls support.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index c570bb848c1a..227ef2a3ebba 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -106,6 +106,7 @@ const char *errorname(int err)
 	CASE_ERR(EDOM);
 	CASE_ERR(ERANGE);
 	CASE_ERR(ENOSYS);
+	CASE_ERR(EOVERFLOW);
 	default:
 		return itoa(err);
 	}
-- 
2.25.1

