Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD9073FE06
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjF0OhY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 10:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjF0OhP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 10:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349E35A4
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vt7eR5Warck2Ap0bmlsSY+DSBbefbEPsBcMz8g8y+lE=;
        b=TePE6k0GtFW9aPQSNkaDciZn+rHKCEffrc1BdNri1yCULOQYwTHL8PCTAXdUsW0xa+r2wG
        BfElZUXEHzt2AZ7W8b+2NQlrxm6nYy5+3K5GcITAq2ldWm5gLBFfjFDpPVT5lNclyZNuNj
        zd9/iU+Zu5/SlDIvMAA/cDhn5SvrmkY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-80VyoFvJNiu59IAEKwFGwA-1; Tue, 27 Jun 2023 10:36:08 -0400
X-MC-Unique: 80VyoFvJNiu59IAEKwFGwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF69E280AA50;
        Tue, 27 Jun 2023 14:35:31 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBED140C2063;
        Tue, 27 Jun 2023 14:35:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/9] cgroup/cpuset: Support remote partitions
Date:   Tue, 27 Jun 2023 10:34:59 -0400
Message-Id: <20230627143508.1576882-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 v4:
  - [v3] https://lore.kernel.org/lkml/20230627005529.1564984-1-longman@redhat.com/
  - Fix compilation problem reported by kernel test robot.

 v3:
  - [v2] https://lore.kernel.org/lkml/20230531163405.2200292-1-longman@redhat.com/
  - Change the new control file from root-only "cpuset.cpus.reserve" to
    non-root "cpuset.cpus.exclusive" which lists the set of exclusive
    CPUs distributed down the hierarchy.
  - Add a patch to restrict boot-time isolated CPUs to isolated
    partitions only.
  - Update the test_cpuset_prs.sh test script and documentation
    accordingly.

This patch series introduces a new cpuset control file
"cpuset.cpus.exclusive" which must be a subset of "cpuset.cpus"
and the parent's "cpuset.cpus.exclusive". This control file lists
the exclusive CPUs to be distributed down the hierarchy. Any one
of the exclusive CPUs can only be distributed to at most one child
cpuset. Unlike "cpuset.cpus", invalid input to "cpuset.cpus.exclusive"
will be rejected with an error. This new control file has no effect on
the behavior of the cpuset until it turns into a partition root. At that
point, its effective CPUs will be set to its exclusive CPUs unless some
of them are offline.

This patch series also introduces a new category of cpuset partition
called remote partitions. The existing partition category where the
partition roots have to be clustered around the root cgroup in a
hierarchical way is now referred to as local partitions.

A remote partition can be formed far from the root cgroup
with no partition root parent. While local partitions can be
created without touching "cpuset.cpus.exclusive" as it can be set
automatically if a cpuset becomes a local partition root. Properly set
"cpuset.cpus.exclusive" values down the hierarchy are required to create
a remote partition.

Both scheduling and isolated partitions can be formed in a remote
partition. A local partition can be created under a remote partition.
A remote partition, however, cannot be formed under a local partition
for now.

Modern container orchestration tools like Kubernetes use the cgroup
hierarchy to manage different containers. And it is relying on other
middleware like systemd to help managing it. If a container needs to
use isolated CPUs, it is hard to get those with the local partitions
as it will require the administrative parent cgroup to be a partition
root too which tool like systemd may not be ready to manage.

With this patch series, we allow the creation of remote partition
far from the root. The container management tool can manage the
"cpuset.cpus.exclusive" file without impacting the other cpuset
files that are managed by other middlewares. Of course, invalid
"cpuset.cpus.exclusive" values will be rejected and changes to
"cpuset.cpus" can affect the value of "cpuset.cpus.exclusive" due to
the requirement that it has to be a subset of the former control file.

Waiman Long (9):
  cgroup/cpuset: Inherit parent's load balance state in v2
  cgroup/cpuset: Extract out CS_CPU_EXCLUSIVE & CS_SCHED_LOAD_BALANCE
    handling
  cgroup/cpuset: Improve temporary cpumasks handling
  cgroup/cpuset: Allow suppression of sched domain rebuild in
    update_cpumasks_hier()
  cgroup/cpuset: Add cpuset.cpus.exclusive for v2
  cgroup/cpuset: Introduce remote partition
  cgroup/cpuset: Check partition conflict with housekeeping setup
  cgroup/cpuset: Documentation update for partition
  cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition

 Documentation/admin-guide/cgroup-v2.rst       |  100 +-
 kernel/cgroup/cpuset.c                        | 1347 ++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       |  398 +++--
 3 files changed, 1291 insertions(+), 554 deletions(-)

-- 
2.31.1

