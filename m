Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D311B0964
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 14:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgDTMeD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 08:34:03 -0400
Received: from mail.loongson.cn ([114.242.206.163]:52242 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbgDTMeC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 08:34:02 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb9uzlp1eHSgqAA--.29S5;
        Mon, 20 Apr 2020 20:33:59 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v3 3/4] kmod: Return directly if module name is empty in request_module()
Date:   Mon, 20 Apr 2020 20:33:54 +0800
Message-Id: <1587386035-5188-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
References: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb9uzlp1eHSgqAA--.29S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW8urWkur1fGry7XF45GFg_yoW8GFWxpF
        45AFWFqr4ftw1qva97Jr95WFyYgrZrGrsxXFs5Crs3AF98trnFyrn8G3WYgrW5uF4Fgr1j
        yr4vvr15uryUuF7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxV
        Aaw2AFwI0_GFv_Wrylc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4U
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
        4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
        daVFxhVjvjDU0xZFpf9x0pRwqXdUUUUU=
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

v3:
  - no changes

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

