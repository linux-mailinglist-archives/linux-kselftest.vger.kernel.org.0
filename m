Return-Path: <linux-kselftest+bounces-9028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6848B5BB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A712816DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8DE8121A;
	Mon, 29 Apr 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDCKh/uj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117157F484;
	Mon, 29 Apr 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401875; cv=none; b=Wa1478ay59Uv0HM7HDCZf+8FSkikiiE7DFUfCL2nCmm9Qq8CVjFr/s9Fw/Fo5Lt/GbDB7AmxXlTVUbGdAiTkxmrgJ/KF5eNuaPmTV47bz5/64TMCfm36t8d5pfPGS/5MnTaS99Fk/Dx8mc/0j7liCq7qXbrGXaSOYRE96Ay4gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401875; c=relaxed/simple;
	bh=9ZJmaESfiWUDYEEn0PcnEMJclTrwEH+GHbRxg7JtARU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3LQFLhTYywQrOFdtSPOWRBxyPNb2/scWe1S1m5pzT4R5ptLNSQwzfvEYVTmurSr2m9xl3Z58UPKsEw3WoWhObKHLQaPjPcyq1dhmRO2BHm4TbiPi1eLHVzxYSQetr2j4MQfMBewCBysdKaF53zXhv1n0Uo3KyrF99JRqQSpSKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDCKh/uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90896C4AF1A;
	Mon, 29 Apr 2024 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401874;
	bh=9ZJmaESfiWUDYEEn0PcnEMJclTrwEH+GHbRxg7JtARU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDCKh/uj7vzoQTFH9W6Uaztn3RBoR+mjNJplkg7QGh9xXUcfNNUcLFHRMU7FUVS9S
	 6dEj97vglHhfPCC8qaPS6s+9JWLSADkjQFQ4Y/ABHxiokbl4od4k//qMdP/qtFXOx1
	 cDjT9bBo0FsAhCPb8NmHiA15von29CeOhD4U+c4nBTEJsrOyS+l/I5EpwEd4zfbEj7
	 5ng29kIYIQ0jy9tVaB/Lx8XFlzn1hemHxuJ8Wbxa/DPm6AtEV487vNmue0eplsjLX1
	 xmevuulp+wBDbJCqDcgr6IWj/Ay8IySxf7qxl2fryI58qg/egGexvq6VWOswMVfOSk
	 YeBqDDa7kzYgQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 5/6] selftests: drv-net: support generating iperf3 load
Date: Mon, 29 Apr 2024 07:44:25 -0700
Message-ID: <20240429144426.743476-6-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429144426.743476-1-kuba@kernel.org>
References: <20240429144426.743476-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While we are not very interested in testing performance
it's useful to be able to generate a lot of traffic.
iperf is the simplest way of getting relatively high PPS.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix import order in __init__.py
---
 .../selftests/drivers/net/lib/py/__init__.py  |  1 +
 .../selftests/drivers/net/lib/py/load.py      | 41 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/load.py

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 4789c1a4282d..401e70f7f136 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -15,4 +15,5 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
     sys.exit(4)
 
 from .env import *
+from .load import *
 from .remote import Remote
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
new file mode 100644
index 000000000000..abdb677bdb1c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import time
+
+from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
+
+class GenerateTraffic:
+    def __init__(self, env):
+        env.require_cmd("iperf3", remote=True)
+
+        self.env = env
+
+        port = rand_port()
+        self._iperf_server = cmd(f"iperf3 -s -p {port}", background=True)
+        wait_port_listen(port)
+        time.sleep(0.1)
+        self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {port} -t 86400",
+                                 background=True, host=env.remote)
+
+        # Wait for traffic to ramp up
+        pkt = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
+        for _ in range(50):
+            time.sleep(0.1)
+            now = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
+            if now - pkt > 1000:
+                return
+            pkt = now
+        self.stop(verbose=True)
+        raise Exception("iperf3 traffic did not ramp up")
+
+    def stop(self, verbose=None):
+        self._iperf_client.process(terminate=True)
+        if verbose:
+            ksft_pr(">> Client:")
+            ksft_pr(self._iperf_client.stdout)
+            ksft_pr(self._iperf_client.stderr)
+        self._iperf_server.process(terminate=True)
+        if verbose:
+            ksft_pr(">> Server:")
+            ksft_pr(self._iperf_server.stdout)
+            ksft_pr(self._iperf_server.stderr)
-- 
2.44.0


