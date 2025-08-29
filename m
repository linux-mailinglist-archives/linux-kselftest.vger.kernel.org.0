Return-Path: <linux-kselftest+bounces-40343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746FBB3C4A1
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 00:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B283BEB30
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 22:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADAD233721;
	Fri, 29 Aug 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjgRRVsb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72833F9;
	Fri, 29 Aug 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505235; cv=none; b=aIqOP5Lp3XiVeld9hs7+Dlh58kHEFyZe7q2KDB+9xx4B/aGcO0ysc6GKnE40iYOmAlET1t9paOrwwSoiYGN3X0BTJWmDJDWaalQPx0GxMUEtmUH5BRSQKX5wWoQSQmMT3B0Jexq16uumUSAoWalh9jIIXOAPao9XLKDKB/HDcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505235; c=relaxed/simple;
	bh=FtSt6Gk0Zh8WLZ9y2nNq0TkHCrmGdtUK3PjQduFr+3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpIrC0CEOyxQojS06E1x/8i34AQOZuH6Z+sVXLQ8thPpf35ug/VfvOHqLwNcTaqO0I4xBNYYKFEPIpPmXNAxUcMLlILbDjruSvUWXLoBqQ6rFFa1pGccZ6G0SHmJM7DoYx14qHox39zo1BEIvn66JhyT79kXrhfBw2+PO7fSvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjgRRVsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6184C4CEF0;
	Fri, 29 Aug 2025 22:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756505235;
	bh=FtSt6Gk0Zh8WLZ9y2nNq0TkHCrmGdtUK3PjQduFr+3g=;
	h=From:To:Cc:Subject:Date:From;
	b=UjgRRVsbcxQDkyRlIU3NYWxZb4IpMg0XGnCF33mWEAGO9B981o+bwHtJnvjoVJbpB
	 PonQT2MSgbtWMi0WSwc8rEkCW84rlhyvBpArS3ezFCjEuVguZFO3leYijG1PH5h66c
	 LSbdrt2x6Rb8myRqRIRf3xfTT6NF8owGMn+gcrrZX8H2VUUsGGSAiuTfdTCP0qk3Or
	 DrUCF8Lf+CE8JrJ5Hi1bkoPHOPfP3l6/qDpy9or18HXNuog0/Ng0pqQD78O2iaLzDX
	 owUWfWg4hIOoVYAC/kupU0Zae3ip/5HkHlReBcMmqTq8MnwVOGUXQU1GDB7+5pX8Nm
	 wQuYHCCsMW8wA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] selftests: drv-net: rss_ctx: use Netlink for timed reconfig
Date: Fri, 29 Aug 2025 15:07:11 -0700
Message-ID: <20250829220712.327920-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rss_ctx test has gotten pretty flaky after I increased
the queue count in NIPA 2->3. Not 100% clear why. We get
a lot of failures in the rss_ctx.test_hitless_key_update case.

Looking closer it appears that the failures are mostly due
to startup costs. I measured the following timing for ethtool -X:
 - python cmd(shell=True)  : 150-250msec
 - python cmd(shell=False) :  50- 70msec
 - timed in bash           :  45- 55msec
 - YNL Netlink call        :   2-  4msec
 - .set_rxfh callback      :   1-  2msec

The target in the test was set to 200msec. We were mostly measuring
ethtool startup cost it seems. Switch to YNL since it's 100x faster.

Lower the pass criteria to ~75msec, no real science behind this number
but we removed ~150msec of overhead, and the old target was 200msec.
So any driver that was passing previously should still pass with 75msec.

Separately we should probably follow up on defaulting to shell=False,
when script doesn't explicitly ask for True, because the overhead
is rather significant.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 9838b8457e5a..3fc5688605b5 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -335,19 +335,20 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     data = get_rss(cfg)
     key_len = len(data['rss-hash-key'])
 
-    key = _rss_key_rand(key_len)
+    ethnl = EthtoolFamily()
+    key = random.randbytes(key_len)
 
     tgen = GenerateTraffic(cfg)
     try:
         errors0, carrier0 = get_drop_err_sum(cfg)
         t0 = datetime.datetime.now()
-        ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))
+        ethnl.rss_set({"header": {"dev-index": cfg.ifindex}, "hkey": key})
         t1 = datetime.datetime.now()
         errors1, carrier1 = get_drop_err_sum(cfg)
     finally:
         tgen.wait_pkts_and_stop(5000)
 
-    ksft_lt((t1 - t0).total_seconds(), 0.2)
+    ksft_lt((t1 - t0).total_seconds(), 0.075)
     ksft_eq(errors1 - errors1, 0)
     ksft_eq(carrier1 - carrier0, 0)
 
-- 
2.51.0


