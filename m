Return-Path: <linux-kselftest+bounces-30900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680BA8A9C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DB71902300
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 21:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611FF25E47E;
	Tue, 15 Apr 2025 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUYgp6e6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D1259CA7
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751083; cv=none; b=do9eTNFUw0I2B67sVduamP9YrzoEO+ep5+pRGtyozNRChUsA80EJENuszK1g16M3TePkcq2dDn+29ilow45Z12rWLZy+mnTVkE7EVbENM1NyQkEKi+pe7cQBip8sUfxLYCAbLpoje471w//lOPQM9lZLPSmAvMgx0HEpyChzeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751083; c=relaxed/simple;
	bh=Hrbb5sT13h5PBRfPbIX3NmiusU0k3HLWDNiuearqhyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZAHDVGNp5gaRLFIfWWwkmaPj7L3nitul/SAf9aBONKtIXSeFlze+lZEKkFGwttbdJ60nxHRD4oVUvtC6ZV/ik+Yuw8rEsq/G+zoXIeNQYLL3yyGOYfDlQLlsLtzcIiOjARclPrnkxmpNlF2V9O7vg5y49qoHyOq9Y68ST1fOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUYgp6e6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744751080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFsllInDSe+SHojwQO4gcvZGi+BBau3/2pd7c11VFAU=;
	b=hUYgp6e6sPhDOdZBMy7dctxcm2RhKdrV3uk72hApWNlDKbQtg7epZrW2qbhyhdZVuT0KiP
	ZC2i7aWJlBLRfIBWgGD/qdjk/+sBuEAM0LLq33nb/fwN9uEaL2BZRZNn/tsyUAO6NoA1Z5
	/80mt720PYPMegB4HnyXFMrxIuy+VrY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-UXskAcDnNXizMDmIG5y0cQ-1; Tue,
 15 Apr 2025 17:04:34 -0400
X-MC-Unique: UXskAcDnNXizMDmIG5y0cQ-1
X-Mimecast-MFC-AGG-ID: UXskAcDnNXizMDmIG5y0cQ_1744751071
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 942FB18007E1;
	Tue, 15 Apr 2025 21:04:30 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.119])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D4171955D81;
	Tue, 15 Apr 2025 21:04:26 +0000 (UTC)
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
Subject: [PATCH v7 1/2] selftests: memcg: Allow low event with no memory.low and memory_recursiveprot on
Date: Tue, 15 Apr 2025 17:04:14 -0400
Message-ID: <20250415210415.13414-2-longman@redhat.com>
In-Reply-To: <20250415210415.13414-1-longman@redhat.com>
References: <20250415210415.13414-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test due to the fact that its 3rd test child cgroup which
have a memmory.low of 0 have low event count. This happens when
memory_recursiveprot mount option is enabled which is the default
setting used by systemd to mount cgroup2 filesystem.

Modify the test_memcontrol.c to allow non-zero low event count in this
particular case with memory_recursiveprot on.

With this patch applied, the test_memcg_low sub-test finishes
successfully without failure in most cases. Though both test_memcg_low
and test_memcg_min sub-tests may still fail occasionally if the
memory.current values fall outside of the expected ranges.

The 4th test child cgroup has no memory usage and so has an effective
low of 0. It has no low event count because the mem_cgroup_below_low()
check in shrink_node_memcgs() is skipped as mem_cgroup_below_min()
returns true. If we ever change mem_cgroup_below_min() in such a way
that it no longer skips the no usage case, we will have to add code to
explicitly skip it.

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

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
2.49.0


