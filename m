Return-Path: <linux-kselftest+bounces-8964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609A8B42AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 01:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1231E1F2416E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE36E3BBCA;
	Fri, 26 Apr 2024 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnQy2kAf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A963A9;
	Fri, 26 Apr 2024 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173844; cv=none; b=YH8Fly0Vbd3tkybOrTXhT3afe5btpqGaIuzp5424ptKKFM99C83MMTjb4j8kRm9sUo+r1FGDUWvUXY2AQNZh+wAC6pOljMAQJ3q34zfOhVGHE3ve3YFmD5/0SeudefZ+4nf1x5OmxIwBv1N9KPHdUmwNzfr7/CB5wx8N4Lg6d+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173844; c=relaxed/simple;
	bh=/g9t1rxqWlKcxef6n8eVH5kZuft6ANF75pHhfo9e0lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOeg3JRivrvf8gIWfoq+Z0xLdIp5j9kUIOXCG445Y+afbnLG+pKBCB+paqy3hWeP94r6nsCslsMjg0XcIyJ68j7p9DFwhKPNgJt5ch13QTkWfgoiQ9X3Phap3AoT/qwZz+SA8JVLcCFYqljyf4Rsn7AffNLg5a7XUvtRA4yoY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnQy2kAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EDBC113CD;
	Fri, 26 Apr 2024 23:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173844;
	bh=/g9t1rxqWlKcxef6n8eVH5kZuft6ANF75pHhfo9e0lg=;
	h=From:To:Cc:Subject:Date:From;
	b=QnQy2kAfAi3PFhm/5hbOeB4zXrmc+kGTe4I8WL1jkiwFntNrQ2FQcW9tsyKnz5iFA
	 rNZwMjdh7FbL0C112y4URgUzP7V9GeJwtjrgrCYA62aEKJ5FKsRwS27/oV0rOKVita
	 sy4rRnDA/ZLgbBp4BUuzpYzxRMe4T3S90NQKk3sSLyfX0NTuxDp5r7YlciQ1o7s91p
	 XCKAry2ZYmp6w6NocB6Nib7PaFQYot854lgqhU3jtEvZV6sz1M9Dp5pP7cpTM9Xfir
	 LU5HTOiVBNA7GfJ3//RUzyE7x1yyZehj1irccfA7dFfAKizTq7H5TjYNhNpAgdaQYz
	 lWN5DMLALywkA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/6] selftests: net: page_poll allocation error injection
Date: Fri, 26 Apr 2024 16:23:53 -0700
Message-ID: <20240426232400.624864-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for exercising driver memory allocation failure paths.
page pool is a bit tricky to inject errors into at the page allocator
level because of the bulk alloc and recycling, so add explicit error
injection support "in front" of the caches.

Add a test to exercise that using only the standard APIs.
This is the first useful test for the new tests with an endpoint.
There's no point testing netdevsim here, so this is also the first
HW-only test in Python.

I'm not super happy with the traffic generation using iperf3,
my initial approach was to use mausezahn. But it turned out to be
5x slower in terms of PPS. Hopefully this is good enough for now.

Jakub Kicinski (6):
  net: page_pool: support error injection
  selftests: drv-net-hw: support using Python from net hw tests
  selftests: net: py: extract tool logic
  selftests: net: py: avoid all ports < 10k
  selftests: drv-net: support generating iperf3 load
  selftests: drv-net-hw: add test for memory allocation failures with
    page pool

 net/core/page_pool.c                          |   2 +
 tools/testing/selftests/Makefile              |   2 +-
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../drivers/net/hw/lib/py/__init__.py         |  16 +++
 .../selftests/drivers/net/hw/pp_alloc_fail.py | 129 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   1 +
 .../selftests/drivers/net/lib/py/env.py       |  10 +-
 .../selftests/drivers/net/lib/py/load.py      |  41 ++++++
 tools/testing/selftests/net/lib/py/ksft.py    |   4 +
 tools/testing/selftests/net/lib/py/utils.py   |  14 +-
 10 files changed, 214 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/load.py

-- 
2.44.0


