Return-Path: <linux-kselftest+bounces-8893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433CD8B2D0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 00:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA581B24F66
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D78156242;
	Thu, 25 Apr 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnJc7q9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E1156226;
	Thu, 25 Apr 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083825; cv=none; b=e9MPLspgDV2+jMIjJvUT1F8L8yc1eYffLib6ChZT8xIHLAfYLS2hn9L/9hkMUHOHTqfLg2Z6Pcjec2tLA+RD5V1H6x594gTLQGT/M3ZlBnBmZr43cdeFprK0MlDkBJT7ZDSMjiVjteI9L+9CuCkVUAIyQMOkN3fnB0EbR+Hnafc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083825; c=relaxed/simple;
	bh=gMri0/2HbfqDkBXyRafH3fexR2k3G9Jim8h87K7dtds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo5/VpvGvbKnO9IyuDNpIT8Hs8MFkuW3V0Y4mzzDhVqtCa5yBe4XNTsugzel9Sdi01AhM2ehc4g+4sYqs9lpU3d4gqmxIBL8evnPAtVoNTETSbhexReG4SJa1Xopi9iKh1TeAA41ah+WyiqwF+HV/RsMOlcZt6Ydq3LmcuEWNbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnJc7q9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9376C2BD11;
	Thu, 25 Apr 2024 22:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714083825;
	bh=gMri0/2HbfqDkBXyRafH3fexR2k3G9Jim8h87K7dtds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RnJc7q9aZlMGQK76SksSegiMjPGaW4kfzq8yMJVlIxfGvPKQvNcMx4H1W//0D/1Fb
	 xWed616phaOXHDaDvghnpz3XUpvP4/eMkYaS2YiVCvGFDlhYx/hCSznjN5ZCAMUeN0
	 LuaekwLGk0sNYwCXHLlP+lkLcUbc3kzS1Lmxp/q2QaDLpZcdwYUXQvhAE1R5JSQ95W
	 5LKGcm3XDkmoKq6y1YsMR49xF89Fy6u9/KGeCd4Xb2ghwlVIo68jzZ324Rlqn0/4/c
	 RC4a9jypDLwCI82CV/TySYTW1QM7zm7vX5ZIb/sIaa/D3mppNn3nSJsdgSbqcktZAs
	 QNKAkZK+Zuw2A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 2/3] selftests: drv-net: reimplement the config parser
Date: Thu, 25 Apr 2024 15:23:40 -0700
Message-ID: <20240425222341.309778-3-kuba@kernel.org>
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

The shell lexer is not helping much, do very basic parsing
manually.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use split() to split the line on =
---
 .../selftests/drivers/net/lib/py/env.py       | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index a3db1bb1afeb..6f57bd5c0ed7 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import os
-import shlex
 from pathlib import Path
 from lib.py import KsftSkipEx
 from lib.py import cmd, ip
@@ -16,17 +15,20 @@ from .remote import Remote
     if not (src_dir / "net.config").exists():
         return env
 
-    lexer = shlex.shlex(open((src_dir / "net.config").as_posix(), 'r').read())
-    k = None
-    for token in lexer:
-        if k is None:
-            k = token
-            env[k] = ""
-        elif token == "=":
-            pass
-        else:
-            env[k] = token
-            k = None
+    with open((src_dir / "net.config").as_posix(), 'r') as fp:
+        for line in fp.readlines():
+            full_file = line
+            # Strip comments
+            pos = line.find("#")
+            if pos >= 0:
+                line = line[:pos]
+            line = line.strip()
+            if not line:
+                continue
+            pair = line.split('=', maxsplit=1)
+            if len(pair) != 2:
+                raise Exception("Can't parse configuration line:", full_file)
+            env[pair[0]] = pair[1]
     return env
 
 
-- 
2.44.0


