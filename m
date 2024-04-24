Return-Path: <linux-kselftest+bounces-8820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0268B15F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D08D1C21BB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BC2168B06;
	Wed, 24 Apr 2024 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUK/rBrT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06912165FB3;
	Wed, 24 Apr 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996892; cv=none; b=McAPZwFVHlTbkj9NuA5m8I8ey7z0tER8DEzvRm123Yjr++bXzywtz9emVh/sCUPizbk2FIbIlAziW2lGvEZn86vSAJ0kNoJ2N4cUxIUNbv6MFuNfCbIVuFXTlAq4f6JI+140ndolz7Swcn4tMCPjJ1IjUysSf1qHQSBwc0My2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996892; c=relaxed/simple;
	bh=mLF7JiYV3aL5gRVzXWPg4mgGT5YCnXvtblk/EeSsU2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/ctaDyWUrjxhVAqPdniXryDMBtqczAQXSKnOGZxMAXp5Xrq6yLH/tshFboT8cZQLFrHfK85FECo2uRe6WFCvJi4q9wDHJbNyvodaXz2HVPWgQYSciDC4ZCQKFU4ZwtibH1kvmWkBk5Kr7pJXlIWYxDkkLPiRSx7YwyNcPh9ZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUK/rBrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED7BC113CE;
	Wed, 24 Apr 2024 22:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996891;
	bh=mLF7JiYV3aL5gRVzXWPg4mgGT5YCnXvtblk/EeSsU2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUK/rBrTA0SlRvjCJLNmlKSsxjI5Al8WXWOjCgQndqY0ICe6+QpbO0nmxKC38h3O8
	 inesWIm5+i+xR+/TfaGC9xjLYaSUgPFCF/p0IH8xAaQ8XkoMTP4G5NFMyav2DY2wXW
	 84BnufNmI4sFpIq8cSdCbPlAjcoqiNSrQvvD0ai7YQVbd8OHmsOIeemvEXKVKjSNdE
	 Q0YjN3/HfBUmQCgAEJb/5QGD0WiN/qUHfx6E+pSD5+vN13EqOZT8pb6GMjCF1iv5yN
	 AQucUBrkmE5izdmAPTOQUemoaMch6rKnLfLUy9Q/5X2SFA8gXkruyIPNp2syOdeOtT
	 8dkweKLc54bJA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] selftests: drv-net: extend the README with more info and example
Date: Wed, 24 Apr 2024 15:14:42 -0700
Message-ID: <20240424221444.4194069-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424221444.4194069-1-kuba@kernel.org>
References: <20240424221444.4194069-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add more info to the README. It's also now copied to GitHub for
increased visibility:

 https://github.com/linux-netdev/nipa/wiki/Running-driver-tests

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/README.rst  | 97 ++++++++++++++++---
 1 file changed, 85 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 0cbab33dad1f..3b6a29e6564b 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -1,18 +1,42 @@
-Running tests
-=============
+.. SPDX-License-Identifier: GPL-2.0
 
-Tests are executed within kselftest framework like any other tests.
-By default tests execute against software drivers such as netdevsim.
-All tests must support running against a real device (SW-only tests
-should instead be placed in net/ or drivers/net/netdevsim, HW-only
-tests in drivers/net/hw).
+Running driver tests
+====================
 
-Set appropriate variables to point the tests at a real device.
+Networking driver tests are executed within kselftest framework like any
+other tests. They support testing both real device drivers and emulated /
+software drivers (latter mostly to test the core parts of the stack).
+
+SW mode
+~~~~~~~
+
+By default, when no extra parameters are set or exported, tests execute
+against software drivers such as netdevsim. No extra preparation is required
+the software devices are created and destroyed as part of the test.
+In this mode the tests are indistinguishable from other selftests and
+(for example) can be run under ``virtme-ng`` like the core networking selftests.
+
+HW mode
+~~~~~~~
+
+Executing tests against a real device requires external preparation.
+The netdevice against which tests will be run must exist, be running
+(in UP state) and be configured with an IP address.
+
+Refer to list of :ref:`Variables` later in this file to set up running
+the tests against a real device.
+
+Both modes required
+~~~~~~~~~~~~~~~~~~~
+
+All tests in drivers/net must support running both against a software device
+and a real device. SW-only tests should instead be placed in net/ or
+drivers/net/netdevsim, HW-only tests in drivers/net/hw.
 
 Variables
 =========
 
-Variables can be set in the environment or by creating a net.config
+The variables can be set in the environment or by creating a net.config
 file in the same directory as this README file. Example::
 
   $ NETIF=eth0 ./some_test.sh
@@ -23,9 +47,9 @@ Variables can be set in the environment or by creating a net.config
   # Variable set in a file
   NETIF=eth0
 
-Please note that the config parser is very simple, if there are
-any non-alphanumeric characters in the value it needs to be in
-double quotes.
+Local test (which don't require endpoint for sending / receiving traffic)
+need only the ``NETIF`` variable. Remaining variables define the endpoint
+and communication method.
 
 NETIF
 ~~~~~
@@ -61,3 +85,52 @@ Arguments used to construct the communication channel.
 
   for netns - name of the "remote" namespace
   for ssh - name/address of the remote host
+
+Example
+=======
+
+Build the selftests::
+
+  # make -C tools/testing/selftests/ TARGETS="drivers/net drivers/net/hw"
+
+"Install" the tests and copy them over to the target machine::
+
+  # make -C tools/testing/selftests/ TARGETS="drivers/net drivers/net/hw" \
+     install INSTALL_PATH=/tmp/ksft-net-drv
+
+  # rsync -ra --delete /tmp/ksft-net-drv root@192.168.1.1:/root/
+
+On the target machine, running the tests will use netdevsim by default::
+
+  [/root] # ./ksft-net-drv/run_kselftest.sh -t drivers/net:ping.py
+  TAP version 13
+  1..1
+  # timeout set to 45
+  # selftests: drivers/net: ping.py
+  # KTAP version 1
+  # 1..3
+  # ok 1 ping.test_v4
+  # ok 2 ping.test_v6
+  # ok 3 ping.test_tcp
+  # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
+  ok 1 selftests: drivers/net: ping.py
+
+Create a config with remote info::
+
+  [/root] # cat > ./ksft-net-drv/drivers/net/net.config <<EOF
+  NETIF=eth0
+  LOCAL_V4=192.168.1.1
+  REMOTE_V4=192.168.1.2
+  REMOTE_TYPE=ssh
+  REMOTE_ARGS=root@192.168.1.2
+  EOF
+
+Run the test::
+
+  [/root] # ./ksft-net-drv/drivers/net/ping.py
+  KTAP version 1
+  1..3
+  ok 1 ping.test_v4
+  ok 2 ping.test_v6 # SKIP Test requires IPv6 connectivity
+  ok 3 ping.test_tcp
+  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:1 error:0
-- 
2.44.0


