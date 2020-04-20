Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634E31B0751
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 13:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgDTLXI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 07:23:08 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42920 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbgDTLXG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 07:23:06 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2sXhp1ePiEqAA--.6S3;
        Mon, 20 Apr 2020 19:23:04 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v2 2/4] kmod: Remove redundant "be an" in the comment
Date:   Mon, 20 Apr 2020 19:23:00 +0800
Message-Id: <1587381782-31047-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587381782-31047-1-git-send-email-yangtiezhu@loongson.cn>
References: <1587381782-31047-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxj2sXhp1ePiEqAA--.6S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF48ZrW8WF1rGr1rCrWkXrb_yoWDXFb_Wa
        18A3W7K34DCr9I9w1kta13ZrWvgrWvv34xCa1xt3y8t3s7Jrn0qwsxGFZYyrnxGaykGrs8
        Ca9rZ3s09r13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4kMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjIJPtUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There exists redundant "be an" in the comment, remove it.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - just add Acked-by tag

 kernel/kmod.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/kmod.c b/kernel/kmod.c
index 37c3c4b..3cd075c 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -36,9 +36,8 @@
  *
  * If you need less than 50 threads would mean we're dealing with systems
  * smaller than 3200 pages. This assumes you are capable of having ~13M memory,
- * and this would only be an be an upper limit, after which the OOM killer
- * would take effect. Systems like these are very unlikely if modules are
- * enabled.
+ * and this would only be an upper limit, after which the OOM killer would take
+ * effect. Systems like these are very unlikely if modules are enabled.
  */
 #define MAX_KMOD_CONCURRENT 50
 static atomic_t kmod_concurrent_max = ATOMIC_INIT(MAX_KMOD_CONCURRENT);
-- 
2.1.0

