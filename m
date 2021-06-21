Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4F03AF5A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhFUSwT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 14:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231837AbhFUSwN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 14:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624301398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=swO++E6Xe5gmahVfon/2vkT+NXylz10k5vVf6UUkIHE=;
        b=WSBiPyUKJsDfJ7GbXLYBZ8aA4dC94ERGMhfxUFme7xMBCepD11MNWAWpaqluvcGA4X+3fg
        vL9H47ArfHB3AHnXHQFElTWzQkq4/nAzL1xMr46J97F7BhXKJe7xJnSXko4NNwmzzbgFY9
        GaPvGiOEiMjs3zsdxSbsNFkTIkIZbK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-rg8wNIO_PcWWY9qwCK676w-1; Mon, 21 Jun 2021 14:49:55 -0400
X-MC-Unique: rg8wNIO_PcWWY9qwCK676w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43483800D55;
        Mon, 21 Jun 2021 18:49:53 +0000 (UTC)
Received: from llong.com (ovpn-114-127.rdu2.redhat.com [10.10.114.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE8B75D9CA;
        Mon, 21 Jun 2021 18:49:51 +0000 (UTC)
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
Subject: [PATCH v2 5/6] cgroup/cpuset: Update description of cpuset.cpus.partition in cgroup-v2.rst
Date:   Mon, 21 Jun 2021 14:49:23 -0400
Message-Id: <20210621184924.27493-6-longman@redhat.com>
In-Reply-To: <20210621184924.27493-1-longman@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update Documentation/admin-guide/cgroup-v2.rst on the newly introduced
"isolated" cpuset partition type as well as the ability to create
non-top cpuset partition with no cpu allocated to it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 65 +++++++++++++++++--------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b1e81aa8598a..cf40a7f499c0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2010,8 +2010,9 @@ Cpuset Interface Files
 	It accepts only the following input values when written to.
 
 	  ========	================================
-	  "root"	a partition root
-	  "member"	a non-root member of a partition
+	  "member"	Non-root member of a partition
+	  "root"	Partition root
+	  "isolated"	Partition root without load balancing
 	  ========	================================
 
 	When set to be a partition root, the current cgroup is the
@@ -2020,6 +2021,11 @@ Cpuset Interface Files
 	partition roots themselves and their descendants.  The root
 	cgroup is always a partition root.
 
+	With "isolated", the CPUs in that partition root will be in an
+	isolated state without any load balancing from the scheduler.
+	Tasks in such a partition must be explicitly bind to each
+	individual CPU.
+
 	There are constraints on where a partition root can be set.
 	It can only be set in a cgroup if all the following conditions
 	are true.
@@ -2038,12 +2044,25 @@ Cpuset Interface Files
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
-	generally allowed as long as the first condition above is true,
+	generally allowed as long as the first condition above is true.
+	Other constraints for this operation are as follows.
+
+	1) Any newly added CPUs must be a subset of the parent's
+	   "cpuset.cpus.effective".
+	2) Taking away all the CPUs from the parent's "cpuset.cpus.effective"
+	   is only allowed if there is no task associated with the
+	   parent partition.
+	3) Deletion of CPUs that have been distributed to child partition
+	   roots are not allowed.
+
 	the change will not take away all the CPUs from the parent
 	partition and the new "cpuset.cpus" value is a superset of its
 	children's "cpuset.cpus" values.
@@ -2056,6 +2075,7 @@ Cpuset Interface Files
 	  ==============	==============================
 	  "member"		Non-root member of a partition
 	  "root"		Partition root
+	  "isolated"		Partition root without load balancing
 	  "root invalid"	Invalid partition root
 	  ==============	==============================
 
@@ -2063,21 +2083,24 @@ Cpuset Interface Files
 	above are true and at least one CPU from "cpuset.cpus" is
 	granted by the parent cgroup.
 
-	A partition root can become invalid if none of CPUs requested
-	in "cpuset.cpus" can be granted by the parent cgroup or the
-	parent cgroup is no longer a partition root itself.  In this
-	case, it is not a real partition even though the restriction
-	of the first partition root condition above will still apply.
-	The cpu affinity of all the tasks in the cgroup will then be
-	associated with CPUs in the nearest ancestor partition.
-
-	An invalid partition root can be transitioned back to a
-	real partition root if at least one of the requested CPUs
-	can now be granted by its parent.  In this case, the cpu
-	affinity of all the tasks in the formerly invalid partition
-	will be associated to the CPUs of the newly formed partition.
-	Changing the partition state of an invalid partition root to
-	"member" is always allowed even if child cpusets are present.
+	A partition root becomes invalid if all the CPUs requested in
+	"cpuset.cpus" become unavailable.  This can happen if all the
+	CPUs have been offlined, or the state of an ancestor partition
+	root become invalid.  In this case, it is not a real partition
+	even though the restriction of the first partition root condition
+	above will still apply.  The cpu affinity of all the tasks in
+	the cgroup will then be associated with CPUs in the nearest
+	ancestor partition.  In the special case of a parent partition
+	competing with a child partition for the only CPU left, the
+	parent partition wins and the child partition becomes invalid.
+
+	An invalid partition root can be transitioned back to a real
+	partition root if at least one of the requested CPUs become
+	available again. In this case, the cpu affinity of all the
+	tasks in the formerly invalid partition will be associated to
+	the CPUs of the newly formed partition.  Changing the partition
+	state of an invalid partition root to "member" is always allowed
+	even if child cpusets are present.
 
 
 Device controller
-- 
2.18.1

