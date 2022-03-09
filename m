Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8F4D37DC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 18:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiCIRFe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbiCIRE2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 12:04:28 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600ED1A12BF
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 08:53:07 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11467so19199947b3.12
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=up0ZjJYkj11CLJMtUPIN1KDA4F2/C8IBCg9IKChap0o=;
        b=HwN8CS6ObGV8DZhTlX89r8HZUDJpxNm32Tj1FwpILwagqEwbMOZXQUJCu2ILM6Kh0x
         1fNs0AwwacckqVD5J4kVp5lVYl/oJPXMpOJA7l7cnr/dZ6GwBQCW5uBmJGRkYWVIWR6+
         9hxP/TXKyvCLjK0Afi284KtG2s5m3mjdJhsgH+x9GPwBoniXhix38VdFYofaaghsOFM6
         ilbtN9Ggtrj7Nrl/SkNoVOm2G++OFa3UmVsDZ+N8GxXWOGOuJENXkH8a9EzwFR2grARK
         mt4KSQWSXrIbzjLx7kcR80gZlzPhWnzBvFABP27CDBt6LvaR4Mx/1ZqQkf89pbSliLml
         zlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=up0ZjJYkj11CLJMtUPIN1KDA4F2/C8IBCg9IKChap0o=;
        b=dHpzittGvLu4GLUc+y8bcPwtbkqYyCJy9Z6BOWHyCOCvfVrf2z/L5q9vkbVwM+5TDL
         c0c8pIt1RvQDJvnlHYJF8472QuNs8Ipsa8ypptlD8RtxB50DuMM18jsNjlWNiBDT1wu6
         SQpzfYpNKM3foWz5ry8naxTmex8yzIcLG5w5leIJtO25gMN+DUM/0ec7gbRKKxI/DTf5
         GOrktltJfJVwhnF5OWHVVBSL7R5BW+ZYSC5qPSq6q6+Z+Sz1Bkh/mnIFmAYAB9vG0HgZ
         gNxc0PxtPk3+4ZR5zvyWdeh7amvT/DkPslCz9m/qpjF8LVyOZ+q6pxygosM61pc1x4yR
         xAZw==
X-Gm-Message-State: AOAM53153F3n/Wn7RHn5VviteXtg52DRtdMz6dAcTtJoXGcwj/FLnkH7
        h8N7z9GH+R9jWRAExy+yT+w6Cswqcd5Tghc=
X-Google-Smtp-Source: ABdhPJwstClxIW/GRdmGa/Sp1EQb++iy7HiAqSgwmMVmvFVw9rwxEmQwaZhdpSYO/gDHjaMGoa/0onkxNq8jbeQ=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a81:a552:0:b0:2dc:15ce:21e with SMTP id
 v18-20020a81a552000000b002dc15ce021emr605576ywg.250.1646844779851; Wed, 09
 Mar 2022 08:52:59 -0800 (PST)
Date:   Wed,  9 Mar 2022 16:52:18 +0000
In-Reply-To: <20220309165222.2843651-1-tjmercier@google.com>
Message-Id: <20220309165222.2843651-9-tjmercier@google.com>
Mime-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [RFC v3 8/8] selftests: Add binder cgroup gpu memory transfer test
From:   "T.J. Mercier" <tjmercier@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kaleshsingh@google.com, Kenny.Ho@amd.com,
        "T.J. Mercier" <tjmercier@google.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test verifies that the cgroup GPU memory charge is transferred
correctly when a dmabuf is passed between processes in two different
cgroups and the sender specifies BINDER_BUFFER_FLAG_SENDER_NO_NEED in the
binder transaction data containing the dmabuf file descriptor.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 .../selftests/drivers/android/binder/Makefile |   8 +
 .../drivers/android/binder/binder_util.c      | 254 +++++++++
 .../drivers/android/binder/binder_util.h      |  32 ++
 .../selftests/drivers/android/binder/config   |   4 +
 .../binder/test_dmabuf_cgroup_transfer.c      | 480 ++++++++++++++++++
 5 files changed, 778 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/android/binder/Makefile
 create mode 100644 tools/testing/selftests/drivers/android/binder/binder_util.c
 create mode 100644 tools/testing/selftests/drivers/android/binder/binder_util.h
 create mode 100644 tools/testing/selftests/drivers/android/binder/config
 create mode 100644 tools/testing/selftests/drivers/android/binder/test_dmabuf_cgroup_transfer.c

diff --git a/tools/testing/selftests/drivers/android/binder/Makefile b/tools/testing/selftests/drivers/android/binder/Makefile
new file mode 100644
index 000000000000..726439d10675
--- /dev/null
+++ b/tools/testing/selftests/drivers/android/binder/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wall
+
+TEST_GEN_PROGS = test_dmabuf_cgroup_transfer
+
+include ../../../lib.mk
+
+$(OUTPUT)/test_dmabuf_cgroup_transfer: ../../../cgroup/cgroup_util.c binder_util.c
diff --git a/tools/testing/selftests/drivers/android/binder/binder_util.c b/tools/testing/selftests/drivers/android/binder/binder_util.c
new file mode 100644
index 000000000000..c9dcf5b9d42b
--- /dev/null
+++ b/tools/testing/selftests/drivers/android/binder/binder_util.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "binder_util.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+
+#include <linux/limits.h>
+#include <linux/android/binder.h>
+#include <linux/android/binderfs.h>
+
+static const size_t BINDER_MMAP_SIZE = 64 * 1024;
+
+static void binderfs_unmount(const char *mountpoint)
+{
+	if (umount2(mountpoint, MNT_DETACH))
+		fprintf(stderr, "Failed to unmount binderfs at %s: %s\n",
+			mountpoint, strerror(errno));
+	else
+		fprintf(stderr, "Binderfs unmounted: %s\n", mountpoint);
+
+	if (rmdir(mountpoint))
+		fprintf(stderr, "Failed to remove binderfs mount %s: %s\n",
+			mountpoint, strerror(errno));
+	else
+		fprintf(stderr, "Binderfs mountpoint destroyed: %s\n", mountpoint);
+}
+
+struct binderfs_ctx create_binderfs(const char *name)
+{
+	int fd, ret, saved_errno;
+	struct binderfs_device device = { 0 };
+	struct binderfs_ctx ctx = { 0 };
+
+	/*
+	 * P_tmpdir is set to "/tmp/" on Android platforms where Binder is most
+	 * commonly used, but this path does not actually exist on Android. We
+	 * will first try using "/data/local/tmp" and fallback to P_tmpdir if
+	 * that fails for non-Android platforms.
+	 */
+	static const char tmpdir[] = "/data/local/tmp";
+	static const size_t MAX_TMPDIR_SIZE =
+		sizeof(tmpdir) > sizeof(P_tmpdir) ?
+		sizeof(tmpdir) : sizeof(P_tmpdir);
+	static const char template[] = "/binderfs_XXXXXX";
+
+	char *mkdtemp_result;
+	char binderfs_mntpt[MAX_TMPDIR_SIZE + sizeof(template)];
+	char device_path[MAX_TMPDIR_SIZE + sizeof(template) + BINDERFS_MAX_NAME];
+
+	snprintf(binderfs_mntpt, sizeof(binderfs_mntpt), "%s%s", tmpdir, template);
+
+	mkdtemp_result = mkdtemp(binderfs_mntpt);
+	if (mkdtemp_result == NULL) {
+		fprintf(stderr, "Failed to create binderfs mountpoint at %s: %s.\n",
+			binderfs_mntpt, strerror(errno));
+		fprintf(stderr, "Trying fallback mountpoint...\n");
+		snprintf(binderfs_mntpt, sizeof(binderfs_mntpt), "%s%s", P_tmpdir, template);
+		if (mkdtemp(binderfs_mntpt) == NULL) {
+			fprintf(stderr, "Failed to create binderfs mountpoint at %s: %s\n",
+			binderfs_mntpt, strerror(errno));
+			return ctx;
+		}
+	}
+	fprintf(stderr, "Binderfs mountpoint created at %s\n", binderfs_mntpt);
+
+	if (mount(NULL, binderfs_mntpt, "binder", 0, 0)) {
+		perror("Could not mount binderfs");
+		rmdir(binderfs_mntpt);
+		return ctx;
+	}
+	fprintf(stderr, "Binderfs mounted at %s\n", binderfs_mntpt);
+
+	strncpy(device.name, name, sizeof(device.name));
+	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
+	fd = open(device_path, O_RDONLY | O_CLOEXEC);
+	if (!fd) {
+		perror("Failed to open binder-control device");
+		binderfs_unmount(binderfs_mntpt);
+		return ctx;
+	}
+
+	ret = ioctl(fd, BINDER_CTL_ADD, &device);
+	saved_errno = errno;
+	close(fd);
+	errno = saved_errno;
+	if (ret) {
+		perror("Failed to allocate new binder device");
+		binderfs_unmount(binderfs_mntpt);
+		return ctx;
+	}
+
+	fprintf(stderr, "Allocated new binder device with major %d, minor %d, and name %s at %s\n",
+		device.major, device.minor, device.name, binderfs_mntpt);
+
+	ctx.name = strdup(name);
+	ctx.mountpoint = strdup(binderfs_mntpt);
+	return ctx;
+}
+
+void destroy_binderfs(struct binderfs_ctx *ctx)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/%s", ctx->mountpoint, ctx->name);
+
+	if (unlink(path))
+		fprintf(stderr, "Failed to unlink binder device %s: %s\n", path, strerror(errno));
+	else
+		fprintf(stderr, "Destroyed binder %s at %s\n", ctx->name, ctx->mountpoint);
+
+	binderfs_unmount(ctx->mountpoint);
+
+	free(ctx->name);
+	free(ctx->mountpoint);
+}
+
+struct binder_ctx open_binder(struct binderfs_ctx *bfs_ctx)
+{
+	struct binder_ctx ctx = {.fd = -1, .memory = NULL};
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/%s", bfs_ctx->mountpoint, bfs_ctx->name);
+	ctx.fd = open(path, O_RDWR | O_NONBLOCK | O_CLOEXEC);
+	if (ctx.fd < 0) {
+		fprintf(stderr, "Error opening binder device %s: %s\n", path, strerror(errno));
+		return ctx;
+	}
+
+	ctx.memory = mmap(NULL, BINDER_MMAP_SIZE, PROT_READ, MAP_SHARED, ctx.fd, 0);
+	if (ctx.memory == NULL) {
+		perror("Error mapping binder memory");
+		close(ctx.fd);
+		ctx.fd = -1;
+	}
+
+	return ctx;
+}
+
+void close_binder(struct binder_ctx *ctx)
+{
+	if (munmap(ctx->memory, BINDER_MMAP_SIZE))
+		perror("Failed to unmap binder memory");
+	ctx->memory = NULL;
+
+	if (close(ctx->fd))
+		perror("Failed to close binder");
+	ctx->fd = -1;
+}
+
+int become_binder_context_manager(int binder_fd)
+{
+	return ioctl(binder_fd, BINDER_SET_CONTEXT_MGR, 0);
+}
+
+int do_binder_write_read(int binder_fd, void *writebuf, binder_size_t writesize,
+			 void *readbuf, binder_size_t readsize)
+{
+	int err;
+	struct binder_write_read bwr = {
+		.write_buffer = (binder_uintptr_t)writebuf,
+		.write_size = writesize,
+		.read_buffer = (binder_uintptr_t)readbuf,
+		.read_size = readsize
+	};
+
+	do {
+		if (ioctl(binder_fd, BINDER_WRITE_READ, &bwr) >= 0)
+			err = 0;
+		else
+			err = -errno;
+	} while (err == -EINTR);
+
+	if (err < 0) {
+		perror("BINDER_WRITE_READ");
+		return -1;
+	}
+
+	if (bwr.write_consumed < writesize) {
+		fprintf(stderr, "Binder did not consume full write buffer %llu %llu\n",
+			bwr.write_consumed, writesize);
+		return -1;
+	}
+
+	return bwr.read_consumed;
+}
+
+static const char *reply_string(int cmd)
+{
+	switch (cmd) {
+	case BR_ERROR:
+		return("BR_ERROR");
+	case BR_OK:
+		return("BR_OK");
+	case BR_TRANSACTION_SEC_CTX:
+		return("BR_TRANSACTION_SEC_CTX");
+	case BR_TRANSACTION:
+		return("BR_TRANSACTION");
+	case BR_REPLY:
+		return("BR_REPLY");
+	case BR_ACQUIRE_RESULT:
+		return("BR_ACQUIRE_RESULT");
+	case BR_DEAD_REPLY:
+		return("BR_DEAD_REPLY");
+	case BR_TRANSACTION_COMPLETE:
+		return("BR_TRANSACTION_COMPLETE");
+	case BR_INCREFS:
+		return("BR_INCREFS");
+	case BR_ACQUIRE:
+		return("BR_ACQUIRE");
+	case BR_RELEASE:
+		return("BR_RELEASE");
+	case BR_DECREFS:
+		return("BR_DECREFS");
+	case BR_ATTEMPT_ACQUIRE:
+		return("BR_ATTEMPT_ACQUIRE");
+	case BR_NOOP:
+		return("BR_NOOP");
+	case BR_SPAWN_LOOPER:
+		return("BR_SPAWN_LOOPER");
+	case BR_FINISHED:
+		return("BR_FINISHED");
+	case BR_DEAD_BINDER:
+		return("BR_DEAD_BINDER");
+	case BR_CLEAR_DEATH_NOTIFICATION_DONE:
+		return("BR_CLEAR_DEATH_NOTIFICATION_DONE");
+	case BR_FAILED_REPLY:
+		return("BR_FAILED_REPLY");
+	case BR_FROZEN_REPLY:
+		return("BR_FROZEN_REPLY");
+	case BR_ONEWAY_SPAM_SUSPECT:
+		return("BR_ONEWAY_SPAM_SUSPECT");
+	default:
+		return("Unknown");
+	};
+}
+
+int expect_binder_reply(int32_t actual, int32_t expected)
+{
+	if (actual != expected) {
+		fprintf(stderr, "Expected %s but received %s\n",
+			reply_string(expected), reply_string(actual));
+		return -1;
+	}
+	return 0;
+}
+
diff --git a/tools/testing/selftests/drivers/android/binder/binder_util.h b/tools/testing/selftests/drivers/android/binder/binder_util.h
new file mode 100644
index 000000000000..807f5abe987e
--- /dev/null
+++ b/tools/testing/selftests/drivers/android/binder/binder_util.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef SELFTEST_BINDER_UTIL_H
+#define SELFTEST_BINDER_UTIL_H
+
+#include <stdint.h>
+
+#include <linux/android/binder.h>
+
+struct binderfs_ctx {
+	char *name;
+	char *mountpoint;
+};
+
+struct binder_ctx {
+	int fd;
+	void *memory;
+};
+
+struct binderfs_ctx create_binderfs(const char *name);
+void destroy_binderfs(struct binderfs_ctx *ctx);
+
+struct binder_ctx open_binder(struct binderfs_ctx *bfs_ctx);
+void close_binder(struct binder_ctx *ctx);
+
+int become_binder_context_manager(int binder_fd);
+
+int do_binder_write_read(int binder_fd, void *writebuf, binder_size_t writesize,
+			 void *readbuf, binder_size_t readsize);
+
+int expect_binder_reply(int32_t actual, int32_t expected);
+#endif
diff --git a/tools/testing/selftests/drivers/android/binder/config b/tools/testing/selftests/drivers/android/binder/config
new file mode 100644
index 000000000000..fcc5f8f693b3
--- /dev/null
+++ b/tools/testing/selftests/drivers/android/binder/config
@@ -0,0 +1,4 @@
+CONFIG_CGROUP_GPU=y
+CONFIG_ANDROID=y
+CONFIG_ANDROID_BINDERFS=y
+CONFIG_ANDROID_BINDER_IPC=y
diff --git a/tools/testing/selftests/drivers/android/binder/test_dmabuf_cgroup_transfer.c b/tools/testing/selftests/drivers/android/binder/test_dmabuf_cgroup_transfer.c
new file mode 100644
index 000000000000..9b952ab401cc
--- /dev/null
+++ b/tools/testing/selftests/drivers/android/binder/test_dmabuf_cgroup_transfer.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * This test verifies that the cgroup GPU memory charge is transferred correctly
+ * when a dmabuf is passed between processes in two different cgroups and the
+ * sender specifies BINDER_BUFFER_FLAG_SENDER_NO_NEED in the binder transaction
+ * data containing the dmabuf file descriptor.
+ *
+ * The gpu_cgroup_dmabuf_transfer test function becomes the binder context
+ * manager, then forks a child who initiates a transaction with the context
+ * manager by specifying a target of 0. The context manager reply contains a
+ * dmabuf file descriptor which was allocated by the gpu_cgroup_dmabuf_transfer
+ * test function, but should be charged to the child cgroup after the binder
+ * transaction.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/epoll.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "binder_util.h"
+#include "../../../cgroup/cgroup_util.h"
+#include "../../../kselftest.h"
+#include "../../../kselftest_harness.h"
+
+#include <linux/limits.h>
+#include <linux/dma-heap.h>
+#include <linux/android/binder.h>
+
+#define UNUSED(x) ((void)(x))
+
+static const unsigned int BINDER_CODE = 8675309; /* Any number will work here */
+
+struct cgroup_ctx {
+	char *root;
+	char *source;
+	char *dest;
+};
+
+void destroy_cgroups(struct __test_metadata *_metadata, struct cgroup_ctx *ctx)
+{
+	if (ctx->source != NULL) {
+		TH_LOG("Destroying cgroup: %s", ctx->source);
+		rmdir(ctx->source);
+		free(ctx->source);
+	}
+
+	if (ctx->dest != NULL) {
+		TH_LOG("Destroying cgroup: %s", ctx->dest);
+		rmdir(ctx->dest);
+		free(ctx->dest);
+	}
+
+	free(ctx->root);
+	ctx->root = ctx->source = ctx->dest = NULL;
+}
+
+struct cgroup_ctx create_cgroups(struct __test_metadata *_metadata)
+{
+	struct cgroup_ctx ctx = {0};
+	char root[PATH_MAX], *tmp;
+	static const char template[] = "/gpucg_XXXXXX";
+
+	if (cg_find_unified_root(root, sizeof(root))) {
+		TH_LOG("Could not find cgroups root");
+		return ctx;
+	}
+
+	if (cg_read_strstr(root, "cgroup.controllers", "gpu")) {
+		TH_LOG("Could not find GPU controller");
+		return ctx;
+	}
+
+	if (cg_write(root, "cgroup.subtree_control", "+gpu")) {
+		TH_LOG("Could not enable GPU controller");
+		return ctx;
+	}
+
+	ctx.root = strdup(root);
+
+	snprintf(root, sizeof(root), "%s/%s", ctx.root, template);
+	tmp = mkdtemp(root);
+	if (tmp == NULL) {
+		TH_LOG("%s - Could not create source cgroup", strerror(errno));
+		destroy_cgroups(_metadata, &ctx);
+		return ctx;
+	}
+	ctx.source = strdup(tmp);
+
+	snprintf(root, sizeof(root), "%s/%s", ctx.root, template);
+	tmp = mkdtemp(root);
+	if (tmp == NULL) {
+		TH_LOG("%s - Could not create destination cgroup", strerror(errno));
+		destroy_cgroups(_metadata, &ctx);
+		return ctx;
+	}
+	ctx.dest = strdup(tmp);
+
+	TH_LOG("Created cgroups: %s %s", ctx.source, ctx.dest);
+
+	return ctx;
+}
+
+int dmabuf_heap_alloc(int fd, size_t len, int *dmabuf_fd)
+{
+	struct dma_heap_allocation_data data = {
+		.len = len,
+		.fd = 0,
+		.fd_flags = O_RDONLY | O_CLOEXEC,
+		.heap_flags = 0,
+	};
+	int ret;
+
+	if (!dmabuf_fd)
+		return -EINVAL;
+
+	ret = ioctl(fd, DMA_HEAP_IOCTL_ALLOC, &data);
+	if (ret < 0)
+		return ret;
+	*dmabuf_fd = (int)data.fd;
+	return ret;
+}
+
+/* The system heap is known to export dmabufs with support for cgroup tracking */
+int alloc_dmabuf_from_system_heap(struct __test_metadata *_metadata, size_t bytes)
+{
+	int heap_fd = -1, dmabuf_fd = -1;
+	static const char * const heap_path = "/dev/dma_heap/system";
+
+	heap_fd = open(heap_path, O_RDONLY);
+	if (heap_fd < 0) {
+		TH_LOG("%s - open %s failed!\n", strerror(errno), heap_path);
+		return -1;
+	}
+
+	if (dmabuf_heap_alloc(heap_fd, bytes, &dmabuf_fd))
+		TH_LOG("dmabuf allocation failed! - %s", strerror(errno));
+	close(heap_fd);
+
+	return dmabuf_fd;
+}
+
+int binder_request_dmabuf(int binder_fd)
+{
+	int ret;
+
+	/*
+	 * We just send an empty binder_buffer_object to initiate a transaction
+	 * with the context manager, who should respond with a single dmabuf
+	 * inside a binder_fd_array_object.
+	 */
+
+	struct binder_buffer_object bbo = {
+		.hdr.type = BINDER_TYPE_PTR,
+		.flags = 0,
+		.buffer = 0,
+		.length = 0,
+		.parent = 0, /* No parent */
+		.parent_offset = 0 /* No parent */
+	};
+
+	binder_size_t offsets[] = {0};
+
+	struct {
+		int32_t cmd;
+		struct binder_transaction_data btd;
+	} __attribute__((packed)) bc = {
+		.cmd = BC_TRANSACTION,
+		.btd = {
+			.target = { 0 },
+			.cookie = 0,
+			.code = BINDER_CODE,
+			.flags = TF_ACCEPT_FDS, /* We expect a FDA in the reply */
+			.data_size = sizeof(bbo),
+			.offsets_size = sizeof(offsets),
+			.data.ptr = {
+				(binder_uintptr_t)&bbo,
+				(binder_uintptr_t)offsets
+			}
+		},
+	};
+
+	struct {
+		int32_t reply_noop;
+	} __attribute__((packed)) br;
+
+	ret = do_binder_write_read(binder_fd, &bc, sizeof(bc), &br, sizeof(br));
+	if (ret >= sizeof(br) && expect_binder_reply(br.reply_noop, BR_NOOP)) {
+		return -1;
+	} else if (ret < sizeof(br)) {
+		fprintf(stderr, "Not enough bytes in binder reply %d\n", ret);
+		return -1;
+	}
+	return 0;
+}
+
+int send_dmabuf_reply(int binder_fd, struct binder_transaction_data *tr, int dmabuf_fd)
+{
+	int ret;
+	/*
+	 * The trailing 0 is to achieve the necessary alignment for the binder
+	 * buffer_size.
+	 */
+	int fdarray[] = { dmabuf_fd, 0 };
+
+	struct binder_buffer_object bbo = {
+		.hdr.type = BINDER_TYPE_PTR,
+		.flags = BINDER_BUFFER_FLAG_SENDER_NO_NEED,
+		.buffer = (binder_uintptr_t)fdarray,
+		.length = sizeof(fdarray),
+		.parent = 0, /* No parent */
+		.parent_offset = 0 /* No parent */
+	};
+
+	struct binder_fd_array_object bfdao = {
+		.hdr.type = BINDER_TYPE_FDA,
+		.num_fds = 1,
+		.parent = 0, /* The binder_buffer_object */
+		.parent_offset = 0 /* FDs follow immediately */
+	};
+
+	uint64_t sz = sizeof(fdarray);
+	uint8_t data[sizeof(sz) + sizeof(bbo) + sizeof(bfdao)];
+	binder_size_t offsets[] = {sizeof(sz), sizeof(sz)+sizeof(bbo)};
+
+	memcpy(data,                            &sz, sizeof(sz));
+	memcpy(data + sizeof(sz),               &bbo, sizeof(bbo));
+	memcpy(data + sizeof(sz) + sizeof(bbo), &bfdao, sizeof(bfdao));
+
+	struct {
+		int32_t cmd;
+		struct binder_transaction_data_sg btd;
+	} __attribute__((packed)) bc = {
+		.cmd = BC_REPLY_SG,
+		.btd.transaction_data = {
+			.target = { tr->target.handle },
+			.cookie = tr->cookie,
+			.code = BINDER_CODE,
+			.flags = 0,
+			.data_size = sizeof(data),
+			.offsets_size = sizeof(offsets),
+			.data.ptr = {
+				(binder_uintptr_t)data,
+				(binder_uintptr_t)offsets
+			}
+		},
+		.btd.buffers_size = sizeof(fdarray)
+	};
+
+	struct {
+		int32_t reply_noop;
+	} __attribute__((packed)) br;
+
+	ret = do_binder_write_read(binder_fd, &bc, sizeof(bc), &br, sizeof(br));
+	if (ret >= sizeof(br) && expect_binder_reply(br.reply_noop, BR_NOOP)) {
+		return -1;
+	} else if (ret < sizeof(br)) {
+		fprintf(stderr, "Not enough bytes in binder reply %d\n", ret);
+		return -1;
+	}
+	return 0;
+}
+
+struct binder_transaction_data *binder_wait_for_transaction(int binder_fd,
+							    uint32_t *readbuf,
+							    size_t readsize)
+{
+	static const int MAX_EVENTS = 1, EPOLL_WAIT_TIME_MS = 3 * 1000;
+	struct binder_reply {
+		int32_t reply0;
+		int32_t reply1;
+		struct binder_transaction_data btd;
+	} *br;
+	struct binder_transaction_data *ret = NULL;
+	struct epoll_event events[MAX_EVENTS];
+	int epoll_fd, num_events, readcount;
+	uint32_t bc[] = { BC_ENTER_LOOPER };
+
+	do_binder_write_read(binder_fd, &bc, sizeof(bc), NULL, 0);
+
+	epoll_fd = epoll_create1(EPOLL_CLOEXEC);
+	if (epoll_fd == -1) {
+		perror("epoll_create");
+		return NULL;
+	}
+
+	events[0].events = EPOLLIN;
+	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, binder_fd, &events[0])) {
+		perror("epoll_ctl add");
+		goto err_close;
+	}
+
+	num_events = epoll_wait(epoll_fd, events, MAX_EVENTS, EPOLL_WAIT_TIME_MS);
+	if (num_events < 0) {
+		perror("epoll_wait");
+		goto err_ctl;
+	} else if (num_events == 0) {
+		fprintf(stderr, "No events\n");
+		goto err_ctl;
+	}
+
+	readcount = do_binder_write_read(binder_fd, NULL, 0, readbuf, readsize);
+	fprintf(stderr, "Read %d bytes from binder\n", readcount);
+
+	if (readcount < (int)sizeof(struct binder_reply)) {
+		fprintf(stderr, "read_consumed not large enough\n");
+		goto err_ctl;
+	}
+
+	br = (struct binder_reply *)readbuf;
+	if (expect_binder_reply(br->reply0, BR_NOOP))
+		goto err_ctl;
+
+	if (br->reply1 == BR_TRANSACTION) {
+		if (br->btd.code == BINDER_CODE)
+			ret = &br->btd;
+		else
+			fprintf(stderr, "Received transaction with unexpected code: %u\n",
+				br->btd.code);
+	} else {
+		expect_binder_reply(br->reply1, BR_TRANSACTION_COMPLETE);
+	}
+
+err_ctl:
+	if (epoll_ctl(epoll_fd, EPOLL_CTL_DEL, binder_fd, NULL))
+		perror("epoll_ctl del");
+err_close:
+	close(epoll_fd);
+	return ret;
+}
+
+static int child_request_dmabuf_transfer(const char *cgroup, void *arg)
+{
+	UNUSED(cgroup);
+	int ret = -1;
+	uint32_t readbuf[32];
+	struct binderfs_ctx bfs_ctx = *(struct binderfs_ctx *)arg;
+	struct binder_ctx b_ctx;
+
+	fprintf(stderr, "Child PID: %d\n", getpid());
+
+	b_ctx = open_binder(&bfs_ctx);
+	if (b_ctx.fd < 0) {
+		fprintf(stderr, "Child unable to open binder\n");
+		return -1;
+	}
+
+	if (binder_request_dmabuf(b_ctx.fd))
+		goto err;
+
+	/* The child must stay alive until the binder reply is received */
+	if (binder_wait_for_transaction(b_ctx.fd, readbuf, sizeof(readbuf)) == NULL)
+		ret = 0;
+
+	/*
+	 * We don't close the received dmabuf here so that the parent can
+	 * inspect the cgroup gpu memory charges to verify the charge transfer
+	 * completed successfully.
+	 */
+err:
+	close_binder(&b_ctx);
+	fprintf(stderr, "Child done\n");
+	return ret;
+}
+
+TEST(gpu_cgroup_dmabuf_transfer)
+{
+	static const char * const GPUMEM_FILENAME = "gpu.memory.current";
+	static const size_t ONE_MiB = 1024 * 1024;
+
+	int ret, dmabuf_fd;
+	uint32_t readbuf[32];
+	long memsize;
+	pid_t child_pid;
+	struct binderfs_ctx bfs_ctx;
+	struct binder_ctx b_ctx;
+	struct cgroup_ctx cg_ctx;
+	struct binder_transaction_data *tr;
+	struct flat_binder_object *fbo;
+	struct binder_buffer_object *bbo;
+
+	bfs_ctx = create_binderfs("testbinder");
+	if (bfs_ctx.name == NULL)
+		ksft_exit_skip("The Android binderfs filesystem is not available\n");
+
+	cg_ctx = create_cgroups(_metadata);
+	if (cg_ctx.root == NULL) {
+		destroy_binderfs(&bfs_ctx);
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+	}
+
+	ASSERT_EQ(cg_enter_current(cg_ctx.source), 0) {
+		TH_LOG("Could not move parent to cgroup: %s", cg_ctx.source);
+		goto err_cg;
+	}
+
+	dmabuf_fd = alloc_dmabuf_from_system_heap(_metadata, ONE_MiB);
+	ASSERT_GE(dmabuf_fd, 0) {
+		goto err_cg;
+	}
+	TH_LOG("Allocated dmabuf");
+
+	memsize = cg_read_key_long(cg_ctx.source, GPUMEM_FILENAME, "system");
+	ASSERT_EQ(memsize, ONE_MiB) {
+		TH_LOG("GPU memory used after allocation: %ld but it should be %lu",
+		       memsize, (unsigned long)ONE_MiB);
+		goto err_dmabuf;
+	}
+
+	b_ctx = open_binder(&bfs_ctx);
+	ASSERT_GE(b_ctx.fd, 0) {
+		TH_LOG("Parent unable to open binder");
+		goto err_dmabuf;
+	}
+	TH_LOG("Opened binder at %s/%s", bfs_ctx.mountpoint, bfs_ctx.name);
+
+	ASSERT_EQ(become_binder_context_manager(b_ctx.fd), 0) {
+		TH_LOG("Cannot become context manager: %s", strerror(errno));
+		goto err_binder;
+	}
+
+	child_pid = cg_run_nowait(cg_ctx.dest, child_request_dmabuf_transfer, &bfs_ctx);
+	ASSERT_GT(child_pid, 0) {
+		TH_LOG("Error forking: %s", strerror(errno));
+		goto err_binder;
+	}
+
+	tr = binder_wait_for_transaction(b_ctx.fd, readbuf, sizeof(readbuf));
+	ASSERT_NE(tr, NULL) {
+		TH_LOG("Error receiving transaction request from child");
+		goto err_child;
+	}
+	fbo = (struct flat_binder_object *)tr->data.ptr.buffer;
+	ASSERT_EQ(fbo->hdr.type, BINDER_TYPE_PTR) {
+		TH_LOG("Did not receive a buffer object from child");
+		goto err_child;
+	}
+	bbo = (struct binder_buffer_object *)fbo;
+	ASSERT_EQ(bbo->length, 0) {
+		TH_LOG("Did not receive an empty buffer object from child");
+		goto err_child;
+	}
+
+	TH_LOG("Received transaction from child");
+	send_dmabuf_reply(b_ctx.fd, tr, dmabuf_fd);
+
+	ASSERT_EQ(cg_read_key_long(cg_ctx.dest, GPUMEM_FILENAME, "system"), ONE_MiB) {
+		TH_LOG("Destination cgroup does not have system charge!");
+		goto err_child;
+	}
+	ASSERT_EQ(cg_read_key_long(cg_ctx.source, GPUMEM_FILENAME, "system"), 0) {
+		TH_LOG("Source cgroup still has system charge!");
+		goto err_child;
+	}
+	TH_LOG("Charge transfer succeeded!");
+
+err_child:
+	waitpid(child_pid, &ret, 0);
+	if (WIFEXITED(ret))
+		TH_LOG("Child %d terminated with %d", child_pid, WEXITSTATUS(ret));
+	else
+		TH_LOG("Child terminated abnormally");
+err_binder:
+	close_binder(&b_ctx);
+err_dmabuf:
+	close(dmabuf_fd);
+err_cg:
+	destroy_cgroups(_metadata, &cg_ctx);
+	destroy_binderfs(&bfs_ctx);
+}
+
+TEST_HARNESS_MAIN
-- 
2.35.1.616.g0bdcbb4464-goog

