Return-Path: <linux-kselftest+bounces-45781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD4C662AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A599535AE7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B680336EEE;
	Mon, 17 Nov 2025 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGwkYGpr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF33093AE;
	Mon, 17 Nov 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413107; cv=none; b=nVxUw+SiCC69II7iCvx6JOGPcfMn6rvIfaqQDL+MhxLkduXpScAu1c0asHGCjf/lzbGciRGhVdpdei2Z8fQP8AxB/cATiszj5UVM6KzC8LiperkKi3cDoG1yzKFFa30t/dOo6bhMypBkjU85KciN1RQu3N1CYIFebeVbs+bLupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413107; c=relaxed/simple;
	bh=gMxOe7pw4YW4sPHaE8H8E0DNQlGAUR7FL6SCkfpnujc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMDY2rVDzQogIYf54fLQfb0CGIp64wdZjO+6JyrkSzNIr0eoXwu2zAJxtVn9tS4pBEQ13pprz04j5H3dq/fJb1ILAAWlUEzMp9yeh36o07CDv5V5a3f0ynsiLFD+QzgalSF0FuAdhwZ/hmg4SToY3Nj8Nmbrh+PgXXw5KcVw3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGwkYGpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262E3C116B1;
	Mon, 17 Nov 2025 20:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413106;
	bh=gMxOe7pw4YW4sPHaE8H8E0DNQlGAUR7FL6SCkfpnujc=;
	h=From:To:Cc:Subject:Date:From;
	b=pGwkYGprq8Sleb6CqiQYnUS6JUkIVkxeGW+zgCREHe8uNpPrvVIdHrAcs/VloL2dn
	 v4ZUL+08okBIV8ncENeFzCTVs5WxFI61HCEUBdmtKcUwacQ2xOEy5NbfxYLq88eBEd
	 O5hVp1wMOe8Uf7UvdSoz6S/rhp7J+RvRNeCuHcCChWTWif52w63lInAWYM1fC2qZbq
	 zvDu3of2q4jD0YundekjL7HlKBz0ysetScKDx13e783k0mi0/XAoeWVT2BW0rMEIOq
	 j5gup3fVY7IATeXOb/m79xPebXIHDVIQ0EMc4O/NZycAo9Nym4pU3trZt7HVMw6rXM
	 v97s0C+JCREXw==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/12] selftests: drv-net: convert GRO and Toeplitz tests to work for drivers in NIPA
Date: Mon, 17 Nov 2025 12:57:58 -0800
Message-ID: <20251117205810.1617533-1-kuba@kernel.org>
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
 tools/testing/selftests/drivers/net/gro.py    | 161 ++++++++++++++
 .../selftests/drivers/net/hw/.gitignore       |   3 +-
 .../drivers/net/hw/lib/py/__init__.py         |   4 +-
 .../selftests/drivers/net/hw/toeplitz.py      | 208 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/env.py       |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  42 ++--
 tools/testing/selftests/net/.gitignore        |   2 -
 tools/testing/selftests/net/gro.sh            | 105 ---------
 .../selftests/net/lib/ksft_setup_loopback.sh  | 111 ++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ksft.py    |  93 ++++++--
 tools/testing/selftests/net/lib/py/nsim.py    |   2 +-
 tools/testing/selftests/net/lib/py/utils.py   |  20 +-
 tools/testing/selftests/net/setup_loopback.sh | 120 ----------
 tools/testing/selftests/net/setup_veth.sh     |  45 ----
 tools/testing/selftests/net/toeplitz.sh       | 199 -----------------
 .../testing/selftests/net/toeplitz_client.sh  |  28 ---
 26 files changed, 631 insertions(+), 578 deletions(-)
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


