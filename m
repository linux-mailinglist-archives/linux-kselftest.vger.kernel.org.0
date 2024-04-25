Return-Path: <linux-kselftest+bounces-8892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99628B2D0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 00:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7843A1F21D5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD90155A57;
	Thu, 25 Apr 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYuKnfot"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26581155A34;
	Thu, 25 Apr 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083825; cv=none; b=qmeM+gTVk0x5VMO4eV6bjYlaKq5SYWi3TeI4EHzfwUyUcGUlwzSmW6DVU9OZ9MizNQu+Eh6QbfDliL8foVz/t50ogtPWXjiBNErw8doCEop0pb2p42vZKoeBt/ct82O8lJ1Zpt+LHet2/UhJD45SWRXWUyVA5mEXfi61646J0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083825; c=relaxed/simple;
	bh=DUJp5cHn4WtHeGghigmtRvGEuyz77UPiJusThdZtrc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJPa5Kc76bZkHUF9iYvvM3NXEOg3MjQV77jf4NJZx6OSQmnDuCmt9ItnZCdXLjHaKgeK/JtnGvICL5H8dg6Y4bcTljC/LO6z+ecoUAMAv+lrUFH/cCJs9gWCAawUbwXotW6LPkBCk19ZqyrjwpkvAVrAP7J4QZIWr/aGCZDTVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYuKnfot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCE5C2BD10;
	Thu, 25 Apr 2024 22:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714083824;
	bh=DUJp5cHn4WtHeGghigmtRvGEuyz77UPiJusThdZtrc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYuKnfotilGuOZSLxnq3jwKQuUbT5c4JIiOpCkHIEx4hx0O7hRdnVRJeS705gceDr
	 8E26OqMBvxH7cHZVjODclBM2r/qzWaLy8MS66hQAP5YTWoy1VpLIq+CX1iXPoza9Rn
	 +v2lMl+p3JR7HuHOoQzz/3NVGxjGyxaVPcvI4kDVoTza0Hf9p0mivj8oSA5/sR4/dh
	 +jsdOVGZsYEHKH4U+4ExQrTDRsH7WmNGJpwn92xeNlCBf85mTAdf3zsDj7RbswOT0f
	 MJa2ai/3JeejcGHo4KJDbXA+GPOfRQzNDXfKRYAnOrmSezmjtpi9OsAmJlduP4+Iq4
	 vVpWG4beIXouQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 1/3] selftests: drv-net: extend the README with more info and example
Date: Thu, 25 Apr 2024 15:23:39 -0700
Message-ID: <20240425222341.309778-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425222341.309778-1-kuba@kernel.org>
References: <20240425222341.309778-1-kuba@kernel.org>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
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


