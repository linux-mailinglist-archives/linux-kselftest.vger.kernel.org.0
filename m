Return-Path: <linux-kselftest+bounces-6961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C789488C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 03:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3E42834ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 01:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B1B4C96;
	Tue,  2 Apr 2024 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rleum6fo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8961C01;
	Tue,  2 Apr 2024 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712019939; cv=none; b=QmH1r6rOR7aXC1DlL8CyisUz3sNLk1kc78rFYvZLpOHcOjrbvgOJQ/n0CZf9lctGuO94oxK8WXyi6mCRBDGUxeYOXZMgvo+V2uKkL8LItqA7qXaiV2YJlhsiin2cjr/nwtiVaqJ2jCw5+1DJ37t6ZakNi6u3lTxxB6kacbJ/rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712019939; c=relaxed/simple;
	bh=1lrpzDDt1QgKvcRc38hsGnv6Q6VUKwROf9kvHpe9Y9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRJJONXhKMZsa8792nucT/T3e2mJ9XiR6CAbdHs7O3YpIkJE3skusmJ1Kf0JK8fi8jnRWyhf0EAvfZpHUXiMQE854uucu2Wb68fGan4y4dv8VkFwKgwLFWyhtU3/a+fo3AAjbye/16CZvq8gBBuUOLfhAWwVftCN+pMPzUUMryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rleum6fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9751DC433C7;
	Tue,  2 Apr 2024 01:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712019939;
	bh=1lrpzDDt1QgKvcRc38hsGnv6Q6VUKwROf9kvHpe9Y9c=;
	h=From:To:Cc:Subject:Date:From;
	b=Rleum6fodaZRgQXvpBxvgTy5MV6kJzamfYTlMLXoValLNWKmmvaoqaMnsj20AKgps
	 S6Ua6/dyejuLUAODvFVOXUnvhWSiHLgqe6iLp7AzAJxktqydmqOGhnDKDs/Qtbiu3s
	 1KqGNyPieeB1co0oqxfSDaMknALf0FHDz5Z/MTMrLx3MwbzrSI+H9O5+hv7Wj5AnA8
	 GnIeEpqCSaIPZqi6Nz3GqugpMVHdXIdVQMOag8JfLHDyFszLuZO6vaXCYeXkZ4+jkA
	 8MSUp1nkohEEU8UM+nrqc5RpJh1Mb1j3/uRgiuxGo5c7qxj/eboLaNWjTbBSxovdg+
	 2kpwb16zhQT8w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	donald.hunter@gmail.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/7] selftests: net: groundwork for YNL-based tests
Date: Mon,  1 Apr 2024 18:05:12 -0700
Message-ID: <20240402010520.1209517-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the options for writing networking tests are C, bash or
some mix of the two. YAML/Netlink gives us the ability to easily
interface with Netlink in higher level laguages. In particular,
there is a Python library already available in tree, under tools/net.
Add the scaffolding which allows writing tests using this library.

The "scaffolding" is needed because the library lives under
tools/net and uses YAML files from under Documentation/.
So we need a small amount of glue code to find those things
and add them to TEST_FILES.

This series adds both a basic SW sanity test and driver
test which can be run against netdevsim or a real device.
When I develop core code I usually test with netdevsim,
then a real device, and then a backport to Meta's kernel.
Because of the lack of integration, until now I had
to throw away the (YNL-based) test script and netdevsim code.

Running tests in tree directly:

 $ ./tools/testing/selftests/net/nl_netdev.py
 KTAP version 1
 1..2
 ok 1 nl_netdev.empty_check
 ok 2 nl_netdev.lo_check
 # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

in tree via make:

 $ make -C tools/testing/selftests/ TARGETS=net \
	TEST_PROGS=nl_netdev.py TEST_GEN_PROGS="" run_tests
  [ ... ]

and installed externally, all seem to work:

 $ make -C tools/testing/selftests/ TARGETS=net \
	install INSTALL_PATH=/tmp/ksft-net
 $ /tmp/ksft-net/run_kselftest.sh -t net:nl_netdev.py
  [ ... ]

For driver tests I followed the lead of net/forwarding and
get the device name from env and/or a config file.

Jakub Kicinski (7):
  netlink: specs: define ethtool header flags
  tools: ynl: copy netlink error to NlError
  selftests: net: add scaffolding for Netlink tests in Python
  selftests: nl_netdev: add a trivial Netlink netdev test
  netdevsim: report stats by default, like a real device
  selftests: drivers: add scaffolding for Netlink tests in Python
  testing: net-drv: add a driver test for stats reporting

 Documentation/netlink/specs/ethtool.yaml      |   5 +
 drivers/net/netdevsim/ethtool.c               |  11 ++
 drivers/net/netdevsim/netdev.c                |  45 +++++++
 tools/net/ynl/lib/ynl.py                      |   3 +-
 tools/testing/selftests/Makefile              |   8 ++
 tools/testing/selftests/drivers/net/Makefile  |   7 ++
 .../testing/selftests/drivers/net/README.rst  |  30 +++++
 .../selftests/drivers/net/lib/py/__init__.py  |  17 +++
 .../selftests/drivers/net/lib/py/env.py       |  41 ++++++
 tools/testing/selftests/drivers/net/stats.py  |  85 +++++++++++++
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/lib/Makefile      |   8 ++
 .../testing/selftests/net/lib/py/__init__.py  |   7 ++
 tools/testing/selftests/net/lib/py/consts.py  |   9 ++
 tools/testing/selftests/net/lib/py/ksft.py    |  96 ++++++++++++++
 tools/testing/selftests/net/lib/py/nsim.py    | 118 ++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   |  47 +++++++
 tools/testing/selftests/net/lib/py/ynl.py     |  49 ++++++++
 tools/testing/selftests/net/nl_netdev.py      |  24 ++++
 19 files changed, 610 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/drivers/net/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/README.rst
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/__init__.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/env.py
 create mode 100755 tools/testing/selftests/drivers/net/stats.py
 create mode 100644 tools/testing/selftests/net/lib/Makefile
 create mode 100644 tools/testing/selftests/net/lib/py/__init__.py
 create mode 100644 tools/testing/selftests/net/lib/py/consts.py
 create mode 100644 tools/testing/selftests/net/lib/py/ksft.py
 create mode 100644 tools/testing/selftests/net/lib/py/nsim.py
 create mode 100644 tools/testing/selftests/net/lib/py/utils.py
 create mode 100644 tools/testing/selftests/net/lib/py/ynl.py
 create mode 100755 tools/testing/selftests/net/nl_netdev.py

-- 
2.44.0


