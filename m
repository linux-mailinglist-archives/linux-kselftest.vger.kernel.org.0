Return-Path: <linux-kselftest+bounces-37934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D18B1034F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F571CE2B2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DF275B0E;
	Thu, 24 Jul 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7ixM7ZV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46E275108;
	Thu, 24 Jul 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345044; cv=none; b=Q3XlFHo1XYcdG2yjo1848g48VQfBX1vEP93B/uT76c7uiEWo8oTZqm8I3f5z4uv55QUVJmjy4zJLrLBvprb/wzC4S+qMjUKtdCmb5iYrpixvxL1HYpCa9sHXm5C51U1k2oBWKmQ11QpF14Jk+Pwd6ZdIe0YUnMneDe52iS61+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345044; c=relaxed/simple;
	bh=MTLT+lV2JBdNmKXaYJ4ZG4ljY/MiMAjjGFtyVb/rW0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccgqWAoZA0uXlOPEgNEr60CiOwbHm8W/y/XSILdVIQ7Qtiy9x4etgR3CZBYyS1eId5hT+4QHwuniuKiYiGVE2JUipf/OMeksY6O24dayWQwNgJL4Onwjpk0rmRNd1lFLg6fqe7TzzVc25lrkYjs2gwvmzKk2BJGrwj6KiPZToVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7ixM7ZV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-75b5be236deso661534b3a.0;
        Thu, 24 Jul 2025 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753345042; x=1753949842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jij+PHwZT95YPs+MTYNdJ41MK7aCYN1i16ExsqGoWoA=;
        b=e7ixM7ZVlAjk5muFRDwodYOauJ05EXCL3pSZmMfUSNtl8ZwkDp26SgJoNGd8gx9YyH
         gWqE0Eh1IEfy+wwV3rm0FyGtd6rGsoJNzt4BR9GV7V3PoY73jWgkBlkZXXFJtYukdHFz
         VHs7jWo/lRHVDFoCyEKf+ruKSYPCVLcwPdRFelUKHyGgZykin83QaMYW1fJwOuDICEYb
         d+1YQb5rCWzz6beRGP3kco/V72KhYtXycHCNuP9b/zoiQgS2V4xCd4mtVTLZsp/S9rxw
         NypvWZ2ZDCX8UgaaDcxQKp0E+AszQpgPjIKAWztA1E1AabH2BWU+a21LsJrN0fdC07LM
         DRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345042; x=1753949842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jij+PHwZT95YPs+MTYNdJ41MK7aCYN1i16ExsqGoWoA=;
        b=NykoKrv3uXh6gVWMRvoo3UUzd27J8YH9H0s21YbKb4jmXuaxTLS7cHzrTaAfm9mha+
         U8Fq7oFE6z/yN8rf8qs/b3fOqrD/m2Va7xuBsrp3YdTOpTzmwlXlNmXAuAu+bMy1O8n1
         Zmd0y8Kf+t7BQ15nG6f5DJefRuh5n0bdwI9BKFUxx+4uQGUJaaOAeIL+Sljlggd7fD5W
         UZ4atULEWKN56sWGNZ2ajewSutz2VRJxhGALhHVBGImrcc22jadz2sMNUHsxowTh4yQU
         K7B7ppzt81hDCNNp2Mo43E2ZMMDnZsvckBBSa9Dw9O3UjaK6sDN73PsXyZRliJRH7U4K
         f7hw==
X-Forwarded-Encrypted: i=1; AJvYcCWqoDyY/vBCZuidqgSWcvIAIQF67aUTZ8In4TtwQ9Zo7pazLbi9++2qMwLI+pLOnL24ALEoGpbaQkE=@vger.kernel.org, AJvYcCX7acDiWVeuuE0068cStlb85lCDgEtCQbXDBiE5s46YD6PufWMeJZDFCvDl9QUbCm0ktUCpOUDL7UtGBdh3/8Ca@vger.kernel.org, AJvYcCXhOEDP6jso1D2oExynthQ4QCbWg0uMpJ5BpoRsc/OMAjLedg19GxpyS5WLNDlNHh3S632E5uqrcDLDSRkc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9OZEQ07XSqatCxtWnpZf0MtRIxn3KLVPCmJPVLxEfamjk149
	nJqlO6QnVMQ2q5HrJBNuHGMBXVShSYMKeMWvUS/UDBwM4lXF8j38akL2DVQ14Ipy
X-Gm-Gg: ASbGncvRGwiCpRRfDpUa7symkNM7g0rqPMNVdcatYpHjhp0iHd/aaour0xPcZZOlWN0
	R2u5ZkiEycgl/DosWaLg8mrUlaJj+fMh0wyeSnGpjm5vI9yJg25g5cEzaUv9h+HVBCMw587b5qi
	69W/I7+ABVa+YpWd8+ugp94zbTRDFVCDTf9iGU0qFPiqil+EVRBwRcniU85q/zBwHKY3kz5Aqu7
	c19oFIkZ03B1N6MHiDo97IfOdLH5xVe/hIRq8jOn+VD34ZwxQ7YKZDrdVLW1Vi1VsOtiS+45SAB
	4EcZ357k4Cb2v4uugQbpgJ/1ClxjkvP630GsHp4uF0KfCDBwqRchh9DhNgPDoyq/wOKzMJpP0po
	g/RHWfSz1A2nogaTTekr79x2MlO3+/rOjhzxrJxe7vBcZbVk=
X-Google-Smtp-Source: AGHT+IG7o3xn5h0i2rZGdHetDDcR0Hu2ewY93q2gD+ugrQIMAHSSbaUTHJHe7hr7X3bCbDKiAOPqSA==
X-Received: by 2002:a05:6a00:a589:b0:747:aa79:e2f5 with SMTP id d2e1a72fcca58-76031771dd1mr8605525b3a.0.1753345041938;
        Thu, 24 Jul 2025 01:17:21 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb7bbeesm1074704b3a.24.2025.07.24.01.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:17:21 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] selftests: bonding: add test for LACP actor port priority
Date: Thu, 24 Jul 2025 08:16:32 +0000
Message-ID: <20250724081632.12921-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250724081632.12921-1-liuhangbin@gmail.com>
References: <20250724081632.12921-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to verify that per-port actor priority (ad_actor_port_prio)
is correctly applied and affects aggregator selection as expected.

Move cmd_jq from forwarding/lib.sh to net/lib.sh.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 73 +++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 24 ------
 tools/testing/selftests/net/lib.sh            | 24 ++++++
 4 files changed, 99 insertions(+), 25 deletions(-)
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
index 000000000000..a3f939d12143
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
@@ -0,0 +1,73 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing if bond lacp per port priority works
+
+lib_dir=$(dirname "$0")
+# shellcheck disable=SC1091
+source "$lib_dir"/../../../net/lib.sh
+
+# create client, switch, backup switch netns
+setup_ns c_ns s_ns b_ns
+defer cleanup_all_ns
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
+ip -n "${c_ns}" link set eth0 type bond_slave ad_actor_port_prio 1000
+prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" ".[].linkinfo.info_slave_data.ad_actor_port_prio")
+[ "$prio" -ne 1000 ] && RET=1
+ip -n "${c_ns}" link set eth2 type bond_slave ad_actor_port_prio 10
+prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" ".[].linkinfo.info_slave_data.ad_actor_port_prio")
+[ "$prio" -ne 10 ] && RET=1
+log_test "bond 802.3ad" "ad_actor_port_prio setting"
+
+# Trigger link state change to reselect the aggregator
+ip -n "${c_ns}" link set eth1 down
+ip -n "${c_ns}" link set eth1 up
+# the active agg should be connect to switch
+bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
+eth0_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" ".[].linkinfo.info_slave_data.ad_aggregator_id")
+if [ "${bond_agg_id}" -ne "${eth0_agg_id}" ]; then
+	RET=1
+fi
+
+# Change the actor port prio and re-test
+ip -n "${c_ns}" link set eth0 type bond_slave ad_actor_port_prio 10
+ip -n "${c_ns}" link set eth2 type bond_slave ad_actor_port_prio 1000
+# Trigger link state change to reselect the aggregator
+ip -n "${c_ns}" link set eth1 down
+ip -n "${c_ns}" link set eth1 up
+# now the active agg should be connect to backup switch
+bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
+eth2_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" ".[].linkinfo.info_slave_data.ad_aggregator_id")
+# shellcheck disable=SC2034
+if [ "${bond_agg_id}" -ne "${eth2_agg_id}" ]; then
+	RET=1
+fi
+log_test "bond 802.3ad" "ad_actor_port_prio switch"
+
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 508f3c700d71..09b63c6f3dbd 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -551,30 +551,6 @@ wait_for_dev()
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
index 006fdadcc4b9..4c278829e04c 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -616,3 +616,27 @@ wait_local_port_listen()
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
2.46.0


