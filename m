Return-Path: <linux-kselftest+bounces-8969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF68B42B9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 01:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C689BB21850
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EA03FBAD;
	Fri, 26 Apr 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0P3/LWk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257103FB99;
	Fri, 26 Apr 2024 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173847; cv=none; b=j4t/oMsFlNrQvmHh/eY6KgWHkWAcg4OtBTy0w0xKoo+opQrlkpafX5g/9w8Q1iKkIE9k32ciIofIhOTBneyKWzQRQ70i7YHgY9sAQb2YpqXNNHpNpAXPkHW52fIA+jXU9DxM6i4fCVDU0HhyTFTmH1R+bnqVIfHfvPB96YoO/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173847; c=relaxed/simple;
	bh=xtWhklSsxR+Wwpdusjmi/7VnELcfUQUxyVVhnNTi7ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ootl31pdbaNLqSBLS0e5lXb/8JSrAH1mxBKtkGJwMj5mBnOxLSvkdA1SxfGSo6QQG+BOwl55wRDglUC6CXx6NsimZo0+bUm/m8RVcw8qQjwxjfRmcYgZYakzMguL0ZaNlae41pw+18gJraOZm7DYpiL1gG/3MH0StgbIUlPlPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0P3/LWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C69C32781;
	Fri, 26 Apr 2024 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173846;
	bh=xtWhklSsxR+Wwpdusjmi/7VnELcfUQUxyVVhnNTi7ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0P3/LWkgWqD+k7ZqpVFqJOAVacLbllQAmtSogoYk3JjBhnPi9r8IaXpgb94hwaWe
	 G82XvxvCeuUIbcY7tsuQfm00mpYaxAgcPJ4IUM+KGxuprf0g6QGq1ZQ5rrC+G5/2mt
	 cdIPaPYkoepUa9U7kvLD346UVIO1enEmwPK1px4FbnXl9K6suNpNNzYULW5B8iVs7R
	 yB3qlbaCEvUr/jFeKfDHIcqZwwcYNmRQWdLiKi/oYzSe5JMuxwuyxGIUbW4+2K58wd
	 KjwQZvtV38GL5aGk8oOGtjE27cYr/FIQWrY8YTUr5RR+TG83MTvkKKPheD5qLlM5/p
	 GzM9ATIlCulDA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/6] selftests: drv-net: support generating iperf3 load
Date: Fri, 26 Apr 2024 16:23:58 -0700
Message-ID: <20240426232400.624864-6-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426232400.624864-1-kuba@kernel.org>
References: <20240426232400.624864-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/lib/py/__init__.py  |  1 +
 .../selftests/drivers/net/lib/py/load.py      | 41 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/load.py

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 4789c1a4282d..2a2dbb1b4ad7 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -2,6 +2,7 @@
 
 import sys
 from pathlib import Path
+from .load import *
 
 KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
 
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


