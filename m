Return-Path: <linux-kselftest+bounces-23151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17E49EC561
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3634F1690D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 07:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CC51C5F0E;
	Wed, 11 Dec 2024 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khld1B6R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827371C2443;
	Wed, 11 Dec 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733901115; cv=none; b=nyo+xpaPBHAFFZhvY+m0EhMNjxN2sp2qW3nGstKPbU5YbQcNc2ue4MscEhd6UGeRYPM7lwSXN+a6QaLwKDLfe+pl9lkT32jNRhdYLlfjP5CDgVu1kA0sxnG6I6kivUSNJlvseRvrcQl9iiktYdXAra0wjSdLo1wOKlC0i1x7ugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733901115; c=relaxed/simple;
	bh=TDn+qaK7jM3jGrKuPryA07XpZu7s/aMa+2EQR915tCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCVJAylcQi8KfwPLbni9qqUzvXRi86oBak0Q6TBC6K94/mfLzbpgnT87ZRowoAbze8LHpxwJX4PSQDLWq5K2SyKhxNh9LhEul0oxkCGVKAqVTRH9SGVkxxQbJdncLtBr3Qtn86p13G94+3akHNYQh+iW3JUVTuhMsZaVfGI1ow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khld1B6R; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165448243fso32620535ad.1;
        Tue, 10 Dec 2024 23:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733901112; x=1734505912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+jJYVfw9KEbWJ7kzZdTWN7G2FIhmsWXz5uzenB8DNQ=;
        b=khld1B6RULIQMhqNN3YKKojbRidvuhTeh2C8Wz7Vs8mGlxngC7vZxS65zBu3Gh6uhe
         v91a8RfZ2rESL3TFJCMOQVjZqtfkF6baK7T4LQGerxhEcRVdWukyTdZIgub57AAyR7UX
         9bMZcmwDMDHu1htMEWFb7eTvl9nBhUlB5Z87RmH2xOBPG18h4DErNxmnGZynYG8Qdmgw
         aWnw2HDoUuPcRbT+yHBP5IKkCmM/LcUTSQWqCNDB9iCp/s7k+jAQcrUAbgwCGGprYkUF
         mzMACWc7pU2HNbvU1CEiascuB5wwnW5mI+BK2zw+DPUCRwEJDXCf8Pfamf/IORJPGLEz
         vP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733901112; x=1734505912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+jJYVfw9KEbWJ7kzZdTWN7G2FIhmsWXz5uzenB8DNQ=;
        b=qyods7OB6W0O8+51yVA6FOMz2H4vW+aFiC11GfGdUk3ea7CtCw3UIC2q8LBEUaaShq
         L4uC2R83nIy2XdJDF4zRgk5Xv/5lLTxQ3ziOluiT0JWZ5EHolTw7LoRUNS75yY36BnRN
         QcB+5DLFmF2vgehY48V4WD6gks1kduzr9kgV4lFB6pBpJ9fdeJnz53lqZ99r1Ph2kVT6
         imCrOoTxquHCkJqsqfoRh8dMUKUq0NUovkE59RbQXK363Lwo+iMvIFuXc5mFI80W0PrT
         bcInzFmL9JqFDQM0gZSDuno2lnlsm0B2s3fC5ZBmmdbzN7iYjIsYxCAIhgKaKpJemt6B
         vkiA==
X-Forwarded-Encrypted: i=1; AJvYcCUWT06VQYB4QhM7apwhMfXry315Bve2DBkLstZa8SJQMOhf1bRlU/aaXYCFHnOTh0xc+b9ZOk7CJ4B1uvOBvknG@vger.kernel.org, AJvYcCVLW6kuapa+uRzJAc8TKWV9ua2+y2RON5GIQRue30hTuU6wIa89p3v4PpvMGQ3QCPbINpGpedmIxPPS7T0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxehzd+1qxWsgh3kU3GxnLbHSzw4d842VOMr+UahPBgTxydSNWC
	B1DkTbgG+40or2gkoyWhfnqfCy5zEfbo8kgRqA/1lTtcIeRAnmrVt/HvGLyk
X-Gm-Gg: ASbGnctN0BKJofP+WvJV0c7CzIhPcG+7qU8kYX2vWJO5bN9PH5W7W3p5myLa83PCpWC
	0iioHfsYLI3gYfB3/ciq4+yHYAJQ4ohQw/rNq+toTwLnJOb/S5lCPD3Z5WhJ3IOazjG4GEtqFVl
	FGTDFO3wNtSw9JytpHWV2AedVnYYeW/5PG7rFioYbUAGmd3TJGGFebKuIHADx8dcw33v6Plf2GC
	KxleWN+LBpD6M8K9sfpzhBDfP+8DBZXyOyF2EUGEK76PbvhiVN91jHRXF0EWj1YfnX/qCzq/w==
X-Google-Smtp-Source: AGHT+IELggJtwvMqUWgDNPwoJo7hVeEddCtghCfMxFPYXgCtKO3IzPufBMxhbuoFnvIh6K3R2l8NnQ==
X-Received: by 2002:a17:902:d58d:b0:216:31aa:12fc with SMTP id d9443c01a7336-2177851f51dmr37248605ad.24.1733901112500;
        Tue, 10 Dec 2024 23:11:52 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9f44sm100311205ad.118.2024.12.10.23.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 23:11:52 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 2/2] selftests: bonding: add ipsec offload test
Date: Wed, 11 Dec 2024 07:11:27 +0000
Message-ID: <20241211071127.38452-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211071127.38452-1-liuhangbin@gmail.com>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
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
index 03a089165d3f..c938475fdefa 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -10,7 +10,8 @@ TEST_PROGS := \
 	mode-2-recovery-updelay.sh \
 	bond_options.sh \
 	bond-eth-type-change.sh \
-	bond_macvlan.sh
+	bond_macvlan.sh \
+	bond_ipsec_offload.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
new file mode 100755
index 000000000000..868f22ad11aa
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
+		return $ksft_skip
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
index 899d7fb6ea8e..91c581abe79c 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -8,3 +8,7 @@ CONFIG_NET_CLS_FLOWER=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
+CONFIG_XFRM_USER=m
+CONFIG_NETDEVSIM=m
-- 
2.39.5 (Apple Git-154)


