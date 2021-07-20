Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850843CFC1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jul 2021 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhGTNp4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jul 2021 09:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239763AbhGTNjE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jul 2021 09:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626790782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bljuvnurXztETt+O1yuNkEF3cA/LhS/2OLhF0eMXd1M=;
        b=VPy3hhIEp5Jke0DIKGky9Z3attCjlOuSXtBzowPFVf9KzZea66WeXHrzFAqMFaYkMhnbTC
        QZ8RXsnoyBb+kuNqW7TbvIMPMwFYfeMFDNYGK4/YX2iMOXehi5FQ0I06FKmf2pK4ao4j9W
        1SYmbWX9IqPdAVWyedJRs2gQZsWcw6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-vaRRnvl6P5iNE4ZjGlVuAw-1; Tue, 20 Jul 2021 10:19:39 -0400
X-MC-Unique: vaRRnvl6P5iNE4ZjGlVuAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A36B710C1ADC;
        Tue, 20 Jul 2021 14:19:36 +0000 (UTC)
Received: from llong.com (ovpn-116-153.rdu2.redhat.com [10.10.116.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A161260583;
        Tue, 20 Jul 2021 14:19:23 +0000 (UTC)
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
Subject: [PATCH v3 0/9] cgroup/cpuset: Add new cpuset partition type & empty effecitve cpus
Date:   Tue, 20 Jul 2021 10:18:25 -0400
Message-Id: <20210720141834.10624-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v3:
 - Add two new patches (patches 2 & 3) to fix bugs found during the
   testing process.
 - Add a new patch to enable inotify event notification when partition
   become invalid.
 - Add a test to test event notification when partition become invalid.

v2:
 - Drop v1 patch 1.
 - Break out some cosmetic changes into a separate patch (patch #1).
 - Add a new patch to clarify the transition to invalid partition root
   is mainly caused by hotplug events.
 - Enhance the partition root state test including CPU online/offline
   behavior and fix issues found by the test.

This patchset fixes two bugs and makes four enhancements to the cpuset
v2 code.

Bug fixes:

 Patch 2: Fix a hotplug handling bug when just all cpus in subparts_cpus
 are offlined.

 Patch 3: Fix violation of cpuset locking rule.

Enhancements: 

 Patch 4: Enable event notification on "cpuset.cpus.partition" when
 a partition become invalid.

 Patch 5: Clarify the use of invalid partition root and add new checks
 to make sure that normal cpuset control file operations will not be
 allowed to create invalid partition root. It also fixes some of the
 issues in existing code.

 Patch 6: Add a new partition state "isolated" to create a partition
 root without load balancing. This is for handling intermitten workloads
 that have a strict low latency requirement.

 Patch 7: Allow partition roots that are not the top cpuset to distribute
 all its cpus to child partitions as long as there is no task associated
 with that partition root. This allows more flexibility for middleware
 to manage multiple partitions.

Patch 8 updates the cgroup-v2.rst file accordingly. Patch 9 adds a new
cpuset test to test the new cpuset partition code.

Waiman Long (9):
  cgroup/cpuset: Miscellaneous code cleanup
  cgroup/cpuset: Fix a partition bug with hotplug
  cgroup/cpuset: Fix violation of cpuset locking rule
  cgroup/cpuset: Enable event notification when partition become invalid
  cgroup/cpuset: Clarify the use of invalid partition root
  cgroup/cpuset: Add a new isolated cpus.partition type
  cgroup/cpuset: Allow non-top parent partition root to distribute out
    all CPUs
  cgroup/cpuset: Update description of cpuset.cpus.partition in
    cgroup-v2.rst
  kselftest/cgroup: Add cpuset v2 partition root state test

 Documentation/admin-guide/cgroup-v2.rst       |  94 ++-
 kernel/cgroup/cpuset.c                        | 360 +++++++---
 tools/testing/selftests/cgroup/Makefile       |   5 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 626 ++++++++++++++++++
 tools/testing/selftests/cgroup/wait_inotify.c |  67 ++
 5 files changed, 1007 insertions(+), 145 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
 create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c

-- 
2.18.1

