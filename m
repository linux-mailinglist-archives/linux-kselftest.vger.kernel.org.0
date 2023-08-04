Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A6D770697
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjHDRCx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 13:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjHDRCw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 13:02:52 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77D4C04;
        Fri,  4 Aug 2023 10:02:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 81E8860177;
        Fri,  4 Aug 2023 19:02:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691168538; bh=ecMjHPpY0lN4NorohlbbtxWzqzYwS0qNv/tnlKmKJwM=;
        h=From:To:Cc:Subject:Date:From;
        b=sJ6i3s16ieRXktGg7Ggi8IG5loEYR3Rdn2m6Z7mj04+89KfW+tif3nr7w+Pq1RRnI
         SRhi346g42xbo3QNUE/GkhBdMcAR0xxlgmI8hfvDwPr+RDBXSXjQGmmPTnqfFCf7Mb
         hUXmVJkqjq0EneVmEL4uoASer2HY1YB6b9LBPq/ebcEXfjv0+CZFzhl4Kdi9x+8Saj
         kEXHc1B+gFLYMoS7kmZjyAwIjAwF0bYSAgqQli6ohPY3gxbZeblpvnx+/b9c/GiBLi
         JAeSyRZhNbca4bkcx91ix+DchVR9dyX2z2FBZyI7eEwfm2Y/pjgWhSGB6729xxyicR
         RcTICJonKJNfQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KR6wHmTX4dgb; Fri,  4 Aug 2023 19:02:15 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id C01FF60174;
        Fri,  4 Aug 2023 19:02:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691168535; bh=ecMjHPpY0lN4NorohlbbtxWzqzYwS0qNv/tnlKmKJwM=;
        h=From:To:Cc:Subject:Date:From;
        b=AH0TB7k93+GgseCprBxrhaw53lg7yLFagoj4hBAjlS3hdrRP/dixkf2vA6JM7eQw4
         jZ8JqmUDEqKdYku+yAKRv0uV5jQlFedL2ikrPtTlL75aJ+N5vCdWytEBr6rsFJvDWn
         +Mwt3HtwZswslVezCeuEj7Jnym+tWI9Yq+pe+DK3tMkw969StRxdk3a9/+3hhIdgG6
         xxIDK1hJFaiOH88czbceIfhhEReFXA3vI7MKUKt1rJtS1oFxlCCTr+/wIfxxqU9jfh
         x5bKwr3mCHaw6XYHuZFfAE3d38jH7xjfsP8dILDTsmpOA0pUhnHFufssswjjUnj6sZ
         ro/yoNJD464Hw==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
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
Subject: [PATCH v3 4.14 1/1] test_firmware: fix the memory leaks with the reqs buffer
Date:   Fri,  4 Aug 2023 19:00:18 +0200
Message-Id: <20230804170017.92671-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ This fix is applied against the 4.14 stable branch. There are no changes to the ]
[ fix in code when compared to the upstread, only the reformatting for backport.  ]

---
v2 -> v3:
 minor clarifications in the versioning for the patchwork. not change to commit.

v1 -> v2:
 removed the Reviewed-by: and Acked-by tags, as this is a slightly different patch and
 those need to be reacquired

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
2.34.1

