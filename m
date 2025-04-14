Return-Path: <linux-kselftest+bounces-30654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3EA875CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 04:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C370816A3C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 02:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616719C540;
	Mon, 14 Apr 2025 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaB0nEOH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D31991B6
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744596796; cv=none; b=RldJ84myE8tqP+C/fmEAa1OQCxrJl6USEg2PG1pTqfwmFK3RV+0EcipqjNBy3ew3581Wi/KADTkpLTF25u7mp6rQm2DeScVH5cJbs6ML8XXSm+1TdIAcTIRsEiIW/edGqEkrMMDHZN+NAILgL6TQcyyBxGqn118MEQp/WpLbAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744596796; c=relaxed/simple;
	bh=M9u8GhzSuXNi2zRw5UTGbv3kuYBa26qTcGgdOIkDTc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvaSIpZAdZRqxCEngOGKgj6t8lq8amoBZZdakEcjkw15X+6W8k8PVsY7N8eKTISVwIwXFF/YOEc8RVCmShAU/MSipxDEi5hQ9ysyW/FKByYGfHAK0IWQNs/k5cqPUmYTxbTF5okqvoPfL2Gp4Jr2yvMg6/XNKt0lQa4uDz093hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaB0nEOH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744596793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWd3wodO+vJYf6OkqNBmP1cg6W0V7cLt+fJ3yVah9lQ=;
	b=YaB0nEOH9UF6XpgkhWcd0reBRoi76dc17QdDK1w7SJcn0UAXyUdHrhQ7py61t0JXzkz9Vv
	DlYP1KFGdwgLgRqqID9cgAWu+aGfevw4Uel5wM3lK6tD23RiFTuVjhOY2UnIJKtcPtXgPg
	2aMS1Px1dFHuPoEKHSuKL9LQvTp9Ko8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-iG2B4VqjNJyB-FSbxmYGvw-1; Sun,
 13 Apr 2025 22:13:09 -0400
X-MC-Unique: iG2B4VqjNJyB-FSbxmYGvw-1
X-Mimecast-MFC-AGG-ID: iG2B4VqjNJyB-FSbxmYGvw_1744596787
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCF5D1955DC5;
	Mon, 14 Apr 2025 02:13:06 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11E63180B488;
	Mon, 14 Apr 2025 02:13:02 +0000 (UTC)
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
Subject: [PATCH v6 2/2] selftests: memcg: Increase error tolerance of child memory.current check in test_memcg_protection()
Date: Sun, 13 Apr 2025 22:12:49 -0400
Message-ID: <20250414021249.3232315-3-longman@redhat.com>
In-Reply-To: <20250414021249.3232315-1-longman@redhat.com>
References: <20250414021249.3232315-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The test_memcg_protection() function is used for the test_memcg_min and
test_memcg_low sub-tests. This function generates a set of parent/child
cgroups like:

  parent:  memory.min/low = 50M
  child 0: memory.min/low = 75M,  memory.current = 50M
  child 1: memory.min/low = 25M,  memory.current = 50M
  child 2: memory.min/low = 0,    memory.current = 50M

After applying memory pressure, the function expects the following
actual memory usages.

  parent:  memory.current ~= 50M
  child 0: memory.current ~= 29M
  child 1: memory.current ~= 21M
  child 2: memory.current ~= 0

In reality, the actual memory usages can differ quite a bit from the
expected values. It uses an error tolerance of 10% with the values_close()
helper.

Both the test_memcg_min and test_memcg_low sub-tests can fail
sporadically because the actual memory usage exceeds the 10% error
tolerance. Below are a sample of the usage data of the tests runs
that fail.

  Child   Actual usage    Expected usage    %err
  -----   ------------    --------------    ----
    1       16990208         22020096      -12.9%
    1       17252352         22020096      -12.1%
    0       37699584         30408704      +10.7%
    1       14368768         22020096      -21.0%
    1       16871424         22020096      -13.2%

The current 10% error tolerenace might be right at the time
test_memcontrol.c was first introduced in v4.18 kernel, but memory
reclaim have certainly evolved quite a bit since then which may result
in a bit more run-to-run variation than previously expected.

Increase the error tolerance to 15% for child 0 and 20% for child 1 to
minimize the chance of this type of failure. The tolerance is bigger
for child 1 because an upswing in child 0 corresponds to a smaller
%err than a similar downswing in child 1 due to the way %err is used
in values_close().

Before this patch, a 100 test runs of test_memcontrol produced the
following results:

     17 not ok 1 test_memcg_min
     22 not ok 2 test_memcg_low

After applying this patch, there were no test failure for test_memcg_min
and test_memcg_low in 100 test runs. However, these tests may still fail
once in a while if the memory usage goes beyond the newly extended range.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 5a5dcbe57b56..2ef07b8fa718 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -495,10 +495,10 @@ static int test_memcg_protection(const char *root, bool min)
 	for (i = 0; i < ARRAY_SIZE(children); i++)
 		c[i] = cg_read_long(children[i], "memory.current");
 
-	if (!values_close(c[0], MB(29), 10))
+	if (!values_close(c[0], MB(29), 15))
 		goto cleanup;
 
-	if (!values_close(c[1], MB(21), 10))
+	if (!values_close(c[1], MB(21), 20))
 		goto cleanup;
 
 	if (c[3] != 0)
-- 
2.48.1


