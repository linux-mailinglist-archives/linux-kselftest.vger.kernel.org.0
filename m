Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3476B3BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjHALsQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjHALsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 07:48:09 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA9E1728;
        Tue,  1 Aug 2023 04:48:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id ADA336017C;
        Tue,  1 Aug 2023 13:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690890472; bh=BVMyjLdmNYq8frJWk79aHYi7fGzAuV+ZzSCG4CYTRDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HGJ7KVftL1Fn70I6nmBUJSiG6EmdVllBy9yw75Qsr2gHm+Tk9iYDpvjr+zEnxosLZ
         GQwhhAaqXMev/uPfJuHkK5G/rO/DA58G/ADe33U0Vf4zaS8HyPw86CSqmafomt1JJJ
         AczTpebaEmFivUQwzBubhpyR6AIo6g9H9npEpotBNCWwlmmL5ewZvFwHwKFZXHjpow
         YmhkVx4sSesFpnFC23NnUQTpbQfeo9J9NgUvozqvfbUSFc5ll3BjRUSAbXNSMj/rjW
         cPOdYxTxyADgqwr1mzrWVl/NB4oZFEX0mBqlY4xnUE+AUH20wefq/iUh8mdyGxSW58
         dUlYv/gU+hbPw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dUBsuvfTHbXF; Tue,  1 Aug 2023 13:47:50 +0200 (CEST)
Received: from pc-mtodorov.slava.alu.hr (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 9D0B66015F;
        Tue,  1 Aug 2023 13:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690890470; bh=BVMyjLdmNYq8frJWk79aHYi7fGzAuV+ZzSCG4CYTRDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Y7DXXWH5A2JGqfy7QCm1GHhdziQweGmxs6ksJaQiZjC5CeDhAGq/Rh6nW6CLmsbMc
         LIujMs84535v41u7u1BGtN6KskeuMxLT5l/nB3NjMJ+/VmmgVJ5vzVxGYWWuVEBhUR
         1RcIsB3kog10Vb6RUyZs/WdaHU7+rxG3BzWHVbUHkNrwd3aV5Alw6yzFFMM62rZm4a
         572LSLC6LZIEuI3fzLffozQ2rdgLSJS32tR75DEcMUyQiCXz+EF6McS+ooa3wsWYcq
         HX5TtBTP9ti+FR9CG8UVjBx+ktOjp63WnwIYlec28d6EKqHo4X6Hj0svHUTx9Z5CZW
         0n75xC0H2xG3A==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v1 1/1] test_firmware: fix the memory leaks with the reqs buffer
Date:   Tue,  1 Aug 2023 13:41:08 +0200
Message-Id: <20230801114107.15545-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ commit be37bed754ed90b2655382f93f9724b3c1aae847 upstream ]

Dan Carpenter spotted that test_fw_config->reqs will be leaked if
trigger_batched_requests_store() is called two or more times.
The same appears with trigger_batched_requests_async_store().

This bug wasn't triggered by the tests, but observed by Dan's visual
inspection of the code.

The recommended workaround was to return -EBUSY if test_fw_config->reqs
is already allocated.

Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Tianfei Zhang <tianfei.zhang@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org # v4.14
Suggested-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ This fix is applied against the 4.14 stable branch. There are no changes to the ]
[ fix in code when compared to the upstread, only the reformatting for backport.  ]
---
 lib/test_firmware.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 1c5e5246bf10..5318c5e18acf 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -621,6 +621,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+        if (test_fw_config->reqs) {
+                rc = -EBUSY;
+                goto out_bail;
+        }
+
 	test_fw_config->reqs = vzalloc(sizeof(struct test_batched_req) *
 				       test_fw_config->num_requests * 2);
 	if (!test_fw_config->reqs) {
@@ -723,6 +728,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+        if (test_fw_config->reqs) {
+                rc = -EBUSY;
+                goto out_bail;
+        }
+
 	test_fw_config->reqs = vzalloc(sizeof(struct test_batched_req) *
 				       test_fw_config->num_requests * 2);
 	if (!test_fw_config->reqs) {
-- 
2.39.3

