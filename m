Return-Path: <linux-kselftest+bounces-24414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9051A0FD69
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 01:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6447A33E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6B13FC2;
	Tue, 14 Jan 2025 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXbrf3xQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C024024E;
	Tue, 14 Jan 2025 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736814827; cv=none; b=ge3HeQDEVXPxZrJYdkzIWP0KvP+pZLI6MHtAnar1XjeoYr+n2usrX2kwqKgq7LtzHmxrlhcFPwfjskDkD07fV7j8Uq3QNaV4YzG7LGaqfAWCg8mvLg7MafybEkQz9ClrZizFJLSgQINUa8QgNawFTA2PISqLpkKf0TrsE+z6b78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736814827; c=relaxed/simple;
	bh=lTj+C+2kmpi0HDv6iuKQ+rcCoq/H2PKYGNYYJKQ5Jks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMYUIGm2q5GGhR8BAIqOhYC0aw47/9kiUxJxkw4AORVpHSF6UYwyOXqU+rohi1PMn5TLhUQ869SxN01CinKv6qq956Gl9yNVspS8TAe8UjxXywXG+ibs+EmhXzR5QFKd9vpw5Ug1NGNDVDjV2a9UH76FZksh0ooZmsqdrnwpE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXbrf3xQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-386329da1d9so2557186f8f.1;
        Mon, 13 Jan 2025 16:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736814823; x=1737419623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LwSJ04T1dLZjPnr65wcLWEjAxfiDEcHO+ths8d0Q1Y=;
        b=DXbrf3xQQyRRoyBrYZCCsnH+bFDnuFpUVxIBEbh7cQMtHFgvp+WeYXZ+Xm4NEmc78v
         /ni4a0EY1jlw3kP2CyoXFGIqTWNc9Gy4YmBpfN9vdXth/WtNfbxKZiyrZr1+kjDrl5tk
         HpjWGGdEplaYfIyHPPebfsFsOi5PSTwS4CkartEb+YFh9erHwH5z8byjuYvfnFWpSPaJ
         CqViHNGZCErgdLCJhwjRN5mWMnRg+NRQWp0UNGMsQI5EhUjJHaFIMb2pVQqEjEzyRZXI
         HWKi8tC9egP8u4ZqFxg+GIfkwJ/MfQ9Zc3puUZOcmGRFscr+qTwP3eQJZ1tFE7aNThk+
         q+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736814823; x=1737419623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LwSJ04T1dLZjPnr65wcLWEjAxfiDEcHO+ths8d0Q1Y=;
        b=guEVrBFG7H70AA7UjDLLYCtnILcnbSJA1mv/gCwZRqqxBst59CPsqSnrh8Yr7ZWShE
         D6Yh2oe9AuPwX+PVPmvd1I6Tcw2R8eZ0113jOmrEzN3eWrpsYeWvxg8tTzf/YGj4u6ua
         D7MyzS5uGfggOtHpYPGd7E+MxOH23bOACDWux3eQe56ZUF0s4crMYduTuGHUoQANaMxc
         tKcGu59lVOgiOzxAG7NBZZeNysvkFi2EtuN/A3TZj0Zrxbc2TyfvCUwwPxbIjOEcGB3v
         28z0yC6SDDO3CM/8oB/84pTs6ZuzK7k+mHyslp0h0nqw4NlrbsygcjSX2Pv98H/aMvff
         4P1w==
X-Forwarded-Encrypted: i=1; AJvYcCU40XgxWfBAtciPT8AiIx73ZvfkQ9ZuKEXxZGdrrR+UM98Ls+jRdhvrbwEsf8c35UlhW4NC6ZuzpneBNuo=@vger.kernel.org, AJvYcCWRHZcP0/b14bhptnu6CXapboctqr3B1skpBsk2j9O3H9c7PV6NfvMwFxh63/OQJb3jktJ2q/jmrIk7Gb58F7pK@vger.kernel.org, AJvYcCX2aEInMZ+mZOiPD3DkPFDr2gQl8LZv7IL1t6Rbp5tyFP98riBwPTutzBFSYLw6UusWr6MxaJBW@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+KxoEh5G/oe5bc5LzgOmYHbFoiiY6bEKNSa7F2jspRzkSq9D
	J5Ip1QVLF3HwHT+qfhrULphcYNsvn3FSzF6V8aiBRzMbkm2Wq4UZ
X-Gm-Gg: ASbGncsjQv0ZYgsDC2fvc6pjbudCx8edb+634aIjKo6uKM//6h9oc1U5l8x2Ct65EZ8
	GGqxJ5p0+kmfUMAFOsE5b6IGwp2icQGLVnoSYnoafpfAG9XLiBwNehc3HIT6nr79+m6KY3fLm6g
	9n5Rd346qN0FSQR3APLtbbAB74cKJZgXQFmMdwxP64MyCsXD9jhgkXgl7swrYqD6brifZI/INAG
	aO3z8nI26HbMVtI4gCGHURWpGkhoDLRegoJiacuf0jczwY0NSrTIyihdtQsUCSKb4ifBpAJ0vwR
	MisoTam9sItKKQYr0Fzrv6s3mnh5QTfGeGRsciOLLQE=
X-Google-Smtp-Source: AGHT+IHs9nBu4YttQvMLn2kVx+dxKrQapbh1Aj+fdilnCtN1diHTM0EwpWTk4JquIbVYKnKz/6LWkw==
X-Received: by 2002:a05:6000:2c5:b0:386:2fc8:ef86 with SMTP id ffacd0b85a97d-38a872da886mr18651647f8f.14.1736814823267;
        Mon, 13 Jan 2025 16:33:43 -0800 (PST)
Received: from alessandro-pc.station (net-2-37-205-234.cust.vodafonedsl.it. [2.37.205.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383df8sm13627198f8f.38.2025.01.13.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:33:42 -0800 (PST)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/net/forwarding: teamd command not found
Date: Tue, 14 Jan 2025 01:33:16 +0100
Message-ID: <20250114003323.97207-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make kselftest TARGETS=net/forwarding" results in
multiple ccurrences of the same error:
- ./lib.sh: line 787: teamd: command not found

This patch adds the variable $REQUIRE_TEAMD in every test that uses the
command teamd and checks the $REQUIRE_TEAMD variable in the file "lib.sh"
to skip the test if the command is not installed.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: added variable REQUIRED_TEAMD to check if teamd is required

 tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh       | 1 +
 tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh          | 1 +
 tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh     | 1 +
 tools/testing/selftests/net/forwarding/lib.sh                 | 4 ++++
 .../selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh      | 1 +
 tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh | 1 +
 .../testing/selftests/net/forwarding/router_bridge_1d_lag.sh  | 1 +
 tools/testing/selftests/net/forwarding/router_bridge_lag.sh   | 1 +
 8 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh b/tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh
index b79542a4dcc7..4a11bf1d514a 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh
@@ -12,6 +12,7 @@ ALL_TESTS="
 	bridge_rif_remaster_port
 "
 
+REQUIRE_TEAMD="yes"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/devlink_lib.sh
diff --git a/tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh b/tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh
index e28f978104f3..b8bbe94f4736 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh
@@ -10,6 +10,7 @@ ALL_TESTS="
 	lag_rif_nomaster_addr
 "
 
+REQUIRE_TEAMD="yes"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/devlink_lib.sh
diff --git a/tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh b/tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh
index 6318cfa6434c..d1a9d379eaf3 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh
@@ -10,6 +10,7 @@ ALL_TESTS="
 	lag_rif_nomaster_addr
 "
 
+REQUIRE_TEAMD="yes"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/devlink_lib.sh
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7337f398f9cc..996a866ed6de 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -68,6 +68,7 @@ declare -A NETIFS=(
 : "${REQUIRE_JQ:=yes}"
 : "${REQUIRE_MZ:=yes}"
 : "${REQUIRE_MTOOLS:=no}"
+: "${REQUIRE_TEAMD:=no}"
 
 # Whether to override MAC addresses on interfaces participating in the test.
 : "${STABLE_MAC_ADDRS:=no}"
@@ -321,6 +322,9 @@ fi
 if [[ "$REQUIRE_MZ" = "yes" ]]; then
 	require_command $MZ
 fi
+if [[ "$REQUIRE_TEAMD" = "yes" ]]; then
+	require_command $TEAMD
+fi
 if [[ "$REQUIRE_MTOOLS" = "yes" ]]; then
 	# https://github.com/troglobit/mtools
 	require_command msend
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
index fe4d7c906a70..a20d22d1df36 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
@@ -49,6 +49,7 @@ ALL_TESTS="
 	test_mirror_gretap_second
 "
 
+REQUIRE_TEAMD="yes"
 NUM_NETIFS=6
 source lib.sh
 source mirror_lib.sh
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
index 1261e6f46e34..ff7049582d35 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
@@ -53,6 +53,7 @@ ALL_TESTS="
 	test_mirror_gretap_second
 "
 
+REQUIRE_TEAMD="yes"
 NUM_NETIFS=6
 source lib.sh
 source mirror_lib.sh
diff --git a/tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh b/tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh
index e064b946e821..16583a470ec3 100755
--- a/tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh
+++ b/tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh
@@ -109,6 +109,7 @@ ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
 "
+REQUIRE_TEAMD="yes"
 NUM_NETIFS=8
 source lib.sh
 
diff --git a/tools/testing/selftests/net/forwarding/router_bridge_lag.sh b/tools/testing/selftests/net/forwarding/router_bridge_lag.sh
index f05ffe213c46..2a4cd1af1b85 100755
--- a/tools/testing/selftests/net/forwarding/router_bridge_lag.sh
+++ b/tools/testing/selftests/net/forwarding/router_bridge_lag.sh
@@ -76,6 +76,7 @@
 	ping_ipv4
 	ping_ipv6
     "}
+REQUIRE_TEAMD="yes"
 NUM_NETIFS=8
 : ${lib_dir:=.}
 source $lib_dir/lib.sh
-- 
2.43.0


