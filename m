Return-Path: <linux-kselftest+bounces-7038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F7896289
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 04:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5451C227F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFDD1BF2F;
	Wed,  3 Apr 2024 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY1d4VbA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42C1BDCF;
	Wed,  3 Apr 2024 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111674; cv=none; b=tQ2NkT3TZc1vpNpYgGqhBqXdQ95VsX+aUxX7N4LRgmXc4vd3unR3XkvPn3mx1igZvtzRDh9DR0qsixziWcDmad7gEDXgT8pBW4ceQ8e/oS500e4Y8YZbdgJxQj7psp1gRAd2QMbIyK/7FMT7BleKRK9bnExK2Dpvo+EFhHViCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111674; c=relaxed/simple;
	bh=EyiiYBcuUUYiQXq7o9GvytmkP4Wt7kXoW/sOJCSNOiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDhbwKFilMAzO8h28YnePcEEWlN9PZpCSbRwfcBg5m5hNduPqrlDwaW7BDNu9n4Tg4Q/eIcBq41TVJYxbp7nIrSiYBbmbesPIqHq3/DZwcdYasj+271kRB2WwKlBbx87Ez8br5KZXEfmD4m09Y5tw6q06JclKpHCOS+WuSTxHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY1d4VbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B895C32781;
	Wed,  3 Apr 2024 02:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712111674;
	bh=EyiiYBcuUUYiQXq7o9GvytmkP4Wt7kXoW/sOJCSNOiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JY1d4VbARelsmFaXhSi0XwQMrqj1CchUDtDYq7qZN+hz9QsSKtoPrtFQJKWSAdKXL
	 1rznoO4HfO8BQ3Uz8/3fYt+ft5XXdGZNMaWYREj2mu9tVfRM6icUVe6zE3Oom1wViJ
	 nfNGeftGehTrH7TG7kyAjzv9c6KfjLvmFQ9KftY4+qWbaIWhOJpzDJZ5a2RQENC3w8
	 4EroPfrSwr2QFjL7idKVaOPcu3Xy1ZKCcqQLL2POYvnMfDCgv8Vt5ZYlg7dnx+nI3I
	 WJ7pxq7f/1cBHIMPp37Ml9LHUDk0F76y6lIKNMOTNfw3lLW4iUdX78v63nEjqEtOk9
	 lREKlKkcwirpA==
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
Subject: [PATCH net-next v2 4/7] selftests: nl_netdev: add a trivial Netlink netdev test
Date: Tue,  2 Apr 2024 19:34:23 -0700
Message-ID: <20240403023426.1762996-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403023426.1762996-1-kuba@kernel.org>
References: <20240403023426.1762996-1-kuba@kernel.org>
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


