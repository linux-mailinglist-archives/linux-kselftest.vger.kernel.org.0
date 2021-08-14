Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1F3EC541
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Aug 2021 22:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhHNU7j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Aug 2021 16:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233750AbhHNU7i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Aug 2021 16:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628974749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=hgsxk/ndi9Bc7L/y8Om3JGSTHXU/MJwZP0HoGDhLIw4=;
        b=YVMyuUKdy0p6hj4RaXMEjm7S3uV+htT6bNtcYUR02i8XusQlOWjRY7gimTZrDKaMG5NIXm
        9D4R3VIJmZs3b2Eipl+5vgQLeDeAjGlU17MSNQBQvPPL0bGxtKbHcNXGO0S2/VZ/cjD09q
        0OhxWDCiBnoiuQUkVJETwDU0+16bBnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-yAMaI02jNKmO7fdnhO46wg-1; Sat, 14 Aug 2021 16:58:04 -0400
X-MC-Unique: yAMaI02jNKmO7fdnhO46wg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A3E8801B3D;
        Sat, 14 Aug 2021 20:58:02 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7407620DE;
        Sat, 14 Aug 2021 20:57:52 +0000 (UTC)
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
Subject: [PATCH-cgroup v6 0/6] cgroup/cpuset: Add new cpuset partition type & empty effecitve cpus
Date:   Sat, 14 Aug 2021 16:57:37 -0400
Message-Id: <20210814205743.3039-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v6:
 - Remove duplicated tmpmask from update_prstate() which should fix the
   frame size too large problem reported by kernel test robot.

v5:
 - Rebased to the latest for-5.15 branch of cgroup git tree and drop the
   1st v4 patch as it has been merged.
 - Update patch 1 to always allow changing partition root back to member
   even if it invalidates child partitions undeneath it.
 - Adjust the empty effective cpu partition patch to not allow 0 effective
   cpu for terminal partition which will make it invalid).
 - Add a new patch to enable reading of cpuset.cpus.partition to display
   the reason that causes invalid partition.
 - Adjust the documentation and testing patch accordingly.

v4:
 - Rebased to the for-5.15 branch of cgroup git tree and dropped the
   first 3 patches of v3 series which have been merged.
 - Beside prohibiting violation of cpu exclusivity rule, allow arbitrary
   changes to cpuset.cpus of a partition root and force the partition root
   to become invalid in case any of the partition root constraints
   are violated. The documentation file and self test are modified
   accordingly.

This patchset makes four enhancements to the cpuset v2 code.

 Patch 1: Properly handle partition root tree and make partition
 invalid in case changes to cpuset.cpus violate any of the partition
 root constraints.

 Patch 2: Enable the "cpuset.cpus.partition" file to show the reason
 that causes invalid partition like "root invalid (No cpu available
 due to hotplug)".

 Patch 3: Add a new partition state "isolated" to create a partition
 root without load balancing. This is for handling intermitten workloads
 that have a strict low latency requirement.

 Patch 4: Allow partition roots that are not the top cpuset to distribute
 all its cpus to child partitions as long as there is no task associated
 with that partition root. This allows more flexibility for middleware
 to manage multiple partitions.

Patch 5 updates the cgroup-v2.rst file accordingly. Patch 6 adds a new
cpuset test to test the new cpuset partition code.

Waiman Long (6):
  cgroup/cpuset: Properly transition to invalid partition
  cgroup/cpuset: Show invalid partition reason string
  cgroup/cpuset: Add a new isolated cpus.partition type
  cgroup/cpuset: Allow non-top parent partition to distribute out all
    CPUs
  cgroup/cpuset: Update description of cpuset.cpus.partition in
    cgroup-v2.rst
  kselftest/cgroup: Add cpuset v2 partition root state test

 Documentation/admin-guide/cgroup-v2.rst       | 116 +--
 kernel/cgroup/cpuset.c                        | 337 ++++++---
 tools/testing/selftests/cgroup/Makefile       |   5 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 663 ++++++++++++++++++
 tools/testing/selftests/cgroup/wait_inotify.c |  86 +++
 5 files changed, 1058 insertions(+), 149 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
 create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c

-- 
2.18.1

