Return-Path: <linux-kselftest+bounces-8154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A518A6DFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF7B272CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00181332BE;
	Tue, 16 Apr 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lfsb+EnN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lfsb+EnN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC108130A4B;
	Tue, 16 Apr 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277219; cv=none; b=p61NJ3CLoile8tsXTgsDKs0QOWEqLZmTZBunqlCh3s1C4iwGC8aGEqUlJatIDDTqWU5J6tjgHr1Es0EOZR4p/eaCUJHoC5TdTNFRBLfwdiFZICSi6tNNry0f7pJu2iJyIBqQD3BHStqPfiH23B1tc8YLyMPWqjVPsl/qfBHDFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277219; c=relaxed/simple;
	bh=JX6xd6eKoSVT/WlpPp/PH4f5xocxKUURNataKL1beVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZY+LkoknC14XiFVO8gHlficO2oMr2n7jOFbYK72zlovincT1GrwXA1Fomohh1SN0zuhyF8sU3/dwE7yYh4Xgpeh86zBIJRXrhnisQ1KhEjD0iKjFuI3S9OadKW2kep8CTqD88GagFnKA2jm1YsaGE2AbFjDuT5WYAcuqiJlJF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lfsb+EnN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lfsb+EnN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3193B3754E;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjNmC9MQWUXNQEGaN9XnQq9166q4BWnQwi+RQgxW1U4=;
	b=lfsb+EnNQpcdKNe144vcv6BVWWU4Ne5dpNLuzY7+08RUcFGUB9cFo3uWSfESLx0x5YZ91D
	ZIW0Fb5rG/vck2JCuAnwcTe72gLfDqltVy7lqcRv01HnAuj9FQolmxAw3/H3n01U6AkPmF
	/OFyxXX3Xgiw76Ru5PvE8LmXsf01Ylc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjNmC9MQWUXNQEGaN9XnQq9166q4BWnQwi+RQgxW1U4=;
	b=lfsb+EnNQpcdKNe144vcv6BVWWU4Ne5dpNLuzY7+08RUcFGUB9cFo3uWSfESLx0x5YZ91D
	ZIW0Fb5rG/vck2JCuAnwcTe72gLfDqltVy7lqcRv01HnAuj9FQolmxAw3/H3n01U6AkPmF
	/OFyxXX3Xgiw76Ru5PvE8LmXsf01Ylc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1947913931;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kFcIBiCJHmbAbQAAD6G6ig
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
Subject: [PATCH v4 3/6] cgroup/pids: Make event counters hierarchical
Date: Tue, 16 Apr 2024 16:20:11 +0200
Message-ID: <20240416142014.27630-4-mkoutny@suse.com>
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
X-Spamd-Result: default: False [-0.75 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.45)[78.91%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -0.75
X-Spam-Flag: NO

The pids.events file should honor the hierarchy, so make the events
propagate from their origin up to the root on the unified hierarchy. The
legacy behavior remains non-hierarchical.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  2 +-
 kernel/cgroup/pids.c                    | 46 ++++++++++++++++---------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 108b03dfb26a..aa97e9f91c51 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -241,7 +241,7 @@ cgroup v2 currently supports the following mount options.
 
   pid_localevents
         Represent fork failures inside cgroup's pids.events:max (not its limit
-        being hit).
+        being hit) and exclude subtree events from pids.events.
 
 
 Organizing Processes and Threads
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index ea1fc6b37c0d..4ad28109c1c8 100644
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


