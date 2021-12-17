Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E447904E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 16:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhLQPtO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 10:49:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43276 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhLQPtO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 10:49:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3C9F1F38B;
        Fri, 17 Dec 2021 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639756152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMAVP9J2GHVSmKC+cLlgFMSosIKR4Gu62W3/R1oimQs=;
        b=C5fXhkyP2MnU0nq4MLVst5WF2II5sGuDOjIZgvNjdXxGfo3wB51ZGJ5VTMQxvb39n+diVK
        qiC0kGQeCM7d8SGibFBwLzKw0gVfk7h+jHJ4HDHCgIdURV58x38TuN74p7GGKt6k30tE91
        GVKnPNVTmtSGP3wcvwASna04ilcjkF4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63496139C1;
        Fri, 17 Dec 2021 15:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V5y0F3ixvGFfRwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 17 Dec 2021 15:49:12 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     longman@redhat.com, tj@kernel.org
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org, corbet@lwn.net,
        frederic@kernel.org, guro@fb.com, hannes@cmpxchg.org,
        juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lizefan.x@bytedance.com, mkoutny@suse.com, mtosatti@redhat.com,
        pauld@redhat.com, peterz@infradead.org, shuah@kernel.org
Subject: [PATCH] cgroup/cpuset: Make child cpusets restrict parents on v1 hierarchy
Date:   Fri, 17 Dec 2021 16:48:54 +0100
Message-Id: <20211217154854.41409-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <8d73dc26-74e1-d763-d897-6e03cdac3c8c@redhat.com>
References: <8d73dc26-74e1-d763-d897-6e03cdac3c8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The commit 1f1562fcd04a ("cgroup/cpuset: Don't let child cpusets
restrict parent in default hierarchy") inteded to relax the check only
on the default hierarchy (or v2 mode) but it dropped the check in v1
too.

This patch returns and separates the legacy-only validations so that
they can be considered only in the v1 mode, which should enforce the old
constraints for the sake of compatibility.

Fixes: 1f1562fcd04a ("cgroup/cpuset: Don't let child cpusets restrict parent in default hierarchy")
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset.c | 52 ++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 12 deletions(-)

This is formatted as a separate patch fixing the already queued change in
for-5.17 but it can be eventually squashed into the referenced commit AFAIAC.

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0dd7d853ed17..ce6929ddc0b0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -590,6 +590,35 @@ static inline void free_cpuset(struct cpuset *cs)
 	kfree(cs);
 }
 
+/*
+ * validate_change_legacy() - Validate conditions specific to legacy (v1)
+ *                            behavior.
+ */
+static int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
+{
+	struct cgroup_subsys_state *css;
+	struct cpuset *c, *par;
+	int ret;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	/* Each of our child cpusets must be a subset of us */
+	ret = -EBUSY;
+	cpuset_for_each_child(c, css, cur)
+		if (!is_cpuset_subset(c, trial))
+			goto out;
+
+	/* On legacy hierarchy, we must be a subset of our parent cpuset. */
+	ret = -EACCES;
+	par = parent_cs(cur);
+	if (par && !is_cpuset_subset(trial, par))
+		goto out;
+
+	ret = 0;
+out:
+	return ret;
+}
+
 /*
  * validate_change() - Used to validate that any proposed cpuset change
  *		       follows the structural rules for cpusets.
@@ -614,20 +643,21 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *c, *par;
-	int ret;
-
-	/* The checks don't apply to root cpuset */
-	if (cur == &top_cpuset)
-		return 0;
+	int ret = 0;
 
 	rcu_read_lock();
-	par = parent_cs(cur);
 
-	/* On legacy hierarchy, we must be a subset of our parent cpuset. */
-	ret = -EACCES;
-	if (!is_in_v2_mode() && !is_cpuset_subset(trial, par))
+	if (!is_in_v2_mode())
+		ret = validate_change_legacy(cur, trial);
+	if (ret)
+		goto out;
+
+	/* Remaining checks don't apply to root cpuset */
+	if (cur == &top_cpuset)
 		goto out;
 
+	par = parent_cs(cur);
+
 	/*
 	 * If either I or some sibling (!= me) is exclusive, we can't
 	 * overlap
@@ -1175,9 +1205,7 @@ enum subparts_cmd {
  *
  * Because of the implicit cpu exclusive nature of a partition root,
  * cpumask changes that violates the cpu exclusivity rule will not be
- * permitted when checked by validate_change(). The validate_change()
- * function will also prevent any changes to the cpu list if it is not
- * a superset of children's cpu lists.
+ * permitted when checked by validate_change().
  */
 static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 					  struct cpumask *newmask,
-- 
2.33.1

