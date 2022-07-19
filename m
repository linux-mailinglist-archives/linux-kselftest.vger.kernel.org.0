Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A33579046
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 03:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiGSB7C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 21:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiGSB7C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 21:59:02 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7153D3A4A7;
        Mon, 18 Jul 2022 18:59:00 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 51F531E80D46;
        Tue, 19 Jul 2022 09:54:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DLrHpBEHnVGZ; Tue, 19 Jul 2022 09:54:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: lvqian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id AA89C1E80D10;
        Tue, 19 Jul 2022 09:54:51 +0800 (CST)
From:   Lv qian <lvqian@nfschina.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Lv qian <lvqian@nfschina.com>
Subject: [PATCH] tools: Change the division operator to a right shift operator
Date:   Tue, 19 Jul 2022 09:58:18 +0800
Message-Id: <20220719015818.3260-1-lvqian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Change the division operator to a right shift operator,Reduced assembly
code.

Signed-off-by: Lv qian <lvqian@nfschina.com>
---
 tools/testing/selftests/size/get_size.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/size/get_size.c b/tools/testing/selftests/size/get_size.c
index 2980b1a63366..b1e34408f8c6 100644
--- a/tools/testing/selftests/size/get_size.c
+++ b/tools/testing/selftests/size/get_size.c
@@ -73,7 +73,7 @@ static int print_k_value(const char *s, unsigned long num, unsigned long units)
 	print(s);
 
 	temp = num;
-	temp = (temp * units)/1024;
+	temp = (temp * units)>>10;
 	num = temp;
 	ccode = print_num(num);
 	print("\n");
-- 
2.18.2

