Return-Path: <linux-kselftest+bounces-48707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8516ED1086F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 05:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC1EA3031CDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 04:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA630BBA0;
	Mon, 12 Jan 2026 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDIeWKGS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC82D6E5C
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768190986; cv=none; b=YmLM9wzFKYT+pcqZIXKvdDi/8xyHMKiAvkE58Sw8S7T9SBcL62BAN37EzOwF2gnWHpnsK4s6Ypx8wuBaf9R0w43gQxH836alfu4P1gV7/p7E6X1lqg39fe0W9vC3d4sCJPvE+s93wVHIzylYD9iQFgzd+UNHmbrxNloOP9HYNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768190986; c=relaxed/simple;
	bh=xRyq+BA5+SW4wNQkBlH/8Va5iksgMOxLzI6w+BAe/8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVoJk1HwqwKS0RUsHR+ezWY5W7jeS9t2uUCAO1gvEm6i1lo9gyr5zebKxIcbOJHaEPsj2forsJv7Ln992wFDcMQoyThktk4tSkjqB3xyQMDTvJdS7HJIrz4Oqu0NNQhhOU7N/hGkj5rdXn/BxJahqOjJPmt1zsV1TUSSuuxwHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDIeWKGS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768190984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RC7chCVKenRI9+ts06yecRuEBGoGAnvwi3kZOLdxres=;
	b=HDIeWKGSAPNoYLHI5qOzxat6Nl0GiL/UV6wgMhTqYSBjGVpoDSBvPAqhpaikYN5we7s9y2
	9FgMJPm1pF5MNlFC8mmfMZL3DO4bHjhpt6EuoZ/9+Wpmo5iZ1pw70witrduNs5nYfmRfxi
	5ERbeEw6nZ/shrleEKIERLzmqHaIa4c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-kLp6ctWBOEy7b_lCeXXz9g-1; Sun,
 11 Jan 2026 23:09:41 -0500
X-MC-Unique: kLp6ctWBOEy7b_lCeXXz9g-1
X-Mimecast-MFC-AGG-ID: kLp6ctWBOEy7b_lCeXXz9g_1768190979
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13D0D1800365;
	Mon, 12 Jan 2026 04:09:39 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.71])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDCAC1800665;
	Mon, 12 Jan 2026 04:09:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH cgroup/for-6.20 v4 0/5] cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict
Date: Sun, 11 Jan 2026 23:08:51 -0500
Message-ID: <20260112040856.460904-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

 v4:
  - Add tags and fix patch 4 commit log

 v3:
  - Patch 2: Change the condition for calling reset_partition_data() to
    (new_prs <= 0).
  - Patch 4: Update commit log and code comment to clarify the change.
  - Add a new patch 5 to move the empty cpus/mems check to
    cpuset1_validate_change().

 v2:
  - Patch 1: additional comment
  - Patch 2: simplify the conditions for triggering call to
    compute_excpus().
  - Patch 3: update description of cpuset.cpus.exclusive in cgroup-v2.rst
    to reflect the new behavior and change the name of the new
    cpus_excl_conflict() parameter to xcpus_changed.
  - Patch 4: update description of cpuset.cpus.partition in cgroup-v2.rst
    to clarify what exclusive CPUs will be used when a partition is
    created.

This patch series is inspired by the cpuset patch sent by Sun Shaojie [1].
The idea is to avoid invalidating sibling partitions when there is a
cpuset.cpus conflict. However this patch series does it in a slightly
different way to make its behavior more consistent with other cpuset
properties.

The first 3 patches are just some cleanup and minor bug fixes on
issues found during the investigation process. The last one is
the major patch that changes the way cpuset.cpus is being handled
during the partition creation process. Instead of invalidating sibling
partitions when there is a conflict, it will strip out the conflicting
exclusive CPUs and assign the remaining non-conflicting exclusive
CPUs to the new partition unless there is no more CPU left which will
fail the partition creation process. It is similar to the idea that
cpuset.cpus.effective may only contain a subset of CPUs specified in
cpuset.cpus. So cpuset.cpus.exclusive.effective may contain only a
subset of cpuset.cpus when a partition is created without setting
cpuset.cpus.exclusive.

Even setting cpuset.cpus.exclusive instead of cpuset.cpus may not
guarantee all the requested CPUs can be granted if parent doesn't have
access to some of those exclusive CPUs. The difference is that conflicts
from siblings is not possible with cpuset.cpus.exclusive as long as it
can be set successfully without failure.

[1] https://lore.kernel.org/lkml/20251117015708.977585-1-sunshaojie@kylinos.cn/

Waiman Long (5):
  cgroup/cpuset: Streamline rm_siblings_excl_cpus()
  cgroup/cpuset: Consistently compute effective_xcpus in
    update_cpumasks_hier()
  cgroup/cpuset: Don't fail cpuset.cpus change in v2
  cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus
    conflict
  cgroup/cpuset: Move the v1 empty cpus/mems check to
    cpuset1_validate_change()

 Documentation/admin-guide/cgroup-v2.rst       |  40 +++--
 kernel/cgroup/cpuset-internal.h               |  12 ++
 kernel/cgroup/cpuset-v1.c                     |  33 ++++
 kernel/cgroup/cpuset.c                        | 163 ++++++------------
 .../selftests/cgroup/test_cpuset_prs.sh       |  29 +++-
 5 files changed, 150 insertions(+), 127 deletions(-)

-- 
2.52.0


