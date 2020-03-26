Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B561948E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 21:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgCZU15 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 16:27:57 -0400
Received: from smtp-42af.mail.infomaniak.ch ([84.16.66.175]:47847 "EHLO
        smtp-42af.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728798AbgCZU1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 16:27:55 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 48pGkv3QxdzlhYBY;
        Thu, 26 Mar 2020 21:27:51 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48pGkv0VcnzlkchT;
        Thu, 26 Mar 2020 21:27:51 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v15 09/10] samples/landlock: Add a sandbox manager example
Date:   Thu, 26 Mar 2020 21:27:30 +0100
Message-Id: <20200326202731.693608-10-mic@digikod.net>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200326202731.693608-1-mic@digikod.net>
References: <20200326202731.693608-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a basic sandbox tool to launch a command which can only access a
whitelist of file hierarchies in a read-only or read-write way.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v14:
* Fix Kconfig dependency.
* Remove access rights that may be required for FD-only requests:
  mmap, truncate, getattr, lock, chmod, chown, chgrp, ioctl.
* Fix useless hardcoded syscall number.
* Use execvpe().
* Follow symlinks.
* Extend help with common file paths.
* Constify variables.
* Clean up comments.
* Improve error message.

Changes since v11:
* Add back the filesystem sandbox manager and update it to work with the
  new Landlock syscall.

Previous version:
https://lore.kernel.org/lkml/20190721213116.23476-9-mic@digikod.net/
---
 samples/Kconfig              |   7 ++
 samples/Makefile             |   1 +
 samples/landlock/.gitignore  |   1 +
 samples/landlock/Makefile    |  15 +++
 samples/landlock/sandboxer.c | 217 +++++++++++++++++++++++++++++++++++
 5 files changed, 241 insertions(+)
 create mode 100644 samples/landlock/.gitignore
 create mode 100644 samples/landlock/Makefile
 create mode 100644 samples/landlock/sandboxer.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 9d236c346de5..b54408c5bd86 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -120,6 +120,13 @@ config SAMPLE_HIDRAW
 	bool "hidraw sample"
 	depends on HEADERS_INSTALL
 
+config SAMPLE_LANDLOCK
+	bool "Build Landlock sample code"
+	select HEADERS_INSTALL
+	help
+	  Build a simple Landlock sandbox manager able to launch a process
+	  restricted by a user-defined filesystem access-control security policy.
+
 config SAMPLE_PIDFD
 	bool "pidfd sample"
 	depends on HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index f8f847b4f61f..61a2bd216f53 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
 obj-$(CONFIG_SAMPLE_KFIFO)		+= kfifo/
 obj-$(CONFIG_SAMPLE_KOBJECT)		+= kobject/
 obj-$(CONFIG_SAMPLE_KPROBES)		+= kprobes/
+subdir-$(CONFIG_SAMPLE_LANDLOCK)	+= landlock
 obj-$(CONFIG_SAMPLE_LIVEPATCH)		+= livepatch/
 subdir-$(CONFIG_SAMPLE_PIDFD)		+= pidfd
 obj-$(CONFIG_SAMPLE_QMI_CLIENT)		+= qmi/
diff --git a/samples/landlock/.gitignore b/samples/landlock/.gitignore
new file mode 100644
index 000000000000..f43668b2d318
--- /dev/null
+++ b/samples/landlock/.gitignore
@@ -0,0 +1 @@
+/sandboxer
diff --git a/samples/landlock/Makefile b/samples/landlock/Makefile
new file mode 100644
index 000000000000..9dfb571641ba
--- /dev/null
+++ b/samples/landlock/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: BSD-3-Clause
+
+hostprogs-y := sandboxer
+
+always := $(hostprogs-y)
+
+KBUILD_HOSTCFLAGS += -I$(objtree)/usr/include
+
+.PHONY: all clean
+
+all:
+	$(MAKE) -C ../.. samples/landlock/
+
+clean:
+	$(MAKE) -C ../.. M=samples/landlock/ clean
diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
new file mode 100644
index 000000000000..0725371672f9
--- /dev/null
+++ b/samples/landlock/sandboxer.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Simple Landlock sandbox manager able to launch a process restricted by a
+ * user-defined filesystem access-control security policy.
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2020 ANSSI
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <linux/prctl.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#ifndef landlock
+static inline int landlock(const unsigned int command,
+		const unsigned int options,
+		const size_t attr_size, void *const attr_ptr)
+{
+	errno = 0;
+	return syscall(__NR_landlock, command, options, attr_size, attr_ptr, 0,
+			NULL);
+}
+#endif
+
+#define ENV_FS_RO_NAME "LL_FS_RO"
+#define ENV_FS_RW_NAME "LL_FS_RW"
+#define ENV_PATH_TOKEN ":"
+
+static int parse_path(char *env_path, const char ***const path_list)
+{
+	int i, path_nb = 0;
+
+	if (env_path) {
+		path_nb++;
+		for (i = 0; env_path[i]; i++) {
+			if (env_path[i] == ENV_PATH_TOKEN[0])
+				path_nb++;
+		}
+	}
+	*path_list = malloc(path_nb * sizeof(**path_list));
+	for (i = 0; i < path_nb; i++)
+		(*path_list)[i] = strsep(&env_path, ENV_PATH_TOKEN);
+
+	return path_nb;
+}
+
+static int populate_ruleset(
+		const struct landlock_attr_features *const attr_features,
+		const char *const env_var, const int ruleset_fd,
+		const __u64 allowed_access)
+{
+	int path_nb, i;
+	char *env_path_name;
+	const char **path_list = NULL;
+	struct landlock_attr_path_beneath path_beneath = {
+		.ruleset_fd = ruleset_fd,
+		.allowed_access = allowed_access,
+		.parent_fd = -1,
+	};
+
+	env_path_name = getenv(env_var);
+	if (!env_path_name) {
+		fprintf(stderr, "Missing environment variable %s\n", env_var);
+		return 1;
+	}
+	env_path_name = strdup(env_path_name);
+	unsetenv(env_var);
+	path_nb = parse_path(env_path_name, &path_list);
+	if (path_nb == 1 && path_list[0][0] == '\0') {
+		fprintf(stderr, "Missing path in %s\n", env_var);
+		goto err_free_name;
+	}
+
+	/* Follows a best-effort approach. */
+	path_beneath.allowed_access &= attr_features->access_fs;
+	for (i = 0; i < path_nb; i++) {
+		path_beneath.parent_fd = open(path_list[i], O_PATH |
+				O_CLOEXEC);
+		if (path_beneath.parent_fd < 0) {
+			fprintf(stderr, "Failed to open \"%s\": %s\n",
+					path_list[i],
+					strerror(errno));
+			goto err_free_name;
+		}
+		if (landlock(LANDLOCK_CMD_ADD_RULE,
+					LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+					sizeof(path_beneath), &path_beneath)) {
+			fprintf(stderr, "Failed to update the ruleset with \"%s\": %s\n",
+					path_list[i], strerror(errno));
+			close(path_beneath.parent_fd);
+			goto err_free_name;
+		}
+		close(path_beneath.parent_fd);
+	}
+	free(env_path_name);
+	return 0;
+
+err_free_name:
+	free(env_path_name);
+	return 1;
+}
+
+#define ACCESS_FS_ROUGHLY_READ ( \
+	LANDLOCK_ACCESS_FS_EXECUTE | \
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_READ_DIR | \
+	LANDLOCK_ACCESS_FS_CHROOT)
+
+#define ACCESS_FS_ROUGHLY_WRITE ( \
+	LANDLOCK_ACCESS_FS_WRITE_FILE | \
+	LANDLOCK_ACCESS_FS_LINK_TO | \
+	LANDLOCK_ACCESS_FS_RENAME_FROM | \
+	LANDLOCK_ACCESS_FS_RENAME_TO | \
+	LANDLOCK_ACCESS_FS_RMDIR | \
+	LANDLOCK_ACCESS_FS_UNLINK | \
+	LANDLOCK_ACCESS_FS_MAKE_CHAR | \
+	LANDLOCK_ACCESS_FS_MAKE_DIR | \
+	LANDLOCK_ACCESS_FS_MAKE_REG | \
+	LANDLOCK_ACCESS_FS_MAKE_SOCK | \
+	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
+	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
+	LANDLOCK_ACCESS_FS_MAKE_SYM)
+
+int main(const int argc, char *const argv[], char *const *const envp)
+{
+	const char *cmd_path;
+	char *const *cmd_argv;
+	int ruleset_fd;
+	struct landlock_attr_features attr_features;
+	struct landlock_attr_ruleset ruleset = {
+		.handled_access_fs = ACCESS_FS_ROUGHLY_READ |
+			ACCESS_FS_ROUGHLY_WRITE,
+	};
+	struct landlock_attr_enforce attr_enforce = {};
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s=\"...\" %s=\"...\" %s <cmd> [args]...\n\n",
+				ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
+		fprintf(stderr, "Launch a command in a restricted environment.\n\n");
+		fprintf(stderr, "Environment variables containing paths, each separated by a colon:\n");
+		fprintf(stderr, "* %s: list of paths allowed to be used in a read-only way.\n",
+				ENV_FS_RO_NAME);
+		fprintf(stderr, "* %s: list of paths allowed to be used in a read-write way.\n",
+				ENV_FS_RO_NAME);
+		fprintf(stderr, "\nexample:\n"
+				"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
+				"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
+				"%s bash -i\n",
+				ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
+		return 1;
+	}
+
+	if (landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES,
+				sizeof(attr_features), &attr_features)) {
+		perror("Failed to probe the Landlock supported features");
+		switch (errno) {
+		case ENOSYS:
+			fprintf(stderr, "Hint: this kernel does not support Landlock.\n");
+			break;
+		case ENOPKG:
+			fprintf(stderr, "Hint: Landlock is currently disabled. It can be enabled in the kernel configuration or at boot with the \"lsm=landlock\" parameter.\n");
+			break;
+		}
+		return 1;
+	}
+	/* Follows a best-effort approach. */
+	ruleset.handled_access_fs &= attr_features.access_fs;
+	ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
+			LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset),
+			&ruleset);
+	if (ruleset_fd < 0) {
+		perror("Failed to create a ruleset");
+		return 1;
+	}
+	if (populate_ruleset(&attr_features, ENV_FS_RO_NAME, ruleset_fd,
+				ACCESS_FS_ROUGHLY_READ)) {
+		goto err_close_ruleset;
+	}
+	if (populate_ruleset(&attr_features, ENV_FS_RW_NAME, ruleset_fd,
+				ACCESS_FS_ROUGHLY_READ |
+				ACCESS_FS_ROUGHLY_WRITE)) {
+		goto err_close_ruleset;
+	}
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+		perror("Failed to restrict privileges");
+		goto err_close_ruleset;
+	}
+	attr_enforce.ruleset_fd = ruleset_fd;
+	if (landlock(LANDLOCK_CMD_ENFORCE_RULESET,
+				LANDLOCK_OPT_ENFORCE_RULESET,
+				sizeof(attr_enforce), &attr_enforce)) {
+		perror("Failed to enforce ruleset");
+		goto err_close_ruleset;
+	}
+	close(ruleset_fd);
+
+	cmd_path = argv[1];
+	cmd_argv = argv + 1;
+	execvpe(cmd_path, cmd_argv, envp);
+	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
+			strerror(errno));
+	fprintf(stderr, "Hint: access to the binary, the interpreter or shared libraries may be denied.\n");
+	return 1;
+
+err_close_ruleset:
+	close(ruleset_fd);
+	return 1;
+}
-- 
2.26.0.rc2

