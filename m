Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F56DFA6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 17:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjDLPjj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjDLPjc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 11:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E7B2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681313915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k6rrgRvWYYfVtAToY1FAF0Jliiym6oOFi31ZayQ1IeY=;
        b=imvtpzDz/sxaqpj0xYKc8G/gpPBzp3+Qey96TaIUNUHIGJvkDXFyZz99EQpcQIdXl+UKlM
        CgG9xDzn61luKE7pfGjL9u9tCn3pYdhDR2C9r/VzkrUEaoUGxjgnzLCf4MlcL2HgA5u00H
        r1GE9SG7oXVvOvRtlbLiQnM5/cfr588=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-FOtmkdM9OOCYuEpr2kcA0Q-1; Wed, 12 Apr 2023 11:38:30 -0400
X-MC-Unique: FOtmkdM9OOCYuEpr2kcA0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 348E0100DED1;
        Wed, 12 Apr 2023 15:38:30 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF5A740C6E20;
        Wed, 12 Apr 2023 15:38:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 4/5] cgroup/cpuset: Documentation update for the new "isolcpus" partition
Date:   Wed, 12 Apr 2023 11:37:57 -0400
Message-Id: <20230412153758.3088111-5-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch updates the cgroup-v2.rst file to include information about
the new "isolcpus" partition type.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 89 +++++++++++++++++++------
 1 file changed, 70 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f67c0829350b..352a02849fa7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2225,7 +2225,8 @@ Cpuset Interface Files
 	  ==========	=====================================
 	  "member"	Non-root member of a partition
 	  "root"	Partition root
-	  "isolated"	Partition root without load balancing
+	  "isolcpus"	Partition root for isolated CPUs pool
+	  "isolated"	Partition root for isolated CPUs
 	  ==========	=====================================
 
 	The root cgroup is always a partition root and its state
@@ -2237,24 +2238,41 @@ Cpuset Interface Files
 	its descendants except those that are separate partition roots
 	themselves and their descendants.
 
+	When set to "isolcpus", the CPUs in that partition root will
+	be in an isolated state without any load balancing from the
+	scheduler.  This partition root is special as there can be at
+	most one instance of it in a system and no task or child cpuset
+	is allowed in this cgroup.  It acts as a pool of isolated CPUs to
+	be pulled into other "isolated" partitions.  The "cpuset.cpus"
+	of an "isolcpus" partition root contains the list of isolated
+	CPUs it holds, where "cpuset.cpus.effective" contains the list
+	of freely available isolated CPUs that are ready to be pull
+	into other "isolated" partition.
+
 	When set to "isolated", the CPUs in that partition root will
 	be in an isolated state without any load balancing from the
 	scheduler.  Tasks placed in such a partition with multiple
 	CPUs should be carefully distributed and bound to each of the
-	individual CPUs for optimal performance.
-
-	The value shown in "cpuset.cpus.effective" of a partition root
-	is the CPUs that the partition root can dedicate to a potential
-	new child partition root. The new child subtracts available
-	CPUs from its parent "cpuset.cpus.effective".
-
-	A partition root ("root" or "isolated") can be in one of the
-	two possible states - valid or invalid.  An invalid partition
-	root is in a degraded state where some state information may
-	be retained, but behaves more like a "member".
-
-	All possible state transitions among "member", "root" and
-	"isolated" are allowed.
+	individual CPUs for optimal performance.  The isolated CPUs can
+	come from either the parent partition root or from an "isolcpus"
+	partition if the parent cannot satisfy its request.
+
+	The value shown in "cpuset.cpus.effective" of a partition root is
+	the CPUs that the partition root can dedicate to a potential new
+	child partition root. The new child partition subtracts available
+	CPUs from its parent "cpuset.cpus.effective". An exception is
+	an "isolated" partition that pulls its isolated CPUs from the
+	"isolcpus" partition root that is not its direct parent.
+
+	A partition root can be in one of the two possible states -
+	valid or invalid.  An invalid partition root is in a degraded
+	state where some state information may be retained, but behaves
+	more like a "member".
+
+	All possible state transitions among "member", "root", "isolcpus"
+	and "isolated" are allowed.  However, the partition root may
+	not be valid if the corresponding prerequisite conditions are
+	not met.
 
 	On read, the "cpuset.cpus.partition" file can show the following
 	values.
@@ -2262,16 +2280,18 @@ Cpuset Interface Files
 	  =============================	=====================================
 	  "member"			Non-root member of a partition
 	  "root"			Partition root
-	  "isolated"			Partition root without load balancing
+	  "isolcpus"			Partition root for isolated CPUs pool
+	  "isolated"			Partition root for isolated CPUs
 	  "root invalid (<reason>)"	Invalid partition root
+	  "isolcpus invalid (<reason>)"	Invalid isolcpus partition root
 	  "isolated invalid (<reason>)"	Invalid isolated partition root
 	  =============================	=====================================
 
 	In the case of an invalid partition root, a descriptive string on
-	why the partition is invalid is included within parentheses.
+	why the partition is invalid may be included within parentheses.
 
-	For a partition root to become valid, the following conditions
-	must be met.
+	For a "root" partition root to become valid, the following
+	conditions must be met.
 
 	1) The "cpuset.cpus" is exclusive with its siblings , i.e. they
 	   are not shared by any of its siblings (exclusivity rule).
@@ -2281,6 +2301,37 @@ Cpuset Interface Files
 	4) The "cpuset.cpus.effective" cannot be empty unless there is
 	   no task associated with this partition.
 
+        A valid "isolcpus" partition root requires the following
+        conditions.
+
+        1) The parent cgroup is a valid partition root.
+        2) The "cpuset.cpus" must be a subset of parent's "cpuset.cpus"
+           including an empty cpu list.
+        3) There can be no more than one valid "isolcpus" partition.
+        4) No task or child cpuset is allowed.
+
+        Note that an "isolcpus" partition is not exclusive and its
+        isolated CPUs can be distributed down sibling cgroups even
+        though they may not appear in their "cpuset.cpus.effective".
+
+        A valid "isolated" partition root can pull isolated CPUs from
+        either its parent partition or from the "isolcpus" partition.
+        It also requires the following conditions to be met.
+
+	1) The "cpuset.cpus" is exclusive with its siblings , i.e. they
+	   are not shared by any of its siblings (exclusivity rule).
+	2) The "cpuset.cpus" is not empty and must be a subset of
+	   parent's "cpuset.cpus".
+	3) The "cpuset.cpus.effective" cannot be empty unless there is
+	   no task associated with this partition.
+
+        If pulling isolated CPUS from "isolcpus" partition,
+        the "cpuset.cpus" must also be a subset of "isolcpus"
+        partition's "cpuset.cpus" and all the requested CPUs must
+        be available for pulling, i.e. in "isolcpus" partition's
+        "cpuset.cpus.effective". In this case, its hierarchical parent
+        does not need to be a valid partition root.
+
 	External events like hotplug or changes to "cpuset.cpus" can
 	cause a valid partition root to become invalid and vice versa.
 	Note that a task cannot be moved to a cgroup with empty
-- 
2.31.1

