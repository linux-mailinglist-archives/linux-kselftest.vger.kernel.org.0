Return-Path: <linux-kselftest+bounces-8153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC28A6DF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7E0282B12
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5E61332B6;
	Tue, 16 Apr 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VtMx5FyC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VtMx5FyC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4B13175E;
	Tue, 16 Apr 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277219; cv=none; b=SNgAxbUpTkNURyT/GRKwgKBAcTX9Ih6z0/9Af9OFtO4v5+XCFN6frFuxGXwnNJf1tV2LIz/3tjXL9sZaeNy09f0FW3pCy8NHgKBS9ohF5Tja6StoQwW7tc6f3Pwp4Bdo0Aj9G4JJmWMT0MG2HTj7CJ9jScIVC7RzxH5sHxft4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277219; c=relaxed/simple;
	bh=ubGo9+oTOS6QkbCEkb9Q6EFpn/e6bGuz7bkTFXxC8/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gex4OeG+nI4laQyeqcR950cXKaHLDa88XhbnYf9znEDhRxclbiWoMvt9rgmUru+yKXYtdOTDttOH0yluPc9+QjH3Zqw+4o+a5G2Ivi3y4Zt0uCblEmIEQmifx8FKdMhiOrT083cO5QTOzl2Wd48X5R+8JzodMyy3CXmCjcrx/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VtMx5FyC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VtMx5FyC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4931B37BEF;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEHppgTc66ahiza21E2iZYSu3pjbMVVB7MdpEadnVeQ=;
	b=VtMx5FyCqqRb+Kz9dksJAxMjxwWJ2r6oNcRmiXT2Na3oem9yMhoepW19YbTFAX/hJuPiwl
	NAR18es08he70+xqQpqpN+mztLOoh4G9b6P9wrfG10FpxTzq1/JArFZWyQMwAedD0UCa/Q
	iBJP5Tm5f9ANhya0Gj/EpcQDf+cFP10=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEHppgTc66ahiza21E2iZYSu3pjbMVVB7MdpEadnVeQ=;
	b=VtMx5FyCqqRb+Kz9dksJAxMjxwWJ2r6oNcRmiXT2Na3oem9yMhoepW19YbTFAX/hJuPiwl
	NAR18es08he70+xqQpqpN+mztLOoh4G9b6P9wrfG10FpxTzq1/JArFZWyQMwAedD0UCa/Q
	iBJP5Tm5f9ANhya0Gj/EpcQDf+cFP10=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F41713942;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eGFmCyCJHmbAbQAAD6G6ig
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
Subject: [PATCH v4 4/6] cgroup/pids: Add pids.events.local
Date: Tue, 16 Apr 2024 16:20:12 +0200
Message-ID: <20240416142014.27630-5-mkoutny@suse.com>
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
X-Spam-Score: -3.30
X-Spam-Flag: NO

Hierarchical counting of events is not practical for watching when a
particular pids.max is being hit. Therefore introduce .local flavor of
events file (akin to memory controller) that collects only events
relevant to given cgroup.

The file is only added to the default hierarchy.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/pids.c | 88 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 4ad28109c1c8..6cd15c3785d4 100644
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
@@ -416,5 +469,6 @@ struct cgroup_subsys pids_cgrp_subsys = {
 	.cancel_fork	= pids_cancel_fork,
 	.release	= pids_release,
 	.dfl_cftypes	= pids_files,
+	.legacy_cftypes = pids_files_legacy,
 	.threaded	= true,
 };
-- 
2.44.0


