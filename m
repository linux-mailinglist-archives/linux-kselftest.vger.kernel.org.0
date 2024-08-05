Return-Path: <linux-kselftest+bounces-14782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F95947306
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 03:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE01C20749
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F213FD72;
	Mon,  5 Aug 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+gXyVV3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28513D524
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Aug 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821466; cv=none; b=RY9MonrUjcIoxIfaZWa9ZrfQJN/3YF32DrSFpjLL0u7GbEEufzkX7Kbc3gtVaoTDJqJUmcDvzU1ZzVeCQ7grOpqqkBRFV9Bj6+K8u0V0ESztVlxhVfE3cqT1/xGIXT/g8JAy0qBQJCfKCHgq65R/rZI0fzbXmT36BUGhFU55j3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821466; c=relaxed/simple;
	bh=0OQIq6EmZJ0HmRr8b7d0sV3ZnAl1teu6B5a0IB6BF5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCu0HCsVj/+qhqXksNLi0PfE7dVj1rYmrxETCroWcHrSIDFBe24W8ZBfTIh/SprIFHVE+jz0ORfv/DMsyI/CDATaU6DoECjtdgimsjtzvB1VpTDW8mpdfJvbytJZX9lO2MEzEMuGjvoVgA4GrgeTu+R7h8KvFj2ML10W6U1W2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+gXyVV3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722821464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRUJt2egi+CPulZ04jC4gpWP21ZBU0lpCZ8ow9/DXIQ=;
	b=M+gXyVV3YJe5WzCR2sUhvaJkcxipbKjQeYc+FeWA6OpmtP5LoW/TaVy0/vlZX0/ZhA68LB
	2CrLih3fPhnhhIXzBBvvMs5jeqXnAvUMAKCdK87w7mN3GmDZ6jYFG+3OVyYa1ZJwFrd5Xc
	0ZeAg4liwpYvc+1LO2oyQTcSgHmfJQ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-ZAfL3G4PMcCaNWwzn1ZIhw-1; Sun,
 04 Aug 2024 21:30:54 -0400
X-MC-Unique: ZAfL3G4PMcCaNWwzn1ZIhw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 893611956064;
	Mon,  5 Aug 2024 01:30:52 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43D731955F40;
	Mon,  5 Aug 2024 01:30:50 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 2/5] cgroup/cpuset: Clear effective_xcpus on cpus_allowed clearing only if cpus.exclusive not set
Date: Sun,  4 Aug 2024 21:30:16 -0400
Message-ID: <20240805013019.724300-3-longman@redhat.com>
In-Reply-To: <20240805013019.724300-1-longman@redhat.com>
References: <20240805013019.724300-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for
v2") adds a user writable cpuset.cpus.exclusive file for setting
exclusive CPUs to be used for the creation of partitions. Since then
effective_xcpus depends on both the cpuset.cpus and cpuset.cpus.exclusive
setting. If cpuset.cpus.exclusive is set, effective_xcpus will depend
only on cpuset.cpus.exclusive.  When it is not set, effective_xcpus
will be set according to the cpuset.cpus value when the cpuset becomes
a valid partition root.

When cpuset.cpus is being cleared by the user, effective_xcpus should
only be cleared when cpuset.cpus.exclusive is not set. However, that
is not currently the case.

  # cd /sys/fs/cgroup/
  # mkdir test
  # echo +cpuset > cgroup.subtree_control
  # cd test
  # echo 3 > cpuset.cpus.exclusive
  # cat cpuset.cpus.exclusive.effective
  3
  # echo > cpuset.cpus
  # cat cpuset.cpus.exclusive.effective // was cleared

Fix it by clearing effective_xcpus only if cpuset.cpus.exclusive is
not set.

Fixes: e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
Reported-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f1846a08e245..7287cecb27d1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2508,7 +2508,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 */
 	if (!*buf) {
 		cpumask_clear(trialcs->cpus_allowed);
-		cpumask_clear(trialcs->effective_xcpus);
+		if (cpumask_empty(trialcs->exclusive_cpus))
+			cpumask_clear(trialcs->effective_xcpus);
 	} else {
 		retval = cpulist_parse(buf, trialcs->cpus_allowed);
 		if (retval < 0)
-- 
2.43.5


