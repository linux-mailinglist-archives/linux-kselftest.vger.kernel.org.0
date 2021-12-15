Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396344758CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 13:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbhLOMXm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 07:23:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58028 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbhLOMXj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 07:23:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 131AF21108;
        Wed, 15 Dec 2021 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639571018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avoTfhAIE8R7plOAMrdkELVazcBOzYRbmMgCN9727sU=;
        b=T17FiyPAxKd0Yte7bfskTZz86haYl0Bhyu1oEU3dBC0Byq4R81utmk2R8NnWvJlLEkNjmQ
        PQ2K4DAUcRZXOVdzOwGylMO1h2WGB0bo4/D0wWjpTbKtLayoEqYPqIm7XVSK6xn5fuAHgH
        9acEHy8TFSSfSvxC/wiRw5dJdDouR0I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF14213B27;
        Wed, 15 Dec 2021 12:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fFfiMUneuWFJLQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 15 Dec 2021 12:23:37 +0000
Date:   Wed, 15 Dec 2021 13:23:36 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v9 1/7] cgroup/cpuset: Don't let child cpusets restrict
 parent in default hierarchy
Message-ID: <20211215122336.GB25459@blackbody.suse.cz>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-2-longman@redhat.com>
 <Ybev80+h4JArgMDz@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybev80+h4JArgMDz@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 13, 2021 at 10:41:23AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > To address this issue, the check is now removed for the default hierarchy
> > to free parent cpusets from being restricted by child cpusets. The
> > check will still apply for legacy hierarchy.

I'm trying to find whether something in update_cpumasks_hier() ensures
the constraint is checkd on the legacy hierarchy but it seems to me this
baby was thrown out with the bathwater. How is the legacy check still
applied?

> Applied to cgroup/for-5.17.

It comes out a bit more complex if I want to achieve both variants in
the below followup:

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0dd7d853ed17..8b6e06f504f6 100644
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
+	ret = validate_change_legacy(cur, trial);
+	if (ret)
+		goto out;
+
+	/* Remaining checks don't apply to root cpuset */
+	ret = 0;
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
