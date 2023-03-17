Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF666BECBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 16:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCQPRb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjCQPRS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 11:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE036A1D1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Mar 2023 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679066135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amVdrpHTvDqA9NrS62Whbl25Xahg4lsNNZAsfD0/8D0=;
        b=BUDU3m7DKG88JRA1whDcemj0RFaT+VLMYzrEI37zwHDo/5aqxmFcxYsAIX5DmR+HaA4e7p
        vpcpg5vU00LbjiLLNwWIHVyhxf0+pAPnSod/h5KvZWijC391TIGCvc/pmER4uoOaQqAnIv
        ZHqHv8CAIjHBrWVsMFWBcxau0h4bw9Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-dusQyZqEPyawIzgUhzWxMA-1; Fri, 17 Mar 2023 11:15:31 -0400
X-MC-Unique: dusQyZqEPyawIzgUhzWxMA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 864BC3801EC6;
        Fri, 17 Mar 2023 15:15:30 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12253492B00;
        Fri, 17 Mar 2023 15:15:30 +0000 (UTC)
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
Subject: [PATCH v2 2/4] cgroup/cpuset: Skip task update if hotplug doesn't affect current cpuset
Date:   Fri, 17 Mar 2023 11:15:06 -0400
Message-Id: <20230317151508.1225282-3-longman@redhat.com>
In-Reply-To: <20230317151508.1225282-1-longman@redhat.com>
References: <20230317151508.1225282-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If a hotplug event doesn't affect the current cpuset, there is no point
to call hotplug_update_tasks() or hotplug_update_tasks_legacy(). So
just skip it.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f310915d1257..5b8d763555b0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3516,6 +3516,8 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 update_tasks:
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
 	mems_updated = !nodes_equal(new_mems, cs->effective_mems);
+	if (!cpus_updated && !mems_updated)
+		goto unlock;	/* Hotplug doesn't affect this cpuset */
 
 	if (mems_updated)
 		check_insane_mems_config(&new_mems);
@@ -3527,6 +3529,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
 					    cpus_updated, mems_updated);
 
+unlock:
 	percpu_up_write(&cpuset_rwsem);
 }
 
-- 
2.31.1

