Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30DA634BED
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 02:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiKWBDr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 20:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiKWBDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 20:03:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F3E359176;
        Tue, 22 Nov 2022 17:03:44 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxtfBvcX1jiiMAAA--.455S3;
        Wed, 23 Nov 2022 09:03:43 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJldqcX1js24YAA--.45400S4;
        Wed, 23 Nov 2022 09:03:42 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] selftests: ftrace: Use "grep -E" instead of "egrep"
Date:   Wed, 23 Nov 2022 09:03:29 +0800
Message-Id: <1669165413-12035-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
References: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxJldqcX1js24YAA--.45400S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFWUCFyfJr45trW3Gr48WFg_yoW8Aw15pF
        W8ArnxKr47Jayayw4xWrs8ZF4jkFs5J3ykJryrJa13Xan3X3W5XF4IqF1UJFsrXrWkZ3yS
        kas7Aay7ZF4DX3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The latest version of grep claims the egrep is now obsolete so the build
now contains warnings that look like:
	egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the related file to use "grep -E" instead.

  sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/testing/selftests/ftrace`

Here are the steps to install the latest grep:

  wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
  tar xf grep-3.8.tar.gz
  cd grep-3.8 && ./configure && make
  sudo make install
  export PATH=/usr/local/bin:$PATH

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .../testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
index 22bff12..ba10389 100644
--- a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -46,10 +46,10 @@ cat trace
 grep -q "tracer: preemptoff" trace || fail
 
 # Check the end of the section
-egrep -q "5.....us : <stack trace>" trace || fail
+grep -E -q "5.....us : <stack trace>" trace || fail
 
 # Check for 500ms of latency
-egrep -q "latency: 5..... us" trace || fail
+grep -E -q "latency: 5..... us" trace || fail
 
 reset_tracer
 
@@ -69,10 +69,10 @@ cat trace
 grep -q "tracer: irqsoff" trace || fail
 
 # Check the end of the section
-egrep -q "5.....us : <stack trace>" trace || fail
+grep -E -q "5.....us : <stack trace>" trace || fail
 
 # Check for 500ms of latency
-egrep -q "latency: 5..... us" trace || fail
+grep -E -q "latency: 5..... us" trace || fail
 
 reset_tracer
 exit 0
-- 
2.1.0

