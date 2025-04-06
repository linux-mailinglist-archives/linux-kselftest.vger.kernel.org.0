Return-Path: <linux-kselftest+bounces-30165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C63A7CC9A
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 04:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246931757B0
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD914A4C7;
	Sun,  6 Apr 2025 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/Wn9biM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CE3596B
	for <linux-kselftest@vger.kernel.org>; Sun,  6 Apr 2025 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743907239; cv=none; b=DIYbFcMFOLWFUGvM2Rs9pR7rIl1N1yurM7QoLS+v88SZE+dXXrhQ6gDvk1HhX9A/eHLO16yLqlbLgCKummcZgDPHGvZmdYez45YCmxmsVJ5GKZJoTZd3/qNMGc8nNeVsi0X3w/ewxkQXKP9x4h+8Ry2EKVJfeCiwSMxX/VUC0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743907239; c=relaxed/simple;
	bh=LIiphxm2snpwj6pqMlmbdwc2xr+9l04Hum2MucikSlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iURX89lYpzKWtnyZblQMTMbeghE46g/cNk0tnsTgQ7DRtzVaS3xn+1fp/nKYfTSOaxZxhr0iqCLPpRCeB5btZOhCQy161jiQsWP5HUHGLvVtX3R9Va5cEI5P+NwaphgBnkMNxyd/hs6fhiBQKvF82ripf8lCFs4v9Z/rCS9FKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/Wn9biM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743907235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bk43KL+s2l5fV3lGaddeDBguiZ6SUsPQ8knSF6ClKoc=;
	b=d/Wn9biM4RWT9f7n+3M1JcGuyJH5MpGpp6lnfdcyEl/qcg03OdyuxoNDwD7zoSrz0czrxa
	7KigRnLbQnU3+iFO3LbrRpRJufN8NzjprhcLaa8DnYL0fPTWk91F6UTVxs7fJaegAuVFq5
	2pJWGJPR/nC8uc3LlgAYBcn8Iyxmsyo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-qdtT_OYuNF-o8UWDoInYEQ-1; Sat,
 05 Apr 2025 22:40:32 -0400
X-MC-Unique: qdtT_OYuNF-o8UWDoInYEQ-1
X-Mimecast-MFC-AGG-ID: qdtT_OYuNF-o8UWDoInYEQ_1743907225
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E17219560BC;
	Sun,  6 Apr 2025 02:40:24 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B85F180176A;
	Sun,  6 Apr 2025 02:40:20 +0000 (UTC)
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
Subject: [PATCH v3 0/2] memcg: Fix test_memcg_min/low test failures
Date: Sat,  5 Apr 2025 22:40:08 -0400
Message-ID: <20250406024010.1177927-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

v3:
 - Take up Johannes' suggestion of just skip the !usage case and
   fix test_memcontrol selftest to fix the rests of the min/low
   failures.

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test and sporadically fails its test_memcg_min sub-test. This
patchset fixes the test_memcg_min and test_memcg_low failures by
skipping the !usage case in shrink_node_memcgs() and adjust the
test_memcontrol selftest to fix other causes of the test failures.

Note that I decide not to use the suggested mem_cgroup_usage() call
as it is a real function call defined in mm/memcontrol.c which is not
available if CONFIG_MEMCG isn't defined.

Waiman Long (2):
  mm/vmscan: Skip memcg with !usage in shrink_node_memcgs()
  selftests: memcg: Increase error tolerance of child memory.current
    check in test_memcg_protection()

 mm/vmscan.c                                      |  4 ++++
 tools/testing/selftests/cgroup/test_memcontrol.c | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.48.1


