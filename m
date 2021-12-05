Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AB6468CC7
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Dec 2021 19:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhLESgm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Dec 2021 13:36:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237391AbhLESgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Dec 2021 13:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638729191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coq500cx/JYI44GCdJjdwkpmAx3lRBAWP17kbkvjtAA=;
        b=HIRs+8eTC9QZRgNLOnCJML9sXVl7sPqMNJKXoqsRl8zBSNR4buvi6aPomSyUGDZ7qfdCXB
        t2cP5VnT7hm+IJVArRqUnx3QkYpMnpwVWW04cz2lL951/xJ9N2o1n6+Oe71IKO8MBcRN2J
        LFpdLvgodvyUOFkxTT4FLphTPqszzLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-udBhrHdbPqivyE0BfKvNvQ-1; Sun, 05 Dec 2021 13:33:09 -0500
X-MC-Unique: udBhrHdbPqivyE0BfKvNvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F06E52F27;
        Sun,  5 Dec 2021 18:33:07 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE162694BD;
        Sun,  5 Dec 2021 18:33:05 +0000 (UTC)
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
Subject: [PATCH v9 6/7] cgroup/cpuset: Update description of cpuset.cpus.partition in cgroup-v2.rst
Date:   Sun,  5 Dec 2021 13:32:19 -0500
Message-Id: <20211205183220.818872-7-longman@redhat.com>
In-Reply-To: <20211205183220.818872-1-longman@redhat.com>
References: <20211205183220.818872-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update Documentation/admin-guide/cgroup-v2.rst on the newly introduced
"isolated" cpuset partition type as well as other changes made in other
cpuset patches.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 168 ++++++++++++++----------
 1 file changed, 102 insertions(+), 66 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 2aeb7ae8b393..9612319b353f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2099,74 +2099,110 @@ Cpuset Interface Files
 	It accepts only the following input values when written to.
 
 	  ========	================================
-	  "root"	a partition root
-	  "member"	a non-root member of a partition
+	  "member"	Non-root member of a partition
+	  "root"	Partition root
+	  "isolated"	Partition root without load balancing
 	  ========	================================
 
-	When set to be a partition root, the current cgroup is the
-	root of a new partition or scheduling domain that comprises
-	itself and all its descendants except those that are separate
-	partition roots themselves and their descendants.  The root
-	cgroup is always a partition root.
-
-	There are constraints on where a partition root can be set.
-	It can only be set in a cgroup if all the following conditions
-	are true.
-
-	1) The "cpuset.cpus" is not empty and the list of CPUs are
-	   exclusive, i.e. they are not shared by any of its siblings.
-	2) The parent cgroup is a partition root.
-	3) The "cpuset.cpus" is also a proper subset of the parent's
-	   "cpuset.cpus.effective".
-	4) There is no child cgroups with cpuset enabled.  This is for
-	   eliminating corner cases that have to be handled if such a
-	   condition is allowed.
-
-	Setting it to partition root will take the CPUs away from the
-	effective CPUs of the parent cgroup.  Once it is set, this
-	file cannot be reverted back to "member" if there are any child
-	cgroups with cpuset enabled.
-
-	A parent partition cannot distribute all its CPUs to its
-	child partitions.  There must be at least one cpu left in the
-	parent partition.
-
-	Once becoming a partition root, changes to "cpuset.cpus" is
-	generally allowed as long as the first condition above is true,
-	the change will not take away all the CPUs from the parent
-	partition and the new "cpuset.cpus" value is a superset of its
-	children's "cpuset.cpus" values.
-
-	Sometimes, external factors like changes to ancestors'
-	"cpuset.cpus" or cpu hotplug can cause the state of the partition
-	root to change.  On read, the "cpuset.sched.partition" file
-	can show the following values.
-
-	  ==============	==============================
-	  "member"		Non-root member of a partition
-	  "root"		Partition root
-	  "root invalid"	Invalid partition root
-	  ==============	==============================
-
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
+	The root cgroup is always a partition root and its state
+	cannot be changed.  All other non-root cgroups start out as
+	"member".
+
+	When set to "root", the current cgroup is the root of a new
+	partition or scheduling domain that comprises itself and
+	all its descendants except those that are separate partition
+	roots themselves and their descendants.
+
+	The value shown in "cpuset.cpus.effective" of a partition root is
+	the CPUs that the parent partition root can dedicate to the new
+	partition root.  They are subtracted from "cpuset.cpus.effective"
+	of the parent and may be different from "cpuset.cpus"
+
+	When set to "isolated", the CPUs in that partition root will
+	be in an isolated state without any load balancing from the
+	scheduler.  Tasks placed in such a partition with multiple
+	CPUs should be carefully distributed and bound to each of the
+	individual CPUs for optimal performance.
+
+	A partition root ("root" or "isolated") can be in one of the
+	two possible states - valid or invalid.  An invalid partition
+	root is in a degraded state where some state information are
+	retained, but behaves more like a "member".
+
+	On read, the "cpuset.cpus.partition" file can show the following
+	values.
+
+	  ======================	==============================
+	  "member"			Non-root member of a partition
+	  "root"			Partition root
+	  "isolated"			Partition root without load balancing
+	  "root invalid (<reason>)"	Invalid partition root
+	  "isolated invalid (<reason>)"	Invalid isolated partition root
+	  ======================	==============================
+
+	In the case of an invalid partition root, a descriptive string on
+	why the partition is invalid is included within parentheses.
+
+	Almost all possible state transitions among "member", valid
+	and invalid partition roots are allowed except from "member"
+	to invalid partition root.
+
+	Before the "member" to partition root transition can happen,
+	the following conditions must be met or the transition will
+	not be allowed.
+
+	1) The "cpuset.cpus" is non-empty and exclusive, i.e. they are
+	   not shared by any of its siblings.
+	2) The parent cgroup is a valid partition root.
+	3) The "cpuset.cpus" must contain at least one of the CPUs from
+	   parent's "cpuset.cpus", i.e. they overlap.
+	4) There is no child cgroups with cpuset enabled.  This avoids
+	   cpu migrations of multiple cgroups simultaneously which can
+	   be problematic.
+
+	Once becoming a partition root, the only rule restricting
+	changes made to "cpuset.cpus" is the exclusivity rule where
+	none of the siblings of a partition root can share CPUs with
+	it.
+
+	External events like hotplug or inappropriate changes to
+	"cpuset.cpus" can cause a valid partition root to become invalid.
+	Besides the exclusivity rule listed above, the other conditions
+	required to maintain the validity of a partition root are
+	as follows:
+
+	1) The parent cgroup is a valid partition root.
+	2) If "cpuset.cpus.effective" is empty, the partition must have
+	   no task associated with it. Otherwise, the partition becomes
+	   invalid and "cpuset.cpus.effective" will fall back to that
+	   of the nearest non-empty ancestor.
+
+	A corollary of a valid partition root is that
+	"cpuset.cpus.effective" is always a subset of "cpuset.cpus".
+	Note that a task cannot be moved to a cgroup with empty
+	"cpuset.cpus.effective".
+
+	A valid non-root parent partition may distribute out all its CPUs
+	to its child partitions when there is no task associated with it.
+
+	An invalid partition root will be reverted back to a valid
+	one if none of the validity constraints of a valid partition
+	root are violated due to hotplug events or proper changes to
+	"cpuset.cpus" files.
+
+	Changing a partition root (valid or invalid) to "member" is
+	always allowed.  If there are child partition roots underneath
+	it, they will become invalid and unrecoverable.  So care must
+	be taken to double check for this condition before disabling
+	a partition root.
+
+	Poll and inotify events are triggered whenever the state of
+	"cpuset.cpus.partition" changes.  That includes changes caused
+	by write to "cpuset.cpus.partition", cpu hotplug or other
+	changes that modify the validity status of the partition.
+	This will allow user space agents to monitor unexpected changes
+	to "cpuset.cpus.partition" without the need to do continuous
+	polling.
 
 
 Device controller
-- 
2.27.0

