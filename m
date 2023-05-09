Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D896FC22E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjEII7m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 04:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjEII7l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 04:59:41 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395D9D059;
        Tue,  9 May 2023 01:59:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1086C60187;
        Tue,  9 May 2023 10:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683622777; bh=BkbDGciTS3W//1DGsvWYvladd4chFAo6enUQtEEQQqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZiHOi8HPxzzbaMu1BjZZouEP73gvHy58Ao5cTqsMxCM4iZOXDHxWxpKrp1dLHCuaJ
         dxBDXLa5fe7MakoluU2y8lwJGGEx4df5P4xjhxbV8aspiHEXl6Zju8X/4WzwV5PL2Y
         fEsMURPTuCszyce/c/Jmw8qm9JtbOElF1SXnzJjDHpDQ4rteRW8WAP2soR5ctuAep2
         4fi2kcRY/MABNk31PQSerIUCtEakvumQmOtxsJHLSjnqpHYg46OtSbkzVQOwD1RCxa
         Kp234zFEiZd9iRtkgfxmivI78zIallIYKfDP9pD40GySeU09gXcdZjirAuZvDby10x
         IWDRtcp1CZZyw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2KOxey4fw9l1; Tue,  9 May 2023 10:59:34 +0200 (CEST)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id E058D6018D; Tue,  9 May 2023 10:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683622774; bh=BkbDGciTS3W//1DGsvWYvladd4chFAo6enUQtEEQQqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7OVwpJpI7Wz6LVxX5Nui1hPHgVn86mc1DA5sZq8+h2zdVGiTVcG1BKmLGt5NP5NX
         RLEgoD3XF44dTF7b+dzcY4Z+pfbtraucHN3SUvtMP6O24fLDj8O2VcPUe7jSh/YqtA
         fNpTE9/Zwqh9n4BHGSr2h3wChoU8kxqcdpB+aiX7CoAJ6BFFHpHHqfIb2oWolaw8XY
         E5+hyZZhLdK0J/2i15jgdg7SG9Pu+gyHswwgoljCu1B9m4/H/HkBqhqqg8jzJkaU6f
         brGy+i6GjBNa9Wf28Iv4IojqwGuUBPGgeS0Tcbtxa84CJIO+fu+hGhhDlEkHsI9/X/
         oYz7H0kiy4C/A==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
Subject: [RESEND PATCH v5 2/3] test_firmware: fix a memory leak with reqs buffer
Date:   Tue,  9 May 2023 10:47:47 +0200
Message-Id: <20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr>
References: <20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dan Carpenter spotted that test_fw_config->reqs will be leaked if
trigger_batched_requests_store() is called two or more times.
The same appears with trigger_batched_requests_async_store().

This bug wasn't trigger by the tests, but observed by Dan's visual
inspection of the code.

The recommended workaround was to return -EBUSY if test_fw_config->reqs
is already allocated.

Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Tianfei Zhang <tianfei.zhang@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org # v5.4
Suggested-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 lib/test_firmware.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 35417e0af3f4..91b232ed3161 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -913,6 +913,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
-- 
2.30.2

