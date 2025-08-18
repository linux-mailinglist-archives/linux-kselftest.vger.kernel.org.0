Return-Path: <linux-kselftest+bounces-39221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7662B29DAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5046A2A1967
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3689930DD2B;
	Mon, 18 Aug 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQfLSVaK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47B2D7D42;
	Mon, 18 Aug 2025 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509051; cv=none; b=RR+PsOO9g+70ru1TCzfyeWuHMmMVrPw2fsWL+7+p8K1lO+fphi90L/z/BCn8o18idbzmb18Zt4PY/V0j75rN/hn4UVDZkVxPz08/9TsGJKSE1dXnqerpMLV0Uj6h7K3Zme8rx3DMWsIRQXDQgt34nZrZ73EmvUU88Dc7nLDdfT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509051; c=relaxed/simple;
	bh=X8nmr9qsKs4h4u/cszFlNiuhe94La6FOdDYXtOeWPn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k97xS503T3TXrmvryVgli2IIi/1w2qrYPFXXQlUCrAZRlWGN4ev4t1fbi4jWwFR7JvHxYEtiHWdMYOFf5pe0Dqmj1hyNMCM/OhXD3hnTJhtcwiq+MLDjHIZQTC1K7bJYRNxfb2gWZvXjqbhzGWeiZFga9EEd25CqwyspkXtgbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQfLSVaK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e613e90so2759639b3a.0;
        Mon, 18 Aug 2025 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509048; x=1756113848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I+GypEpIQ7J3iEd2raeG4lCfRBgtCb1Ib07unm/9ow=;
        b=kQfLSVaKj2gBcF5CoM6wHPPprRqVomZFdjpN327daAr/gJdlpcNuKY7W4sSfFy8ypD
         hnkprU3mSH67YDcxWLNphznLP/qSYpeBwlpFQeJ5krChRIdtloG/isB+KGtWDrFMbRVN
         q/BWCqXTp9fQ2xOTlPyphf5cR1W/Uc4sbA2DWEyXqGqWMvl/C74XlZ4M71+uqCm0XBlP
         YN5pnfs8St77mUkMLW7IYcSWJIO+MFRbP8v5RX/ggNIE8kfXPPNxrqnOF7cKcNIqR8FD
         hvivnNARlOmy6NmubZzZqN+mpBxCkGiyF7PPE/z1PQykshJ6ZvaaAvWiW/jtyutVcvQi
         OnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509048; x=1756113848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I+GypEpIQ7J3iEd2raeG4lCfRBgtCb1Ib07unm/9ow=;
        b=MtGGsLZ8DEoz9mkxg/rfIpAQ8M+Dduo9nO7ibtTdmJJ5FHUJlVl43hs4n7l3Fq1FI7
         CDH4M6NXwgjrt+LJddEdYUyrpTeCPuCIadVR6JNqyFqckgg0Pg8+1FpxMQNKSVGaSFiL
         oFPueLfRARnIujZtwV9UUd6hHVhLwtARk9bl7D45xxNctG79a7IJJgYkRt8IkkHGnHV8
         IJMKrXIFMKT8fMJjM3g3+LBkskekig0eL822j27gchHoNDYNsQLRNiLNSNrUIZD2CikF
         FnigfMhS5TKsevHe86KeXtXJ/YJ4F3yo9bTCBM1lkE6ZnBafcfa8SsqEg1+PjZzD+OlG
         YqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiX7qGf1+7BlbCiTwOev9zJl+fkUQuJYBfo6g603FN4ug4HEmRJr1UHBBj0Xqkd3wkkxj0ipXOcpxW7usB/5pc@vger.kernel.org, AJvYcCXZDSqYOn/VQs5MhVLP4tFW9625aOuUKofjwt4JrAtWW6OUA0I/scq0So4IWYm3LoplMZM51CXRSOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmDuuD56Q2avEzj1LiXeMBdGif+syduhiFmtwTpBzx8vhUBd8P
	Mnx0Ahkw19hyNmqapfSmNPfw2c/f0EATa4klnVItIWFd4RX7sX1xfNi9Ilo5J628+cA=
X-Gm-Gg: ASbGncvjosFFHcoSyqoPNu3lr5/sEKNXvvRaVPsLLRvaDVhweUD1TQUSOzaCDQxyicf
	KA7y7SsP6AlAf9xmIM4E/bI3nsWKC3iOoAVrysuxlj2U7TqRx5xUNvBgpxikPuTikGF/GwuCmmx
	tXzNDGfcJmYVIUnONhywffu31bCW7xfw7nG8qoLE/4yJIJaC6Jg4V0FOMnV7rGofVuLL0BN2TJe
	nRMhEWqm793yPYNJt42D1yp9KzpxnzyBELL9Bvx/oUx2NWFBi78JLQDeHo16/f2so8ZMw+9S3YU
	yDZX3dVoK+24vHrdiM/2tSuMv4uzS+joj0t4MnwBuRxEDvHf/SqBIAMJKwmny3ZFJ85Gq87fkrz
	A/3vI4f5UuBn1qgxuiaysLerV11Z9DcuNZu1GTkPbSw==
X-Google-Smtp-Source: AGHT+IG++R3oSldT2C5mBGUKzHiXlKfEX8oVQlXAb+se733Lo9uuYmfzRHoKWywIpJEEuE8W8LqslQ==
X-Received: by 2002:a05:6a20:a11e:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-240d2f2190dmr17255968637.30.1755509048348;
        Mon, 18 Aug 2025 02:24:08 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45592eeesm6604976b3a.104.2025.08.18.02.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:24:07 -0700 (PDT)
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
Subject: [PATCHv3 net-next 3/3] selftests: bonding: add test for LACP actor port priority
Date: Mon, 18 Aug 2025 09:23:11 +0000
Message-ID: <20250818092311.383181-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818092311.383181-1-liuhangbin@gmail.com>
References: <20250818092311.383181-1-liuhangbin@gmail.com>
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
  TEST: bond 802.3ad (ad_actor_port_prio setting)                     [ OK ]
  TEST: bond 802.3ad (ad_actor_port_prio select)                      [ OK ]
  TEST: bond 802.3ad (ad_actor_port_prio switch)                      [ OK ]

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 93 +++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 24 -----
 tools/testing/selftests/net/lib.sh            | 24 +++++
 4 files changed, 119 insertions(+), 25 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 2b10854e4b1e..32617a834a6b 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -10,7 +10,8 @@ TEST_PROGS := \
 	mode-2-recovery-updelay.sh \
 	bond_options.sh \
 	bond-eth-type-change.sh \
-	bond_macvlan_ipvlan.sh
+	bond_macvlan_ipvlan.sh \
+	bond_lacp_prio.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
new file mode 100755
index 000000000000..491ad9be3a93
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
@@ -0,0 +1,93 @@
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
+RET=0
+
+trap cleanup_all_ns EXIT
+# create client, switch, backup switch netns
+setup_ns c_ns s_ns b_ns
+
+# setup links
+# shellcheck disable=SC2154
+ip -n "${c_ns}" link add eth0 type veth peer name eth0 netns "${s_ns}"
+ip -n "${c_ns}" link add eth1 type veth peer name eth1 netns "${s_ns}"
+# shellcheck disable=SC2154
+ip -n "${c_ns}" link add eth2 type veth peer name eth0 netns "${b_ns}"
+ip -n "${c_ns}" link add eth3 type veth peer name eth1 netns "${b_ns}"
+
+ip -n "${c_ns}" link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast ad_select prio
+ip -n "${s_ns}" link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast
+ip -n "${b_ns}" link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast
+
+ip -n "${c_ns}" link set eth0 master bond0
+ip -n "${c_ns}" link set eth1 master bond0
+ip -n "${c_ns}" link set eth2 master bond0
+ip -n "${c_ns}" link set eth3 master bond0
+ip -n "${s_ns}" link set eth0 master bond0
+ip -n "${s_ns}" link set eth1 master bond0
+ip -n "${b_ns}" link set eth0 master bond0
+ip -n "${b_ns}" link set eth1 master bond0
+
+ip -n "${c_ns}" link set bond0 up
+ip -n "${s_ns}" link set bond0 up
+ip -n "${b_ns}" link set bond0 up
+
+# set ad actor port priority, default 255
+ip -n "${c_ns}" link set eth0 type bond_slave actor_port_prio 1000
+prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" ".[].linkinfo.info_slave_data.actor_port_prio")
+[ "$prio" -ne 1000 ] && RET=1
+ip -n "${c_ns}" link set eth2 type bond_slave actor_port_prio 10
+prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" ".[].linkinfo.info_slave_data.actor_port_prio")
+[ "$prio" -ne 10 ] && RET=1
+log_test "bond 802.3ad" "actor_port_prio setting"
+
+# Trigger link state change to reselect the aggregator
+ip -n "${c_ns}" link set eth1 down
+sleep 1
+ip -n "${c_ns}" link set eth1 up
+# the active agg should be connect to switch
+bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
+eth0_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" ".[].linkinfo.info_slave_data.ad_aggregator_id")
+[ "${bond_agg_id}" -ne "${eth0_agg_id}" ] && RET=1
+log_test "bond 802.3ad" "actor_port_prio select"
+
+# Change the actor port prio and re-test
+ip -n "${c_ns}" link set eth0 type bond_slave actor_port_prio 10
+ip -n "${c_ns}" link set eth2 type bond_slave actor_port_prio 1000
+# Trigger link state change to reselect the aggregator
+ip -n "${c_ns}" link set eth1 down
+sleep 1
+ip -n "${c_ns}" link set eth1 up
+# now the active agg should be connect to backup switch
+bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
+eth2_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" ".[].linkinfo.info_slave_data.ad_aggregator_id")
+# shellcheck disable=SC2034
+if [ "${bond_agg_id}" -ne "${eth2_agg_id}" ]; then
+	RET=1
+fi
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


