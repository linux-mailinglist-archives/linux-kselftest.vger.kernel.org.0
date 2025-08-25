Return-Path: <linux-kselftest+bounces-39823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA6B336AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 08:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAB2176F8B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9C285C9A;
	Mon, 25 Aug 2025 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlYHHI8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D341C3C08;
	Mon, 25 Aug 2025 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104351; cv=none; b=FDjEeuUuf2H0oRUPthyuJwqN2Db4wW+ffpYVbXO4OAcwqRyzbt3YR5L52a67dXQu0AGQdNkC8usRxSsmw+07jjIhlnwy4p0c56VjvwC0NXyo1a8xZ6p8m3l6osJWHl2vAMSlgnB+RMmc44avCGMtcBpvnU4eAJhyK84ygj51cpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104351; c=relaxed/simple;
	bh=5MuhzqEAFp7z83EOi2YR4P8OPG5HOJB5/UgcWmFry40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9gRqLtWcU25sM0nqSqEVLBKErrG9xHfuNVjVf8CR79V+ompKgjRtAq9N5ag26obtwDgd85CSMR5De30Wn9Mltl+9zTBdLhqjUHNTNiTjrIqHL9rD8UiYy75xXxq4F0uNCm2mHnb3fDPoTfEgGeb+rDQ9dZJN+ML7aeyWCUwW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlYHHI8y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e5f058so2690807a91.3;
        Sun, 24 Aug 2025 23:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104349; x=1756709149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsbo+qPYTYiB/DwrByFJVbv6Ae3Kqkg6hVhhkSUAjYg=;
        b=VlYHHI8yiqdWWzhDJxaGA/mm6YABW78LzdqPSH44SzrrgXD5wKC3FW54ZY+VinZQdB
         h45avvmTg9oq+eRS+yjzP23HXiAFBjx72MANT8GHWT9bTzaBn7J0riTrYPQ+LLjS5uBE
         t2zHhPZE9W0i0CLK4Ns3SN3RaIZ44AIu3NRonghE4LPh6ApAs8oVfvjNg2K6eA2Gt6F0
         o+MVi3fmmA4AIUKLeQmktpBfYw4GGhrG1mySjgDHI0xoSA0ROZvO5UmcAcf2ZST5pDg+
         +dfPAEKUNLzmFtAaA0MvheYeYpx0NtpzIc0A+SwJoqLZ3wmK5uoMUK1EKKZSx/9JQsvz
         wJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104349; x=1756709149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsbo+qPYTYiB/DwrByFJVbv6Ae3Kqkg6hVhhkSUAjYg=;
        b=Z0PLHFxUGilcVgV9TkeNZTuIhbK2SvhYIZM/c1riflB9Bs/3kYMmROuPVFD7YhQd02
         iWnw4PdSPYnbZI9JmchSLhXWSplccrl/6fJ1mmLlUIWVOWw96F+gdrwZgWXI5oI+TXwh
         15d4EIRpexRfTpCkntp+E6IOQZcGFnphg6dJ/atlczHSh0v4eOZ6LOF0WE9E7RXvGRhs
         mxiIYPa3p24938wGE9N4I89qnWyh8n9Dyjc8wzAvGQqFn3ViucxU32ncJc+KHJQUJhBp
         r/n98MZqY8OG2Nc/a/PUPTADY0NyiTdjiq+w2ANrThpRPqHlT/CkoR0n+A5rH9XHlWiQ
         kYIg==
X-Forwarded-Encrypted: i=1; AJvYcCUfIKBjrodsUW1AdtHF8ssPYbtzR92pK9iehVRq4N6SoKzvdGS/LMXIyaxx1UJc/swpfP8AfZT6CHU=@vger.kernel.org, AJvYcCXGpOVEsaXK2KyTefBN08dgDjU4CzTr5oUf+A3c6VfDndPhMSZIzGIpbi9QsjeH3mEZ4CKGg7d0+bwoe/PwVajd@vger.kernel.org
X-Gm-Message-State: AOJu0YxBOzdUwb5jVJTtYjYzomydGksSDcwlqwbJgNEeTgGTgDookFIy
	AAobw6PGIFcuAVyoC7UwohW4gtwZLOOiNM3vFe832vBDsPei5FF0FbvDtae+2+9n
X-Gm-Gg: ASbGncsMbgxUPAWHKYcMN7IX0pH7fQMvmzW+cN9Om115hHAMNiCFr9R16m67CmPME9t
	N3MHCaCFrXkFI/p2bqP5sry8w/cbLTXfUBWgKfh4NB+EktskBc0jDFTEZ+4Na/hUuVViAhEl5Xs
	/OWcxAtnB+vGX32XgfA1ATmM8ZAl6kWM3Qyo0EJbCNy0Jt15Gi/AP+KSS/f7LmvPYSTIRkpwtXD
	MuwkzFGYPCVmMf+cpfndsdB5mpKuGyqdyAX6IJfvldthiWnXLB+k0lqA0keHhAetlRdSypEl4sH
	v3eB4O25QR94rZ42k+rOv/cwzjKQkvOswoHsIKQbgHJtnvIA7XdYC19ijQRsvyXGntBsADfnjvR
	fZ8XeAwW/1nCUfiuEwJ40Zfc1KIBtHGkTfWqUgAUbDw==
X-Google-Smtp-Source: AGHT+IGjp/d27B15mh/iCxgYPyzUdq+NSC0q/HP11fpvNtIbvXHSgjkABwKputpsq9n74L3QPU6/OA==
X-Received: by 2002:a17:90b:1b4c:b0:31e:f351:bfec with SMTP id 98e67ed59e1d1-32515d111e9mr13119625a91.0.1756104348890;
        Sun, 24 Aug 2025 23:45:48 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4c347sm5978118a91.18.2025.08.24.23.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:45:48 -0700 (PDT)
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
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 3/3] selftests: bonding: add test for LACP actor port priority
Date: Mon, 25 Aug 2025 06:45:16 +0000
Message-ID: <20250825064516.421275-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825064516.421275-1-liuhangbin@gmail.com>
References: <20250825064516.421275-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive selftest to verify:
- Per-port actor priority setting via ad_actor_port_prio
- Aggregator selection behavior with port_priority ad_select policy

Also move cmd_jq helper from forwarding/lib.sh to net/lib.sh for
broader reusability across network selftests.

Here is the result output
  # ./bond_lacp_prio.sh
  TEST: bond 802.3ad (ad_actor_port_prio setting)                  [ OK ]
  TEST: bond 802.3ad (ad_actor_port_prio select)                   [ OK ]
  TEST: bond 802.3ad (ad_actor_port_prio switch)                   [ OK ]

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 107 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  24 ----
 tools/testing/selftests/net/lib.sh            |  24 ++++
 4 files changed, 133 insertions(+), 25 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 44b98f17f8ff..3462783ed3ac 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -11,7 +11,8 @@ TEST_PROGS := \
 	bond_options.sh \
 	bond-eth-type-change.sh \
 	bond_macvlan_ipvlan.sh \
-	bond_passive_lacp.sh
+	bond_passive_lacp.sh \
+	bond_lacp_prio.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
new file mode 100755
index 000000000000..5d067b8ee707
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
@@ -0,0 +1,107 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing if bond lacp per port priority works
+#
+#          Switch (s_ns)          Backup Switch (b_ns)
+#  +-------------------------+ +-------------------------+
+#  |          bond0          | |          bond0          |
+#  |            +            | |            +            |
+#  |      eth0  |  eth1      | |      eth0  |  eth1      |
+#  |        +---+---+        | |        +---+---+        |
+#  |        |       |        | |        |       |        |
+#  +-------------------------+ +-------------------------+
+#           |       |                   |       |
+#  +-----------------------------------------------------+
+#  |        |       |                   |       |        |
+#  |        +-------+---------+---------+-------+        |
+#  |      eth0     eth1       |       eth2     eth3      |
+#  |                          +                          |
+#  |                        bond0                        |
+#  +-----------------------------------------------------+
+#                        Client (c_ns)
+
+lib_dir=$(dirname "$0")
+# shellcheck disable=SC1091
+source "$lib_dir"/../../../net/lib.sh
+
+setup_links()
+{
+	# shellcheck disable=SC2154
+	ip -n "${c_ns}" link add eth0 type veth peer name eth0 netns "${s_ns}"
+	ip -n "${c_ns}" link add eth1 type veth peer name eth1 netns "${s_ns}"
+	# shellcheck disable=SC2154
+	ip -n "${c_ns}" link add eth2 type veth peer name eth0 netns "${b_ns}"
+	ip -n "${c_ns}" link add eth3 type veth peer name eth1 netns "${b_ns}"
+
+	ip -n "${c_ns}" link add bond0 type bond mode 802.3ad miimon 100 \
+		lacp_rate fast ad_select prio
+	ip -n "${s_ns}" link add bond0 type bond mode 802.3ad miimon 100 \
+		lacp_rate fast
+	ip -n "${b_ns}" link add bond0 type bond mode 802.3ad miimon 100 \
+		lacp_rate fast
+
+	ip -n "${c_ns}" link set eth0 master bond0
+	ip -n "${c_ns}" link set eth1 master bond0
+	ip -n "${c_ns}" link set eth2 master bond0
+	ip -n "${c_ns}" link set eth3 master bond0
+	ip -n "${s_ns}" link set eth0 master bond0
+	ip -n "${s_ns}" link set eth1 master bond0
+	ip -n "${b_ns}" link set eth0 master bond0
+	ip -n "${b_ns}" link set eth1 master bond0
+
+	ip -n "${c_ns}" link set bond0 up
+	ip -n "${s_ns}" link set bond0 up
+	ip -n "${b_ns}" link set bond0 up
+}
+
+test_port_prio_setting()
+{
+	RET=0
+	ip -n "${c_ns}" link set eth0 type bond_slave actor_port_prio 1000
+	prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" \
+		".[].linkinfo.info_slave_data.actor_port_prio")
+	[ "$prio" -ne 1000 ] && RET=1
+	ip -n "${c_ns}" link set eth2 type bond_slave actor_port_prio 10
+	prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" \
+		".[].linkinfo.info_slave_data.actor_port_prio")
+	[ "$prio" -ne 10 ] && RET=1
+}
+
+test_agg_reselect()
+{
+	local bond_agg_id slave_agg_id
+	local expect_slave="$1"
+	RET=0
+
+	# Trigger link state change to reselect the aggregator
+	ip -n "${c_ns}" link set eth1 down
+	sleep 1
+	ip -n "${c_ns}" link set eth1 up
+
+	bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" \
+		".[].linkinfo.info_data.ad_info.aggregator")
+	slave_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show $expect_slave" \
+		".[].linkinfo.info_slave_data.ad_aggregator_id")
+	# shellcheck disable=SC2034
+	[ "${bond_agg_id}" -ne "${slave_agg_id}" ] && \
+		RET=1
+}
+
+trap cleanup_all_ns EXIT
+setup_ns c_ns s_ns b_ns
+setup_links
+
+test_port_prio_setting
+log_test "bond 802.3ad" "actor_port_prio setting"
+
+test_agg_reselect eth0
+log_test "bond 802.3ad" "actor_port_prio select"
+
+# Change the actor port prio and re-test
+ip -n "${c_ns}" link set eth0 type bond_slave actor_port_prio 10
+ip -n "${c_ns}" link set eth2 type bond_slave actor_port_prio 1000
+test_agg_reselect eth2
+log_test "bond 802.3ad" "actor_port_prio switch"
+
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 890b3374dacd..08121cb9dc26 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -571,30 +571,6 @@ wait_for_dev()
         fi
 }
 
-cmd_jq()
-{
-	local cmd=$1
-	local jq_exp=$2
-	local jq_opts=$3
-	local ret
-	local output
-
-	output="$($cmd)"
-	# it the command fails, return error right away
-	ret=$?
-	if [[ $ret -ne 0 ]]; then
-		return $ret
-	fi
-	output=$(echo $output | jq -r $jq_opts "$jq_exp")
-	ret=$?
-	if [[ $ret -ne 0 ]]; then
-		return $ret
-	fi
-	echo $output
-	# return success only in case of non-empty output
-	[ ! -z "$output" ]
-}
-
 pre_cleanup()
 {
 	if [ "${PAUSE_ON_CLEANUP}" = "yes" ]; then
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index c7add0dc4c60..4dca6893aa8a 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -645,3 +645,27 @@ wait_local_port_listen()
 		sleep 0.1
 	done
 }
+
+cmd_jq()
+{
+	local cmd=$1
+	local jq_exp=$2
+	local jq_opts=$3
+	local ret
+	local output
+
+	output="$($cmd)"
+	# it the command fails, return error right away
+	ret=$?
+	if [[ $ret -ne 0 ]]; then
+		return $ret
+	fi
+	output=$(echo $output | jq -r $jq_opts "$jq_exp")
+	ret=$?
+	if [[ $ret -ne 0 ]]; then
+		return $ret
+	fi
+	echo $output
+	# return success only in case of non-empty output
+	[ ! -z "$output" ]
+}
-- 
2.50.1


