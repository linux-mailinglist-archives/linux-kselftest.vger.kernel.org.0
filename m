Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5824313D331
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 05:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgAPEgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 23:36:20 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54564 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730970AbgAPEgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 23:36:19 -0500
Received: by mail-pl1-f201.google.com with SMTP id f10so8096647plr.21
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2020 20:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lOS4ewWznrG+/0jceSUIoLxZFs2qMA4l+9gH32rT8ZU=;
        b=WStbr0MJSOPJGqzN2iGhIkdauZViO9hiPHW8Uj0CQFi0U3cTaC+CtBLstGwqiu/okm
         HwJonDO4S20K4z1FseDh/ERI2uZPRo9aoKkZjNyJR4eLMsIuCWvGzCPrdTwlUbyFeq18
         4aadRAQl8JLnnKuLbKXV8Kf5PuQGXgWmjRQGIXV6jLyRE55XPV46346RsbUI5pwP646F
         W7Zi4/hotQx4xNZHbfw2SyYexpMQ3MwhPt1at98Ah5V6RNdVvM3CwauYeM00GAr+WM2Y
         A8r1y2CyypILKIp6eJzku7HKEflikMjfc9K1prTtvGNz2mox+pXGPh+YGIgEKaDqqfYW
         KcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lOS4ewWznrG+/0jceSUIoLxZFs2qMA4l+9gH32rT8ZU=;
        b=qgOo9cq7YDi8N1NonbjHUiMIUxsgTlWE0VwghuC7v/oGa4sM9CJ8Qp7INkktLe1Qsz
         gszvhiUIlv18X4ZJ+HS31EMszsxzW6IVrVm0ScrmJ9ZP/sHvOy5ypJJT4rq4Qfg8gqEc
         nrL3F611NpJjltazEt9WmuRIgsMLqPFyp6AnckvlduWxfFbUOvCHPgFSMXHKp8Vyr53Z
         Y+YHXqR4oMKhz79xmuG2OLPKMqEQ3PMkWdmLJ4mAUg0N5jPeOg4+/yEMvh7aS/rF+weO
         zL4q2czkeNgvO7uJrZQ7dHm9r218ezsQ6AqpW0RDgay6AFSmqYAbNKcXSry+UEbLHz8w
         nr6g==
X-Gm-Message-State: APjAAAUH1+pFUN3qa2+U/pFkBpBmtuB89NbCFqlOeqPUMx5TQvPHljLg
        pcMSTnrBNp1zTWOIP3uo1PffdRGavJE=
X-Google-Smtp-Source: APXvYqzbKGjnpLecCWg4B+/ttVo20VzbmxlVS+5fmmSGkVQcYwu4EGAJJ4ZismsmxqM/zsKwRtOeqsmsDUk=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr37413032pgf.91.1579149378890;
 Wed, 15 Jan 2020 20:36:18 -0800 (PST)
Date:   Wed, 15 Jan 2020 20:36:12 -0800
In-Reply-To: <20200116043612.52782-1-surenb@google.com>
Message-Id: <20200116043612.52782-2-surenb@google.com>
Mime-Version: 1.0
References: <20200116043612.52782-1-surenb@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH 2/2] kselftest/cgroup: add cgroup destruction test
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        matthias.bgg@gmail.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, shuah@kernel.org, guro@fb.com,
        alex.shi@linux.alibaba.com, mkoutny@suse.com,
        linux-kselftest@vger.kernel.org, linger.lee@mediatek.com,
        tomcherry@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new test to verify that a cgroup with dead processes can be destroyed.
The test spawns a child process which allocates and touches 100MB of RAM
to ensure prolonged exit. Subsequently it kills the child, waits until
the cgroup containing the child is empty and destroys the cgroup.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/cgroup/test_core.c | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index c5ca669feb2b..2a5242ec1a49 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -2,7 +2,10 @@
 
 #include <linux/limits.h>
 #include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
 #include <unistd.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <errno.h>
 #include <signal.h>
@@ -12,6 +15,115 @@
 #include "../kselftest.h"
 #include "cgroup_util.h"
 
+static int touch_anon(char *buf, size_t size)
+{
+	int fd;
+	char *pos = buf;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	while (size > 0) {
+		ssize_t ret = read(fd, pos, size);
+
+		if (ret < 0) {
+			if (errno != EINTR) {
+				close(fd);
+				return -1;
+			}
+		} else {
+			pos += ret;
+			size -= ret;
+		}
+	}
+	close(fd);
+
+	return 0;
+}
+
+static int alloc_and_touch_anon_noexit(const char *cgroup, void *arg)
+{
+	int ppid = getppid();
+	size_t size = (size_t)arg;
+	void *buf;
+
+	buf = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON,
+		   0, 0);
+	if (buf == MAP_FAILED)
+		return -1;
+
+	if (touch_anon((char *)buf, size)) {
+		munmap(buf, size);
+		return -1;
+	}
+
+	while (getppid() == ppid)
+		sleep(1);
+
+	munmap(buf, size);
+	return 0;
+}
+
+/*
+ * Create a child process that allocates and touches 100MB, then waits to be
+ * killed. Wait until the child is attached to the cgroup, kill all processes
+ * in that cgroup and wait until "cgroup.events" is empty. At this point try to
+ * destroy the empty cgroup. The test helps detect race conditions between
+ * dying processes leaving the cgroup and cgroup destruction path.
+ */
+static int test_cgcore_destroy(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_test = NULL;
+	int child_pid;
+	char buf[PAGE_SIZE];
+
+	cg_test = cg_name(root, "cg_test");
+
+	if (!cg_test)
+		goto cleanup;
+
+	for (int i = 0; i < 10; i++) {
+		if (cg_create(cg_test))
+			goto cleanup;
+
+		child_pid = cg_run_nowait(cg_test, alloc_and_touch_anon_noexit,
+					  (void *) MB(100));
+
+		if (child_pid < 0)
+			goto cleanup;
+
+		/* wait for the child to enter cgroup */
+		if (cg_wait_for_proc_count(cg_test, 1))
+			goto cleanup;
+
+		if (cg_killall(cg_test))
+			goto cleanup;
+
+		/* wait for cgroup to be empty */
+		while (1) {
+			if (cg_read(cg_test, "cgroup.procs", buf, sizeof(buf)))
+				goto cleanup;
+			if (buf[0] == '\0')
+				break;
+			usleep(1000);
+		}
+
+		if (rmdir(cg_test))
+			goto cleanup;
+
+		if (waitpid(child_pid, NULL, 0) < 0)
+			goto cleanup;
+	}
+	ret = KSFT_PASS;
+cleanup:
+	if (cg_test)
+		cg_destroy(cg_test);
+	free(cg_test);
+	return ret;
+}
+
 /*
  * A(0) - B(0) - C(1)
  *        \ D(0)
@@ -512,6 +624,7 @@ struct corecg_test {
 	T(test_cgcore_populated),
 	T(test_cgcore_proc_migration),
 	T(test_cgcore_thread_migration),
+	T(test_cgcore_destroy),
 };
 #undef T
 
-- 
2.25.0.rc1.283.g88dfdc4193-goog

