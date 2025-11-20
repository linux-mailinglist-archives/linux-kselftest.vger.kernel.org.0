Return-Path: <linux-kselftest+bounces-46044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA8C71C8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D25574E4FEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA6285CBA;
	Thu, 20 Nov 2025 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohdLVT8P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCD285C8C;
	Thu, 20 Nov 2025 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604646; cv=none; b=JK36ExhmqKNu8XAgr2qa1qFPMYwiaziOmjor8cRpKcvaHKxDDrEfrPJ6DDdcr4EsYQUo5strWJ4hqUu+DOE3oRq1X9yWaVxBihlv6aQCQ5DrN+5n68akB0Ln2CGm1WH3kJZhaX54CeT1G2SlYqrTUwO5sW9Zn9JaW1Fm/WFjOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604646; c=relaxed/simple;
	bh=x9im6RmSm9imxk9gjHDW/5RBniGB2wRL3GlrUoqx4c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUohLsArWvy7eu7g/oeYgYPAKWV1Qx6EL8qvcX7a7XLVJR5GbyNvBylHC0EMd6qmnz0iUyelNQXy0PYzi4hEfFEI+ktNIAnNhk4QyDeqQzjRB6NMK1Xstk/kNb8x++fLIJX4tZCGlYZifrdxTp7TxozHZYgnFnPRmFuVq/W/s8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohdLVT8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24CAC4CEF5;
	Thu, 20 Nov 2025 02:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604646;
	bh=x9im6RmSm9imxk9gjHDW/5RBniGB2wRL3GlrUoqx4c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohdLVT8P88Kpj98DDlvMF51wqHiy9K+Wh69DSevWcSQqKi/1l/f5jMIRV+QWdxS45
	 i5DrGKABSyetqD0DS37gBqBand12sKdEl2Pg78Di/921pci51K4PaXw7xwlrPQLvNS
	 l/8lJeFSKW51YYXYCgc68jem1TqN999cR0SQsE7NwT8Rwgt9TmolUmGbdxwBjsRLAL
	 o9Z/fD21S5sNV1s8Je04OxZ/zOJ+kkKfvAy0gM0NtDtWvLdhIPNS7JDcRGEF9vCRLv
	 gL5pDqNcyQ+d4maVVdRWQJz1cZQ865Rk2lJhay1i21zpHhheTB41fWP3MzooNgms8v
	 w+xm/TLu9fuzg==
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
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 07/12] selftests: net: py: read ip link info about remote dev
Date: Wed, 19 Nov 2025 18:10:19 -0800
Message-ID: <20251120021024.2944527-8-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120021024.2944527-1-kuba@kernel.org>
References: <20251120021024.2944527-1-kuba@kernel.org>
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

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
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


