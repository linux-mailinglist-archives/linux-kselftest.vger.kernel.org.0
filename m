Return-Path: <linux-kselftest+bounces-10473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5C8CAAAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEC8B224C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2666BB33;
	Tue, 21 May 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VtQv1jNa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MDQNis8B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FB56770;
	Tue, 21 May 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283296; cv=none; b=pW9uqEpx4bVX4Fdhs+jJGrodRzl0UjLlnEFPM4hjTC2erSa0y54fvO4Ygg+sr1f3V2DQLucWom7IlrfR3BI2HSJVuP1T4oT0BCFBFLSGNJDce6PbjcilIf6lP+CiKBn59zbFpPLO2NlLBsMFWKUwm+H/fEdKLaozcUlRRebhkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283296; c=relaxed/simple;
	bh=B6uAzYGyhbOpoDj0Sj0mEz/Su8GLqQW+a3Rkh7C5tqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITfiEpyKL/6PGABWGbb8GyVqX1okKDTrJ1a5WemMabYtRJaYpzw8kZiQ0y1sZJwxIHt8Ekl/g27KhsTZv3nytoy4+4IsuyuOW5EknUoFgMyBxy3wpeyscnChEnWvhn0L1UOJHRnNj2QB6ENSfLF092y/TI7V/AGFaxbCs7EY1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VtQv1jNa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MDQNis8B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D235C5BFD6;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qceXSfz3LJ1Ky3PN6eGyHsIwnCsMUhAc+8g+mjeSwuE=;
	b=VtQv1jNaDCI8BUzouaeKWxppg3NUhBwehqEkaEdTKJKOpsU70ZpdhJ2qvobRRoCF/1z6Iq
	ztlTFzrHVnMPeVx8thASlw1uwbfq7p9TR71K7XPNwnBbdF6b5GwCNcAFBXOo1mn1ElkSyt
	Gk0DzE+Cyi/V23HeedWYWTGCql5MDvQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MDQNis8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qceXSfz3LJ1Ky3PN6eGyHsIwnCsMUhAc+8g+mjeSwuE=;
	b=MDQNis8Bvk95+f6XtVJdewE3fLfXSBJAcZ/jK4s1SL392nGaaqSrLxqlf/W2Mk+CDPhhS2
	+TA7FfsVi364jLfN92U3SCXF+F+S4MBz07h81ymYEo24MuNTj5AA3XtVl5hKnMisb5QKD4
	rKU8G4GN3YUO6dZRqQg4FZ0wuMhZkaM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C32F113A79;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SPiFL5tnTGaZYgAAD6G6ig
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
Subject: [PATCH v5 2/5] cgroup/pids: Make event counters hierarchical
Date: Tue, 21 May 2024 11:21:27 +0200
Message-ID: <20240521092130.7883-3-mkoutny@suse.com>
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
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D235C5BFD6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

The pids.events file should honor the hierarchy, so make the events
propagate from their origin up to the root on the unified hierarchy. The
legacy behavior remains non-hierarchical.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  9 +++--
 kernel/cgroup/pids.c                    | 46 ++++++++++++++++---------
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 945ff743a3c9..0b5f77104e8b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -240,8 +240,11 @@ cgroup v2 currently supports the following mount options.
           v2 is remounted later on).
 
   pids_localevents
-        Represent fork failures inside cgroup's pids.events:max (v1 behavior),
-        not its limit being hit (v2 behavior).
+        The option restores v1-like behavior of pids.events:max, that is only
+        local (inside cgroup proper) fork failures are counted. Without this
+        option pids.events.max represents any pids.max enforcemnt across
+        cgroup's subtree.
+
 
 
 Organizing Processes and Threads
@@ -2205,7 +2208,7 @@ PID Interface Files
 	modified event. The following entries are defined.
 
 	  max
-		The number of times the cgroup's number of processes hit the
+		The number of times the cgroup's total number of processes hit the pids.max
 		limit (see also pids_localevents).
 
 Organisational operations are not blocked by cgroup policies, so it is
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index a557f5c8300b..c09b744d548c 100644
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
+	for (; parent_pids(p); p = parent_pids(p)) {
+		/* Only log the first time limit is hit. */
+		if (atomic64_inc_return(&p->events[PIDCG_FORKFAIL]) == 1) {
+			pr_info("cgroup: fork rejected by pids controller in ");
+			pr_cont_cgroup_path(p->css.cgroup);
+			pr_cont("\n");
+		}
+		cgroup_file_notify(&p->events_file);
+
+		if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
+		    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
+			break;
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
-		if (atomic64_inc_return(&pids->events[PIDCG_FORKFAIL]) == 1) {
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


