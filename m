Return-Path: <linux-kselftest+bounces-14500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59BD942350
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 01:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753AA2837D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FD4191F88;
	Tue, 30 Jul 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="SAaGeZyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m47-110.mailgun.net (m47-110.mailgun.net [69.72.47.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06741AA3FF
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.47.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381195; cv=none; b=mxutlz101ttOrE2Alnl373j7zrcI3+7BtL0PVypXDfQ0IzBz/yLa9Mo/d/TZ91Ww3/f7ScrQ8xssJ+eg42uaxL4Keafst0/vQptUnt37CrAOGg1jskoD+vcmSEkymHJmPeLLQuzup5Zr/wVoEOh8EYSaxnwfTxEaM//zLNeFeds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381195; c=relaxed/simple;
	bh=W/5CntLbeB1Dw6lpz+OWwaeLeOn8lSO1+7ZN7FmmsyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BT9IyK3E0kl8Ipwjfu227s7pAz5W/5jJAEDE9qg8vvtiOGGjEgB5eNgpIb4m6yQ1kOgCDU/TJonCgxhYqKk5qGFCAJZQcwxhT1o0K5h+SHdWFf20SMWpw54tyoWQBjy+nYbfgR2aGytC2bRyHE/f8O0lr4lJF08dG3RH8Lps7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=SAaGeZyu; arc=none smtp.client-ip=69.72.47.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1722381193; x=1722388393;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=HFw6Itzm+RFqrqKfDRiCjS9+G+PGLdndYUWiXGJxZPI=;
 b=SAaGeZyu7hp+34HTgx0vmV5cKS1DWbGO9XJdwCqG0mZtFbL4NBBBFYbPMXR4XAbREW1FjNoTXmp3oa5AfoeXt06imjZZ+kVRii/AJS/gzXSGPFVnPmaBA12X3fD9CXAdHy70/RFu55cZl4LzxKI7x7n/abg8nK694jT0j7qh1ag=
X-Mailgun-Sending-Ip: 69.72.47.110
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 9a3eac76c4d6 with SMTP id 66a973892c8e1673cb6a35c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jul 2024 23:13:13 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-4c35368b-hrdh.c.vimeo-core.internal [10.56.27.209])
	by smtp.vimeo.com (Postfix) with ESMTP id 23D9365CC2;
	Tue, 30 Jul 2024 23:13:13 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id C06F0B40AC9; Tue, 30 Jul 2024 19:13:12 -0400 (EDT)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v7] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Tue, 30 Jul 2024 19:13:02 -0400
Message-Id: <20240730231304.761942-1-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision only updates the tests from the previous revision[1], and
integrates an Acked-by[2] and a Reviewed-By[3] into the first commit
message.


Documentation/admin-guide/cgroup-v2.rst          |  22 ++-
include/linux/cgroup-defs.h                      |   5 +
include/linux/cgroup.h                           |   3 +
include/linux/memcontrol.h                       |   5 +
include/linux/page_counter.h                     |  11 +-
kernel/cgroup/cgroup-internal.h                  |   2 +
kernel/cgroup/cgroup.c                           |   7 +
mm/memcontrol.c                                  | 116 +++++++++++++--
mm/page_counter.c                                |  30 +++-
tools/testing/selftests/cgroup/cgroup_util.c     |  22 +++
tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
tools/testing/selftests/cgroup/test_memcontrol.c | 264 ++++++++++++++++++++++++++++++++-
12 files changed, 454 insertions(+), 35 deletions(-)

[1]: https://lore.kernel.org/cgroups/20240729143743.34236-1-davidf@vimeo.com/T/
[2]: https://lore.kernel.org/cgroups/20240729143743.34236-1-davidf@vimeo.com/T/#m807225dd0944b0bf78419639272bf6602fe053fc
[3]: https://lore.kernel.org/cgroups/20240729143743.34236-1-davidf@vimeo.com/T/#meac510a72b4a282fe1e5edec3323c2204d46cf11


Thank you all for the support and reviews so far!

David Finkel
Senior Principal Software Engineer
Vimeo Inc.




