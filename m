Return-Path: <linux-kselftest+bounces-8967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB81E8B42B4
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 01:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EE6B2140E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3523D552;
	Fri, 26 Apr 2024 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdnUuhQz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F43D0C5;
	Fri, 26 Apr 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173845; cv=none; b=SyPhez/UCGF+j7UrMfiQf7TAHINBQ2pFjwTh7JpXmboc49UqSbPx+2gJ+qH9psAxnHKZeqsU3hOT2ammZriv7NMcrQBA4C7UxVMt1OueEfRFI+KiOKJ2zvNmmTQS9QY28MdJxAxIXRxvvRYpABtiExVnODm4YQusKAi4iBIvW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173845; c=relaxed/simple;
	bh=JeQ35s6yBVRaqXvMkpIQzzUCCOzpP8v/SETOU7be0NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUyf17TaktCfGuDG6plHHceOmYdkzpo0MPb4G9NetvRLR/uu1z1lyf8saCyKRq4QjAV6kq3SfC7gKKdtyt96OzmXDp531mEqfrISSrQ+4Sa2j30Rw91SfkKL0fmh026mf3ZvZgqcaCwLvsMPK9imhU/1a8dRRMU6PgL4bdIOVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdnUuhQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBECC32783;
	Fri, 26 Apr 2024 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173845;
	bh=JeQ35s6yBVRaqXvMkpIQzzUCCOzpP8v/SETOU7be0NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdnUuhQzYNNkUdyy/FuZ8rGUOGKQpRGs8lGxvM2jvlan2+eTdOOxsOiFIrA/MWzAp
	 48BOgPuZYv5kerFtPvzpPbaLW4hwSjev2UnyYe1+ah1OjbphubS8jkcAG0cznXvtQx
	 oP2U4UxlsHLK5CBr81g1x+do6gCnbQPdhes008pPlSdCbFbYRLleXzsmnGnXiAiu4i
	 KHEjNFC8jgMPWyXcLjxnubu2bkAHWLUH0gCkHtMtrWCMj5xk4xw/ku2e0wPOIDN6Dl
	 priG1yLlZk6j8As+YQe/ptk9gJwvucEiAakdZ2C+db0vwismGTQE+J2lYGwDpi3JOQ
	 aaE4e+FolUA+w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/6] selftests: net: py: extract tool logic
Date: Fri, 26 Apr 2024 16:23:56 -0700
Message-ID: <20240426232400.624864-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426232400.624864-1-kuba@kernel.org>
References: <20240426232400.624864-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main use of the ip() wrapper over cmd() is that it can parse JSON.
cmd("ip -j link show") will return stdout as a string, and test has
to call json.loads(). With ip("link show", json=True) the return value
will be already parsed.

More tools (ethtool, bpftool etc.) support the --json switch.
To avoid having to wrap all of them individually create a tool()
helper.

Switch from -j to --json (for ethtool).
While at it consume the netns attribute at the ip() level.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index d3715e6c21f2..11b588a2bb9d 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -56,10 +56,10 @@ import time
         return self.process(terminate=self.terminate)
 
 
-def ip(args, json=None, ns=None, host=None):
-    cmd_str = "ip "
+def tool(name, args, json=None, ns=None, host=None):
+    cmd_str = name + " "
     if json:
-        cmd_str += '-j '
+        cmd_str += '--json '
     cmd_str += args
     cmd_obj = cmd(cmd_str, ns=ns, host=host)
     if json:
@@ -67,6 +67,12 @@ import time
     return cmd_obj
 
 
+def ip(args, json=None, ns=None, host=None):
+    if ns:
+        args = '-netns ' + ns + " " + args
+    return tool("ip", args, json=json, host=host)
+
+
 def rand_port():
     """
     Get unprivileged port, for now just random, one day we may decide to check if used.
-- 
2.44.0


