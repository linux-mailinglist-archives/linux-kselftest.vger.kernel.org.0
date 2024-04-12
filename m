Return-Path: <linux-kselftest+bounces-7807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5318A3044
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAE6B233BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36F127E20;
	Fri, 12 Apr 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMOkwjqD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B0127E1A;
	Fri, 12 Apr 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931284; cv=none; b=UtUtgHD0eEXi+q9sFOawRBsKkiOVD55UDkMcENNPm6ASS3+asMlESWgFqsyh/utxrVmf8UpVf9NniPHyeLP3HtoFp94MOVq+3og4ZHtWjitMMbssm2TEHfOaRE7ag1yziLIbeQlw/HA6hOaggoiCM4C9TSCS29IC2a8exu8hxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931284; c=relaxed/simple;
	bh=a/xwDv1uI1eJafNxyFB3fcAD3BCfsSqkG8l2bCUThIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zsez1QACwutgbNm1jcGFsYFEmmsdkbdknsGFhqPLiV/4B2wwBgDQ3kEEaxH7xt8A9Cvhq9Z73efCJ80wFc2YhmRm8Zxn0udXYuMXWi6V0CIrzitlsKZXqLjI/RvMcPV6LrSPDRLTJgUm/GNRV21I5L5/JkhOAvDtv5vATvjPO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMOkwjqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E38C4AF0E;
	Fri, 12 Apr 2024 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712931284;
	bh=a/xwDv1uI1eJafNxyFB3fcAD3BCfsSqkG8l2bCUThIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMOkwjqDeZMrtWjW+EuM5BRU0pg3VGxVxY+Q+U6Q4DpJ9kJ76D+Oh1d5MmDn4rH7X
	 z1wEHdYOEm+O9623Vi4+U/qiGn9dIMNjGJ92bVwUT0TPf946y0D8NYiuARivdOHqVD
	 5aP1B/eof8Rh96k7F3sdyVA0GKA4Z+l3G7ujzlyLeLfGsQiDADuE/sbNX3J5c2l5OY
	 vZo1KGjAPoQRxnvBYOk50bpICinlCgrDcFfeaj4wQo7p+ke4tJj5L8Ug1dtGn6GECC
	 i5YTyKMtLFoPsmQltHQYm5LcS/IpQD9MyzB5YdG5iIwL9rrPJyuN5lubgjjPFtUE7S
	 fa1QweTOEhVZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 6/6] selftests: net: exercise page pool reporting via netlink
Date: Fri, 12 Apr 2024 07:14:36 -0700
Message-ID: <20240412141436.828666-7-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412141436.828666-1-kuba@kernel.org>
References: <20240412141436.828666-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Python test for the basic ops.

  # ./net/nl_netdev.py
  KTAP version 1
  1..3
  ok 1 nl_netdev.empty_check
  ok 2 nl_netdev.lo_check
  ok 3 nl_netdev.page_pool_check
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - move up / down to the test
 - add helper for getting pp
 - add busy_wait helper
 - rename undeteched
---
 tools/testing/selftests/net/lib/py/ksft.py | 12 ++++
 tools/testing/selftests/net/lib/py/nsim.py |  1 +
 tools/testing/selftests/net/nl_netdev.py   | 76 +++++++++++++++++++++-
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 793e4761645e..3769b9197213 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -2,6 +2,7 @@
 
 import builtins
 import inspect
+import time
 import traceback
 from .consts import KSFT_MAIN_NAME
 
@@ -50,6 +51,17 @@ KSFT_RESULT = None
         _fail("Check failed", a, "<", b, comment)
 
 
+def ksft_busy_wait(cond, sleep=0.005, deadline=1, comment=""):
+    end = time.monotonic() + deadline
+    while True:
+        if cond():
+            return
+        if time.monotonic() > end:
+            _fail("Waiting for condition timed out", comment)
+            return
+        time.sleep(sleep)
+
+
 def ktap_result(ok, cnt=1, case="", comment=""):
     res = ""
     if not ok:
diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
index 94aa32f59fdb..06896cdf7c18 100644
--- a/tools/testing/selftests/net/lib/py/nsim.py
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -28,6 +28,7 @@ from .utils import cmd, ip
         self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
         ret = ip("-j link show dev %s" % ifname, ns=ns)
         self.dev = json.loads(ret.stdout)[0]
+        self.ifindex = self.dev["ifindex"]
 
     def dfs_write(self, path, val):
         self.nsimdev.dfs_write(f'ports/{self.port_index}/' + path, val)
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index 2b8b488fb419..6909b1760739 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -1,7 +1,9 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily
+import time
+from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, ksft_busy_wait
+from lib.py import NetdevFamily, NetdevSimDev, ip
 
 
 def empty_check(nf) -> None:
@@ -15,9 +17,79 @@ from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily
     ksft_eq(len(lo_info['xdp-rx-metadata-features']), 0)
 
 
+def page_pool_check(nf) -> None:
+    with NetdevSimDev() as nsimdev:
+        nsim = nsimdev.nsims[0]
+
+        def up():
+            ip(f"link set dev {nsim.ifname} up")
+
+        def down():
+            ip(f"link set dev {nsim.ifname} down")
+
+        def get_pp():
+            pp_list = nf.page_pool_get({}, dump=True)
+            return [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
+
+        # No page pools when down
+        down()
+        ksft_eq(len(get_pp()), 0)
+
+        # Up, empty page pool appears
+        up()
+        pp_list = get_pp()
+        ksft_ge(len(pp_list), 0)
+        refs = sum([pp["inflight"] for pp in pp_list])
+        ksft_eq(refs, 0)
+
+        # Down, it disappears, again
+        down()
+        pp_list = get_pp()
+        ksft_eq(len(pp_list), 0)
+
+        # Up, allocate a page
+        up()
+        nsim.dfs_write("pp_hold", "y")
+        pp_list = nf.page_pool_get({}, dump=True)
+        refs = sum([pp["inflight"] for pp in pp_list if pp.get("ifindex") == nsim.ifindex])
+        ksft_ge(refs, 1)
+
+        # Now let's leak a page
+        down()
+        pp_list = get_pp()
+        ksft_eq(len(pp_list), 1)
+        refs = sum([pp["inflight"] for pp in pp_list])
+        ksft_eq(refs, 1)
+        attached = [pp for pp in pp_list if "detach-time" not in pp]
+        ksft_eq(len(attached), 0)
+
+        # New pp can get created, and we'll have two
+        up()
+        pp_list = get_pp()
+        attached = [pp for pp in pp_list if "detach-time" not in pp]
+        detached = [pp for pp in pp_list if "detach-time" in pp]
+        ksft_eq(len(attached), 1)
+        ksft_eq(len(detached), 1)
+
+        # Free the old page and the old pp is gone
+        nsim.dfs_write("pp_hold", "n")
+        # Freeing check is once a second so we may need to retry
+        ksft_busy_wait(lambda: len(get_pp()) == 1, deadline=2)
+
+        # And down...
+        down()
+        ksft_eq(len(get_pp()), 0)
+
+        # Last, leave the page hanging for destroy, nothing to check
+        # we're trying to exercise the orphaning path in the kernel
+        up()
+        nsim.dfs_write("pp_hold", "y")
+
+
 def main() -> None:
     nf = NetdevFamily()
-    ksft_run([empty_check, lo_check], args=(nf, ))
+    ksft_run([empty_check, lo_check, page_pool_check],
+             args=(nf, ))
 
 
 if __name__ == "__main__":
-- 
2.44.0


