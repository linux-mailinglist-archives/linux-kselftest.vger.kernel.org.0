Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2215457F819
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jul 2022 04:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiGYCAQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jul 2022 22:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGYCAQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jul 2022 22:00:16 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B459F21B3;
        Sun, 24 Jul 2022 19:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6Zj5A
        pdAiEx8X+QuboEHsQ4u/PvScDJ4OjKZQgS8oPA=; b=HFP7K6XiYK5KmBAOJ2Q4K
        uY2lA7Q85TbTio/W4FC8TZUyLvFL5dxDaKAxxWHz3++1EOmeLsguOgXaRj1GEQKu
        JukR5wQn6Jyto57IkOwmQ5K9X1HaVcjXpY1ia+DFLrhd1NV+DLFR9+9kTrjuVI84
        aZxuEHRHmOz4AtYK5dQes8=
Received: from localhost.localdomain (unknown [112.97.48.126])
        by smtp5 (Coremail) with SMTP id HdxpCgCn_dTo+N1i1CHWQA--.190S2;
        Mon, 25 Jul 2022 09:59:08 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     tglx@linutronix.de, mingo@redhat.com, shuah@kernel.org,
        peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] selftests: futex: Fix typo 'the the' in comment
Date:   Mon, 25 Jul 2022 09:59:03 +0800
Message-Id: <20220725015903.5449-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgCn_dTo+N1i1CHWQA--.190S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyDGF1DKFyDJr4fZrWUurg_yoWDJFc_Kr
        4DJrZ7Xrs8GFn5tr10ya13ur4xG34UuF48CrW5WF47KFn0yFW5Aw4kAr48AFyrWw43Ary2
        gFnxXrs8K3W3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRJu4j7UUUUU==
X-Originating-IP: [112.97.48.126]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGQ1JZFyPdo1IBwAAse
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 .../futex/functional/futex_requeue_pi_signal_restart.c          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
index f8c43ce8fe66..c6b8f32990c8 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
@@ -184,7 +184,7 @@ int main(int argc, char *argv[])
 		/*
 		 * If res is non-zero, we either requeued the waiter or hit an
 		 * error, break out and handle it. If it is zero, then the
-		 * signal may have hit before the the waiter was blocked on f1.
+		 * signal may have hit before the waiter was blocked on f1.
 		 * Try again.
 		 */
 		if (res > 0) {
-- 
2.25.1

