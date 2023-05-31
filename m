Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65670718781
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 18:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjEaQfj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjEaQfh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 12:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5459DE45
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685550855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W5Ntvs4Cwyl2QgvwcOBrVxRXkGHt94aU7j3HrNtgJ4Y=;
        b=UehugPJUjC1l0PrJwrRm76U4Q3smSOgdhu6701Ldfzy+Rq3Oetuv0Kg+oYmo8mH6mnf8Re
        nCE+of8a0rx+wjZVWDQVlHWjVjFwxpxewGT+e1nNQCi6zwtaSG+fwJIEALhnfNUdGAg8QL
        MrUC6lB6m/Gxv14hriNHYV0NVVvTwi0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-pO9mQNz7PaS5ecqsEMv-Zw-1; Wed, 31 May 2023 12:34:12 -0400
X-MC-Unique: pO9mQNz7PaS5ecqsEMv-Zw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95BAA1C05AA2;
        Wed, 31 May 2023 16:34:11 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FCED2166B25;
        Wed, 31 May 2023 16:34:10 +0000 (UTC)
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
Subject: [PATCH v2 0/6] cgroup/cpuset: Support remote isolated partitions
Date:   Wed, 31 May 2023 12:33:59 -0400
Message-Id: <20230531163405.2200292-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 v2:
  - [v1] https://lore.kernel.org/lkml/20230412153758.3088111-1-longman@redhat.com/
  - Dropped the special "isolcpus" partition in v1
  - Add the root only "cpuset.cpus.reserve" control file for reserving
    CPUs used for remote isolated partitions.
  - Update the test_cpuset_prs.sh test script and documentation
    accordingly.

This patch series introduces a new category of cpuset partition called
remote partitions. The existing partition category where the partition
roots have to be clustered around the root cgroup in a hierarchical way
is now referred to as adjacent partitions.

A remote partition can be formed far from the root cgroup with no
partition root parent. The only commonality is that the CPUs that are
used in the partition as specified in "cpuset.cpus" have to be present
in the "cpuset.cpus" of all its ancestors.

It is relatively rare to have applications that require creation of
a separate scheduling domain (root). However, it is more common to
have applications that require the use of isolated CPUs (isolated),
e.g. DPDK. One can use the "isolcpus" or "nohz_full" boot command options
to get that statically. Of course, the "isolated" partition is another
way to achieve that dynamically.

Modern container orchestration tools like Kubernetes use the cgroup
hierarchy to manage different containers. And it is relying on other
middleware like systemd to help managing it. If a container needs to
use isolated CPUs, it is hard to get those with the adjacent partitions
as it will require the administrative parent cgroup to be a partition
root too which tool like systemd may not be ready to manage.

With this patch series, a new root cgroup only "cpuset.cpus.reserve"
file is added to specify the set of CPUs that can be used in partitions
(whether remote or adjacent). To create a remote partition, the set
of CPUs to be used in that partition (the "cpuset.cpus" file of the
partition root) has to be reserved by manually adding them to that
control file first. Then that partition can be activated by writing
"isolated" into its "cpuset.cpus.partition". CPU reservation of adjacent
partitions is done automatically without touching "cpuset.cpus.reserve"
at all.

Currently only remote isolated partitions are supported, we could
support a scheduling partition ("root") in the future if the need arises.
Additional isolation attributes like those with the "isolcpus" or "nohz"
boot command line options may be supported in the isolated partitions
in the future.

Waiman Long (6):
  cgroup/cpuset: Extract out CS_CPU_EXCLUSIVE & CS_SCHED_LOAD_BALANCE
    handling
  cgroup/cpuset: Improve temporary cpumasks handling
  cgroup/cpuset: Add cpuset.cpus.reserve for top cpuset
  cgroup/cpuset: Introduce remote isolated partition
  cgroup/cpuset: Documentation update for partition
  cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition

 Documentation/admin-guide/cgroup-v2.rst       |  92 ++-
 kernel/cgroup/cpuset.c                        | 749 +++++++++++++++---
 .../selftests/cgroup/test_cpuset_prs.sh       | 403 ++++++----
 3 files changed, 988 insertions(+), 256 deletions(-)

-- 
2.31.1

