Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD08573EFE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 02:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjF0A4s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0A4r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 20:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00431737
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687827362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rbG/y9GPhxZI54iVshXHiIlQQfxiaFT7O670ezrv8YA=;
        b=O0ZKk+UuuAv7mCtHLa9/K4ZVuo8jYjB18MmPI/F5IbxSxnEurVF76/6xYDx465ZrmxMG/8
        z31+QBEwdfFdISAgI9FFjbNHsIvAfovTzdF93xuLwi0KW3XX4IT7XVHVwpSuJ53AUaQlAz
        C5B6mstFwIsHOxLzMHKaXWSe9Puv5wI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-mRQ30TuNNde7aqdnqDK6mQ-1; Mon, 26 Jun 2023 20:55:59 -0400
X-MC-Unique: mRQ30TuNNde7aqdnqDK6mQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59AAA80006E;
        Tue, 27 Jun 2023 00:55:58 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 138542166B25;
        Tue, 27 Jun 2023 00:55:57 +0000 (UTC)
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
Subject: [PATCH v3 0/9] cgroup/cpuset: Support remote partitions
Date:   Mon, 26 Jun 2023 20:55:20 -0400
Message-Id: <20230627005529.1564984-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 v3:
  - [v2] https://lore.kernel.org/lkml/20230531163405.2200292-1-longman@redhat.com/
  - Change the new control file from root-only "cpuset.cpus.reserve" to
    non-root "cpuset.cpus.exclusive" which lists the set of exclusive
    CPUs distributed down the hierarchy.
  - Add a patch to restrict boot-time isolated CPUs to isolated
    partitions only.
  - Update the test_cpuset_prs.sh test script and documentation
    accordingly.

 v2:
  - [v1] https://lore.kernel.org/lkml/20230412153758.3088111-1-longman@redhat.com/
  - Dropped the special "isolcpus" partition in v1
  - Add the root only "cpuset.cpus.reserve" control file for reserving
    CPUs used for remote isolated partitions.
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
 kernel/cgroup/cpuset.c                        | 1352 ++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       |  398 +++--
 3 files changed, 1297 insertions(+), 553 deletions(-)

-- 
2.31.1

