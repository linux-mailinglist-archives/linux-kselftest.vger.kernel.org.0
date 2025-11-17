Return-Path: <linux-kselftest+bounces-45788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A98C662C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7E2B72977D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7534D39A;
	Mon, 17 Nov 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUTose0Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6C34CFDE;
	Mon, 17 Nov 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413117; cv=none; b=IM0D+ko4zabGnqphKZx/OZ5IggDsg7dKxPrv5MJeQvI8AOpYz/1ZCpqQgIFdi42eSxOtil7t/QK+1ocyj0btX87lUUjmpJnsXBsNkjfj7/IFlPiJ99hgd4FoG0eqGjvxHDNzcOB/YqVSpXzhio13jIR1AvsatM+xWB3AAj+lfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413117; c=relaxed/simple;
	bh=zJuilAMBCqK8irESZmDZAvqwvT0FFeBdoMmHsxTCLKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar/zBZWUuwWdnkW5TR9yDd1x9eKJbq0qMARWyi8nuGV6S2zUNZzao37A5oqiQqNWHUUY8LzBwYdqWik0Uqq8mYtKGuiuJjquYLnBGbTsxbl3g9IievDEhKCMGCDSv3ynf1CJ/UOenP7VGo0XSe7edjQU7ChHEFW/WqtE4YNjoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUTose0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C34C4AF1C;
	Mon, 17 Nov 2025 20:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413116;
	bh=zJuilAMBCqK8irESZmDZAvqwvT0FFeBdoMmHsxTCLKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUTose0QKJPWuHZ0KUZFrrdhZqwwOQEYWQu9DUPe7onPOgmZ8QMvuqAWRNZgUCcnw
	 uXFUZdG9D9mwhuyGM9jRORtb5+JLMxGRGK7aPj3KqbEFfElcOToQsGyNjx8qFF1lsi
	 QtZ0z93PlhaCgMpXjwOxLjQcJbzvaYpIpOX6fXibqDUMr0aDq9V1LVDlJKTIUkSnz/
	 4SMDwOlQ05v0t7AlDhu3JkH6op4iCp9gSih4OZh94+Utylif84n3TaeKrDkQn6WPar
	 4rk9iJ+OQLp3YdoiqZ2jk+enrgTmm6KJEXg+ffHd7yhPJl16iTMDuQZtr8MXsw6IAG
	 gIexSX3juunRw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/12] selftests: net: py: read ip link info about remote dev
Date: Mon, 17 Nov 2025 12:58:05 -0800
Message-ID: <20251117205810.1617533-8-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117205810.1617533-1-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're already saving the info about the local dev in env.dev
for the tests, save remote dev as well. This is more symmetric,
env generally provides the same info for local and remote end.

While at it make sure that we reliably get the detailed info
about the local dev. nsim used to read the dev info without -d.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 2 ++
 tools/testing/selftests/net/lib/py/nsim.py        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 01be3d9b9720..8b644fd84ff2 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -168,6 +168,8 @@ from .remote import Remote
 
         # resolve remote interface name
         self.remote_ifname = self.resolve_remote_ifc()
+        self.remote_dev = ip("-d link show dev " + self.remote_ifname,
+                             host=self.remote, json=True)[0]
 
         self._required_cmd = {}
 
diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
index 1a8cbe9acc48..7c640ed64c0b 100644
--- a/tools/testing/selftests/net/lib/py/nsim.py
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -27,7 +27,7 @@ from .utils import cmd, ip
         self.port_index = port_index
         self.ns = ns
         self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
-        ret = ip("-j link show dev %s" % ifname, ns=ns)
+        ret = ip("-d -j link show dev %s" % ifname, ns=ns)
         self.dev = json.loads(ret.stdout)[0]
         self.ifindex = self.dev["ifindex"]
 
-- 
2.51.1


