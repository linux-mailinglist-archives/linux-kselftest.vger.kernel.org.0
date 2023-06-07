Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55141726F2E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjFGU4K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 16:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjFGU4J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 16:56:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA29D1;
        Wed,  7 Jun 2023 13:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DC3F6482F;
        Wed,  7 Jun 2023 20:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ED7C433EF;
        Wed,  7 Jun 2023 20:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171366;
        bh=Rn7wB5NGhrgNZG8yXxEyGad8nUz1ISi0pi3f06GgqgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ami56aapMlP/G8D6XpfulAfBvo3lSV+IgRXaHgVjNZQsgqMOSRMOY6YYWnUVpAY+B
         ziNjVHhUY0rmXDw1jsM845PAE65KZOqOErIxTLeJULFJQUvyMba/T7K8H/FS5cy46+
         rM2OgUw78DvZzcgTQrHd5K+usJn0kL0PnbteOncE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 5.4 91/99] test_firmware: fix the memory leak of the allocated firmware buffer
Date:   Wed,  7 Jun 2023 22:17:23 +0200
Message-ID: <20230607200903.089044381@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

commit 48e156023059e57a8fc68b498439832f7600ffff upstream.

The following kernel memory leak was noticed after running
tools/testing/selftests/firmware/fw_run_tests.sh:

[root@pc-mtodorov firmware]# cat /sys/kernel/debug/kmemleak
.
.
.
unreferenced object 0xffff955389bc3400 (size 1024):
  comm "test_firmware-0", pid 5451, jiffies 4294944822 (age 65.652s)
  hex dump (first 32 bytes):
    47 48 34 35 36 37 0a 00 00 00 00 00 00 00 00 00  GH4567..........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff962f5dec>] slab_post_alloc_hook+0x8c/0x3c0
    [<ffffffff962fcca4>] __kmem_cache_alloc_node+0x184/0x240
    [<ffffffff962704de>] kmalloc_trace+0x2e/0xc0
    [<ffffffff9665b42d>] test_fw_run_batch_request+0x9d/0x180
    [<ffffffff95fd813b>] kthread+0x10b/0x140
    [<ffffffff95e033e9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff9553c334b400 (size 1024):
  comm "test_firmware-1", pid 5452, jiffies 4294944822 (age 65.652s)
  hex dump (first 32 bytes):
    47 48 34 35 36 37 0a 00 00 00 00 00 00 00 00 00  GH4567..........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff962f5dec>] slab_post_alloc_hook+0x8c/0x3c0
    [<ffffffff962fcca4>] __kmem_cache_alloc_node+0x184/0x240
    [<ffffffff962704de>] kmalloc_trace+0x2e/0xc0
    [<ffffffff9665b42d>] test_fw_run_batch_request+0x9d/0x180
    [<ffffffff95fd813b>] kthread+0x10b/0x140
    [<ffffffff95e033e9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff9553c334f000 (size 1024):
  comm "test_firmware-2", pid 5453, jiffies 4294944822 (age 65.652s)
  hex dump (first 32 bytes):
    47 48 34 35 36 37 0a 00 00 00 00 00 00 00 00 00  GH4567..........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff962f5dec>] slab_post_alloc_hook+0x8c/0x3c0
    [<ffffffff962fcca4>] __kmem_cache_alloc_node+0x184/0x240
    [<ffffffff962704de>] kmalloc_trace+0x2e/0xc0
    [<ffffffff9665b42d>] test_fw_run_batch_request+0x9d/0x180
    [<ffffffff95fd813b>] kthread+0x10b/0x140
    [<ffffffff95e033e9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff9553c3348400 (size 1024):
  comm "test_firmware-3", pid 5454, jiffies 4294944822 (age 65.652s)
  hex dump (first 32 bytes):
    47 48 34 35 36 37 0a 00 00 00 00 00 00 00 00 00  GH4567..........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff962f5dec>] slab_post_alloc_hook+0x8c/0x3c0
    [<ffffffff962fcca4>] __kmem_cache_alloc_node+0x184/0x240
    [<ffffffff962704de>] kmalloc_trace+0x2e/0xc0
    [<ffffffff9665b42d>] test_fw_run_batch_request+0x9d/0x180
    [<ffffffff95fd813b>] kthread+0x10b/0x140
    [<ffffffff95e033e9>] ret_from_fork+0x29/0x50
[root@pc-mtodorov firmware]#

Note that the size 1024 corresponds to the size of the test firmware
buffer. The actual number of the buffers leaked is around 70-110,
depending on the test run.

The cause of the leak is the following:

request_partial_firmware_into_buf() and request_firmware_into_buf()
provided firmware buffer isn't released on release_firmware(), we
have allocated it and we are responsible for deallocating it manually.
This is introduced in a number of context where previously only
release_firmware() was called, which was insufficient.

Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <error27@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Tianfei zhang <tianfei.zhang@intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org # v5.4
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Link: https://lore.kernel.org/r/20230509084746.48259-3-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_firmware.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -38,6 +38,7 @@ struct test_batched_req {
 	bool sent;
 	const struct firmware *fw;
 	const char *name;
+	const char *fw_buf;
 	struct completion completion;
 	struct task_struct *task;
 	struct device *dev;
@@ -134,8 +135,14 @@ static void __test_release_all_firmware(
 
 	for (i = 0; i < test_fw_config->num_requests; i++) {
 		req = &test_fw_config->reqs[i];
-		if (req->fw)
+		if (req->fw) {
+			if (req->fw_buf) {
+				kfree_const(req->fw_buf);
+				req->fw_buf = NULL;
+			}
 			release_firmware(req->fw);
+			req->fw = NULL;
+		}
 	}
 
 	vfree(test_fw_config->reqs);
@@ -489,6 +496,8 @@ static ssize_t trigger_request_store(str
 
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	test_firmware = NULL;
 	rc = request_firmware(&test_firmware, name, dev);
 	if (rc) {
@@ -531,6 +540,8 @@ static ssize_t trigger_async_request_sto
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
 	test_firmware = NULL;
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	rc = request_firmware_nowait(THIS_MODULE, 1, name, dev, GFP_KERNEL,
 				     NULL, trigger_async_request_cb);
 	if (rc) {
@@ -573,6 +584,8 @@ static ssize_t trigger_custom_fallback_s
 
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	test_firmware = NULL;
 	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG, name,
 				     dev, GFP_KERNEL, NULL,
@@ -625,6 +638,8 @@ static int test_fw_run_batch_request(voi
 						    TEST_FIRMWARE_BUF_SIZE);
 		if (!req->fw)
 			kfree(test_buf);
+		else
+			req->fw_buf = test_buf;
 	} else {
 		req->rc = test_fw_config->req_firmware(&req->fw,
 						       req->name,
@@ -680,6 +695,7 @@ static ssize_t trigger_batched_requests_
 		req->fw = NULL;
 		req->idx = i;
 		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
 		req->dev = dev;
 		init_completion(&req->completion);
 		req->task = kthread_run(test_fw_run_batch_request, req,
@@ -779,6 +795,7 @@ ssize_t trigger_batched_requests_async_s
 	for (i = 0; i < test_fw_config->num_requests; i++) {
 		req = &test_fw_config->reqs[i];
 		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
 		req->fw = NULL;
 		req->idx = i;
 		init_completion(&req->completion);


