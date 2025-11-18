Return-Path: <linux-kselftest+bounces-45918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52013C6BC40
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 135992BB09
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102E2F7AA3;
	Tue, 18 Nov 2025 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd+KZCft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776CC3702EE;
	Tue, 18 Nov 2025 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502714; cv=none; b=jrixiJDRHJZfsgf1gkMwIwUx6ZOLQ24ZYy6IT1ADNr9ElM3+zle9ECkx1B6xiQO70ORde1WGRfGb6aBoBAnhNjacbnhizQvY69zXmagvLlmkmFB+3ngbC6rXc5dvpeK9102U7Sefl7GUjxSualQT0czPxbRk1dLvjqghDQCCmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502714; c=relaxed/simple;
	bh=3saQsPNTZ1BLwOoaxmM5AQKiNhw4mO5JRJ3OV85XG2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=js3bsSsf2ouF4hIDEEcL21BrQTqOh1Rsmkr2zLBj/NkL8IAyKK8xSQZMJT06l7SeM6/ULoGWa3jHGG5Pyjnzmi03c+qPvA9pJHiv7w8gcGz6/1Xb6kfR0zFHEOvfqXEvX8+YO4dZchRLjj70/tXBm3leO2HpDNCR/o/eadH5pis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd+KZCft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A358C19424;
	Tue, 18 Nov 2025 21:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502713;
	bh=3saQsPNTZ1BLwOoaxmM5AQKiNhw4mO5JRJ3OV85XG2M=;
	h=From:To:Cc:Subject:Date:From;
	b=bd+KZCft4bdyMtznl0QNiXZern0SAdTdjRRG96pDzuX68XwUiu/QKKQxU1gM9ULeD
	 Q1ORrXnma9N3iSyGAZHEJdROvKeojoseLAdHXuBWnxEuYE/s2jsCwYrwSw3B3d3L77
	 KSzcWbT5mQUvAOLq6mJFsN+g2my5N5bMhXaFjUUl+dZQSqnsAoXt3+bT5gdakuW+Py
	 mfw7MM8Vf6biuR66dF12BMR4AXTVgre2jSqZ4tTdOsEw98+kHjqCiK6ubq10DT2U0g
	 bxleDPGWfFD1NC8+rBrtICxQUWyT2l4+p2bMf2QtTHxYsKtQrI6Bl8ed07tHCDm01r
	 F81efobK/7WMw==
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
Subject: [PATCH net-next v2 00/12] selftests: drv-net: convert GRO and Toeplitz tests to work for drivers in NIPA
Date: Tue, 18 Nov 2025 13:51:14 -0800
Message-ID: <20251118215126.2225826-1-kuba@kernel.org>
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

v2:
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
 tools/testing/selftests/drivers/net/gro.py    | 161 ++++++++++++++
 .../selftests/drivers/net/hw/.gitignore       |   1 +
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
 26 files changed, 630 insertions(+), 577 deletions(-)
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


