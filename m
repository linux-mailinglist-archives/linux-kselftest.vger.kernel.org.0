Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADAD6ACEE1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjCFUKS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjCFUKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:10:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A2D4AFEE
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 12:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678133370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TktQ7QJRxbBjz+L1F60GxDGA9dvv+g9tZaNVQ0g9JWA=;
        b=VqrvHAkQcfJTzGmXrEyX7QYKQeW/VGUYaIPWtD/+3uTkIrXjNwSK8IsVY71C99T/bvQ+bb
        y8g1k7Wo5qZF84TYXwilNf/v0DajUaSBJVdXKIgqGkUNkhlX4b00capGXkJiTy576pvL1w
        5n1SIhYYP6yVOCV3mCjy4H/rK0ztj5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-Bza0R6gzPryCu47XHWAv5Q-1; Mon, 06 Mar 2023 15:09:26 -0500
X-MC-Unique: Bza0R6gzPryCu47XHWAv5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B5E18027FD;
        Mon,  6 Mar 2023 20:09:26 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE4B240C83B6;
        Mon,  6 Mar 2023 20:09:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/5] cgroup/cpuset: Miscellaneous updates
Date:   Mon,  6 Mar 2023 15:08:44 -0500
Message-Id: <20230306200849.376804-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series includes miscellaneous update to the cpuset and its
testing code.

Patch 2 is actually a follow-up of commit 3fb906e7fabb ("cgroup/cpuset:
Don't filter offline CPUs in cpuset_cpus_allowed() for top cpuset tasks").

Patches 3-4 are for handling corner cases when dealing with
task_cpu_possible_mask().

Waiman Long (5):
  cgroup/cpuset: Skip task update if hotplug doesn't affect current
    cpuset
  cgroup/cpuset: Include offline CPUs when tasks' cpumasks in top_cpuset
    are updated
  cgroup/cpuset: Find another usable CPU if none found in current cpuset
  cgroup/cpuset: Add CONFIG_DEBUG_CPUSETS config for cpuset testing
  cgroup/cpuset: Minor updates to test_cpuset_prs.sh

 init/Kconfig                                  |   5 +
 kernel/cgroup/cpuset.c                        | 155 +++++++++++++++++-
 .../selftests/cgroup/test_cpuset_prs.sh       |  25 +--
 3 files changed, 165 insertions(+), 20 deletions(-)

-- 
2.31.1

