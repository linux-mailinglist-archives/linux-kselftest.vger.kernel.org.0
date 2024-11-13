Return-Path: <linux-kselftest+bounces-21931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7159C7016
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 14:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C5B1F263F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F72206047;
	Wed, 13 Nov 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuKpQGr+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56AF200BAB;
	Wed, 13 Nov 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502710; cv=none; b=FlZdVhA33/D/hlMYNpgwBqWpnnxN4M9yDr6QwMp7Jyq3OcTKpGDUQmvnIKw2yOPSPl1TZTzqYf1IP6nPDfuw/z+cdKSj0bPm3woFtx1faXwcd6ZS03LgumXUW4lwyc84c2L/YSrwcb5qMN8MkWWw3iTxsirvYJTZEvtYGyNzF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502710; c=relaxed/simple;
	bh=MiIGFE7JQmeCulMCTNzU+03Zvl9uvgozGAxqw8x+eUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3NPV58sgxYS3noyIQ25rRmrBl55BwWccZFal7b5yMGAm/urLbiMr5i4/YAB3JC01Nq7Dpl5KfDUNJdU85favmjSXi7uru2tVZns84rg26YuYZ0MontgRjV9p0N5iuLZcq8kTk9a932hNjR0CqkFH8UpRxO/w+RA+Gm2ZsZ7AvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuKpQGr+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e9b55b83d2so4231647a91.3;
        Wed, 13 Nov 2024 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502707; x=1732107507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqrrLk6+C692qIcVQOp9KatlJAZHjGryjisTBrwbzoI=;
        b=AuKpQGr+TdF2ChIJohhWsFdVKp4kAXgRA6k+SK4b1DUiyvHUATwQUViv9lsaVf9t5v
         vuxbV74pusxqjqorQfGH0Jg86vVbOPzvd/s4gFDCyPQyDXAXHBHZL9oy9wHxv06C5h6x
         L2wSA/vgpy4gKuwZE7CRc+pOoYKBEEzWmefGVS0Rz99HX7fUCIYTax0cxmBHQgRuypRV
         uBn+LlJmWBHnRx4Jr+D9SRx19t9OX+W3i7k9mBCT/CDlHzSW7SMdSn2DDHaXZNq768KV
         bVV1osooSxE/32U3Aboe1m205SjNGOv9ZXrZaFBy8gBDecXuxzyfXk6FYCre3kyFOgOU
         vD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502707; x=1732107507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqrrLk6+C692qIcVQOp9KatlJAZHjGryjisTBrwbzoI=;
        b=AMzYyX8uYwpKwENZ0IWCg7FUOnXhrD5N3+qA+3locZ1wrd0UMpOkKw6zUX1LwP97rA
         NXul85JTsBfU0sFY+g5yW5cjYc2a9ywp9pvWETc1WZVebkPIGfTBZoLiIEIiEzaYXw8t
         hgxxo8oZQ503HJxrYsA4uiH+WL/8guPjMKFVPqeb0xvD8P0cwa7rWg0ujLsRH5vsvKJG
         I3zhk7CER1V15O8+cqPPWk8YnLcxlLedCD3R8yXT3/EQQRa0qzZFPbYXYJPWWDo7xgOU
         gPxEXm4PiZFzmDCP/KhpXPm+GxmIlg8RU99FUPtTSvTxe1rUxl1neLHlaaY77omTL4yP
         saVg==
X-Forwarded-Encrypted: i=1; AJvYcCULsCtWFGahO/3fn7PwjJZbiC7SOZqPwWGg7yu+S82iKiHEW276pRd8UosYdAvdTrscdlBg7VGCGlIjtT6NwrU=@vger.kernel.org, AJvYcCVFUpZnCvRgG48vMQRVzLwmk0QWt/TQiM4tkHupx2B0OkSzA9wYIYk50D8TunnGESvaq8BZfcEnucxrOQ==@vger.kernel.org, AJvYcCVOIRpbZuqSeBGkXU7PDL7wwi+3RAGwRlBpAn+jAOeDEZGs1QW2wGjx8Lzmvv64sJFBKtyI+Nvb1yKE/g==@vger.kernel.org, AJvYcCVTStIh8Bwzq/vYTeoGXNwdgeuIxjjf4GXTW1a4uo5aUWuqmyihF/E5euhPcymkKkKH5Z8tzDaWg4Jl@vger.kernel.org, AJvYcCVjMX/MVXuce6ym31Z3DHeDh9DEFi7qGD9iQ5tQXAKeYrhRgrbY6DPpFOyNrquDN5yDJUHV0i2ay3GBl6yUvrm3@vger.kernel.org, AJvYcCVvUUPVH8lthRGVUr74f6GW/glOQiKgeSfQfhPBN1afYlGLd/hmmKJ++KAI9v9aE9AjG3A=@vger.kernel.org, AJvYcCX/guAv7i9DWMk+S+nJIOtmEzMmrMIA/GDP9KEnQEaux3WGKTebEwbA5hbGF7l56Xl7hw5oo6Of/ZK2@vger.kernel.org, AJvYcCXhfOgdk4KDgDJm8+3EgJjhjX4DVRiyE3A0i3nTl5QXFODlmZ5V5KCCkZRm1+2Nffp8RZUSJNrRD8WbN1Wy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gpZaroi1T1BGtN0s4SWlL4zHzjEUjpTWxcup1pUzyDRuh65b
	ec5prC8vTpQHvfyNOyucRF+ED+Mgo2EadYGK5AganDcN1bByWLI8MahgRBr7WAc=
X-Google-Smtp-Source: AGHT+IE/vtXg73mPc9UwMocIh3JnpJ4Nx9KNFh/J++F7E0J+l3pL2CaZbF6bhZwKtLiUviIv9q/4Rw==
X-Received: by 2002:a17:90b:3c12:b0:2e2:b2ce:e41e with SMTP id 98e67ed59e1d1-2e9f2c78421mr3106773a91.13.1731502707231;
        Wed, 13 Nov 2024 04:58:27 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:58:26 -0800 (PST)
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
Subject: [PATCH net-next v3 6/6] selftests: net: Add two test cases for link netns
Date: Wed, 13 Nov 2024 20:57:15 +0800
Message-ID: <20241113125715.150201-7-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
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
 tools/testing/selftests/net/netns_atomic.py | 38 +++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 2b2a5ec7fa6a..4c15a115c251 100644
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
index 000000000000..e6c4147ef75e
--- /dev/null
+++ b/tools/testing/selftests/net/netns_atomic.py
@@ -0,0 +1,38 @@
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
+    ksft_true(not rtnl.async_msg_queue, "Received unexpected link notification")
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


