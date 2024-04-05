Return-Path: <linux-kselftest+bounces-7248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2689934A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 04:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF9B1C2245C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B61803D;
	Fri,  5 Apr 2024 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDcB1IeA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951B17BAA;
	Fri,  5 Apr 2024 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285134; cv=none; b=GuOPbreBd6+bCp3rOSyapngnWSQ7kHdhQH2nlzDwkn9Moy7e7Y1x1A/d27Gdfuhe5lJVEc0pfa8nbY6wjUxP/uUcEU8h94EO9q1F0HhamFU5rx9g7k6J41PouVEXBuI1F5+0+cI0FWLzf37ypuFTOjNo5pqBe9+0eTg0KJ5Maqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285134; c=relaxed/simple;
	bh=IvV+aDZV9LoDJKeFJ1Ku34Z4N3M29tyMD6RuL09yyoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE9++DTTpPN/dVBo0lvwA1vWQYUhdxTkYzTulC/5X5TZvk4kR5Aqgnt+063dX22XESNs6jPbckjqMHLl++zyMVdtTb8pdh9oRBx+LrwrAfqtLxQDVt9Z32XVqWd1dFRQ5goKPOqpLW376EBdzAd/DvFpwSbowRl9tFMX7GRNoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDcB1IeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4955C43399;
	Fri,  5 Apr 2024 02:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712285134;
	bh=IvV+aDZV9LoDJKeFJ1Ku34Z4N3M29tyMD6RuL09yyoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDcB1IeA03Bu8noSy2z6U3BLh8W7kOBZSS0UcgZQBnpjWBytfaH6UVNs2QMwoNJRz
	 BFwdu1ytU5BwOZ1T8TednGteeSByxtxNl82uh8AdhrpWWK1JJKnbxGxR4JAWg04jtF
	 EzKHTKgImJnv6sK4QA2JfUTp1dDJFJcvMOdy8cLmd80/6NuPgnh65pViStIfxX9RbC
	 3Q1Z06JbtjSwa4Z3oIOrPwX8qDHh3opL9gKUthsW7t7bYEmCgdGtQyhU/B5KSFj+xU
	 GQSE8yY0vOiORrkK3PQeND2zSV0bj0WgfUNlRw6qr0Uq4zKDgJ7VdbxUFtyGka9EWP
	 JNwTWaaTaRFdQ==
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
Subject: [PATCH net-next v3 2/5] selftests: nl_netdev: add a trivial Netlink netdev test
Date: Thu,  4 Apr 2024 19:45:23 -0700
Message-ID: <20240405024526.2752998-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405024526.2752998-1-kuba@kernel.org>
References: <20240405024526.2752998-1-kuba@kernel.org>
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

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - pass family as argument

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
index 000000000000..2b8b488fb419
--- /dev/null
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -0,0 +1,24 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily
+
+
+def empty_check(nf) -> None:
+    devs = nf.dev_get({}, dump=True)
+    ksft_ge(len(devs), 1)
+
+
+def lo_check(nf) -> None:
+    lo_info = nf.dev_get({"ifindex": 1})
+    ksft_eq(len(lo_info['xdp-features']), 0)
+    ksft_eq(len(lo_info['xdp-rx-metadata-features']), 0)
+
+
+def main() -> None:
+    nf = NetdevFamily()
+    ksft_run([empty_check, lo_check], args=(nf, ))
+
+
+if __name__ == "__main__":
+    main()
-- 
2.44.0


