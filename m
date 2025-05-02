Return-Path: <linux-kselftest+bounces-32139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B93AA6824
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 03:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D971BA2118
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B7151991;
	Fri,  2 May 2025 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Emy0EFJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6A14A09C
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746147908; cv=none; b=YNs/6/EdEh8k1BckbWwBhRjS18eyEewNG6Zg7orf3mXwZ+bdGlsHqxOUjXZXmJgeb1xFRyHDad557GWZfxEs4EIJRocE9ZvErP039iENa8w2O9Nf//Aym9RLd66GIgGuKAKrZ0R0fDNMbKTiUl/pl4cAv37yw1aY6gCfk4nrAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746147908; c=relaxed/simple;
	bh=/XF+nOVUHWV7oclFaQbHJp3k6ZIWTtBLnwSsEHDHaX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+NkWRRdeZfjllzdTbxLGZAHMLzwv/rpRLjVzWv3Xomz63HrmRhbj+Yy1X+MERLE+mDctoz6xPq6MQFKlcDNhjuO6eDz3ISSe68vpX1P0y6pMtWduQNQYEvip8t4HlDC4sH4GjKsm5MBDIiX5nTrvGWVeXYlSA6iRxcF6vkriCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Emy0EFJy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746147904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sn1zLJkhirXV66vZdR9vsgzol2b+QwrjTsg6tbMu/Q=;
	b=Emy0EFJyMGKnljklMMhE5pmWxIwXQpAyCk8Un7KTPKOQPHtMVZAGrpveZdJDyIYxDmcPhG
	b6v61ZUtuu2WQpO+2/1z6G8C/C4rsY837HdEu3S7l/mHwPhpV6BvclcGWs2UbsgQ+KhvRZ
	8Z7wWiYScsoiH3SqRA1Zld1YAPpbJ4M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-ufg9Hyr_PVGF2X9qP6yT9Q-1; Thu,
 01 May 2025 21:05:02 -0400
X-MC-Unique: ufg9Hyr_PVGF2X9qP6yT9Q-1
X-Mimecast-MFC-AGG-ID: ufg9Hyr_PVGF2X9qP6yT9Q_1746147897
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 102C418001D5;
	Fri,  2 May 2025 01:04:57 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.189])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F66119560B0;
	Fri,  2 May 2025 01:04:53 +0000 (UTC)
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
Subject: [PATCH v8 1/2] selftests: memcg: Allow low event with no memory.low and memory_recursiveprot on
Date: Thu,  1 May 2025 21:04:42 -0400
Message-ID: <20250502010443.106022-2-longman@redhat.com>
In-Reply-To: <20250502010443.106022-1-longman@redhat.com>
References: <20250502010443.106022-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test due to the fact that its 3rd test child cgroup which
have a memmory.low of 0 have low event count. This happens when
memory_recursiveprot mount option is enabled which is the default
setting used by systemd to mount cgroup2 filesystem.

This issue was originally fixed by commit cdc69458a5f3 ("cgroup:
account for memory_recursiveprot in test_memcg_low()"). It was later
reverted by commit 1d09069f5313 ("selftests: memcg: expect no low events
in unprotected sibling") expecting the memory reclaim code would be
fixed. However, it turns out the unprotected cgroup may still have some
residual effective memory.low protection depending on the memory.low
settings in its parent and its siblings. As a result, low events may
still be triggered.

One way to fix the test failure is to revert the revert commit. However,
Michal suggested that it might be better to ignore the low event count
with memory_recursiveprot enabled as low event may or may not happen
depending on the actual test configuration.

Modify the test_memcontrol.c to ignore low event in the 3rd child cgroup
with memory_recursiveprot on.

The 4th child cgroup has no memory usage and so has an effective
low of 0. It has no low event count because the mem_cgroup_below_low()
check in shrink_node_memcgs() is skipped as mem_cgroup_below_min()
returns true. If we ever change mem_cgroup_below_min() in such a way
that it no longer skips the no usage case, we will have to add code to
explicitly skip it.

With this patch applied, the test_memcg_low sub-test finishes
successfully without failure in most cases. Though both test_memcg_low
and test_memcg_min sub-tests may still fail occasionally if the
memory.current values fall outside of the expected ranges.

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../testing/selftests/cgroup/test_memcontrol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 16f5d74ae762..58602c1831f1 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -380,10 +380,11 @@ static bool reclaim_until(const char *memcg, long goal);
  *
  * Then it checks actual memory usages and expects that:
  * A/B    memory.current ~= 50M
- * A/B/C  memory.current ~= 29M
- * A/B/D  memory.current ~= 21M
- * A/B/E  memory.current ~= 0
- * A/B/F  memory.current  = 0
+ * A/B/C  memory.current ~= 29M [memory.events:low > 0]
+ * A/B/D  memory.current ~= 21M [memory.events:low > 0]
+ * A/B/E  memory.current ~= 0   [memory.events:low == 0 if !memory_recursiveprot,
+ *				 undefined otherwise]
+ * A/B/F  memory.current  = 0   [memory.events:low == 0]
  * (for origin of the numbers, see model in memcg_protection.m.)
  *
  * After that it tries to allocate more than there is
@@ -525,7 +526,14 @@ static int test_memcg_protection(const char *root, bool min)
 		goto cleanup;
 	}
 
+	/*
+	 * Child 2 has memory.low=0, but some low protection may still be
+	 * distributed down from its parent with memory.low=50M if cgroup2
+	 * memory_recursiveprot mount option is enabled. Ignore the low
+	 * event count in this case.
+	 */
 	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		int ignore_low_events_index = has_recursiveprot ? 2 : -1;
 		int no_low_events_index = 1;
 		long low, oom;
 
@@ -534,6 +542,8 @@ static int test_memcg_protection(const char *root, bool min)
 
 		if (oom)
 			goto cleanup;
+		if (i == ignore_low_events_index)
+			continue;
 		if (i <= no_low_events_index && low <= 0)
 			goto cleanup;
 		if (i > no_low_events_index && low)
-- 
2.49.0


