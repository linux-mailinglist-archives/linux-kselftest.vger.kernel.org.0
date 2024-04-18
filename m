Return-Path: <linux-kselftest+bounces-8384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4D8AA5E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 01:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DBE284953
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C17B3FA;
	Thu, 18 Apr 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d81ZiJjI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407379B96;
	Thu, 18 Apr 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483531; cv=none; b=OtHrEU44sNJiIC5AaOeRQ1PrrdZCzr8bzcFXhCLXcpGR6gzS+7na6d6HiFqHnbBzn3RV9HJ5+3Rn+hYKHNUiIOdApYk1coJS2Y/yGscDcwEpsKDpay/wmPAsKYUc+11iVhvTKsZLvBei30WZEfLllEQRSzUXJvWK2P4z2RHa3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483531; c=relaxed/simple;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avGoh97eSuo/USVo1jr7FeFBwodfe1nmyamOnDkinSGyWdrGXn2dtDJidhbTGVnAmzMVCOFlrMV/G8mLZAdqrn2XcXwXc4qkrUIGyU1m8Rz7dypSq8BLwZn8T6opH5n8892eVJyzT2skO/t5Dzjv8wyRMMr/CzEhh1mY7qYaPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d81ZiJjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D032CC32781;
	Thu, 18 Apr 2024 23:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713483531;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d81ZiJjI4B0kTsUCc8RXTi+4BefSMrM0D01lQAgXhaQiKwcpjgceENTQfIG/TRVIO
	 bbFZvdoP6QbhVMYG9ex7WpildHhGuDvZSFEjTHhkm8+TP9vo/WsTntvurXlZ2+Ag+i
	 QnEyHXMVm7+H2AjuuUMjcyZCVWE2IdoW0Ie/tq0dXnjpqLsISSOQRk8WrAxcluxtWl
	 Hipzu9IQZ4miAeEBBsw+d6zoHaGdK5rJ1UwOblXiwkHoOsDt/MiN47g69APqaoCtj8
	 bOd2/+YHmabuDU2L1e70mUtytgb8l4hrLBsaNaYBha8s1AU4YLlQ4HmMrdOGbJs6wc
	 mdzDs5qV7rjqw==
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
Subject: [PATCH net-next v4 2/7] selftests: drv-net: factor out parsing of the env
Date: Thu, 18 Apr 2024 16:38:39 -0700
Message-ID: <20240418233844.2762396-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418233844.2762396-1-kuba@kernel.org>
References: <20240418233844.2762396-1-kuba@kernel.org>
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


