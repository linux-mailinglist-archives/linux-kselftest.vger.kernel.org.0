Return-Path: <linux-kselftest+bounces-7305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A0089A318
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C381C22DE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE78171E64;
	Fri,  5 Apr 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vLvNRChO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vLvNRChO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1A171652;
	Fri,  5 Apr 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336756; cv=none; b=tGO5PLDxGroHAbJwVFS5LITkGhbqL1LNePrfvpyDS9whmSiSBEpuSDdjxTZf9Jb7YRIdJATFwrpFMMBtAsJFNZjJOyb+oMpvnb18h6FtLbO1DuDOHvFKcbqgp+E0nKMDoFxTujLfWW5tCFlq5UGTj3OWMFcHNdl+7PBKCaxC7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336756; c=relaxed/simple;
	bh=wMulK/G+6RPSUybH7+ViBKiUepR9/Avresur9lAF0vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMOcv0XEZ/KbzmCnrmHyMHQSVG4FDUZ+zPrK8jCRT06qWPS+fEs8PyZNqkjYWRRP7hNlW321Og6dZh3JRjXJQGWC1nbjwlQcEP5ReseB+t3HOtNnuxbC4LxQGI/dN4tipjgs/j3tuKwocCLn09S8AJOyBzimTMPZTJZ4NPig65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vLvNRChO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vLvNRChO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 345BC1F7F3;
	Fri,  5 Apr 2024 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zUqm5lIfGuNd8A8EKniU9Rq618E06v9L0Eq25l5kFU=;
	b=vLvNRChO5/oY4AuD2uppLI5q3fvHax4KqhQw6bnqNTRJoWKDfNjMxPI2Drpb37Zh3rNzcB
	NbR07Ev1/P1pO/tFFzY/0hK1L0uJmaTUCC5mTTpOPuQOrJnQsA4Nqlh2cNkoKPPTYI8kik
	3g1GSgj9/oNghqjxBaH2jq22dPZynGI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=vLvNRChO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zUqm5lIfGuNd8A8EKniU9Rq618E06v9L0Eq25l5kFU=;
	b=vLvNRChO5/oY4AuD2uppLI5q3fvHax4KqhQw6bnqNTRJoWKDfNjMxPI2Drpb37Zh3rNzcB
	NbR07Ev1/P1pO/tFFzY/0hK1L0uJmaTUCC5mTTpOPuQOrJnQsA4Nqlh2cNkoKPPTYI8kik
	3g1GSgj9/oNghqjxBaH2jq22dPZynGI=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BD9C113AB0;
	Fri,  5 Apr 2024 17:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ePF8LW8vEGYteAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Fri, 05 Apr 2024 17:05:51 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Subject: [RFC PATCH v3 6/9] selftests: cgroup: Add basic tests for pids controller
Date: Fri,  5 Apr 2024 19:05:45 +0200
Message-ID: <20240405170548.15234-7-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405170548.15234-1-mkoutny@suse.com>
References: <20240405170548.15234-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 345BC1F7F3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

This commit adds (and wires in) new test program for checking basic pids
controller functionality -- restricting tasks in a cgroup and correct
event counting.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/test_pids.c | 187 +++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_pids.c

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
index 000000000000..c1c3a3965624
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_pids.c
@@ -0,0 +1,187 @@
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
+ * This test checks that pids.max prevents forking new children above the
+ * specified limit in the cgroup.
+ */
+static int test_pids_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_parent = NULL, *cg_child = NULL;
+	int pid;
+
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
+
+	if (cg_read_key_long(cg_child, "pids.events", "max ") != 0)
+		goto cleanup;
+	if (cg_read_key_long(cg_child, "pids.events", "max.imposed ") != 1)
+		goto cleanup;
+
+	if (cg_read_key_long(cg_parent, "pids.events", "max ") != 1)
+		goto cleanup;
+	if (cg_read_key_long(cg_parent, "pids.events", "max.imposed ") != 1)
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
+	int i, ret = EXIT_SUCCESS;
+
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
2.44.0


