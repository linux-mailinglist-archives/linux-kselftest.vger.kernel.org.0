Return-Path: <linux-kselftest+bounces-28455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BF5A55E39
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 04:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBC23B47CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 03:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B599D1993B1;
	Fri,  7 Mar 2025 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiffwQrJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A6199235;
	Fri,  7 Mar 2025 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317574; cv=none; b=iF7exLOu/zn89SceVBjrM2Gl2YfhoLBzhFte1WRjFHZarKtziGgiUIKwyJ647KwJY5DY5Bm342ZtAUW/T5G1QqG4YSfcyIv6Y1L/KRCdtXt3IDl6CsyP6iSnmcIfbCgzHMv6d3RyKk031xyp2u8nwWDaM7pGwpyc0bv2oYBkgeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317574; c=relaxed/simple;
	bh=QK4lwkBaLpYkzW8OpVr6l0dFgx76+HSEo+fzV171KDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR5VlLMbtYZzYZlmT1NvAeg8FWAaMabNn4nc/Gu7nARhkpMJ+KWe0lru+POUYlD74jL/ykgSYE+4LjRnZ/wKJ26WVyE9/Pq1AYxq4U1ipiPvrbolPkuf4kwpfQDthVYQgwbyKQIudRd96sa2Fk7UK0gbWdXtA0t7JSte6iyGbL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiffwQrJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22337bc9ac3so28761285ad.1;
        Thu, 06 Mar 2025 19:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741317572; x=1741922372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkYXSSC3tJ8D/xoGrXlhmNN1ijluTdRxzvHht/qe2VM=;
        b=ZiffwQrJUkip4rROJHzKoE7+rfbFvP5W06rVSxHG11qwbuO2+YrYjQVo0+XmX4CxBg
         l4i/zrfdFK0S58KNKwJCj9oe9O4ZB8MbWmYtA7D33/b58ZUAm4ESpOBN8hqdhh9+quYg
         f2/C/y2ossW/vcDrpT7x7S1k0ZyYvUziEYB3nzaKDG17zxaEN/6sGGxfhvovl3uXoP1r
         L9lxAp6SQlCs705gF0+5kfpKuovI+1ZDZCFMP28MUtTqD75ldt0kvoAbtG0neKwq8Yva
         1+Dmlrs34jeD1AtEhxtl0RzYNkrdakNOuVEnjxnfKEH1qFfIdpv9t/1iuSoNJMeBCWEi
         HO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741317572; x=1741922372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkYXSSC3tJ8D/xoGrXlhmNN1ijluTdRxzvHht/qe2VM=;
        b=F49VA7AOuvuMYVfwwGS0UyLbC42jUQYIGUXdB+SABO0cy+/FVLCnaGzrDfYpiSP9xT
         KrTeNjA/O6bnPdb6rxzT9lEF2LSr1tLJna0kwDIpMJuiGcV4hqSY/G+r7epYwfMsK7Ch
         KKT7dVUbYdegIvVnIMa03qOhq7fR0Ls7zPiI8DjoA3sM1nDVUMMrdcQKLhVDfLJoTYjb
         V9xN5RLi0clZmkMzm3QvOIN1+rCpu4Q5PZ+s5snK+m8D3+G6P0TB35rYmsIOzzpmx1xU
         R6AC5mgYgyo9QEJr+bJJFEpBh+rrq1WdlWWMiuNn86c+rB2HO8aQW+8Go+E4vohDRQyU
         XaSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7QqTuDg6fUaEPSh00xiMq0XlNjRLJgqcbdkGuqFVM6LewfoCwgLVd6umADA5wPbzDp1BawatR06z8nZaIkio6@vger.kernel.org, AJvYcCW+AAiAYeaWIa2zBnqRJmJr7yT2Fy3F4qv2itKwXdT5+dgmHfGUpTc2nDMmrY8DtWmB8U3Fk9eHnjyv4pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3FGhCOGsFiy1dq6hVD/atFkqzpazIzgAyLBwyG1DhLEUe94n
	E58gf55QyU9Qi9TgWuzevq3jalkiLnkRRDq0AsXbP1QeJ93MUiteKC3/u7DyKzd5vQ==
X-Gm-Gg: ASbGnctf+uGtjSa0KftlAfkM4G6CHyEwGFxM8xBiFc8PB87msB8M6NTRevpeWS8r+ns
	7TX6nVyBmO1kdFvxhIQRETEdr6FuMHGko6NY+5YIhpYGbnGZ00hnCfiJShkk5L70psJPkalUhKD
	aoPngMjJ6i0s2uUYyaxYgG8PBUf2UWvJM0PvwaQl2cbyxT4ekDKjWmk7Xk8Joxv9DtYNiPBIJb+
	VD9m5QI2A0mWXnvw+tyDuziiOMa3XQn3YWQXJMd7kQ/I5LdTfXEmohsv+7uiHR+sOugHzzKDeo+
	WQStys8ThTFuhC+fxb7c+PKDPPsUk1lEf/U5Ff16f2lvwTPQJcHj8BUbm9cwBpRU
X-Google-Smtp-Source: AGHT+IFZyhyvr2XGalTzNKpQy8s4HxN8N0MwaY/NNXoNcmh6dVchxFXBgPTfwtr0189P+LrVEESDrA==
X-Received: by 2002:a17:903:40cb:b0:224:584:6f07 with SMTP id d9443c01a7336-22428ac94camr27553035ad.37.1741317571906;
        Thu, 06 Mar 2025 19:19:31 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd5e2sm20013165ad.15.2025.03.06.19.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:19:31 -0800 (PST)
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
Subject: [PATCHv5 net 3/3] selftests: bonding: add ipsec offload test
Date: Fri,  7 Mar 2025 03:19:03 +0000
Message-ID: <20250307031903.223973-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250307031903.223973-1-liuhangbin@gmail.com>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
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


