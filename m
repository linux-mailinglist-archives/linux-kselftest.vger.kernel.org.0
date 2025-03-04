Return-Path: <linux-kselftest+bounces-28206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949FAA4DEF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FF53B4222
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 13:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FF0204C3E;
	Tue,  4 Mar 2025 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umx4xlsM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F63204C1E;
	Tue,  4 Mar 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093912; cv=none; b=cf7PBcFWKsDD5Xvfzr7yIa/WE/1g7AyX2wFSEIhMW+EODUT5ACvfw7z0vG/eeFdlx0jtT/NkxG8OiToLeYrgPR+j+etg2Ed3t4RFSyM3009uyIuKpx7MMZWcPgIVo5CyJnDpOgvywWDSnB1VZEj2mA1MeRITtBCWzBm+/h9XbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093912; c=relaxed/simple;
	bh=CVNUGFCMu8pB9FIblXe0H3eHuWlR9XEnZTlypbRs3rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nObE9Urku7aG+tl9wo5f2/HaLOgs/rHcyDODRAfSwGFR+JBArl/CPWALwKWndWi8VWMFXn1WQvRnH6KTG3juXt4qruGdD5X43amV6djc+1d5TmNSNb4ry4cMQRLH1obRzB6EwzEu0r8YYHLxel5GECiO7sFv17CLm2l4BSl2CPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Umx4xlsM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22349dc31bcso96959365ad.3;
        Tue, 04 Mar 2025 05:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741093909; x=1741698709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/wzkrlUs9VbfhOoJaGuLKCbDq4g35qaZwr6L+mmw+E=;
        b=Umx4xlsMmGrnaNJuRrin5vi8ZAt2w883ENa/opm5Ef1E2b5FCGMRuI80/nNjvxxje+
         AnLrqhGu/leSnSjl8jSbImGreK5/nIfZsTXlB+CU6XhtIUKJaRQOZYQv4hys7dlfyINa
         vu5MTzKTRwJ59XwvjdbVwrIAqITsAs0HMGHqDFz3y583jbr5M6xNDv1TtDkscpGF7Xb2
         bQvCYvBGRjTzdR6/FKxwuY+rIoADtGliOmsJQMMchtwBqkc1XLBZJe91g8jnSdqd5YqG
         5A9WP0uKdMgrhEV4NMQ1FN/Kmme/p/ir1qAIihXoVwdm+wu5kCXLDvjE8eT1Q0WdQBQ6
         Pulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093909; x=1741698709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/wzkrlUs9VbfhOoJaGuLKCbDq4g35qaZwr6L+mmw+E=;
        b=C5jfnGFO81nvtt4ct78pMATQkDcRmhdhmVVtKVSUg16gg6KXP1I036FY3zZwM7L/uK
         Uq+vD7WtEDdWJ5P9z1K5b5ovLtXguDtp37VsN4LSTZYFzdHen6eXT+v9Pg2e/6ymvBSJ
         1YYzxW0MJn356N5iHzisje+Bn9czUpzGSaHu3Q6xkofT3Td14pzkJK0Yffx0CyjQU7ih
         glYE+PPTMd9WpsqyoDnfh/QPk54PAou4AcPvzmY+VZ2PGjdnkDV52CT2vN5QKO13GpCM
         Q2CoDmQIS+x823Biq99MhSrMfmH+Lh3OQsJMkKbN3c4UM+0wuXUCzBPKxoJm+gajv3ge
         MHvA==
X-Forwarded-Encrypted: i=1; AJvYcCWe1ID/rFDeg3PWH70IGGr/pDtcUgFr3bljjeATIR6qXJMewftK3TCKcJ7f1mm2Njc3re/BcaNYLmwFxrB2Huvl@vger.kernel.org, AJvYcCXT5dudQoiYWJquUMjbhL7dFlsn1mghXZu80eRliAU/aqdqyQttuXt+W0v/ca0VEeuQBDQvZnqF1udJDTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdQ9BmOTDh5gTiHNuI1F8EsSMbf8g3tmwTTM7K/0ZyQiiFyBB
	S9uvl3xuNeA6h8fnlVXUV1fNAoeH1OJICAf4LTzzKgPgt96pvpazOhwmgVqun2Qo6Q==
X-Gm-Gg: ASbGncsK+DpUXnnwofic7SG/1KTaumH9MKObL6vcLs1BNnlJjoQv/u2jRAHDF+uhahw
	y7BDw8y7fzx1X01Q+cnDyYUbwJv5AnF9UcZsZgBegHTxEHEwxf+Vam+Fb5NFy3cbM6IG2vD6lEA
	ebirlpxs08QUlzCN+uhCdpQpI2ERX0Bf3F3DeZyT05KAMC94OclQWVGtQqpljXrQnzRvA1mhuxC
	WLlQaTGPGr1Ak/ldcAXkNsPfsnl4MfNNYa9QJDsGSG/tJtU6KDGd0rHmED5RMS3RCIqRk7DcIaw
	Eb4rNXkOovBu8eVUfBk9ELGvUBSIOSsvocRxC1H2ESRDwDRnuvMYpm4MmWRI7P1z
X-Google-Smtp-Source: AGHT+IHe8Mh/cx2X8WKXOhydai9XajBG4/GGVd21BbCnkpbCoVM9apiwu2b/ffJQSIAjHk4+KoolSQ==
X-Received: by 2002:aa7:88c7:0:b0:736:5486:781d with SMTP id d2e1a72fcca58-73654867c2fmr11847921b3a.19.1741093909312;
        Tue, 04 Mar 2025 05:11:49 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a668sm10824199b3a.30.2025.03.04.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:11:48 -0800 (PST)
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
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net 3/3] selftests: bonding: add ipsec offload test
Date: Tue,  4 Mar 2025 13:11:20 +0000
Message-ID: <20250304131120.31135-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250304131120.31135-1-liuhangbin@gmail.com>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
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

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 154 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 3 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 2b10854e4b1e..d5a7de16d33a 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -10,7 +10,8 @@ TEST_PROGS := \
 	mode-2-recovery-updelay.sh \
 	bond_options.sh \
 	bond-eth-type-change.sh \
-	bond_macvlan_ipvlan.sh
+	bond_macvlan_ipvlan.sh \
+	bond_ipsec_offload.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
new file mode 100755
index 000000000000..4b19949a4c33
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
@@ -0,0 +1,154 @@
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
+source "$lib_dir"/../../../net/lib.sh
+algo="aead rfc4106(gcm(aes)) 0x3132333435363738393031323334353664636261 128"
+srcip=192.0.2.1
+dstip=192.0.2.2
+ipsec0=/sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
+ipsec1=/sys/kernel/debug/netdevsim/netdevsim0/ports/1/ipsec
+active_slave=""
+
+active_slave_changed()
+{
+        local old_active_slave=$1
+        local new_active_slave=$(ip -n ${ns} -d -j link show bond0 | \
+				 jq -r ".[].linkinfo.info_data.active_slave")
+        [ "$new_active_slave" != "$old_active_slave" -a "$new_active_slave" != "null" ]
+}
+
+test_offload()
+{
+	# use ping to exercise the Tx path
+	ip netns exec $ns ping -I bond0 -c 3 -W 1 -i 0 $dstip >/dev/null
+
+	active_slave=$(ip -n ${ns} -d -j link show bond0 | \
+		       jq -r ".[].linkinfo.info_data.active_slave")
+
+	if [ $active_slave = $nic0 ]; then
+		sysfs=$ipsec0
+	elif [ $active_slave = $nic1 ]; then
+		sysfs=$ipsec1
+	else
+		check_err 1 "bond_ipsec_offload invalid active_slave $active_slave"
+	fi
+
+	# The tx/rx order in sysfs may changed after failover
+	grep -q "SA count=2 tx=3" $sysfs && grep -q "tx ipaddr=$dstip" $sysfs
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
+		modprobe -q netdevsim
+		if [ $? -ne 0 ]; then
+			echo "SKIP: can't load netdevsim for ipsec offload"
+			exit $ksft_skip
+		fi
+		defer modprobe -r netdevsim
+	fi
+
+	setup_ns ns
+	defer cleanup_ns $ns
+}
+
+setup_bond()
+{
+	ip -n $ns link add bond0 type bond mode active-backup miimon 100
+	ip -n $ns addr add $srcip/24 dev bond0
+	ip -n $ns link set bond0 up
+
+	ifaces=$(ip netns exec $ns bash -c '
+		sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
+		echo "0 2" > /sys/bus/netdevsim/new_device
+		while [ ! -d $sysfsnet ] ; do :; done
+		udevadm settle
+		ls $sysfsnet
+	')
+	nic0=$(echo $ifaces | cut -f1 -d ' ')
+	nic1=$(echo $ifaces | cut -f2 -d ' ')
+	ip -n $ns link set $nic0 master bond0
+	ip -n $ns link set $nic1 master bond0
+
+	# we didn't create a peer, make sure we can Tx by adding a permanent
+	# neighbour this need to be added after enslave
+	ip -n $ns neigh add $dstip dev bond0 lladdr 00:11:22:33:44:55
+
+	# create offloaded SAs, both in and out
+	ip -n $ns x p add dir out src $srcip/24 dst $dstip/24 \
+	    tmpl proto esp src $srcip dst $dstip spi 9 \
+	    mode transport reqid 42
+
+	ip -n $ns x p add dir in src $dstip/24 dst $srcip/24 \
+	    tmpl proto esp src $dstip dst $srcip spi 9 \
+	    mode transport reqid 42
+
+	ip -n $ns x s add proto esp src $srcip dst $dstip spi 9 \
+	    mode transport reqid 42 $algo sel src $srcip/24 dst $dstip/24 \
+	    offload dev bond0 dir out
+
+	ip -n $ns x s add proto esp src $dstip dst $srcip spi 9 \
+	    mode transport reqid 42 $algo sel src $dstip/24 dst $srcip/24 \
+	    offload dev bond0 dir in
+
+	# does offload show up in ip output
+	lines=`ip -n $ns x s list | grep -c "crypto offload parameters: dev bond0 dir"`
+	if [ $lines -ne 2 ] ; then
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
+ip -n $ns link set $active_slave down
+slowwait 5 active_slave_changed $active_slave
+test_offload
+
+# make sure offload get removed from driver
+ip -n $ns x s flush
+ip -n $ns x p flush
+line0=$(grep -c "SA count=0" $ipsec0)
+line1=$(grep -c "SA count=0" $ipsec1)
+[ $line0 -ne 1 -o $line1 -ne 1 ]
+check_fail $? "bond_ipsec_offload SA not removed from driver"
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index dad4e5fda4db..054fb772846f 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -9,3 +9,7 @@ CONFIG_NET_CLS_FLOWER=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
+CONFIG_XFRM_USER=m
+CONFIG_NETDEVSIM=m
-- 
2.46.0


