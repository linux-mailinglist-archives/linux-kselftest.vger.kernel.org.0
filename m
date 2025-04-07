Return-Path: <linux-kselftest+bounces-30172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EFDA7D1CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 03:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C3E188520A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 01:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC9211A3D;
	Mon,  7 Apr 2025 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RX5CIxLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0331A2547
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743990137; cv=none; b=nyMI1hzzUJJJlGI1M5/1OuqOb/NdBydt8+SrkwHnDrYOJLEi7CG6nPmB6pdR+3Xl8hbfJ7UTlZfWZ0QwFssobTezw+xDOBGayMWL4C+N5MmVvPOhadXZApKKCHjFgbkUbsxqra5eQ1A3FUznH6T3GWNJBRo946E5VwXZyYxPI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743990137; c=relaxed/simple;
	bh=AbyDo/bY+pVL2kFHBCII9XlpdemPv9asbH5oaC7ILOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jz3OoRXskHlvmlwLPXf7u/IPphgK9Tbe+WIKARV1i9GVYp2IaZy+mnNrO7rFQQY2ete+/jr6aiSKoLew8ouaLuTL2GvUyAX+3L4+PeytCgSptb+rh1Pmx4M9GcLDdxcxIjAJo2kgKD0KOmwFMvwBQF8VArdLoP9R9Sn8xan4QSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RX5CIxLC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743990134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EiOkPE1vjWj92acdNv9hdFS/EiVTHVQ3P2F+DfPB/2Y=;
	b=RX5CIxLCSKU0RD3rqzfvqo6o+jcOgndLIUcu9tlLoqOyTeaVaEdnsktYm5zKQ0vZv69kn8
	gGUNNeAHWv7AzbEpm4Do4TV0cDQKI7sRROrGYkEUPzDCWfgJPrIvPOLSwQXFxPwYU5uWhV
	7rd75fKmaVY3YxrQSRkSp0s7oDegK8k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-c2uwzL7jOFi8bMlELcNZdQ-1; Sun,
 06 Apr 2025 21:42:11 -0400
X-MC-Unique: c2uwzL7jOFi8bMlELcNZdQ-1
X-Mimecast-MFC-AGG-ID: c2uwzL7jOFi8bMlELcNZdQ_1743990129
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A354E195609E;
	Mon,  7 Apr 2025 01:42:08 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19B6B1801766;
	Mon,  7 Apr 2025 01:42:04 +0000 (UTC)
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
Subject: [PATCH v4 0/2] memcg: Fix test_memcg_min/low test failures
Date: Sun,  6 Apr 2025 21:41:57 -0400
Message-ID: <20250407014159.1291785-1-longman@redhat.com>
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
v4:
 - Add "#ifdef CONFIG_MEMCG" directives around shrink_node_memcgs() to
   avoid compilation problem with !CONFIG_MEMCG configs.

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test and sporadically fails its test_memcg_min sub-test. This
patchset fixes the test_memcg_min and test_memcg_low failures by
skipping the !usage case in shrink_node_memcgs() and adjust the
test_memcontrol selftest to fix other causes of the test failures.

Note that I decide not to use the suggested mem_cgroup_usage() call as
it is a real function call defined in mm/memcontrol.c to be used mainly
by cgroup v1 code.

Waiman Long (2):
  mm/vmscan: Skip memcg with !usage in shrink_node_memcgs()
  selftests: memcg: Increase error tolerance of child memory.current
    check in test_memcg_protection()

 mm/vmscan.c                                      | 10 ++++++++++
 tools/testing/selftests/cgroup/test_memcontrol.c | 11 ++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.48.1


