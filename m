Return-Path: <linux-kselftest+bounces-27422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0028BA43A02
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F08817FA41
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA65266B61;
	Tue, 25 Feb 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQgV0xHc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3212638B2;
	Tue, 25 Feb 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476478; cv=none; b=kXhEmGp7gNyWHV2SupBpQDwwxzVTXIwzdtnBen4s1FHNYY67uYTzg95LgDNmox1w2ivn50StN9IRK+6bzf8f5O42lIAJJYeAwVrrLcM1EWi7saq8GBJZXekr5kjSmCTDEaJz0yuKBpF+0l1WHJ2hrbq9B8/uWsDRV89ELtC04lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476478; c=relaxed/simple;
	bh=FzT/ECMeABHeNeF84rIs6l8GIuZokm7ac23EJgGF+xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvrFE/7LvKoKUG3tSKk1kUgHgqjSk1ChTzZCplslPST6wSinWnFMBcSQVPFIOwgEVQweS71yrvBdKRtQz5FGR3HVZ1UAzthMUsqAiv5OgrTHXwDGwgBdG67QXyrbgiTQCpIHO44YolZ8owwxBEg1LdMazuc3wENfM9E4l0iQz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQgV0xHc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220f048c038so101624705ad.2;
        Tue, 25 Feb 2025 01:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740476475; x=1741081275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afOILgA/zHRb8Nw9ui16zGP2yzgeLzRcNXnyvIsurfI=;
        b=gQgV0xHcs066hJfCuDGQYpTx3bFJY/f6ZF7cKrk6jCvpanyveq+RiHnZfceda0MH3a
         bsFCvHjEA0t5tvmPK95LA6Z1wJL70cBbIPlsnuiwT9neLOVYkipbSUuJLK44hkANpjDq
         UbKtzSq1w7y9US1l+4taAjUWjL3GtIk7djLscBpPYBYbKe0RFxIjzh9KYJDuEL1kLgTI
         lqF60c1oakWWLymZSMjmykRUedb/twoGePkN0r82Jhf7MwYUBaMa0ZwfNE3omKTI7icR
         XOI3MPETjknbBVOza7gOmtDx28iw4unN0xDmrUPvBlX/k4fYjKIMZQoQw3M3zpXBuZqr
         rlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476475; x=1741081275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afOILgA/zHRb8Nw9ui16zGP2yzgeLzRcNXnyvIsurfI=;
        b=eDLoXsO9YlnsXqW0Q0JAxF7mRuzNzRVTQICJiaIF8WydJEuDQc1lvsKDHjjaF1k5aN
         pt5yWYWPzkvwT7jlt63jn+0DI6nAztvaSzu9yRXi2GxGqu94f0a+69o3Hky/itbieHRf
         G8B7zop1+2M1mwsOAE+NzhoSs6/1w8pU7XAR3AsrSvB337yJXdAKk7Fz+yLBDgfxt9Tg
         3nKdcJr+Sqsnb+ExzCjCzUOxT+Jktz7tAyG7RhSwqkht3LkPKeE2hNzqPDxYTTIy2xzF
         kDEC08i7MRkkMtPniL7Y5baof2sAP2Z77RiiekeMjxvwLKgjeDJBLA/rt3XyGkd0QVSl
         wHMg==
X-Forwarded-Encrypted: i=1; AJvYcCU7/AKFviAEqdISWGM0951PzX+BBbCyRBBbC1bSCaHIIhfMVhoRk1ntpL1+77BmIoz1DBuASfLphHgatYmXTX+H@vger.kernel.org, AJvYcCV4G+jlAhECvhp24Tnq34UupMZngwKjJpPbS8JyESEvHmEfYCEhs+5CwZBg/IpftpmfE+79Fqp0eHPSbsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIE0kSc2J9pnxvyv1amsstXzBopW7xCLXYVhx38YntfZb4Eayf
	MX64UNfsVZ7oeR1yEsW3zFNYDePqu30zuA0KHSfM+6MFwOkK/772YBzGNmfZ2wWDQg==
X-Gm-Gg: ASbGncvRbLy1Kc/fflpBmbuYYItwBpHZOjvrqCh0HI3xyzAZcp0DljRMdc2YtdLueXr
	ddfSFjrqkJ+nbU+1i/DzLzFD2bHAY+COg2srCj38b9TYk7RoGM+jD28IQt8Zkcp+G8BK3Wr5WHM
	/0JRlFmDrfYzTySs9n3Vtncba6VUqG0NFJKsYV8gIQ+xbjDHOoPjV9locT2rkxw5yvgJMLB4XPa
	bClacBK8V6PrmJW0+2eXoNlbx9pwaMkCM20QxZkhMKZo/+zfzrVI+bB/KntJ7mM4DPVMdBljRJ3
	SpS/6YOc/YqQ91IADqDcHoHXV56c2agtvXVTwBxzndHAVA==
X-Google-Smtp-Source: AGHT+IFJmZ7Sk5dhvMYx5VBnMk7wHl+pK6YrB7A+OwFAyOenTMOJ9d+agjqzGuYDcyJliI4uA5kqUw==
X-Received: by 2002:a05:6a21:7a93:b0:1ee:df88:9f80 with SMTP id adf61e73a8af0-1f0fc7795dfmr4290781637.26.1740476474968;
        Tue, 25 Feb 2025 01:41:14 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f9e6dsm1065597b3a.64.2025.02.25.01.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:41:14 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 3/3] selftests: bonding: add ipsec offload test
Date: Tue, 25 Feb 2025 09:40:49 +0000
Message-ID: <20250225094049.20142-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250225094049.20142-1-liuhangbin@gmail.com>
References: <20250225094049.20142-1-liuhangbin@gmail.com>
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

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 155 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 3 files changed, 161 insertions(+), 1 deletion(-)
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
index 000000000000..169866b47a67
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
@@ -0,0 +1,155 @@
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
+ret=0
+
+cleanup()
+{
+	modprobe -r netdevsim
+	cleanup_ns $ns
+}
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
+		echo "FAIL: bond_ipsec_offload invalid active_slave $active_slave"
+		ret=1
+	fi
+
+	# The tx/rx order in sysfs may changed after failover
+	if grep -q "SA count=2 tx=3" $sysfs && grep -q "tx ipaddr=$dstip" $sysfs; then
+		echo "PASS: bond_ipsec_offload has correct tx count with link ${active_slave}"
+	else
+		echo "FAIL: bond_ipsec_offload incorrect tx count with link ${active_slave}"
+		ret=1
+	fi
+}
+
+if ! mount | grep -q debugfs; then
+	mount -t debugfs none /sys/kernel/debug/ &> /dev/null
+fi
+
+# setup netdevsim since dummy/veth dev doesn't have offload support
+if [ ! -w /sys/bus/netdevsim/new_device ] ; then
+	modprobe -q netdevsim
+	if [ $? -ne 0 ]; then
+		echo "SKIP: can't load netdevsim for ipsec offload"
+		exit $ksft_skip
+	fi
+fi
+
+trap cleanup EXIT
+
+setup_ns ns
+ip -n $ns link add bond0 type bond mode active-backup miimon 100
+ip -n $ns addr add $srcip/24 dev bond0
+ip -n $ns link set bond0 up
+
+ifaces=$(ip netns exec $ns bash -c '
+	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
+	echo "0 2" > /sys/bus/netdevsim/new_device
+	while [ ! -d $sysfsnet ] ; do :; done
+	udevadm settle
+	ls $sysfsnet
+')
+nic0=$(echo $ifaces | cut -f1 -d ' ')
+nic1=$(echo $ifaces | cut -f2 -d ' ')
+ip -n $ns link set $nic0 master bond0
+ip -n $ns link set $nic1 master bond0
+
+# create offloaded SAs, both in and out
+ip -n $ns x p add dir out src $srcip/24 dst $dstip/24 \
+    tmpl proto esp src $srcip dst $dstip spi 9 \
+    mode transport reqid 42
+
+ip -n $ns x p add dir in src $dstip/24 dst $srcip/24 \
+    tmpl proto esp src $dstip dst $srcip spi 9 \
+    mode transport reqid 42
+
+ip -n $ns x s add proto esp src $srcip dst $dstip spi 9 \
+    mode transport reqid 42 $algo sel src $srcip/24 dst $dstip/24 \
+    offload dev bond0 dir out
+
+ip -n $ns x s add proto esp src $dstip dst $srcip spi 9 \
+    mode transport reqid 42 $algo sel src $dstip/24 dst $srcip/24 \
+    offload dev bond0 dir in
+
+# does offload show up in ip output
+lines=`ip -n $ns x s list | grep -c "crypto offload parameters: dev bond0 dir"`
+if [ $lines -ne 2 ] ; then
+	echo "FAIL: bond_ipsec_offload SA offload missing from list output"
+	ret=1
+fi
+
+# we didn't create a peer, make sure we can Tx by adding a permanent neighbour
+# this need to be added after enslave
+ip -n $ns neigh add $dstip dev bond0 lladdr 00:11:22:33:44:55
+
+# start Offload testing
+test_offload
+
+# do failover
+ip -n $ns link set $active_slave down
+slowwait 5 active_slave_changed $active_slave
+test_offload
+
+# make sure offload get removed from driver
+ip -n $ns x s flush
+ip -n $ns x p flush
+line0=$(grep -c "SA count=0" $ipsec0)
+line1=$(grep -c "SA count=0" $ipsec1)
+if [ $line0 -ne 1 -o $line1 -ne 1 ]  ; then
+	echo "FAIL: bond_ipsec_offload SA not removed from driver"
+	ret=1
+else
+	echo "PASS: bond_ipsec_offload SA removed from driver"
+fi
+
+exit $ret
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


