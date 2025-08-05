Return-Path: <linux-kselftest+bounces-38290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC9AB1B166
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1153AC0E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D802226B08F;
	Tue,  5 Aug 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umyjyh2Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62C27055D;
	Tue,  5 Aug 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387234; cv=none; b=REdtUbecrgrfsiW2Htc6rAG4peqZ4YksQ0r3PFjz4nmg/5krPbTTnqxTXCv3qBoEyhQ7xgnObuCkZCvx1Ys5pQkSoU5mqOaKXeLB1dSscdygCe72rbkOmsD8rn7rbcmX2NziCH6O0IHtwvK96n2G0/qRR0gRS7DKcwNE5Yq98hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387234; c=relaxed/simple;
	bh=kQJLcJXeDr5oiiaa2BNB/vbbB6uNs7fNgN8hmxlKbV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acly4mC8NoBwErkuY+PUQlnwiCE0zDlfcYEUF8QTPP8owwAxVX44KkONwYNqUkemtB9ywYwtejvSYcTyOINbp0AgzPqRr+wGzYn7DstZp+wF8s5RhTz4dLQDPx6k547MVFT0rwR0QUmGJ1sFn/3rNw27aBRSJCb+9hklHhrmU+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Umyjyh2Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24009eeb2a7so42456065ad.0;
        Tue, 05 Aug 2025 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754387232; x=1754992032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCjWU531Bszqp1N9XxsVVVWtLLboUR6bhpsUeRJdGXE=;
        b=Umyjyh2Zp0FbUTmhDKvRNRpAoB0AY0pqJAyGGAZrk/n7ojocxg75JK7G5Oxny5cSqX
         6zIx2QE4tuDwgT+pDYHLPsHcbeCTYpwXARvrKhmMwV1FbBPPsS/mQqDcdFg4uL3PGKGw
         9FkpMXF1CjILa86HlS508CwkfQG4wXEhx1ZzxdsvNmrAkmY43bQ01xGAvzx0SeTBP3hF
         r3tyidWEHvfBGDAaeHQCpAEI6sGcsU+VaXvj4qtPop4n54NZg7fLOXT4C9U2XyrZjC5R
         Sz4VAumew2VEYtDsKdKn+s3cXXtBtpGe88NdDxt4E0FKlkYxR7xMX7FZim8PjbZm3q9x
         vlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387232; x=1754992032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCjWU531Bszqp1N9XxsVVVWtLLboUR6bhpsUeRJdGXE=;
        b=PoM4xHa3yGcOwyPS5iFHGBXMxv0RAPYvz4r3QLfr6m5h2sswu3+0p0fMm8p/q5v7v4
         C9PIYWwGTc50RNfqxHOlmKBSINhXBdqoSccnAA4P03IySvuPtWwEKsc3nIJDDOtfQOjV
         uTwdwKgBIf9m8gaLpsndrbgLimRi84r7BHsHOHVInRQxaRFJ0zcXzfi2uubYtTPwlWvR
         9qG6Z1Qkq9GNKtMnvmli+0lRFiCaEX1fXJh5SlLkK7zhRrc01qb0cv23jvzFPRYKh8nz
         6Z1mOH1LFX4DnjV+xZ4KPdYg2r+nogcZRH3ZYxtf3XtKHoRlraSfZjObfrhxM19aYYvZ
         TGsA==
X-Forwarded-Encrypted: i=1; AJvYcCWEt/j8m37iQHpx5zLtHQAcIgyG5duV1KPJOXZzlhy7J6YZluSgCM7VhC7YMZYMpKJBCyiHs34Lcqq4HmQ=@vger.kernel.org, AJvYcCWIk5AGD4otcJjCRuWsKh5zzet0DSce41E3P+PJJkjxeJPLnctYaKwl5SF2ZsyJX7yjuCqq8C1pzJp4uVyNx2j4@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUEk1LGzUlTMPV287xM47R6PWjkYnb2N6K+AplGZoTjY4A1Vo
	lt8agQoc1272OeK4RFYzAs5b0SqbqFPza3YE8ZTJj6IPNWtO3Wza48or5FSrE4z32Ww=
X-Gm-Gg: ASbGncsHJXQZUmNBxjnUOFEmVrzmiHJp510rD3VGgWIHqUigHrvfsJynPKkE6HN0By2
	gXd+6nhFqR4wrUmXdHEN23EoOnaPW4zKw2cf2CKpcI7q3zgNTKHKd2TZwUvTk3QoRxOfNVE5zl6
	hG8GqjWuV3WGCrwJp5+CrpbScj7WHyXCGBYMxRy7bRImjjlKvvUE4aWTFZRYFhgYPizBMCIv24I
	ylSlap4mKfvPst/qm8IafREsQ2YPta/MpfBAjfKG4giNJj78GuUIIvvw/SdMiVDbj9DDza0wH9n
	3joSSK3LPdB7M+NEd4DGe16BhJChqwHdtrVM4RCAjSv7s7oRg4TL+mlsgnF63ToHYU2YS7J5TKu
	3fuKT1w7Z5SowGaIHFkuKDo5yE0Ez7DOVGoyI2PfaguZN1So=
X-Google-Smtp-Source: AGHT+IGA9F/b42ZtN7UAqVDli6XbbXLsb5Ws4i88KG13V9Ms072nRIRglEcgh3ra8BFxA7RrXwIzwA==
X-Received: by 2002:a17:902:e811:b0:234:a139:11fb with SMTP id d9443c01a7336-24246fe09d6mr160621445ad.27.1754387232165;
        Tue, 05 Aug 2025 02:47:12 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d18asm128934875ad.141.2025.08.05.02.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:47:11 -0700 (PDT)
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
Subject: [PATCHv2 net 3/3] selftests: bonding: add test for passive LACP mode
Date: Tue,  5 Aug 2025 09:46:34 +0000
Message-ID: <20250805094634.40173-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250805094634.40173-1-liuhangbin@gmail.com>
References: <20250805094634.40173-1-liuhangbin@gmail.com>
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
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_passive_lacp.sh  | 95 +++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)
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
index 000000000000..4c714c166566
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
@@ -0,0 +1,95 @@
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
+trap cleanup EXIT
+setup_ns c_ns s_ns
+defer cleanup_all_ns
+
+# shellcheck disable=SC2154
+ip -n "${c_ns}" link add eth0 type veth peer name eth0 netns "${s_ns}"
+ip -n "${c_ns}" link add eth1 type veth peer name eth1 netns "${s_ns}"
+ip -n "${s_ns}" link set eth0 up
+ip -n "${s_ns}" link set eth1 up
+ip -n "${c_ns}" link add bond0 type bond mode 802.3ad lacp_active off lacp_rate fast
+ip -n "${c_ns}" link set eth0 master bond0
+ip -n "${c_ns}" link set eth1 master bond0
+ip -n "${c_ns}" link set bond0 up
+
+# 1. The passive side shouldn't send LACPDU.
+RET=0
+client_mac=$(cmd_jq "ip -j -n ${c_ns} link show bond0" ".[].address")
+# Wait for the first LACPDU due to state change.
+sleep 5
+timeout 62 ip netns exec "${c_ns}" tcpdump --immediate-mode -c 1 -i eth0 \
+	-nn -l -vvv ether proto 0x8809 2> /dev/null > /tmp/client_init.out
+grep -q "System $client_mac" /tmp/client_init.out && RET=1
+log_test "802.3ad" "init port pkt lacp_active off"
+
+# 2. The passive side should not have the 'active' flag.
+RET=0
+check_port_state "${c_ns}" "eth0" "active" && RET=1
+log_test "802.3ad" "port state lacp_active off"
+
+# Set up the switch side with active mode.
+ip -n "${s_ns}" link set eth0 down
+ip -n "${s_ns}" link set eth1 down
+ip -n "${s_ns}" link add bond0 type bond mode 802.3ad lacp_active on lacp_rate fast
+ip -n "${s_ns}" link set eth0 master bond0
+ip -n "${s_ns}" link set eth1 master bond0
+ip -n "${s_ns}" link set bond0 up
+# Make sure the negotiation finished
+sleep 5
+
+# 3. The active side should have the 'active' flag.
+RET=0
+check_port_state "${s_ns}" "eth0" "active" || RET=1
+log_test "802.3ad" "port state lacp_active on"
+
+# 4. Make sure the connection has not expired.
+RET=0
+slowwait 15 check_port_state "${s_ns}" "eth0" "expired" && RET=1
+slowwait 15 check_port_state "${s_ns}" "eth1" "expired" && RET=1
+log_test "bond 802.3ad" "port connect lacp_active off"
+
+# After testing, disconnect one port on each side to check the state.
+ip -n "${s_ns}" link set eth0 nomaster
+ip -n "${s_ns}" link set eth0 up
+ip -n "${c_ns}" link set eth1 nomaster
+ip -n "${c_ns}" link set eth1 up
+# 5. The passive side shouldn't send LACPDU anymore.
+RET=0
+# Wait for LACPDU due to state change.
+sleep 5
+timeout 62 ip netns exec "${c_ns}" tcpdump --immediate-mode -c 1 -i eth0 \
+	-nn -l -vvv ether proto 0x8809 2> /dev/null > /tmp/client_dis.out
+grep -q "System $client_mac" /tmp/client_dis.out && RET=1
+log_test "bond 802.3ad" "disconnect port pkt lacp_active off"
+
+# 6. The active side keeps sending LACPDU.
+RET=0
+switch_mac=$(cmd_jq "ip -j -n ${s_ns} link show bond0" ".[].address")
+timeout 62 ip netns exec "${s_ns}" tcpdump --immediate-mode -c 1 -i eth1 \
+	-nn -l -vvv ether proto 0x8809 2> /dev/null > /tmp/switch.out
+grep -q "System $switch_mac" /tmp/switch.out || RET=1
+log_test "bond 802.3ad" "disconnect port pkt lacp_active on"
+
+exit "$EXIT_STATUS"
-- 
2.46.0


