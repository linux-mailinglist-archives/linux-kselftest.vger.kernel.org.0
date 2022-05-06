Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE2951D621
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 May 2022 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391134AbiEFLFz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 May 2022 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391128AbiEFLFx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 May 2022 07:05:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C0B666FA3;
        Fri,  6 May 2022 04:02:09 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxMNorAHViuhoMAA--.48869S3;
        Fri, 06 May 2022 19:02:04 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] selftests/ftrace: Save kprobe_events to test log
Date:   Fri,  6 May 2022 19:02:02 +0800
Message-Id: <1651834923-31573-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1651834923-31573-1-git-send-email-yangtiezhu@loongson.cn>
References: <1651834923-31573-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxMNorAHViuhoMAA--.48869S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1fJF4kuFW8WFyfGF45ZFb_yoW8Gryfpa
        93W3Z8Ka18J3W3JryxCw1DGFy09r4kArWUCr1rXry3Zwn5ZF9rJr1IgFWDGF93urZYgry3
        Aw12yry7XFykJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPS14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2
        xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
        W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7V
        UUa9aPUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It may lead to kernel panic when execute the following testcase on mips:

  # cd tools/testing/selftests/ftrace
  # ./ftracetest test.d/kprobe/multiple_kprobes.tc

A preliminary analysis shows that the issue is related with

  echo 1 > events/kprobes/enable

after add the 256 probe points.

In order to find the root cause, I want to verify which probe point has
problem, so it is necessary to save kprobe_events to test log.

With this patch, we can get the 256 probe points in the test log through
the following command:

  # ./ftracetest test.d/kprobe/multiple_kprobes.tc -vvv -k

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index 312d237..be754f5 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -25,6 +25,8 @@ if [ $L -ne 256 ]; then
   exit_fail
 fi
 
+cat kprobe_events >> $testlog
+
 echo 1 > events/kprobes/enable
 echo 0 > events/kprobes/enable
 echo > kprobe_events
-- 
2.1.0

