Return-Path: <linux-kselftest+bounces-8894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794838B2D0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 00:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C9C28255B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889115666F;
	Thu, 25 Apr 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFKD8Pmv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45D15665C;
	Thu, 25 Apr 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083826; cv=none; b=JJO0lC6Wvv5/xGzU0fVoMbSLXDGKetn+iN3OM0hMara8sAUwW5qd3pbKYmYZEZd91Iqtt9TeRMq12ZTZUsDycHiLPT6hQ3ItVyFCwHdbtcZVTbjJymNTKt65FZIbNR4Sm4luNwGFxDiTiAcRFLgBisW+BTwTqm2tQ8GjsclG6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083826; c=relaxed/simple;
	bh=yIhLkmj1LbR7a0JWHfGMmeLybevbTRq425qq1r8AFhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIwO/ZzjEjW3DRHgjako9auirfIuvgTqp/+IxiZ1mcA1qgV245lKChdJ0ck03xtyKIh2qTpgM0b7seaC0k8HN7lB0hazVNL08FvW60kPYEVXbwfqkZ4jNyicLXHn/nw4xO0ZbYSnLTwmut9RFPANANC8L/RbreTyDGNbKQCm0ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFKD8Pmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBEFC2BD10;
	Thu, 25 Apr 2024 22:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714083825;
	bh=yIhLkmj1LbR7a0JWHfGMmeLybevbTRq425qq1r8AFhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFKD8PmvKpzHiBk7nC7VRU9zo0Bxkcq3uCO5uXOoXieGeRKrjwfhbjF3T6kAIDDDt
	 jbFZ07tUWtb2PI8z3XtYjYzau3QHKA6N6vjR6XD+AsCwKOjFtz37pgnyMtHxLJraSa
	 79f/bcLtbQSr5ZNq79/8YzppsHldMgz6ZO/tpERqAFYxefoxF55EGjYIvWAzNkT46Z
	 K+QRD269E2NbWtXOPMSd6pgBbwLcV2FwFXGCGk8Uxb/W1QSAdpa+zVTqHIkj8dPca2
	 fx2PpH+KOb4K21u9G6TeJ/b+X71dzI1BA8abCxTno+6yxzZVgJfu/CsL/S1WD4PeFL
	 0rO/pp24SQqUQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 3/3] selftests: drv-net: validate the environment
Date: Thu, 25 Apr 2024 15:23:41 -0700
Message-ID: <20240425222341.309778-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425222341.309778-1-kuba@kernel.org>
References: <20240425222341.309778-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Throw a slightly more helpful exception when env variables
are partially populated. Prior to this change we'd get
a dictionary key exception somewhere later on.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - check "both or none" for addresses
---
 .../selftests/drivers/net/lib/py/env.py       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 6f57bd5c0ed7..e2ab637e56dc 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -88,6 +88,7 @@ from .remote import Remote
         self._ns_peer = None
 
         if "NETIF" in self.env:
+            self._check_env()
             self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
 
             self.v4 = self.env.get("LOCAL_V4")
@@ -143,6 +144,30 @@ from .remote import Remote
         ip(f"-6 addr add dev {self._ns_peer.nsims[0].ifname} {self.nsim_v6_pfx}2/64 nodad", ns=self._netns)
         ip(f"   link set dev {self._ns_peer.nsims[0].ifname} up", ns=self._netns)
 
+    def _check_env(self):
+        vars_needed = [
+            ["LOCAL_V4", "LOCAL_V6"],
+            ["REMOTE_V4", "REMOTE_V6"],
+            ["REMOTE_TYPE"],
+            ["REMOTE_ARGS"]
+        ]
+        missing = []
+
+        for choice in vars_needed:
+            for entry in choice:
+                if entry in self.env:
+                    break
+            else:
+                missing.append(choice)
+        # Make sure v4 / v6 configs are symmetric
+        if ("LOCAL_V6" in self.env) != ("REMOTE_V6" in self.env):
+            missing.append(["LOCAL_V6", "REMOTE_V6"])
+        if ("LOCAL_V4" in self.env) != ("REMOTE_V4" in self.env):
+            missing.append(["LOCAL_V4", "REMOTE_V4"])
+        if missing:
+            raise Exception("Invalid environment, missing configuration:", missing,
+                            "Please see tools/testing/selftests/drivers/net/README.rst")
+
     def __enter__(self):
         return self
 
-- 
2.44.0


