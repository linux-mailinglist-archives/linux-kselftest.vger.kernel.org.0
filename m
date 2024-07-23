Return-Path: <linux-kselftest+bounces-14120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79793A9DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 01:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD391C22386
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 23:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACD71494A8;
	Tue, 23 Jul 2024 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="hCnIIpTE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m35-116.mailgun.net (m35-116.mailgun.net [69.72.35.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FDC13CA81
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.35.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777519; cv=none; b=TLb9lGKJaOSP/DsQGabHKzrQdcRTWdnIH8y9wSivF/OzK20buBd5/4X0EUsVHMHGS4akry/DQtgfWL73+vn+XwriIuRLz7Xh0MGVbL4mWzC4jPO8i4zCocp4SjXH8jyweInYuZelc2CqgcyTCeCCSRvxRrgDYt63z9jG36wEmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777519; c=relaxed/simple;
	bh=574PVJjxhcXgBU93C1TBe8sKbMY4qQit0D23iiTID9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RXOWbYyIDOuInHopm6IXG53dwbuGZpWdoIQ2hBw0gnXwYLY945w9eMSe9IFs/jmOGIhQD4BcRYvvhCDXqPPwRWCbPeBpagj5mpN6SAZ1ENg25apBYy67tobYYZZLNvA/su/xJ0TS2DL8p8ZLvFCZw0jAE27xKEkO/Xz64y4t8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=hCnIIpTE; arc=none smtp.client-ip=69.72.35.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721777517; x=1721784717;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=1OGOL1sPx+J2rF1NZfGSVqg8QLtgMP1hDzZwcEuf6js=;
 b=hCnIIpTEPPL1Fk3ukz9EL8Jy+AONnNcWnuZPGyT0K5/OfRIzSQpKUJgeoTLj0vAiXgn7XUt8szvXwz3U9LHI92BRKn2nJHntuLAoXfxTEB8K+GBKIcgbtIuMgxyDX8or7+vNdgj+ocFeRSJxtafUsJgN2BJcpp/bQKuTjVcCkiI=
X-Mailgun-Sending-Ip: 69.72.35.116
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by b1f1fcd39ac8 with SMTP id 66a03d6d50ed252601e391f7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jul 2024 23:31:57 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-7f6ba6de-fx1q.c.vimeo-core.internal [10.56.27.207])
	by smtp.vimeo.com (Postfix) with ESMTP id 53EDE64D5F;
	Tue, 23 Jul 2024 23:31:57 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 0096BB4133E; Tue, 23 Jul 2024 19:31:56 -0400 (EDT)
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
Date: Tue, 23 Jul 2024 19:31:47 -0400
Message-Id: <20240723233149.3226636-1-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an update of a previous series[1] addressing Johannes' comments,
and rebasing on top of linus's master.

Unfortunately, linus's master doesn't seem to be bootable at the
moment, so I haven't re-run the tests on this change yet. I'll see about
re-running everything in the morning. (root= resolution seems to be
failing both for x86-64 (in qemu) and usermode linux)

 Documentation/admin-guide/cgroup-v2.rst          |  26 ++--
 include/linux/cgroup-defs.h                      |   5 +
 include/linux/cgroup.h                           |   3 +
 include/linux/memcontrol.h                       |   5 +
 include/linux/page_counter.h                     |   6 +-
 kernel/cgroup/cgroup-internal.h                  |   2 +
 kernel/cgroup/cgroup.c                           |   7 ++
 mm/memcontrol.c                                  | 117 ++++++++++++++++--
 mm/page_counter.c                                |  30 +++--
 tools/testing/selftests/cgroup/cgroup_util.c     |  22 ++++
 tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
 tools/testing/selftests/cgroup/test_memcontrol.c | 226 ++++++++++++++++++++++++++++++++--
 12 files changed, 416 insertions(+), 35 deletions(-)


[1]: https://lore.kernel.org/cgroups/20240722235554.2911971-1-davidf@vimeo.com/T/


Thanks for all the constructive comments and discussion!

David Finkel
Senior Principal Engineer, Core Services
Vimeo Inc.



