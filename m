Return-Path: <linux-kselftest+bounces-14026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C5F93972B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 01:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E281C21926
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945B69953;
	Mon, 22 Jul 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="tb5lLGei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m47-110.mailgun.net (m47-110.mailgun.net [69.72.47.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B317BCD
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.47.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692562; cv=none; b=n46FqD6F+NHYSc59MNI2OvzIT+f1GS7s9UHuC2A26Nl4LuZ0ZqTdySPNl8tE3tgoR5Nx5FoOIiJXRfw8bR06SF5uHESVfjTM9WexA1FTneCx+WFU3Izy8qC4z5YybATMc2uAnwgwFPsJrRiYVOGSZ/qNgwOyMJgm8bhsXiYNt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692562; c=relaxed/simple;
	bh=QmnzzWCOFqhy961yzlmuKd1kX7jYGiJWBA2GGKxKShU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lGMKLIVJljOU4DOHjkc5QEAQAT5798quYdDkJE+215cw+L6cg6ygaxgKUEEN828NRWxRXsCyqGKuRLxRDSnF3tssOiHH/RmVQ0B1HkeO4PjYulNWlABZKEU5SdmMWr26eAs9Vub2MvZk1nBBwo1obibcDB/7HmxxbxgOhcHCPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=tb5lLGei; arc=none smtp.client-ip=69.72.47.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721692560; x=1721699760;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=cfXqvTLoWpZvf03R69ICFZ0UrMEoFs1/qsNUNtZDS1o=;
 b=tb5lLGeiLNJZdwGajY/q6+HJ/mpFKhqoK3u/d8JZ3rFEfiwK9zmcjPuuO1RGHEiAdiiv8t40CuWACLjVyn532d6eGp4cTLdtqh9iyMGjPCMpzPz8jvRW1JGdrNWhTCYlag5WUD1xl6lORjIBlPstkej8wegOh7XvUnKJVgr4P+k=
X-Mailgun-Sending-Ip: 69.72.47.110
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 2e1dd017df26 with SMTP id 669ef19042584033c1a590b2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jul 2024 23:56:00 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-4c35368b-g75q.c.vimeo-core.internal [10.56.27.204])
	by smtp.vimeo.com (Postfix) with ESMTP id 9DB5865C5B;
	Mon, 22 Jul 2024 23:55:59 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 34D7BB4117E; Mon, 22 Jul 2024 19:55:59 -0400 (EDT)
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
	linux-kselftest@vger.kernel.org
Subject: mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Mon, 22 Jul 2024 19:55:52 -0400
Message-Id: <20240722235554.2911971-1-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an updated patchset following some excellent comments from Roman
and Longman. [1]

As suggested, I've broken this into two commits:
 1) with the implementation changes
 2) extending the tests tests

I haven't been able to induce anything problematic, but I'm a bit
unclear as to whether there's reference counting on cgroups such that
we don't need to handle the case where the cgroup is freed before the
one of the peak files is closed.


 Documentation/admin-guide/cgroup-v2.rst          |  26 ++-
 include/linux/cgroup.h                           |   8 +
 include/linux/memcontrol.h                       |   5 +
 include/linux/page_counter.h                     |  11 +-
 kernel/cgroup/cgroup-internal.h                  |   2 +
 kernel/cgroup/cgroup.c                           |   7 +
 mm/memcontrol.c                                  | 129 +++++++++++++--
 mm/page_counter.c                                |  36 ++++-
 tools/testing/selftests/cgroup/cgroup_util.c     |  22 +++
 tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
 tools/testing/selftests/cgroup/test_memcontrol.c | 227 ++++++++++++++++++++++++++-
 11 files changed, 444 insertions(+), 31 deletions(-)


[1]: https://lore.kernel.org/cgroups/20240722151713.2724855-1-davidf@vimeo.com/T/


Thank you for your efforts and reviews,

David Finkel
Senior Principal Software Engineer
Vimeo Inc.



