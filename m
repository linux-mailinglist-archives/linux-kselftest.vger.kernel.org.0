Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB803EC424
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Aug 2021 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhHNRlo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Aug 2021 13:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233212AbhHNRlo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Aug 2021 13:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628962874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=S/27zO2jNZB6YHStofzFjSmTX0cZBNRgUk+CUXiaBjg=;
        b=N2+B5F9KRfKF8XW5cTNMxrEK8PWEfaKR9exJdAXKr7XgOdkcfmOW6/pPgOdBfzftdHKWGu
        BYy+RDZx5n3UbNvvH5jp6jv4TIfFR240wpGyUgRMPblLderj6PPn/8FmSYY/0gdDzk3w+G
        jeO/fiK3+H/4USLqSOsMsw06IHxr/Ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-fmMW-tygPuCf3WEyvYCEsA-1; Sat, 14 Aug 2021 13:41:13 -0400
X-MC-Unique: fmMW-tygPuCf3WEyvYCEsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D080E8799EB;
        Sat, 14 Aug 2021 17:41:11 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 325A6105C89F;
        Sat, 14 Aug 2021 17:41:02 +0000 (UTC)
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
Subject: [PATCH-cgroup v5 0/6] cgroup/cpuset: Add new cpuset partition type & empty effecitve cpus
Date:   Sat, 14 Aug 2021 13:38:42 -0400
Message-Id: <20210814173848.11540-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
 kernel/cgroup/cpuset.c                        | 347 ++++++---
 tools/testing/selftests/cgroup/Makefile       |   5 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 663 ++++++++++++++++++
 tools/testing/selftests/cgroup/wait_inotify.c |  86 +++
 5 files changed, 1068 insertions(+), 149 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
 create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c

-- 
2.18.1

