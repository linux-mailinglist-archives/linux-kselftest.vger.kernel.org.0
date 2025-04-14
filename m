Return-Path: <linux-kselftest+bounces-30653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B258A875C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 04:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7662717024A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 02:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC77194A60;
	Mon, 14 Apr 2025 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtzhhW1j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291691917C2
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744596791; cv=none; b=BDzfQra6jp/KnSXt5VJzpGmJrACAHWsXZkerqNgjUoYMS51x4ly/EJGwEJFhO0jqf9lvUjGGGbosjLGD3g8wFOGs9CrbkDMCQvn93+JGft7kqFn+qBTUZgk+ENr6pypBLKOQRW1O3CwSdzNp0o9M1z8Kq7bAXPCTqlmhePwXoVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744596791; c=relaxed/simple;
	bh=UkNjBzrZQ56WR0I2Jr/2T7hIjhiXrcVzWBiJwjH1NWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDLLOacaApvcH1w5+wijzupHti7Df3EuYFufpqmTtAJWl9sFFqKPivDTJ2x6NPOMojd6Ll1HjtVsbBx2P5DsmhdyQRtJfotQmGBqI8Fnf/bKAKOkINbsMJK54/otROaeEh9FqeUZNtKTq5e1A4ZUaOfTStONyXHlpxzlaCBQ61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtzhhW1j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744596788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D51S4gUlLsYOY6CMyTXh6Jn0QDbYM7QIvJMp3/dr794=;
	b=RtzhhW1jTql+vdYIdF0BHB2d31qM5TU1n+ps9o4MIvxs5QswSch1q4t0FWvjwOFmx0xxia
	qrIcmJy2nInThhgN6NNMA/ve/f0pl6wKpvEMoGn709E2zEAH3yM2F2aF+fZBLbg71JnllA
	zP1Es/nHByRf2AW38Q46yhOzfPKSfmg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-oL2pbVgrPO-LZ5pu1Csbsw-1; Sun,
 13 Apr 2025 22:13:04 -0400
X-MC-Unique: oL2pbVgrPO-LZ5pu1Csbsw-1
X-Mimecast-MFC-AGG-ID: oL2pbVgrPO-LZ5pu1Csbsw_1744596782
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89F2D1956087;
	Mon, 14 Apr 2025 02:13:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 382B0180AF7C;
	Mon, 14 Apr 2025 02:12:58 +0000 (UTC)
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
Subject: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in shrink_node_memcgs()
Date: Sun, 13 Apr 2025 22:12:48 -0400
Message-ID: <20250414021249.3232315-2-longman@redhat.com>
In-Reply-To: <20250414021249.3232315-1-longman@redhat.com>
References: <20250414021249.3232315-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test due to the fact that two of its test child cgroups which
have a memmory.low of 0 or an effective memory.low of 0 still have low
events generated for them since mem_cgroup_below_low() use the ">="
operator when comparing to elow.

The two failed use cases are as follows:

1) memory.low is set to 0, but low events can still be triggered and
   so the cgroup may have a non-zero low event count.

2) memory.low is set to a non-zero value but the cgroup has no task in
   it so that it has an effective low value of 0. Again it may have a
   non-zero low event count if memory reclaim happens. This is probably
   not a result expected by the users and it is really doubtful that
   users will check an empty cgroup with no task in it and expecting
   some non-zero event counts.

In the first case, even though memory.low isn't set, it may still have
some low protection if memory.low is set in the parent and the cgroup2
memory_recursiveprot mount option is enabled. So low event may still
be recorded. The test_memcontrol.c test has to be modified to account
for that.

For the second case, it really doesn't make sense to have non-zero
low event if the cgroup has 0 usage. So we need to skip this corner
case in shrink_node_memcgs() by skipping the !usage case.

With this patch applied, the test_memcg_low sub-test finishes
successfully without failure in most cases. Though both test_memcg_low
and test_memcg_min sub-tests may still fail occasionally if the
memory.current values fall outside of the expected ranges.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/internal.h                                    |  9 +++++++++
 mm/memcontrol-v1.h                               |  2 --
 mm/vmscan.c                                      |  4 ++++
 tools/testing/selftests/cgroup/test_memcontrol.c | 16 +++++++++++-----
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 50c2f590b2d0..c06fb0e8d75c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1535,6 +1535,15 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
+#ifdef CONFIG_MEMCG
+unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
+#else
+static inline unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
+{
+	return 1UL;
+}
+#endif
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb416..e92b21af92b1 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -22,8 +22,6 @@
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
-unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
-
 void drain_all_stock(struct mem_cgroup *root_memcg);
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b620d74b0f66..a771a0145a12 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5963,6 +5963,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
+		/* Skip memcg with no usage */
+		if (!mem_cgroup_usage(memcg, false))
+			continue;
+
 		if (mem_cgroup_below_min(target_memcg, memcg)) {
 			/*
 			 * Hard protection.
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 16f5d74ae762..5a5dcbe57b56 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -380,10 +380,10 @@ static bool reclaim_until(const char *memcg, long goal);
  *
  * Then it checks actual memory usages and expects that:
  * A/B    memory.current ~= 50M
- * A/B/C  memory.current ~= 29M
- * A/B/D  memory.current ~= 21M
- * A/B/E  memory.current ~= 0
- * A/B/F  memory.current  = 0
+ * A/B/C  memory.current ~= 29M [memory.events:low > 0]
+ * A/B/D  memory.current ~= 21M [memory.events:low > 0]
+ * A/B/E  memory.current ~= 0   [memory.events:low == 0 if !memory_recursiveprot, > 0 otherwise]
+ * A/B/F  memory.current  = 0   [memory.events:low == 0]
  * (for origin of the numbers, see model in memcg_protection.m.)
  *
  * After that it tries to allocate more than there is
@@ -525,8 +525,14 @@ static int test_memcg_protection(const char *root, bool min)
 		goto cleanup;
 	}
 
+	/*
+	 * Child 2 has memory.low=0, but some low protection is still being
+	 * distributed down from its parent with memory.low=50M if cgroup2
+	 * memory_recursiveprot mount option is enabled. So the low event
+	 * count will be non-zero in this case.
+	 */
 	for (i = 0; i < ARRAY_SIZE(children); i++) {
-		int no_low_events_index = 1;
+		int no_low_events_index = has_recursiveprot ? 2 : 1;
 		long low, oom;
 
 		oom = cg_read_key_long(children[i], "memory.events", "oom ");
-- 
2.48.1


