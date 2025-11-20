Return-Path: <linux-kselftest+bounces-46037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247AC71C60
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 363E84E38D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B23B274B4D;
	Thu, 20 Nov 2025 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyaabMRu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73945271462;
	Thu, 20 Nov 2025 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604641; cv=none; b=avunPgspZ2CEsk0SH52xgiux40Omg6uoK4/oB0kkckh6SYtC19WewNdHWuKsi7cl2N4c5RWaSbi5ORum4fIryju1BWLcTpvERkmQzu+r3nKkLunjsUI3hRnJ3pwNpdcmQqL4Xp2GV35MriJxWq0Qh2mAx//jaISvBj/cQEdygNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604641; c=relaxed/simple;
	bh=ZNgjrhepYvhJD95ZBeFaRojImBCDpIVxDBkjaC+zosY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5UC0KgZbqk4zVnJo2DOJa2YApZPWQ1t4q9SJ5EwDrKv3bFLOHW7FSDGtVEJUNTccMOVa76Q/F+YBVtE4+GhTI9tjZEJ8OoFLj/5a30etXG02msLNkJCaHMoTZ/pDXNtv6sISWWtja0jy8DZj9yxTTtFLULpkDSWivtjDVqQmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyaabMRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7C3C4CEF5;
	Thu, 20 Nov 2025 02:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604641;
	bh=ZNgjrhepYvhJD95ZBeFaRojImBCDpIVxDBkjaC+zosY=;
	h=From:To:Cc:Subject:Date:From;
	b=EyaabMRufvEqlystnoTNE0X4/ypSckJG9zko+C/vkkU+toCJ5tSXyY7hR9WEdHC1e
	 QaEqYv5SzMgYAtyrP99RO4o0Cfz6ROqLqf8KwY9AAbdgweeczz+6LFMR+ZqIlILjmM
	 dOsp9ldNffxIkSH+pGAszppM35n4nng4wHdHTm44pdC4DoG9SsMcKpHZFMvzex3CiR
	 f3+GTnAw1VyZO5SLrQTLvQEPN5PcxeZE057qmB+A9EhgZsoVegSzNbWVoYPcB3sDss
	 aPrkWPt6AINsSWPuiwlEizLg7hXvTrB7pNbpbQkNUa+DNrrVpt51/P8zgi/ZKDhARZ
	 pEFDHVa8almcg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 00/12] selftests: drv-net: convert GRO and Toeplitz tests to work for drivers in NIPA
Date: Wed, 19 Nov 2025 18:10:12 -0800
Message-ID: <20251120021024.2944527-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Main objective of this series is to convert the gro.sh and toeplitz.sh
tests to be "NIPA-compatible" - meaning make use of the Python env,
which lets us run the tests against either netdevsim or a real device.

The tests seem to have been written with a different flow in mind.
Namely they source different bash "setup" scripts depending on arguments
passed to the test. While I have nothing against the use of bash and
the overall architecture - the existing code needs quite a bit of work
(don't assume MAC/IP addresses, support remote endpoint over SSH).
If I'm the one fixing it, I'd rather convert them to our "simplistic"
Python.

This series rewrites the tests in Python while addressing their
shortcomings. The functionality of running the test over loopback
on a real device is retained but with a different method of invocation
(see the last patch).

Once again we are dealing with a script which run over a variety of
protocols (combination of [ipv4, ipv6, ipip] x [tcp, udp]). The first
4 patches add support for test variants to our scripts. We use the
term "variant" in the same sense as the C kselftest_harness.h -
variant is just a set of static input arguments.

Note that neither GRO nor the Toeplitz test fully passes for me on
any HW I have access to. But this is unrelated to the conversion.
This series is not making any real functional changes to the tests,
it is limited to improving the "test harness" scripts.

v3:
 [patch  1] Exception -> BaseException
 [patch  3] use named tuple instead of attaching attrs directly to a func
 [patch  9] restore the comment about retries in GRO test
 [patch 10] use open() instead of echo
 [patch 10] move MTU changes to _setup() to handle all the config related
  stuff in that function
v2: https://lore.kernel.org/20251118215126.2225826-1-kuba@kernel.org
 [patch  5] fix accidental modification of gitignore
 [patch  8] fix typo in "compared"
 [patch  9] fix typo I -> It
 [patch 10] fix typoe configure -> configured
v1: https://lore.kernel.org/20251117205810.1617533-1-kuba@kernel.org


Jakub Kicinski (12):
  selftests: net: py: coding style improvements
  selftests: net: py: extract the case generation logic
  selftests: net: py: add test variants
  selftests: drv-net: xdp: use variants for qstat tests
  selftests: net: relocate gro and toeplitz tests to drivers/net
  selftests: net: py: support ksft ready without wait
  selftests: net: py: read ip link info about remote dev
  netdevsim: pass packets thru GRO on Rx
  selftests: drv-net: add a Python version of the GRO test
  selftests: drv-net: hw: convert the Toeplitz test to Python
  netdevsim: add loopback support
  selftests: net: remove old setup_* scripts

 tools/testing/selftests/drivers/net/Makefile  |   2 +
 .../testing/selftests/drivers/net/hw/Makefile |   6 +-
 tools/testing/selftests/net/Makefile          |   7 -
 tools/testing/selftests/net/lib/Makefile      |   1 +
 drivers/net/netdevsim/netdev.c                |  26 ++-
 .../testing/selftests/{ => drivers}/net/gro.c |   5 +-
 .../{net => drivers/net/hw}/toeplitz.c        |   7 +-
 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/gro.py    | 164 ++++++++++++++
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   4 +-
 .../selftests/drivers/net/hw/toeplitz.py      | 209 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/env.py       |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  42 ++--
 tools/testing/selftests/net/.gitignore        |   2 -
 tools/testing/selftests/net/gro.sh            | 105 ---------
 .../selftests/net/lib/ksft_setup_loopback.sh  | 111 ++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ksft.py    |  91 ++++++--
 tools/testing/selftests/net/lib/py/nsim.py    |   2 +-
 tools/testing/selftests/net/lib/py/utils.py   |  20 +-
 tools/testing/selftests/net/setup_loopback.sh | 120 ----------
 tools/testing/selftests/net/setup_veth.sh     |  45 ----
 tools/testing/selftests/net/toeplitz.sh       | 199 -----------------
 .../testing/selftests/net/toeplitz_client.sh  |  28 ---
 26 files changed, 632 insertions(+), 577 deletions(-)
 rename tools/testing/selftests/{ => drivers}/net/gro.c (99%)
 rename tools/testing/selftests/{net => drivers/net/hw}/toeplitz.c (99%)
 create mode 100755 tools/testing/selftests/drivers/net/gro.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/toeplitz.py
 delete mode 100755 tools/testing/selftests/net/gro.sh
 create mode 100755 tools/testing/selftests/net/lib/ksft_setup_loopback.sh
 delete mode 100644 tools/testing/selftests/net/setup_loopback.sh
 delete mode 100644 tools/testing/selftests/net/setup_veth.sh
 delete mode 100755 tools/testing/selftests/net/toeplitz.sh
 delete mode 100755 tools/testing/selftests/net/toeplitz_client.sh

-- 
2.51.1


