Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0E35AA127
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 22:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiIAU6r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiIAU6b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 16:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EB999248
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662065905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vcxKMjXClmm1CGJHlAQCcN01M2QmT/+Q6JHJZbXLhs=;
        b=SQyhS4Cesc9e6KIpsiq/wXrW2e7FJjriqPs4RrTLBQphaFDo1W+XIDB9eIEGs/U/q+0u6y
        +jAYU1Us1V8z0cgS+9OPbPDC/fStKlw145Op6bsZkIUBkjlyniR/qkLHkZmINGPHtgOsCn
        a0EMC3LhWO4hVVZG5F4N/bKIR9yGI7w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-PwzinuI9PW-4acSwvQ_56w-1; Thu, 01 Sep 2022 16:58:22 -0400
X-MC-Unique: PwzinuI9PW-4acSwvQ_56w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F1541C0896F;
        Thu,  1 Sep 2022 20:58:21 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A67EF1415137;
        Thu,  1 Sep 2022 20:58:20 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v12 08/10] cgroup/cpuset: Make partition invalid if cpumask change violates exclusivity rule
Date:   Thu,  1 Sep 2022 16:57:43 -0400
Message-Id: <20220901205745.323326-9-longman@redhat.com>
In-Reply-To: <20220901205745.323326-1-longman@redhat.com>
References: <20220901205745.323326-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, changes in "cpust.cpus" of a partition root is not allowed if
it violates the sibling cpu exclusivity rule when the check is done
in the validate_change() function. That is inconsistent with the
other cpuset changes that are always allowed but may make a partition
invalid.

Update the cpuset code to allow cpumask change even if it violates the
sibling cpu exclusivity rule, but invalidate the partition instead
just like the other changes. However, other sibling partitions with
conflicting cpumask will also be invalidated in order to not violating
the exclusivity rule. This behavior is specific to this partition
rule violation.

Note that a previous commit has made sibling cpu exclusivity rule check
the last check of validate_change(). So if -EINVAL is returned, we can
be sure that sibling cpu exclusivity rule violation is the only rule
that is broken.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 69 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b0d921d03f62..6baa977a71ba 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1256,6 +1256,7 @@ enum subparts_cmd {
 	partcmd_enable,		/* Enable partition root	 */
 	partcmd_disable,	/* Disable partition root	 */
 	partcmd_update,		/* Update parent's subparts_cpus */
+	partcmd_invalidate,	/* Make partition invalid	 */
 };
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
@@ -1286,13 +1287,17 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  * or vice versa. An error code will only be returned if transitioning from
  * invalid to valid violates the exclusivity rule.
  *
+ * For partcmd_invalidate, the current partition will be made invalid.
+ *
  * The partcmd_enable and partcmd_disable commands are used by
  * update_prstate(). An error code may be returned and the caller will check
  * for error.
  *
  * The partcmd_update command is used by update_cpumasks_hier() with newmask
- * NULL and update_cpumask() with newmask set. The callers won't check for
- * error and so partition_root_state and prs_error will be updated directly.
+ * NULL and update_cpumask() with newmask set. The partcmd_invalidate is used
+ * by update_cpumask() with NULL newmask. In both cases, the callers won't
+ * check for error and so partition_root_state and prs_error will be updated
+ * directly.
  */
 static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 					  struct cpumask *newmask,
@@ -1320,7 +1325,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		return PERR_CPUSEMPTY;
 
 	/*
-	 * new_prs will only be changed for the partcmd_update command.
+	 * new_prs will only be changed for the partcmd_update and
+	 * partcmd_invalidate commands.
 	 */
 	adding = deleting = false;
 	old_prs = new_prs = cs->partition_root_state;
@@ -1350,6 +1356,20 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		deleting = !is_prs_invalid(old_prs) &&
 			   cpumask_and(tmp->delmask, cs->cpus_allowed,
 				       parent->subparts_cpus);
+	} else if (cmd == partcmd_invalidate) {
+		if (is_prs_invalid(old_prs))
+			return 0;
+
+		/*
+		 * Make the current partition invalid. It is assumed that
+		 * invalidation is caused by violating cpu exclusivity rule.
+		 */
+		deleting = cpumask_and(tmp->delmask, cs->cpus_allowed,
+				       parent->subparts_cpus);
+		if (old_prs > 0) {
+			new_prs = -old_prs;
+			part_error = PERR_NOTEXCL;
+		}
 	} else if (newmask) {
 		/*
 		 * partcmd_update with newmask:
@@ -1403,6 +1423,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 					  parent->cpus_allowed);
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
+
 		if ((is_partition_valid(cs) && !parent->nr_subparts_cpus) ||
 		    (adding &&
 		     cpumask_subset(parent->effective_cpus, tmp->addmask) &&
@@ -1709,6 +1730,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 {
 	int retval;
 	struct tmpmasks tmp;
+	bool invalidate = false;
 
 	/* top_cpuset.cpus_allowed tracks cpu_online_mask; it's read-only */
 	if (cs == &top_cpuset)
@@ -1736,10 +1758,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
 		return 0;
 
-	retval = validate_change(cs, trialcs);
-	if (retval < 0)
-		return retval;
-
 #ifdef CONFIG_CPUMASK_OFFSTACK
 	/*
 	 * Use the cpumasks in trialcs for tmpmasks when they are pointers
@@ -1750,9 +1768,42 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	tmp.new_cpus = trialcs->cpus_allowed;
 #endif
 
+	retval = validate_change(cs, trialcs);
+
+	if ((retval == -EINVAL) && cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
+		struct cpuset *cp, *parent;
+		struct cgroup_subsys_state *css;
+
+		/*
+		 * The -EINVAL error code indicates that partition sibling
+		 * CPU exclusivity rule has been violated. We still allow
+		 * the cpumask change to proceed while invalidating the
+		 * partition. However, any conflicting sibling partitions
+		 * have to be marked as invalid too.
+		 */
+		invalidate = true;
+		rcu_read_lock();
+		parent = parent_cs(cs);
+		cpuset_for_each_child(cp, css, parent)
+			if (is_partition_valid(cp) &&
+			    cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
+				rcu_read_unlock();
+				update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
+				rcu_read_lock();
+			}
+		rcu_read_unlock();
+		retval = 0;
+	}
+	if (retval < 0)
+		return retval;
+
 	if (cs->partition_root_state) {
-		update_parent_subparts_cpumask(cs, partcmd_update,
-					       trialcs->cpus_allowed, &tmp);
+		if (invalidate)
+			update_parent_subparts_cpumask(cs, partcmd_invalidate,
+						       NULL, &tmp);
+		else
+			update_parent_subparts_cpumask(cs, partcmd_update,
+						trialcs->cpus_allowed, &tmp);
 	}
 
 	compute_effective_cpumask(trialcs->effective_cpus, trialcs,
-- 
2.31.1

