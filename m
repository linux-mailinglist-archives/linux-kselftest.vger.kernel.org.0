Return-Path: <linux-kselftest+bounces-48054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB548CED4DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 20:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4A83024130
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B7F2F3C3F;
	Thu,  1 Jan 2026 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuwvAqy4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1752F28FF
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Jan 2026 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767294981; cv=none; b=d97kIdUNgKUlqpPYaoZbYtIYqVYeX0zSYy+UO06P/GbV9GHZiWDctrJ/wKYwX3SDAkO0I4JX0r3lNsD3oPvzcp2mOzNttwkFCTWq5THZA8V+TzSRtFjhoKB9bBDjse+9GGC2gVvomLfVmvWQ0J9jyTt8PzdjrOpwpXTl4EzjVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767294981; c=relaxed/simple;
	bh=WuZ+KIrAFyIyTuvGFhDERQtIknlayk6lIRMSONetz+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENJW4/ioPKaI2W/M7xdC1z4YTWHp1ADZJJYmbtklBdA4VDAVaS3skMDDiTNAm6BTaoxGz8oaLZqk3rxjp761cWtEer88WlRkD1m8nr99kAgaLui8wW3WLlmbD/MNFnzxXSHvhdbfze0+eQwWGRjUQ+KZ2g/+NUo7eXfu5hFPAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuwvAqy4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767294979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WaWf6gAWtlCiDAIVhOyWiXv6mwYvWphsmSUYaJCTeu4=;
	b=QuwvAqy4OmLqCoGwNwRcs0xeRNGShzgHzbADSUX4Yayncp9GJNKkrF8cNQhBBu2XbIcggf
	5me/ILKNc7JQxL/6m6T73ql4UvWfen69oRy8Ro3FxfMHl4GrZXTsZfIV0l7GvlJwjkJkw2
	PpkIKaRHoY6QSFDdCyYVdvAA56GV16U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-CB2ubz43PfGRIOvBivjGrQ-1; Thu,
 01 Jan 2026 14:16:14 -0500
X-MC-Unique: CB2ubz43PfGRIOvBivjGrQ-1
X-Mimecast-MFC-AGG-ID: CB2ubz43PfGRIOvBivjGrQ_1767294973
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1551018001D1;
	Thu,  1 Jan 2026 19:16:13 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.71])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E301B19560A7;
	Thu,  1 Jan 2026 19:16:10 +0000 (UTC)
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
Subject: [cgroup/for-6.20 PATCH v2 2/4] cgroup/cpuset: Consistently compute effective_xcpus in update_cpumasks_hier()
Date: Thu,  1 Jan 2026 14:15:56 -0500
Message-ID: <20260101191558.434446-3-longman@redhat.com>
In-Reply-To: <20260101191558.434446-1-longman@redhat.com>
References: <20260101191558.434446-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Since commit f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check()
& make update_cpumasks_hier() handle remote partition"), the
compute_effective_exclusive_cpumask() helper was extended to
strip exclusive CPUs from siblings when computing effective_xcpus
(cpuset.cpus.exclusive.effective). This helper was later renamed to
compute_excpus() in commit 86bbbd1f33ab ("cpuset: Refactor exclusive
CPU mask computation logic").

This helper is supposed to be used consistently to compute
effective_xcpus. However, there is an exception within the callback
critical section in update_cpumasks_hier() when exclusive_cpus of a
valid partition root is empty. This can cause effective_xcpus value to
differ depending on where exactly it is last computed. Fix this by using
compute_excpus() in this case to give a consistent result.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index da2b3b51630e..37d118a9ad4d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2168,17 +2168,13 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		spin_lock_irq(&callback_lock);
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
-		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
-			compute_excpus(cp, cp->effective_xcpus);
-
 		/*
-		 * Make sure effective_xcpus is properly set for a valid
-		 * partition root.
+		 * Need to compute effective_xcpus if either exclusive_cpus
+		 * is non-empty or it is a valid partition root.
 		 */
-		if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
-			cpumask_and(cp->effective_xcpus,
-				    cp->cpus_allowed, parent->effective_xcpus);
-		else if (new_prs < 0)
+		if ((new_prs > 0) || !cpumask_empty(cp->exclusive_cpus))
+			compute_excpus(cp, cp->effective_xcpus);
+		if (new_prs < 0)
 			reset_partition_data(cp);
 		spin_unlock_irq(&callback_lock);
 
-- 
2.52.0


