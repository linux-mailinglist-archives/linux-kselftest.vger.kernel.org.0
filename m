Return-Path: <linux-kselftest+bounces-45925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7CBC6BC7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F691368357
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB613126B0;
	Tue, 18 Nov 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxHXZk+4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350892FABEE;
	Tue, 18 Nov 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502726; cv=none; b=Jc7OfxsUxuC2TNnXanz5IdCgMut4lyaGvlMWd6rP7DS4h+OBRZ2nmP5JvksMxqr5sLziuaYv1veqdfc0B36QLgWXVxdGOa6zYslay4VTQH1DWcpigzUHRsSQ2tk6aW8dOHHxuM0GkAZWn+Y9jY/zC2jpp2mh/j11iQcalWotRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502726; c=relaxed/simple;
	bh=zJuilAMBCqK8irESZmDZAvqwvT0FFeBdoMmHsxTCLKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u87V5BIfRXebRXPD3dkw78tT5v5GbvxUO/utDAj+JrVnmw20Q/LwGphx1UKjcocs3bIU7vuShEpOFDRRdbZkAWh1jxoDkE1npxPsTK0eWPk+upiz1tMXzxk+D41APw0wGv7LwH1fdhjpz4JjWcu3v7q2T0MItc+qr0MiQN4wuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxHXZk+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BC3C4AF17;
	Tue, 18 Nov 2025 21:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502725;
	bh=zJuilAMBCqK8irESZmDZAvqwvT0FFeBdoMmHsxTCLKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxHXZk+4fI0DWFyceivn1nXoMbIqRlHIJ54VkGwBnJUz1QUX4g0YcsiUUoEVGi86c
	 nY8R7LaUFhcjuNe+IWx0rFW9evNmvve7WX6TeF1Q4PUshsmUrRMgV8QsQ2xDrJRUuk
	 EsHAI4pNQNsn5g9vmzl4TfLz4xtYI7qLYEDAcGWdI8rA3PtUhvygDC4a734MRj5Zc0
	 9D3WAMioxO9zAJFK0sovc1TJ02d5bZ2lkRWdSTijnq7rnE+TQQR3XZGjzQts0+77Tt
	 q+RYVsUl2XiMNu1rTbOIkdGvHLI5oHv/pIeY70VynfPjDGSVNYw5xzuJj7ggJp29EI
	 xf1SRq0bJnhrg==
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
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/12] selftests: net: py: read ip link info about remote dev
Date: Tue, 18 Nov 2025 13:51:21 -0800
Message-ID: <20251118215126.2225826-8-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
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


