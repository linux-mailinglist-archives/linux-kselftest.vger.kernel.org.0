Return-Path: <linux-kselftest+bounces-7460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D6A89D0E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018501F257D2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BAE56465;
	Tue,  9 Apr 2024 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3LyIE9A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943505578A;
	Tue,  9 Apr 2024 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632618; cv=none; b=Dv54r5h4Syd4uZNMgp9/GS2Ok0ewDfaxqDW7P9gRnFAn2YZlmSU8GGnfo+E+faxuYZaxEhNWDOlEa/FAWIwjRjSIQZ+m5htC7SvYPkT4ErRPEXoaMvA0TUKptOEGZgq8L27nxSSOnqe2PGe2fglHnnotLlOxE8MDMRLIwpl9l8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632618; c=relaxed/simple;
	bh=gZcoxT+eHxeUPYgzQtfsTv7+4vbMaAl8YaTwWiTQxRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UV8Kal+Mqqe1lcuH7KkocfKV1Y8pNjWgAH5KKYa7scNWTMpc82b4fdrUZbS+dnjZS9DHUHGIZKPg8FcSa3kv4BTmmpypodoasXapt9J07DB/b/2pkz0+lLShj4vryafL6WNEtw5yrGrd0Zv2mma3KLX/szohyyVs6S1o2z2rUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3LyIE9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EF3C433F1;
	Tue,  9 Apr 2024 03:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712632618;
	bh=gZcoxT+eHxeUPYgzQtfsTv7+4vbMaAl8YaTwWiTQxRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3LyIE9AXANuzef+WL7A/qfePVDcNU2+DTmQTqbUfI6TlIllagO23f7BNkd3fAXFt
	 A+z2rOnACQPSMggmVjOohojkd511nHIXQuihd0uroKFMRNduIKm786gUDeUbkVcSaA
	 r/ku9+ijudhvhwv/iykvTAo6GfqRTsFGPnN+LDiYhr/lF4o5hryDqjNFQibAc4q8Yq
	 NjNCU6rPrRme4LNLiZd9QGABaIQjI9CLM0iVC1SXw0K1RS1VLTfB3mKSrlv7C/8YPL
	 sf3aR8wTBhs98Yv8c3sSpHJiFBfoEwrdiXOmFx6K6ZIghMdmR8JH+le3IUd9nFj8yI
	 SIK01BSKpMETA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	mykolal@fb.com,
	eddyz87@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] selftests: net: bpf_offload: wait for maps
Date: Mon,  8 Apr 2024 20:15:47 -0700
Message-ID: <20240409031549.3531084-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409031549.3531084-1-kuba@kernel.org>
References: <20240409031549.3531084-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maps are removed asynchronously. Either there's a bigger delay
now or the test has always been flaky. Retry waiting in the loop.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/bpf_offload.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index 6157f884d091..174dba1a48d3 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -201,11 +201,11 @@ netns = [] # net namespaces to be removed
         time.sleep(0.05)
     raise Exception("Time out waiting for program counts to stabilize want %d, have %d" % (expected, nprogs))
 
-def bpftool_map_list_wait(expected=0, n_retry=20):
+def bpftool_map_list_wait(expected=0, n_retry=20, ns=""):
     for i in range(n_retry):
-        nmaps = len(bpftool_map_list())
-        if nmaps == expected:
-            return
+        maps = bpftool_map_list(ns=ns)
+        if len(maps) == expected:
+            return maps
         time.sleep(0.05)
     raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
 
@@ -605,7 +605,7 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
     return file_name, bpf_pinned(file_name)
 
 def pin_map(file_name, idx=0, expected=1):
-    maps = bpftool_map_list(expected=expected)
+    maps = bpftool_map_list_wait(expected=expected)
     m = maps[idx]
     bpftool("map pin id %d %s" % (m["id"], file_name))
     files.append(file_name)
@@ -618,7 +618,7 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
     ret, err = bpftool("prog show pin %s" % (prog_file), fail=False)
     fail(ret != 0, "failed to show prog with removed device")
 
-    bpftool_map_list(expected=0)
+    bpftool_map_list_wait(expected=0)
     ret, err = bpftool("map show pin %s" % (map_file), fail=False)
     fail(ret == 0, "Showing map with removed device did not fail")
     fail(err["error"].find("No such device") == -1,
@@ -642,7 +642,7 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
     else:
         fail("ifname" in dev.keys(), "Ifname is reported for other ns")
 
-    maps = bpftool_map_list(expected=2, ns=ns)
+    maps = bpftool_map_list_wait(expected=2, ns=ns)
     for m in maps:
         fail("dev" not in m.keys(), "Device parameters not reported")
         fail(dev != m["dev"], "Map's device different than program's")
@@ -1206,7 +1206,7 @@ netns = []
 
     start_test("Test map update (no flags)...")
     sim.set_xdp(map_obj, "offload", JSON=False) # map fixup msg breaks JSON
-    maps = bpftool_map_list(expected=2)
+    maps = bpftool_map_list_wait(expected=2)
     array = maps[0] if maps[0]["type"] == "array" else maps[1]
     htab = maps[0] if maps[0]["type"] == "hash" else maps[1]
     for m in maps:
-- 
2.44.0


