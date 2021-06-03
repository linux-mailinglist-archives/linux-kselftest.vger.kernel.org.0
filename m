Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D139ACBA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 23:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFCV0j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 17:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhFCV0j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 17:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622755493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=I7Je95OOknB79OPSw/FKhXFURHd0Sf3BEVJm/9BIKEw=;
        b=bnohuAg2YecIkqbajG00yS8pND2TgomI1VgBjiyuXgGPleGDoYKtt3qTsiROHIkS+j/PQ+
        VPEBLA7z42/kjQcZr/CoZgfYBjzHkBzUFZ8m/SWgB6rH/aCF+ljfgz6An6yB3cuyKwtiSd
        3q8AxpnmtAYhKYrRY124lp1i5IxwpuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-9iMlZqdCMdy7xsPCWHQhVw-1; Thu, 03 Jun 2021 17:24:52 -0400
X-MC-Unique: 9iMlZqdCMdy7xsPCWHQhVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8838419253C3;
        Thu,  3 Jun 2021 21:24:50 +0000 (UTC)
Received: from llong.com (ovpn-116-222.rdu2.redhat.com [10.10.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D20BB60D06;
        Thu,  3 Jun 2021 21:24:42 +0000 (UTC)
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
Subject: [PATCH 0/5] cgroup/cpuset: Enable cpuset partition with no load balancing
Date:   Thu,  3 Jun 2021 17:24:11 -0400
Message-Id: <20210603212416.25934-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset makes the following two major changes to the cpuset v2 code:

 Patch 2: Add a new partition state "root-nolb" to create a partition
 root with load balancing disabled. This is for handling intermitten
 workloads that have a strict low latency requirement.

 Patch 3: Allow partition roots that are not the top cpuset to distribute
 all its cpus to child partitions as long as there is no task associated
 with that partition root. This allows more flexibility for middleware
 to manage multiple partitions.

Patch 4 updates the cgroup-v2.rst file accordingly. Patch 5 adds a test
to test the new cpuset partition code.

Waiman Long (5):
  cgroup/cpuset: Don't call validate_change() for some flag changes
  cgroup/cpuset: Add new cpus.partition type with no load balancing
  cgroup/cpuset: Allow non-top parent partition root to distribute out
    all CPUs
  cgroup/cpuset: Update description of cpuset.cpus.partition in
    cgroup-v2.rst
  kselftest/cgroup: Add cpuset v2 partition root state test

 Documentation/admin-guide/cgroup-v2.rst       |  19 ++-
 kernel/cgroup/cpuset.c                        | 124 +++++++++++----
 tools/testing/selftests/cgroup/Makefile       |   2 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 141 ++++++++++++++++++
 4 files changed, 247 insertions(+), 39 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh

-- 
2.18.1

