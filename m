Return-Path: <linux-kselftest+bounces-7034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA2896282
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 04:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3426285FE2
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A168879F2;
	Wed,  3 Apr 2024 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2UZlzci"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D217BAB;
	Wed,  3 Apr 2024 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111672; cv=none; b=J0EHiXKJAYJtT+I37msjt0msennsLzlUxy9hOj/yAArVrL2gas4h8yP1ZoE/PNaohXCDvla87yUeGBLbLTuOou05YoZ/PehaCcpmwUlzMSBlfvpImYavQfki8G3LTMndQiAiZLgetVuv26zcM76iZPrDDTFmij+QEY7ycG2SNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111672; c=relaxed/simple;
	bh=YJByJDcZnprdhLCoGxWdlJMxvPUCqYi57jxdSPR2L5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmJ3oGnKPEaECv2f1RUyFqj95jRdo6F65tz+8mzPiIQWE7NuLvvDPUxzAeCIWOgsfPMe1fTUzAexzkhlTzzo78zJje7NaVYdC+lZJ0XpQtVePsA+vqtv/yd+Dx3+1zvV8+D8Ekoi+HPBrLM51L/nWsMmPAjYO6ob+hkCJiJDSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2UZlzci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70643C433F1;
	Wed,  3 Apr 2024 02:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712111672;
	bh=YJByJDcZnprdhLCoGxWdlJMxvPUCqYi57jxdSPR2L5U=;
	h=From:To:Cc:Subject:Date:From;
	b=I2UZlzciD2v7Vijtuw5WbM3XKYQv1PM7X+Tr3cQgvX0gj9ENiQGRGL4v45Z4XgCyn
	 seteKNceapMx5qSKLu2Nh12IZYDDgEwB5W8eImzgz0zVCewwQ67Eb21YI3cjyeqqSp
	 3jwvJsDPvYGCWn4cfMwBYk7Oua2fcp0gaBsNoXMCeKDZ9bSAkbb4UExNSYHsCKUpKi
	 Qb9it0l011iVPYuNlaM2sKbGfv+MCkh7zWHdFbJOGuiho+2sD+s3hm3BUYQPy9+lH3
	 xQWC4PZIThokY2TWeCwY6N2rL1QdpHeBY4uwbvm1MTCevTsRXCZY9XaBgOqOltkc7G
	 m5US/Rx2QvhnA==
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
Subject: [PATCH net-next v2 0/7] selftests: net: groundwork for YNL-based tests
Date: Tue,  2 Apr 2024 19:34:19 -0700
Message-ID: <20240403023426.1762996-1-kuba@kernel.org>
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

v2: (see patches for minor changes)
 - don't add to TARGETS, create a deperate variable with deps
 - support and use with
 - support and use passing arguments to tests
v1: https://lore.kernel.org/all/20240402010520.1209517-1-kuba@kernel.org/

Jakub Kicinski (7):
  netlink: specs: define ethtool header flags
  tools: ynl: copy netlink error to NlError
  selftests: net: add scaffolding for Netlink tests in Python
  selftests: nl_netdev: add a trivial Netlink netdev test
  netdevsim: report stats by default, like a real device
  selftests: drivers: add scaffolding for Netlink tests in Python
  testing: net-drv: add a driver test for stats reporting

 Documentation/netlink/specs/ethtool.yaml      |   6 +
 drivers/net/netdevsim/ethtool.c               |  11 ++
 drivers/net/netdevsim/netdev.c                |  45 +++++++
 tools/net/ynl/lib/ynl.py                      |   3 +-
 tools/testing/selftests/Makefile              |  10 +-
 tools/testing/selftests/drivers/net/Makefile  |   7 ++
 .../testing/selftests/drivers/net/README.rst  |  30 +++++
 .../selftests/drivers/net/lib/py/__init__.py  |  17 +++
 .../selftests/drivers/net/lib/py/env.py       |  52 ++++++++
 tools/testing/selftests/drivers/net/stats.py  |  86 +++++++++++++
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/lib/Makefile      |   8 ++
 .../testing/selftests/net/lib/py/__init__.py  |   7 ++
 tools/testing/selftests/net/lib/py/consts.py  |   9 ++
 tools/testing/selftests/net/lib/py/ksft.py    |  96 ++++++++++++++
 tools/testing/selftests/net/lib/py/nsim.py    | 118 ++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   |  47 +++++++
 tools/testing/selftests/net/lib/py/ynl.py     |  49 ++++++++
 tools/testing/selftests/net/nl_netdev.py      |  24 ++++
 19 files changed, 624 insertions(+), 2 deletions(-)
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


