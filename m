Return-Path: <linux-kselftest+bounces-9026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F59F8B5BB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5101F20EEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D9F80624;
	Mon, 29 Apr 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRJsI3rF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89F80603;
	Mon, 29 Apr 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401874; cv=none; b=hxQSOKrT8qq8gpCJ9nrMmVMtzObN9AWkVz3qK8grjHbitZiQZokblmY/AOjQia4lVxHuQ/owHBrvakzYIFEIWQWU59covZdj17y03ecgVaNyHrwE/ufE7pp6lZoSvErleC8r6kT7NRiFO3bIcM2dyNpXxBbaxo/Z0ATiL3gblKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401874; c=relaxed/simple;
	bh=6jqd5U+F65l8v2GGjV8nPwQfU+VslA3x6+xTZifk+uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBNYnUBh1x5idJhUOfS/Jy5TpCqLIUbyn5cJEQe2Rp4bNQ5pE7AqVcP00bJGqTQl4p1exTwVWK6+nt4PvJyTxdALTIYcG7hkgJatB8j0yGl1QBsEVSXMQGFnxU1kOd7HesB7yy/tLuieVu3xJTdi2rh6gRcIsjLWcpS55dPR0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRJsI3rF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93751C4AF1B;
	Mon, 29 Apr 2024 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401873;
	bh=6jqd5U+F65l8v2GGjV8nPwQfU+VslA3x6+xTZifk+uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRJsI3rFs7z+B3TDyYNYxFbUYeFhNmmG7H+Ss6UBnWUoY4nyU3LXqoj6OOYxfe5U0
	 SFIvvm28VVI2ESFAMFFG7a4xgWQzI8w5L1afBBporFsg4gLsz0w+/FvrMJ2/WYIkbx
	 K+1/3G0vGcgyohS7U/FMOjf+E7w/5INm2ntKXaeNGjPdyLuQM7RHCPK7juflHDOI6+
	 FySFuHrCbNjSkgis0XriLpXtcMKTLEiclDKTXGbabs8TDwa6N9huLZioKp1ytjMPFs
	 jOVvoLwLdqVRqEvtsKKCHeasZXBxlVJt2APjny0Iyfj7JCkOfxgN00MFX34YcTuiAE
	 E8VPo5MrLBkEA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 3/6] selftests: net: py: extract tool logic
Date: Mon, 29 Apr 2024 07:44:23 -0700
Message-ID: <20240429144426.743476-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429144426.743476-1-kuba@kernel.org>
References: <20240429144426.743476-1-kuba@kernel.org>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use consistent quote type
 - use format string to force string conversion of NetNS class
---
 tools/testing/selftests/net/lib/py/utils.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index d3715e6c21f2..4930a90a64ea 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -56,10 +56,10 @@ import time
         return self.process(terminate=self.terminate)
 
 
-def ip(args, json=None, ns=None, host=None):
-    cmd_str = "ip "
+def tool(name, args, json=None, ns=None, host=None):
+    cmd_str = name + ' '
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
+        args = f'-netns {ns} ' + args
+    return tool('ip', args, json=json, host=host)
+
+
 def rand_port():
     """
     Get unprivileged port, for now just random, one day we may decide to check if used.
-- 
2.44.0


