Return-Path: <linux-kselftest+bounces-8382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC1B8AA5E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 01:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181661C20CB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 23:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D571742;
	Thu, 18 Apr 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iibcZVH9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4C54907;
	Thu, 18 Apr 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483530; cv=none; b=Kx/uoU40YvkaC9MZTRv9H7r+TZgDAk90L/XNgONsqquhZj4aTqXVDLgaKrLriF0DuRvWIuY8ko69T3CraBQrH035cDAknWgsdqAaOaHS9ekARye9ehLxqg/xMqoIIEYx2xPsQDT1KC5udE1PfScdpApV+ovGkpMEJMcwCV8H3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483530; c=relaxed/simple;
	bh=1GK/S6OPKI5H31805uG2C4stCPsSr4VBSkY5Bv4RpkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWLrKDCfdDyu8JryWRBJ3SZrSGdGGZ2ExORZGM+X9CRNI7rwSXjZSj05sTsEoSnbuIfuEh1PiisXDJ3YuSOBEgoD+khtaWQ2DynKOiLIv+oxJBuQOrARfEMcRUlVNuC6aswZguduwMe+CKQVW0TNBYcxdJfOv8lPNZdRk5ElP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iibcZVH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6ECC113CC;
	Thu, 18 Apr 2024 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713483530;
	bh=1GK/S6OPKI5H31805uG2C4stCPsSr4VBSkY5Bv4RpkQ=;
	h=From:To:Cc:Subject:Date:From;
	b=iibcZVH9rUQz709UH0YQ8acb9OVO4TGU+JRl/qwtkv6nosQytnQvWEFwgaq5qJk+H
	 xYzfyRKWaKTgIBP9bDWKnLcAratQis6Az1rfN1UZLvYkWEaqzLfL/vTXo3cLC2gU6d
	 1r/sxlnob4DAn3f0CPtGTmkjuxN2cusA7pWNdD9S0NyTYJBK6o0qbkndeVVNbIFYqq
	 lX1GNazvbxEZbxzoe/WRRLbcyTtsEMRoZ8sk1EyzG/wPhwlHNchIbBwMz0qokd+lqu
	 8Rvyrk7ZNckuH8JS9qW/ZUY/52CWv4ZJNOClMiYmRjiSHiSpeD2aMJgTJ2H15yRLMy
	 NiOg6KEay87oQ==
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
Subject: [PATCH net-next v4 0/7] selftests: drv-net: support testing with a remote system
Date: Thu, 18 Apr 2024 16:38:37 -0700
Message-ID: <20240418233844.2762396-1-kuba@kernel.org>
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

v4:
 - improve coding sytle of patch 5
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
 .../selftests/drivers/net/lib/py/env.py       | 174 ++++++++++++++++--
 .../selftests/drivers/net/lib/py/remote.py    |  15 ++
 .../drivers/net/lib/py/remote_netns.py        |  21 +++
 .../drivers/net/lib/py/remote_ssh.py          |  39 ++++
 tools/testing/selftests/drivers/net/ping.py   |  54 ++++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ksft.py    |  13 +-
 tools/testing/selftests/net/lib/py/netns.py   |  31 ++++
 tools/testing/selftests/net/lib/py/utils.py   |  52 +++++-
 12 files changed, 410 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
 create mode 100755 tools/testing/selftests/drivers/net/ping.py
 create mode 100644 tools/testing/selftests/net/lib/py/netns.py

-- 
2.44.0


