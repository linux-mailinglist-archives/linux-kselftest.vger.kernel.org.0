Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6DF5AA12A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 22:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiIAU6e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiIAU62 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 16:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD3598A43
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662065904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yjsoi9jMIhi4zCKfFUwtWjEtMVRAwWq9W9IHBrQtpuI=;
        b=QZQfM2J6FPuYHgUQAC7kjCf2UScmNF2Y9m0Pfmshu9umEttd7oWjapKPosJpnKAUMzOBqS
        P6rgQUT8G1ouw2jld3kaT1RUtVL+UHzdaSxbXZVnbbiIVMqyt86HB4L0llMWitnQSJHjyf
        VOErfn9a83NjQd5PKyznVWM+rXsgxt0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-5vV1koFcMN61CaO3MmG7UA-1; Thu, 01 Sep 2022 16:58:21 -0400
X-MC-Unique: 5vV1koFcMN61CaO3MmG7UA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 983AD1C08961;
        Thu,  1 Sep 2022 20:58:20 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1DB91415137;
        Thu,  1 Sep 2022 20:58:19 +0000 (UTC)
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
Subject: [PATCH v12 07/10] cgroup/cpuset: Relocate a code block in validate_change()
Date:   Thu,  1 Sep 2022 16:57:42 -0400
Message-Id: <20220901205745.323326-8-longman@redhat.com>
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

This patch moves down the exclusive cpu and memory check in
validate_change(). There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 15fcd2f86108..b0d921d03f62 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -741,22 +741,6 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 
 	par = parent_cs(cur);
 
-	/*
-	 * If either I or some sibling (!= me) is exclusive, we can't
-	 * overlap
-	 */
-	ret = -EINVAL;
-	cpuset_for_each_child(c, css, par) {
-		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
-		    c != cur &&
-		    cpumask_intersects(trial->cpus_allowed, c->cpus_allowed))
-			goto out;
-		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
-		    c != cur &&
-		    nodes_intersects(trial->mems_allowed, c->mems_allowed))
-			goto out;
-	}
-
 	/*
 	 * Cpusets with tasks - existing or newly being attached - can't
 	 * be changed to have empty cpus_allowed or mems_allowed.
@@ -781,6 +765,22 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 				       trial->cpus_allowed))
 		goto out;
 
+	/*
+	 * If either I or some sibling (!= me) is exclusive, we can't
+	 * overlap
+	 */
+	ret = -EINVAL;
+	cpuset_for_each_child(c, css, par) {
+		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
+		    c != cur &&
+		    cpumask_intersects(trial->cpus_allowed, c->cpus_allowed))
+			goto out;
+		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
+		    c != cur &&
+		    nodes_intersects(trial->mems_allowed, c->mems_allowed))
+			goto out;
+	}
+
 	ret = 0;
 out:
 	rcu_read_unlock();
-- 
2.31.1

