Return-Path: <linux-kselftest+bounces-30091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D4A7B56D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 03:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E6D3B40F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 01:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D78D517;
	Fri,  4 Apr 2025 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjVHg9ZX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9643433A8
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743729909; cv=none; b=mTgtYQYqixrX5IVi9uO+gDolEc6CTSolJfp4aNdP3az9yvDzWWbEdeXR8FPksCVMO3xeCTa5evgtg4PjQD3XwzXmhCgEzCxJSQGJahrW5wir3smfTEq1s7Bstj8OwrSz4fA3aSBaprUu/siCz7BjRWY7SRMyGXI4sf1wCyptN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743729909; c=relaxed/simple;
	bh=LpA9FyU6S3VEfDl9/LNHrnpW1DCPvRJq3D3FwBIgIGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oqp5OftGMJmy9PZbFJK2Oceunyz2Nl21CRrXGXKNf5lLQHkmHWriaB98+CSG4Pmw1lvxhwI6BDZu0fat+LCh3R1Yz8fc+BNJTF4REc2VQrhe8jlwAn2Od8Yu1BLviC5WrdRYZy9OWcOfcNVW0sOmGmdNmt+tLBRmzLTXYLPce0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjVHg9ZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743729906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eeDF4dFIWOS0DFmcqcZYB3wJsohtT8Hr0IIadggs/8c=;
	b=NjVHg9ZXQTMi8LxUoRcgtbJQWMRdeDKZdf1VXuvHiH1WSTS6oD73QpVLLwX2G88hx6FvdY
	ndL/dr6SrulxjH1OdTOFdSYhVDvqrgaJchYV8GkgvdwN7Rj6AudDih2AdIE1csDI53Kggr
	SJFM3HYNteUQeS2tezdJ4V97RoVVXNk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-qnvY40IQO2C4Esh2un-iuA-1; Thu,
 03 Apr 2025 21:25:00 -0400
X-MC-Unique: qnvY40IQO2C4Esh2un-iuA-1
X-Mimecast-MFC-AGG-ID: qnvY40IQO2C4Esh2un-iuA_1743729898
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCD5C1956089;
	Fri,  4 Apr 2025 01:24:57 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B1B3180B489;
	Fri,  4 Apr 2025 01:24:54 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/2] memcg: Don't generate low/min events if either low/min or elow/emin is 0
Date: Thu,  3 Apr 2025 21:24:34 -0400
Message-ID: <20250404012435.656045-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test due to the fact that two of its test child cgroups which
have a memmory.low of 0 or an effective memory.low of 0 still have low
events generated for them since mem_cgroup_below_low() use the ">="
operator when comparing to elow.

The two failed use cases are as follows:

1) memory.low is set to 0, but low events can still be triggered and
   so the cgroup may have a non-zero low event count. I doubt users are
   looking for that as they didn't set memory.low at all.

2) memory.low is set to a non-zero value but the cgroup has no task in
   it so that it has an effective low value of 0. Again it may have a
   non-zero low event count if memory reclaim happens. This is probably
   not a result expected by the users and it is really doubtful that
   users will check an empty cgroup with no task in it and expecting
   some non-zero event counts.

The simple and naive fix of changing the operator to ">", however,
changes the memory reclaim behavior which can lead to other failures
as low events are needed to facilitate memory reclaim.  So we can't do
that without some relatively riskier changes in memory reclaim.

Another simpler alternative is to avoid reporting below_low failure
if either memory.low or its effective equivalent is 0 which is done
by this patch specifically for the two failed use cases above.

With this patch applied, the test_memcg_low sub-test finishes
successfully without failure in most cases. Though both test_memcg_low
and test_memcg_min sub-tests may still fail occasionally if the
memory.current values fall outside of the expected ranges.

To be consistent, similar change is appled to mem_cgroup_below_min()
as to avoid the two failed use cases above with low replaced by min.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/memcontrol.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53364526d877..4d4a1f159eaa 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -601,21 +601,31 @@ static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
 					struct mem_cgroup *memcg)
 {
+	unsigned long elow;
+
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
-	return READ_ONCE(memcg->memory.elow) >=
-		page_counter_read(&memcg->memory);
+	elow = READ_ONCE(memcg->memory.elow);
+	if (!elow || !READ_ONCE(memcg->memory.low))
+		return false;
+
+	return page_counter_read(&memcg->memory) <= elow;
 }
 
 static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 					struct mem_cgroup *memcg)
 {
+	unsigned long emin;
+
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
-	return READ_ONCE(memcg->memory.emin) >=
-		page_counter_read(&memcg->memory);
+	emin = READ_ONCE(memcg->memory.emin);
+	if (!emin || !READ_ONCE(memcg->memory.min))
+		return false;
+
+	return page_counter_read(&memcg->memory) <= emin;
 }
 
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
-- 
2.48.1


