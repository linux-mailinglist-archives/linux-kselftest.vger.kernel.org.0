Return-Path: <linux-kselftest+bounces-10469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DC78CAA9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DA6283120
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A457CB1;
	Tue, 21 May 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kZwEtK84";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kZwEtK84"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450D47A7C;
	Tue, 21 May 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283295; cv=none; b=a3H+l6p4SzcFUClz9tumWq98Jk9Sm8bICOXtawGotd1CCnfNPFz+BNGy8lmc9ZqS+rOaLJygR4fqjLahwFF9Wtj3uEJwh7DweT16U05onozUFjXo6hPN1Q4P+bbzMPuv7jVUx1JBsHw6Iu4scMsx3wW1m3HJR1mg/Q+gLdo6g1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283295; c=relaxed/simple;
	bh=b9/Tim9UjsTQ/Ly7qH+LkANsbWjkWuDa/ghrNqz0c68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acY1amqv1ST8Rp11Jp9IM3HhWVwJrEsR2Mc+r17YP/12ad2IgqpijclKxeHRqKIsuxh8gBbY+RIGTtLnIdkzvFvwI9VmHiieKdLR6LpPvrw79anu06J8kK+SB9AY4AYmEdKopFkuzDxLF6vjT7ksjdi11fmKvE2HPKSK+/I7D40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kZwEtK84; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kZwEtK84; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC0C134632;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M71L2bSoBNtqG+SVJil6QJgye81u3ko4WdjXqhOELEM=;
	b=kZwEtK84QrpZg2iSi1TYEcvAyxWELlaaewrMlLIc3ljcOamatu00lwUgDEvf++P0xuL6c+
	et+YXWKxgmG4ubpJ5BoU/7GXEQ0zUv1EmQhsnjpXNPK9OWeLWqNJSoZNJEu4sszsKqUtWk
	kUCAS+ddEURSaPIVEoDK7c/tHZPmeII=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M71L2bSoBNtqG+SVJil6QJgye81u3ko4WdjXqhOELEM=;
	b=kZwEtK84QrpZg2iSi1TYEcvAyxWELlaaewrMlLIc3ljcOamatu00lwUgDEvf++P0xuL6c+
	et+YXWKxgmG4ubpJ5BoU/7GXEQ0zUv1EmQhsnjpXNPK9OWeLWqNJSoZNJEu4sszsKqUtWk
	kUCAS+ddEURSaPIVEoDK7c/tHZPmeII=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC57613A7A;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WOzAMZtnTGaZYgAAD6G6ig
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
Subject: [PATCH v5 3/5] cgroup/pids: Add pids.events.local
Date: Tue, 21 May 2024 11:21:28 +0200
Message-ID: <20240521092130.7883-4-mkoutny@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

Hierarchical counting of events is not practical for watching when a
particular pids.max is being hit. Therefore introduce .local flavor of
events file (akin to memory controller) that collects only events
relevant to given cgroup.

The file is only added to the default hierarchy.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  5 ++
 kernel/cgroup/pids.c                    | 89 ++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0b5f77104e8b..782656dcf38b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2211,6 +2211,11 @@ PID Interface Files
 		The number of times the cgroup's total number of processes hit the pids.max
 		limit (see also pids_localevents).
 
+  pids.events.local
+	Similar to pids.events but the fields in the file are local
+	to the cgroup i.e. not hierarchical. The file modified event
+	generated on this file reflects only the local events.
+
 Organisational operations are not blocked by cgroup policies, so it is
 possible to have pids.current > pids.max.  This can be done by either
 setting the limit to be smaller than pids.current, or attaching enough
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index c09b744d548c..f5cb0ec45b9d 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -57,10 +57,12 @@ struct pids_cgroup {
 	atomic64_t			limit;
 	int64_t				watermark;
 
-	/* Handle for "pids.events" */
+	/* Handles for pids.events[.local] */
 	struct cgroup_file		events_file;
+	struct cgroup_file		events_local_file;
 
 	atomic64_t			events[NR_PIDCG_EVENTS];
+	atomic64_t			events_local[NR_PIDCG_EVENTS];
 };
 
 static struct pids_cgroup *css_pids(struct cgroup_subsys_state *css)
@@ -244,21 +246,23 @@ static void pids_event(struct pids_cgroup *pids_forking,
 	struct pids_cgroup *p = pids_forking;
 	bool limit = false;
 
-	for (; parent_pids(p); p = parent_pids(p)) {
-		/* Only log the first time limit is hit. */
-		if (atomic64_inc_return(&p->events[PIDCG_FORKFAIL]) == 1) {
-			pr_info("cgroup: fork rejected by pids controller in ");
-			pr_cont_cgroup_path(p->css.cgroup);
-			pr_cont("\n");
-		}
-		cgroup_file_notify(&p->events_file);
-
-		if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
-		    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
-			break;
+	/* Only log the first time limit is hit. */
+	if (atomic64_inc_return(&p->events_local[PIDCG_FORKFAIL]) == 1) {
+		pr_info("cgroup: fork rejected by pids controller in ");
+		pr_cont_cgroup_path(p->css.cgroup);
+		pr_cont("\n");
+	}
+	cgroup_file_notify(&p->events_local_file);
+	if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
+	    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
+		return;
 
-		if (p == pids_over_limit)
+	for (; parent_pids(p); p = parent_pids(p)) {
+		if (p == pids_over_limit) {
 			limit = true;
+			atomic64_inc(&p->events_local[PIDCG_MAX]);
+			cgroup_file_notify(&p->events_local_file);
+		}
 		if (limit)
 			atomic64_inc(&p->events[PIDCG_MAX]);
 
@@ -368,20 +372,68 @@ static s64 pids_peak_read(struct cgroup_subsys_state *css,
 	return READ_ONCE(pids->watermark);
 }
 
-static int pids_events_show(struct seq_file *sf, void *v)
+static int __pids_events_show(struct seq_file *sf, bool local)
 {
 	struct pids_cgroup *pids = css_pids(seq_css(sf));
 	enum pidcg_event pe = PIDCG_MAX;
+	atomic64_t *events;
 
 	if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
-	    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
+	    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS) {
 		pe = PIDCG_FORKFAIL;
+		local = true;
+	}
+	events = local ? pids->events_local : pids->events;
 
-	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&pids->events[pe]));
+	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&events[pe]));
+	return 0;
+}
+
+static int pids_events_show(struct seq_file *sf, void *v)
+{
+	__pids_events_show(sf, false);
+	return 0;
+}
+
+static int pids_events_local_show(struct seq_file *sf, void *v)
+{
+	__pids_events_show(sf, true);
 	return 0;
 }
 
 static struct cftype pids_files[] = {
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
+		.name = "peak",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = pids_peak_read,
+	},
+	{
+		.name = "events",
+		.seq_show = pids_events_show,
+		.file_offset = offsetof(struct pids_cgroup, events_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "events.local",
+		.seq_show = pids_events_local_show,
+		.file_offset = offsetof(struct pids_cgroup, events_local_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{ }	/* terminate */
+};
+
+static struct cftype pids_files_legacy[] = {
 	{
 		.name = "max",
 		.write = pids_max_write,
@@ -407,6 +459,7 @@ static struct cftype pids_files[] = {
 	{ }	/* terminate */
 };
 
+
 struct cgroup_subsys pids_cgrp_subsys = {
 	.css_alloc	= pids_css_alloc,
 	.css_free	= pids_css_free,
@@ -415,7 +468,7 @@ struct cgroup_subsys pids_cgrp_subsys = {
 	.can_fork	= pids_can_fork,
 	.cancel_fork	= pids_cancel_fork,
 	.release	= pids_release,
-	.legacy_cftypes	= pids_files,
+	.legacy_cftypes = pids_files_legacy,
 	.dfl_cftypes	= pids_files,
 	.threaded	= true,
 };
-- 
2.44.0


