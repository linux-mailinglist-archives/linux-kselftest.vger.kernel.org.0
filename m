Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE7E468CB7
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Dec 2021 19:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhLESg2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Dec 2021 13:36:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237230AbhLESg1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Dec 2021 13:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638729179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc8E81HzpSVvhFI2hG1HGDObMZxL5sNxz/ZaqIPKOPM=;
        b=LedlccNKGOYLpoAjg2OBGULzwzxU3RxWtsx7ZCirOvXkx1497vJtD9/9W4sFy6QlVKazZt
        0EDvJtU81xshNb48qtLasbgJw2z3koAselAMimvSnmAuAIZyB/hklalmn6QTD2YlTWMkUH
        1LiNKZD5cBddwgYnA9zemuLyPTlOBAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-1A09MbSrPw6hiTl85NZVKw-1; Sun, 05 Dec 2021 13:32:56 -0500
X-MC-Unique: 1A09MbSrPw6hiTl85NZVKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9EC22F23;
        Sun,  5 Dec 2021 18:32:54 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 923FA13A58;
        Sun,  5 Dec 2021 18:32:52 +0000 (UTC)
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
Subject: [PATCH v9 1/7] cgroup/cpuset: Don't let child cpusets restrict parent in default hierarchy
Date:   Sun,  5 Dec 2021 13:32:14 -0500
Message-Id: <20211205183220.818872-2-longman@redhat.com>
In-Reply-To: <20211205183220.818872-1-longman@redhat.com>
References: <20211205183220.818872-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In validate_change(), there is a check since v2.6.12 to make sure that
each of the child cpusets must be a subset of a parent cpuset.  IOW, it
allows child cpusets to restrict what changes can be made to a parent's
"cpuset.cpus". This actually violates one of the core principles of the
default hierarchy where a cgroup higher up in the hierarchy should be
able to change configuration however it sees fit as deligation breaks
down otherwise.

To address this issue, the check is now removed for the default hierarchy
to free parent cpusets from being restricted by child cpusets. The
check will still apply for legacy hierarchy.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d0e163a02099..0dd7d853ed17 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -616,19 +616,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	struct cpuset *c, *par;
 	int ret;
 
-	rcu_read_lock();
-
-	/* Each of our child cpusets must be a subset of us */
-	ret = -EBUSY;
-	cpuset_for_each_child(c, css, cur)
-		if (!is_cpuset_subset(c, trial))
-			goto out;
-
-	/* Remaining checks don't apply to root cpuset */
-	ret = 0;
+	/* The checks don't apply to root cpuset */
 	if (cur == &top_cpuset)
-		goto out;
+		return 0;
 
+	rcu_read_lock();
 	par = parent_cs(cur);
 
 	/* On legacy hierarchy, we must be a subset of our parent cpuset. */
-- 
2.27.0

