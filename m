Return-Path: <linux-kselftest+bounces-7303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8749589A311
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4011C22C9B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F08171E47;
	Fri,  5 Apr 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HH/wKGUq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nq2C5hGK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183F171645;
	Fri,  5 Apr 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336755; cv=none; b=qrww9DLxOPzuzqE1Bga33lLWsSxM5K2um4FxMt1JUL/Y8KQ0lJM9p2i8B25YVKdE4cs4MszZXm22SD6jbFMtm0REKDgY8ZcBC9MRRXDj+7EvKadrVZ5ObCX2Sv5dN2MacuUJVRqLB8sOo7yQjGPtitxLupQ0k4hkdnwZcmWGvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336755; c=relaxed/simple;
	bh=5ZOfaNXZeiIXvirKwtb0elVzanrnswLvpyCFHQWdtIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNQGibWN55kmPeDFJQIRBdCHsyo5KOAHtecvtOgyFqftvqbktqpcbQnLI+2faBbjvV4QLxd7ot5t4oOHbua80tH6CGFtd0oiLKq/Jzwdu3PAFETtligCEj6+jhsirU5pelCOQVBv0SxH93OAYTrZzcXWDKX9fCgos/5Hm77Nhw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HH/wKGUq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nq2C5hGK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BEEE21AC0;
	Fri,  5 Apr 2024 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWte9b54VKI1DemrieVd4NneMerCxmqw3/8DurPYqEg=;
	b=HH/wKGUq2X2IqukKy3psMacqxNh/gp1hELo2pVg86F0nzkk4NPBdZrocvPz8SB9nl7CeM7
	sulfJ6m9MIrdtfdIxCnOF4CFam9+TfqIHB4LQbe92UFk/wlH5UaEAjUOmLq/bt6Sk07rVa
	lPSs7z/FwP8OkDJhnKoBCEGDBpPZcww=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWte9b54VKI1DemrieVd4NneMerCxmqw3/8DurPYqEg=;
	b=Nq2C5hGKhCiGHbNBlkHT6Kwz09Ncw0mpakuL0rj20IX4cOtQtKvjIBpD74+iXPqhnvs7IY
	euyNZbl0QwIr93+qgTz5Mb5aflTwwWAw3efnGkLNgIEf3pz0h37bpuN8FlAvu6bDJXQoRq
	lvJYeny1hDZ0UrC4Txkh98ds/S9OQcc=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B43813AAA;
	Fri,  5 Apr 2024 17:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6JcFAm8vEGYteAAAn2gu4w
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
Subject: [RFC PATCH v3 2/9] cgroup/pids: Separate semantics of pids.events related to pids.max
Date: Fri,  5 Apr 2024 19:05:41 +0200
Message-ID: <20240405170548.15234-3-mkoutny@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email,pids.events:url]

Currently, when pids.max limit is breached in the hierarchy, the event
is counted and reported in the cgroup where the forking task resides.

This decouples the limit and the notification caused by the limit making
it hard to detect when the actual limit was effected.

Let's introduce new events:
	  max
		The number of times the limit of the cgroup was hit.

	  max.imposed
		The number of times fork failed in the cgroup because of self
		or ancestor limit.

Since it changes semantics of the original "max" event, we introduce
this change only in the v2 API of the controller.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v1/pids.rst |  3 +-
 Documentation/admin-guide/cgroup-v2.rst      | 12 ++++
 kernel/cgroup/pids.c                         | 71 ++++++++++++++++----
 3 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/pids.rst b/Documentation/admin-guide/cgroup-v1/pids.rst
index 6acebd9e72c8..0f9f9a7b1f6c 100644
--- a/Documentation/admin-guide/cgroup-v1/pids.rst
+++ b/Documentation/admin-guide/cgroup-v1/pids.rst
@@ -36,7 +36,8 @@ superset of parent/child/pids.current.
 
 The pids.events file contains event counters:
 
-  - max: Number of times fork failed because limit was hit.
+  - max: Number of times fork failed in the cgroup because limit was hit in
+    self or ancestors.
 
 Example
 -------
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 17e6e9565156..4f04538d688c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2186,6 +2186,18 @@ PID Interface Files
 	The number of processes currently in the cgroup and its
 	descendants.
 
+  pids.events
+	A read-only flat-keyed file which exists on non-root cgroups.  Unless
+	specified otherwise, a value change in this file generates a file modified
+	event. The following entries are defined.
+
+	  max
+		The number of times the limit of the cgroup was hit.
+
+	  max.imposed
+		The number of times fork failed in the cgroup because of self
+		or ancestor limit.
+
 Organisational operations are not blocked by cgroup policies, so it is
 possible to have pids.current > pids.max.  This can be done by either
 setting the limit to be smaller than pids.current, or attaching enough
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 0e5ec7d59b4d..471562609eef 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -38,6 +38,14 @@
 #define PIDS_MAX (PID_MAX_LIMIT + 1ULL)
 #define PIDS_MAX_STR "max"
 
+enum pidcg_event {
+	/* Fork failed in subtree because this pids_cgroup limit was hit. */
+	PIDCG_MAX,
+	/* Fork failed in this pids_cgroup because ancestor limit was hit. */
+	PIDCG_MAX_IMPOSED,
+	NR_PIDCG_EVENTS,
+};
+
 struct pids_cgroup {
 	struct cgroup_subsys_state	css;
 
@@ -52,8 +60,7 @@ struct pids_cgroup {
 	/* Handle for "pids.events" */
 	struct cgroup_file		events_file;
 
-	/* Number of times fork failed because limit was hit. */
-	atomic64_t			events_limit;
+	atomic64_t			events[NR_PIDCG_EVENTS];
 };
 
 static struct pids_cgroup *css_pids(struct cgroup_subsys_state *css)
@@ -148,12 +155,13 @@ static void pids_charge(struct pids_cgroup *pids, int num)
  * pids_try_charge - hierarchically try to charge the pid count
  * @pids: the pid cgroup state
  * @num: the number of pids to charge
+ * @fail: storage of pid cgroup causing the fail
  *
  * This function follows the set limit. It will fail if the charge would cause
  * the new value to exceed the hierarchical limit. Returns 0 if the charge
  * succeeded, otherwise -EAGAIN.
  */
-static int pids_try_charge(struct pids_cgroup *pids, int num)
+static int pids_try_charge(struct pids_cgroup *pids, int num, struct pids_cgroup **fail)
 {
 	struct pids_cgroup *p, *q;
 
@@ -166,9 +174,10 @@ static int pids_try_charge(struct pids_cgroup *pids, int num)
 		 * p->limit is %PIDS_MAX then we know that this test will never
 		 * fail.
 		 */
-		if (new > limit)
+		if (new > limit) {
+			*fail = p;
 			goto revert;
-
+		}
 		/*
 		 * Not technically accurate if we go over limit somewhere up
 		 * the hierarchy, but that's tolerable for the watermark.
@@ -236,7 +245,7 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
 static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 {
 	struct cgroup_subsys_state *css;
-	struct pids_cgroup *pids;
+	struct pids_cgroup *pids, *pids_over_limit;
 	int err;
 
 	if (cset)
@@ -244,15 +253,23 @@ static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 	else
 		css = task_css_check(current, pids_cgrp_id, true);
 	pids = css_pids(css);
-	err = pids_try_charge(pids, 1);
+	err = pids_try_charge(pids, 1, &pids_over_limit);
 	if (err) {
-		/* Only log the first time events_limit is incremented. */
-		if (atomic64_inc_return(&pids->events_limit) == 1) {
+		/* compatibility on v1 where events were notified in leaves. */
+		if (!cgroup_subsys_on_dfl(pids_cgrp_subsys))
+			pids_over_limit = pids;
+
+		/* Only log the first time limit is hit. */
+		if (atomic64_inc_return(&pids->events[PIDCG_MAX_IMPOSED]) == 1) {
 			pr_info("cgroup: fork rejected by pids controller in ");
-			pr_cont_cgroup_path(css->cgroup);
+			pr_cont_cgroup_path(pids->css.cgroup);
 			pr_cont("\n");
 		}
+		atomic64_inc(&pids_over_limit->events[PIDCG_MAX]);
+
 		cgroup_file_notify(&pids->events_file);
+		if (pids_over_limit != pids)
+			cgroup_file_notify(&pids_over_limit->events_file);
 	}
 	return err;
 }
@@ -341,7 +358,16 @@ static int pids_events_show(struct seq_file *sf, void *v)
 {
 	struct pids_cgroup *pids = css_pids(seq_css(sf));
 
-	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&pids->events_limit));
+	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&pids->events[PIDCG_MAX]));
+	seq_printf(sf, "max.imposed %lld\n", (s64)atomic64_read(&pids->events[PIDCG_MAX_IMPOSED]));
+	return 0;
+}
+
+static int pids_events_show_legacy(struct seq_file *sf, void *v)
+{
+	struct pids_cgroup *pids = css_pids(seq_css(sf));
+
+	seq_printf(sf, "max%lld\n", (s64)atomic64_read(&pids->events[PIDCG_MAX_IMPOSED]));
 	return 0;
 }
 
@@ -371,6 +397,27 @@ static struct cftype pids_files[] = {
 	{ }	/* terminate */
 };
 
+static struct cftype pids_files_legacy[] = {
+	{
+		.name = "max",
+		.write = pids_max_write,
+		.seq_show = pids_max_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "current",
+		.read_s64 = pids_current_read,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "events",
+		.seq_show = pids_events_show_legacy,
+		.file_offset = offsetof(struct pids_cgroup, events_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{ }	/* terminate */
+};
+
 struct cgroup_subsys pids_cgrp_subsys = {
 	.css_alloc	= pids_css_alloc,
 	.css_free	= pids_css_free,
@@ -379,7 +426,7 @@ struct cgroup_subsys pids_cgrp_subsys = {
 	.can_fork	= pids_can_fork,
 	.cancel_fork	= pids_cancel_fork,
 	.release	= pids_release,
-	.legacy_cftypes	= pids_files,
 	.dfl_cftypes	= pids_files,
+	.legacy_cftypes	= pids_files_legacy,
 	.threaded	= true,
 };
-- 
2.44.0


