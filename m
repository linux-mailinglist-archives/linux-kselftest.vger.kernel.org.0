Return-Path: <linux-kselftest+bounces-8155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC98A6DFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A32811CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3476F13342F;
	Tue, 16 Apr 2024 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z2Gzy7QQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z2Gzy7QQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0213175A;
	Tue, 16 Apr 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277220; cv=none; b=PcgyDbO9kWuZtHz9WcHfOv37KkhpqRpJXNAll31JnKWAhLu2sjvpXBIt9WaFzGsAHjA0b5RZhh7vJdSi/iybH7IJjVZto+9UkOO8Kxi5/nbuOTIoD4Ct5ulvhl+01QJ/y++mjtVGOgP0DqyNEeaHmJhtJefz/j39OKTDJlHGZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277220; c=relaxed/simple;
	bh=dZtiUt4VDuK8wpF76G3p0Cg3iHZOEC1WrBN6ZvdJmTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozaheuBcwKwgmueJ/RV2BLSga3YfK1mLq1U+rI2p7p0SEXkF2l7i6gYOGsyNPLYdLIK2U0giu2ra7qFNhgHwLVw9ZfrNCo4/6yRD2sm7EtSe6fXoXx4GZHkiulHOEU11Jo2D2YKcPbkJJcB/FYci5/Id503/ZBHBVKvNcXpCjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z2Gzy7QQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z2Gzy7QQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CF263754A;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDgPJ2+XdcAbyUZbYfg26iCO2S1vIj77wUMIRg5FecE=;
	b=Z2Gzy7QQhUJ4L92hlRHM28nm17GugLloIYTsfy8qlOO99Wgl5XB/VbkPwnOOcTHQ2zSi3O
	wz0SUcoj24WAe2JhMlQdmG0svq46akQZ68AXpWrjVGuMD0VjhQybhib6/9KkVZtvHZVgbH
	B84YyMU2Y3ivsyqL4dxGAnmTI+F/H4c=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Z2Gzy7QQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDgPJ2+XdcAbyUZbYfg26iCO2S1vIj77wUMIRg5FecE=;
	b=Z2Gzy7QQhUJ4L92hlRHM28nm17GugLloIYTsfy8qlOO99Wgl5XB/VbkPwnOOcTHQ2zSi3O
	wz0SUcoj24WAe2JhMlQdmG0svq46akQZ68AXpWrjVGuMD0VjhQybhib6/9KkVZtvHZVgbH
	B84YyMU2Y3ivsyqL4dxGAnmTI+F/H4c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1D7613967;
	Tue, 16 Apr 2024 14:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eHHqOh+JHmbAbQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 16 Apr 2024 14:20:15 +0000
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
Subject: [PATCH v4 2/6] cgroup/pids: Separate semantics of pids.events related to pids.max
Date: Tue, 16 Apr 2024 16:20:10 +0200
Message-ID: <20240416142014.27630-3-mkoutny@suse.com>
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
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1CF263754A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.com:+]

Currently, when pids.max limit is breached in the hierarchy, the event
is counted and reported in the cgroup where the forking task resides.

This decouples the limit and the notification caused by the limit making
it hard to detect when the actual limit was effected.

Redefine the pids.events:max as: the number of times the limit of the
cgroup was hit.

(Implementation differentiates also "forkfail" event but this is
currently not exposed as it would better fit into pids.stat. It also
differs from pids.events:max only when pids.max is configured on
non-leaf cgroups.)

Since it changes semantics of the original "max" event, introduce this
change only in the v2 API of the controller and add a cgroup2 mount
option to revert to the legacy behavior.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v1/pids.rst |  3 +-
 Documentation/admin-guide/cgroup-v2.rst      | 12 ++++++
 include/linux/cgroup-defs.h                  |  7 ++-
 kernel/cgroup/cgroup.c                       | 15 ++++++-
 kernel/cgroup/pids.c                         | 45 ++++++++++++++------
 5 files changed, 67 insertions(+), 15 deletions(-)

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
index 17e6e9565156..108b03dfb26a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -239,6 +239,10 @@ cgroup v2 currently supports the following mount options.
           will not be tracked by the memory controller (even if cgroup
           v2 is remounted later on).
 
+  pid_localevents
+        Represent fork failures inside cgroup's pids.events:max (not its limit
+        being hit).
+
 
 Organizing Processes and Threads
 --------------------------------
@@ -2186,6 +2190,14 @@ PID Interface Files
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
 Organisational operations are not blocked by cgroup policies, so it is
 possible to have pids.current > pids.max.  This can be done by either
 setting the limit to be smaller than pids.current, or attaching enough
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ea48c861cd36..b36690ca0d3f 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -119,7 +119,12 @@ enum {
 	/*
 	 * Enable hugetlb accounting for the memory controller.
 	 */
-	 CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING = (1 << 19),
+	CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING = (1 << 19),
+
+	/*
+	 * Enable legacy local pids.events.
+	 */
+	CGRP_ROOT_PIDS_LOCAL_EVENTS = (1 << 20),
 };
 
 /* cftype->flags */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..306af389a78a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1922,6 +1922,7 @@ enum cgroup2_param {
 	Opt_memory_localevents,
 	Opt_memory_recursiveprot,
 	Opt_memory_hugetlb_accounting,
+	Opt_pids_localevents,
 	nr__cgroup2_params
 };
 
@@ -1931,6 +1932,7 @@ static const struct fs_parameter_spec cgroup2_fs_parameters[] = {
 	fsparam_flag("memory_localevents",	Opt_memory_localevents),
 	fsparam_flag("memory_recursiveprot",	Opt_memory_recursiveprot),
 	fsparam_flag("memory_hugetlb_accounting", Opt_memory_hugetlb_accounting),
+	fsparam_flag("pids_localevents",	Opt_pids_localevents),
 	{}
 };
 
@@ -1960,6 +1962,9 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	case Opt_memory_hugetlb_accounting:
 		ctx->flags |= CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
 		return 0;
+	case Opt_pids_localevents:
+		ctx->flags |= CGRP_ROOT_PIDS_LOCAL_EVENTS;
+		return 0;
 	}
 	return -EINVAL;
 }
@@ -1989,6 +1994,11 @@ static void apply_cgroup_root_flags(unsigned int root_flags)
 			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
 		else
 			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
+
+		if (root_flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
+			cgrp_dfl_root.flags |= CGRP_ROOT_PIDS_LOCAL_EVENTS;
+		else
+			cgrp_dfl_root.flags &= ~CGRP_ROOT_PIDS_LOCAL_EVENTS;
 	}
 }
 
@@ -2004,6 +2014,8 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
 		seq_puts(seq, ",memory_recursiveprot");
 	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
 		seq_puts(seq, ",memory_hugetlb_accounting");
+	if (cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
+		seq_puts(seq, ",pids_localevents");
 	return 0;
 }
 
@@ -7061,7 +7073,8 @@ static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
 			"favordynmods\n"
 			"memory_localevents\n"
 			"memory_recursiveprot\n"
-			"memory_hugetlb_accounting\n");
+			"memory_hugetlb_accounting\n"
+			"pids_localevents\n");
 }
 static struct kobj_attribute cgroup_features_attr = __ATTR_RO(features);
 
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 0e5ec7d59b4d..ea1fc6b37c0d 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -38,6 +38,14 @@
 #define PIDS_MAX (PID_MAX_LIMIT + 1ULL)
 #define PIDS_MAX_STR "max"
 
+enum pidcg_event {
+	/* Fork failed in subtree because this pids_cgroup limit was hit. */
+	PIDCG_MAX,
+	/* Fork failed in this pids_cgroup because ancestor limit was hit. */
+	PIDCG_FORKFAIL,
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
+		if (atomic64_inc_return(&pids->events[PIDCG_FORKFAIL]) == 1) {
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
@@ -340,8 +357,13 @@ static s64 pids_peak_read(struct cgroup_subsys_state *css,
 static int pids_events_show(struct seq_file *sf, void *v)
 {
 	struct pids_cgroup *pids = css_pids(seq_css(sf));
+	enum pidcg_event pe = PIDCG_MAX;
+
+	if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
+	    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
+		pe = PIDCG_FORKFAIL;
 
-	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&pids->events_limit));
+	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&pids->events[pe]));
 	return 0;
 }
 
@@ -379,7 +401,6 @@ struct cgroup_subsys pids_cgrp_subsys = {
 	.can_fork	= pids_can_fork,
 	.cancel_fork	= pids_cancel_fork,
 	.release	= pids_release,
-	.legacy_cftypes	= pids_files,
 	.dfl_cftypes	= pids_files,
 	.threaded	= true,
 };
-- 
2.44.0


