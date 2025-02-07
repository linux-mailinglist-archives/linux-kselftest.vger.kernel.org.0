Return-Path: <linux-kselftest+bounces-26023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD6A2CBA8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D973ADD07
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B811B21BA;
	Fri,  7 Feb 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8p2kAeL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007C200CD;
	Fri,  7 Feb 2025 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953703; cv=none; b=mFx25rcPnkO2I6f0a0WWlkmuC8yYdRiG9cKiZcaKlWJAXh++nsI9xcs6Zo4EyUz/KM4isMSkQpkRuVYllZ732NMxjej1z/+Y+CaEKJzYpbOaVvvgfeSgUZZ5JQs5Qcjz9qtwqgE4fV03t6fylEM9GsUHrB2oHWl8IKGMqbV+BCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953703; c=relaxed/simple;
	bh=3zJXaj3IBjRkrJI5MDEeFM49y/kAOcZD3PfmpDJ29d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kx0Gbqk+USzaTaL652yMVNFHwiHk7JfOYXfLwoaPno2zoi6IjwVbfHN9mEv79AtSHmi4m7d7AmFAWLA6XjiVvgUZvYPrylGpgShkmr2YvmfHNNGZhz1wuWlJEj+LcY8fWB1tF807t/RD6Uz7rpuQdOK118m3G0hxufcAAvhs5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8p2kAeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F97C4CED1;
	Fri,  7 Feb 2025 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738953702;
	bh=3zJXaj3IBjRkrJI5MDEeFM49y/kAOcZD3PfmpDJ29d8=;
	h=From:To:Cc:Subject:Date:From;
	b=I8p2kAeLyHxaVFljDQoXkStUvMD4dZlbiJ1H6xOTqBXDGeq678bygcLW/MmNrw/yO
	 DpB2VjHWnIgcRii1VP/7PUMcloT+58Ys738czSdKIQq3A7R26sOcEL8qACKN/3xqAh
	 /vHc+epOlFHkWcYHxL+xq5P2TX6/HDXRsSOw29EJG2ZGksC16CWzbcsJnopNU+Rdcl
	 RZWx8tbkTVmCL0Wm3cmB2z/jXmFnR/oHVhN0Vzxgc0KK3YbRpnfu74OV8ohwqmNhMB
	 rNKUe8b3wnpPBSSEtsjsl2mcMCl/0ocmVnwOwtFnJoCkalbA9SsVIpl3Ck8jUNEKfI
	 DEGCM9bBCR7aw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] selftests: drv-net: factor out a DrvEnv base class
Date: Fri,  7 Feb 2025 10:41:39 -0800
Message-ID: <20250207184140.1730466-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have separate Env classes for local tests and tests with a remote
endpoint. Make it easier to share the code by creating a base class.
Make env loading a method of this class.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/lib/py/env.py       | 59 +++++++++++--------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 987e452d3a45..2f17880e411d 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -10,38 +10,46 @@ from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
 
 
-def _load_env_file(src_path):
-    env = os.environ.copy()
+class NetDrvEnvBase:
+    """
+    Base class for a NIC / host envirnoments
+    """
+    def __init__(self, src_path):
+        self.src_path = src_path
+        self.env = self._load_env_file()
 
-    src_dir = Path(src_path).parent.resolve()
-    if not (src_dir / "net.config").exists():
+    def _load_env_file(self):
+        env = os.environ.copy()
+
+        src_dir = Path(self.src_path).parent.resolve()
+        if not (src_dir / "net.config").exists():
+            return ksft_setup(env)
+
+        with open((src_dir / "net.config").as_posix(), 'r') as fp:
+            for line in fp.readlines():
+                full_file = line
+                # Strip comments
+                pos = line.find("#")
+                if pos >= 0:
+                    line = line[:pos]
+                line = line.strip()
+                if not line:
+                    continue
+                pair = line.split('=', maxsplit=1)
+                if len(pair) != 2:
+                    raise Exception("Can't parse configuration line:", full_file)
+                env[pair[0]] = pair[1]
         return ksft_setup(env)
 
-    with open((src_dir / "net.config").as_posix(), 'r') as fp:
-        for line in fp.readlines():
-            full_file = line
-            # Strip comments
-            pos = line.find("#")
-            if pos >= 0:
-                line = line[:pos]
-            line = line.strip()
-            if not line:
-                continue
-            pair = line.split('=', maxsplit=1)
-            if len(pair) != 2:
-                raise Exception("Can't parse configuration line:", full_file)
-            env[pair[0]] = pair[1]
-    return ksft_setup(env)
 
-
-class NetDrvEnv:
+class NetDrvEnv(NetDrvEnvBase):
     """
     Class for a single NIC / host env, with no remote end
     """
     def __init__(self, src_path, **kwargs):
-        self._ns = None
+        super().__init__(src_path)
 
-        self.env = _load_env_file(src_path)
+        self._ns = None
 
         if 'NETIF' in self.env:
             self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
@@ -68,7 +76,7 @@ from .remote import Remote
             self._ns = None
 
 
-class NetDrvEpEnv:
+class NetDrvEpEnv(NetDrvEnvBase):
     """
     Class for an environment with a local device and "remote endpoint"
     which can be used to send traffic in.
@@ -82,8 +90,7 @@ from .remote import Remote
     nsim_v6_pfx = "2001:db8::"
 
     def __init__(self, src_path, nsim_test=None):
-
-        self.env = _load_env_file(src_path)
+        super().__init__(src_path)
 
         self._stats_settle_time = None
 
-- 
2.48.1


