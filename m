Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46803735410
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 12:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjFSKvl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 06:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjFSKvN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 06:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2A2198E;
        Mon, 19 Jun 2023 03:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68BC6068B;
        Mon, 19 Jun 2023 10:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BFDC433C8;
        Mon, 19 Jun 2023 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171839;
        bh=gzdujEU3/hRV6Pr8z9XYs+gz9JZAg2D18OESNsKRvIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t218jkCYiu77x+TGYq/o+VYEZdyZhFO5ECml4ka9BnNy2rDZw8ZU9QUIwft9cqAKb
         jL2Mb6Msa8oB9DdFE45ua16BMWdKwyGyPZ3yF9dENxKshjxAs18Bu4kSAxt/34Pxx9
         ZT0o9GxP2m3Mx0O1eR+1JcMoyEBJ1huHajbnMQCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 01/64] test_firmware: fix a memory leak with reqs buffer
Date:   Mon, 19 Jun 2023 12:29:57 +0200
Message-ID: <20230619102132.877724157@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

[ Upstream commit be37bed754ed90b2655382f93f9724b3c1aae847 ]

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
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_firmware.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 3146845f01562..38553944e9675 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -679,6 +679,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -778,6 +783,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
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
2.39.2



