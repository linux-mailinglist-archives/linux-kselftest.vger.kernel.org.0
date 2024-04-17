Return-Path: <linux-kselftest+bounces-8277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789C8A8F25
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BC41F221CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 23:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8E8527B;
	Wed, 17 Apr 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVdxB+3U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76E79C8;
	Wed, 17 Apr 2024 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395516; cv=none; b=TeCTJtz8wrlwAKZc6rB5pdfXogfs4SNfwKhBJXbH7AYu0mLvlknH2b6dJyyMVm733lEybr1FtRwgUsuUNSY5iPnUydjtnVfR10cJP0RDByFg5EUFVZf1hIs0PUwFsGiK5fNC55ggIbWInCCMOJ3y6CWu2cH9pw2wXOZldBwoP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395516; c=relaxed/simple;
	bh=2sCMdV0/f+LRWVKuBKmkrPcPzK+ls5B4k2d1V4pFHCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfMRf5iaJa/QdcyDEnJAduMg7EnurlrDulokpvaS/3PaxK15HfDY/+2xfAQk/Zfbt5r+yR6Eg2d+YAzsbVXv+GvNhpVMozBKmwTj+gnK1UTeJz9GcfMfnCvPFgupKXGCxsdNMnHOvy34wcO7wNlnNjPdlArP0Ri7F6ogn2WQsws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVdxB+3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4CBC072AA;
	Wed, 17 Apr 2024 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395516;
	bh=2sCMdV0/f+LRWVKuBKmkrPcPzK+ls5B4k2d1V4pFHCc=;
	h=From:To:Cc:Subject:Date:From;
	b=PVdxB+3UoVEuc5AKsc2jxvmmsQ7P49pnXlBrfBdkMtHSPRyS+pzWiDDRW8kYbuDc5
	 NBBU4Nw1STv54qUOr1ZrUlBrr6v2I3vkEiGrM67xS1CJMjIbhkqGPK6Xke/Ft4/6qf
	 RAPbqBuJSK1b0YByZ4FA96G+IBjvQ8/4+/8o9Ji9v7hrSD3euGDu1nZzk7ryVYQ+VZ
	 u1snd9c+VWUBDrGbcLsMAncWkeSze0ih2ZLyhnQoICQGE14+xL8fldirmXNaesYjFF
	 vfe1ZMLxSyxeXmsBtGS7nifTVEFEcMeG7sMj0ihv8eHmVs5w0XcAZ+YSR91OHzyihy
	 YFMHCHAZiAtMw==
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
Subject: [PATCH net-next v3 0/8] selftests: drv-net: support testing with a remote system
Date: Wed, 17 Apr 2024 16:11:38 -0700
Message-ID: <20240417231146.2435572-1-kuba@kernel.org>
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

v3:
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

Jakub Kicinski (8):
  selftests: net: fix counting totals when some checks fail
  selftests: net: set the exit code correctly in Python tests
  selftests: drv-net: define endpoint structures
  selftests: drv-net: factor out parsing of the env
  selftests: drv-net: construct environment for running tests which
    require an endpoint
  selftests: drv-net: add a trivial ping test
  selftests: net: support matching cases by name prefix
  selftests: drv-net: add a TCP ping test case (and useful helpers)

 tools/testing/selftests/drivers/net/Makefile  |   5 +-
 .../testing/selftests/drivers/net/README.rst  |  33 ++++
 .../selftests/drivers/net/lib/py/__init__.py  |   1 +
 .../selftests/drivers/net/lib/py/env.py       | 141 +++++++++++++++---
 .../selftests/drivers/net/lib/py/remote.py    |  15 ++
 .../drivers/net/lib/py/remote_netns.py        |  21 +++
 .../drivers/net/lib/py/remote_ssh.py          |  39 +++++
 tools/testing/selftests/drivers/net/ping.py   |  52 +++++++
 tools/testing/selftests/drivers/net/stats.py  |   4 +-
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ksft.py    |  25 +++-
 tools/testing/selftests/net/lib/py/netns.py   |  31 ++++
 tools/testing/selftests/net/lib/py/utils.py   |  50 ++++++-
 tools/testing/selftests/net/nl_netdev.py      |   4 +-
 14 files changed, 391 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
 create mode 100755 tools/testing/selftests/drivers/net/ping.py
 create mode 100644 tools/testing/selftests/net/lib/py/netns.py

-- 
2.44.0


