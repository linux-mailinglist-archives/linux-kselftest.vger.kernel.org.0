Return-Path: <linux-kselftest+bounces-9023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2418B5BB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E23282315
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C57EEE3;
	Mon, 29 Apr 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS3AV2Bd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF8745C5;
	Mon, 29 Apr 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401872; cv=none; b=IdEk5JZMeInPGYqdslsgIzPijNbv2bIyBgq6iPN3Er0Gup7dvI3XynaLUJHRIphq1spTmT9ZPD3K3kXSNV+mtnFUwlTWmRU7RYkCk0pISadS3eTmRK1fADycUanura7/73TVzb3W6jvIV+L9lF5mRJtp0DCnkmu5NMvlyEvrK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401872; c=relaxed/simple;
	bh=U0nGyiN2Vuh8uEp85v3uiynui0tK1Ilq6lvlRzdsl+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SB/UxmXWM8UsaUD5cVhtourxPmxXz26+rIWCGii9mQ0MCeJtIE9PjBCJ/bDD1YK0ccCh/AkYCtx1pSuXt3yKgjBEWxvnYgyitGIW9LoXvJcrNUHIGzhn8hXUGSoA7oh2OzAjMlYjs0bmK0dxPkH0OxQ/55tYhZr5LJlF4MuacoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS3AV2Bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE6CC113CD;
	Mon, 29 Apr 2024 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401872;
	bh=U0nGyiN2Vuh8uEp85v3uiynui0tK1Ilq6lvlRzdsl+E=;
	h=From:To:Cc:Subject:Date:From;
	b=MS3AV2Bd6arzn+z2cdYk8T9aZiqSVHU88wo6yGl1g+DHw8u0SkeyPZR72qAza/rU8
	 UWzR4bJeNSSPJ4Asb07Fn3Id7f/JL3rTnDlvcB56QMClwrPKBoPOmHliVJ41ytiFzX
	 12ZeqtN0/w6BfVgpdQoAbzbjvkq6AoJRsunY0be/XuHvsBWCl0a+o19yfRzVAhXXED
	 RTiW5e2p/zILgsbwjw6oDJu7O1oWwcgQQtZRYBIWvE6j6XzXdHFdfo0Zn+O5Q2Xicr
	 Fax6PFZkInOkFBi9UeuA1CginqFiF6tcXhxTI72Z81YEiHbaCwJkiZAWhuP8TPFX9H
	 0OW9sFFLNjl6w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/6] selftests: net: page_poll allocation error injection
Date: Mon, 29 Apr 2024 07:44:20 -0700
Message-ID: <20240429144426.743476-1-kuba@kernel.org>
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

v2:
 - fix the string formatting for tool wrapper change (patch 3)
 - fix import order for load.py
v1: https://lore.kernel.org/all/20240426232400.624864-1-kuba@kernel.org/

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


