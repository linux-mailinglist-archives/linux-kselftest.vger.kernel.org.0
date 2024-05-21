Return-Path: <linux-kselftest+bounces-10470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633988CAA9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870E91C21AC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0AF5BAC1;
	Tue, 21 May 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jYf2C43D";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jYf2C43D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944732EB1D;
	Tue, 21 May 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283295; cv=none; b=X27Gq6Z4OZiwexqWsfUtEqncNcY+/JMJ8AOKjwrZGPVoRI4B/zlGFrqKsuNNqHfWxv1GAANNxFmXfagkPBKntQ2rqXukCAxhvGsTyK+6p7cSevPzopHd6XF29wMrAwAA34x1ohjrimltd6pvf6E3pib5Ud1PIYzrvwSX+wMm4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283295; c=relaxed/simple;
	bh=40DtK0NjnVb7tKbF3pe7qfXATTZMXl+tGU5c6wYltQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffm4IdOm8wLf/57de8Nth6ySeMFj/1j8XSaEX6glhYzd97GQxEYsFPtEtosTiUdeh61flziGiJUDVkBTIxaGWd5+HtU+DUHjvXUOlewe7L2y71VhZL3V0Roz18e/iGL9TVacZ5MByVyvjWXiQc1+o8sxnUTetDwbKm735Dn6qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jYf2C43D; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jYf2C43D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9EA634631;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPFpFKaPEcMbSbIAntKG5udyTojAGGnmE3ttNKQ1AQk=;
	b=jYf2C43DE0uO2GdjDOYyBGxI25NkztXg7i6hg9Kb7nLT0xeIJlalUs865WtuykLeQtx2rv
	Ii8Fl+4detGkb7VSSOOPakQY28Qazj3znyJQ3t+IeGz3Fo0Fv1X3HNiSeu/MPQeKuNf1EP
	2hKusDpY5GyWSU74g93qAY7lj70jDe8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPFpFKaPEcMbSbIAntKG5udyTojAGGnmE3ttNKQ1AQk=;
	b=jYf2C43DE0uO2GdjDOYyBGxI25NkztXg7i6hg9Kb7nLT0xeIJlalUs865WtuykLeQtx2rv
	Ii8Fl+4detGkb7VSSOOPakQY28Qazj3znyJQ3t+IeGz3Fo0Fv1X3HNiSeu/MPQeKuNf1EP
	2hKusDpY5GyWSU74g93qAY7lj70jDe8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B873213A75;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WLbnLJtnTGaZYgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 21 May 2024 09:21:31 +0000
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
Subject: [PATCH v5 1/5] cgroup/pids: Separate semantics of pids.events related to pids.max
Date: Tue, 21 May 2024 11:21:26 +0200
Message-ID: <20240521092130.7883-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240521092130.7883-1-mkoutny@suse.com>
References: <20240521092130.7883-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.30
X-Spam-Flag: NO

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
 Documentation/admin-guide/cgroup-v2.rst      | 13 ++++--
 include/linux/cgroup-defs.h                  |  7 +++-
 kernel/cgroup/cgroup.c                       | 15 ++++++-
 kernel/cgroup/pids.c                         | 44 +++++++++++++++-----
 5 files changed, 64 insertions(+), 18 deletions(-)

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
index e73e373297a0..945ff743a3c9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -239,6 +239,10 @@ cgroup v2 currently supports the following mount options.
           will not be tracked by the memory controller (even if cgroup
           v2 is remounted later on).
 
+  pids_localevents
+        Represent fork failures inside cgroup's pids.events:max (v1 behavior),
+        not its limit being hit (v2 behavior).
+
 
 Organizing Processes and Threads
 --------------------------------
@@ -2196,12 +2200,13 @@ PID Interface Files
 	descendants has ever reached.
 
   pids.events
-	A read-only flat-keyed file which exists on non-root cgroups. The
-	following entries are defined. Unless specified otherwise, a value
-	change in this file generates a file modified event.
+	A read-only flat-keyed file which exists on non-root cgroups. Unless
+	specified otherwise, a value change in this file generates a file
+	modified event. The following entries are defined.
 
 	  max
-		Number of times fork failed because limit was hit.
+		The number of times the cgroup's number of processes hit the
+		limit (see also pids_localevents).
 
 Organisational operations are not blocked by cgroup policies, so it is
 possible to have pids.current > pids.max.  This can be done by either
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
index e32b6972c478..9c9943ea5f89 100644
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
 
@@ -7062,7 +7074,8 @@ static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
 			"favordynmods\n"
 			"memory_localevents\n"
 			"memory_recursiveprot\n"
-			"memory_hugetlb_accounting\n");
+			"memory_hugetlb_accounting\n"
+			"pids_localevents\n");
 }
 static struct kobj_attribute cgroup_features_attr = __ATTR_RO(features);
 
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 0e5ec7d59b4d..a557f5c8300b 100644
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
 
-- 
2.44.0


