Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8626D572E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 05:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjDDDX6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 23:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjDDDXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 23:23:51 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBEB19B3;
        Mon,  3 Apr 2023 20:23:37 -0700 (PDT)
X-UUID: 005b3a2ee91641c09af50283789917b0-20230404
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:23d41e41-0d92-45a2-9317-dd453af336f5,IP:5,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:31
X-CID-INFO: VERSION:1.1.22,REQID:23d41e41-0d92-45a2-9317-dd453af336f5,IP:5,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:31
X-CID-META: VersionHash:120426c,CLOUDID:a5ba502a-564d-42d9-9875-7c868ee415ec,B
        ulkID:230404112333OFCV9LE8,BulkQuantity:0,Recheck:0,SF:38|24|17|19|45|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 005b3a2ee91641c09af50283789917b0-20230404
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 947019076; Tue, 04 Apr 2023 11:23:30 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     seanjc@google.com, dmatlack@google.com, coltonlewis@google.com,
        vipinsh@google.com, gehao@kylinos.cn, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        gehao618@163.com
Subject: [RESEND PATCH] selftest/vmx_nested_tsc_scaling_test: fix fp leak
Date:   Tue,  4 Apr 2023 11:23:11 +0800
Message-Id: <20230404032311.146506-1-gehao@kylinos.cn>
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

Fix stable_tsc_check_supported fopen but not fclose

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
