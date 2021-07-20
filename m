Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69503CFC31
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jul 2021 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbhGTNqN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jul 2021 09:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240059AbhGTNjs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jul 2021 09:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626790824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=3Bali8rkEps7iXEarLyy6nashKZ29ZfCD2TM56N0zaI=;
        b=UeqpbPbIEHellL/03s8fftVFyl566k8MIj3razfuOnav/buEEJ55N67ZfeuFh4V9h3UwDh
        L6lHify7thkhG53LzEj8gvxSPzd74bNHMpUbICV3yrRGv3x03bIQFdsMy/zIFdFampdHaA
        9hh8gI0oSd9T+odh8lLh7l5rbb1Mv0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-0sglr9-zOWS3UqbaUwzhmg-1; Tue, 20 Jul 2021 10:20:23 -0400
X-MC-Unique: 0sglr9-zOWS3UqbaUwzhmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BFEB1084F4C;
        Tue, 20 Jul 2021 14:20:21 +0000 (UTC)
Received: from llong.com (ovpn-116-153.rdu2.redhat.com [10.10.116.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 586A8369A;
        Tue, 20 Jul 2021 14:20:19 +0000 (UTC)
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
Subject: [PATCH v3 8/9] cgroup/cpuset: Update description of cpuset.cpus.partition in cgroup-v2.rst
Date:   Tue, 20 Jul 2021 10:18:33 -0400
Message-Id: <20210720141834.10624-9-longman@redhat.com>
In-Reply-To: <20210720141834.10624-1-longman@redhat.com>
References: <20210720141834.10624-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update Documentation/admin-guide/cgroup-v2.rst on the newly introduced
"isolated" cpuset partition type as well as the ability to create
non-top cpuset partition with no cpu allocated to it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 94 +++++++++++++++----------
 1 file changed, 58 insertions(+), 36 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5c7377b5bd3e..2e101a353ab1 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2080,8 +2080,9 @@ Cpuset Interface Files
 	It accepts only the following input values when written to.
 
 	  ========	================================
-	  "root"	a partition root
-	  "member"	a non-root member of a partition
+	  "member"	Non-root member of a partition
+	  "root"	Partition root
+	  "isolated"	Partition root without load balancing
 	  ========	================================
 
 	When set to be a partition root, the current cgroup is the
@@ -2090,9 +2091,14 @@ Cpuset Interface Files
 	partition roots themselves and their descendants.  The root
 	cgroup is always a partition root.
 
-	There are constraints on where a partition root can be set.
-	It can only be set in a cgroup if all the following conditions
-	are true.
+	When set to "isolated", the CPUs in that partition root will
+	be in an isolated state without any load balancing from the
+	scheduler.  Tasks in such a partition must be explicitly bound
+	to each individual CPU.
+
+	There are constraints on where a partition root can be set
+	("root" or "isolated").  It can only be set in a cgroup if all
+	the following conditions are true.
 
 	1) The "cpuset.cpus" is not empty and the list of CPUs are
 	   exclusive, i.e. they are not shared by any of its siblings.
@@ -2103,51 +2109,67 @@ Cpuset Interface Files
 	   eliminating corner cases that have to be handled if such a
 	   condition is allowed.
 
-	Setting it to partition root will take the CPUs away from the
-	effective CPUs of the parent cgroup.  Once it is set, this
+	Setting it to a partition root will take the CPUs away from
+	the effective CPUs of the parent cgroup.  Once it is set, this
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
+
+	Once becoming a partition root, changes to "cpuset.cpus"
+	is generally allowed as long as the first condition above
+	(cpu exclusivity rule) is true.  Other constraints for this
+	operation are as follows.
 
-	Once becoming a partition root, changes to "cpuset.cpus" is
-	generally allowed as long as the first condition above is true,
-	the change will not take away all the CPUs from the parent
-	partition and the new "cpuset.cpus" value is a superset of its
-	children's "cpuset.cpus" values.
+	1) Any newly added CPUs must be a subset of the parent's
+	   "cpuset.cpus.effective".
+	2) Taking away all the CPUs from the parent's "cpuset.cpus.effective"
+	   is only allowed if there is no task associated with the
+	   parent partition.
+	3) Deletion of CPUs that have been distributed to child partition
+	   roots are not allowed.
 
 	Sometimes, external factors like changes to ancestors'
 	"cpuset.cpus" or cpu hotplug can cause the state of the partition
-	root to change.  On read, the "cpuset.sched.partition" file
-	can show the following values.
+	root to change.  On read, the "cpuset.cpus.partition" file can
+	show the following values.
 
 	  ==============	==============================
 	  "member"		Non-root member of a partition
 	  "root"		Partition root
+	  "isolated"		Partition root without load balancing
 	  "root invalid"	Invalid partition root
 	  ==============	==============================
 
-	It is a partition root if the first 2 partition root conditions
-	above are true and at least one CPU from "cpuset.cpus" is
-	granted by the parent cgroup.
-
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
+	even though the restriction of the cpu exclusivity rule will
+	still apply.  The cpu affinity of all the tasks in the cgroup
+	will then be associated with CPUs in the nearest ancestor
+	partition.
+
+	In the special case of a parent partition competing with a child
+	partition for the only CPU left, the parent partition wins and
+	the child partition becomes invalid.
+
+	An invalid partition root can be transitioned back to a real
+	partition root if at least one of the requested CPUs become
+	available again. In this case, the cpu affinity of all the tasks
+	in the formerly invalid partition will be associated to the CPUs
+	of the newly formed partition.	Changing the partition state of
+	an invalid partition root to "member" is always allowed even if
+	child cpusets are present. However changing a partition root back
+	to member will not be allowed if child partitions are present.
+
+	Poll and inotify events are triggered when transition to or
+	from invalid partition root happens.
 
 
 Device controller
-- 
2.18.1

