Return-Path: <linux-kselftest+bounces-32138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E2AA6822
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 03:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB99809E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F82143748;
	Fri,  2 May 2025 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="By8Kfpre"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ED98632B
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746147904; cv=none; b=l9+MPKuw13TRZnupGnvxxIhZ4r6iAMAvNgCacTJ6WjGxRIeJ4HtwZx55PfI9RGOmG0MR2dIl9wkfOY4NuOaeO6pjd5sE6Se5rupxteHbLaO3FAQ7oBSb0BuNJNUUKEfJvzUN/sho6bZmeawb+nqJCki5mizwFjDDZWTMYGeT+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746147904; c=relaxed/simple;
	bh=vhlVuXi8YA72d8p0j+EDkAR9M4GEwVDBp87iOO8b9Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jD7wpMYMBJ5GX4vm3SOGjAvKyPcLVJGSa8gMaQBlPP+02i0O41Mfc50GeUV+d1FZ2mBT7DRn3QOMelDhF/HyW4XflB0+GTQKukjj0AQECtYYnccDpp9tviUXK6LFIdPt/olAj5XZPij5WsKv+s/I7GUaQASurJLjoiLGYZlnmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=By8Kfpre; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746147901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TYSdSFwzjhXcSLgkgaEemwI8IC5UbKlgSIinlVdAjNc=;
	b=By8KfpreZTk6qnpiNFAu/3ASZIfv9mVeZebnSpa7jA2EKkWEVBsEkt0oTGrq1ovs3ywafq
	zy6uWekQQnD3oJBvHYH7UisuJT0yA4GeoQ78blOw2NkCYGpLduDqj3LYBcdbkLRKs50qEl
	NKk0nDBvU296IPhYsm2nu8zhiMg672E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-v6cGtQwjNLKML5NP6cyq4A-1; Thu,
 01 May 2025 21:04:56 -0400
X-MC-Unique: v6cGtQwjNLKML5NP6cyq4A-1
X-Mimecast-MFC-AGG-ID: v6cGtQwjNLKML5NP6cyq4A_1746147894
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C01271800261;
	Fri,  2 May 2025 01:04:53 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.189])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4136B19560A3;
	Fri,  2 May 2025 01:04:49 +0000 (UTC)
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
Subject: [PATCH v8 0/2] memcg: Fix test_memcg_min/low test failures
Date: Thu,  1 May 2025 21:04:41 -0400
Message-ID: <20250502010443.106022-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

v8:
 - Ignore the low event count of child 2 with memory_recursiveprot on
   in patch 1 as originally suggested by Michal.

v7:
 - Skip the vmscan change as the mem_cgroup_usage() check for now as
   it is currently redundant.

v6:
 - The memcg_test_low failure is indeed due to the memory_recursiveprot
   mount option which is enabled by default in systemd cgroup v2 setting.
   So adopt Michal's suggestion to adjust the low event checking
   according to whether memory_recursiveprot is enabled or not.

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

 .../selftests/cgroup/test_memcontrol.c        | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.49.0


