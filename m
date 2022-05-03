Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11FC518997
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiECQ0S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbiECQ0R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 12:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ACCA3982C
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651594964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+g2uJIOUxcZwM6c5aOyAIEGRNprcj0Uo89xpRn5Hq6Y=;
        b=R7mMBwkroNm6vyxmMkTOY7tZVhZVewn9dSO5a7prujUYoA4BZYrYExsXf14YR4iSacV06t
        P8YuHkWT66jhNbijry+8eDDrOqjkRGseWAKe2pF6+VNOR6T3cJxQEb2xghtPHYKiXgZLiM
        R+qaOUc+WhgnCk/1/KtsN4fCZ7hwUEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-OAKLH312M7mYzR7U9EhSwQ-1; Tue, 03 May 2022 12:22:38 -0400
X-MC-Unique: OAKLH312M7mYzR7U9EhSwQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EC7B1014A64;
        Tue,  3 May 2022 16:22:37 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33882403373;
        Tue,  3 May 2022 16:22:36 +0000 (UTC)
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
Subject: [PATCH v10 0/8] cgroup/cpuset: Major cpu partition code restructuring
Date:   Tue,  3 May 2022 12:21:41 -0400
Message-Id: <20220503162149.1764245-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v10:
 - Relax constraints for changes made to "cpuset.cpus"
   and "cpuset.cpus.partition" as suggested. Now almost all changes
   are allowed.

v9:
 - Add a new patch 1 to remove the child cpuset restriction on parent's
   "cpuset.cpus".
 - Relax initial root partition entry limitation to allow cpuset.cpus to
   overlap that of parent's.
 - An "isolated invalid" displayed type is added to
   cpuset.cpus.partition.
 - Resetting partition root to "member" will leave child partition root
   as invalid.
 - Update documentation and test accordingly.

v8:
 - Reorganize the patch series and rationalize the features and
   constraints of a partition.
 - Update patch descriptions and documentation accordingly.

This patchset include the following enhancements to the cpuset v2
partition code.
 1) Allow partitions that have no task to have empty effective cpus.
 2) Relax the constraints on what changes are allowed in cpuset.cpus
    and cpuset.cpus.partition. However, the partition remain invalid
    until the constraints of a valid partition root is satisfied.
 3) Add a new "isolated" partition type for partitions with no load
    balancing which is available in v1 but not yet in v2.
 4) Allow the reading of cpuset.cpus.partition to include a reason
    string as to why the partition remain invalid.

 In addition, the cgroup-v2.rst documentation file is updated and
 a self test is added to verify the correctness the partition code.

Waiman Long (8):
  cgroup/cpuset: Add top_cpuset check in update_tasks_cpumask()
  cgroup/cpuset: Miscellaneous cleanups & add helper functions
  cgroup/cpuset: Allow no-task partition to have empty
    cpuset.cpus.effective
  cgroup/cpuset: Relax constraints to partition & cpus changes
  cgroup/cpuset: Add a new isolated cpus.partition type
  cgroup/cpuset: Show invalid partition reason string
  cgroup/cpuset: Update description of cpuset.cpus.partition in
    cgroup-v2.rst
  kselftest/cgroup: Add cpuset v2 partition root state test

 Documentation/admin-guide/cgroup-v2.rst       | 145 ++--
 kernel/cgroup/cpuset.c                        | 712 +++++++++++-------
 tools/testing/selftests/cgroup/Makefile       |   5 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 674 +++++++++++++++++
 tools/testing/selftests/cgroup/wait_inotify.c |  87 +++
 5 files changed, 1295 insertions(+), 328 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
 create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c

-- 
2.27.0

