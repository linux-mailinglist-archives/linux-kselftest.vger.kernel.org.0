Return-Path: <linux-kselftest+bounces-22184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31FF9D1346
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53C7B2B0D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DC61C3301;
	Mon, 18 Nov 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL4T9EAm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C41C243A;
	Mon, 18 Nov 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940441; cv=none; b=UMLYJg5BTnFFEVT6EkxkgAuMD4n4BNlQHJS/G8W9Hbbjpr8IIeLHiPGcKPJ6JoZyFw6B9W2XrNG1cRAJUFqXnH8yd9p60bifdIppyyRgsUWfQV1kUNdcWvOzauMOvubpeXsFYRUHIKyt0P3m0zFdpOrgekEFTuDFg2vJO7PG/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940441; c=relaxed/simple;
	bh=EMm8SpRFSVdgOejildAdC2w3jXC1qx7tovAMGbdzoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzoVPmVavIxMNPgaQX+8jSC4+iP1NyYELlyG1WltSrbvz7nGiEWcOoEtrdq+ns/0qHsQlRUwxn/7NIPyeHl6uylUyUPQK1omQUgmk8b8ye6pfiqUT9xqBhEKY3TPaYV++M2Rq2Q5h5timhIwfPp2ogld+4MgElKnsjcF0dZL1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL4T9EAm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7240fa50694so2573017b3a.1;
        Mon, 18 Nov 2024 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940438; x=1732545238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mad+mOcno2P0CIpC5U9uxqbBM+RxeN4q/RBh6+yxx1g=;
        b=CL4T9EAmet4oWj3D2aUczQ5Wy6j++1B1BMz+q0T1SnUYhEwh0UmnGmbx6yMFd/Yo/f
         V6M6oitwQY+pCqyfNlQmhhOKLVKRxRGDqPRpAm1697TmGXcFrCS0F9FC6Vk2FkIjiOUX
         uZwuWMiFyYK1VL2DO6fJNQrDFuomj+704nOcJ0O227+IqDuP2+9t/doT8em7PeFdaJ9Z
         5QaTkBXhkyJYQ8jqNd4ZbmXzwCwG97RHuvTojNPdaVUPU2B5hgal09LPPzCq6kqqwNyz
         F3mce2Bhn7Hk7xdlVmUHP4bpCWmzlfX3rU27yw3AykBjJeTB8hsMhAFxwhrlE/A+3CUH
         ASNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940438; x=1732545238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mad+mOcno2P0CIpC5U9uxqbBM+RxeN4q/RBh6+yxx1g=;
        b=mkcbTXOihPDoEF3kRJk7Z6KyTj8F8vetx6QL3VvAoIKk9J2ZfgSQfQ4sBl7kQ0Aspr
         AptqKMjGTdCX1X4YgVHjlVSQUH2vUUOMvPcsfzES1rkxChhx/bFHOf89tsRQ8J8o6ihT
         Nt8ADeL1UndOCkBA3N+nNoCuPX6pzo9nr9Lc1EmP3gd1Wy5/Fl5NBZ+F11W8TXg+f+W3
         9eUnpXfysihiKr/x/FwKe/SxKT+760P/V2i1q5GjLiFMTNGFzq0DQRw1EDRXDSkOcRTr
         ugyVf0eqffXPdotF98KYsHlIVLdi7G5gU2wlkAzpkyjkjmmsxvKdjDgS5fCBU5yHF6Nw
         1BcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4SqadZdzqBEM9eAGz8dPy8VyZ1N5qk6Ie2Mx4UucckIrB+1zRx2mlS+V3rPK8stP/S+Jx8T5sVwAqdQ==@vger.kernel.org, AJvYcCUkN84qgFYcXc0oTc3w1x10SERt/eR6PPXQDCnwZ/ohYn79c3bLEmvLl6dgw84L4yd7M1swezaAecYVpg==@vger.kernel.org, AJvYcCUn5OtIt1UrKk7YJEGol7JVUdHwDFUhm582scEMTsJ8TlwxBZ10uYLZJbELrcDlPYq41Qw=@vger.kernel.org, AJvYcCVjwnYxNcv+F2+D3fRpEZ8dw7RXfV0qecUZyEq3K6tZkm0MsTPuEtO7RSz2uQg43gc8tgwBnXNOd7G6yQUzhyU=@vger.kernel.org, AJvYcCVmWoubgTLk9VnhftPID3s+QQazA1I6ffijBTT90DMwIkQcIJVMANqxO6TRuhn6omi73bNqjessqMS5@vger.kernel.org, AJvYcCVvCtv7vs2Wm6XhDnqsZxAs4k2bTAm4E6Se7ypFRWSWJKqPWzRScdJxHwlI+QFudWg4p0EbEmpya0BL@vger.kernel.org, AJvYcCXOrhWF1YOhNgnJOfalKZhiE3Md1cX1CwCizoub9DVqH4exInnUXKvp/S5FFhuUT5DXy3PTBi+57HGdQlro@vger.kernel.org, AJvYcCXU7QP3tJIm2Wnv9wrwaV81935zbg9uQGRmlGIhLVnfXP0HPRGxe8a5KQ2hxR0h4N1uVuyP5zdT2wwadBmA8p6i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrr4Ja8m+mt2ByCjOsC3lrP+pyUhmA/kuxO/CqXRQev8c2sM29
	CHd3g27ggyEIgcUwzbd+6Sa6Ads0ctmLLxeFOJ9ZctSA8oT6FJ6DqZv92e6DPXs=
X-Google-Smtp-Source: AGHT+IF3SrGnsKmrF4jvHwe9jv6er3cYNAFkQ6BmUOZb81V3DDpEwoq4AchAw0/egZEddY1NEy8bEw==
X-Received: by 2002:a17:90b:3887:b0:2ea:98f1:c172 with SMTP id 98e67ed59e1d1-2ea98f1c2a5mr1425759a91.7.1731940436264;
        Mon, 18 Nov 2024 06:33:56 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:55 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 5/5] selftests: net: Add two test cases for link netns
Date: Mon, 18 Nov 2024 22:32:44 +0800
Message-ID: <20241118143244.1773-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Add test for creating link in another netns when a link of the same
   name and ifindex exists in current netns.
 - Add test for link netns atomicity - create link directly in target
   netns, and no notifications should be generated in current netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/Makefile        |  1 +
 tools/testing/selftests/net/netns-name.sh   | 10 ++++++
 tools/testing/selftests/net/netns_atomic.py | 39 +++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 3d487b03c4a0..3aaa7950b0f0 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -34,6 +34,7 @@ TEST_PROGS += gre_gso.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
+TEST_PROGS += netns_atomic.py
 TEST_PROGS += nl_netdev.py
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
index 6974474c26f3..0be1905d1f2f 100755
--- a/tools/testing/selftests/net/netns-name.sh
+++ b/tools/testing/selftests/net/netns-name.sh
@@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &&
     fail "Can still find alt-name after move"
 ip -netns $test_ns link del $DEV || fail
 
+#
+# Test no conflict of the same name/ifindex in different netns
+#
+ip -netns $NS link add name $DEV index 100 type dummy || fail
+ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy ||
+    fail "Can create in netns without moving"
+ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found"
+ip -netns $NS link del $DEV || fail
+ip -netns $test_ns link del $DEV || fail
+
 echo -ne "$(basename $0) \t\t\t\t"
 if [ $RET_CODE -eq 0 ]; then
     echo "[  OK  ]"
diff --git a/tools/testing/selftests/net/netns_atomic.py b/tools/testing/selftests/net/netns_atomic.py
new file mode 100755
index 000000000000..d350a3fc0a91
--- /dev/null
+++ b/tools/testing/selftests/net/netns_atomic.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import time
+
+from lib.py import ksft_run, ksft_exit, ksft_true
+from lib.py import ip
+from lib.py import NetNS, NetNSEnter
+from lib.py import RtnlFamily
+
+
+def test_event(ns1, ns2) -> None:
+    with NetNSEnter(str(ns1)):
+        rtnl = RtnlFamily()
+
+    rtnl.ntf_subscribe("rtnlgrp-link")
+
+    ip(f"netns set {ns1} 0", ns=str(ns2))
+
+    ip(f"link add netns {ns2} link-netnsid 0 dummy1 type dummy")
+    ip(f"link add netns {ns2} dummy2 type dummy", ns=str(ns1))
+
+    ip("link del dummy1", ns=str(ns2))
+    ip("link del dummy2", ns=str(ns2))
+
+    time.sleep(1)
+    rtnl.check_ntf()
+    ksft_true(rtnl.async_msg_queue.empty(),
+              "Received unexpected link notification")
+
+
+def main() -> None:
+    with NetNS() as ns1, NetNS() as ns2:
+        ksft_run([test_event], args=(ns1, ns2))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.0


