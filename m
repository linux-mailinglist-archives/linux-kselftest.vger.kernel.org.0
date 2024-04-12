Return-Path: <linux-kselftest+bounces-7890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E648B8A38EC
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8841F22B5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245FD152DF4;
	Fri, 12 Apr 2024 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDxTuecH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF48152DEE;
	Fri, 12 Apr 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965038; cv=none; b=S3XQTG+CQNTApDarzDW4ARNg05o5BZ35SAYAvuNbncThaD7ZM/VzprxSBTgmArhqJV+lX7rNxs027NFrWusoVD8AqniCMFtcGuHzMrpWDZVZkuFRX2Oy2yXD/hJCgrNZqNfHV+oHxXvkyao4aoV3ebGzjtSQItqYdq+31a1ZEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965038; c=relaxed/simple;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgbryvUY7NEKbDGd9jmQP6SxHKVFaWotj1GSuYzSgOuQsmZhQIiQB0pu61Exo3l+ZdB+1qPMnpz1979tP3rGlUzIRz3UWM6HsDgOPrLkmROtD3qOBJ7DIIDqu5vJyRZX6oFEYeYAPt6W5Hej+HqY/q2kx48VQ3gj7iOshnZXODs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDxTuecH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402D5C4AF0A;
	Fri, 12 Apr 2024 23:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712965037;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDxTuecHdLnPQQPQxy6caTBndoq3qkWOnkzSotuUackQPnRK/EVFzMe/i1czRpgla
	 GnxNBlK8CJ9fqZODNbAoCIk4As6fu5MtgwpKZndKfjNVS75pK0h0BK19oTNYyTvLL/
	 v6fi+Tw/LqSwJF8mW/efxMi9T1u8tjkgtCn+me36gJdNH+mbEcz3PlZfsPZaqZ9Lyp
	 RSXaOmB9mTT+C/dVEre2c9pdx4fZW7/Vix30iKh702KDqrafg0xtXYLSn0GAVRd3ds
	 YEbeUMjm3BLr/vUFHe9XHX7iI/+zO0hU6UBQNBbTR/qUfJQOUK3777CcPg7YIxBP2y
	 lIKYf9Aqr6+Ag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] selftests: drv-net: factor out parsing of the env
Date: Fri, 12 Apr 2024 16:37:03 -0700
Message-ID: <20240412233705.1066444-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412233705.1066444-1-kuba@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
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


