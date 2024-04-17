Return-Path: <linux-kselftest+bounces-8283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F438A8F31
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18102826AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 23:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05285620;
	Wed, 17 Apr 2024 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/1wiqL/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174F1411DE;
	Wed, 17 Apr 2024 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395519; cv=none; b=llmuIKe1eWQ4z71uA790rISFwTcPer912RyDnPkTRdKze+F1OzEyhsLUJ3GfjKTfUrBY6V5npVcLK0zODE/PUe2KQOzL5nEDT8+ItQri/EVCqkqIO1KJ+cQ0PwKRmR9Dwqw1MAGUlcL2gINhdIMPiXYLYD5DudaOKS5DnMuZI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395519; c=relaxed/simple;
	bh=17pAk2sHA9rQOuf6BUb0S5PNLhhzSql5gjiWf9LNW4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsL1ujJ5f3tzIGM/JGCTcAJFAt5rwc3KoiQDsiewJfSaT1NMk4etWAp3JbLxvr1cJL6phkEFbV6QSNqUUEf/1jSyu8DlBZEgr3gMs+2OhXNCxEkmMl7U1LSVLPc/x34CPPNiOKJx5k7lnqLAwJqUrs/s2HtMzDiNE0N9jBmA8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/1wiqL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897F9C4AF08;
	Wed, 17 Apr 2024 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395518;
	bh=17pAk2sHA9rQOuf6BUb0S5PNLhhzSql5gjiWf9LNW4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/1wiqL/D3yTeg26GdMXTLGTP5KYPQzYZDN5wJCrnR+OV2v9GnfCrC39x+snhRjN/
	 ZSJQFza7mQdoy9w8xHjbrt/y4qGzW02ze3wwHU7llJPjvscA9mk8DbevqHMxbEYIaj
	 6Cm1Zq/SroncWtEi2MbJA1pAIHdof+YQd7Hj4bW9qeoEvseNQ+RQJ4/j66j9iPPxIr
	 0AHibO1NluMVM7Efh7ydoJ0jl8a1j3cN5CWqK768yhD+NbwgOdpiXxN+SX1infD7el
	 Y+9gVvaKMQJ1z1O9GI7LcTxf4SrhXmhiReTQXR823IhdA2Gce0+jPWx6Xs6BFkW4Yb
	 VX0XmH3XuYzyQ==
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
Subject: [PATCH net-next v3 6/8] selftests: drv-net: add a trivial ping test
Date: Wed, 17 Apr 2024 16:11:44 -0700
Message-ID: <20240417231146.2435572-7-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417231146.2435572-1-kuba@kernel.org>
References: <20240417231146.2435572-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a very simple test for testing with a remote system.
Both IPv4 and IPv6 connectivity is optional so tests
will XFail is env doesn't define an address for the given
family.

Using netdevsim:

 $ ./run_kselftest.sh -t drivers/net:ping.py
 TAP version 13
 1..1
 # timeout set to 45
 # selftests: drivers/net: ping.py
 # KTAP version 1
 # 1..2
 # ok 1 ping.test_v4
 # ok 2 ping.test_v6
 # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/net: ping.py

Command line SSH:

 $ NETIF=virbr0 REMOTE_TYPE=ssh REMOTE_ARGS=root@192.168.122.123 \
    LOCAL_V4=192.168.122.1 REMOTE_V4=192.168.122.123 \
    ./tools/testing/selftests/drivers/net/ping.py
 KTAP version 1
 1..2
 ok 1 ping.test_v4
 ok 2 ping.test_v6 # XFAIL
 # Totals: pass:1 fail:0 xfail:1 xpass:0 skip:0 error:0

Existing devices placed in netns (and using net.config):

 $ cat drivers/net/net.config
 NETIF=veth0
 REMOTE_TYPE=netns
 REMOTE_ARGS=red
 LOCAL_V4="192.168.1.1"
 REMOTE_V4="192.168.1.2"

 $ ./run_kselftest.sh -t drivers/net:ping.py
 TAP version 13
 1..1
 # timeout set to 45
 # selftests: drivers/net: ping.py
 # KTAP version 1
 # 1..2
 # ok 1 ping.test_v4
 # ok 2 ping.test_v6 # XFAIL
 # # Totals: pass:1 fail:0 xfail:1 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/Makefile |  5 ++-
 tools/testing/selftests/drivers/net/ping.py  | 33 ++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/ping.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 379cdb1960a7..754ec643768a 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -2,6 +2,9 @@
 
 TEST_INCLUDES := $(wildcard lib/py/*.py)
 
-TEST_PROGS := stats.py
+TEST_PROGS := \
+	ping.py \
+	stats.py \
+# end of TEST_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
new file mode 100755
index 000000000000..7dd197836ff1
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit, KsftXfailEx
+from lib.py import NetDrvEpEnv
+from lib.py import cmd
+
+
+def test_v4(cfg) -> None:
+    if not cfg.v4:
+        raise KsftXfailEx()
+
+    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
+    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
+
+
+def test_v6(cfg) -> None:
+    if not cfg.v6:
+        raise KsftXfailEx()
+
+    cmd(f"ping -c 1 -W0.5 {cfg.remote_v6}")
+    cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_v4, test_v6],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.44.0


