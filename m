Return-Path: <linux-kselftest+bounces-21610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C129C0789
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182541C21A09
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2750212EEC;
	Thu,  7 Nov 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdTIQt93"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6B210188;
	Thu,  7 Nov 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986265; cv=none; b=P+IvhnwoyuH3G4/2BdTa4+Eu/Jw5/bgpiEDm4z7L7WdSqmMwSzI/rvvwVTRhl6h3iSuDYPWedbTNYCelYTqNVyZS1reQPR3+snShgm4OVNzc56kN28wv1nKTbtJQyXa73kGGsR8pXdrlMjn6rxpOnDFphocXwvxRNjVNBXYBuA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986265; c=relaxed/simple;
	bh=TTAXzMoR6prbPDyHf3K7ryf5DxLLy+uLbXyIgHqvYrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLkxohko2FyQqEhvsrXUZVI18Q0oCKfkY3BWFPEg5r1c6lmCvHYd1eijLOfql2CJ35d4tyjkZtdAwX/nIV8Kpt2/AFTq/rY1XdSiir64ZDZs2MlSacdUE42DHKtEiiF8VtPktZh3qmEDKFSmNuat96Ya2NK7GC28ZOpXsadf+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdTIQt93; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7240d93fffdso230052b3a.2;
        Thu, 07 Nov 2024 05:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986262; x=1731591062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIZzWn+nKvXmxLmxcEunwkkL//l0GlmBJ8eEaT50DUs=;
        b=UdTIQt93WGI1xTqJfS2i9v3514ImNEokfhvhdOhSHi6tCq4IUF/hZUctxhkp9yk4t7
         yfVTaaWWrBZ5UfKsSO4pVED0v5vTqTadHsl08Px3mQyZGQA2KheohLFCB2EE7tVpoi6p
         48yEB3/QpJl6cOUUYi8Dy0e4VkQi/4SuJtI6qUAQ6CofhNDuujfjRX0aLmENynNzlzPZ
         O/ZLTeqJJmZ8df6Rjv9IZs2h/C5iUT5t49Qsot9QO9m9InFqZvJWigNoPmzvP0SreSqA
         xCULtOBj43aTScb9TEtU/WrF8exTacRucDy23lYKfKe7ksLvio3auBvwYDgjjFUU8f6Y
         A1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986262; x=1731591062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIZzWn+nKvXmxLmxcEunwkkL//l0GlmBJ8eEaT50DUs=;
        b=PcEBz4R18+GhcEL7EZvo+1mY8EfDIxh8hJ6P5bNYdtiKc9F62YpnEyw4j/hKkLNJ8D
         tZ94CcdW2SuWHDAxZ7BouVkc9aXKyi0YWJ4M0t+EuU3pHRMuRyfKomNIxK+qVjTSutyr
         Ukjg0nzJuTFf5d0KOqTEFBF8DFhJ7admRsf8lsHyBa8+SlQIlYv+qqwhwxK5AEk9yyvz
         Uc4sZ9cEoiv/2YkfcZoxEi3sw2QQuTuaeum3X3t86eHKPk2PoT2hXIJx/Aah6yKmuxPq
         CjBU8WLfnfz4DhjNCNjjlDh3iAmdt3i3VTs4wbJqge1gJBsfNuvVtinZXX7Cyp3T+hUy
         cuyg==
X-Forwarded-Encrypted: i=1; AJvYcCUYsnmQRDxeURr5iG2ntGVxCz+RyxCFTldlCi/Eao7lfxxjTiouWsqgLnjJLUqtJo8Aq7HEeRpGTPs9/h8gKXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIg8uuoOP4X7rX55S0b62VDl2KRFe3dbjoKUTqBX0ZkvcYkBdr
	HrwFvzngVtnogg8hq4l9YB+sxNzipkr5azBf2/6RzRcPSwqUEt1d6cePknHqjd8=
X-Google-Smtp-Source: AGHT+IEh95nMdBX1+0rzwUpHOxUQK7Py9U7CAHY31MA+MJvL+BeTAvewl50HEbJcORXsi9Sf9tRzIg==
X-Received: by 2002:a05:6a21:8985:b0:1dc:154a:81fb with SMTP id adf61e73a8af0-1dc17c4f723mr1075230637.44.1730986262550;
        Thu, 07 Nov 2024 05:31:02 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm1359303a12.76.2024.11.07.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:31:02 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2 8/8] selftests: net: Add two test cases for link netns
Date: Thu,  7 Nov 2024 21:30:03 +0800
Message-ID: <20241107133004.7469-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107133004.7469-1-shaw.leon@gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Add test for creating link in another netns when a link of the same
   name and ifindex exists in current netns.
 - Add test for netns_atomic - create link directly in target netns,
   and no notifications should be generated in current netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/Makefile        |  1 +
 tools/testing/selftests/net/netns-name.sh   | 10 ++++
 tools/testing/selftests/net/netns_atomic.py | 54 +++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 26a4883a65c9..ba1a486f93dc 100644
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
index 000000000000..0a3864e22b8b
--- /dev/null
+++ b/tools/testing/selftests/net/netns_atomic.py
@@ -0,0 +1,54 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import ctypes
+
+from lib.py import ksft_run, ksft_exit, ksft_true
+from lib.py import ip
+from lib.py import NetNS
+from lib.py import RtnlFamily
+
+libc = ctypes.cdll.LoadLibrary('libc.so.6')
+
+
+class NSEnter:
+    def __init__(self, ns_name):
+        self.ns_path = f"/run/netns/{ns_name}"
+
+    def __enter__(self):
+        self.saved = open("/proc/thread-self/ns/net")
+        with open(self.ns_path) as ns_file:
+            libc.setns(ns_file.fileno(), 0)
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        libc.setns(self.saved.fileno(), 0)
+        self.saved.close()
+
+
+def test_event(ns1, ns2) -> None:
+    with NSEnter(str(ns1)):
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
+    # Should receive no link events in ns1. Wait 5*0.1 seconds.
+    ksft_true(next(rtnl.check_ntf(max_retries=5), None) is None,
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


