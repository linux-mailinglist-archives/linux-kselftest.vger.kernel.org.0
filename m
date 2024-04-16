Return-Path: <linux-kselftest+bounces-8040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626008A5F6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 02:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E6C1C20F4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 00:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB52CAD49;
	Tue, 16 Apr 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogqa3Zsb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F88A94F;
	Tue, 16 Apr 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228364; cv=none; b=cziBE6YYW7+oTTcZwLhrRDD9LMsTUToTA3oAY4dljVRLBUdaN9P4x3zDuG78H5M3ClQ+eh4FRjr0VZKkEbSz4kQ7CoDvODAIEx1RlXYZL5QkgKg0rOQ8Ddb+w+aofJw+04A7aCPtrAr4Pm9OcdnmUGii7/4Er1eVF0Cdb95uJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228364; c=relaxed/simple;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXxr+6Y6ye/q9i0i0QeO9SnR3e4XUGranB71W7j+5ztM7DC6Y5lBgpQxJSjosc1gnkHsOBzSFQH+uzoaP/TOi/AvryRVV1lonaOnPf+hr/eL/R83LjYPvztEmfq+bwluGVn+szaCU8S8fKfzQ68WUcoiMaTaFtWyLaP7Tdw8Nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogqa3Zsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CBEC4AF07;
	Tue, 16 Apr 2024 00:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713228364;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogqa3ZsboKb/chTbmpyOUKzKeRofiNdTH/u4+IOOC1+jQKWkloaxw+4SfdrqEBUnX
	 bEj0ciXgoRSrfR7ylP4NLH+0R+4mLg+8T2x/Pl1IHAOBuHF4snXugrjByJyEu3OaT3
	 AKnL1w7lXEWPErpTrZQXj3hW+H1R+1qgKtXoVZbYMFttlO50Ly+rZwBD1joQ1SEKtI
	 8oivkI+YskjZrLrtihvUhuuCEwuAPgXgBY/xc8x7p9rlGYa8N6MiVWHidxETd3kI4U
	 z3HdjFgjOIhvOuzJ/dlwBjhWAq++C4j3xnn5ZOMvBzhVHmPxuPGYWtV/bbSaHwx2+l
	 1XtBF/4YJi6Vg==
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
Subject: [PATCH net-next v2 4/6] selftests: drv-net: factor out parsing of the env
Date: Mon, 15 Apr 2024 17:45:54 -0700
Message-ID: <20240416004556.1618804-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416004556.1618804-1-kuba@kernel.org>
References: <20240416004556.1618804-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests with a remote end will use a different class,
for clarity, but will also need to parse the env.
So factor parsing the env out to a function.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/lib/py/env.py       | 43 +++++++++++--------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index e1abe9491daf..a081e168f3db 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -6,12 +6,36 @@ from pathlib import Path
 from lib.py import ip
 from lib.py import NetdevSimDev
 
+
+def _load_env_file(src_path):
+    env = os.environ.copy()
+
+    src_dir = Path(src_path).parent.resolve()
+    if not (src_dir / "net.config").exists():
+        return env
+
+    lexer = shlex.shlex(open((src_dir / "net.config").as_posix(), 'r').read())
+    k = None
+    for token in lexer:
+        if k is None:
+            k = token
+            env[k] = ""
+        elif token == "=":
+            pass
+        else:
+            env[k] = token
+            k = None
+    return env
+
+
 class NetDrvEnv:
+    """
+    Class for a single NIC / host env, with no remote end
+    """
     def __init__(self, src_path):
         self._ns = None
 
-        self.env = os.environ.copy()
-        self._load_env_file(src_path)
+        self.env = _load_env_file(src_path)
 
         if 'NETIF' in self.env:
             self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
@@ -34,19 +58,4 @@ from lib.py import NetdevSimDev
             self._ns.remove()
             self._ns = None
 
-    def _load_env_file(self, src_path):
-        src_dir = Path(src_path).parent.resolve()
-        if not (src_dir / "net.config").exists():
-            return
 
-        lexer = shlex.shlex(open((src_dir / "net.config").as_posix(), 'r').read())
-        k = None
-        for token in lexer:
-            if k is None:
-                k = token
-                self.env[k] = ""
-            elif token == "=":
-                pass
-            else:
-                self.env[k] = token
-                k = None
-- 
2.44.0


