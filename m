Return-Path: <linux-kselftest+bounces-30898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DF5A8A9BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CA819023AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073C256C8D;
	Tue, 15 Apr 2025 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbmXZbwy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E6250BE8
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751078; cv=none; b=AOr8RoN7k/C2gTL0YrUtMeowmOjPFOGJeg1FqZEVcM7iYUWlyWBXgMjLIl6kfwD0qe1DGMgrZtmMWv067ZmLrLhOMlzDT1v6WDsJHDr+yXyl6RVvM5j2TJzekVzwbcVqQSmR1Udlo+sYCXvvlH8o4gB+Lop7/DApMXDcHUXN33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751078; c=relaxed/simple;
	bh=5zUudYqV340vynghSpjh6FRljA4V5Xb1a1ZKaVrUOkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DAihsbgPhIf+lRJ4jNhNHUkT1v+LugvBpHA5WDgq3NP3+r1Yo/D3CJOEw/TIBhiaCmq78VABjNFG/gJd4JTxc7T7ABqUAqCK+jnJHU0iZ4XAg3EWkx3BU9IgEgpOnLisjx+xig5kAOIg9LfsLOf1eCvJGHkyfPwWzjAswtIYY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbmXZbwy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744751075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GD3dcZZaAV8PGBsMmRQtcMpL9M1m9kBkUBv1lLYHAEA=;
	b=hbmXZbwyUaBcyGrOGZ2tf+MR7j2vJeRpoyrTtutWx0Vpnr32XWrFZQz/uH5JSFtgfIMwCF
	yiiotTvucEyOjZ0n98PbeRNST1HzH/lMGSe5Q10npKBLUfSUQ5/GZANXu7IkINg+u4u4TB
	K5UylA9i7IQIMF+Ot1q8c3f12vO5iY4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-do-G7T1BObOjxM-zBSTeuA-1; Tue,
 15 Apr 2025 17:04:29 -0400
X-MC-Unique: do-G7T1BObOjxM-zBSTeuA-1
X-Mimecast-MFC-AGG-ID: do-G7T1BObOjxM-zBSTeuA_1744751067
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3E45195609F;
	Tue, 15 Apr 2025 21:04:26 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.119])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C4341956054;
	Tue, 15 Apr 2025 21:04:21 +0000 (UTC)
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
Subject: [PATCH v7 0/2] memcg: Fix test_memcg_min/low test failures
Date: Tue, 15 Apr 2025 17:04:13 -0400
Message-ID: <20250415210415.13414-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

v7:
 - Skip the vmscan change as the mem_cgroup_usage() check for now as
   it is currently redundant.

v6:
 - The memcg_test_low failure is indeed due to the memory_recursiveprot
   mount option which is enabled by default in systemd cgroup v2 setting.
   So adopt Michal's suggestion to adjust the low event checking
   according to whether memory_recursiveprot is enabled or not.

v5:
 - Use mem_cgroup_usage() in patch 1 as originally suggested by Johannes.

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test (with memory_recursiveprot enabled) and sporadically fails
its test_memcg_min sub-test. This patchset fixes the test_memcg_min
and test_memcg_low failures by adjusting the test_memcontrol selftest
to fix these test failures.

Waiman Long (2):
  selftests: memcg: Allow low event with no memory.low and
    memory_recursiveprot on
  selftests: memcg: Increase error tolerance of child memory.current
    check in test_memcg_protection()

 .../selftests/cgroup/test_memcontrol.c        | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.49.0


