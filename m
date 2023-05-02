Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B72A6F40EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 12:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjEBKRT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 06:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEBKRR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 06:17:17 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4668F2D4A
        for <linux-kselftest@vger.kernel.org>; Tue,  2 May 2023 03:17:12 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:f07a:92a2:297:162b])
        by baptiste.telenet-ops.be with bizsmtp
        id rmHA290075FQxRj01mHA2t; Tue, 02 May 2023 12:17:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ptn4D-000ymV-Ut;
        Tue, 02 May 2023 12:17:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ptn4H-00AtQ6-UW;
        Tue, 02 May 2023 12:17:09 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] Input: tests - fix use-after-free and refcount underflow in input_test_exit()
Date:   Tue,  2 May 2023 12:17:02 +0200
Message-Id: <957b3b309a44d39fb6e38b2a526b250f69ea3d2c.1683022164.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1683022164.git.geert+renesas@glider.be>
References: <cover.1683022164.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With CONFIG_DEBUG_SLAB=y:

        # Subtest: input_core
        1..3
    input: Test input device as /devices/virtual/input/input1
    8<--- cut here ---
    Unable to handle kernel paging request at virtual address 6b6b6dd7 when read
    ...
     __lock_acquire from lock_acquire+0x26c/0x300
     lock_acquire from _raw_spin_lock_irqsave+0x50/0x64
     _raw_spin_lock_irqsave from devres_remove+0x20/0x7c
     devres_remove from devres_destroy+0x8/0x24
     devres_destroy from input_free_device+0x2c/0x60
     input_free_device from kunit_try_run_case+0x70/0x94 [kunit]

Without CONFIG_DEBUG_SLAB=y:

	KTAP version 1
	# Subtest: input_core
	1..3
    input: Test input device as /devices/virtual/input/input1
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 694 at lib/refcount.c:28 refcount_warn_saturate+0x54/0x100
    refcount_t: underflow; use-after-free.
    ...
    Call Trace: [<0037cad4>] dump_stack+0xc/0x10
     [<00377614>] __warn+0x7e/0xb4
     [<0037768c>] warn_slowpath_fmt+0x42/0x62
     [<001eee1c>] refcount_warn_saturate+0x54/0x100
     [<000b1d34>] kfree_const+0x0/0x20
     [<0036290a>] __kobject_del+0x0/0x6e
     [<001eee1c>] refcount_warn_saturate+0x54/0x100
     [<00362a1a>] kobject_put+0xa2/0xb6
     [<11965770>] kunit_generic_run_threadfn_adapter+0x0/0x1c [kunit]

As per the comments for input_allocate_device() and
input_register_device(), input_free_device() must be called only to free
devices that have not been registered.  input_unregister_device()
already calls input_put_device(), thus leading to a use-after-free.

Moreover, the kunit_suite.exit() method is called after every test case,
even on failures.  As the test itself already does cleanups in its
failure paths, this may lead to a second use-after-free.

Fix the first issue by dropping the call to input_allocate_device() from
input_test_exit().
Fix the second issue by making the cleanup code conditional on a
successful test.

Fixes: fdefcbdd6f361841 ("Input: Add KUnit tests for some of the input core helper functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/tests/input_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
index e5a6c1ad2167c103..8b8ac3412a70d3b4 100644
--- a/drivers/input/tests/input_test.c
+++ b/drivers/input/tests/input_test.c
@@ -43,8 +43,8 @@ static void input_test_exit(struct kunit *test)
 {
 	struct input_dev *input_dev = test->priv;
 
-	input_unregister_device(input_dev);
-	input_free_device(input_dev);
+	if (input_dev)
+		input_unregister_device(input_dev);
 }
 
 static void input_test_poll(struct input_dev *input) { }
-- 
2.34.1

