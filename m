Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FB873FDF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjF0Og5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjF0Og4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 10:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001CC30D7
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vmQ47yrk6oi4cwmpXV9NlSGFJ5Yq05aPKaX6AWXHzFg=;
        b=UN21Mqra9VuzAjK4Oq9vSEUtX9R4K61p2qSfpiw0AXVxYXPojVTcyA/6e7y5+f19X82IkB
        xIZWogAsiSO34MeXc32glZvZGEhcpOoEDY8Ia2ksSR6j7/YVVFz7EAmR4jZ/968pHqTyKq
        /rJt9NElVZOF+IdF5W0I2Vu2zd0IPk4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-Ay3jFgDAP7uyNdF6Hx5YQw-1; Tue, 27 Jun 2023 10:35:56 -0400
X-MC-Unique: Ay3jFgDAP7uyNdF6Hx5YQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D62893819AE2;
        Tue, 27 Jun 2023 14:35:37 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12F0E40C2063;
        Tue, 27 Jun 2023 14:35:37 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 7/9] cgroup/cpuset: Check partition conflict with housekeeping setup
Date:   Tue, 27 Jun 2023 10:35:06 -0400
Message-Id: <20230627143508.1576882-8-longman@redhat.com>
In-Reply-To: <20230627143508.1576882-1-longman@redhat.com>
References: <20230627143508.1576882-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A user can pre-configure certain CPUs in an isolated state at boot time
with the "isolcpus" kernel boot command line option. Those CPUs will
not be in the housekeeping_cpumask(HK_TYPE_DOMAIN) and so will not
be in any sched domains. This may conflict with the partition setup
at runtime. Those boot time isolated CPUs should only be used in an
isolated partition.

This patch adds the necessary check and disallows partition setup if the
check fails.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 56aa7b4f213c..3b0805eacb6b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -75,6 +75,7 @@ enum prs_errcode {
 	PERR_NOCPUS,
 	PERR_HOTPLUG,
 	PERR_CPUSEMPTY,
+	PERR_HKEEPING,
 };
 
 static const char * const perr_strings[] = {
@@ -85,6 +86,7 @@ static const char * const perr_strings[] = {
 	[PERR_NOCPUS]    = "Parent unable to distribute cpu downstream",
 	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
 	[PERR_CPUSEMPTY] = "cpuset.cpus is empty",
+	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
 };
 
 struct cpuset {
@@ -1574,6 +1576,26 @@ static int remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 	return 0;
 }
 
+/*
+ * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
+ * @prstate: partition root state to be checked
+ * @new_cpus: cpu mask
+ * Return: true if there is conflict, false otherwise
+ *
+ * CPUs outside of housekeeping_cpumask(HK_TYPE_DOMAIN) can only be used in
+ * an isolated partition.
+ */
+static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
+{
+	const struct cpumask *hk_domain = housekeeping_cpumask(HK_TYPE_DOMAIN);
+	bool all_in_hk = cpumask_subset(new_cpus, hk_domain);
+
+	if (!all_in_hk && (prstate != PRS_ISOLATED))
+		return true;
+
+	return false;
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1674,6 +1696,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (!cpumask_intersects(xcpus, parent->exclusive_cpus))
 			return PERR_INVCPUS;
 
+		if (prstate_housekeeping_conflict(new_prs, xcpus))
+			return PERR_HKEEPING;
+
 		/*
 		 * A parent can be left with no CPU as long as there is no
 		 * task directly associated with the parent partition.
@@ -2249,6 +2274,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		if (cpumask_empty(trialcs->exclusive_cpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_INVCPUS;
+		} else if (prstate_housekeeping_conflict(old_prs, trialcs->exclusive_cpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_HKEEPING;
 		} else if (tasks_nocpu_error(parent, cs, trialcs->exclusive_cpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_NOCPUS;
@@ -2381,6 +2409,9 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		if (cpumask_empty(trialcs->exclusive_cpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_INVCPUS;
+		} else if (prstate_housekeeping_conflict(old_prs, trialcs->exclusive_cpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_HKEEPING;
 		} else if (tasks_nocpu_error(parent, cs, trialcs->exclusive_cpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_NOCPUS;
-- 
2.31.1

