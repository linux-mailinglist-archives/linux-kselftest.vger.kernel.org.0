Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97077066B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 18:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjHDQzx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHDQzw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 12:55:52 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A3422B;
        Fri,  4 Aug 2023 09:55:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7EA3960177;
        Fri,  4 Aug 2023 18:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691168144; bh=jGKArOHB9A/vE1VyN1TzB7/9WlyDQkSbKJ/qSRlrg4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Lvq2XEfE5l92EkNlNdNhmi5dOFDJqg0P27OgthGyexVw/muoggPy19Z/MtgGbxuGK
         Gximh2eGIRnyqvnn3RtCEe4NfNB86/v7IauGF1auuC3ZwTl22756htbNNoWLs7ZcrO
         0XJIgVr9fyhGSA20LyciUAVIrhU330GfD7IxRLsTH0vGXPX340377zn6n8sAWuRlAr
         YbEjJQrLnSoASysqQSsMynN244431zJnlRAnD4E9unTvVBsI+OY029ZhZD0hAVy9JR
         km8sVJz+AVlOU5Zzkw2qY2ujyl7tJuH7+WjHCyLX+CLqYKi1yBs1mw23RulUlcA8L3
         s7kZLdMjkrn6w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kBv9sbNghrv6; Fri,  4 Aug 2023 18:55:41 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id EC2E560174;
        Fri,  4 Aug 2023 18:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691168141; bh=jGKArOHB9A/vE1VyN1TzB7/9WlyDQkSbKJ/qSRlrg4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=qAR4TZQ/gjjpKyr7+3vOmYASKTSG8wSaJaJw+xgTNXZszy/eJYvqn+75UoZzHxHfS
         MIc9FUyHn88MjS5iFfWafxHfhm7q0PlJMyLRSk6//wDpZF3sLS8AUEzELV2p6wqrua
         54UBVULx9cE6WJ8ykp54cEQ601XEkl1GapI49wg4rx8Z7Wkppa3OkDLuYFsZyFmUZE
         AK7oOYMni5iboWcWS72hYrKasipH/ccJUwck5wVuhQIlMB0kLC1vpo8ObxNRqiYxT8
         grR1nDoP+lAFw7q8QY33UpkYFpyuclLW+anE3sQvQ6HAs603ne63642tWDnGVcezA2
         wxelq2g3IYwDA==
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
Subject: [PATCH v3 4.19 1/2] test_firmware: fix a memory leak with reqs buffer
Date:   Fri,  4 Aug 2023 18:53:21 +0200
Message-Id: <20230804165321.92163-1-mirsad.todorovac@alu.unizg.hr>
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
Cc: stable@vger.kernel.org # v4.19
Suggested-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ This is a backport to v4.19 stable branch without a change in code from the 5.4+ patch ]

---
v2:
 no changes to commit. minor clarifications with versioning for the patchwork.

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

