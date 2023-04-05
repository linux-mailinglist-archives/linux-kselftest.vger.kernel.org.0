Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88C56D795B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 12:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbjDEKOb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDEKOa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 06:14:30 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AEF1989;
        Wed,  5 Apr 2023 03:14:28 -0700 (PDT)
X-UUID: d602bed24f3d429bb527d0b6799d2ddb-20230405
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8917a6d3-17f0-4697-ad62-c68c70d80830,IP:-32
        768,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FIL
        E:-32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:8917a6d3-17f0-4697-ad62-c68c70d80830,IP:-3276
        8,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FILE:
        -32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:nil,BulkID:nil,BulkQuantity:0,Recheck:
        0,SF:nil,TC:nil,Content:nil,EDM:nil,IP:nil,URL:nil,File:nil,Bulk:nil,QS:ni
        l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d602bed24f3d429bb527d0b6799d2ddb-20230405
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2089193996; Wed, 05 Apr 2023 18:13:54 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        dmatlack@google.com, coltonlewis@google.com, vipinsh@google.com
Cc:     gehao@kylinos.cn, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        gehao618@163.com
Subject: [RESEND PATCH] kvm/selftests: Close opened file descriptor in stable_tsc_check_supported()
Date:   Wed,  5 Apr 2023 18:13:50 +0800
Message-Id: <20230405101350.259000-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Close the "current_clocksource" file descriptor before
returning or exiting from stable_tsc_check_supported()
in vmx_nested_tsc_scaling_test

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 .../selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c    | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index d427eb146bc5..fa03c8d1ce4e 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -126,12 +126,16 @@ static void stable_tsc_check_supported(void)
 		goto skip_test;
 
 	if (fgets(buf, sizeof(buf), fp) == NULL)
-		goto skip_test;
+		goto close_fp;
 
 	if (strncmp(buf, "tsc", sizeof(buf)))
-		goto skip_test;
+		goto close_fp;
 
+	fclose(fp);
 	return;
+
+close_fp:
+	fclose(fp);
 skip_test:
 	print_skip("Kernel does not use TSC clocksource - assuming that host TSC is not stable");
 	exit(KSFT_SKIP);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
