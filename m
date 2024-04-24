Return-Path: <linux-kselftest+bounces-8821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8BB8B15F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EFA284441
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3ED16D4EA;
	Wed, 24 Apr 2024 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq74QV7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CAC16D32A;
	Wed, 24 Apr 2024 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996892; cv=none; b=uN6U07zdKGxI/PYajtxOd5EhyST9IG/4oJ8kkU/u2qDxKfhLV/ZGfYYyKAIvnm+KwwwtXS7M1h/KHNIItEy5RgI7VEX4faADmHYt6UdFT+UIAJ2E2S9iM64Qj6JGi54oKGSfDvmaEgpGCP3YoYVDUJh8oWhh1Aqdu37qUOuurFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996892; c=relaxed/simple;
	bh=fhHMUm9DEAJsvgFZ3Tc+NqLDyywCnTct5uhYXaxImII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qloceMJ/AilGvrfmNR1o+CLsy8/AV6DgSgZa+K/f//7gbCTGTk5/yc8WK51juln7UWfH2WdO++vwEjM3PX2Jjg8IesIKesoxCIejJfYnYvCOtPqwza2l1tw7qin1YbJEtSF4qrmOGAjA/vNe2EYRQYBitYZdWx4cXIwtlCQUN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qq74QV7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF6BC32782;
	Wed, 24 Apr 2024 22:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996892;
	bh=fhHMUm9DEAJsvgFZ3Tc+NqLDyywCnTct5uhYXaxImII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qq74QV7QaA+P7VH6kTfIQVYF0WNg3MLBBNunDrv18CAfhcATu+w/PzKJj59gtCuqn
	 8mJyJvafW2jK0HENKiuFseRHejBYYll3J23E8nj5GGQZRRibbqkLM9vPAn2Jv1N+so
	 xaV7AoSQCrjbJ9co1o0J5+blYS54N/7v1MGjdD5t0AA+BW5ccR0LnHukKMclEqa1QZ
	 0y32U3G5YcyZec7/Z3MUMCrP/kX0vV1z85SnrXfCDO6S/FVHYLd+PLMQSp4N9Ck99F
	 U6K0HCLM+YR8xR5jRZZ2PQh3Muqr6XbJjUPcMTEwdqxT+kCbUxqRGT0HHErqYgRkMv
	 i1M+VRMpsx8GA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] selftests: drv-net: reimplement the config parser
Date: Wed, 24 Apr 2024 15:14:43 -0700
Message-ID: <20240424221444.4194069-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424221444.4194069-1-kuba@kernel.org>
References: <20240424221444.4194069-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shell lexer is not helping much, do very basic parsing
manually.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/lib/py/env.py       | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index a3db1bb1afeb..a6a5a5f9c6db 100644
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
+            pos = line.find("=")
+            if pos <= 0:
+                raise Exception("Can't parse configuration line:", full_file)
+            env[line[:pos]] = line[pos+1:]
     return env
 
 
-- 
2.44.0


