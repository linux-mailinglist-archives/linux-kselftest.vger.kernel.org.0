Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D606BB609
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 15:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjCOObG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 10:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjCOObC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 10:31:02 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2146B2A15C
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 07:30:34 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by andre.telenet-ops.be with bizsmtp
        id YeWY2900R1C8whw01eWYSs; Wed, 15 Mar 2023 15:30:33 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pcS6R-00CI9L-4A;
        Wed, 15 Mar 2023 15:28:21 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pcS73-00D174-Gj;
        Wed, 15 Mar 2023 15:28:21 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tobias Klausmann <klausman@schwarzvogel.de>
Subject: [PATCH] lib: dhry: Fix unstable smp_processor_id(_) usage
Date:   Wed, 15 Mar 2023 15:28:17 +0100
Message-Id: <b0d29932bb24ad82cea7f821e295c898e9657be0.1678890070.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running the in-kernel Dhrystone benchmark with
CONFIG_DEBUG_PREEMPT=y:

    BUG: using smp_processor_id() in preemptible [00000000] code: bash/938

Fix this by not using smp_processor_id() directly, but instead wrapping
the whole benchmark inside a get_cpu()/put_cpu() pair.  This makes sure
the whole benchmark is run on the same CPU core, and the reported values
are consistent.

Fixes: d5528cc16893f1f6 ("lib: add Dhrystone benchmark test")
Reported-by: Tobias Klausmann <klausman@schwarzvogel.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217179
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/dhry_run.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/dhry_run.c b/lib/dhry_run.c
index f9d33efa6d090604..f15ac666e9d38bd2 100644
--- a/lib/dhry_run.c
+++ b/lib/dhry_run.c
@@ -31,6 +31,7 @@ MODULE_PARM_DESC(iterations,
 
 static void dhry_benchmark(void)
 {
+	unsigned int cpu = get_cpu();
 	int i, n;
 
 	if (iterations > 0) {
@@ -45,9 +46,10 @@ static void dhry_benchmark(void)
 	}
 
 report:
+	put_cpu();
 	if (n >= 0)
-		pr_info("CPU%u: Dhrystones per Second: %d (%d DMIPS)\n",
-			smp_processor_id(), n, n / DHRY_VAX);
+		pr_info("CPU%u: Dhrystones per Second: %d (%d DMIPS)\n", cpu,
+			n, n / DHRY_VAX);
 	else if (n == -EAGAIN)
 		pr_err("Please increase the number of iterations\n");
 	else
-- 
2.34.1

