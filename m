Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92E11B0754
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 13:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDTLXM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 07:23:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42936 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgDTLXH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 07:23:07 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2sXhp1ePiEqAA--.6S4;
        Mon, 20 Apr 2020 19:23:04 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v2 3/4] kmod: Return directly if module name is empty in request_module()
Date:   Mon, 20 Apr 2020 19:23:01 +0800
Message-Id: <1587381782-31047-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587381782-31047-1-git-send-email-yangtiezhu@loongson.cn>
References: <1587381782-31047-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxj2sXhp1ePiEqAA--.6S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW8urWkur1fGry7XF45GFg_yoW8GFy5pF
        45AFWFqr4ftw1qya97Jr95WFyYgrZrGrsxXFs5Crs3AF90yrnFyrn8G3WYgrW5uF4rKr1j
        yr4vqr15uryUWFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8KwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUneOLUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If module name is empty, it is better to return directly at the beginning
of request_module() without doing the needless call_modprobe() operation.

Call trace:

request_module()
      |
      |
__request_module()
      |
      |
call_modprobe()
      |
      |
call_usermodehelper_exec() -- retval = sub_info->retval;
      |
      |
call_usermodehelper_exec_work()
      |
      |
call_usermodehelper_exec_sync() -- sub_info->retval = ret;
      |
      | --> call_usermodehelper_exec_async() --> do_execve()
      |
kernel_wait4(pid, (int __user *)&ret, 0, NULL);

sub_info->retval is 256 after call kernel_wait4(), the function
call_usermodehelper_exec() returns sub_info->retval which is 256,
then call_modprobe() and __request_module() returns 256.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - update the commit message to explain the detailed reason

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

