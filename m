Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A060439ACC8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFCV0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 17:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhFCV0t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 17:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622755503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=thMjmtJh5+hm9zST5bagiDDjjocf7BWJz4f5zZJsM5c=;
        b=SK7sjfMnj6SR4Aa2/ZUVTNrbJuxzQNoPbMv6PP7hOor9G8vMxyIKcQBBs+XGQ/CSoi98or
        sPwZryTZRjfEWYmvh5EOP9tOl7p3b4mkIHVsVHHyJ2oIaWAi2sMLribYqlkEtTajLctFE/
        eGcgUkJLBcFFFkmFP+W0RY2BKUBbwfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-SmUDUhhCMpKbkpLm1y9EOg-1; Thu, 03 Jun 2021 17:25:00 -0400
X-MC-Unique: SmUDUhhCMpKbkpLm1y9EOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA602107ACC7;
        Thu,  3 Jun 2021 21:24:58 +0000 (UTC)
Received: from llong.com (ovpn-116-222.rdu2.redhat.com [10.10.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69AA460D06;
        Thu,  3 Jun 2021 21:24:57 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH 4/5] cgroup/cpuset: Update description of cpuset.cpus.partition in cgroup-v2.rst
Date:   Thu,  3 Jun 2021 17:24:15 -0400
Message-Id: <20210603212416.25934-5-longman@redhat.com>
In-Reply-To: <20210603212416.25934-1-longman@redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update Documentation/admin-guide/cgroup-v2.rst on the new "root-nolb"
cpuset partition type as well as the ability to create non-top cpuset
partition with no cpu allocated to it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b1e81aa8598a..36a923cabeb0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2010,8 +2010,9 @@ Cpuset Interface Files
 	It accepts only the following input values when written to.
 
 	  ========	================================
-	  "root"	a partition root
-	  "member"	a non-root member of a partition
+	  "member"	Non-root member of a partition
+	  "root"	Partition root
+	  "root-nolb"	Partition root with no load balancing
 	  ========	================================
 
 	When set to be a partition root, the current cgroup is the
@@ -2020,6 +2021,10 @@ Cpuset Interface Files
 	partition roots themselves and their descendants.  The root
 	cgroup is always a partition root.
 
+        With "root-nolb", the CPUs in that partition root will be in an
+        isolated state with no load balancing by the scheduler.  Tasks in
+        such a partition must be explicitly bind to each individual CPU.
+
 	There are constraints on where a partition root can be set.
 	It can only be set in a cgroup if all the following conditions
 	are true.
@@ -2038,9 +2043,12 @@ Cpuset Interface Files
 	file cannot be reverted back to "member" if there are any child
 	cgroups with cpuset enabled.
 
-	A parent partition cannot distribute all its CPUs to its
-	child partitions.  There must be at least one cpu left in the
-	parent partition.
+	A parent partition may distribute all its CPUs to its child
+	partitions as long as it is not the root cgroup and there is no
+	task directly associated with that parent partition.  Otherwise,
+	there must be at least one cpu left in the parent partition.
+	A new task cannot be moved to a partition root with no effective
+	cpu.
 
 	Once becoming a partition root, changes to "cpuset.cpus" is
 	generally allowed as long as the first condition above is true,
@@ -2056,6 +2064,7 @@ Cpuset Interface Files
 	  ==============	==============================
 	  "member"		Non-root member of a partition
 	  "root"		Partition root
+	  "root-nolb"		Partition root with no load balancing
 	  "root invalid"	Invalid partition root
 	  ==============	==============================
 
-- 
2.18.1

