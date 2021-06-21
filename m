Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659E83AF587
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFUSwE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 14:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhFUSwE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 14:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624301389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=8+0lAgdKmEikh/Be8Z1O35k9BkrQgmcKMiwbRtHdQCs=;
        b=dVQdNttU3tKfzfWTvtrWrw+oQBINFyk3UXurvyJv3qP7wAJn2VyH2p+i8nhJOk35qvZKe6
        8sAz2Eqm4QHqx3AR4ScMnlyEO/NT8Tegjy7tWvo8K44zaQcH7q9yFx6Z1zI7aQQr35i6s9
        9xN5aVlP6mAQhSM2TQeGIB7VDuU4mKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-zSqeXrXOMZ6GWiIus38YDg-1; Mon, 21 Jun 2021 14:49:47 -0400
X-MC-Unique: zSqeXrXOMZ6GWiIus38YDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E7D653;
        Mon, 21 Jun 2021 18:49:45 +0000 (UTC)
Received: from llong.com (ovpn-114-127.rdu2.redhat.com [10.10.114.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE705D9CA;
        Mon, 21 Jun 2021 18:49:37 +0000 (UTC)
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
Subject: [PATCH v2 0/6] cgroup/cpuset: Add new cpuset partition type & empty effecitve cpus
Date:   Mon, 21 Jun 2021 14:49:18 -0400
Message-Id: <20210621184924.27493-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2:
 - Drop v1 patch 1.
 - Break out some cosmetic changes into a separate patch (patch #1).
 - Add a new patch to clarify the transition to invalid partition root
   is mainly caused by hotplug events.
 - Enhance the partition root state test including CPU online/offline
   behavior and fix issues found by the test.

This patchset makes the following three major changes to the cpuset v2 code:

 Patch 2: Clarify the use of invalid partition root and add new checks
 to make sure that normal cpuset control file operations will not be
 allowed to create invalid partition root. It also fixes some of the
 issues in existing code.

 Patch 3: Add a new partition state "isolated" to create a partition
 root without load balancing. This is for handling intermitten workloads
 that have a strict low latency requirement.

 Patch 4: Allow partition roots that are not the top cpuset to distribute
 all its cpus to child partitions as long as there is no task associated
 with that partition root. This allows more flexibility for middleware
 to manage multiple partitions.

Patch 5 updates the cgroup-v2.rst file accordingly. Patch 5 adds a new
cpuset test to test the new cpuset partition code.


Waiman Long (6):
  cgroup/cpuset: Miscellaneous code cleanup
  cgroup/cpuset: Clarify the use of invalid partition root
  cgroup/cpuset: Add a new isolated cpus.partition type
  cgroup/cpuset: Allow non-top parent partition root to distribute out
    all CPUs
  cgroup/cpuset: Update description of cpuset.cpus.partition in
    cgroup-v2.rst
  kselftest/cgroup: Add cpuset v2 partition root state test

 Documentation/admin-guide/cgroup-v2.rst       |  65 +-
 kernel/cgroup/cpuset.c                        | 285 ++++++---
 tools/testing/selftests/cgroup/Makefile       |   2 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 558 ++++++++++++++++++
 4 files changed, 794 insertions(+), 116 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh

-- 
2.18.1

