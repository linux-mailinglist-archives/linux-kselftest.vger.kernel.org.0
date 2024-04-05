Return-Path: <linux-kselftest+bounces-7304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563C89A314
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009571F24372
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC88171E51;
	Fri,  5 Apr 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q1BBKm2O";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kUVI90Cy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF20171659;
	Fri,  5 Apr 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336756; cv=none; b=aM/VP/xxSxet3dj0IOaC6/39TSuFj+NEqBC9k6pHqNiJ79LnbZN4lEJDgLTmI8qImgElVGUIZdQVg2OmRAHj82mMuHOdNnGFi+4MGNUfWTJbQUGErcnT5NW8SWqHJdXQJnmN2FHg3W+W7XSUuzC9YulS8bSFLHdFSbJH5FEAM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336756; c=relaxed/simple;
	bh=R9clZ8T2lcQlVApdxb/LCRn1Vu4EIS+rW6t2QJnF7cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4qPRe6EMvPgDZAZ7ZWzd/c+977PzpOqCzQZJrxWJhlAv4SBqEkzKcfJnEhwez5lCFo9YfCzFOhjQ9IuMoc1+Q9Ott5g3sxcl6KUoPILoRpUqVm0ORRzTlUm7pMG6I/s3xq8s9PTiPiSZ0sGzHTX4+Jcy988QeCL3Cvs1kSihys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q1BBKm2O; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kUVI90Cy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 682DE1F7F1;
	Fri,  5 Apr 2024 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiwCnwZ2VAGhImKJnzUhLK6HmMDw3wHqFOMyEBth2+I=;
	b=q1BBKm2Ohg1ChSMQbOtkX35oV4JI0PbODmE5JbnNDUVSZxjc05NiLDlByTdjyxQ4aiQ4Tb
	1w3bsuHXeS3CYggkgPu04RU6CO27Ml4+WUmETNejRzjOV/J3E6k5w8PG0Ns6b2+06hrPOG
	oW+Udpz0clzLfD+Ihn6iAIfNQEyar0Y=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiwCnwZ2VAGhImKJnzUhLK6HmMDw3wHqFOMyEBth2+I=;
	b=kUVI90CyKQQ5mjSMyvvVTGwi5A49BxXNj1a185RkECFsZMwifLCy8f9P9wzdPnuy6+Iqth
	yJZRnHmMW6X46bDMq4al9gjUwYvJwMJG7z1Da/3M54nxPg3Pwa6S0HLCK+lbB0wzDXSyh3
	hYXsTcv0dIcMZyDRIZUMMP5jCKmz6FI=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B2D913AAD;
	Fri,  5 Apr 2024 17:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QGa1DW8vEGYteAAAn2gu4w
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
Subject: [RFC PATCH v3 3/9] cgroup/pids: Make event counters hierarchical
Date: Fri,  5 Apr 2024 19:05:42 +0200
Message-ID: <20240405170548.15234-4-mkoutny@suse.com>
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqco6ghhk4ot65weiawc5nc38)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,pids.events:url,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

The pids.events file should honor the hierarchy, so make the events
propagate from their origin up to the root on the unified hierarchy. The
v1 behavior remains non-hierarchical.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 ++-
 kernel/cgroup/pids.c                    | 46 ++++++++++++++++---------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 4f04538d688c..5d4c505cae06 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2189,7 +2189,9 @@ PID Interface Files
   pids.events
 	A read-only flat-keyed file which exists on non-root cgroups.  Unless
 	specified otherwise, a value change in this file generates a file modified
-	event. The following entries are defined.
+	event. Fields in this file are hierarchical and the file modified event
+	can be generated due to an event down the hierarchy. The following
+	entries are defined.
 
 	  max
 		The number of times the limit of the cgroup was hit.
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 471562609eef..76c0a97e42da 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -238,6 +238,34 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
 	}
 }
 
+static void pids_event(struct pids_cgroup *pids_forking,
+		       struct pids_cgroup *pids_over_limit)
+{
+	struct pids_cgroup *p = pids_forking;
+	bool limit = false;
+
+	/* Only log the first time limit is hit. */
+	if (atomic64_inc_return(&p->events[PIDCG_MAX_IMPOSED]) == 1) {
+		pr_info("cgroup: fork rejected by pids controller in ");
+		pr_cont_cgroup_path(p->css.cgroup);
+		pr_cont("\n");
+	}
+	/* Events are only notified in pids_forking on v1 */
+	if (!cgroup_subsys_on_dfl(pids_cgrp_subsys))
+		return;
+
+	for (; parent_pids(p); p = parent_pids(p)) {
+		atomic64_inc(&p->events[PIDCG_MAX_IMPOSED]);
+
+		if (p == pids_over_limit)
+			limit = true;
+		if (limit)
+			atomic64_inc(&p->events[PIDCG_MAX]);
+
+		cgroup_file_notify(&p->events_file);
+	}
+}
+
 /*
  * task_css_check(true) in pids_can_fork() and pids_cancel_fork() relies
  * on cgroup_threadgroup_change_begin() held by the copy_process().
@@ -254,23 +282,9 @@ static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 		css = task_css_check(current, pids_cgrp_id, true);
 	pids = css_pids(css);
 	err = pids_try_charge(pids, 1, &pids_over_limit);
-	if (err) {
-		/* compatibility on v1 where events were notified in leaves. */
-		if (!cgroup_subsys_on_dfl(pids_cgrp_subsys))
-			pids_over_limit = pids;
-
-		/* Only log the first time limit is hit. */
-		if (atomic64_inc_return(&pids->events[PIDCG_MAX_IMPOSED]) == 1) {
-			pr_info("cgroup: fork rejected by pids controller in ");
-			pr_cont_cgroup_path(pids->css.cgroup);
-			pr_cont("\n");
-		}
-		atomic64_inc(&pids_over_limit->events[PIDCG_MAX]);
+	if (err)
+		pids_event(pids, pids_over_limit);
 
-		cgroup_file_notify(&pids->events_file);
-		if (pids_over_limit != pids)
-			cgroup_file_notify(&pids_over_limit->events_file);
-	}
 	return err;
 }
 
-- 
2.44.0


