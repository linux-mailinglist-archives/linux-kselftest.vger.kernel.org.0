Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43D6591B5E
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbiHMP1N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiHMP1M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 11:27:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D78186D7;
        Sat, 13 Aug 2022 08:27:08 -0700 (PDT)
X-QQ-mid: bizesmtp73t1660404405ts23mexm
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 13 Aug 2022 23:26:36 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: LE7C6P2vL8RBQc0pNvlq+InLMsfwEzbGkHDriDjF08MA10MxdJf/+1ydnBF/g
        kfNOJ8w/wjDVnNE5Kk+tfTedy5jsCDqmEMF2+G2GSopK87Ak5QQ3sE8VegSfJenw2vT+Gxx
        6XQtuSQ8aogq9nt6WyWupdDUWQzrPiQAmZkFJefmYQ9WpGv2MilxKb2oIzAmpUEWCBHbVod
        l6Monz++jCFveqRJgpAm/T2YxRvG+wacwBoGxqoGdDVDKYvK8dlxFyaaCk02NyaeG8lB/8R
        ynHJMf5EGPkDTtD+aK2SCqIZZJW30+BOU3L+ZybkmgZUM3pPePQYA48wZLzJbKvuJ+2VThP
        BsoWRb2PBizdC9FrffXyyyf+5OGs5ytC8Cp4UbRdxEiyZbwSNN2gPmGqzsWTA==
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     shuah@kernel.org
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] selftests/timers: Unneeded semicolon
Date:   Sat, 13 Aug 2022 23:26:24 +0800
Message-Id: <20220813152624.4478-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no semicolon after '}' in line 75.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 tools/testing/selftests/timers/nsleep-lat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index eb3e79ed7b4a..a7ca9825e106 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
2.17.1

