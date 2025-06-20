Return-Path: <linux-kselftest+bounces-35452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D173AE1FE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 18:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30FE1C22622
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76982E6123;
	Fri, 20 Jun 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjqLVeNX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4A92E610B;
	Fri, 20 Jun 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435910; cv=none; b=F4kgQTUgNxs+ee2P9jPN5EKl6CEkttpaKqfTZdDpv8q8r+Fz+1W/T4wg6zvKE2210wMPyUCA8y3TuVBDq5c2nLpr1hLshauntLDWPqL97vsE+jonGHUsp6LTZup2ed0Q7J+DHwNXbwQES1YRxiROnnDdL4uHKYcDajdKHIG5efg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435910; c=relaxed/simple;
	bh=nElQ9/r9RGhRFbJLrWWq2AWdzYVL5uawzxg5jng16F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R958vfLEB1FqvfxgT1iKMXUuuMz+RDZO0g2vadiQZKRKPB8niT0Wg/7j/9WooCdKhuJjSWBUqihlS2ZbQGL40dwdfJOuB4D5435WtjCmCbOySr1oUwfYfTtBD5vv10PdIOsyqt5+WpUZBEBH8bxTMVCOzA80UtrlKi0oqRRT414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjqLVeNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D900C4CEF1;
	Fri, 20 Jun 2025 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750435910;
	bh=nElQ9/r9RGhRFbJLrWWq2AWdzYVL5uawzxg5jng16F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KjqLVeNXzA81kBJUZ0e8sU7YZKOj9aoIrmPZ3YgQy2I6O6aJHyJCjWK23i9N1+LA0
	 tB7PkUfo1OmR5twVGGKw0ktHqrUnGXKoonDzBNScq0N+pVEC9zbR6NynT8KwWw6iwo
	 ZAoT+c+YYYORZLdotFFrMqBQLsj2O3tVS7Ohziczw1VHn86JYuOqM37r027IbefR5R
	 RA6qGiW+dZwUesKLwaZ8q3CKC3fgK4aVL2KfnmkzxpgDRKleZBP6aqFQ3tRGzKF0pb
	 /ozRoKseVNhm6ECfxoi4Vf7SCJLG2Bqb8zg+jKoH5w+6Rvr3r2XGdwti9vZt2lAzzu
	 gLBf2UsygXu/Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: drv-net: stats: use skip instead of xfail for unsupported features
Date: Fri, 20 Jun 2025 09:11:09 -0700
Message-ID: <20250620161109.2146242-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620161109.2146242-1-kuba@kernel.org>
References: <20250620161109.2146242-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XFAIL is considered a form of a pass by our CI. For HW devices returning
XFAIL for unsupported features is counter-productive because our CI
knows not to expect any HW test to pass until it sees 10 passes in a row.
If we return xfail the test shows up as pass even if the device doesn't
support the feature. netdevsim supports all features necessary for
the stats test so there is no concern about running the test in SW mode.

Make the test skip rather than xfail if driver doesn't support FEC or pause.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/stats.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 00a85d6e54f9..c2bb5d3f1ca1 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -10,7 +10,7 @@ import subprocess
 import time
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_ge, ksft_eq, ksft_is, ksft_in, ksft_lt, ksft_true, ksft_raises
-from lib.py import KsftSkipEx, KsftXfailEx, KsftFailEx
+from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import ksft_disruptive
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
@@ -31,7 +31,7 @@ rtnl = RtnlFamily()
         ethnl.pause_get({"header": {"dev-index": cfg.ifindex}})
     except NlError as e:
         if e.error == errno.EOPNOTSUPP:
-            raise KsftXfailEx("pause not supported by the device") from e
+            raise KsftSkipEx("pause not supported by the device") from e
         raise
 
     data = ethnl.pause_get({"header": {"dev-index": cfg.ifindex,
@@ -49,7 +49,7 @@ rtnl = RtnlFamily()
         ethnl.fec_get({"header": {"dev-index": cfg.ifindex}})
     except NlError as e:
         if e.error == errno.EOPNOTSUPP:
-            raise KsftXfailEx("FEC not supported by the device") from e
+            raise KsftSkipEx("FEC not supported by the device") from e
         raise
 
     data = ethnl.fec_get({"header": {"dev-index": cfg.ifindex,
-- 
2.49.0


