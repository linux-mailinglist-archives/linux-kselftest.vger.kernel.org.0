Return-Path: <linux-kselftest+bounces-41465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1150B57329
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 10:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9443AE455
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B12F068F;
	Mon, 15 Sep 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6Y8GkBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666032ECD34
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925480; cv=none; b=IdSeVsrsDxuqKQgGIPfTVmnHg9oYJKrJGrxtCfMq1KSZ266zeP1/LNETIuMMiQFIihCSP0hrN7+v5j9s1Lid2Vnjpu1L+MfMAnn4kbjkL/xuKwnIcc7mgFFSTw07iP0w1J4f5+zb/mDLAU6XSjJLMRG7fz9aNl0LMoJryaazxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925480; c=relaxed/simple;
	bh=7u80ReDnDCInh+aNkQsfcb3XTF3Bd2sZEHQdKV9NRcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5dqkkU/PIFO9ovvw/PEUGHmE/sUPsXVnfHB596XcSVwJi5WkVvfqEwaGnr/F/FkawTwIDqCCad/cAJ82LyWqW0Y+IPEfJbcCuyVY8oo2qp8BF4vDTr0qtair9z0gUjapQ8NERMlFjgXbZPD5R1qyrP9tJ6wfUxAQ9mTHgH4Sl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6Y8GkBM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77716518125so749466b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757925478; x=1758530278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDoCph1wIa9nDp+Ls5YW8at1GN3q+1l7Ys3PhbWDvJI=;
        b=O6Y8GkBM5ze5b4IzvRCrVovjnhdhsOzHuozQDSz+ROHKQ5OW7TxI/jSHEFVYtxh02n
         08qnBK4aRCdVlaqLq3SqCdy18wigxX72NkjypOCw/3OMlphX1e7eNIZWwd0ZMv/ExeHa
         Ll4A/61AmdBYssc6z1j3BaRSEpz0tl27c3WEPgOq/MmbxR6+C7xc+LFwgVDRP/hORfeg
         MYcXHAm/XXgEXvus68TmvXt3BBMS/o7fWsKL+g5pj2P5A+bw6JCR5IR0PscQeXqLCqpm
         uSpvRvxI3thNYWVMOEhgorIH9jNOnNp6TGsSSkEVecWAUFECMpq9YEmlMY6H3YkF8yhT
         Gdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925478; x=1758530278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDoCph1wIa9nDp+Ls5YW8at1GN3q+1l7Ys3PhbWDvJI=;
        b=Gq6Tlbwzui1nw1SKUU8DLUBiWXCdJqqUuZJKF7lwaj0+f2+p56P1EGKm/h38U1rWLF
         s3tHwCpsIMSXQ/WPd08stFBw4hqsT9RK+ZC3HoClDFkFi7wAWHiV7f5e0+RoisWT3E2y
         trq7xNQqzSPzH+PnzVUpg2fMG++rFVPr2gzpKRJ2ZG/nQkL9ZLcHipFw+NKOSKbVIsC6
         6OLOxgvp5Dp7T2NMnBx05kln5+s4Uy32qomDHU8uC/HoIol2KwyKV76wTWhe1i6Mnuk/
         51YzswfyZhP7gPnKOKazYdvku3oJoFq1BXsvZG1xfyz/MkAm9C6ShC9FKYz5X4Ks0Ox0
         M4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWj2FXnsgVu0CIUTJ3T9dEVlEOudgHhxWBkD2yXPgHV1wnZMsdm2mIB98I8nqWnYm6KlDrT6rzPsHxrfsWeSbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXNiCBNH3yczXU0JzfxI+AlmgNbpRCtSHIURyq73WK+kVrrSao
	6Gyav8cMlSnwR16ID/vXZRLtur1Fkj+etEvVDU+w6h2EDUu96NM3Y2b8
X-Gm-Gg: ASbGncuo4McWRTDELNM62kEJRCsC0y1d5RJUhUUOzy6Zrsx94OcmQuAcV/bgQ2DV81i
	Te+sx/4y4HEihpAqbIQzv68eGjkvX7vrPh4pP8f2YAGVR8LChRGnpqLQWjC/x+WHDTxBAriFPk0
	0VUgcFb2s57lVH4BKZAYtQwR76bcvqxRuSkSfp68wYEAp/tfqJHk4Cmiqj+hj3poLRtNe+rUmPs
	u5liAWHt1/rk0SCWafXtVxIgp/zG263JU/SiT/hRNxPPIbB47PrIs59psRGsxhy7hv3wyGIGMKF
	w9VtthDMAa3TptnbHHaL3nM/bZidWUaUB5yvh9fAd52/gcXleFpMDG4nxDrejxe6SAd1Kn/oLJr
	duUXfOUGTWOAVlqv+luBbO/gmksHL2Ak35b1SNe62SA==
X-Google-Smtp-Source: AGHT+IHitCsHJoq28GnOhekSevw6BlB4OkYmROTXSDSkUd7RqqVB0//Pt3osxPDlsy2neRxLTy1zLQ==
X-Received: by 2002:a05:6a20:939e:b0:245:ffe1:5615 with SMTP id adf61e73a8af0-2602bb59653mr13885769637.38.1757925477650;
        Mon, 15 Sep 2025 01:37:57 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b1a031sm12901974b3a.57.2025.09.15.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:37:57 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH 2/2] selftests: bonding: add ipsec offload test
Date: Mon, 15 Sep 2025 08:37:42 +0000
Message-ID: <20250915083742.423741-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915083742.423741-1-liuhangbin@gmail.com>
References: <20250915083742.423741-1-liuhangbin@gmail.com>
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
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 154 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 3 files changed, 160 insertions(+), 1 deletion(-)
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
index 4d16a69ffc65..bcd54edd1c87 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -10,3 +10,7 @@ CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
+CONFIG_XFRM_USER=m
+CONFIG_NETDEVSIM=m
-- 
2.50.1


