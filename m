Return-Path: <linux-kselftest+bounces-42267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B311B9D35A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 04:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D5B3A7224
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 02:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA12DE6ED;
	Thu, 25 Sep 2025 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFf90FJo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B92D8360
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767607; cv=none; b=l7lSeqYtWE5E/37k4snYTr3XedLE+CLqa2jKNWJ5HJVXze5ejMXcyCx02K7NWpz8rNvxX6ekE+svlFFGeCg7z67Jafuax8xhTG8sKrQW1E7AmQcy+8g7irYP6LmdMY7pjUJDyJ4895tIgTzrJQoph5rSy/BWVj+vTz4hVONmQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767607; c=relaxed/simple;
	bh=2GgT+/bIGWUh0Zo1qFAZZaQ2gOXKobW1e3IMD+Ql+G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvsrYG05oGFl9Z9SxyP/fTPzuWgFjdB3CEgg4fpeL9qUkxvU2/QDk0I8g6uJXrifezahQAWLSD+ReYIoHetIqAdrhaA8edBQPygy0p2AJ2sGsUu2heYBG1FHKkB4c/VGu7tPMbrPhkcAoaPcfHghnmRhrhumhbkHX8dAhnaI4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFf90FJo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-780f6632e64so284173b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 19:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758767604; x=1759372404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbrI7IN9vr5Pwbxxiph1tkV49TqqLtSdV+f8CWz+hCo=;
        b=QFf90FJovsLMwwObqGbqrNWcKx+t3qVbL88sy621agDBGV9KEv2xZhuf3h+UQ5xpm4
         BKKVdA850fclDFz4YPXR9WuMPBeO6tt75dIcpBy3sl4gy+guI1SfuUnuNjOk8OePMXsj
         nGevZCuSQ10K4zgqDP9zMIumB8QRVQhTLmjle/kizSNF0BU8/JA3srjkE0QDvUio+4Kb
         1n32RQUPEyA6cJaOAa3hqx2MUzuoa3OTc4eH0SxyN0EbHS3OZmV/bT36cqt1RwZVTLHY
         7JO14kPtUKFo/E5gZ53vV6CqTetDpF4gqTT3n8XGkoPkDXzErRH2qyQThBwszDvALgFb
         rZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767604; x=1759372404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbrI7IN9vr5Pwbxxiph1tkV49TqqLtSdV+f8CWz+hCo=;
        b=xBjkdsEyC/8ErbuacjVamxBu12j+qS2RR95M8MtIOGFCZufvArq5WuL6tDMZosUrR2
         11psspmLnDGOQej0e33ap1U+9JcoJ5Pl0IJPMePmUr73Vp8d7qWryDK448RwC1OA53NX
         kRAiwSbcrADiQiuwpRhpvX/ydcmRShTQsEL7A/Vr05C/hTeYFsA3MpO/6TGAEc/RUvXc
         T0LC3XUDFL8vFvoChLFQPYo2fgBQIjCPOUbTJfwsuuyBCKe0xsoelhBsHI47TBLKPh1d
         gCBfJJwmfsIWjU5j5V3ehB0kaqvMbGYjPsAOyGYYekItpsLEn8DKtz4w3if2goan9rvo
         v56A==
X-Forwarded-Encrypted: i=1; AJvYcCVKqzy6vQCn1wH7cV2OVndVLA1KV1+J8iNhaw9ZV24uN1lsa0KM4Qa8JWLc+K9DovYMWzsJ/vBDmBXXxVC79uU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50qRYxoSuP2o6lbTgd+oHUMWFuORwBVMw8yx9CAtEDs8wwQd3
	CaOXq7q3niqCYZTW/yA8hAP6asECtPW9VO0aHAiHoq+Gk9upd8bUPjRW
X-Gm-Gg: ASbGncseIjVvFW3Xvz5pl7sO6bktE/MOgO2sjRIA2Q+4uVBdrFXRKHmxguR3XNPviEb
	pY4W2F7Nt2OGtxLyYqt5nJirVGvj2Cvp73Uzy4QGi4L8WpM5Q4iVWBDGBg7MUMa8+Anxm+qDkCV
	nDscth0DRWa39RgfWDrPWSXC4UTLlTarABDi0WhSsHkzeXJA9M3U9PsKGUS6qGRyd5qJmA4AmW0
	Pzsn1j5DIhfNCqLad7eeH/NOi0lh0k1cFxFpxKmgPLc7tFvQ/F6vV/NTiPgc0KlnS+k2oSS5l5W
	tOGlBlzTnVGnOtFspshl+hTM4Gc7JMxnKNVZkBL2i5iQJJhC5sWUxeHOIsyJzcWIstc/BszfAhU
	2oIo4j/uBNlqbCtAz4fsYmD+K8um9rCLMtefuYL0dV8AwPb7mnfkX
X-Google-Smtp-Source: AGHT+IEpXppuwXRh2ZE6G69rH/UxkMFKQ377pJNZmMGNRQIjKhzdNyiQYshjnt6IpK2/KQnT6h2pMw==
X-Received: by 2002:a05:6a00:92a3:b0:780:f8f9:878a with SMTP id d2e1a72fcca58-780fced5e28mr2253974b3a.21.1758767604358;
        Wed, 24 Sep 2025 19:33:24 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78105a81540sm125952b3a.14.2025.09.24.19.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:33:23 -0700 (PDT)
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
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 2/2] selftests: bonding: add ipsec offload test
Date: Thu, 25 Sep 2025 02:33:04 +0000
Message-ID: <20250925023304.472186-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925023304.472186-1-liuhangbin@gmail.com>
References: <20250925023304.472186-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces a test for IPSec offload over bonding, utilizing netdevsim
for the testing process, as veth interfaces do not support IPSec offload.
The test will ensure that the IPSec offload functionality remains operational
even after a failover event occurs in the bonding configuration.

Here is the test result:

TEST: bond_ipsec_offload (active_slave eth0)                        [ OK ]
TEST: bond_ipsec_offload (active_slave eth1)                        [ OK ]

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: fix shellcheck errors
v2: rebase to latest net, no code update
---
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 156 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 44b98f17f8ff..c13ef40e7db1 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -11,7 +11,8 @@ TEST_PROGS := \
 	bond_options.sh \
 	bond-eth-type-change.sh \
 	bond_macvlan_ipvlan.sh \
-	bond_passive_lacp.sh
+	bond_passive_lacp.sh \
+	bond_ipsec_offload.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
new file mode 100755
index 000000000000..f09e100232c7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
@@ -0,0 +1,156 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# IPsec over bonding offload test:
+#
+#  +----------------+
+#  |     bond0      |
+#  |       |        |
+#  |  eth0    eth1  |
+#  +---+-------+----+
+#
+# We use netdevsim instead of physical interfaces
+#-------------------------------------------------------------------
+# Example commands
+#   ip x s add proto esp src 192.0.2.1 dst 192.0.2.2 \
+#            spi 0x07 mode transport reqid 0x07 replay-window 32 \
+#            aead 'rfc4106(gcm(aes))' 1234567890123456dcba 128 \
+#            sel src 192.0.2.1/24 dst 192.0.2.2/24
+#            offload dev bond0 dir out
+#   ip x p add dir out src 192.0.2.1/24 dst 192.0.2.2/24 \
+#            tmpl proto esp src 192.0.2.1 dst 192.0.2.2 \
+#            spi 0x07 mode transport reqid 0x07
+#
+#-------------------------------------------------------------------
+
+lib_dir=$(dirname "$0")
+# shellcheck disable=SC1091
+source "$lib_dir"/../../../net/lib.sh
+srcip=192.0.2.1
+dstip=192.0.2.2
+ipsec0=/sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
+ipsec1=/sys/kernel/debug/netdevsim/netdevsim0/ports/1/ipsec
+active_slave=""
+
+# shellcheck disable=SC2317
+active_slave_changed()
+{
+	local old_active_slave=$1
+	local new_active_slave
+
+	# shellcheck disable=SC2154
+	new_active_slave=$(ip -n "${ns}" -d -j link show bond0 | \
+		jq -r ".[].linkinfo.info_data.active_slave")
+	[ "$new_active_slave" != "$old_active_slave" ] && [ "$new_active_slave" != "null" ]
+}
+
+test_offload()
+{
+	# use ping to exercise the Tx path
+	ip netns exec "$ns" ping -I bond0 -c 3 -W 1 -i 0 "$dstip" >/dev/null
+
+	active_slave=$(ip -n "${ns}" -d -j link show bond0 | \
+		       jq -r ".[].linkinfo.info_data.active_slave")
+
+	if [ "$active_slave" = "$nic0" ]; then
+		sysfs=$ipsec0
+	elif [ "$active_slave" = "$nic1" ]; then
+		sysfs=$ipsec1
+	else
+		check_err 1 "bond_ipsec_offload invalid active_slave $active_slave"
+	fi
+
+	# The tx/rx order in sysfs may changed after failover
+	grep -q "SA count=2 tx=3" "$sysfs" && grep -q "tx ipaddr=$dstip" "$sysfs"
+	check_err $? "incorrect tx count with link ${active_slave}"
+
+	log_test bond_ipsec_offload "active_slave ${active_slave}"
+}
+
+setup_env()
+{
+	if ! mount | grep -q debugfs; then
+		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
+		defer umount /sys/kernel/debug/
+
+	fi
+
+	# setup netdevsim since dummy/veth dev doesn't have offload support
+	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
+		if ! modprobe -q netdevsim; then
+			echo "SKIP: can't load netdevsim for ipsec offload"
+			# shellcheck disable=SC2154
+			exit "$ksft_skip"
+		fi
+		defer modprobe -r netdevsim
+	fi
+
+	setup_ns ns
+	defer cleanup_ns "$ns"
+}
+
+setup_bond()
+{
+	ip -n "$ns" link add bond0 type bond mode active-backup miimon 100
+	ip -n "$ns" addr add "$srcip/24" dev bond0
+	ip -n "$ns" link set bond0 up
+
+	echo "0 2" | ip netns exec "$ns" tee /sys/bus/netdevsim/new_device >/dev/null
+	nic0=$(ip netns exec "$ns" ls /sys/bus/netdevsim/devices/netdevsim0/net | head -n 1)
+	nic1=$(ip netns exec "$ns" ls /sys/bus/netdevsim/devices/netdevsim0/net | tail -n 1)
+	ip -n "$ns" link set "$nic0" master bond0
+	ip -n "$ns" link set "$nic1" master bond0
+
+	# we didn't create a peer, make sure we can Tx by adding a permanent
+	# neighbour this need to be added after enslave
+	ip -n "$ns" neigh add "$dstip" dev bond0 lladdr 00:11:22:33:44:55
+
+	# create offloaded SAs, both in and out
+	ip -n "$ns" x p add dir out src "$srcip/24" dst "$dstip/24" \
+	    tmpl proto esp src "$srcip" dst "$dstip" spi 9 \
+	    mode transport reqid 42
+
+	ip -n "$ns" x p add dir in src "$dstip/24" dst "$srcip/24" \
+	    tmpl proto esp src "$dstip" dst "$srcip" spi 9 \
+	    mode transport reqid 42
+
+	ip -n "$ns" x s add proto esp src "$srcip" dst "$dstip" spi 9 \
+	    mode transport reqid 42 aead "rfc4106(gcm(aes))" \
+	    0x3132333435363738393031323334353664636261 128 \
+	    sel src "$srcip/24" dst "$dstip/24" \
+	    offload dev bond0 dir out
+
+	ip -n "$ns" x s add proto esp src "$dstip" dst "$srcip" spi 9 \
+	    mode transport reqid 42 aead "rfc4106(gcm(aes))" \
+	    0x3132333435363738393031323334353664636261 128 \
+	    sel src "$dstip/24" dst "$srcip/24" \
+	    offload dev bond0 dir in
+
+	# does offload show up in ip output
+	lines=$(ip -n "$ns" x s list | grep -c "crypto offload parameters: dev bond0 dir")
+	if [ "$lines" -ne 2 ] ; then
+		check_err 1 "bond_ipsec_offload SA offload missing from list output"
+	fi
+}
+
+trap defer_scopes_cleanup EXIT
+setup_env
+setup_bond
+
+# start Offload testing
+test_offload
+
+# do failover and re-test
+ip -n "$ns" link set "$active_slave" down
+slowwait 5 active_slave_changed "$active_slave"
+test_offload
+
+# make sure offload get removed from driver
+ip -n "$ns" x s flush
+ip -n "$ns" x p flush
+line0=$(grep -c "SA count=0" "$ipsec0")
+line1=$(grep -c "SA count=0" "$ipsec1")
+[ "$line0" -ne 1 ] || [ "$line1" -ne 1 ]
+check_fail $? "bond_ipsec_offload SA not removed from driver"
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 832fa1caeb66..e5b7a8db4dfa 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -11,3 +11,7 @@ CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=m
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
+CONFIG_XFRM_USER=m
+CONFIG_NETDEVSIM=m
-- 
2.50.1


