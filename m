Return-Path: <linux-kselftest+bounces-8523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9328AB90A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097D11C20F49
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CF58BEA;
	Sat, 20 Apr 2024 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr1Eg8QQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37D79F5;
	Sat, 20 Apr 2024 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581560; cv=none; b=DpRlm1teMMkSMKy91IfQbjFla0k7fBR3+Xjb5AFmI9QFeDuxmm2O261f8jN/ADUMOeSYSdQsCqI+aV/I875EpJ4dCeAu1w9C5a/tb3zqr9SVFV2Zck4rlPr80ilMcVx/JmDbNO83rIJh2x9//gtBC71tlbXnk/nvgo8ThgDd03g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581560; c=relaxed/simple;
	bh=Ddgl4fer8XQqqIUUbAuPuEm3gp+8CbmSSS/skwlXGW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T70azMBWlfE3U2bbGwSoMvGGuWbQicX90saj5ueyRRYbhIqq/D4WzYoakLLSvC4GkWXwKRJ3hAEdIXYOxaEF9iIs0k5E/TzWXzOmkpaeXolo3SG8aX/6r+LALVIwjgiwH+a+C2Kcn5UbKYqAg0d35uiBuc6QJuso3QjhsnETFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr1Eg8QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD79C072AA;
	Sat, 20 Apr 2024 02:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713581560;
	bh=Ddgl4fer8XQqqIUUbAuPuEm3gp+8CbmSSS/skwlXGW8=;
	h=From:To:Cc:Subject:Date:From;
	b=Cr1Eg8QQidKUEV8s36/aGRcIbioeQmSqtsw7/HFSAG3rI1b0p2fCsWTOENXof0So6
	 Y32Vgi1Lb37W1BM5xiQaGWVr91pdq+FvNfpWvFPER1n9aOTHkelUH0UfP+yKrsD8yk
	 RlZMWx6/TXG1TlPCmi+jE1yn0dUZYeEK2B6vhc1nFcGTmvLOMClwDkcqXpfX9fpk4i
	 +NwBVFdE7rn4YVgWmmChZROrNzg1gmVJ1NmHyoZDJwUbPV/nAAYO9frV2vLnhwvq/k
	 0A8rmqgt+FZoafgtN5kRUDFLtwUZEmbqxOlKoxjFt2DIcMqEVRJn9NQh3OsdxPMOtC
	 UuNPC8di9mIlw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v5 0/7] selftests: drv-net: support testing with a remote system
Date: Fri, 19 Apr 2024 19:52:30 -0700
Message-ID: <20240420025237.3309296-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Implement support for tests which require access to a remote system /
endpoint which can generate traffic.
This series concludes the "groundwork" for upstream driver tests.

I wanted to support the three models which came up in discussions:
 - SW testing with netdevsim
 - "local" testing with two ports on the same system in a loopback
 - "remote" testing via SSH
so there is a tiny bit of an abstraction which wraps up how "remote"
commands are executed. Otherwise hopefully there's nothing surprising.

I'm only adding a ping test. I had a bigger one written but I was
worried we'll get into discussing the details of the test itself
and how I chose to hack up netdevsim, instead of the test infra...
So that test will be a follow up :)

v5:
 - fix rand port generation, and wrap it in a helper in case
   the random thing proves to be flaky
 - reuseaddr
 - explicitly select the address family
v4: https://lore.kernel.org/all/20240418233844.2762396-1-kuba@kernel.org
 - improve coding style of patch 5
 - switch from netcat to socat (patch 6)
 - support exit_wait for bkg() in context manager
 - add require_XYZ() helpers (patch 7)
 - increase timeouts a little (1,3 -> 5 sec)
v3: https://lore.kernel.org/all/20240417231146.2435572-1-kuba@kernel.org
 - first two patches are new
 - make Remote::cmd() return Popen() object (patch 3)
 - always operate on absolute paths (patch 3)
 - last two patches are new
v2: https://lore.kernel.org/all/20240416004556.1618804-1-kuba@kernel.org
 - rename endpoint -> remote
 - use 2001:db8:: v6 prefix
 - add a note about persistent SSH connections
 - add the kernel config
v1: https://lore.kernel.org/all/20240412233705.1066444-1-kuba@kernel.org

Jakub Kicinski (7):
  selftests: drv-net: define endpoint structures
  selftests: drv-net: factor out parsing of the env
  selftests: drv-net: construct environment for running tests which
    require an endpoint
  selftests: drv-net: add a trivial ping test
  selftests: net: support matching cases by name prefix
  selftests: drv-net: add a TCP ping test case (and useful helpers)
  selftests: drv-net: add require_XYZ() helpers for validating env

 tools/testing/selftests/drivers/net/Makefile  |   5 +-
 .../testing/selftests/drivers/net/README.rst  |  33 ++++
 .../selftests/drivers/net/lib/py/__init__.py  |   1 +
 .../selftests/drivers/net/lib/py/env.py       | 175 ++++++++++++++++--
 .../selftests/drivers/net/lib/py/remote.py    |  15 ++
 .../drivers/net/lib/py/remote_netns.py        |  21 +++
 .../drivers/net/lib/py/remote_ssh.py          |  39 ++++
 tools/testing/selftests/drivers/net/ping.py   |  51 +++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ksft.py    |  13 +-
 tools/testing/selftests/net/lib/py/netns.py   |  31 ++++
 tools/testing/selftests/net/lib/py/utils.py   |  60 +++++-
 12 files changed, 416 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
 create mode 100755 tools/testing/selftests/drivers/net/ping.py
 create mode 100644 tools/testing/selftests/net/lib/py/netns.py

-- 
2.44.0


