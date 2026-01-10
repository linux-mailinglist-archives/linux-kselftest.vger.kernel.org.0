Return-Path: <linux-kselftest+bounces-48650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E682BD0CB6E
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 02:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA06304C90A
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D13E22F388;
	Sat, 10 Jan 2026 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhpFwieA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AED139D0A
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008815; cv=none; b=ospvTxDiF8CLw2JXqjQglmNGBO7f6nlvQHOMJb76P/ztVjwvwRtvok2CAVKf9IGMBX+UG2P82bA/cue7CnyD4nO8G00ETs4HhIynCP/zedPgzU6qf/4p5qjkpoe6KtUMGM+zDm0lx4N/NYsBwQfRYUannu8OWdNeHvE3wQVNqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008815; c=relaxed/simple;
	bh=/Hr5td0q2fKUO8L0UFsfzO/yV0xkttzaHGLMqqbjcaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiNYldo8AMku9F12AtEuIFooKZM7MLVc8/2SeWVpFChnAj6D6orqBFVoBVyPzADH0eq8wxZBqVMVYTytq6D0ndjsKDzAn7zFdKdgHf81msfOFeYhINEydbfQTIqAjLIgbAzaMad21hiLTg0xKZQhiT3stp3EvyZCGOysrihsQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhpFwieA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768008813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2dX1nduvd1Y2+YZKFwl6uVgXF8yg4bmyS1EUMGzFdk=;
	b=KhpFwieAqC2GkSyPA96lRKlpUjFVNxnDuSLqBkhgXtN9Nbg45f2iMr3k8S1jK9iT623K5H
	+emZtqWZ26vWbZFiJRVip5VSixTjCPV8OpzpJkeZ8lrnEtq35XhPU1Bc/7ScdbvaJmJBra
	fzn2BHwiDcmV2MSRaGKKervLt2sdDWE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-_yDBuCRNOY-ysUQXtV9geQ-1; Fri,
 09 Jan 2026 20:33:27 -0500
X-MC-Unique: _yDBuCRNOY-ysUQXtV9geQ-1
X-Mimecast-MFC-AGG-ID: _yDBuCRNOY-ysUQXtV9geQ_1768008806
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CEE91800447;
	Sat, 10 Jan 2026 01:33:25 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BF7518004D8;
	Sat, 10 Jan 2026 01:33:22 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH cgroup/for-6.20 v3 1/5] cgroup/cpuset: Streamline rm_siblings_excl_cpus()
Date: Fri,  9 Jan 2026 20:32:42 -0500
Message-ID: <20260110013246.293889-2-longman@redhat.com>
In-Reply-To: <20260110013246.293889-1-longman@redhat.com>
References: <20260110013246.293889-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If exclusive_cpus is set, effective_xcpus must be a subset of
exclusive_cpus. Currently, rm_siblings_excl_cpus() checks both
exclusive_cpus and effective_xcpus consecutively. It is simpler
to check only exclusive_cpus if non-empty or just effective_xcpus
otherwise.

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong<chenridong@huawei.com>
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


