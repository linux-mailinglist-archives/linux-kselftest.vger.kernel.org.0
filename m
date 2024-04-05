Return-Path: <linux-kselftest+bounces-7307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C31E89A31D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE801F25135
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88331172764;
	Fri,  5 Apr 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fk2jbyKg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fk2jbyKg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620B171664;
	Fri,  5 Apr 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336756; cv=none; b=ZYXTU8ECDuWyzajDF02B2KSkNWR4rd6IswH893RvGvtWZQJoqZbmcR8Qw9ioY8i/VdO4P4YhDPZPIsJ9D0NhJcA+evkwP7Y9Oz6ZHy3Z972GNSN2mdcORvyMg1oFYxXS0j7HoAAYOh18WnPFwJvdD6VtF4iJJ4C+jKJLonFx1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336756; c=relaxed/simple;
	bh=KkUoBQzcMlALn6Mccqa0ttzzH8E9KfZ2WpkSFjPxReY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMKa/pXMl/SOMFNH2XNKTqMSFxmmewKZhsL3zbI0ZAtxQ1Jr/yMR7W78lvAWa6piNWvK2twPItCz83WzaFf2L5XPRd1NbgMrEk9yP6C8OPKb+3B+d9662MapzvfLf3PV970qONoa0nesDJODBmrhkpvc4dfqMUcv5DjMxIBHel4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fk2jbyKg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fk2jbyKg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BA1F1F7F5;
	Fri,  5 Apr 2024 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f58r1/3r4ZhM3ZTHBh4+rovDyyYzto8nSN21lk4LFNA=;
	b=fk2jbyKgGaJewq044j7MheRtW861laTS2bkyTMluUaZ6Z+8hhWCZ9sGsitJyH+P0U10nHZ
	2nlIkm+N9/oeHcK/1+y6+/V9TRMkY3Np99FJlBUtYOkJDedjYWk47zd3t+25IDPJj0EkZ1
	VAKIONB6BZxsrFDoJCWCfthENJrS4zY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fk2jbyKg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f58r1/3r4ZhM3ZTHBh4+rovDyyYzto8nSN21lk4LFNA=;
	b=fk2jbyKgGaJewq044j7MheRtW861laTS2bkyTMluUaZ6Z+8hhWCZ9sGsitJyH+P0U10nHZ
	2nlIkm+N9/oeHcK/1+y6+/V9TRMkY3Np99FJlBUtYOkJDedjYWk47zd3t+25IDPJj0EkZ1
	VAKIONB6BZxsrFDoJCWCfthENJrS4zY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5668213AAA;
	Fri,  5 Apr 2024 17:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +KhtFHAvEGYteAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Fri, 05 Apr 2024 17:05:52 +0000
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
Subject: [RFC PATCH v3 9/9] selftests: cgroup: Add tests pids controller
Date: Fri,  5 Apr 2024 19:05:48 +0200
Message-ID: <20240405170548.15234-10-mkoutny@suse.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfcexjtczxtbnj559fj95g6y7)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7BA1F1F7F5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

This adds a couple of tests to check enforcing of limits in pids
controller upon migration. When the new option does not exist, the test
is skipped.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/test_pids.c | 117 ++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_pids.c b/tools/testing/selftests/cgroup/test_pids.c
index c1c3a3965624..a3ad5a495f59 100644
--- a/tools/testing/selftests/cgroup/test_pids.c
+++ b/tools/testing/selftests/cgroup/test_pids.c
@@ -12,6 +12,8 @@
 #include "../kselftest.h"
 #include "cgroup_util.h"
 
+static bool has_miglimit;
+
 static int run_success(const char *cgroup, void *arg)
 {
 	return 0;
@@ -69,6 +71,112 @@ static int test_pids_max(const char *root)
 	return ret;
 }
 
+/*
+ * This test checks that pids.max prevents migrating tasks over limit into the
+ * cgroup.
+ */
+static int test_pids_max_migration(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_pids;
+	int pid;
+
+	if (!has_miglimit)
+		return KSFT_SKIP;
+
+	cg_pids = cg_name(root, "pids_test");
+	if (!cg_pids)
+		goto cleanup;
+
+	if (cg_create(cg_pids))
+		goto cleanup;
+
+	if (cg_write(cg_pids, "pids.max", "1"))
+		goto cleanup;
+
+	pid = cg_run_nowait(cg_pids, run_pause, NULL);
+	if (pid < 0)
+		goto cleanup;
+
+	if (cg_enter_current(cg_pids) >= 0)
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
+ * This test checks that pids.max does not prevent migrating existing tasks
+ * inside subtree.
+ */
+static int test_pids_max_overcommit(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_parent = NULL, *cg_src = NULL, *cg_dst = NULL;
+	int pid;
+
+	if (!has_miglimit)
+		return KSFT_SKIP;
+
+	cg_parent = cg_name(root, "pids_test");
+	if (!cg_parent)
+		goto cleanup;
+	cg_src = cg_name(cg_parent, "src");
+	if (!cg_src)
+		goto cleanup;
+	cg_dst = cg_name(cg_parent, "dst");
+	if (!cg_dst)
+		goto cleanup;
+
+	if (cg_create(cg_parent))
+		goto cleanup;
+	if (cg_write(cg_parent, "cgroup.subtree_control", "+pids"))
+		goto cleanup;
+	if (cg_create(cg_src))
+		goto cleanup;
+	if (cg_create(cg_dst))
+		goto cleanup;
+
+	if (cg_enter_current(cg_src) < 0)
+		goto cleanup;
+
+	pid = cg_run_nowait(cg_src, run_pause, NULL);
+	if (pid < 0)
+		goto cleanup;
+
+	if (cg_write(cg_parent, "pids.max", "1"))
+		goto cleanup;
+
+	if (cg_enter(cg_dst, pid) < 0)
+		goto cleanup;
+
+	if (kill(pid, SIGINT))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	cg_destroy(cg_dst);
+	cg_destroy(cg_src);
+	cg_destroy(cg_parent);
+	free(cg_dst);
+	free(cg_src);
+	free(cg_parent);
+
+	return ret;
+}
+
+
 /*
  * This test checks that pids.max prevents forking new children above the
  * specified limit in the cgroup.
@@ -145,6 +253,8 @@ struct pids_test {
 	const char *name;
 } tests[] = {
 	T(test_pids_max),
+	T(test_pids_max_migration),
+	T(test_pids_max_overcommit),
 	T(test_pids_events),
 };
 #undef T
@@ -152,7 +262,7 @@ struct pids_test {
 int main(int argc, char **argv)
 {
 	char root[PATH_MAX];
-	int i, ret = EXIT_SUCCESS;
+	int i, proc_status, ret = EXIT_SUCCESS;
 
 	if (cg_find_unified_root(root, sizeof(root)))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
@@ -168,6 +278,11 @@ int main(int argc, char **argv)
 		if (cg_write(root, "cgroup.subtree_control", "+pids"))
 			ksft_exit_skip("Failed to set pids controller\n");
 
+	proc_status = proc_mount_contains("pids_miglimit");
+	if (proc_status < 0)
+		ksft_exit_skip("Failed to query cgroup mount option\n");
+	has_miglimit = proc_status;
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
-- 
2.44.0


