Return-Path: <linux-kselftest+bounces-34512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA52EAD250E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 19:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A291891942
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857C21D00D;
	Mon,  9 Jun 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RndpDoCc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA521CFF4;
	Mon,  9 Jun 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490497; cv=none; b=BwYwXDMObbA6DR/hR202Q4NqMLD/uUNFfEoBDw8tGX2KMJTA6Qv2cev4Bmx5V781q5YWU8e1G2i1zGFg6qiVKpbFCzupetv/tkC00hIfjSwuq+yrdtKREnmY0p0XkuZH+fzkMV0/BGAfUE0sOtB3UFPi1CyAo4yt4uFI00oVGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490497; c=relaxed/simple;
	bh=8H8hEpWXQkhTJSSB0aoHtRWu5OCi4/cvplwAeuUL16U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEKKaH3ed7Z6rizxkG2D2Wsaa6O8AsIkQBGkirS0q8jLrCkIHoKb2APMbb+rGXmXghhioKBVlV+bNaACIYUUvVdY0rVh3O2aJpo9Os8t9h2aXy0qq0eztZlCoA9lZRMoFUI3+SO2TgSowbv1rOmw2QBAWivBzvnz/4se/1hJdBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RndpDoCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC3BC4CEEF;
	Mon,  9 Jun 2025 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749490497;
	bh=8H8hEpWXQkhTJSSB0aoHtRWu5OCi4/cvplwAeuUL16U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RndpDoCcX4mBM8J5p5iSGeo3nErrU/fHKbaalUHSjOrOEUDmFi8I+WzWGD//B9Y1K
	 JaBCTPNSJ1CQz7/MBYssZDIqomCNpDKPXQsPYTCwFLNc75bU+aSdFOMvEmJxyM2m8Y
	 CvRVMs9kA7xBSPkB9a/5taUkg9occRbdHsRRZ05QCtTIz98YBvCVmkGuvuIZLXX3Ty
	 jLh9T8DsINZqo8ET+MQmOJrsycLRGDygaM20pjdDca2iXyv29qG5xtT2nnlaZ+Txfy
	 Pisiv2BctUl1J2c1aZwja5qV59G270IYDoXZVOFdXJ9hJbHK3xnzZxiOj3fTzVEniN
	 eFWNAztpTsd/Q==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	mohan.prasad@microchip.com,
	sdf@fomichev.me,
	dw@davidwei.uk,
	linux-kselftest@vger.kernel.org
Subject: [RFC net-next 5/6] selftests: drv-net: import things in lib one by one
Date: Mon,  9 Jun 2025 10:34:41 -0700
Message-ID: <20250609173442.1745856-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609173442.1745856-1-kuba@kernel.org>
References: <20250609173442.1745856-1-kuba@kernel.org>
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


