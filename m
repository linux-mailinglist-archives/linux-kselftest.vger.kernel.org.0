Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFAC5AA121
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 22:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiIAU6b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiIAU6Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 16:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C39A948
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662065899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mHTwsNDN8zfszdHXZRdpSjJLNg46frqqa+bSRa3s8Mc=;
        b=E2aKVvIKu2GYgXDdERkxRTuHFsAmWrLRGbaZi+xkonvhWFtkqSbYFRzUQxM1Hw3esLPhWW
        vkdKPJ2F2Tcsm5zBwBwFJnooX9SOHgGelvlRT/mEAiEuLH0xH8g+QBtIDewGlgeXZL/OL6
        X0nGzdv4xE4laQhia905P5dXwT34d2U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219--MY6BnuoN7KGdbCG9cwjjw-1; Thu, 01 Sep 2022 16:58:16 -0400
X-MC-Unique: -MY6BnuoN7KGdbCG9cwjjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7D42803916;
        Thu,  1 Sep 2022 20:58:15 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A49381410DD5;
        Thu,  1 Sep 2022 20:58:14 +0000 (UTC)
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
Subject: [PATCH v12 00/10] cgroup/cpuset: cpu partition code fixes & enhancements
Date:   Thu,  1 Sep 2022 16:57:35 -0400
Message-Id: <20220901205745.323326-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v12:
 - Change patch 1 to enable update_tasks_cpumask() for top_cpuset except
   for percpu kthreads.
 - Add 2 more patches to make exclusivity rule violations invalidate the
   partition and its siblings instead of failing the change to make it
   consistent with other cpuset changes.
 - Update documentation and test script accordingly.

v11:
 - Fix incorrect spacing in patch 7 and include documentation suggestions
   by Michal.
 - Move partition_is_populated() check to the last one in list of
   conditions to be checked.

v10:
 - Relax constraints for changes made to "cpuset.cpus"
   and "cpuset.cpus.partition" as suggested. Now almost all changes
   are allowed.
 - Add patch 1 to signal that we may need to do additional work in
   the future to relax the constraint that tasks' cpumask may need
   some adjustment if child partitions are present.
 - Add patch 2 for miscellaneous cleanups.

The first patch fixes the problem that tasks in the top_cpuset
will not have its cpus_mask properly set to reflect the reduced
set of cpus available in the top_cpuset when a partition is enabled.

This patchset also includes the following enhancements to the cpuset
v2 partition code.

 1) Allow partitions that have no task to have empty effective cpus.
 2) Relax the constraints on what changes are allowed in cpuset.cpus
    and cpuset.cpus.partition. However, the partition remain invalid
    until the constraints of a valid partition root is satisfied.
 3) Add a new "isolated" partition type for partitions with no load
    balancing which is available in v1 but not yet in v2.
 4) Allow the reading of cpuset.cpus.partition to include a reason
    string as to why the partition remain invalid.

In addition, the cgroup-v2.rst documentation file is updated and a self
test is added to verify the correctness the partition code.

Waiman Long (10):
  cgroup/cpuset: Enable update_tasks_cpumask() on top_cpuset
  cgroup/cpuset: Miscellaneous cleanups & add helper functions
  cgroup/cpuset: Allow no-task partition to have empty
    cpuset.cpus.effective
  cgroup/cpuset: Relax constraints to partition & cpus changes
  cgroup/cpuset: Add a new isolated cpus.partition type
  cgroup/cpuset: Show invalid partition reason string
  cgroup/cpuset: Relocate a code block in validate_change()
  cgroup/cpuset: Make partition invalid if cpumask change violates
    exclusivity rule
  cgroup/cpuset: Update description of cpuset.cpus.partition in
    cgroup-v2.rst
  kselftest/cgroup: Add cpuset v2 partition root state test

 Documentation/admin-guide/cgroup-v2.rst       | 150 ++--
 kernel/cgroup/cpuset.c                        | 817 ++++++++++++------
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   5 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 674 +++++++++++++++
 tools/testing/selftests/cgroup/wait_inotify.c |  87 ++
 6 files changed, 1385 insertions(+), 349 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
 create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c

-- 
2.31.1

