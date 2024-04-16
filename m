Return-Path: <linux-kselftest+bounces-8157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC308A6E09
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C25B2741F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CD9134738;
	Tue, 16 Apr 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KF5rdz/k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KF5rdz/k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959D1304B4;
	Tue, 16 Apr 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277221; cv=none; b=Saw9wpR4Tzuw5PgmqyXCQbbaxxBBstlIAEgs7N8rYDtOEV3cNGC4a9AjaFbFCtifF5Va01t5cACuX3JQ80jAzjIoUZH2fMFV1EGX/Xc4qsTp48WdmqVktQY0itVJOk12AiM994X1E+ENgr7dZXgVqsHPENPPJQ9Sfp90w88CncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277221; c=relaxed/simple;
	bh=3jGZQApJ9fWbuggQ4IbzhCB3DJkJBT9AZ/zmJVg8UUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPeE+AqhX2r0HLz/3QENa6xsPPlpYgFLZlhuYBGs7kELaxLBPcdW/umlPgSEpeGVLly289gVydrWjyN9XN2rarFz/6H03vCp2+38fWf6mHN8IhgboC5uQHpS3PagAmfAz+v5HEH+DfeMLUNx+cdvEmCFYGbLhuSt1Oe0PkN7Lgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KF5rdz/k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KF5rdz/k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AF0A5F890;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iv3fNv8LLYJHp4fC3CC5bwMdRNSE7gN5K/TlvWEl93E=;
	b=KF5rdz/ksFIVU9XivjIiExKMDfAKRwB3083NjlRwt8bh/hfvnLYnoLiBx05jOA1gge8W1r
	7ZNhzjqdGcEMcszMBnq90cEM2rSi9QoHTz7koLOd5UqE79MP38ijtG50bXgLcPLRgJlvTg
	+/9sC7gmY6ph9M8MWKnvu/9l3Mdkmx0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iv3fNv8LLYJHp4fC3CC5bwMdRNSE7gN5K/TlvWEl93E=;
	b=KF5rdz/ksFIVU9XivjIiExKMDfAKRwB3083NjlRwt8bh/hfvnLYnoLiBx05jOA1gge8W1r
	7ZNhzjqdGcEMcszMBnq90cEM2rSi9QoHTz7koLOd5UqE79MP38ijtG50bXgLcPLRgJlvTg
	+/9sC7gmY6ph9M8MWKnvu/9l3Mdkmx0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CC7B13931;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GKiDFiCJHmbAbQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 16 Apr 2024 14:20:16 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v4 6/6] selftests: cgroup: Add basic tests for pids controller
Date: Tue, 16 Apr 2024 16:20:14 +0200
Message-ID: <20240416142014.27630-7-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416142014.27630-1-mkoutny@suse.com>
References: <20240416142014.27630-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL6j1h7wxugqfdyj8pnx7tibp9)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

This commit adds (and wires in) new test program for checking basic pids
controller functionality -- restricting tasks in a cgroup and correct
event counting.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/.gitignore  |   1 +
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/test_pids.c | 178 +++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_pids.c

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index ec635a0ef488..952e4448bf07 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -7,5 +7,6 @@ test_hugetlb_memcg
 test_kill
 test_kmem
 test_memcontrol
+test_pids
 test_zswap
 wait_inotify
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index f3e1ef69e88d..f5f0886a2c4a 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_PROGS += test_hugetlb_memcg
 TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_memcontrol
+TEST_GEN_PROGS += test_pids
 TEST_GEN_PROGS += test_zswap
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
@@ -29,4 +30,5 @@ $(OUTPUT)/test_hugetlb_memcg: cgroup_util.c
 $(OUTPUT)/test_kill: cgroup_util.c
 $(OUTPUT)/test_kmem: cgroup_util.c
 $(OUTPUT)/test_memcontrol: cgroup_util.c
+$(OUTPUT)/test_pids: cgroup_util.c
 $(OUTPUT)/test_zswap: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/test_pids.c b/tools/testing/selftests/cgroup/test_pids.c
new file mode 100644
index 000000000000..61f939c9bc24
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_pids.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/limits.h>
+#include <signal.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+static int run_success(const char *cgroup, void *arg)
+{
+	return 0;
+}
+
+static int run_pause(const char *cgroup, void *arg)
+{
+	return pause();
+}
+
+/*
+ * This test checks that pids.max prevents forking new children above the
+ * specified limit in the cgroup.
+ */
+static int test_pids_max(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_pids;
+	int pid;
+
+	cg_pids = cg_name(root, "pids_test");
+	if (!cg_pids)
+		goto cleanup;
+
+	if (cg_create(cg_pids))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_pids, "pids.max", "max\n"))
+		goto cleanup;
+
+	if (cg_write(cg_pids, "pids.max", "2"))
+		goto cleanup;
+
+	if (cg_enter_current(cg_pids))
+		goto cleanup;
+
+	pid = cg_run_nowait(cg_pids, run_pause, NULL);
+	if (pid < 0)
+		goto cleanup;
+
+	if (cg_run_nowait(cg_pids, run_success, NULL) != -1 || errno != EAGAIN)
+		goto cleanup;
+
+	if (kill(pid, SIGINT))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	cg_destroy(cg_pids);
+	free(cg_pids);
+
+	return ret;
+}
+
+/*
+ * This test checks that pids.events are counted in cgroup associated with pids.max
+ */
+static int test_pids_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_parent = NULL, *cg_child = NULL;
+	int pid;
+
+	cg_parent = cg_name(root, "pids_parent");
+	cg_child = cg_name(cg_parent, "pids_child");
+	if (!cg_parent || !cg_child)
+		goto cleanup;
+
+	if (cg_create(cg_parent))
+		goto cleanup;
+	if (cg_write(cg_parent, "cgroup.subtree_control", "+pids"))
+		goto cleanup;
+	if (cg_create(cg_child))
+		goto cleanup;
+
+	if (cg_write(cg_parent, "pids.max", "2"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_child, "pids.max", "max\n"))
+		goto cleanup;
+
+	if (cg_enter_current(cg_child))
+		goto cleanup;
+
+	pid = cg_run_nowait(cg_child, run_pause, NULL);
+	if (pid < 0)
+		goto cleanup;
+
+	if (cg_run_nowait(cg_child, run_success, NULL) != -1 || errno != EAGAIN)
+		goto cleanup;
+
+	if (kill(pid, SIGINT))
+		goto cleanup;
+
+	if (cg_read_key_long(cg_child, "pids.events", "max ") != 0)
+		goto cleanup;
+	if (cg_read_key_long(cg_parent, "pids.events", "max ") != 1)
+		goto cleanup;
+
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	if (cg_child)
+		cg_destroy(cg_child);
+	if (cg_parent)
+		cg_destroy(cg_parent);
+	free(cg_child);
+	free(cg_parent);
+
+	return ret;
+}
+
+
+
+#define T(x) { x, #x }
+struct pids_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_pids_max),
+	T(test_pids_events),
+};
+#undef T
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	/*
+	 * Check that pids controller is available:
+	 * pids is listed in cgroup.controllers
+	 */
+	if (cg_read_strstr(root, "cgroup.controllers", "pids"))
+		ksft_exit_skip("pids controller isn't available\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "pids"))
+		if (cg_write(root, "cgroup.subtree_control", "+pids"))
+			ksft_exit_skip("Failed to set pids controller\n");
+
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	ksft_finished();
+}
-- 
2.44.0


