Return-Path: <linux-kselftest+bounces-33559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36128AC1ABD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 05:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE414A09F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 03:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A036322171E;
	Fri, 23 May 2025 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx1S/bhb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB72DCC02;
	Fri, 23 May 2025 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747971899; cv=none; b=DKMO+JfPk5qWXrIX2gdpmcDe5F45NOmM63M2mi2esLD7aQGl88Oj6YSpI8g734QvnG+fNfkeXCbhOTzUcbTovHwLIL3KWEMWt7P3UFydhXiMuy9icVXA2exRzjB7nx3jBMX1uLPMTsVipbnkhUWvtKEh71NGTtvqsDGuUwRcj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747971899; c=relaxed/simple;
	bh=LF/0eyCryd6R0BPLTvNb7XpdEDWXdfK7ZOwDRuXOsfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NL8DOUjknReFNyMQa6lg19bvUNtTUveQ7CLZZDnI8oKiD8pfxxPMdbqN5Dp8EFH/0vKjWj/LfV+/VLAwIKfJGIuIxZUV5BsRw3Z8u71FpLHebp5+iy1c8wENyisA75yzF65HjXg2xl8StFeFvVNAcYmlaIfg9MM/kBLdNzJEbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx1S/bhb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231ecd4f2a5so57937165ad.0;
        Thu, 22 May 2025 20:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747971897; x=1748576697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2o3j+2XgFpauGpmRYtOxgbJgOaGgnrT4xSP3hcSaRo0=;
        b=Mx1S/bhbrUr3TPbcK4nP2GhL2jXSxKRpOjfxpB+Zmhzh/tLGR9IwWZTNqa+aUwTHby
         nlS51m/2c30lBoG/H18/BKJg8BkTacq1vsk27aM6dKfjAJYV3Z1JepTwD7GG86mgZ/0W
         cXoEpXf2YaAwk+wO1k3j3t1Dtq4EfMPK7vIRphkG98kOYoJXew6+reKzzoy1t/FhZBLW
         MJjzELkKj0qpJV5QCkxlsIZlKMgWk3lRRntSGa5YSJzDGKlcgLMcmRJH6QGhEMnCWuLS
         7hUam8sJVWF8gqXAmuWuMhBFaM4NmIYlz5KA7uy1mW/8lPElgL+JuIMhE1qFkW2IgINw
         rQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747971897; x=1748576697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2o3j+2XgFpauGpmRYtOxgbJgOaGgnrT4xSP3hcSaRo0=;
        b=bJkKcSsN0JFhwIPm2wVonxVb/qZI+DX/ovQqFjwBYyZ2K7YotVIaZ8trgqz2oNpWRE
         XIB7tRGZ6JBnceatg35tPVO8vUanFz/EQPS4vwMUXjFDOTJgQcU37aheW3AJyZppCXin
         Wsbs13E54CJyxK5qPhBYLun4Z99OEyiP92w/PfKGg9t9R4nQO8k4clHop8wySheQappI
         rj5GhRgXLWrXCwBIAixy33FFQAaPBVlXwaRGY95kbK54iQ3FMZEZ+yc4DYVLDwBfTszw
         SC8T5GTObY5rTCk5BIZRBj/3diJeB+HWYTV/xSqmMFhoR50YV1/5Hzryy9rgXcnOHwcQ
         OD9g==
X-Forwarded-Encrypted: i=1; AJvYcCVlYtnZ2/65D5htaFMP9xdVwjQRax+3nLpzriakibIz5CzbuhHaWip0MdJR12NZdkaUorqEQMtznZf4gTilrwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Tj85WeFY6Y4qkcH4S/0R4VHhjwk7OBPSnHgVvFZZh3wy9kLs
	NxRfzuk1CFLHjrATIrtqXnAVC7rVr4SJKbna1raF0hVQqZDOkDw1ZAVvdB4M/IIyxsbtBw==
X-Gm-Gg: ASbGncurJ2/8IVIIaUMaeCOymxxrtsNR68r77v/3mbO1u18FPzFgkVVYWPYYYvR1T5w
	XN/NAmDDb4P4FVOemThmBtNrHj8wDq033Ue18xKriqzfcjqu+IbECxBnlWmll6S6ZW0ze2OlZhg
	prfj/8SWVWtknBtdbhtmkZL6PYpoqXHw6MVzYdbAkWKU7irvHTpAfZ+RjBxTRgWarT5l8nuwT4E
	4Jc2WHAsD0uRJFL/RfKnSjaZrJP7sDU1WYPjmAJx/Q1MpJWtiDgTbnzYwX5q5eSzQBXQHBwx+/z
	CZ/B29oHibh3gAkXJvi1KXRiapwGZEDOLtHdlnTK1qaWKeZ670M9q+HmrG0LobMuM+Dp9qj+e8S
	x
X-Google-Smtp-Source: AGHT+IHnHhkwN4RPM1sZGax22UCxLFFyjDOfjBA1sS14FQa5RUuVu81bDcpKP9tc8IYZx8hL/mgG3Q==
X-Received: by 2002:a17:903:faf:b0:224:160d:3f5b with SMTP id d9443c01a7336-231de37ec9bmr350292425ad.49.1747971896792;
        Thu, 22 May 2025 20:44:56 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed5683sm115728625ad.245.2025.05.22.20.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 20:44:56 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] selftests: net: move wait_local_port_listen to lib.sh
Date: Fri, 23 May 2025 03:44:33 +0000
Message-ID: <20250523034433.1373-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function wait_local_port_listen() is the only function defined in
net_helper.sh. Since some tests source both lib.sh and net_helper.sh,
we can simplify the setup by moving wait_local_port_listen() to lib.sh.

With this change, net_helper.sh becomes redundant and can be removed.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/Makefile          |  2 +-
 tools/testing/selftests/net/busy_poll_test.sh |  2 +-
 .../net/ipv6_route_update_soft_lockup.sh      |  1 -
 tools/testing/selftests/net/lib.sh            | 21 ++++++++++++++++
 tools/testing/selftests/net/mptcp/Makefile    |  2 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  1 -
 tools/testing/selftests/net/net_helper.sh     | 25 -------------------
 tools/testing/selftests/net/pmtu.sh           |  1 -
 tools/testing/selftests/net/udpgro.sh         |  2 +-
 tools/testing/selftests/net/udpgro_bench.sh   |  2 +-
 tools/testing/selftests/net/udpgro_frglist.sh |  2 +-
 tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
 12 files changed, 28 insertions(+), 35 deletions(-)
 delete mode 100644 tools/testing/selftests/net/net_helper.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 70a38f485d4d..ea84b88bcb30 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -115,7 +115,7 @@ YNL_GEN_FILES := busy_poller netlink-dumps
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 
 TEST_FILES := settings
-TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
+TEST_FILES += in_netns.sh lib.sh setup_loopback.sh setup_veth.sh
 
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
 
diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/testing/selftests/net/busy_poll_test.sh
index 7db292ec4884..7d2d40812074 100755
--- a/tools/testing/selftests/net/busy_poll_test.sh
+++ b/tools/testing/selftests/net/busy_poll_test.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-source net_helper.sh
+source lib.sh
 
 NSIM_SV_ID=$((256 + RANDOM % 256))
 NSIM_SV_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_SV_ID
diff --git a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
index a6b2b1f9c641..c6866e42f95c 100755
--- a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
+++ b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
@@ -69,7 +69,6 @@
 # which can affect the conditions needed to trigger a soft lockup.
 
 source lib.sh
-source net_helper.sh
 
 TEST_DURATION=300
 ROUTING_TABLE_REFRESH_PERIOD=0.01
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 7962da06f816..006fdadcc4b9 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -595,3 +595,24 @@ bridge_vlan_add()
 	bridge vlan add "$@"
 	defer bridge vlan del "$@"
 }
+
+wait_local_port_listen()
+{
+	local listener_ns="${1}"
+	local port="${2}"
+	local protocol="${3}"
+	local pattern
+	local i
+
+	pattern=":$(printf "%04X" "${port}") "
+
+	# for tcp protocol additionally check the socket state
+	[ ${protocol} = "tcp" ] && pattern="${pattern}0A"
+	for i in $(seq 10); do
+		if ip netns exec "${listener_ns}" awk '{print $2" "$4}' \
+		   /proc/net/"${protocol}"* | grep -q "${pattern}"; then
+			break
+		fi
+		sleep 0.1
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 340e1a777e16..e47788bfa671 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -11,7 +11,7 @@ TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
 
 TEST_FILES := mptcp_lib.sh settings
 
-TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh) ../net_helper.sh
+TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
 
 EXTRA_CLEAN := *.pcap
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 55212188871e..09cd24b2ae46 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(dirname "${0}")/../lib.sh"
-. "$(dirname "${0}")/../net_helper.sh"
 
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
deleted file mode 100644
index 6596fe03c77f..000000000000
--- a/tools/testing/selftests/net/net_helper.sh
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Helper functions
-
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-	local protocol="${3}"
-	local pattern
-	local i
-
-	pattern=":$(printf "%04X" "${port}") "
-
-	# for tcp protocol additionally check the socket state
-	[ ${protocol} = "tcp" ] && pattern="${pattern}0A"
-	for i in $(seq 10); do
-		if ip netns exec "${listener_ns}" awk '{print $2" "$4}' \
-		   /proc/net/"${protocol}"* | grep -q "${pattern}"; then
-			break
-		fi
-		sleep 0.1
-	done
-}
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 66be7699c72c..88e914c4eef9 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -205,7 +205,6 @@
 #	Check that PMTU exceptions are created for both paths.
 
 source lib.sh
-source net_helper.sh
 
 PAUSE_ON_FAIL=no
 VERBOSE=0
diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index d5ffd8c9172e..1dc337c709f8 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -3,7 +3,7 @@
 #
 # Run a series of udpgro functional tests.
 
-source net_helper.sh
+source lib.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index 815fad8c53a8..54fa4821bc5e 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -3,7 +3,7 @@
 #
 # Run a series of udpgro benchmarks
 
-source net_helper.sh
+source lib.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 5f3d1a110d11..9a2cfec1153e 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -3,7 +3,7 @@
 #
 # Run a series of udpgro benchmarks
 
-source net_helper.sh
+source lib.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index f22f6c66997e..a39fdc4aa2ff 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-source net_helper.sh
+source lib.sh
 
 BPF_FILE="lib/xdp_dummy.bpf.o"
 readonly BASE="ns-$(mktemp -u XXXXXX)"
-- 
2.46.0


