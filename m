Return-Path: <linux-kselftest+bounces-47954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CECDD700
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 08:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F113A3024E7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B72F4A15;
	Thu, 25 Dec 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTadpNo1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3923EA8B
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Dec 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647932; cv=none; b=Rijd+pO/EXHwjIJXW8Q3u/hUpRiEGdJ5C8ku5vC9VL0iD4i3CL0jOMMk0CPjZVZtgr2Lxh7zI3JYXWK10gRWf7bXW5N7YULCfJ0aPvca8waC6mxWds7LpvFdR1PBUBMEpXOruYuzn+jXpeZ8xqpHNZgggBF1f8viAOf0oZPswq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647932; c=relaxed/simple;
	bh=CJaGZjpJs2+vnsnm8O3kOZuG6Na1R+ZtwLcAQalKPs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3PRNaNvt2zXZgp82tPB0vM6oZow/k2nDsQO0/pmarZuLNDGIqhW7NZ1BgEcE3Ozt0FAMFTSpC9L3/aORgZxKmOfsByuRlbW0dUGdrQ/NA+V45aJFs6exv54ajy3cpf2N1varhjgyBI4t+SBJygq98Z5xpAQlz3wsMMQ9zjML38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTadpNo1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766647929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cp5bpt5G7GyNdNrZ0HyPBBNCrzvoPT8Jv2FHYXiJko4=;
	b=XTadpNo1H6grmD3jAwDtUrcj6TdR3Zjg06A4Gn50nXXUw+DcCEu3aN9Es9TlXivvOTKwse
	321NnBJP0MNc6w2UtidS/9B1dFDN5uasv9oO8viYFry+OOPYjKT4eK2B1dgoStrK81PObn
	Aw7YN9iCINwPzqwZJAz8zIZsf/Y/NZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692--PtmfDfNMQmMfs93vMBFQg-1; Thu,
 25 Dec 2025 02:32:08 -0500
X-MC-Unique: -PtmfDfNMQmMfs93vMBFQg-1
X-Mimecast-MFC-AGG-ID: -PtmfDfNMQmMfs93vMBFQg_1766647926
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1E0618002E4;
	Thu, 25 Dec 2025 07:32:05 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08B851956056;
	Thu, 25 Dec 2025 07:32:02 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.20 PATCH 1/4] cgroup/cpuset: Streamline rm_siblings_excl_cpus()
Date: Thu, 25 Dec 2025 02:30:53 -0500
Message-ID: <20251225073056.30789-2-longman@redhat.com>
In-Reply-To: <20251225073056.30789-1-longman@redhat.com>
References: <20251225073056.30789-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If exclusive_cpus is set, effective_xcpus must be a subset of
exclusive_cpus. Currently, rm_siblings_excl_cpus() checks both
exclusive_cpus and effective_xcpus connectively. It is simpler
to check only exclusive_cpus if non-empty or just effective_xcpus
otherwise.

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 221da921b4f9..3d2d28f0fd03 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1355,23 +1355,24 @@ static int rm_siblings_excl_cpus(struct cpuset *parent, struct cpuset *cs,
 	int retval = 0;
 
 	if (cpumask_empty(excpus))
-		return retval;
+		return 0;
 
 	/*
 	 * Exclude exclusive CPUs from siblings
 	 */
 	rcu_read_lock();
 	cpuset_for_each_child(sibling, css, parent) {
+		struct cpumask *sibling_xcpus;
+
 		if (sibling == cs)
 			continue;
 
-		if (cpumask_intersects(excpus, sibling->exclusive_cpus)) {
-			cpumask_andnot(excpus, excpus, sibling->exclusive_cpus);
-			retval++;
-			continue;
-		}
-		if (cpumask_intersects(excpus, sibling->effective_xcpus)) {
-			cpumask_andnot(excpus, excpus, sibling->effective_xcpus);
+		sibling_xcpus = cpumask_empty(sibling->exclusive_cpus)
+			      ? sibling->effective_xcpus
+			      : sibling->exclusive_cpus;
+
+		if (cpumask_intersects(excpus, sibling_xcpus)) {
+			cpumask_andnot(excpus, excpus, sibling_xcpus);
 			retval++;
 		}
 	}
-- 
2.52.0


