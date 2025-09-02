Return-Path: <linux-kselftest+bounces-40509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8322FB3F5D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB517A7ABD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 06:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2F2E36FD;
	Tue,  2 Sep 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWa0AWvH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5C2E540B;
	Tue,  2 Sep 2025 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795541; cv=none; b=Mv9bP7NReFU1mPwtLj4x+uGdJoWW1UvFPFOb4DvuQPR92VYCo9Hql/y6tnfIVCkTC83fmrs/qLuSh9JsWR2joe/0jFWjOdmg1dOCDPKZQ+X5nKOwwR7rzD30mzchVyhuxLVLKmxUWuI1qSkp8GOZlRdbxyCxOEvHxm8T/8ov3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795541; c=relaxed/simple;
	bh=rmtb2q9MbPGKaUSTzt5qidSt0q9ZAIfPd6d0SEYL5NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVUeP5MvFW4Oa5QjvSEFAzV180PPkvLYhVHVEqO7i6OPWuhj3/d/HlGEyL3efsdYd3+ybWwBUrqfhb4ciPYS+mXTO1iW+Zp5CgXIqL1/vjVfn3fwi4Bk+8KYASPds/RBCrrCkG5VjDKW3X/agEC4KfFDfPAMQFBHKCZPX10iDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWa0AWvH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323266cdf64so4070901a91.0;
        Mon, 01 Sep 2025 23:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756795539; x=1757400339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtcWNmCOv6gMQmL0rij+iQY538S9Maa5imuMzRg+K90=;
        b=JWa0AWvH2GB+ayTgGXBIx/Sc6J/RYV+X1UP8vhhSaGruoZIrUWDYysTNj3AnHEXFCm
         x3oOcYgszzfqDRVN7O4sht0xdQt1T8SyYAiSmQm1vj1RleFwkAbTEUV0ZRfVkpu80hiB
         LEJlMsy1x9sgV+Ve/fC4gQ+cc4VnNI1Q7/OH4sd/Z/3v1JPKFIlR5fR2URl47UdiIFBz
         RHFR6TK4Oq/7ScMVUo+qNBENNN2CmTelDitsZIopT9Drt6UdzP2aoOW2Bf/yiQr5WYxi
         TjsWXeP4K0R/Vzta2+emavRKTEqU/e81hXal5jqEF23c8wOv/3eUhx1fhmj3ESu98nea
         WLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756795539; x=1757400339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtcWNmCOv6gMQmL0rij+iQY538S9Maa5imuMzRg+K90=;
        b=pQf9f8z1bgaswEjVEpfK47AALhAS0X9jguTcdIaIHFbKtiD69e7Ykyz/n+WCEB031p
         2cIjV9lfNwQzSJ1rLstRSYMkFdu5U0po+U3tsG2IeD8EjNu7EBOXYlFPbR5uQvKz2EpZ
         PPIv9YMR06k8bfv/0N3cPtOS3JOyxPBtS5Vk8EEXNdLHeHXtS3BTeSO6ymetNsPqLocq
         Fw5P7WBamV5OMhf/U/A4AK3Bn0xqqPe5mHlxI3SiuOYk4+mFcSFD6tOMg9026qH3Ideu
         598w5wztVbAp3SHGUx1eQpj7fq24GN5h6yyT9AqLOYWCl4/3gyM5v2+Jn3pflE9d/tCJ
         PGBA==
X-Forwarded-Encrypted: i=1; AJvYcCUP6KzmGNGQrmyKpMIqUIakbKaA3I9JivnUTkCOPN6Ndxb+K61yswz266BMw+16WwYRHhzG/HCe1CxeC48KAC71@vger.kernel.org, AJvYcCWjR0wERP7L2oXmNZg6ko4wm61Pbk4XeyVuSjGJKLVz6SCBwPYLkSXgaLossNif/HVLIW9gM1Fs054=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmja01Q21teV14X8BVUTW9tDo8CQwMqnq+p2QUx9rWIqOCC6wK
	uK+XRMAir8ByUhjNeJR7k31hwmQe16CHMBSH2On4mDScwt2EXt4FhGvfD6qRn5gVAgs=
X-Gm-Gg: ASbGncshG0X7xnAnaDOoH48bbEsBgpPewfe2auWmcirRrOKMyxvZJKJ+ozKVP4wwskE
	sSfeU5hy/Vts9ojQCySBzUo0bJMLndG2/SoTxeSK1jhPu+fstQK/rUW1fj4r51dm+uFKunYp02S
	FeO7/FJxeXS5n93yebxY46rRrnBKaqGHv415BfJ5GFnIjDxtlPtEnHA/ACbC28FZPywajBtaD3M
	EGmrIeFaNVcB6hHX3xVUfL94cPQ1q/jnaKGroYZlQjGECBrh62mIw08xETYyajGX7VX7X2Ljy/C
	bggCfUYSmSMziqoXSHq18kDKKAJ+TMZl1o4R0Df3XQh2kyjFE3Ag0q6ZBqdwtXt+xTKlUDlU0I6
	rAlRR4nrz3cOD5s0B1eqZB9Bhhj5y+WSKyFWmXutnjThVzz+eIc4S
X-Google-Smtp-Source: AGHT+IFd8vZ+2Nr+vntvJxcPdYfnYzuJZodQS7WSFwE0LEVxJWsc7sCiWwmsSpdgvoZ5Qe5Th8PnjQ==
X-Received: by 2002:a17:90b:3c05:b0:324:e794:70b1 with SMTP id 98e67ed59e1d1-32815412ac1mr14734934a91.4.1756795538882;
        Mon, 01 Sep 2025 23:45:38 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd2ea3a04sm10936681a12.38.2025.09.01.23.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:45:38 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCHv5 net-next 3/3] selftests: bonding: add test for LACP actor port priority
Date: Tue,  2 Sep 2025 06:45:01 +0000
Message-ID: <20250902064501.360822-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902064501.360822-1-liuhangbin@gmail.com>
References: <20250902064501.360822-1-liuhangbin@gmail.com>
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
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 108 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  24 ----
 tools/testing/selftests/net/lib.sh            |  24 ++++
 4 files changed, 134 insertions(+), 25 deletions(-)
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
index 000000000000..a483d505c6a8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
@@ -0,0 +1,108 @@
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
+		lacp_rate fast ad_select actor_port_prio
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
+	sleep 0.5
+	ip -n "${c_ns}" link set eth1 up
+	sleep 0.5
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


