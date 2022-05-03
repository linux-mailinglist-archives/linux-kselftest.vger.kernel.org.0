Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE9251899B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiECQ0T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbiECQ0S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 12:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 608F539810
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651594964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z2B9ZmQvNBHEoNy1Tn2IwNtSYVYpH1gZkBTg7xLupGA=;
        b=V7AdBX352JNfR5lJ52q/tps6ve6cd4NalObuUWNbl4BdWCc9gVwGgjsZIFeCeU0P4ryP4w
        waEkpE3BM+4Fr1Oc/SS/TvBkSSwEefWe693GPh+uzw8iM8mWmFeGfS6oiRHFzJnoCBFiT8
        g2tqweRo4qTtVqqPjH4uvN9gNyF1E8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-D97_fEeaNyS4WxCOsoxdug-1; Tue, 03 May 2022 12:22:41 -0400
X-MC-Unique: D97_fEeaNyS4WxCOsoxdug-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF01A1014A70;
        Tue,  3 May 2022 16:22:40 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50DC7463E0B;
        Tue,  3 May 2022 16:22:40 +0000 (UTC)
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
Subject: [PATCH v10 7/8] cgroup/cpuset: Update description of cpuset.cpus.partition in cgroup-v2.rst
Date:   Tue,  3 May 2022 12:21:48 -0400
Message-Id: <20220503162149.1764245-8-longman@redhat.com>
In-Reply-To: <20220503162149.1764245-1-longman@redhat.com>
References: <20220503162149.1764245-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update Documentation/admin-guide/cgroup-v2.rst on the newly introduced
"isolated" cpuset partition type as well as other changes made in other
cpuset patches.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 145 +++++++++++++-----------
 1 file changed, 79 insertions(+), 66 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 69d7a6983f78..94e1e3771830 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2110,74 +2110,87 @@ Cpuset Interface Files
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
+	partition or scheduling domain that comprises itself and all
+	its descendants except those that are separate partition roots
+	themselves and their descendants.
+
+	When set to "isolated", the CPUs in that partition root will
+	be in an isolated state without any load balancing from the
+	scheduler.  Tasks placed in such a partition with multiple
+	CPUs should be carefully distributed and bound to each of the
+	individual CPUs for optimal performance.
+
+	The value shown in "cpuset.cpus.effective" of a partition root is
+	the CPUs that the parent partition root can dedicate to the new
+	partition root.  They are subtracted from "cpuset.cpus.effective"
+	of the parent and may be different from "cpuset.cpus"
+
+	A partition root ("root" or "isolated") can be in one of the
+	two possible states - valid or invalid.  An invalid partition
+	root is in a degraded state where some state information may
+	be retained, but behaves more like a "member".
+
+	All possible state transitions among "member", "root" and
+	"isolated" are allowed.
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
+	For a partition root to become valid, the following conditions
+	must be met.
+
+	1) The "cpuset.cpus" is exclusive, i.e. they are not shared by
+	   any of its siblings (exclusivity rule).
+	2) The parent cgroup is a valid partition root.
+	3) The "cpuset.cpus" is not empty and must contain at least
+	   one of the CPUs from parent's "cpuset.cpus", i.e. they overlap.
+        4) The "cpuset.cpus.effective" must be a subset of "cpuset.cpus"
+           and cannot be empty unless there is no task associated with
+           this partition.
+
+	External events like hotplug or changes to "cpuset.cpus" can
+	cause a valid partition root to become invalid and vice versa.
+	Note that a task cannot be moved to a cgroup with empty
+	"cpuset.cpus.effective".
+
+        For a valid partition root or an invalid partition root with
+        the exclusivity rule enabled, changes made to "cpuset.cpus"
+        that violate the exclusivity rule will not be allowed.
+
+	A valid non-root parent partition may distribute out all its CPUs
+	to its child partitions when there is no task associated with it.
+
+        Care must be taken to change a valid partition root to "member"
+        as all its child partitions, if present, will become invalid.
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

