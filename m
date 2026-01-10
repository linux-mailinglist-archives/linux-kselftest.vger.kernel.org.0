Return-Path: <linux-kselftest+bounces-48651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA54D0CB73
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 02:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40B61304D867
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03143234964;
	Sat, 10 Jan 2026 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyCGO1OC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2722689C
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008815; cv=none; b=CWrAlGUiXg8H+DPZqe4kIc16X/Z2xBYL+cL/QjO9CIYCobAPNNLM7nF8NS2oI59cq60LvZXI5G/bnMbok69dYIZ9P3hAPKPZso6z0VOiPm0r1r5Y8Mn1YhaRZH/fvsyKXIZP3iOkMGkPcbAvwF77jfYY65yjhna4inHPbpSgiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008815; c=relaxed/simple;
	bh=GVYDDDVRYJy+DezfithNmy78zZ3MzV4lsozrxk2l4fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuZw3JQD3MRKHjkvGBfC+y5trap/DQh1an+GvIuwM9d15kVPI8Q1bsd1eVbjf5XGAslVTgzuSgdUvbnoPsibSWppOeAOY++6whxhx73JVJcm3Pncvk4j8/gi5s02d36AV/ktLmwPY2gp/SRuiWxR9AEPSsCK/+SnSyScZlN3XCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyCGO1OC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768008813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xohj+aZez+y8mNAfWa34c4zxXzaL2DZOCbddhySIizE=;
	b=MyCGO1OCzbNRuhga6QmaOSUVgFnWr3UPaeJCaGC0tOE702XATe89RHsfayxzzDGwlf8fGS
	m6WJsPF59kr9Dt3wpTUQV2Y7TB3la/SyUdAI0IxXgmP1y0ePHBD1vQPFuJGZ1JPqDsWNE6
	SrdupSuJNGCgkQ4RFsEtucN+NRi7xto=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-OOTVBS8nMPSdOsDrgb39Ug-1; Fri,
 09 Jan 2026 20:33:29 -0500
X-MC-Unique: OOTVBS8nMPSdOsDrgb39Ug-1
X-Mimecast-MFC-AGG-ID: OOTVBS8nMPSdOsDrgb39Ug_1768008807
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DF1618003FD;
	Sat, 10 Jan 2026 01:33:27 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6735B1800980;
	Sat, 10 Jan 2026 01:33:25 +0000 (UTC)
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
Subject: [PATCH cgroup/for-6.20 v3 2/5] cgroup/cpuset: Consistently compute effective_xcpus in update_cpumasks_hier()
Date: Fri,  9 Jan 2026 20:32:43 -0500
Message-ID: <20260110013246.293889-3-longman@redhat.com>
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
index da2b3b51630e..894131f47f78 100644
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
+		if (new_prs <= 0)
 			reset_partition_data(cp);
 		spin_unlock_irq(&callback_lock);
 
-- 
2.52.0


