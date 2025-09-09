Return-Path: <linux-kselftest+bounces-41028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A5B4A506
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB38B17161A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62324EA9D;
	Tue,  9 Sep 2025 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgThm+Sx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452124BBE4;
	Tue,  9 Sep 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405984; cv=none; b=kHzChsY01i96yMkwVJ2AJ6Y8jqmOHGcsqsrA3fGQX7PeYz5dB9hV9knxkBcHsvs4MxK0T5OfZrgc3OmdKcx0wxA9SLf2xvPvL3DDF+gD/XGS4pTKRJ7YjZxnV9XW2wRXoX7BEhv5Jwmz5AJDwcVDS4DJohQXJK07ip1gvTlI4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405984; c=relaxed/simple;
	bh=Dgcs8MxHanr/0OJzZegDekRCw8UWXjmqJbMOO/yf2ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJqcIVgoOASaxpxStbc9uf5UDvnjIytKqGzpizjar1Yq7kYhawTevVIoYaBA+TfKVo5/p62LS68fxExP+yuR2++efvbdHUXe2kpy/82xUh9PnD5ub1om78bXc1a8NacSP9Afa8e3wH0w6MbDVYCdsDjPdlERGyTcpYZrRYIrimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgThm+Sx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2518a38e7e4so31401415ad.1;
        Tue, 09 Sep 2025 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405982; x=1758010782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kkYMhRFqiCQOalVGgl3DPBxokTZqQJbI+Err9BZ1ds=;
        b=RgThm+SxQ2rQ53XEcPekeTefc6JEHaWOoLPbJ91qTpKlhXwMJ8CgeZUSrTYOft+QCS
         1zT2JKO8CSYUu4BPjjk/Mpw7yEK7feuCc8i1Vj0utXNuFv85nhlVnuWo0ifkeR+x/dSE
         SxWq6nnrHgYElI65j6B1/VTN1sKuWyXDNMurtDGKB5z7UE2wJxbfcjccReFFW0TUWkHe
         KbiA/PjZ8f4VAIeRBWRnd5h6VhUY+ftjlLSley4rlksbtAtSmp7LaDb2LIu6XnilWeG+
         z7Kd4Q8iyanvkxl6zoLyQdSSaaoIdFREA56gJcmujHsBGexkiE+h/G+S0ZNIuWvBsihN
         vCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405982; x=1758010782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kkYMhRFqiCQOalVGgl3DPBxokTZqQJbI+Err9BZ1ds=;
        b=EmynhUaxk3sUlUOf3XS9cD7u3b1pf+wawqKH2V7kg7Aq+zOdpMlVO0ujxMbNuU3eVd
         DfcTGYNlqnDrigTzZ7xQwn+KtE9fEIYiZjUbEXtItJK6u35MfOvNkWrndDxWYFHhnV5D
         y+gto/pMJc1nzbyS44R8SpcUasGHbM38dYMiJ0f7yOib6Egg2cDNaeMLmLVn+76wA+/k
         4vLSBn45nChTYcvqDgM6qBjd0pQSxE3u/lF+1OP6/F9eNyHa8LYT6ETPQcQqwz5KgxUV
         pi4m6PTtc294gCDcDHm6awRjfX5jxTG13uCXsIO1oHosCSjIuPfQgGQTKDuczD84Fyqe
         sF4w==
X-Forwarded-Encrypted: i=1; AJvYcCUUJ0Y6hc2Z3JZdmiBWmw8i6zTZ1VGFFb8/huQfuYAGoONuyyNk0C5tGEIwEJ+SvbJ+FKguHH0vAOgyvjJNYm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGi0p4dcGBTm9lggqTmgEm3kRk/42EUchgFmzMPsSmR7Lro3/w
	mGtXYSYrVZbI0P4SCJaxedevEdy/N5AAISb0lDBP+89LM/g/0so8d7+FcBlvX0nG4ag=
X-Gm-Gg: ASbGncsHKihUVcAW7onAM6ISCtADk9anu9bPB5oM58h3xgo3gamy/YS24aRAHTHO5HY
	EoGVRp70I5ccguy3PizsEuY/+CiuSgMaXNazEgbziigIMD+zv9NRP4GEqECU2Qq+osCA36fduw6
	evZLmxDysZfweKXM4JVGA5vfNgUIHegfwNsG9xuUmKXxGEPWJN2sKxwzuv9NpCLgvZGtuQ0qmpK
	ATykSwdIsEq9ovmYAKwujr/u0vEk379FeVUj+kW/IXlIzFu1lOE8SfGDK2hCRsLManQtAMXJkce
	AgqJtpmJGookeSprPBwKtcBo7Kh0OJai0mXLN0Eug5qpTBvgCzoNEx+7MJrFpJkfFalypJ1fIQM
	2CBY6+RZCVKhpqrj/JhjRyLB5LrnHw9Vh6WdJKHih232iNKvtOSGC
X-Google-Smtp-Source: AGHT+IFPsqO9J0V2j7nWY4KCNV3228rVBXepKIlN3pJACIgkvAeC/KXN1N0FIs6Qijs0xiVKkktqgQ==
X-Received: by 2002:a17:902:e811:b0:244:5bbe:acdd with SMTP id d9443c01a7336-25179f34dc0mr127684515ad.27.1757405981836;
        Tue, 09 Sep 2025 01:19:41 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm174370575ad.83.2025.09.09.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:19:41 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 5/5] selftests/net: add offload checking test for virtual interface
Date: Tue,  9 Sep 2025 08:18:52 +0000
Message-ID: <20250909081853.398190-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250909081853.398190-1-liuhangbin@gmail.com>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make sure the virtual interface offload setting is correct after
changing lower devices.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/Makefile        |   1 +
 tools/testing/selftests/net/config          |   1 +
 tools/testing/selftests/net/vdev_offload.sh | 137 ++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8c860782f9cd..c77c55677a3a 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -119,6 +119,7 @@ TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
 TEST_PROGS += route_hint.sh
+TEST_PROGS += vdev_offload.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d548611e2698..da4212373b84 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -128,3 +128,4 @@ CONFIG_NETKIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_IPV6_ILA=m
 CONFIG_IPV6_RPL_LWTUNNEL=y
+CONFIG_NET_TEAM=m
diff --git a/tools/testing/selftests/net/vdev_offload.sh b/tools/testing/selftests/net/vdev_offload.sh
new file mode 100755
index 000000000000..17b89a40a7d3
--- /dev/null
+++ b/tools/testing/selftests/net/vdev_offload.sh
@@ -0,0 +1,137 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# shellcheck disable=SC1091
+source lib.sh
+
+# Set related offload on lower deivces and check if upper device re-compute
+# Some features are fixed on veth interface. Just list here in case we have a
+# better way to test in future.
+set_offload()
+{
+	local dev="$1"
+	local state="$2"
+
+	# VLAN features
+	# NETIF_F_FRAGLIST: tx-scatter-gather-fraglist
+	# shellcheck disable=SC2154
+	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather-fraglist "$state"
+
+	# ENC features
+	# NETIF_F_RXCSUM: rx-checksum (bond/team/bridge fixed)
+
+	# XFRM features (veth fixed, netdevsim supports)
+	# NETIF_F_HW_ESP: esp-hw-offload
+	# NETIF_F_GSO_ESP: tx-esp-segmentation
+
+	# GSO partial features
+	# NETIF_F_GSO_PARTIAL: tx-gso-partial (veth/bond fixed)
+
+	# Common features
+	# NETIF_F_SG: tx-scatter-gather
+	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather "$state" &> /dev/null
+	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_ACCECN: tx-tcp-accecn-segmentation
+	ip netns exec "$ns" ethtool -K "$dev" tx-tcp-accecn-segmentation "$state"
+	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_SCTP: tx-sctp-segmentation
+	ip netns exec "$ns" ethtool -K "$dev" tx-sctp-segmentation "$state"
+	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_FRAGLIST: tx-gso-list
+	ip netns exec "$ns" ethtool -K "$dev" tx-gso-list "$state"
+}
+
+__check_offload()
+{
+	local dev=$1
+	local opt=$2
+	local expect=$3
+
+	ip netns exec "$ns" ethtool --json -k "$dev" | \
+		jq -r -e ".[].\"$opt\".active == ${expect}" >/dev/null
+}
+
+check_offload()
+{
+	local dev=$1
+	local state=$2
+
+	__check_offload "$dev" "tx-scatter-gather-fraglist" "$state" || RET=1
+	__check_offload "$dev" "tx-scatter-gather" "$state" || RET=1
+	__check_offload "$dev" "tx-tcp-accecn-segmentation" "$state" || RET=1
+	__check_offload "$dev" "tx-sctp-segmentation" "$state" || RET=1
+	__check_offload "$dev" "tx-gso-list" "$state" || RET=1
+}
+
+setup_veth()
+{
+	# Set up test netns
+	setup_ns ns switch
+
+	# shellcheck disable=SC2154
+	ip -n "$ns" link add veth0 type veth peer name veth0 netns "$switch"
+	ip -n "$ns" link add veth1 type veth peer name veth1 netns "$switch"
+	ip -n "$switch" link set veth0 up
+	ip -n "$switch" link set veth1 up
+
+	link_0=veth0
+	link_1=veth1
+}
+
+cleanup()
+{
+	cleanup_all_ns
+}
+
+setup_bond()
+{
+	ip -n "$ns" link set "$link_0" nomaster
+	ip -n "$ns" link set "$link_1" nomaster
+	ip -n "$ns" link add bond0 type bond mode active-backup miimon 100
+	ip -n "$ns" link set "$link_0" master bond0
+	ip -n "$ns" link set "$link_1" master bond0
+	ip -n "$ns" link set bond0 up
+}
+
+setup_team()
+{
+	ip -n "$ns" link set "$link_0" nomaster
+	ip -n "$ns" link set "$link_1" nomaster
+	ip -n "$ns" link add team0 type team
+	ip -n "$ns" link set "$link_0" master team0
+	ip -n "$ns" link set "$link_1" master team0
+	ip -n "$ns" link set team0 up
+}
+
+setup_bridge()
+{
+	ip -n "$ns" link set "$link_0" nomaster
+	ip -n "$ns" link set "$link_1" nomaster
+	ip -n "$ns" link add br0 type bridge
+	ip -n "$ns" link set "$link_0" master br0
+	ip -n "$ns" link set "$link_1" master br0
+	ip -n "$ns" link set br0 up
+}
+
+do_test()
+{
+	local dev=$1
+
+	RET=0
+	set_offload veth0 "on"
+	set_offload veth1 "on"
+	check_offload "$dev" "true"
+	log_test "$dev" "enable offload"
+
+	RET=0
+	set_offload veth0 "off"
+	set_offload veth1 "off"
+	check_offload "$dev" "false"
+	log_test "$dev" "disable offload"
+}
+
+trap cleanup EXIT
+setup_veth
+setup_bond
+do_test bond0
+setup_team
+do_test team0
+setup_bridge
+do_test br0
-- 
2.50.1


