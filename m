Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379AF1B096B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgDTMeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 08:34:13 -0400
Received: from mail.loongson.cn ([114.242.206.163]:52212 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbgDTMeB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 08:34:01 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb9uzlp1eHSgqAA--.29S3;
        Mon, 20 Apr 2020 20:33:57 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v3 1/4] selftests: kmod: Use variable NAME in kmod_test_0001()
Date:   Mon, 20 Apr 2020 20:33:52 +0800
Message-Id: <1587386035-5188-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
References: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb9uzlp1eHSgqAA--.29S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF48Zry7ZrWfJr1UZF4UXFb_yoWkGwcE9r
        42grn7Cw47AFyUAF4Iv3Z3ZF4qk3WUWr48GryjqFy3Kw12q3Z8Jwn2yr10ya1ruFW5GFZF
        9rWvywnakw429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ryUMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUx3kZUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the variable NAME instead of "\000" directly in kmod_test_0001().

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v3:
  - no changes

v2:
  - just add the Acked-by tag

 tools/testing/selftests/kmod/kmod.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 3702dbc..da60c3b 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -341,7 +341,7 @@ kmod_test_0001_driver()
 
 	kmod_defaults_driver
 	config_num_threads 1
-	printf '\000' >"$DIR"/config_test_driver
+	printf $NAME >"$DIR"/config_test_driver
 	config_trigger ${FUNCNAME[0]}
 	config_expect_result ${FUNCNAME[0]} MODULE_NOT_FOUND
 }
@@ -352,7 +352,7 @@ kmod_test_0001_fs()
 
 	kmod_defaults_fs
 	config_num_threads 1
-	printf '\000' >"$DIR"/config_test_fs
+	printf $NAME >"$DIR"/config_test_fs
 	config_trigger ${FUNCNAME[0]}
 	config_expect_result ${FUNCNAME[0]} -EINVAL
 }
-- 
2.1.0

