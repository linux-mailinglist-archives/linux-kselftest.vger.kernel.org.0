Return-Path: <linux-kselftest+bounces-8281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4BF8A8F2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838E21F2198A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 23:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E113126F08;
	Wed, 17 Apr 2024 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAQR7uvK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AEA86136;
	Wed, 17 Apr 2024 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395518; cv=none; b=kKT0H3UL1VZCRPhdMvS0XoNF0sIvEvwU26HfGw8Zqm2cZ0zYC8aGIq+/QQEyQok6K9Ks7i2SWrsS5AzIHUrJirJEA6yTP4O0VRIBdLp7mm09olhFp2E1RrslARZomqr2SJQoOElnBynAukz7VHyqDSkHxKN1h2SRs8RboG+T5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395518; c=relaxed/simple;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3/hQ5d7BE08BosqTHYDlC3zSemYqMNVU9DkVNbBa/j7KdoVyEP84Aked9Mdw6AYxg41Udj3iBmMQUwwDbEzPq4ZQNUe1WSNzNT2CGjbElGz+5Jj4TU5dip94RTdHxVdxFQsk0XnrmDBufcmBrm7oe+jrxanCWHq1ljApBHUJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAQR7uvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36E8C072AA;
	Wed, 17 Apr 2024 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395518;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAQR7uvKFT3E4n3LieDUd/BYPPPxmqHpVxP5STP6KQBHtZg/zKcfBLHGSZF0zRVrj
	 LU9CKZPlWGHRrUk09xrbCg8bY+89jyRwIbBklZRawr/mkRwQW8XVqDFCpthGvBAG3B
	 YhVw0spm/vBkm7YrhDVDQWiolf0apruyfwXo0KCk6yhFF0MPs49yw/2F9xOiPobuXo
	 xDVhyDyBnuAOO8iq7eTPXCUU+Qqphk2c1qejNmzwODaVnFQYcrQ5kRYY3phdQd7xM0
	 RHC11u/IXIu0VcEmPKT46zZ1Z/au6UhY6bPwYAWBbpoK1hceqkTu5/iDoTnFslYnbf
	 06cIl5XMZCyCw==
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
Subject: [PATCH net-next v3 4/8] selftests: drv-net: factor out parsing of the env
Date: Wed, 17 Apr 2024 16:11:42 -0700
Message-ID: <20240417231146.2435572-5-kuba@kernel.org>
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


