Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FD6DFA63
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjDLPj3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 11:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDLPj2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 11:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462256A45
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681313913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tcf4K424VGDcdSaKtEm81lLzwyCEljjvVM6IbOXUCaM=;
        b=JcTYN721nm6kYH67wjRy2s9sUI0twHXn4GuOmAuka4czYzSCg68qogre/aA76gACIl+uq4
        NkD6HAgJuDcc9+FkTZGPUdMV1D3U0RHbDUmIrexQzlFtE4yxwOj7Zpd0rKJv/+ydA4ogsd
        OybgMyJ+aEwQ9SaUluRh6z5V2ACPhfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-FVXzpNDZO22DpHreHszLow-1; Wed, 12 Apr 2023 11:38:28 -0400
X-MC-Unique: FVXzpNDZO22DpHreHszLow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D30DC185A7A4;
        Wed, 12 Apr 2023 15:38:27 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A7CB40C6E70;
        Wed, 12 Apr 2023 15:38:27 +0000 (UTC)
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
Subject: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Date:   Wed, 12 Apr 2023 11:37:53 -0400
Message-Id: <20230412153758.3088111-1-longman@redhat.com>
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

This patch series introduces a new "isolcpus" partition type to the
existing list of {member, root, isolated} types. The primary reason
of adding this new "isolcpus" partition is to facilitate the
distribution of isolated CPUs down the cgroup v2 hierarchy.

The other non-member partition types have the limitation that their
parents have to be valid partitions too. It will be hard to create a
partition a few layers down the hierarchy.

It is relatively rare to have applications that require creation of
a separate scheduling domain (root). However, it is more common to
have applications that require the use of isolated CPUs (isolated),
e.g. DPDK. One can use the "isolcpus" or "nohz_full" boot command options
to get that statically. Of course, the "isolated" partition is another
way to achieve that dynamically.

Modern container orchestration tools like Kubernetes use the cgroup
hierarchy to manage different containers. If a container needs to use
isolated CPUs, it is hard to get those with existing set of cpuset
partition types. With this patch series, a new "isolcpus" partition
can be created to hold a set of isolated CPUs that can be pull into
other "isolated" partitions.

The "isolcpus" partition is special that there can have at most one
instance of this in a system. It serves as a pool for isolated CPUs
and cannot hold tasks or sub-cpusets underneath it. It is also not
cpu-exclusive so that the isolated CPUs can be distributed down the
sibling hierarchies, though those isolated CPUs will not be useable
until the partition type becomes "isolated".

Once isolated CPUs are needed in a cgroup, the administrator can write
a list of isolated CPUs into its "cpuset.cpus" and change its partition
type to "isolated" to pull in those isolated CPUs from the "isolcpus"
partition and use them in that cgroup. That will make the distribution
of isolated CPUs to cgroups that need them much easier.

In the future, we may be able to extend this special "isolcpus" partition
type to support other isolation attributes like those that can be
specified with the "isolcpus" boot command line and related options.

Waiman Long (5):
  cgroup/cpuset: Extract out CS_CPU_EXCLUSIVE & CS_SCHED_LOAD_BALANCE
    handling
  cgroup/cpuset: Add a new "isolcpus" paritition root state
  cgroup/cpuset: Make isolated partition pull CPUs from isolcpus
    partition
  cgroup/cpuset: Documentation update for the new "isolcpus" partition
  cgroup/cpuset: Extend test_cpuset_prs.sh to test isolcpus partition

 Documentation/admin-guide/cgroup-v2.rst       |  89 ++-
 kernel/cgroup/cpuset.c                        | 548 +++++++++++++++---
 .../selftests/cgroup/test_cpuset_prs.sh       | 376 ++++++++----
 3 files changed, 789 insertions(+), 224 deletions(-)

-- 
2.31.1

