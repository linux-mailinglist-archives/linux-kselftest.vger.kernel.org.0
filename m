Return-Path: <linux-kselftest+bounces-37975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C00FB1188B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 08:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8D15A239C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD7288C08;
	Fri, 25 Jul 2025 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYVv7DBy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403B2882CA;
	Fri, 25 Jul 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424957; cv=none; b=Ho5xXiSslTsU+X3jBqFfDBwoddglyaVfZHvfviiZ9jLhAUC9t02SXMobGtj+URpXLvA302bsrG/CjoR1TLmkZTbTGumI5GNK0T9expXh7TQ1Q8HvPNjn3EQa4lRWY+JV1jU57AugaNYIpp6iCg3RlxuK0Pw2ImrkjBWLYiNTk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424957; c=relaxed/simple;
	bh=UoJ0MLyQYkeXIw8hsmrGf0Zx+0T+ufTiZpIxgruMik8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oInYkjtyf7KD79+XIGnCEDXpA2WWJ94E+xoWCRgvQAbB9cYfhtKLb0Rup7fVlUBGntwe7if+io1sP+szcb3yyun4a4QCWIxT+w8QwjXG5SvYSWr9dQMVt+tN13FHePU7SJJnXjKAbVMZqeUTi16DMJmNWT3qV0l4cPxuayxAzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYVv7DBy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3226307787so1548338a12.1;
        Thu, 24 Jul 2025 23:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753424955; x=1754029755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp+n7vwcyjj/ZiGkoHkKkkxW2SBrgsntY3ZqFgrCTyE=;
        b=RYVv7DByVT2ldE7p+q1t9WRWyPgvLfsX527H7EeQxyT2e7q0bNhnBHj9w+W+qbCFEt
         duR8oy/9rSNwVLRDIeARYWeNs9MYtkS4WL9jfb6x6qVdlLh5anC5Dlqo4ntUZqXkm09t
         tqAnrQtmwHZXpQdGQKoYicWSBzHrFMw49jucdTR/1WTqhAfcMReqAciavN/MqIt9UsJ8
         7KURD/DTZW+1QTaipmNaeVNsaWUZqUF+DSKYLxXqh6S8IE1xVMvZiSZzhXJQTFCoLhO2
         NmZNyr9auRGCU9csFI7TNnx9VXn75DX0SibBEGK64Z5d9dDp2rE84KLB795LcNQKuEm+
         dKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753424955; x=1754029755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp+n7vwcyjj/ZiGkoHkKkkxW2SBrgsntY3ZqFgrCTyE=;
        b=pUGm7FtGOhewAjDEL/sclcZEUYiEgAYw0sF3MGyC9kmXUZcSt5a82h7/8TwJF7tVGG
         7DeSEnvGbj7zvpBG/hTPNq3e7sNs7WzMQ+LNgacepQWPYJtpTUtWIk/17ofxtlVUNF+y
         uFNtMKoRyims+/AVL+A/Ws4W9wDVWkl1IBDqt5xLEXTQHfr16TMScjl0XWoQ18Tv1Iy2
         Ipkdn7Yr+Yxif4IjK34YaCspwe/kYyDYoS20m05Ro2Zq53kF6dBl8XrLX+AG7KpbryuY
         ktnjoIIp4klsShZ0NjXsLG7WSWWonvD7LcvbSY3meaN9LFVqNy9uvBkyQyj1FcgsHKn4
         zNiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS1wx8NWS5CmxV2p3VL+BgOW0h6cpzgxytYMu9LueB2gIkKfDEylt4+NMyu7UoAAYETO3uoflhtkU=@vger.kernel.org, AJvYcCUzWaSPNDDsZ0ip7GqzAetQs5JhQ4K7R+l2GnENQFjg2eNcPzMVxgBNhxtEnuyc9Jp4Y0YjoChMPiE++aqbsFee@vger.kernel.org, AJvYcCVI4pKRXG/pg04GP0ap+zXrxsPPOqdXszV9ASwDMoU93EkJYyzx0tINJyqY+dpET1lIGYlq8rpRiC/zmw//@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBQ7u2/HPr1zi2T1UEntusln9dhRvpWErc8fDluMui6E7OODO
	c6re/LNy45YIZsS5TBkJL/i+BpB/ZphCVEczNQnpQT+owJ87P8dnyqmbZa8baXRu
X-Gm-Gg: ASbGnctPT5kfwoSSEUcBmLxWxwvT/Clt9KyE5o1REftYfEwERDuybs2UQI/JGft3SmI
	Be30FCRYHP5y1nug7If2o31nsobTDxNpjNg4gNmjgvZ4cfEN/JCUGeVy9QejDMsrFxje98jlIdo
	+CWlwlW7FlegQqFXHNwfY0nvm7Z0MFgITpeaSd5CWqE4s4uEHs+z+yG1kNpG2pRjBjyHjFTlhLS
	zroa4kwsjITZOuAt1P+HmwXpgqYSWKUO//mjvNkRvdRYkR54Q3c6ORTs3C9r8tIfbhG9b92wpOI
	M8vlXRydUwG4soptSWfUKEDRfB3gEVUM4tcHuq2MzphweqQNoP60NnwY4PA2Hfv7RHxukka+unM
	sY0hvHb9jKNrpUhmFbGTnRYLnZ6KwPXAZ4jWDJr9u6udIrMw=
X-Google-Smtp-Source: AGHT+IEe9RTKqbc6PNoN0QvqDtlJz9XyB0yFHMLudxA71L7ky76POavm6tuXekDEpp9fIZYWhsYIeg==
X-Received: by 2002:a05:6a20:918e:b0:222:d817:2f4a with SMTP id adf61e73a8af0-23d70052992mr1039617637.17.1753424954746;
        Thu, 24 Jul 2025 23:29:14 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c09b532sm2667917a12.25.2025.07.24.23.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 23:29:14 -0700 (PDT)
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
	Jonathan Corbet <corbet@lwn.net>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 2/2] selftests: bonding: add test for passive LACP mode
Date: Fri, 25 Jul 2025 06:28:48 +0000
Message-ID: <20250725062848.18889-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250725062848.18889-1-liuhangbin@gmail.com>
References: <20250725062848.18889-1-liuhangbin@gmail.com>
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
 .../drivers/net/bonding/bond_passive_lacp.sh  | 93 +++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)
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
index 000000000000..017d96a319a3
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
@@ -0,0 +1,93 @@
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
+sleep 2
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


