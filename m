Return-Path: <linux-kselftest+bounces-35542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13366AE2A9C
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EAEC3BCC7B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8CC22D9F1;
	Sat, 21 Jun 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfoJKwF4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32032229B2E;
	Sat, 21 Jun 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526397; cv=none; b=urR8CXUhqhd0NXUn5RI5x/KgxEJgzG1izQbD2EkykJD99DAUp4276rssNffPk1NQFChxAFkEinfISWrXZoB4JDpHu0vvaelDakG7rhbYIQYyo0PZhOBvu+5ThAt/+lxYf6j8xpC91pry5DyUAoN2qyh23y1ALyVT4SNZHzMoFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526397; c=relaxed/simple;
	bh=8H8hEpWXQkhTJSSB0aoHtRWu5OCi4/cvplwAeuUL16U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GO0BNU+JYNMGKG3E/J1vCZfgM9vzPUiTeUX0JH9BWgZ/5Y57C4xzKdiHyzFc4yEOcvjWfwIUdJ5SVNcNSf8Z9IbTIUiW+A4Vjt8yPOOdNgxyw6Fyih+FuJXmfGX3FPiJdQFjdodnkMYdNHygaANl8DDe9ah8uN/4y5YEMQcoeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfoJKwF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BBCC4CEE7;
	Sat, 21 Jun 2025 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526396;
	bh=8H8hEpWXQkhTJSSB0aoHtRWu5OCi4/cvplwAeuUL16U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfoJKwF4rjvtlkxYJ0lFPMuRXF9BWkdeJSxhceNHfVYLPpO2NCuBFGD9RD0kE7Tbv
	 FDMQ6p0ZvPE5YwpOGTJ8cUUqJX8WNSFT6wZaZkcryaM5eVDcb3Wn2vVDBsoJ3zi+ly
	 s4hyNSB7UTgZ0zpIFivT1HBtn7Fis1B1Xdg2Rj/Yy1BEGF+xc8BVTUVXpDiqbITPxU
	 dFYc9Yl/Q67x1ugH05vdMYj0UMU9w65sX3TFn679XgObNCQVwVRL6mZ9TI37oBT2YY
	 FuZ87pwSJD5iRS4dO5d47TCowtktXTMEU90kat1sYQ72eBd9ipOVcKigrOcJytazjV
	 HHJMeqfm/VEFg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	mohan.prasad@microchip.com,
	dw@davidwei.uk,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 8/9] selftests: drv-net: import things in lib one by one
Date: Sat, 21 Jun 2025 10:19:43 -0700
Message-ID: <20250621171944.2619249-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621171944.2619249-1-kuba@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pylint doesn't understand our path hacks, and it generates a lot
of warnings for driver tests. Import what we use one by one, this
is hopefully not too tedious and it makes pylint happy.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: mohan.prasad@microchip.com
CC: sdf@fomichev.me
CC: dw@davidwei.uk
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/hw/lib/py/__init__.py | 17 +++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py    | 14 ++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index b582885786f5..56ff11074b55 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -7,8 +7,25 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
 
 try:
     sys.path.append(KSFT_DIR.as_posix())
+
     from net.lib.py import *
     from drivers.net.lib.py import *
+
+    # Import one by one to avoid pylint false positives
+    from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
+        NlError, RtnlFamily
+    from net.lib.py import CmdExitFailure
+    from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
+        rand_port, tool, wait_port_listen
+    from net.lib.py import fd_read_timeout
+    from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
+    from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
+        ksft_setup
+    from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true
+    from net.lib.py import NetNSEnter
+    from drivers.net.lib.py import GenerateTraffic
+    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 401e70f7f136..9ed1d8f70524 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -7,7 +7,21 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
 
 try:
     sys.path.append(KSFT_DIR.as_posix())
+
     from net.lib.py import *
+
+    # Import one by one to avoid pylint false positives
+    from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
+        NlError, RtnlFamily
+    from net.lib.py import CmdExitFailure
+    from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
+        rand_port, tool, wait_port_listen
+    from net.lib.py import fd_read_timeout
+    from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
+    from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
+        ksft_setup
+    from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
-- 
2.49.0


