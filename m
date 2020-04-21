Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647241B1F6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Apr 2020 09:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDUHFR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Apr 2020 03:05:17 -0400
Received: from mail.loongson.cn ([114.242.206.163]:41452 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbgDUHFR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Apr 2020 03:05:17 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf2ogm55esnIqAA--.25S5;
        Tue, 21 Apr 2020 15:05:07 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v4 3/4] kmod: Return directly if module name is empty in request_module()
Date:   Tue, 21 Apr 2020 15:05:03 +0800
Message-Id: <1587452704-1299-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587452704-1299-1-git-send-email-yangtiezhu@loongson.cn>
References: <1587452704-1299-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxf2ogm55esnIqAA--.25S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4xAr13JF18CrW7GF4kWFg_yoW5GF43pa
        y5AFZ5Krs3t3yjya1xJrs7GryrK3y7JrW3Jr1DCrn3ZFZ0grnrAr1j9w15WFW8ua95Kw1U
        GF4vqw4fWF4Dur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4xMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjNBMtUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If module name is empty, it is better to return directly at the beginning
of request_module() without doing the needless call_modprobe() operation.

(1) In the kernel space

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

The exit status of child process is wrote to the address of variable
"ret" after call kernel_wait4(), its value is 256 if module name is
empty, then sub_info->retval is assigned to "ret" which is 256, the
function call_usermodehelper_exec() returns 256, call_modprobe() and
__request_module() also return 256.

(2)In the user space

when build and execute the following application, we can see the exit
status is 256.

$ ./system
exit status = 256

$ ./execl
exit status = 256

$ cat system.c
#include <stdio.h>
#include <stdlib.h>

int main()
{
	int status = 0;

	status = system("modprobe '' > /dev/null 2>&1");
	printf("exit status = %d\n", status);

	return status;
}

$ cat execl.c
#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int main()
{
	pid_t pid, w;
	int status;

	pid = fork();
	if (pid == -1) {
		perror("fork");
		exit(EXIT_FAILURE);
	}

	if (pid == 0) {
		execl("/bin/sh", "sh", "-c",
		      "modprobe '' > /dev/null 2>&1", (char *) 0);
	} else {
		w = waitpid(pid, &status, 0);
		if (w == -1) {
			perror("waitpid");
			exit(EXIT_FAILURE);
		}

		printf("exit status = %d\n", status);
		exit(EXIT_SUCCESS);
	}

	return 0;
}

The exit status of child process is wrote to the address of variable
"status" after call waitpid() in the user space that corresponds with
kernel_wait4() in the kernel space.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v4:
  - update the commit message with application

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

