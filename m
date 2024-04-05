Return-Path: <linux-kselftest+bounces-7302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01C289A30E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867CB289938
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E786C17167D;
	Fri,  5 Apr 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SxcqlR4J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SxcqlR4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD5171651;
	Fri,  5 Apr 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336755; cv=none; b=qIg46EOHRbp77QPuL4I8U1SSokqg1TWOWzZYlhcIcvOq0XwqXHeQirNQnkF0vntmMCj44Fk3nPFcRbAnimoXW/ioGZMBXUR/Jb0F56PYdzPXMHkbnaJ7pWL4jjt85mKeC0K/TqnHpDPWZjwBkCKzI78m6P4cRgkRAqyhtJh9Llk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336755; c=relaxed/simple;
	bh=1w2TKTMlNpVRU1sF7Zq0Ys1KBgyYzKCq6yP4qFU/Ze8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WV1R6BGvFJEr4B9sfdchIpzsccKYpHq5+2NxlCzl+7GHKnxBUEPYhWY9RFxgn5qFYSnFLf52slEpGrJ3vYvtDPds0DNuvWh5IavtkJdpUQqCysMGtxFAe6hqXFafDx//H5b13vwHynM4y7gvF8o7DxD6ZGhuelfUGwubwYfe5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SxcqlR4J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SxcqlR4J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A68C1F7F2;
	Fri,  5 Apr 2024 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HFLvwNkkohqs8nr8mn89oRBeVGr2rUcscWOP23yK2w=;
	b=SxcqlR4JtSJ8m7RFoAey2ENvodDZGYd7cOmcSfWJceo+ulAeN0w1xJicWODdyBgdrUbY0w
	kTSE1dRVT/0oJsPvCkhGZXEXSeOFjaR7xoaax2XZYHLRL0AGShSXzNJuCtgtoNgWY2PwTK
	2dAxxkkYWZBY8ml9cz5KA3pdZNztCn0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HFLvwNkkohqs8nr8mn89oRBeVGr2rUcscWOP23yK2w=;
	b=SxcqlR4JtSJ8m7RFoAey2ENvodDZGYd7cOmcSfWJceo+ulAeN0w1xJicWODdyBgdrUbY0w
	kTSE1dRVT/0oJsPvCkhGZXEXSeOFjaR7xoaax2XZYHLRL0AGShSXzNJuCtgtoNgWY2PwTK
	2dAxxkkYWZBY8ml9cz5KA3pdZNztCn0=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 03CA813AB3;
	Fri,  5 Apr 2024 17:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2MdBAHAvEGYteAAAn2gu4w
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
Subject: [RFC PATCH v3 7/9] cgroup/pids: Replace uncharge/charge pair with a single function
Date: Fri,  5 Apr 2024 19:05:46 +0200
Message-ID: <20240405170548.15234-8-mkoutny@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

No functional change intended. This rework reduces modifications of pids
counters only to a minimal subtree of uncharged/charged cgroups.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/pids.c | 80 ++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index f5f81274658e..9df8a209a6e2 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -133,41 +133,23 @@ static void pids_uncharge(struct pids_cgroup *pids, int num)
 		pids_cancel(p, num);
 }
 
-/**
- * pids_charge - hierarchically charge the pid count
- * @pids: the pid cgroup state
- * @num: the number of pids to charge
- *
- * This function does *not* follow the pid limit set. It cannot fail and the new
- * pid count may exceed the limit. This is only used for reverting failed
- * attaches, where there is no other way out than violating the limit.
- */
-static void pids_charge(struct pids_cgroup *pids, int num)
-{
-	struct pids_cgroup *p;
-
-	for (p = pids; parent_pids(p); p = parent_pids(p)) {
-		int64_t new = atomic64_add_return(num, &p->counter);
-
-		pids_update_watermark(p, new);
-	}
-}
-
 /**
  * pids_try_charge - hierarchically try to charge the pid count
  * @pids: the pid cgroup state
  * @num: the number of pids to charge
+ * @root: charge only under this root (NULL is global root)
  * @fail: storage of pid cgroup causing the fail
  *
  * This function follows the set limit. It will fail if the charge would cause
- * the new value to exceed the hierarchical limit. Returns 0 if the charge
- * succeeded, otherwise -EAGAIN.
+ * the new value to exceed the hierarchical limit and fail is set. Returns 0 if
+ * no limit was hit, otherwise -EAGAIN.
  */
-static int pids_try_charge(struct pids_cgroup *pids, int num, struct pids_cgroup **fail)
+static int pids_try_charge(struct pids_cgroup *pids, int num, struct pids_cgroup *root, struct pids_cgroup **fail)
 {
 	struct pids_cgroup *p, *q;
+	int ret = 0;
 
-	for (p = pids; parent_pids(p); p = parent_pids(p)) {
+	for (p = pids; parent_pids(p) && p != root; p = parent_pids(p)) {
 		int64_t new = atomic64_add_return(num, &p->counter);
 		int64_t limit = atomic64_read(&p->limit);
 
@@ -177,8 +159,11 @@ static int pids_try_charge(struct pids_cgroup *pids, int num, struct pids_cgroup
 		 * fail.
 		 */
 		if (new > limit) {
-			*fail = p;
-			goto revert;
+			ret = -EAGAIN;
+			if (fail) {
+				*fail = p;
+				goto revert;
+			}
 		}
 		/*
 		 * Not technically accurate if we go over limit somewhere up
@@ -187,14 +172,45 @@ static int pids_try_charge(struct pids_cgroup *pids, int num, struct pids_cgroup
 		pids_update_watermark(p, new);
 	}
 
-	return 0;
+	return ret;
 
 revert:
 	for (q = pids; q != p; q = parent_pids(q))
 		pids_cancel(q, num);
 	pids_cancel(p, num);
 
-	return -EAGAIN;
+	return ret;
+}
+
+/**
+ * pids_tranfer_charge - charge/uncharge in subtree betwee src and dst
+ * @src: pid cgroup state to uncharge
+ * @dst: pid cgroup state to charge
+ * @num: the number of pids to transfer
+ *
+ * The function updates charged pids in subtree whose root is the closest
+ * common ancestor of @src and @dst. This root and its ancestors are not
+ * modified (their limits are not enacted).
+ *
+ * Returns 0 if no limit was hit, -EAGAIN if a limit on path [@dst, @comm) was
+ * hit (charges are transferred despite the limit).
+ */
+static int pids_tranfer_charge(struct pids_cgroup *src, struct pids_cgroup *dst, int num)
+{
+	struct pids_cgroup *p, *comm = src;
+	int ret;
+
+	/* for stable cgroup tree */
+	lockdep_assert_held(&cgroup_mutex);
+
+	while (!cgroup_is_descendant(dst->css.cgroup, comm->css.cgroup))
+		comm = parent_pids(comm);
+
+	ret = pids_try_charge(dst, num, comm, NULL);
+
+	for (p = src; p != comm; p = parent_pids(p))
+		pids_cancel(p, num);
+	return ret;
 }
 
 static int pids_can_attach(struct cgroup_taskset *tset)
@@ -215,8 +231,7 @@ static int pids_can_attach(struct cgroup_taskset *tset)
 		old_css = task_css(task, pids_cgrp_id);
 		old_pids = css_pids(old_css);
 
-		pids_charge(pids, 1);
-		pids_uncharge(old_pids, 1);
+		(void) pids_tranfer_charge(old_pids, pids, 1);
 	}
 
 	return 0;
@@ -235,8 +250,7 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
 		old_css = task_css(task, pids_cgrp_id);
 		old_pids = css_pids(old_css);
 
-		pids_charge(old_pids, 1);
-		pids_uncharge(pids, 1);
+		(void) pids_tranfer_charge(pids, old_pids, 1);
 	}
 }
 
@@ -287,7 +301,7 @@ static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 	else
 		css = task_css_check(current, pids_cgrp_id, true);
 	pids = css_pids(css);
-	err = pids_try_charge(pids, 1, &pids_over_limit);
+	err = pids_try_charge(pids, 1, NULL, &pids_over_limit);
 	if (err)
 		pids_event(pids, pids_over_limit);
 
-- 
2.44.0


