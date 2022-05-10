Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151D2521F0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 17:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345576AbiEJPjz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346073AbiEJPjf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 11:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBA2995DD3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652196881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zmItBsl+o+clEdOgKlE44Gi7CMA+rlpMh3A+D5Vxp8=;
        b=T2ERyls5HsBrL/cMMEbyLyTQTZoZcX5Jyht5cErFNdQ/CvFCEKwQMm9QcO6scEKbtPeiTR
        +ukKu/vT38kqk1g4TtMQhGc/vfpg7jNqBMfmhliKdKlGoxVl9lfiU4z3TC3T3lvu7mQSB8
        MkGA4Ek9u3HnK4+YXlCUfND2QFrq3K8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-AYPo8gJ7PPKoG2PZX9IiJQ-1; Tue, 10 May 2022 11:34:36 -0400
X-MC-Unique: AYPo8gJ7PPKoG2PZX9IiJQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CD1418E5281;
        Tue, 10 May 2022 15:34:35 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E886401E31;
        Tue, 10 May 2022 15:34:35 +0000 (UTC)
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
Subject: [PATCH v11 6/8] cgroup/cpuset: Show invalid partition reason string
Date:   Tue, 10 May 2022 11:34:11 -0400
Message-Id: <20220510153413.400020-7-longman@redhat.com>
In-Reply-To: <20220510153413.400020-1-longman@redhat.com>
References: <20220510153413.400020-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are a number of different reasons which can cause a partition to
become invalid. A user seeing an invalid partition may not know exactly
why. To help user to get a better understanding of the underlying reason,
The cpuset.cpus.partition control file, when read, will now report the
reason why a partition become invalid. When a partition does become
invalid, reading the control file will show "root invalid (<reason>)"
where <reason> is a string that describes why the partition is invalid.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 93 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 18 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index dde45a16deec..261974f5bb3c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -85,6 +85,30 @@ struct fmeter {
 	spinlock_t lock;	/* guards read or write of above */
 };
 
+/*
+ * Invalid partition error code
+ */
+enum prs_errcode {
+	PERR_NONE = 0,
+	PERR_INVCPUS,
+	PERR_INVPARENT,
+	PERR_NOTPART,
+	PERR_NOTEXCL,
+	PERR_NOCPUS,
+	PERR_HOTPLUG,
+	PERR_CPUSEMPTY,
+};
+
+static const char * const perr_strings[] = {
+	[PERR_INVCPUS]   = "Invalid cpu list in cpuset.cpus",
+	[PERR_INVPARENT] = "Parent is an invalid partition root",
+	[PERR_NOTPART]   = "Parent is not a partition root",
+	[PERR_NOTEXCL]   = "Cpu list in cpuset.cpus not exclusive",
+	[PERR_NOCPUS]    = "Parent unable to distribute cpu downstream",
+	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
+	[PERR_CPUSEMPTY] = "cpuset.cpus is empty",
+};
+
 struct cpuset {
 	struct cgroup_subsys_state css;
 
@@ -168,6 +192,9 @@ struct cpuset {
 	int use_parent_ecpus;
 	int child_ecpus_count;
 
+	/* Invalid partition error code, not lock protected */
+	enum prs_errcode prs_err;
+
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
 };
@@ -294,6 +321,10 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
 	if (old_prs == cs->partition_root_state)
 		return;
 	cgroup_file_notify(&cs->partition_file);
+
+	/* Reset prs_err if not invalid */
+	if (is_partition_valid(cs))
+		WRITE_ONCE(cs->prs_err, PERR_NONE);
 }
 
 static struct cpuset top_cpuset = {
@@ -1231,7 +1262,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  * @cmd:     Partition root state change command
  * @newmask: Optional new cpumask for partcmd_update
  * @tmp:     Temporary addmask and delmask
- * Return:   0 or -1 (error)
+ * Return:   0 or a partition root state error code
  *
  * For partcmd_enable, the cpuset is being transformed from a non-partition
  * root to a partition root. The cpus_allowed mask of the given cpuset will
@@ -1257,7 +1288,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  *
  * The partcmd_update command is used by update_cpumasks_hier() with newmask
  * NULL and update_cpumask() with newmask set. The callers won't check for
- * error and so partition_root_state will be updated directly.
+ * error and so partition_root_state and prs_error will be updated directly.
  */
 static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 					  struct cpumask *newmask,
@@ -1267,7 +1298,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	int adding;	/* Moving cpus from effective_cpus to subparts_cpus */
 	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
 	int old_prs, new_prs;
-	bool part_error = false;	/* Partition error? */
+	int part_error = PERR_NONE;	/* Partition error? */
 
 	percpu_rwsem_assert_held(&cpuset_rwsem);
 
@@ -1276,10 +1307,13 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	 * The new cpumask, if present, or the current cpus_allowed must
 	 * not be empty.
 	 */
-	if (!is_partition_valid(parent) ||
-	   (newmask && cpumask_empty(newmask)) ||
+	if (!is_partition_valid(parent)) {
+		return is_partition_invalid(parent)
+		       ? PERR_INVPARENT : PERR_NOTPART;
+	}
+	if ((newmask && cpumask_empty(newmask)) ||
 	   (!newmask && cpumask_empty(cs->cpus_allowed)))
-		return -1;
+		return PERR_CPUSEMPTY;
 
 	adding = deleting = false;
 	old_prs = new_prs = cs->partition_root_state;
@@ -1289,7 +1323,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		 * doesn't overlap parent's cpus_allowed.
 		 */
 		if (!cpumask_intersects(cs->cpus_allowed, parent->cpus_allowed))
-			return -1;
+			return PERR_INVCPUS;
 
 		/*
 		 * A parent can be left with no CPU as long as there is no
@@ -1297,7 +1331,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		 */
 		if (!cpumask_intersects(cs->cpus_allowed, parent->effective_cpus) &&
 		    partition_is_populated(parent, cs))
-			return -1;
+			return PERR_NOCPUS;
 
 		cpumask_copy(tmp->addmask, cs->cpus_allowed);
 		adding = true;
@@ -1334,7 +1368,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		    cpumask_subset(parent->effective_cpus, tmp->addmask) &&
 		    !cpumask_intersects(tmp->delmask, cpu_active_mask) &&
 		    partition_is_populated(parent, cs)) {
-			part_error = true;
+			part_error = PERR_NOCPUS;
 			adding = false;
 			deleting = cpumask_and(tmp->delmask, cs->cpus_allowed,
 					       parent->subparts_cpus);
@@ -1366,7 +1400,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		    (adding &&
 		     cpumask_subset(parent->effective_cpus, tmp->addmask) &&
 		     partition_is_populated(parent, cs))) {
-			part_error = true;
+			part_error = PERR_NOCPUS;
 			adding = false;
 		}
 
@@ -1375,6 +1409,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 			deleting = cpumask_and(tmp->delmask, cs->cpus_allowed,
 					       parent->subparts_cpus);
 	}
+	if (part_error)
+		WRITE_ONCE(cs->prs_err, part_error);
 
 	if (cmd == partcmd_update) {
 		/*
@@ -1405,7 +1441,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	if ((old_prs != new_prs) && is_prs_invalid(old_prs)) {
 		if (!is_cpu_exclusive(cs) &&
 		    (update_flag(CS_CPU_EXCLUSIVE, cs, 1) < 0))
-			return -1;
+			return PERR_NOTEXCL;
 	}
 
 	/*
@@ -1538,6 +1574,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				 */
 				if (is_partition_valid(cp))
 					new_prs = -cp->partition_root_state;
+				WRITE_ONCE(cp->prs_err,
+					   is_partition_invalid(parent)
+					   ? PERR_INVPARENT : PERR_NOTPART);
 				break;
 			}
 		}
@@ -2112,13 +2151,13 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  * update_prstate - update partition_root_state
  * @cs: the cpuset to update
  * @new_prs: new partition root state
- * Return: 0 if successful, < 0 if error
+ * Return: 0 if successful, != 0 if error
  *
  * Call with cpuset_rwsem held.
  */
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
-	int err = 0, old_prs = cs->partition_root_state;
+	int err = PERR_NONE, old_prs = cs->partition_root_state;
 	bool sched_domain_rebuilt = false;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
@@ -2145,13 +2184,15 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * cannot be empty.
 		 */
 		if (cpumask_empty(cs->cpus_allowed)) {
-			err = 1;
+			err = PERR_CPUSEMPTY;
 			goto out;
 		}
 
 		err = update_flag(CS_CPU_EXCLUSIVE, cs, 1);
-		if (err)
+		if (err) {
+			err = PERR_NOTEXCL;
 			goto out;
+		}
 
 		err = update_parent_subparts_cpumask(cs, partcmd_enable,
 						     NULL, &tmpmask);
@@ -2723,6 +2764,7 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 static int sched_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
+	const char *err, *type = NULL;
 
 	switch (cs->partition_root_state) {
 	case PRS_ROOT:
@@ -2735,9 +2777,17 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 		seq_puts(seq, "member\n");
 		break;
 	case PRS_INVALID_ROOT:
-		seq_puts(seq, "root invalid\n");
-		break;
+		type = "root";
+		fallthrough;
 	case PRS_INVALID_ISOLATED:
+		if (!type)
+			type = "isolated";
+		err = perr_strings[READ_ONCE(cs->prs_err)];
+		if (err)
+			seq_printf(seq, "%s invalid (%s)\n", type, err);
+		else
+			seq_printf(seq, "%s invalid\n", type);
+		break;
 		seq_puts(seq, "isolated invalid\n");
 		break;
 	}
@@ -3328,7 +3378,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 */
 	if (is_partition_valid(cs) && (!parent->nr_subparts_cpus ||
 	   (cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)))) {
-		int old_prs;
+		int old_prs, parent_prs;
 
 		update_parent_subparts_cpumask(cs, partcmd_disable, NULL, tmp);
 		if (cs->nr_subparts_cpus) {
@@ -3340,10 +3390,17 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		}
 
 		old_prs = cs->partition_root_state;
+		parent_prs = parent->partition_root_state;
 		if (is_partition_valid(cs)) {
 			spin_lock_irq(&callback_lock);
 			set_partition_invalid(cs);
 			spin_unlock_irq(&callback_lock);
+			if (is_prs_invalid(parent_prs))
+				WRITE_ONCE(cs->prs_err, PERR_INVPARENT);
+			else if (!parent_prs)
+				WRITE_ONCE(cs->prs_err, PERR_NOTPART);
+			else
+				WRITE_ONCE(cs->prs_err, PERR_HOTPLUG);
 			notify_partition_change(cs, old_prs);
 		}
 		cpuset_force_rebuild();
-- 
2.27.0

