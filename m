Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A3746164
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGCR1s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGCR1q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 13:27:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B0E5D;
        Mon,  3 Jul 2023 10:27:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9DB01FF9B;
        Mon,  3 Jul 2023 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688405263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRKA7HZbx/PNfhSZJXmKgXZ8xGGJ/O1hIuO7ezGpPQQ=;
        b=Hn9DTlo6aF63q8ALuo80CjuvfTC0UlfB+iyNy+47ll7kQmJmt67mmHScMTlKKO+VWhhAEC
        pifkY+Bd1bdQ357+s6sp/Oxj5KUXjyCfyq4x160nlXLRR0vlOnsPM5bD52gAZX3yzbLKGX
        RRDass0gnpAoyS8bS1WjrmFKhTksYio=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91F44138FC;
        Mon,  3 Jul 2023 17:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OBPJIg8Fo2QqHgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 03 Jul 2023 17:27:43 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v3 1/3] cpuset: Allow setscheduler regardless of manipulated task
Date:   Mon,  3 Jul 2023 19:27:39 +0200
Message-ID: <20230703172741.25392-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703172741.25392-1-mkoutny@suse.com>
References: <20230703172741.25392-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When we migrate a task between two cgroups, one of the checks is a
verification whether we can modify task's scheduler settings
(cap_task_setscheduler()).

An implicit migration occurs also when enabling a controller on the
unified hierarchy (think of parent to child migration). The
aforementioned check may be problematic if the caller of the migration
(enabling a controller) has no permissions over migrated tasks.
For instance, a user's cgroup that ends up running a process of a
different user. Although cgroup permissions are configured favorably,
the enablement fails due to the foreign process [1].

Change the behavior by relaxing the permissions check on the unified
hierarchy when no effective change would happen.
This is in accordance with unified hierarchy attachment behavior when
permissions of the source to target cgroups are decisive whereas the
migrated task is opaque (as opposed to more restrictive check in
__cgroup1_procs_write()).

Notice that foreign task's affinity may still be modified if the user
can modify destination cgroup's cpuset attributes
(update_tasks_cpumask() does no permissions check). The permissions
check could thus be skipped on v2 even when affinity changes. Stay
conservative in this patch though.

[1] https://github.com/systemd/systemd/issues/18293#issuecomment-831205649

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58e6f18f01c1..0a9b860844ca 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2487,6 +2487,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
+	bool cpus_updated, mems_updated;
 	int ret;
 
 	/* used later by cpuset_attach() */
@@ -2501,13 +2502,25 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	if (ret)
 		goto out_unlock;
 
+	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
+	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
-		ret = security_task_setscheduler(task);
-		if (ret)
-			goto out_unlock;
+
+		/*
+		 * Skip rights over task check in v2 when nothing changes,
+		 * migration permission derives from hierarchy ownership in
+		 * cgroup_procs_write_permission()).
+		 */
+		if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
+		    (cpus_updated || mems_updated)) {
+			ret = security_task_setscheduler(task);
+			if (ret)
+				goto out_unlock;
+		}
 
 		if (dl_task(task)) {
 			cs->nr_migrate_dl_tasks++;
-- 
2.41.0

