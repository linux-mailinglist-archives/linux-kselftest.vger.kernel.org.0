Return-Path: <linux-kselftest+bounces-27723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E4A47803
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BE21700F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCE8229B00;
	Thu, 27 Feb 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2M8TUyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4222686B;
	Thu, 27 Feb 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645484; cv=none; b=obs+GUyc70Nc1NWEudVxyNbOTcI5rBqYaTCHS/R9Ub/KLLXTMQ6LCEWY8ywSalpUkkr/2tybw8Fe4Yv4bOrJv6hoVCLaw0oFy00nVBq4dR9Un/KGsg6QIXDWdjK3vKcIMyBdVtJiwZ/y5JO+Z21fdnmWlBpPkNCOcGzc6LYgrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645484; c=relaxed/simple;
	bh=FzT/ECMeABHeNeF84rIs6l8GIuZokm7ac23EJgGF+xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkHIxChBjikIzDY1s+yv66PwvYKaQ/WK7W6/85RdqmXgqIyYHcyJc9h+kBBQdWKQQAumfZrc3BeOvPWgesfSAzSB5vkC4dpCtWoECMrlbbyzMo/fM+VMyp5NHx1ADcPcEUnDwzMLDKn4SGRPn8sM2E7ZqmdUf/hwprZnH4Rv3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2M8TUyu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-221057b6ac4so9651465ad.2;
        Thu, 27 Feb 2025 00:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740645481; x=1741250281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afOILgA/zHRb8Nw9ui16zGP2yzgeLzRcNXnyvIsurfI=;
        b=G2M8TUyuNbk3PJqGjNqaykfnQByFwuT477qP/84jioILor9XCOA+6nDxyCqcBocYyr
         i8jsTf/KERui8GVgwaGg1xMOSaeQKgYY2AbGprTdc5KO3ExnLW2reLJS3X39etU8Zejz
         mN4JgsE2GbqZOQas3ym/Ep9ay4p0hKXEZh94vp2UVZ0bleEJ5eZJB8557SfMsvwAYFve
         0Tn2RC3FFO/SO5f5Y5Bf2X1xZraYRpUfGW1IKf5ewIL5SV4louML7J2+zkr7dlJvN4q9
         nH7jwPlIwy1cvXdN+euCxHCWuLqmiJZA/oyu4+k/KrWjMepV6AXlZHHDSAQZLnNvfirb
         5owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645481; x=1741250281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afOILgA/zHRb8Nw9ui16zGP2yzgeLzRcNXnyvIsurfI=;
        b=B9wj2C2i0/STpTKJvoMcCODtNODwiFA3pKy+fqBNqE5fBwRQE6cTuhIfK94Re07Jlp
         qm3kBi40903RD86x0/qYB9w1sreamaGJZLyAwlqf7Y6ZNzcgu68KMDptOW8MpuDDNq2g
         aJTMeISeaexamC1n9N4WAYTPKrthN6LwJTJVBt+S3DpK5DfPClJSvcAFJ3AkLv/Ub5we
         QRKkEGrLlgaV4i/biypwavFElOjJGFpKEt8N/wy+ArbTYY89+qgDd5lZsD+wty7Cw2fl
         Tn4WA0F2amMNjCvCtoe9NJvCIaVzFkxFrGDztEkaoeCEUPxmcdtx09t3RXTod9wSgQ3d
         SWuA==
X-Forwarded-Encrypted: i=1; AJvYcCVzcSab93NBUaGHI+bMgmxrOOvsXCGrcPMhKMaQkApivKGXrx3VaYj59WOg/MAbJAVrqgnaEuR06yEcxbaZ0Jcy@vger.kernel.org, AJvYcCWkDF+1dyBtUEUfpBJRHw6sgIutWPHMkceaUrjWEVTIgnAJv5zTwyhWi6CPn91hPTkNWoi7Dou8HJj8I0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPsjT3EZk1kXolbTWQl621ZITO25zlY0JiwINDngKGrKD2iOu
	XB3rf+Ol9WqUeNG3Yz1O6n/VqitQvmqnYrKNdlgga1vNqiunZvOeC4EK3O0wQLHJsg==
X-Gm-Gg: ASbGncu3JtR/JtuYz1J4YarHsXjiTAipjTrS44uZix/qioL/19+hT6QRDS29+W72mmj
	ab4JQ7HKBir5enhCINSo1dLlnUDFfZoFE7S7c++XAwmbxYQaGHZZrGHL1A+vfyceOpFBlxndWMP
	snOdrDmAM5mDRMMWW4oDkG6FYYroagJ4EJ7BAdvkmhacf4xhkextf+iFy8HaZJt4phHqsOkRGRa
	BtQ/gAVuQN6aRQSQyoTES3jf0G9nryhPvBfwEGokgZFIks3s2LNNQKFb5LziHCe7KyFqQuQp5RE
	pkJVZr0patC08IaGspLHDt9HnuXIfEMGOZgfIk0OdpS8DA==
X-Google-Smtp-Source: AGHT+IHiJQm5gAuu/tcXr9gjobQJUohYDDCYEQIOHXiFQx8G4kRB5uinLdfdfdRoaXUFc7YbuSpWGA==
X-Received: by 2002:a05:6a00:4615:b0:732:5651:e892 with SMTP id d2e1a72fcca58-73426ce7667mr38760848b3a.14.1740645481450;
        Thu, 27 Feb 2025 00:38:01 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec7esm966796b3a.153.2025.02.27.00.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:38:00 -0800 (PST)
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
Subject: [PATCHv3 net 3/3] selftests: bonding: add ipsec offload test
Date: Thu, 27 Feb 2025 08:37:17 +0000
Message-ID: <20250227083717.4307-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250227083717.4307-1-liuhangbin@gmail.com>
References: <20250227083717.4307-1-liuhangbin@gmail.com>
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


