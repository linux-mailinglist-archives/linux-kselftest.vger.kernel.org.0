Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC97422F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjF2JL7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 05:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjF2JL5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 05:11:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD652122;
        Thu, 29 Jun 2023 02:11:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7651A21867;
        Thu, 29 Jun 2023 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688029913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzH1MaaHBG7iINHeBosnRktquhjO5Balbd3OzF+YzWM=;
        b=qCPqhPNIOQIp087JLjr6YsSGfL+Mu8T4lYYPyNm71S1Sq8FsOKyK1pr/RcMVau8YsgNx/4
        GI4v1qqjDWXtyfYAvVGmur3YOr1Z4OkF48oTiURPQl12da+z5X6xXDTkXj8icnTvbOip8u
        nf+2UCHICSXOYOTlurjq9tmg1bwOdHE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 440F813A43;
        Thu, 29 Jun 2023 09:11:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wAfYD9lKnWSMdQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 29 Jun 2023 09:11:53 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 3/3] selftests: cgroup: Add cpuset migrations testcase
Date:   Thu, 29 Jun 2023 11:11:46 +0200
Message-ID: <20230629091146.28801-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629091146.28801-1-mkoutny@suse.com>
References: <20230629091146.28801-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a separate testfile to verify treating permissions when tasks are
migrated on cgroup v2 hierarchy between cpuset cgroups.

In accordance with v2 design, migration should be allowed based on
delegation boundaries (i.e. cgroup.procs permissions) and does not
depend on the migrated object (i.e. unprivileged process can migrate
another process (even privileged) as long as it remains in the original
dedicated scope).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 MAINTAINERS                                  |   1 +
 tools/testing/selftests/cgroup/.gitignore    |   1 +
 tools/testing/selftests/cgroup/Makefile      |   2 +
 tools/testing/selftests/cgroup/test_cpuset.c | 272 +++++++++++++++++++
 4 files changed, 276 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_cpuset.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 50e7056b4383..51a31aab077f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5259,6 +5259,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
 F:	Documentation/admin-guide/cgroup-v1/cpusets.rst
 F:	include/linux/cpuset.h
 F:	kernel/cgroup/cpuset.c
+F:	tools/testing/selftests/cgroup/test_cpuset.c
 F:	tools/testing/selftests/cgroup/test_cpuset_prs.sh
 
 CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index c4a57e69f749..8443a8d46a1c 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -5,4 +5,5 @@ test_freezer
 test_kmem
 test_kill
 test_cpu
+test_cpuset
 wait_inotify
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 3d263747d2ad..dee0f013c7f4 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS += test_core
 TEST_GEN_PROGS += test_freezer
 TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_cpu
+TEST_GEN_PROGS += test_cpuset
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
 
@@ -23,3 +24,4 @@ $(OUTPUT)/test_core: cgroup_util.c
 $(OUTPUT)/test_freezer: cgroup_util.c
 $(OUTPUT)/test_kill: cgroup_util.c
 $(OUTPUT)/test_cpu: cgroup_util.c
+$(OUTPUT)/test_cpuset: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
new file mode 100644
index 000000000000..976ec6f014d8
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_cpuset.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/limits.h>
+#include <signal.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+static int idle_process_fn(const char *cgroup, void *arg)
+{
+	(void)pause();
+	return 0;
+}
+
+static int do_migration_fn(const char *cgroup, void *arg)
+{
+	int object_pid = (int)(size_t)arg;
+
+	if (setuid(TEST_UID))
+		return EXIT_FAILURE;
+
+	// XXX checking /proc/$pid/cgroup would be quicker than wait
+	if (cg_enter(cgroup, object_pid) ||
+	    cg_wait_for_proc_count(cgroup, 1))
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static int do_controller_fn(const char *cgroup, void *arg)
+{
+	const char *child = cgroup;
+	const char *parent = arg;
+
+	if (setuid(TEST_UID))
+		return EXIT_FAILURE;
+
+	if (!cg_read_strstr(child, "cgroup.controllers", "cpuset"))
+		return EXIT_FAILURE;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+cpuset"))
+		return EXIT_FAILURE;
+
+	if (cg_read_strstr(child, "cgroup.controllers", "cpuset"))
+		return EXIT_FAILURE;
+
+	if (cg_write(parent, "cgroup.subtree_control", "-cpuset"))
+		return EXIT_FAILURE;
+
+	if (!cg_read_strstr(child, "cgroup.controllers", "cpuset"))
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+/*
+ * Migrate a process between two sibling cgroups.
+ * The success should only depend on the parent cgroup permissions and not the
+ * migrated process itself (cpuset controller is in place because it uses
+ * security_task_setscheduler() in cgroup v1).
+ */
+static int test_cpuset_perms_object(const char *root, bool allow)
+{
+	char *parent = NULL, *child_src = NULL, *child_dst = NULL;
+	char *parent_procs = NULL, *child_src_procs = NULL, *child_dst_procs = NULL;
+	const uid_t test_euid = TEST_UID;
+	int object_pid = 0;
+	int ret = KSFT_FAIL;
+
+	parent = cg_name(root, "cpuset_test_0");
+	if (!parent)
+		goto cleanup;
+	parent_procs = cg_name(parent, "cgroup.procs");
+	if (!parent_procs)
+		goto cleanup;
+	if (cg_create(parent))
+		goto cleanup;
+
+	child_src = cg_name(parent, "cpuset_test_1");
+	if (!child_src)
+		goto cleanup;
+	child_src_procs = cg_name(child_src, "cgroup.procs");
+	if (!child_src_procs)
+		goto cleanup;
+	if (cg_create(child_src))
+		goto cleanup;
+
+	child_dst = cg_name(parent, "cpuset_test_2");
+	if (!child_dst)
+		goto cleanup;
+	child_dst_procs = cg_name(child_dst, "cgroup.procs");
+	if (!child_dst_procs)
+		goto cleanup;
+	if (cg_create(child_dst))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+cpuset"))
+		goto cleanup;
+
+	if (cg_read_strstr(child_src, "cgroup.controllers", "cpuset") ||
+	    cg_read_strstr(child_dst, "cgroup.controllers", "cpuset"))
+		goto cleanup;
+
+	/* Enable permissions along src->dst tree path */
+	if (chown(child_src_procs, test_euid, -1) ||
+	    chown(child_dst_procs, test_euid, -1))
+		goto cleanup;
+
+	if (allow && chown(parent_procs, test_euid, -1))
+		goto cleanup;
+
+	/* Fork a privileged child as a test object */
+	object_pid = cg_run_nowait(child_src, idle_process_fn, NULL);
+	if (object_pid < 0)
+		goto cleanup;
+
+	/* Carry out migration in a child process that can drop all privileges
+	 * (including capabilities), the main process must remain privileged for
+	 * cleanup.
+	 * Child process's cgroup is irrelevant but we place it into child_dst
+	 * as hacky way to pass information about migration target to the child.
+	 */
+	if (allow ^ (cg_run(child_dst, do_migration_fn, (void *)(size_t)object_pid) == EXIT_SUCCESS))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (object_pid > 0) {
+		(void)kill(object_pid, SIGTERM);
+		(void)clone_reap(object_pid, WEXITED);
+	}
+
+	cg_destroy(child_dst);
+	free(child_dst_procs);
+	free(child_dst);
+
+	cg_destroy(child_src);
+	free(child_src_procs);
+	free(child_src);
+
+	cg_destroy(parent);
+	free(parent_procs);
+	free(parent);
+
+	return ret;
+}
+
+static int test_cpuset_perms_object_allow(const char *root)
+{
+	return test_cpuset_perms_object(root, true);
+}
+
+static int test_cpuset_perms_object_deny(const char *root)
+{
+	return test_cpuset_perms_object(root, false);
+}
+
+/*
+ * Migrate a process between parent and child implicitely
+ * Implicit migration happens when a controller is enabled/disabled.
+ *
+ */
+static int test_cpuset_perms_subtree(const char *root)
+{
+	char *parent = NULL, *child = NULL;
+	char *parent_procs = NULL, *parent_subctl = NULL, *child_procs = NULL;
+	const uid_t test_euid = TEST_UID;
+	int object_pid = 0;
+	int ret = KSFT_FAIL;
+
+	parent = cg_name(root, "cpuset_test_0");
+	if (!parent)
+		goto cleanup;
+	parent_procs = cg_name(parent, "cgroup.procs");
+	if (!parent_procs)
+		goto cleanup;
+	parent_subctl = cg_name(parent, "cgroup.subtree_control");
+	if (!parent_subctl)
+		goto cleanup;
+	if (cg_create(parent))
+		goto cleanup;
+
+	child = cg_name(parent, "cpuset_test_1");
+	if (!child)
+		goto cleanup;
+	child_procs = cg_name(child, "cgroup.procs");
+	if (!child_procs)
+		goto cleanup;
+	if (cg_create(child))
+		goto cleanup;
+
+	/* Enable permissions as in a delegated subtree */
+	if (chown(parent_procs, test_euid, -1) ||
+	    chown(parent_subctl, test_euid, -1) ||
+	    chown(child_procs, test_euid, -1))
+		goto cleanup;
+
+	/* Put a privileged child in the subtree and modify controller state
+	 * from an unprivileged process, the main process remains privileged
+	 * for cleanup.
+	 * The unprivileged child runs in subtree too to avoid parent and
+	 * internal-node constraing violation.
+	 */
+	object_pid = cg_run_nowait(child, idle_process_fn, NULL);
+	if (object_pid < 0)
+		goto cleanup;
+
+	if (cg_run(child, do_controller_fn, parent) != EXIT_SUCCESS)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (object_pid > 0) {
+		(void)kill(object_pid, SIGTERM);
+		(void)clone_reap(object_pid, WEXITED);
+	}
+
+	cg_destroy(child);
+	free(child_procs);
+	free(child);
+
+	cg_destroy(parent);
+	free(parent_subctl);
+	free(parent_procs);
+	free(parent);
+
+	return ret;
+}
+
+
+#define T(x) { x, #x }
+struct cpuset_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_cpuset_perms_object_allow),
+	T(test_cpuset_perms_object_deny),
+	T(test_cpuset_perms_subtree),
+};
+#undef T
+
+int main(int argc, char *argv[])
+{
+	char root[PATH_MAX];
+	int i, ret = EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "cpuset"))
+		if (cg_write(root, "cgroup.subtree_control", "+cpuset"))
+			ksft_exit_skip("Failed to set cpuset controller\n");
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ret = EXIT_FAILURE;
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	return ret;
+}
-- 
2.41.0

