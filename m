Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBE66BECAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 16:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjCQPQi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCQPQf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 11:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0FA6FFCE
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Mar 2023 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679066135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yyPOMwQLISxSVk5Hax7mBc5lUymcLlOh64gwiaoZAvQ=;
        b=RhCycSMZxz/FIotAeZK1ieNaAMnoyfyVzSSJtKsaa6q5PvSJaENzlrqfaEePZC/QtoHRWO
        pYpdcAvsITSNidw5l9waM2rBsjNDTwY0MYMKSPBbO+37sqsExjxnA2rCEu6EE+0Z4GVg16
        Y3REEM6YvtgER94hDol24LHxMtxN9Ow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-dZAI30q9PRKOvWTgzcfh4g-1; Fri, 17 Mar 2023 11:15:30 -0400
X-MC-Unique: dZAI30q9PRKOvWTgzcfh4g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0602810146E3;
        Fri, 17 Mar 2023 15:15:30 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83C49492B00;
        Fri, 17 Mar 2023 15:15:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/4] cgroup/cpuset: Fix partition root's cpuset.cpus update bug
Date:   Fri, 17 Mar 2023 11:15:05 -0400
Message-Id: <20230317151508.1225282-2-longman@redhat.com>
In-Reply-To: <20230317151508.1225282-1-longman@redhat.com>
References: <20230317151508.1225282-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It was found that commit 7a2127e66a00 ("cpuset: Call
set_cpus_allowed_ptr() with appropriate mask for task") introduced a bug
that corrupted "cpuset.cpus" of a partition root when it was updated.

It is because the tmp->new_cpus field of the passed tmp parameter
of update_parent_subparts_cpumask() should not be used at all as
it contains important cpumask data that should not be overwritten.
Fix it by using tmp->addmask instead.

Also update update_cpumask() to make sure that trialcs->cpu_allowed
will not be corrupted until it is no longer needed.

Fixes: 7a2127e66a00 ("cpuset: Call set_cpus_allowed_ptr() with appropriate mask for task")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 636f1c682ac0..f310915d1257 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1513,7 +1513,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	spin_unlock_irq(&callback_lock);
 
 	if (adding || deleting)
-		update_tasks_cpumask(parent, tmp->new_cpus);
+		update_tasks_cpumask(parent, tmp->addmask);
 
 	/*
 	 * Set or clear CS_SCHED_LOAD_BALANCE when partcmd_update, if necessary.
@@ -1770,10 +1770,13 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	/*
 	 * Use the cpumasks in trialcs for tmpmasks when they are pointers
 	 * to allocated cpumasks.
+	 *
+	 * Note that update_parent_subparts_cpumask() uses only addmask &
+	 * delmask, but not new_cpus.
 	 */
 	tmp.addmask  = trialcs->subparts_cpus;
 	tmp.delmask  = trialcs->effective_cpus;
-	tmp.new_cpus = trialcs->cpus_allowed;
+	tmp.new_cpus = NULL;
 #endif
 
 	retval = validate_change(cs, trialcs);
@@ -1838,6 +1841,11 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	}
 	spin_unlock_irq(&callback_lock);
 
+#ifdef CONFIG_CPUMASK_OFFSTACK
+	/* Now trialcs->cpus_allowed is available */
+	tmp.new_cpus = trialcs->cpus_allowed;
+#endif
+
 	/* effective_cpus will be updated here */
 	update_cpumasks_hier(cs, &tmp, false);
 
-- 
2.31.1

