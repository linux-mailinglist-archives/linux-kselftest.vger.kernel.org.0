Return-Path: <linux-kselftest+bounces-6965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35A894894
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 03:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB2B1C22203
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 01:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E23D53C;
	Tue,  2 Apr 2024 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn4YOBaT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D7D530;
	Tue,  2 Apr 2024 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712019942; cv=none; b=fYReej8cQfcex9IDU1mx+oh7eIbD9VqaXbTP6fd7x9ApPuRQh7QHB/KiBIr73VtAtd5Eh26jnQjnyLeDaRZOPeD6DTMwaytoGw1kk4rAe2emO3FynB2jrhp648UdXkvAznUJSVJ2Cfs9dgbHwM6zs1u2h1QOETtK1phmNuSB5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712019942; c=relaxed/simple;
	bh=e738ql/dcNvxSZzrbxZnMLoXdMlLsFew81kY5MkzfRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0qY7908dem/R+EI2nEMXoDOf7QzKZGjoThKO/NIenz6Uqiu91Hn00Z8gEJizWMJCnyw3yxZgXmZt+Lf4kV5oGdry2SxnKu3Rvkhav0b4YCixLxraqDNnLLjRSAiDiOSL8dQwpkUocdNtdkTPb/5hDVHjPViNn3J508NFVtulRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn4YOBaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9A6C43390;
	Tue,  2 Apr 2024 01:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712019941;
	bh=e738ql/dcNvxSZzrbxZnMLoXdMlLsFew81kY5MkzfRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pn4YOBaThzOJu5TyKthc4sC3yewky7tamDpCgBeLW11H0pfa6yH75yu+4yqM9lSXd
	 yCLwTzAkbnkzi32JHyEH8BAOqiNtY0ct9x6tyHbmcx4fvjnXIkY/NBLRBWvjy8UMcI
	 W2dDLemwBd7ny67hjwdPzJs44i+hHoxzW8fEno5wfYGxRj4UP2+s8s2pd5ru5V+WUX
	 945rln1gxQlRhu68ucYVERAiuDGUAf0zHy+AYt9jKnOXmT9fb/v6dL3amyUI+aygky
	 k/HvnNu6+8hkUcCB31PeVfVbKpkfcrI6azGJ0ADUnLj0MwkQVirEdBGbGNLALMtwFJ
	 Mld1411oRJKCQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	donald.hunter@gmail.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/7] selftests: nl_netdev: add a trivial Netlink netdev test
Date: Mon,  1 Apr 2024 18:05:16 -0700
Message-ID: <20240402010520.1209517-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402010520.1209517-1-kuba@kernel.org>
References: <20240402010520.1209517-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a trivial test using YNL.

  $ ./tools/testing/selftests/net/nl_netdev.py
  KTAP version 1
  1..2
  ok 1 nl_netdev.empty_check
  ok 2 nl_netdev.lo_check

Instantiate the family once, it takes longer than the test itself.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/Makefile     |  1 +
 tools/testing/selftests/net/nl_netdev.py | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100755 tools/testing/selftests/net/nl_netdev.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index cb418a2346bc..5e34c93aa51b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -34,6 +34,7 @@ TEST_PROGS += gre_gso.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
+TEST_PROGS += nl_netdev.py
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt6_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
new file mode 100755
index 000000000000..40a59857f984
--- /dev/null
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -0,0 +1,24 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily
+
+
+nf = NetdevFamily()
+
+
+def empty_check() -> None:
+    global nf
+    devs = nf.dev_get({}, dump=True)
+    ksft_ge(len(devs), 1)
+
+
+def lo_check() -> None:
+    global nf
+    lo_info = nf.dev_get({"ifindex": 1})
+    ksft_eq(len(lo_info['xdp-features']), 0)
+    ksft_eq(len(lo_info['xdp-rx-metadata-features']), 0)
+
+
+if __name__ == "__main__":
+    ksft_run([empty_check, lo_check])
-- 
2.44.0


