Return-Path: <linux-kselftest+bounces-7309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0789A327
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4811F24E84
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F341172790;
	Fri,  5 Apr 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Np8NKrm8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BQG5Qlck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B359171665;
	Fri,  5 Apr 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336757; cv=none; b=cgU3AWLzeMrUnWiEwSMqVuWwNgrkaWOO7SmW/COQ3ldVD2cf53Bk0Tf+4AHtEC/5mgVReqUOS9lXIJrGtR5ogNRZmFkPUQ8ArspJmZE07rgsgXblYDzuMknekZJqS6J/Jc6QhhuzwkTZaBvYh+ZCpUz8ikDe64YCDmaGOICfHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336757; c=relaxed/simple;
	bh=AVXC1iCd9NBLC2Msgkz6+GmM9FNRPydkge/20Ldmzqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PC0eotNMnuK8HenY9GtFEtd/QhezuY3M4tG5PluvKoxwrBCrS3YDRW6mj+bQz4RY5kIqKyoci75vXlPzonJ23ibSL4LD1bRPGd0Da9VlHg55kx6ycryF7Gy1Zw6x1IOr8nKgEgbssdpVdsW3lQhh2xOZZpMhLFVVfkvScBRcZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Np8NKrm8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BQG5Qlck; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9735A21AC1;
	Fri,  5 Apr 2024 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhORgcMqukZeoN8nPu696Ffaj3DcfndUAkskxcIcS5A=;
	b=Np8NKrm8JvSiOrGZgfUFzRDwKGh7KmoxaVgmwdYhnfgc/H3rEzIBgewyVnOcHLizpTFOpu
	yIkA2lCnb6N5iJPcx8Iz6QhmYC9AQYL0B1GyrFbW8m13LKqh4XYCBsTLM3Lp6NeGeuISpI
	fSyF24pHkCIMSkuvUI9Og7kl0VNBf80=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BQG5Qlck
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhORgcMqukZeoN8nPu696Ffaj3DcfndUAkskxcIcS5A=;
	b=BQG5QlckHEHyiAAX6helwYcS4V/BH/xIjs9yrntAOiUJeU1PyVnqK47jpolQB8xiGCl7Zg
	HF1np1ayrdYwkpU0f95+c4/0Afl6ze4BdqLN6H2J5vq4KvOlSVgvdpG1zZC2E8g5Cf2j7Y
	eIq1ShwduaI59ymFPoxpyrsfCusVNi4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6969E13AAE;
	Fri,  5 Apr 2024 17:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aBEEGW8vEGYteAAAn2gu4w
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
Subject: [RFC PATCH v3 4/9] cgroup/pids: Add pids.events.local
Date: Fri,  5 Apr 2024 19:05:43 +0200
Message-ID: <20240405170548.15234-5-mkoutny@suse.com>
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
X-Spamd-Result: default: False [-0.53 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.02)[53.81%];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfcexjtczxtbnj559fj95g6y7)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -0.53
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 9735A21AC1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Hierarchical counting of events is not practical for watching when a
particular pids.max is being hit. Therefore introduce .local flavor of
events file (akin to memory controller) that collects only events
relevant to given cgroup.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/pids.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 76c0a97e42da..f5f81274658e 100644
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
@@ -245,11 +247,12 @@ static void pids_event(struct pids_cgroup *pids_forking,
 	bool limit = false;
 
 	/* Only log the first time limit is hit. */
-	if (atomic64_inc_return(&p->events[PIDCG_MAX_IMPOSED]) == 1) {
+	if (atomic64_inc_return(&p->events_local[PIDCG_MAX_IMPOSED]) == 1) {
 		pr_info("cgroup: fork rejected by pids controller in ");
 		pr_cont_cgroup_path(p->css.cgroup);
 		pr_cont("\n");
 	}
+	cgroup_file_notify(&p->events_local_file);
 	/* Events are only notified in pids_forking on v1 */
 	if (!cgroup_subsys_on_dfl(pids_cgrp_subsys))
 		return;
@@ -257,8 +260,11 @@ static void pids_event(struct pids_cgroup *pids_forking,
 	for (; parent_pids(p); p = parent_pids(p)) {
 		atomic64_inc(&p->events[PIDCG_MAX_IMPOSED]);
 
-		if (p == pids_over_limit)
+		if (p == pids_over_limit) {
 			limit = true;
+			atomic64_inc(&p->events_local[PIDCG_MAX]);
+			cgroup_file_notify(&p->events_local_file);
+		}
 		if (limit)
 			atomic64_inc(&p->events[PIDCG_MAX]);
 
@@ -368,12 +374,25 @@ static s64 pids_peak_read(struct cgroup_subsys_state *css,
 	return READ_ONCE(pids->watermark);
 }
 
-static int pids_events_show(struct seq_file *sf, void *v)
+static int __pids_events_show(struct seq_file *sf, bool local)
 {
 	struct pids_cgroup *pids = css_pids(seq_css(sf));
+	atomic64_t *events = local ? pids->events_local : pids->events;
+
+	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&events[PIDCG_MAX]));
+	seq_printf(sf, "max.imposed %lld\n", (s64)atomic64_read(&events[PIDCG_MAX_IMPOSED]));
+	return 0;
+}
+
+static int pids_events_show(struct seq_file *sf, void *v)
+{
+	__pids_events_show(sf, false);
+	return 0;
+}
 
-	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&pids->events[PIDCG_MAX]));
-	seq_printf(sf, "max.imposed %lld\n", (s64)atomic64_read(&pids->events[PIDCG_MAX_IMPOSED]));
+static int pids_events_local_show(struct seq_file *sf, void *v)
+{
+	__pids_events_show(sf, true);
 	return 0;
 }
 
@@ -381,7 +400,7 @@ static int pids_events_show_legacy(struct seq_file *sf, void *v)
 {
 	struct pids_cgroup *pids = css_pids(seq_css(sf));
 
-	seq_printf(sf, "max%lld\n", (s64)atomic64_read(&pids->events[PIDCG_MAX_IMPOSED]));
+	seq_printf(sf, "max%lld\n", (s64)atomic64_read(&pids->events_local[PIDCG_MAX_IMPOSED]));
 	return 0;
 }
 
@@ -408,6 +427,12 @@ static struct cftype pids_files[] = {
 		.file_offset = offsetof(struct pids_cgroup, events_file),
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "events.local",
+		.seq_show = pids_events_local_show,
+		.file_offset = offsetof(struct pids_cgroup, events_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{ }	/* terminate */
 };
 
@@ -426,7 +451,7 @@ static struct cftype pids_files_legacy[] = {
 	{
 		.name = "events",
 		.seq_show = pids_events_show_legacy,
-		.file_offset = offsetof(struct pids_cgroup, events_file),
+		.file_offset = offsetof(struct pids_cgroup, events_local_file),
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
 	{ }	/* terminate */
-- 
2.44.0


