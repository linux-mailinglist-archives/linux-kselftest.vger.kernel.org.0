Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F651AEA01
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 07:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgDRFUM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 01:20:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34256 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbgDRFUL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 01:20:11 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj9wAjppe2UQpAA--.8S4;
        Sat, 18 Apr 2020 13:20:03 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 3/4] kmod: Return directly if module name is empty in request_module()
Date:   Sat, 18 Apr 2020 13:19:59 +0800
Message-Id: <1587187200-13109-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxj9wAjppe2UQpAA--.8S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4kAF1DXFy7Jr47Xw45Awb_yoW3ArX_Cw
        17ur98WFZ8trnI9r4UZ3yfXF92g3y8Ca4F9r9rGFWDX34DKasxtw1Syr9aqrZxCrW8JF4D
        Gw15GF9Iqr1fCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbhxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4rMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjG-e5UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If module name is empty, it is better to return directly at the beginning
of request_module() without doing the needless call_modprobe() operation.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/kmod.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kmod.c b/kernel/kmod.c
index 3cd075c..5851444 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -28,6 +28,8 @@
 
 #include <trace/events/module.h>
 
+#define MODULE_NOT_FOUND 256
+
 /*
  * Assuming:
  *
@@ -144,6 +146,9 @@ int __request_module(bool wait, const char *fmt, ...)
 	if (ret >= MODULE_NAME_LEN)
 		return -ENAMETOOLONG;
 
+	if (strlen(module_name) == 0)
+		return MODULE_NOT_FOUND;
+
 	ret = security_kernel_module_request(module_name);
 	if (ret)
 		return ret;
-- 
2.1.0

