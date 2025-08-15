Return-Path: <linux-kselftest+bounces-39062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 937ECB27912
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B518BB61EC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E3D2C0F98;
	Fri, 15 Aug 2025 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBV66jTn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74242BE636;
	Fri, 15 Aug 2025 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238829; cv=none; b=N/FKShleqzcu7i5W8kpmlgIeplYCx6/oVJ0fcNQIYNL0/E73im+bfrsLFNrfhwbcwCFbSS9ASdT7W86c6k0glJxXdWd/jXC4d0odp7nWHYGfJis3Sq/xzLmaVGTcUvFAA35AQH3HBnPqvE+tjnlvPG+B16zptkAu8PtHrSYfY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238829; c=relaxed/simple;
	bh=aPpabXhvPLpcF0X2TWoTMXPjSBp7r1Cjnc2nxsi0C3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBVvZlUthObw2L82xyPP5HzOAoAKdQ/tDUrCNiy7BEMaxob35T/VmO2X3SDIybI5JnNrH37XQKuuQDWsB6JUtoUOj2lDsEgh8YbYwRK1+dq73Quoxo4Lk88kfRnyjgUITvDz3ITgWr1+45tftpNy9sGMuJnkeQK9YoW6WoYJWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBV66jTn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24457f43981so11691675ad.0;
        Thu, 14 Aug 2025 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238827; x=1755843627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDajSTBBsS5Ac37CDKkbi0GU+XErCJ9ZpxWNvqdBPqk=;
        b=cBV66jTnDZeNujCtQcWEIZeE86WIlx7ATIRAoF62xBLxGkMc2c7YZGeZnZpZdgDS78
         nQOQ9w8aplhJ6cs50O8GubFhNQ4XAbVAhIBTTH21VkawRPQ/U1j/y/ErmPJKyDneHG4O
         907tI6o1GMlntdFLY/UPrmaIZ65ImvabH6sbJyFRZw89RhJax7SivSLxVsLhH47FSCbJ
         USBrQXvSeR+BnTcsCDetcZ8iacbfn2Z7dCw/oy4KrfWAnSHTnnItszsLFfxQaW1FH3WY
         sEcHhDrGgZh3M48T3BDpxOwkmSzYmrU2wWX2XLLej8aKEBR5IJ8JB02jaQVEHeyU+yMB
         oZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238827; x=1755843627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDajSTBBsS5Ac37CDKkbi0GU+XErCJ9ZpxWNvqdBPqk=;
        b=iVp/89zUOdvMgpsFR7UW9EUAQ8pOuwJRZETGcM6YJYupMRbDlljuXd5LCWvh4mRpD+
         A9+qBcOUHgKSi/tBgtfsgZDEqlhWGLUXrPyGlNBQt3TPgR4fsOqb++8OQA59sW2dtuJM
         xp2/QNwX/XSPRztQhsAvBalol3FjTAedRMa+AhWscT/N2Ujx3/Q6p8nH+F8ZEITsjAxN
         Iv4xIxD7PBU8GW0E8DwsGB7APT7oFCezlH9gp/WmCVE6Qp59I2Auo/0MnReXCISOx5k3
         gooWdcM/HX0Usj6Z4Q3eBLSRdRBEFBbro/oUuwcqvrxJuAKRA4rOPmrkeeYDbI0eX60P
         vJqg==
X-Forwarded-Encrypted: i=1; AJvYcCUKlLpspeNz5tSraw92/JWBGfz7YlMkBhg993IX5JeizhcAbTK8vg5JIJdVyXhebsKGlTV9YFsRuALS9Ls=@vger.kernel.org, AJvYcCXbcYnNxcGceFmLKJLrOsD+NnBoPevIYTF8DK8CxuMEt7c5NkUZWEw7hOdAOhRr2Z26LwI4Vt/eJuMbyizxsV6r@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ywOZnDwcrBH4/T7AnE/S0TICCkw0JrWrk/3x7XTlTTHBbKIK
	AkecNQ7KKtPaFFsvd1DtquyI3Cz0cwUDLcGoSCtfYyyTY5KYPGT/aRfIBQoHeyn/
X-Gm-Gg: ASbGncuiclpUDLviREIZxDePbABj9WHQbHehOFW1VyeZj4F6ehvPQ0A26VwPxitEWEb
	40E/lM9WBLpcujxkdLG1erBWFru/PAFm9sd2+mLEzDWhSK0dhQnGR6cE0J7Ae34CiyZ3uMubYkK
	TtCRn0nzH6jGGALqTCXipEFnWS6oNUrY1CCEb/Tg6S6jCcXvGWLAmuOwDV5vVKguX3A9hDjMXrJ
	zYV460j0Auz65QOWJuI9R0QvEniPwYblkMYLATmnZ+wKm8rbaPKS18wMoRqDSL3TgOxRQEAVgh6
	fzR53lzkXfyP0Zl+EWMwDS08ToBfciJDJY45XfP9vVbvQZSiPwlqo5tNIV46hrTr9QWHUwI62rr
	FOfSdHYJ+YkqHjPfjSuNpG+asBAfv5XH3GWeKNPDGlQ==
X-Google-Smtp-Source: AGHT+IESdapEWx3Im7r1+czXhOoF3VbAfyJKsPol/PczCXzt+a9RCmbqslqfXcT6tpPa1oIQT6M/Wg==
X-Received: by 2002:a17:902:ea03:b0:235:e76c:4362 with SMTP id d9443c01a7336-2446d7010damr15765795ad.18.1755238826549;
        Thu, 14 Aug 2025 23:20:26 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76df62sm425206a12.41.2025.08.14.23.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:20:26 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 3/3] selftests: bonding: add test for passive LACP mode
Date: Fri, 15 Aug 2025 06:20:00 +0000
Message-ID: <20250815062000.22220-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815062000.22220-1-liuhangbin@gmail.com>
References: <20250815062000.22220-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to verify bonding behavior when `lacp_active` is set to `off`.

The test checks the following:
- The passive LACP bond should not send LACPDUs before receiving a partner's
  LACPDU.
- The transmitted LACPDUs must not include the active flag.
- After transitioning to EXPIRED and DEFAULTED states, the passive side should
  still not initiate LACPDUs.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_passive_lacp.sh  | 105 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   1 +
 3 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 2b10854e4b1e..44b98f17f8ff 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -10,7 +10,8 @@ TEST_PROGS := \
 	mode-2-recovery-updelay.sh \
 	bond_options.sh \
 	bond-eth-type-change.sh \
-	bond_macvlan_ipvlan.sh
+	bond_macvlan_ipvlan.sh \
+	bond_passive_lacp.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
new file mode 100755
index 000000000000..9c3b089813df
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
@@ -0,0 +1,105 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test if a bond interface works with lacp_active=off.
+
+# shellcheck disable=SC2034
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+# shellcheck disable=SC1091
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+# shellcheck disable=SC2317
+check_port_state()
+{
+	local netns=$1
+	local port=$2
+	local state=$3
+
+	ip -n "${netns}" -d -j link show "$port" | \
+		jq -e ".[].linkinfo.info_slave_data.ad_actor_oper_port_state_str | index(\"${state}\") != null" > /dev/null
+}
+
+check_pkt_count()
+{
+	RET=0
+	local ns="$1"
+	local iface="$2"
+
+	# wait 65s, one per 30s
+	slowwait_for_counter 65 2 tc_rule_handle_stats_get \
+		"dev ${iface} egress" 101 ".packets" "-n ${ns}" &> /dev/null
+}
+
+setup() {
+	setup_ns c_ns s_ns
+
+	# shellcheck disable=SC2154
+	ip -n "${c_ns}" link add eth0 type veth peer name eth0 netns "${s_ns}"
+	ip -n "${c_ns}" link add eth1 type veth peer name eth1 netns "${s_ns}"
+
+	# Add tc filter to count the pkts
+	tc -n "${c_ns}" qdisc add dev eth0 clsact
+	tc -n "${c_ns}" filter add dev eth0 egress handle 101 protocol 0x8809 matchall action pass
+	tc -n "${s_ns}" qdisc add dev eth1 clsact
+	tc -n "${s_ns}" filter add dev eth1 egress handle 101 protocol 0x8809 matchall action pass
+
+	ip -n "${s_ns}" link add bond0 type bond mode 802.3ad lacp_active on lacp_rate fast
+	ip -n "${s_ns}" link set eth0 master bond0
+	ip -n "${s_ns}" link set eth1 master bond0
+
+	ip -n "${c_ns}" link add bond0 type bond mode 802.3ad lacp_active off lacp_rate fast
+	ip -n "${c_ns}" link set eth0 master bond0
+	ip -n "${c_ns}" link set eth1 master bond0
+
+}
+
+trap cleanup_all_ns EXIT
+setup
+
+# The bond will send 2 lacpdu pkts during init time, let's wait at least 2s
+# after interface up
+ip -n "${c_ns}" link set bond0 up
+sleep 2
+
+# 1. The passive side shouldn't send LACPDU.
+check_pkt_count "${c_ns}" "eth0" && RET=1
+log_test "802.3ad lacp_active off" "init port"
+
+ip -n "${s_ns}" link set bond0 up
+# 2. The passive side should not have the 'active' flag.
+RET=0
+slowwait 2 check_port_state "${c_ns}" "eth0" "active" && RET=1
+log_test "802.3ad lacp_active off" "port state active"
+
+# 3. The active side should have the 'active' flag.
+RET=0
+slowwait 2 check_port_state "${s_ns}" "eth0" "active" || RET=1
+log_test "802.3ad lacp_active on" "port state active"
+
+# 4. Make sure the connection is not expired.
+RET=0
+slowwait 5 check_port_state "${s_ns}" "eth0" "distributing"
+slowwait 10 check_port_state "${s_ns}" "eth0" "expired" && RET=1
+log_test "bond 802.3ad lacp_active off" "port connection"
+
+# After testing, disconnect one port on each side to check the state.
+ip -n "${s_ns}" link set eth0 nomaster
+ip -n "${s_ns}" link set eth0 up
+ip -n "${c_ns}" link set eth1 nomaster
+ip -n "${c_ns}" link set eth1 up
+# Due to Periodic Machine and Rx Machine state change, the bond will still
+# send lacpdu pkts in a few seconds. sleep at lease 5s to make sure
+# negotiation finished
+sleep 5
+
+# 5. The active side should keep sending LACPDU.
+check_pkt_count "${s_ns}" "eth1" || RET=1
+log_test "bond 802.3ad lacp_active on" "port pkt after disconnect"
+
+# 6. The passive side shouldn't send LACPDU anymore.
+check_pkt_count "${c_ns}" "eth0" && RET=1
+log_test "bond 802.3ad lacp_active off" "port pkt after disconnect"
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index dad4e5fda4db..4d16a69ffc65 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -6,6 +6,7 @@ CONFIG_MACVLAN=y
 CONFIG_IPVLAN=y
 CONFIG_NET_ACT_GACT=y
 CONFIG_NET_CLS_FLOWER=y
+CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
-- 
2.50.1


