Return-Path: <linux-kselftest+bounces-7667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C399E8A058E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A67A1F219EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3926B77F2F;
	Thu, 11 Apr 2024 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OahLLZf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185D73171;
	Thu, 11 Apr 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798924; cv=none; b=fU3ozhB2FDeIYfeXnQQTPrVTcej1ekc5fYRSPO7i/AMXFlcUFMGKQLXdWUL2URcA1vEyfgJ5vIZstnnog9iFo6EjSlx+J23hVUxU0V5d+8Zgoz7uzRmR3CYR63Mx1bA0HdrS9xvVAzDumKD1XKz4hmTOVjt+4/MW8BXlpNNHTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798924; c=relaxed/simple;
	bh=Dt+N9TSEXMGWfFEH27py4ZfTIinmlfGwSEEGHIQSoco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ca6QUUYCgZe0CiWgAOiOtoodCBuTr1Jft+84/d2ldo0cyBAXyzNeTVi0Yx79zfTmZ/HQETpZxUFj+63NTAKDv2pX2BNLS9yM4V9Qo3kMtDfSaAjXu5RxLFkVDQGlBSEzSqOGuBkisTGL996c+5N2qU4KSr9Ghp7Px8QFarg2s2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OahLLZf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD33C43399;
	Thu, 11 Apr 2024 01:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712798923;
	bh=Dt+N9TSEXMGWfFEH27py4ZfTIinmlfGwSEEGHIQSoco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OahLLZf9vIOhO54V3vzzapGnETus+wNJxWrh0o6K9C/DD+j6CFQkiTeNtgSesU0ew
	 Sp8mHBAKH9DIoGkaGLZiF5DiFrp2CDjT/D1ez8S+rv209hRf4qZNZi9ZuadGT3mxtB
	 Z5siQ24JPWXU3CE+6ejbCLiN2JyK03rYTEAx1TGbaV90mY/9o3dvNXlbqIHzaTWCDL
	 f9BOX4P46d7pMre2MASQUktBJ3/9RF19dwL9AH2uPBs+jdN6NeQBdT3zkSKNi6VlIW
	 vPFYQuvebdxwbMMS9q2+K6FxO0syrRrt9pQVgA9buBVQa37zoIP+umbpEZFs1AknK2
	 tUvd5V08ce1sQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/6] selftests: net: exercise page pool reporting via netlink
Date: Wed, 10 Apr 2024 18:28:15 -0700
Message-ID: <20240411012815.174400-7-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411012815.174400-1-kuba@kernel.org>
References: <20240411012815.174400-1-kuba@kernel.org>
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
 tools/testing/selftests/net/lib/py/nsim.py |  7 ++
 tools/testing/selftests/net/nl_netdev.py   | 79 +++++++++++++++++++++-
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
index 94aa32f59fdb..1fd50a308408 100644
--- a/tools/testing/selftests/net/lib/py/nsim.py
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -28,6 +28,13 @@ from .utils import cmd, ip
         self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
         ret = ip("-j link show dev %s" % ifname, ns=ns)
         self.dev = json.loads(ret.stdout)[0]
+        self.ifindex = self.dev["ifindex"]
+
+    def up(self):
+        ip("link set dev {} up".format(self.ifname))
+
+    def down(self):
+        ip("link set dev {} down".format(self.ifname))
 
     def dfs_write(self, path, val):
         self.nsimdev.dfs_write(f'ports/{self.port_index}/' + path, val)
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index 2b8b488fb419..afc510c044ce 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -1,7 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily
+import time
+from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily, NetdevSimDev, ip
 
 
 def empty_check(nf) -> None:
@@ -15,9 +16,83 @@ from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily
     ksft_eq(len(lo_info['xdp-rx-metadata-features']), 0)
 
 
+def page_pool_check(nf) -> None:
+    with NetdevSimDev() as nsimdev:
+        nsim = nsimdev.nsims[0]
+
+        # No page pools when down
+        nsim.down()
+        pp_list = nf.page_pool_get({}, dump=True)
+        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
+        ksft_eq(len(pp_list), 0)
+
+        # Up, empty page pool appears
+        nsim.up()
+        pp_list = nf.page_pool_get({}, dump=True)
+        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
+        ksft_ge(len(pp_list), 0)
+        refs = sum([pp["inflight"] for pp in pp_list])
+        ksft_eq(refs, 0)
+
+        # Down, it disappears, again
+        nsim.down()
+        pp_list = nf.page_pool_get({}, dump=True)
+        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
+        ksft_eq(len(pp_list), 0)
+
+        # Up, allocate a page
+        nsim.up()
+        nsim.dfs_write("pp_hold", "y")
+        pp_list = nf.page_pool_get({}, dump=True)
+        refs = sum([pp["inflight"] for pp in pp_list if pp.get("ifindex") == nsim.ifindex])
+        ksft_ge(refs, 1)
+
+        # Now let's leak a page
+        nsim.down()
+        pp_list = nf.page_pool_get({}, dump=True)
+        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
+        ksft_eq(len(pp_list), 1)
+        refs = sum([pp["inflight"] for pp in pp_list if pp.get("ifindex") == nsim.ifindex])
+        ksft_eq(refs, 1)
+        undetached = [pp for pp in pp_list if "detach-time" not in pp]
+        ksft_eq(len(undetached), 0)
+
+        # New pp can get created, and we'll have two
+        nsim.up()
+        pp_list = nf.page_pool_get({}, dump=True)
+        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
+        attached = [pp for pp in pp_list if "detach-time" not in pp]
+        undetached = [pp for pp in pp_list if "detach-time" in pp]
+        ksft_eq(len(attached), 1)
+        ksft_eq(len(undetached), 1)
+
+        # Free the old page and the old pp is gone
+        nsim.dfs_write("pp_hold", "n")
+        # Freeing check is once a second so we may need to retry
+        for i in range(50):
+            pp_list = nf.page_pool_get({}, dump=True)
+            pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
+            if len(pp_list) == 1:
+                break
+            time.sleep(0.05)
+        ksft_eq(len(pp_list), 1)
+
+        # And down...
+        nsim.down()
+        pp_list = nf.page_pool_get({}, dump=True)
+        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
+        ksft_eq(len(pp_list), 0)
+
+        # Last, leave the page hanging for destroy, nothing to check
+        # we're trying to exercise the orphaning path in the kernel
+        nsim.up()
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


