Return-Path: <linux-kselftest+bounces-7306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18AA89A31B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BDD1C22559
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C9171E77;
	Fri,  5 Apr 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eOtiogYD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eOtiogYD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FB171658;
	Fri,  5 Apr 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336756; cv=none; b=G9zf71sDNIYOyxAInu9tS5gvSCafg1PE/RBKH1zh5EPvuDcaYF1+amPlBfN2mKqZnRaFGBUMScygxZO8ZbQ+9wZKL4ww3P6zp+V1AAPPZlQBZbo2+6Lw9xZyVR1FEtQbXNIVijSlQMfypt9DASQFnhhZcLbFBtPRUV7o2Kwsw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336756; c=relaxed/simple;
	bh=sNMiOrjpJBDlOy/o9yvn0i9g7eME0srR4YDWEYMqrMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7IPdEn0Wo6XGmPtTPVl2OyKdzEAd9j6aFGHGT6eA0QcjsTkUxnqbxw2mmS2WMLoR1S5LK/DW0W+7fDDxuky1fJ1tj0q+hv4rKt1BzUQ0w1wHZEYFuEOJczMyYKnGz4xlYaT97m1eGUxAeMbRfJN7Inrodif7pWsmyeMMcPuqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eOtiogYD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eOtiogYD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5239121AC4;
	Fri,  5 Apr 2024 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JL3VRnglLkYkgr45ZBKtck6zrwTEkznP9XmoZIrWnWY=;
	b=eOtiogYDrUalSfchBR9qJbJ2LeHTZuh51KD2A/q/ggcTFhK7FbQ7Lp5Znl7nwZwdLTdBMc
	J3rmnoLPgBN6MOGETJTb5ppMGvGIxe8Yz7qnVBabjr3F8kQ4+JnfX0jOKl29cCGVC+vfNS
	dr/s4Eb/WOcJ9xtLIZFDH7xh2FMRL28=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eOtiogYD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JL3VRnglLkYkgr45ZBKtck6zrwTEkznP9XmoZIrWnWY=;
	b=eOtiogYDrUalSfchBR9qJbJ2LeHTZuh51KD2A/q/ggcTFhK7FbQ7Lp5Znl7nwZwdLTdBMc
	J3rmnoLPgBN6MOGETJTb5ppMGvGIxe8Yz7qnVBabjr3F8kQ4+JnfX0jOKl29cCGVC+vfNS
	dr/s4Eb/WOcJ9xtLIZFDH7xh2FMRL28=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B39313A92;
	Fri,  5 Apr 2024 17:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qIPoCXAvEGYteAAAn2gu4w
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
Subject: [RFC PATCH v3 8/9] cgroup/pids: Enforce pids.max on task migrations
Date: Fri,  5 Apr 2024 19:05:47 +0200
Message-ID: <20240405170548.15234-9-mkoutny@suse.com>
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
X-Rspamd-Queue-Id: 5239121AC4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

While pids controller is designed with only forks in mind, it leads to
situations where limit is apparently ineffective.
A manager daemon is in /src and it spawns tasks into /dst. The
administrator sets up a limit dst/pids.max while src/pids.max is
unlimited. The manager daemon can spawn more than dst/pids.max tasks
because they get into their target cgroup via migration (or
CLONE_INTO_CGROUP).

For this (migration) to work both src and dst must be in the same
resource domain so the manager daemon does not honor the limit which is
under its control anyway and no excessive resource consumption happens.

dst/pids.current > dst/pids.max may come as a surprise when the
spawning mechanism is opaque to the administrator of dst/pids.max.

Change the behavior of pids controller to take into account limits of
target cgroup upon migration (but only below common ancestor src and
dst, pids.current of common ancestor and above is not affected by
migration, so deliberatly ignore pre-existing pids.current > pids.max).

This change of behavior is hidden behind cgroup2 mount option and
the default is unchanged, pids.max won't affect migrations.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 +++++++-
 include/linux/cgroup-defs.h             |  7 ++++++-
 kernel/cgroup/cgroup.c                  | 16 +++++++++++++++-
 kernel/cgroup/pids.c                    |  8 ++++++--
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5d4c505cae06..d7e721aed584 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -239,6 +239,11 @@ cgroup v2 currently supports the following mount options.
           will not be tracked by the memory controller (even if cgroup
           v2 is remounted later on).
 
+  pids_miglimit
+        Apply pids.max limit also when migrating tasks between cgroups. Only
+        new destination limit are taken into account, i.e. if subtree has
+        pids.current > pids.max, migration within that subtree is allowed.
+
 
 Organizing Processes and Threads
 --------------------------------
@@ -2204,7 +2209,8 @@ Organisational operations are not blocked by cgroup policies, so it is
 possible to have pids.current > pids.max.  This can be done by either
 setting the limit to be smaller than pids.current, or attaching enough
 processes to the cgroup such that pids.current is larger than
-pids.max.  However, it is not possible to violate a cgroup PID policy
+pids.max (unless pids_miglimit mount options is given).
+However, it is not possible to violate a cgroup PID policy
 through fork() or clone(). These will return -EAGAIN if the creation
 of a new process would cause a cgroup policy to be violated.
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ea48c861cd36..a99db24b5496 100644
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
+	 * Enforce pids limit upon task migration
+	 */
+	CGRP_ROOT_PIDS_MIGRATION_LIMIT = (1 << 20),
 };
 
 /* cftype->flags */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..9aa6428c84c1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1922,6 +1922,7 @@ enum cgroup2_param {
 	Opt_memory_localevents,
 	Opt_memory_recursiveprot,
 	Opt_memory_hugetlb_accounting,
+	Opt_pids_miglimit,
 	nr__cgroup2_params
 };
 
@@ -1931,6 +1932,7 @@ static const struct fs_parameter_spec cgroup2_fs_parameters[] = {
 	fsparam_flag("memory_localevents",	Opt_memory_localevents),
 	fsparam_flag("memory_recursiveprot",	Opt_memory_recursiveprot),
 	fsparam_flag("memory_hugetlb_accounting", Opt_memory_hugetlb_accounting),
+	fsparam_flag("pids_miglimit",           Opt_pids_miglimit),
 	{}
 };
 
@@ -1960,6 +1962,9 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	case Opt_memory_hugetlb_accounting:
 		ctx->flags |= CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
 		return 0;
+	case Opt_pids_miglimit:
+		ctx->flags |= CGRP_ROOT_PIDS_MIGRATION_LIMIT;
+		return 0;
 	}
 	return -EINVAL;
 }
@@ -1989,6 +1994,12 @@ static void apply_cgroup_root_flags(unsigned int root_flags)
 			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
 		else
 			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
+
+		if (root_flags & CGRP_ROOT_PIDS_MIGRATION_LIMIT)
+			cgrp_dfl_root.flags |= CGRP_ROOT_PIDS_MIGRATION_LIMIT;
+		else
+			cgrp_dfl_root.flags &= ~CGRP_ROOT_PIDS_MIGRATION_LIMIT;
+
 	}
 }
 
@@ -2004,6 +2015,8 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
 		seq_puts(seq, ",memory_recursiveprot");
 	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
 		seq_puts(seq, ",memory_hugetlb_accounting");
+	if (cgrp_dfl_root.flags & CGRP_ROOT_PIDS_MIGRATION_LIMIT)
+		seq_puts(seq, ",pids_miglimit");
 	return 0;
 }
 
@@ -7061,7 +7074,8 @@ static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
 			"favordynmods\n"
 			"memory_localevents\n"
 			"memory_recursiveprot\n"
-			"memory_hugetlb_accounting\n");
+			"memory_hugetlb_accounting\n"
+			"pids_miglimit\n");
 }
 static struct kobj_attribute cgroup_features_attr = __ATTR_RO(features);
 
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 9df8a209a6e2..4683629b8168 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -217,6 +217,7 @@ static int pids_can_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
 	struct cgroup_subsys_state *dst_css;
+	int err, ret = 0;
 
 	cgroup_taskset_for_each(task, dst_css, tset) {
 		struct pids_cgroup *pids = css_pids(dst_css);
@@ -231,10 +232,13 @@ static int pids_can_attach(struct cgroup_taskset *tset)
 		old_css = task_css(task, pids_cgrp_id);
 		old_pids = css_pids(old_css);
 
-		(void) pids_tranfer_charge(old_pids, pids, 1);
+		err = pids_tranfer_charge(old_pids, pids, 1);
+
+		if (!ret && (cgrp_dfl_root.flags & CGRP_ROOT_PIDS_MIGRATION_LIMIT))
+			ret = err;
 	}
 
-	return 0;
+	return ret;
 }
 
 static void pids_cancel_attach(struct cgroup_taskset *tset)
-- 
2.44.0


