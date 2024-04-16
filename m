Return-Path: <linux-kselftest+bounces-8036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496028A5F64
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 02:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD121F21E79
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 00:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656F15C0;
	Tue, 16 Apr 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMSp/Sea"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB477A50;
	Tue, 16 Apr 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228362; cv=none; b=jszZRgv9LcCqfLvDWBvt9UugdQfqmllfOt/8QzlRcR9dph8FoxwgOR4/NCZD1Sv3UUj4uPDaAGrrYuzlcrRJ2eqEQMACdW5CqTPZitntkwKpHMLhsS7vS+m7KeIYtIvHt6aLNBKPIIaNnR1DsZMDX4n5rXvKIT0j5LXKyV7An8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228362; c=relaxed/simple;
	bh=tnNvUiVcZ1//9EPJDf5+oXW/lGC9LYiQfQzFIgqUsS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kib+ojnTHo9F/J6BgzGxlFMOWhDkwYHiM4MxtAuFh0pnr3CRlsEQlWivLmxHL7KOFv7L16o2/AIuyelf+Hg2Kx5nFoKofZ278atCaLAed8EGI2VatsPNtGust6kgyIe/yiAiuWmYAhPPuhsHS4j2giTOXQw0NrkagnqWTQPl5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMSp/Sea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD453C113CC;
	Tue, 16 Apr 2024 00:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713228362;
	bh=tnNvUiVcZ1//9EPJDf5+oXW/lGC9LYiQfQzFIgqUsS0=;
	h=From:To:Cc:Subject:Date:From;
	b=UMSp/Sea/WSkrBUcrY6wYe/iXKwNz5UzAOCG/TTYdJXyUft4aEJxFFayP8aJfWXsW
	 V7cOKs+bB14F5WHlWM4Iu+8qaB9PAsViLbaL4RxzeqMJvVK2px0356YgjfXBZ3jysI
	 Ufeit5e0B97GV1VqtHQgIQwfeWo2HfW//dEEVrrYb8pE2liY9/JDITqAU4o3n/a3ch
	 ZKx8QGvJKi/QR11dN6mNmLikrnfHatoufKm10s6lW9Ij9ceGf3Jrx0eDEoU6dAEzAg
	 MuGRxWn6wT7UTB8de9xnz948Eh/0ioZyRO8EtTXTDRV5RUQwGclyfyxfKa0zfRIn7i
	 THrgXLhDTrMKQ==
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
Subject: [PATCH net-next v2 0/6] selftests: drv-net: support testing with a remote system
Date: Mon, 15 Apr 2024 17:45:50 -0700
Message-ID: <20240416004556.1618804-1-kuba@kernel.org>
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

v2:
 - rename endpoint -> remote
 - use 2001:db8:: v6 prefix
 - add a note about persistent SSH connections
 - add the kernel config
v1: https://lore.kernel.org/all/20240412233705.1066444-1-kuba@kernel.org

Jakub Kicinski (6):
  selftests: drv-net: add stdout to the command failed exception
  selftests: drv-net: add config for netdevsim
  selftests: drv-net: define endpoint structures
  selftests: drv-net: factor out parsing of the env
  selftests: drv-net: construct environment for running tests which
    require an endpoint
  selftests: drv-net: add a trivial ping test

 tools/testing/selftests/drivers/net/Makefile  |   5 +-
 .../testing/selftests/drivers/net/README.rst  |  33 ++++
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/drivers/net/lib/py/__init__.py  |   1 +
 .../selftests/drivers/net/lib/py/env.py       | 141 +++++++++++++++---
 .../selftests/drivers/net/lib/py/remote.py    |  13 ++
 .../drivers/net/lib/py/remote_netns.py        |  15 ++
 .../drivers/net/lib/py/remote_ssh.py          |  34 +++++
 tools/testing/selftests/drivers/net/ping.py   |  32 ++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/netns.py   |  31 ++++
 tools/testing/selftests/net/lib/py/utils.py   |  22 +--
 12 files changed, 301 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/config
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
 create mode 100755 tools/testing/selftests/drivers/net/ping.py
 create mode 100644 tools/testing/selftests/net/lib/py/netns.py

-- 
2.44.0


