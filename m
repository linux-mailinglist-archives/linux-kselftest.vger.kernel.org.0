Return-Path: <linux-kselftest+bounces-40363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE62B3CEBD
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 20:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8831C1897454
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 18:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E72DAFAE;
	Sat, 30 Aug 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj7Dj9Zh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2F2DAFA6;
	Sat, 30 Aug 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579401; cv=none; b=QA/iQUbv92jpbF2b3lTmVjlkbQKAa0TTQT94ANG5GCUXRilPpQbwTVJpwjA7ypW0KDNxX9EiQ+t7UDLE30NQJzEfzm0Yo1DuZ2+MFHKJx0EuFBIualiK5F4iq6n4x1NQacMjuLRdu05PYa26t5EY2vEd+T1R33xE++IbvboLCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579401; c=relaxed/simple;
	bh=fLsOGhl5G0JyK31g09dJEI8XL9BKyTjRDbIpcRsGYWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aaCfIEE2QHW0HjjgtR94BBgs9qSfVSOJ1O23AbCsdOtxA74YXtRUSflOmrWuEuDtK9jBrH1Y3lQCvPyw/8u3BcJA6Bs3POiAisw9KmmFfsZpCK7L5O8Msy7lvM0HNRFiisXsEAELX564+O0JplSPXgvbgqEch1NWLfRgjgsxhUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj7Dj9Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C6EC4CEEB;
	Sat, 30 Aug 2025 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756579401;
	bh=fLsOGhl5G0JyK31g09dJEI8XL9BKyTjRDbIpcRsGYWM=;
	h=From:To:Cc:Subject:Date:From;
	b=fj7Dj9ZhgU+4rEyIz8DZhQz2GEClJJzfl5ZQcpY/PTa3mSWW/ZHLtPnlG5tTAUJDw
	 Wb/TLimXC/BU4QXZVQq/WA+Apo45A7G39UnVYKI+iuZKPrLLV3F4QPyS14uj13LnYK
	 nGzeBeX79BqW5xjso96jj5s2iFoXxclAO5Ybx6Sthw6T4uQjaHVbR9A+Qxd03E+G0T
	 XVgWGISk1Lhfw3CuWL6bYwJQbjUu+XvzOxyklUlfgvSC9kRLYk7EwNa7179DbeB14D
	 6l4/m1ZG7TttmlrW3DAgw40rP6yXB8cAsmiXlMZcnDhuE+HZvR7tMSLtcdF25a7Uwi
	 dg0oNL3YT8tTg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	joe@dama.to,
	leitao@debian.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] selftests: drv-net: adjust tests before defaulting to shell=False
Date: Sat, 30 Aug 2025 11:43:16 -0700
Message-ID: <20250830184317.696121-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up tests which expect shell=True without explicitly passing
that param to cmd(). There seems to be only one such case, and
in fact it's better converted to a direct write.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/napi_threaded.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/napi_threaded.py b/tools/testing/selftests/drivers/net/napi_threaded.py
index ed66efa481b0..f4be72b2145a 100755
--- a/tools/testing/selftests/drivers/net/napi_threaded.py
+++ b/tools/testing/selftests/drivers/net/napi_threaded.py
@@ -24,7 +24,8 @@ from lib.py import cmd, defer, ethtool
 
 
 def _set_threaded_state(cfg, threaded) -> None:
-    cmd(f"echo {threaded} > /sys/class/net/{cfg.ifname}/threaded")
+    with open(f"/sys/class/net/{cfg.ifname}/threaded", "wb") as fp:
+        fp.write(str(threaded).encode('utf-8'))
 
 
 def _setup_deferred_cleanup(cfg) -> None:
-- 
2.51.0


