Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146A976BACD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 19:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjHARJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 13:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjHARJo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 13:09:44 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1662735;
        Tue,  1 Aug 2023 10:09:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id E2D276017C;
        Tue,  1 Aug 2023 19:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690909749; bh=e6Bszk6G8nn708Yum4V8G3z8149Ww6/gLP9EzNUvxuo=;
        h=From:To:Cc:Subject:Date:From;
        b=FP0C+zTwyvERTQuh8B2EgRRe8bKfJwUBetXKuq+9gUAIF2fOidbjm+soAfkOc8yb1
         Tq93y7luRQAB/5JCxIo2UsWFYMpGjjkVHS7BpKiGkL3a7crWTVdpTQBL02Jdivz9xD
         NhF7gS3wEOxQG2yUoRXhoK7ZCWNq40HN/63v4H12y+Tc9HmV1OwXFEqq+DYQ0ZLJxv
         Vu92U9lLRFrCPX3RxvtTNV446aBYiQlLxLT3vzWg2eg/dJqXdES4bikYelz2HMQxYl
         uFvZAfDfOJC5XcBh+rJp3rjef6i+Qos7Q1cSSuIx+G5CvSbB6F8gmK+qfmncAXJg2N
         f8DUEDGpq492g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o4ZKyBaRx3Iz; Tue,  1 Aug 2023 19:09:07 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id D228C6015F;
        Tue,  1 Aug 2023 19:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690909747; bh=e6Bszk6G8nn708Yum4V8G3z8149Ww6/gLP9EzNUvxuo=;
        h=From:To:Cc:Subject:Date:From;
        b=NIi/IRqXTxYAZRPVtZEFea23cg+CDIvwOzVlY+RXnH1bpPpcxf00VBxCsVvRsi+xy
         xshyRiv/8AH3E7Pw9yyRJemwYgP3/+iK7PGLcc+VtW7iPSU5iYa7B5MUo02Cv9ACge
         knotXaT2tZsij0Qaj8Kybc5LWarWHZGRNnfxG9oxNMauqClqD/BprpjlT/Yqm94wfn
         GHGKArGl9WzUa28QOENciK4zc+UIcGpvSPmNgx5vzYebqXRuZXV2r/7wobgbEjrjt4
         O+R7ByCrbB6vz05TYP2GyuNR5pXhQCveNAF4GfAD4R6rjaOAH2M4w2sR2XHdAInY8m
         Iuhrowt65eGGA==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
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
Subject: [PATCH v1 1/1] test_firmware: fix a memory leak with reqs buffer
Date:   Tue,  1 Aug 2023 19:07:47 +0200
Message-Id: <20230801170746.191505-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
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
Cc: stable@vger.kernel.org # v4.19
Suggested-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ This is a backport to v4.19 stable branch without a change in code from the 5.4+ patch ]
---
v1:
 patch sumbmitted verbatim from the 5.4+ branch to 4.19

 lib/test_firmware.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index f4cc874021da..e4688821eab8 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -618,6 +618,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -721,6 +726,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
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
2.34.1

