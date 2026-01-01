Return-Path: <linux-kselftest+bounces-48053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF3CED4DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 20:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0864301D650
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893252F49F6;
	Thu,  1 Jan 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emoKP5ja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A92F361B
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Jan 2026 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767294980; cv=none; b=VRxMY99aJBLmY294ma2VtNLMGN0bb05cJV7cgso03dUTyb3mbnpEXhRAXKuN3ASSbgpkcwk9lOI3uDMsHWmOZvOrvx9v3bnEoQuZad8pO7CEvs8I2caIY6j3EvCfI52Mm7DB0QaPyAY0wXVBRDGWufp7+2C5EH11YwnVwnsACqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767294980; c=relaxed/simple;
	bh=etlfhTemoygMQW3PHZe0HVBAQTnSuw8QQ3VegLsbQ4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE+guQnME/Nwk4eSLDx3lRu4AISU6Pt301QtW9/CDg4gDBTi1FnmWpUfO0/KWVeWUoe0friqMmNV6ieiTXRlMzAB0bXzSF+kp9FovYS9L8ksGDhgJcY0qBJvl3bzXhhMB+MeuawA8Bms0ElrcSL27cqZarS4Y5pVekbQ4XWOzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emoKP5ja; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767294976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zrwy5CP+T+6ulQfCzu10r1dq1k5+JaVARRWBoOGzC1Y=;
	b=emoKP5jauY9Srfkz28Flz2v+fl5jBJj4ZJJZgE2LDB0esJ2gq1JL9VXDVAfWDSYySSbAON
	0CLKLRY5BJDga5cC4N+77rwdQ2m4PEsJd8BDuOydW8TdYTG+V/UUBbr5Y/yTSLFP/H69+y
	hV2IDArh2yrIkKs4tj8Xfy5HeAbs5aU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-0E6WrBNvOsi-9cHN0063Eg-1; Thu,
 01 Jan 2026 14:16:12 -0500
X-MC-Unique: 0E6WrBNvOsi-9cHN0063Eg-1
X-Mimecast-MFC-AGG-ID: 0E6WrBNvOsi-9cHN0063Eg_1767294971
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B08AE195608A;
	Thu,  1 Jan 2026 19:16:10 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.71])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8ECB119560B4;
	Thu,  1 Jan 2026 19:16:08 +0000 (UTC)
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
Subject: [cgroup/for-6.20 PATCH v2 1/4] cgroup/cpuset: Streamline rm_siblings_excl_cpus()
Date: Thu,  1 Jan 2026 14:15:55 -0500
Message-ID: <20260101191558.434446-2-longman@redhat.com>
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

If exclusive_cpus is set, effective_xcpus must be a subset of
exclusive_cpus. Currently, rm_siblings_excl_cpus() checks both
exclusive_cpus and effective_xcpus consecutively. It is simpler
to check only exclusive_cpus if non-empty or just effective_xcpus
otherwise.

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 221da921b4f9..da2b3b51630e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1355,23 +1355,29 @@ static int rm_siblings_excl_cpus(struct cpuset *parent, struct cpuset *cs,
 	int retval = 0;
 
 	if (cpumask_empty(excpus))
-		return retval;
+		return 0;
 
 	/*
-	 * Exclude exclusive CPUs from siblings
+	 * Remove exclusive CPUs from siblings
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
+		/*
+		 * If exclusive_cpus is defined, effective_xcpus will always
+		 * be a subset. Otherwise, effective_xcpus will only be set
+		 * in a valid partition root.
+		 */
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


