Return-Path: <linux-kselftest+bounces-23045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EAE9E9859
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B23E162E7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529701BEF70;
	Mon,  9 Dec 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZAZfv+B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33B1B4257;
	Mon,  9 Dec 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753177; cv=none; b=MiEDnPLrNko2vVqtJaKFYu+7KBRjqrjs1yxoxpx8PYqHoLkL0+7RJr6T174hQKLqUyB5Zkpb0GmywWvZgZvkSRJ7fjxq+5NkAT8l+WVk05wmj5Yw5bZZg/kh7RGcDDIUGaJeuw3K/Fx2oqc2ipT2mWJa94uLn0RNMKWj7+GGAtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753177; c=relaxed/simple;
	bh=x8YNUdGfzz0Gow2dLZx6X+qGjYOm2eRI9DodjQo7NU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7bJ97cbxJpdcfHzt15MBCws/G81NcZZ2u+clZ48iI7A2bAHOn10yHpoEt4dUjkDRfAAdzKS3JB75KWUkMdhrho14GrtvUjhxqoGVU+RspDH7Tyz62zLMNbk/D7rmXoQbu3JN8UnoojQVGT7mpomdsoJvMP0RZggQJYrEgEUu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZAZfv+B; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2165448243fso9518935ad.1;
        Mon, 09 Dec 2024 06:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753174; x=1734357974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZacjWdb8RyenSpXv6Caz5kcIhA6mwKRd5G/S3r2hOU=;
        b=UZAZfv+BRLl/Shtic2L4VBsSRsZmYRwmhJ1j0Xnwb7fJw9/ABUzo79nmLO4z+TGNyS
         EHxjADxk4lsz30Uy5ZFZtQqfF/bLc/2ROEE/Vbajw/wxhQRy11wDQtjkhUWvq1Q2NyTU
         eYweIU691CgjovnKYPUe2JnF7D/QFOMeH9Oq3m/l+wWBi874BXrIwLyvcvjQBk9fgMyD
         +4WLhqA59w4Ka9ryxj/nvYWwldCJ1jqBxRTtISaIujKFAcLsNFu2cvbDr+X0bi5Kg8cK
         Cv6dDPr3TFCpw33ZL805f9CMCZTMMLT6uUBHI4SmRbenSwWeHHsoG6UwBnTtJPH+1I3X
         HuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753174; x=1734357974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZacjWdb8RyenSpXv6Caz5kcIhA6mwKRd5G/S3r2hOU=;
        b=DHem4pmSO4aCKrwY+1uBxIu4tRkbz5mAhqUShWsozzik4lsXZQwmfr4KNxFUYwRNZA
         8cCpkgIOX6u7e6t2yZvOswXQDlqxfrXiO/SpSTx2qpZ50T7NjTuBKVZOOFFgM9N+jhby
         q6zzuGC8ADCYiZj5XVs8uuILuBgfj2duB3dlMV4v1Sn5AkPU5Rouc7sOs/kJZzWtLMLz
         4+Ib4c0s8SvXFMMnSS5kDm7Jqb6iW5D4lSitp/1DfTHUYcO/osY82EXeZTIwn2qrBhXp
         1dPr0i93zcN0naDtCtbAtjmtFjUIP7mqtL3jQZBi6RfOO9SHl0zeRZ5bn4yRMc47hgVU
         /MVA==
X-Forwarded-Encrypted: i=1; AJvYcCUAx0ZS8vbxLada1xpQ6jvUbYv/WlK5YjswwZWX8LIJTxHpGKQWAPH7vzPACZ8dWwQvjlqzvVhXGQAe@vger.kernel.org, AJvYcCUJ1nDG2k0Xy0ESnsGPeihybrlBHdYwTyxCGAppPGmjLrzd29+YNf1CdpHcLJNM2FlxNNs=@vger.kernel.org, AJvYcCUaDZPMRd/38Zfeh9P3kB//x2o3/7TeK3BD0vYoaAONG+tRhYxmnBGV3XN4dLICNes8MG4nWdYF0KFgvNfn@vger.kernel.org, AJvYcCVF6IOYmj+kpLdp7ctzmCz5egJeCBSbBp54hl7gWE2T5AH2OPdKLsMwySWs3X1Z8M8VG05NlSpdeTIYcQ==@vger.kernel.org, AJvYcCWWLNNPTp8zAr0oVLahBhsnZrdeV/FvIHBldEcNGLztTFSxJxMgwXlADfH9nn3f/UIYoLLeyH7JsEefqQ==@vger.kernel.org, AJvYcCWrKbxHD3826G9bfWdg36KnRWwG9HYQMbMtH0i/VpUWAgBh2Dh94mGgYaIsArkwfihpqICfd7ukMreMQueQWHw=@vger.kernel.org, AJvYcCXbW3jvUGIp5R+w7ZmNCFY8zilMiNBy+tDwVZOwSh4jqL7MHaEc7NfZkyicM/WRQ0ORyuR/8E3A1zFFDlvYcvyP@vger.kernel.org, AJvYcCXlOD3uQoTOoef613wqQBUyQR7Ro0sNd8BXzHos/r7lWQ7gp5WYJYp7EINTSHNcQZXKYl+vjJv1DC68@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYbiq9KS6tdcBXnKTgURZ5kzyetV5Z0KLyepJ2nTdgbXoZLKu
	PR4qofKhZT9G2nvhyOmKcgEG48wMM0R11SJbMpjRf/kmNxLCZp8Tlbu4bqtkCQc=
X-Gm-Gg: ASbGncs8Ratplb/QAj24KurcWvfroPQiRMhrVKLGZml+AZyeEZtgefB0GOSIoRGEBOa
	9SCufkIf16NHIN31aKP4NYRdzKFtTLCUiG31f/rvPzmmLFi7BMNjzZ1GlNkpJTZFT6Z91szM8K0
	02uixKuoDlaePQzlxZrqvVrHZbTe0EVan5eYz4yvApF91NkSMQXrfjBebcpFVtPvGqSWqDDpXMi
	pG7PnI6bful7v8madW/dSrAnsOraGiOvxQUJIoe2YzuX4g=
X-Google-Smtp-Source: AGHT+IHmgSwYi0f3YPXZUnipKY4/LE+6y74m5MtL3Oj9+h7tdAHjZEgR2L+TFdRwx2htNJ1fIiOnow==
X-Received: by 2002:a17:902:ce8d:b0:215:a2af:44ca with SMTP id d9443c01a7336-21614dd2374mr177498285ad.37.1733753174431;
        Mon, 09 Dec 2024 06:06:14 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:06:13 -0800 (PST)
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
Subject: [PATCH net-next v5 5/5] selftests: net: Add two test cases for link netns
Date: Mon,  9 Dec 2024 22:01:51 +0800
Message-ID: <20241209140151.231257-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
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
index cb2fc601de66..f9f7a765d645 100644
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
2.47.1


