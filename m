Return-Path: <linux-kselftest+bounces-12064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B9090B3E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C341F27C43
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C48515B995;
	Mon, 17 Jun 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzzwlO2U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466315B986
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635278; cv=none; b=Gjihpg7P2yG67nTTlWF63Pkt4QNqD+7A1S9ZxF2rh6PAADG0FJbxVBx824QFdPFmPK3J0NajlnJByJjr0R7Bnl5zIWkCCLDYWsbIUomIAwSkev804YHxTtjYzTyWvdR5eo6cFNq+/ijjiCxVmKoeMjlw/BCSZMeYGTNr06lxQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635278; c=relaxed/simple;
	bh=BKxZRYhWTUP+ZwtfxFFfpIbGweia8FSOZExsleG1QNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ct6J5TzfrLzqkanEHg4pwEYsVr7lfZ+Z+zyorV3FwoqKeJnCZTZY19LsOeOdpWbLQg3R/JhQ0tjet/TzOh7hDrxZMZWVlsG4M3p8qaU9JNCE9NKNBt885auvXAiLc35PfowBAmr3QXgWkIUfMKN9iy3xEtoJMABOmF2UpyI2dXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzzwlO2U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718635275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoV1XwOZ7Cwl9H/g9F44sqIaQzIwrjfnCXC0mFAkhaw=;
	b=VzzwlO2Uoi+6v4hhEi9pBYFB3xL7CWRmL7gUzfTjzQsW+BlIS0mUrPQE942PDl8u2c4JwU
	e9Xk6doWu4eoei9HC7xxAHU202l1+HokuMJH4SYQPlfQJ8PNXmLdzwmMgXEJYAMcpGPSgV
	FzEhecAiTn3tet9JzbsLs4NKWaGEJks=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-ZziscDCCPMu-8ZwfoSpBBg-1; Mon,
 17 Jun 2024 10:41:12 -0400
X-MC-Unique: ZziscDCCPMu-8ZwfoSpBBg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6891A19560AE;
	Mon, 17 Jun 2024 14:41:10 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46BD11956052;
	Mon, 17 Jun 2024 14:41:07 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xavier <ghostxavier@sina.com>,
	Peter Hunt <pehunt@redhat.com>,
	Petr Malat <oss@malat.biz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v2 1/5] cgroup/cpuset: Fix remote root partition creation problem
Date: Mon, 17 Jun 2024 10:39:41 -0400
Message-Id: <20240617143945.454888-2-longman@redhat.com>
In-Reply-To: <20240617143945.454888-1-longman@redhat.com>
References: <20240617143945.454888-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since commit 181c8e091aae ("cgroup/cpuset: Introduce remote partition"),
a remote partition can be created underneath a non-partition root cpuset
as long as its exclusive_cpus are set to distribute exclusive CPUs down
to its children. The generate_sched_domains() function, however, doesn't
take into account this new behavior and hence will fail to create the
sched domain needed for a remote root (non-isolated) partition.

There are two issues related to remote partition support. First of
all, generate_sched_domains() has a fast path that is activated if
root_load_balance is true and top_cpuset.nr_subparts is non-zero. The
later condition isn't quite correct for remote partitions as nr_subparts
just shows the number of local child partitions underneath it. There
can be no local child partition under top_cpuset even if there are
remote partitions further down the hierarchy. Fix that by checking
for subpartitions_cpus which contains exclusive CPUs allocated to both
local and remote partitions.

Secondly, the valid partition check for subtree skipping in the csa[]
generation loop isn't enough as remote partition does not need to
have a partition root parent. Fix this problem by breaking csa[] array
generation loop of generate_sched_domains() into v1 and v2 specific parts
and checking a cpuset's exclusive_cpus before skipping its subtree in
the v2 case.

Also simplify generate_sched_domains() for cgroup v2 as only
non-isolating partition roots should be included in building the cpuset
array and none of the v1 scheduling attributes other than a different
way to create an isolated partition are supported.

Fixes: 181c8e091aae ("cgroup/cpuset: Introduce remote partition")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 55 ++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f9b97f65e204..fb71d710a603 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -169,7 +169,7 @@ struct cpuset {
 	/* for custom sched domain */
 	int relax_domain_level;
 
-	/* number of valid sub-partitions */
+	/* number of valid local child partitions */
 	int nr_subparts;
 
 	/* partition root state */
@@ -957,13 +957,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	int nslot;		/* next empty doms[] struct cpumask slot */
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
+	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
 
 	doms = NULL;
 	dattr = NULL;
 	csa = NULL;
 
 	/* Special case for the 99% of systems with one, full, sched domain */
-	if (root_load_balance && !top_cpuset.nr_subparts) {
+	if (root_load_balance && cpumask_empty(subpartitions_cpus)) {
 single_root_domain:
 		ndoms = 1;
 		doms = alloc_sched_domains(ndoms);
@@ -992,16 +993,18 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
 		if (cp == &top_cpuset)
 			continue;
+
+		if (cgrpv2)
+			goto v2;
+
 		/*
+		 * v1:
 		 * Continue traversing beyond @cp iff @cp has some CPUs and
 		 * isn't load balancing.  The former is obvious.  The
 		 * latter: All child cpusets contain a subset of the
 		 * parent's cpus, so just skip them, and then we call
 		 * update_domain_attr_tree() to calc relax_domain_level of
 		 * the corresponding sched domain.
-		 *
-		 * If root is load-balancing, we can skip @cp if it
-		 * is a subset of the root's effective_cpus.
 		 */
 		if (!cpumask_empty(cp->cpus_allowed) &&
 		    !(is_sched_load_balance(cp) &&
@@ -1009,16 +1012,28 @@ static int generate_sched_domains(cpumask_var_t **domains,
 					 housekeeping_cpumask(HK_TYPE_DOMAIN))))
 			continue;
 
-		if (root_load_balance &&
-		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
-			continue;
-
 		if (is_sched_load_balance(cp) &&
 		    !cpumask_empty(cp->effective_cpus))
 			csa[csn++] = cp;
 
-		/* skip @cp's subtree if not a partition root */
-		if (!is_partition_valid(cp))
+		/* skip @cp's subtree */
+		pos_css = css_rightmost_descendant(pos_css);
+		continue;
+
+v2:
+		/*
+		 * Only valid partition roots that are not isolated and with
+		 * non-empty effective_cpus will be saved into csn[].
+		 */
+		if ((cp->partition_root_state == PRS_ROOT) &&
+		    !cpumask_empty(cp->effective_cpus))
+			csa[csn++] = cp;
+
+		/*
+		 * Skip @cp's subtree if not a partition root and has no
+		 * exclusive CPUs to be granted to child cpusets.
+		 */
+		if (!is_partition_valid(cp) && cpumask_empty(cp->exclusive_cpus))
 			pos_css = css_rightmost_descendant(pos_css);
 	}
 	rcu_read_unlock();
@@ -1072,6 +1087,20 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	dattr = kmalloc_array(ndoms, sizeof(struct sched_domain_attr),
 			      GFP_KERNEL);
 
+	/*
+	 * Cgroup v2 doesn't support domain attributes, just set all of them
+	 * to SD_ATTR_INIT. Also non-isolating partition root CPUs are a
+	 * subset of HK_TYPE_DOMAIN housekeeping CPUs.
+	 */
+	if (cgrpv2) {
+		for (i = 0; i < ndoms; i++) {
+			cpumask_copy(doms[i], csa[i]->effective_cpus);
+			if (dattr)
+				dattr[i] = SD_ATTR_INIT;
+		}
+		goto done;
+	}
+
 	for (nslot = 0, i = 0; i < csn; i++) {
 		struct cpuset *a = csa[i];
 		struct cpumask *dp;
@@ -1231,7 +1260,7 @@ static void rebuild_sched_domains_locked(void)
 	 * root should be only a subset of the active CPUs.  Since a CPU in any
 	 * partition root could be offlined, all must be checked.
 	 */
-	if (top_cpuset.nr_subparts) {
+	if (!cpumask_empty(subpartitions_cpus)) {
 		rcu_read_lock();
 		cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
 			if (!is_partition_valid(cs)) {
@@ -4575,7 +4604,7 @@ static void cpuset_handle_hotplug(void)
 	 * In the rare case that hotplug removes all the cpus in
 	 * subpartitions_cpus, we assumed that cpus are updated.
 	 */
-	if (!cpus_updated && top_cpuset.nr_subparts)
+	if (!cpus_updated && !cpumask_empty(subpartitions_cpus))
 		cpus_updated = true;
 
 	/* For v1, synchronize cpus_allowed to cpu_active_mask */
-- 
2.39.3


