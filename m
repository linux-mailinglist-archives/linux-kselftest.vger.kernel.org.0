Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293E36BECB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 16:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjCQPQv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCQPQm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 11:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABBF4D626
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Mar 2023 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679066135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=q7V46Q52rkSh11P7uwpvJlomEOhaWhBzxdnEpXedVNs=;
        b=Obe8WIAeMyZ+uyXIXL5lNqKdAyznM23sampzKQ8IBvKPKqUGbgjEnE+DQlUlM8slU95ZZx
        Xi7ZpzGGVMMwWWe3jsDBpfSuWSVwfwIdnKZgkUDuY6CLWCU0LnH8uUnCv5UC1V71NVioP1
        mWDfQUvzegRxiTwHFk7bxVtFUF/yqd0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-W1yAmKFMMy2wcEDHNLbwnw-1; Fri, 17 Mar 2023 11:15:30 -0400
X-MC-Unique: W1yAmKFMMy2wcEDHNLbwnw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7683C29AA2E3;
        Fri, 17 Mar 2023 15:15:29 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBEE7492B00;
        Fri, 17 Mar 2023 15:15:28 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/4] cgroup/cpuset: Miscellaneous updates
Date:   Fri, 17 Mar 2023 11:15:04 -0400
Message-Id: <20230317151508.1225282-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 v2:
  - Add a new patch 1 that fixes a bug introduced by recent v6.2 commit
    7a2127e66a00 ("cpuset: Call set_cpus_allowed_ptr() with appropriate
    mask for task").
  - Make a small twist and additional comment to patch 2 ("cgroup/cpuset:
    Skip task update if hotplug doesn't affect current cpuset") as
    suggested by Michal.
  - Remove v1 patches 3/4 for now for further discussion.

This patch series includes miscellaneous update to the cpuset and its
testing code.

Patch 1 fixes a bug caused by commit 7a2127e66a00 ("cpuset: Call
set_cpus_allowed_ptr() with appropriate mask for task") in the partition
handling code. This fix was verified by running the test_cpuset_prs.sh
test.

Patch 2 is for a hotplug optimization.

Patch 3 is actually a follow-up of commit 3fb906e7fabb ("cgroup/cpuset:
Don't filter offline CPUs in cpuset_cpus_allowed() for top cpuset tasks").

Patch 4 reduces verbosity when running test_cpuset_prs.sh test script
unless explicitly enabled with the -v option.

Waiman Long (4):
  cgroup/cpuset: Fix partition root's cpuset.cpus update bug
  cgroup/cpuset: Skip task update if hotplug doesn't affect current
    cpuset
  cgroup/cpuset: Include offline CPUs when tasks' cpumasks in top_cpuset
    are updated
  cgroup/cpuset: Minor updates to test_cpuset_prs.sh

 kernel/cgroup/cpuset.c                        | 38 +++++++++++++------
 .../selftests/cgroup/test_cpuset_prs.sh       | 25 ++++++------
 2 files changed, 41 insertions(+), 22 deletions(-)

-- 
2.31.1

