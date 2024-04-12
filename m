Return-Path: <linux-kselftest+bounces-7887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592808A38E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087F528308A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC648152522;
	Fri, 12 Apr 2024 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXuVJsjn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CEB27442;
	Fri, 12 Apr 2024 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965036; cv=none; b=nW1x4p64bvckSSAlvbSlReJXw68k/iG/0LEvkbdQ+srgNGR9dZIDlJBiS/CVPe+mJrOQACvcIjY1Z7o9JujmA3P8qAzH2r3msdOBaEPwYSfkJIACfbzjOPKvM274FRouvV6d+NN3OqBL1HGOeKHNXBCodc+2+QGsMAskrWVFTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965036; c=relaxed/simple;
	bh=Mpt1lC7lY21wo2xnlij1glW2m9/36BGTueRcCPi0iFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xq8lGV8V3wXqf7B2u3RocNxURnSmp4m0a1W9/Xg8EQAQtL43gyrof3A5ub8uSEnQ+H3GOTeG9p6Djh/TlX0ghJ1XGX9ulyGx6ZUVUbAw1mc926FZfWkYiE6gw2eCspvtw6+E0GaLSIAiPGPHRdiGpwK/uSlyShxfqeZnDjciYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXuVJsjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24E3C113CC;
	Fri, 12 Apr 2024 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712965036;
	bh=Mpt1lC7lY21wo2xnlij1glW2m9/36BGTueRcCPi0iFs=;
	h=From:To:Cc:Subject:Date:From;
	b=NXuVJsjnNf5FmhE0wUaXn4BcTV6SfT4/XZ7omgKOBj1RcA4dBbQEj+foVZIZnpgex
	 zx0H8Mcw0rTZZz9bpViM9Bm4R9JVoFSlLVifVsLqzH6lrt+rP8jTiX0C9VyEsJ437w
	 2h8ijxf3/HP0w9Z/4npZ5P0RfLIVgdYEGs+Tw66KvoRDsQYXjVLlV4FzjFORqcu1iq
	 wP4sMxWQlrHC2PNiQTmSDXVz0KA8gUHLalhS4gh3ByGawMeKsiVx7veFvMeD/8oYhq
	 Zc8JSlX+9+HTbE9UjNNaZm44z+c/CW4yGPIkNnv6e05PpcRXp45B/9tMJ5+1NIpE6k
	 hwj6hyQHDdOjA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] selftests: drv-net: support testing with a remote system
Date: Fri, 12 Apr 2024 16:37:00 -0700
Message-ID: <20240412233705.1066444-1-kuba@kernel.org>
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

---

TBH, this series is on top of the one I posted in the morning:
https://lore.kernel.org/all/20240412141436.828666-1-kuba@kernel.org/
but it applies cleanly, and all it needs is the ifindex definition
in netdevsim. Testing with real HW works fine even without the other
series.

Jakub Kicinski (5):
  selftests: drv-net: define endpoint structures
  selftests: drv-net: add stdout to the command failed exception
  selftests: drv-net: factor out parsing of the env
  selftests: drv-net: construct environment for running tests which
    require an endpoint
  selftests: drv-net: add a trivial ping test

 tools/testing/selftests/drivers/net/Makefile  |   4 +-
 .../testing/selftests/drivers/net/README.rst  |  31 ++++
 .../selftests/drivers/net/lib/py/__init__.py  |   1 +
 .../selftests/drivers/net/lib/py/endpoint.py  |  13 ++
 .../selftests/drivers/net/lib/py/env.py       | 136 +++++++++++++++---
 .../selftests/drivers/net/lib/py/ep_netns.py  |  15 ++
 .../selftests/drivers/net/lib/py/ep_ssh.py    |  34 +++++
 tools/testing/selftests/drivers/net/ping.py   |  32 +++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/netns.py   |  31 ++++
 tools/testing/selftests/net/lib/py/utils.py   |  22 +--
 11 files changed, 291 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/endpoint.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/ep_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/ep_ssh.py
 create mode 100755 tools/testing/selftests/drivers/net/ping.py
 create mode 100644 tools/testing/selftests/net/lib/py/netns.py

-- 
2.44.0


