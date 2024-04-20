Return-Path: <linux-kselftest+bounces-8525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF08AB90E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5421C203AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78F0E57F;
	Sat, 20 Apr 2024 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYejC5DY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DBD52A;
	Sat, 20 Apr 2024 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581561; cv=none; b=RPANyCjygDEvcBz0h0Qz5A286cWoWlczZ/MwJkA+iyDEhp6n8yFTYBNETYJTmD27gpyNXWV14J5IEKGLo0qc6SlAvcTiTdFKTbT6THvmD+WJaRN+lVB+GBmYYI1qAAVSmid8CX/O8vvho2gaQGTvMyzClQ+tP1as/EMwJ5lNTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581561; c=relaxed/simple;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrHBYE/Azjk5QFMSJOkvWLzVqZ+MI/hBdNiMRS0KayDR3IbszzaFlOWuZhf4Ddfl5hOuTIOtHwiHsl6OVJAx9xZ2iHUu7Adaba5oOESuwmme6HCDxhqVNCr7ur7GMZp2wmIre22sd6FAAyGl8+RcL9C9GySbK8EHkuQAef2h3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYejC5DY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197F7C32786;
	Sat, 20 Apr 2024 02:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713581561;
	bh=U5+EVNFryCl6AbqRDTDECqncYZkgnEzOhvv/pOI/KNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYejC5DYo9XJevwDTlKVoqiUd51VDKiiiDBiwPIAt0mlvSIeEG1l7Pp8Id2kaKYGB
	 hZqZFC39fLu7ICKLkoXl7BSr0Y6lEwql7xd30P+W0oOmXz2zMt9QGLNgN9c7PrwQm6
	 oyanIlTHbiT9orTDoMR/55afMIvHiAsQfffnbvFn5q+69B7njB65SMOrbOZK8Qet1T
	 +Ci8SN1EI8mcxKv1pgHtlHeCsSiI5PxP4BYylpEgueX18qHQ0+9FIH0JQSy+0pVGkA
	 FdarVxIPBlrO5uARbhtmO94wJAPG6tvW0QlkRtGqcIW1wl9cHSS5/LsDRCPUxnrT4m
	 HmEHlcH3oMekg==
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
Subject: [PATCH net-next v5 2/7] selftests: drv-net: factor out parsing of the env
Date: Fri, 19 Apr 2024 19:52:32 -0700
Message-ID: <20240420025237.3309296-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025237.3309296-1-kuba@kernel.org>
References: <20240420025237.3309296-1-kuba@kernel.org>
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


