Return-Path: <linux-kselftest+bounces-48385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F12BCFCE24
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 10:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97AD3300AC94
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815E30594E;
	Wed,  7 Jan 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CCMOprFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A798304BDA;
	Wed,  7 Jan 2026 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777973; cv=none; b=PTS7GDQyav0AglqXNCzNiyGOSyg5i7Lj49/XppdYMwilNeqkVycP9/Y57mluOPxeYCSdx3OkQn++Ts1mFuGfD137lX2p39G+PgFQjmyMGY2lE/UT43mEaJ7vRtW3lrakbPXTXqTtDwULFIKW5Gb4UWErlZYKiAqDJbgCpnAW4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777973; c=relaxed/simple;
	bh=kagYsdrj2NYA3SiSuto7dDGq3C70YnCFspbbMVu5GJU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y0FUkMXtGIN1wupvOm9JIW0Ygdj8FxO242cmnrQwJ2GQ5w8Jx5lsjZ9zjfAs2E/x/LNoW2JYi9AeZV9hIDfAsclSu518Swm6uEIgqq3CUdLBkMup4v5TtlOvwSmNeOOa9r1dWUHVj1J4bvSaABT/KzKn0ILHVGxm51hfGDAuJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CCMOprFU; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SbepdL8fPHry+zhsuV968bg0EkRiLpLMT1qSDyYCvVA=;
	b=CCMOprFU8FCITCQZe4mbIl7plgbAUUxisTeoYgN4Cl7CoYSrUIeyk+PeKwsUGL07MFH411gAq
	2qKPjBeWos4rcIyUZEKb2k0c7vJjs3xagg2HSvL3vClI0SpGR9cQTi4feFK+Geb0coWMKmwpi++
	h6lCPx2oiw+E7T7lGHwQ7Lg=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dmMyG2pN8zpStD;
	Wed,  7 Jan 2026 17:22:46 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9578B40363;
	Wed,  7 Jan 2026 17:26:07 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 17:26:07 +0800
Received: from huawei.com (10.173.125.37) by kwepemq500010.china.huawei.com
 (7.202.194.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 7 Jan
 2026 17:26:06 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <shuah@kernel.org>
CC: <david@kernel.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <nao.horiguchi@gmail.com>,
	<linmiaohe@huawei.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH 0/3] selftests/mm: add memory failure selftests
Date: Wed, 7 Jan 2026 17:37:07 +0800
Message-ID: <20260107093710.3928374-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

Introduce selftests to validate the functionality of memory failure. 
These tests help ensure that memory failure handling for anonymous
pages, pagecaches pages works correctly, including proper SIGBUS
delivery to user processes, page isolation, and recovery paths.

Currently madvise syscall is used to inject memory failures. And only
anonymous pages and pagecaches are tested. More test scenarios, e.g.
hugetlb, shmem, thp, will be added. Also more memory failure injecting
methods will be supported, e.g. APEI Error INJection, if required.

Thanks!

Miaohe Lin (3):
  selftests/mm: add memory failure anonymous page test
  selftests/mm: add memory failure clean pagecache test
  selftests/mm: add memory failure dirty pagecache test

 MAINTAINERS                                 |   1 +
 tools/testing/selftests/mm/.gitignore       |   1 +
 tools/testing/selftests/mm/Makefile         |   1 +
 tools/testing/selftests/mm/memory-failure.c | 335 ++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh   |  21 ++
 tools/testing/selftests/mm/vm_util.c        |  41 +++
 tools/testing/selftests/mm/vm_util.h        |   3 +
 7 files changed, 403 insertions(+)
 create mode 100644 tools/testing/selftests/mm/memory-failure.c

-- 
2.33.0


