Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD91373EFE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 02:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjF0A47 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 20:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjF0A44 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 20:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5612E
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 17:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687827361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxXXRG19n9JIA9MH1iFO6LWghYV5obKh5ig/aXiH0Xo=;
        b=gnU3Jb9jZO68jDyuQkEI8y/GtBEgD/ubQPjrfrcMkZU+YiPW1tZCUtdphktKGBZGqJZ+k9
        yzKxrpxECgrYa8qNovvGsCxdnnjGU/+qWKkEjLgMnsL1c5GkeR84/QsvmvpoWCDc14WkaK
        O2Mgl14n7KDjG+Redrf4bnpjfuBBNP4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-hAcb0zztPFekXAwJrYR7eQ-1; Mon, 26 Jun 2023 20:55:59 -0400
X-MC-Unique: hAcb0zztPFekXAwJrYR7eQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3857D8C7C21;
        Tue, 27 Jun 2023 00:55:59 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6982C2166B25;
        Tue, 27 Jun 2023 00:55:58 +0000 (UTC)
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
Subject: [PATCH v3 1/9] cgroup/cpuset: Inherit parent's load balance state in v2
Date:   Mon, 26 Jun 2023 20:55:21 -0400
Message-Id: <20230627005529.1564984-2-longman@redhat.com>
In-Reply-To: <20230627005529.1564984-1-longman@redhat.com>
References: <20230627005529.1564984-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since commit f28e22441f35 ("cgroup/cpuset: Add a new isolated
cpus.partition type"), the CS_SCHED_LOAD_BALANCE bit of a v2 cpuset
can be on or off. The child cpusets of a partition root must have the
same setting as its parent or it may screw up the rebuilding of sched
domains. Fix this problem by making sure the a child v2 cpuset will
follows its parent cpuset load balance state unless the child cpuset
is a new partition root itself.

Fixes: f28e22441f35 ("cgroup/cpuset: Add a new isolated cpus.partition type")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58e6f18f01c1..170e342b07e3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1588,11 +1588,16 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		}
 
 		/*
-		 * Skip the whole subtree if the cpumask remains the same
-		 * and has no partition root state and force flag not set.
+		 * Skip the whole subtree if
+		 * 1) the cpumask remains the same,
+		 * 2) has no partition root state,
+		 * 3) force flag not set, and
+		 * 4) for v2 load balance state same as its parent.
 		 */
 		if (!cp->partition_root_state && !force &&
-		    cpumask_equal(tmp->new_cpus, cp->effective_cpus)) {
+		    cpumask_equal(tmp->new_cpus, cp->effective_cpus) &&
+		    (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
+		    (is_sched_load_balance(parent) == is_sched_load_balance(cp)))) {
 			pos_css = css_rightmost_descendant(pos_css);
 			continue;
 		}
@@ -1675,6 +1680,20 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 
 		update_tasks_cpumask(cp, tmp->new_cpus);
 
+		/*
+		 * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
+		 * from parent if current cpuset isn't a valid partition root
+		 * and their load balance states differ.
+		 */
+		if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
+		    !is_partition_valid(cp) &&
+		    (is_sched_load_balance(parent) != is_sched_load_balance(cp))) {
+			if (is_sched_load_balance(parent))
+				set_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
+			else
+				clear_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
+		}
+
 		/*
 		 * On legacy hierarchy, if the effective cpumask of any non-
 		 * empty cpuset is changed, we need to rebuild sched domains.
@@ -3222,6 +3241,14 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cs->use_parent_ecpus = true;
 		parent->child_ecpus_count++;
 	}
+
+	/*
+	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
+	 */
+	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
+	    !is_sched_load_balance(parent))
+		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
+
 	spin_unlock_irq(&callback_lock);
 
 	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
-- 
2.31.1

