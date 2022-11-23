Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25804634BEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 02:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiKWBDs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 20:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiKWBDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 20:03:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87624BEAF0;
        Tue, 22 Nov 2022 17:03:44 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Axy+pvcX1jjSMAAA--.300S3;
        Wed, 23 Nov 2022 09:03:43 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJldqcX1js24YAA--.45400S5;
        Wed, 23 Nov 2022 09:03:43 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] selftests: powerpc: Use "grep -E" instead of "egrep"
Date:   Wed, 23 Nov 2022 09:03:30 +0800
Message-Id: <1669165413-12035-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
References: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxJldqcX1js24YAA--.45400S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFWUCFykCrW7tF4fur4xXrb_yoW8GF48pa
        48C34YyasYgFy7XF4UGFsFgFW8KF4kA3y0gFWrJryDZFsxAasaqryftF47JFnxGrWktw4r
        ua9akay0kr47GaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07j5l1kUUUUU=
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

  sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/testing/selftests/powerpc`

Here are the steps to install the latest grep:

  wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
  tar xf grep-3.8.tar.gz
  cd grep-3.8 && ./configure && make
  sudo make install
  export PATH=/usr/local/bin:$PATH

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/powerpc/scripts/hmi.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/scripts/hmi.sh b/tools/testing/selftests/powerpc/scripts/hmi.sh
index dcdb392..bcc7b6b 100755
--- a/tools/testing/selftests/powerpc/scripts/hmi.sh
+++ b/tools/testing/selftests/powerpc/scripts/hmi.sh
@@ -36,7 +36,7 @@ trap "ppc64_cpu --smt-snooze-delay=100" 0 1
 
 # for each chip+core combination
 # todo - less fragile parsing
-egrep -o 'OCC: Chip [0-9a-f]+ Core [0-9a-f]' < /sys/firmware/opal/msglog |
+grep -E -o 'OCC: Chip [0-9a-f]+ Core [0-9a-f]' < /sys/firmware/opal/msglog |
 while read chipcore; do
 	chip=$(echo "$chipcore"|awk '{print $3}')
 	core=$(echo "$chipcore"|awk '{print $5}')
-- 
2.1.0

