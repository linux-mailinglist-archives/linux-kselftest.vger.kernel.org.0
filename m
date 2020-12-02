Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB24D2CBFDD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgLBOhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 09:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727975AbgLBOhV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 09:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606919754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=DPNYKLavUjpeB+W3e/it8DOgEQRQd7bBs3Cx0Z4NvEQ=;
        b=D8QQsEIkgZvrcTSUiRHRTAqeRUeW8XJDdR0rmw2jyETVMDzT+ZGYtVyhtUT4NMQQe6rceS
        tWIcOx/QxQrpV9rggGub697EigMlVh/AAYD91LIz4W5eDVUL2wal5i41mMnem59t9nPOc9
        JfXsgwnTysOL8UouMKsGLOBBJuf9mo8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-gJHExIfsNr6o_GO-lN2V8w-1; Wed, 02 Dec 2020 09:35:48 -0500
X-MC-Unique: gJHExIfsNr6o_GO-lN2V8w-1
Received: by mail-wm1-f72.google.com with SMTP id h68so4222718wme.5
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 06:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DPNYKLavUjpeB+W3e/it8DOgEQRQd7bBs3Cx0Z4NvEQ=;
        b=pkbYliOAvsoTLu0/YS40LS93HRoBbl+mTgfEa5fUSIYX/xnEjEgngdtW78rclhFeh8
         uNUOKUMPHMxhBakNSZ+DBMCyjJR4h7jN/wllnqJvS0L1Eoub0j+5M0eWsKc4oBiIVnky
         jBz8gSHb8mY3B2B60rWW5AnlCCzxK+wF9UTR3XhBH4iWYeJmhLnSXAivczm2qRoLZCwb
         5RMvLKpZl+8xh93qaExX0ZdZE6ZE3l3QrQIqqHIQHVrxGTi6E+/MbkTc63pClRJ70AvX
         mtG+CL/UAeExfHP7iUGTja0gjb07jXVYIkJEq0mzqJusD8SHKRncFsN1sygcJapnJlUc
         jypQ==
X-Gm-Message-State: AOAM533LV+PeR7GVxKmpak9GCovf4oC0Twvi3vBGqN7TM5G0YW48pL2a
        61y7iYwmllyVwzs83VNnzXKOcjSkVcANi7CRvV5rQhj4Ca3etT9k5IgPxRRV7l/OaT/4GMsG6oI
        gmtGLqco8auNx6Hh8/iFJUp+GLzME
X-Received: by 2002:a7b:c843:: with SMTP id c3mr3486002wml.100.1606919746263;
        Wed, 02 Dec 2020 06:35:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyso84ylurdW7zc4YBHDTvXZqllRU5yKka7IAAcYwgqWx5bkw+fhegNH2GACMy8ln4PLpTkNg==
X-Received: by 2002:a7b:c843:: with SMTP id c3mr3485979wml.100.1606919746062;
        Wed, 02 Dec 2020 06:35:46 -0800 (PST)
Received: from linux.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id 21sm2412843wme.0.2020.12.02.06.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:35:45 -0800 (PST)
Date:   Wed, 2 Dec 2020 15:35:43 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next] selftests: forwarding: Add MPLS L2VPN test
Message-ID: <625f5c1aafa3a8085f8d3e082d680a82e16ffbaa.1606918980.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Connect hosts H1 and H2 using two intermediate encapsulation routers
(LER1 and LER2). These routers encapsulate traffic from the hosts,
including the original Ethernet header, into MPLS.

Use ping to test reachability between H1 and H2.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/config |   3 +
 .../selftests/net/forwarding/tc_mpls_l2vpn.sh | 192 ++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 250fbb2d1625..d97bd6889446 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -48,6 +48,7 @@ TEST_PROGS = bridge_igmp.sh \
 	tc_chains.sh \
 	tc_flower_router.sh \
 	tc_flower.sh \
+	tc_mpls_l2vpn.sh \
 	tc_shblocks.sh \
 	tc_vlan_modify.sh \
 	vxlan_asymmetric.sh \
diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index da96eff72a8e..10e9a3321ae1 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -6,6 +6,9 @@ CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_VRF=m
 CONFIG_BPF_SYSCALL=y
 CONFIG_CGROUP_BPF=y
+CONFIG_NET_ACT_MIRRED=m
+CONFIG_NET_ACT_MPLS=m
+CONFIG_NET_ACT_VLAN=m
 CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_ACT_GACT=m
diff --git a/tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh b/tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh
new file mode 100755
index 000000000000..03743f04e178
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh
@@ -0,0 +1,192 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +-----------------------+
+# | H1 (v$h1)             |
+# | 192.0.2.1/24          |
+# | 2001:db8::1/124       |
+# |                 + $h1 |
+# +-----------------|-----+
+#                   |
+#                   | (Plain Ethernet traffic)
+#                   |
+# +-----------------|-----------------------------------------+
+# | LER1            + $edge1                                  |
+# |                     -ingress:                             |
+# |                       -encapsulate Ethernet into MPLS     |
+# |                       -add outer Ethernet header          |
+# |                       -redirect to $mpls1 (egress)        |
+# |                                                           |
+# |                 + $mpls1                                  |
+# |                 |   -ingress:                             |
+# |                 |     -remove outer Ethernet header       |
+# |                 |     -remove MPLS header                 |
+# |                 |     -redirect to $edge1 (egress)        |
+# +-----------------|-----------------------------------------+
+#                   |
+#                   | (Ethernet over MPLS traffic)
+#                   |
+# +-----------------|-----------------------------------------+
+# | LER2            + $mpls2                                  |
+# |                     -ingress:                             |
+# |                       -remove outer Ethernet header       |
+# |                       -remove MPLS header                 |
+# |                       -redirect to $edge2 (egress)        |
+# |                                                           |
+# |                 + $edge2                                  |
+# |                 |   -ingress:                             |
+# |                 |     -encapsulate Ethernet into MPLS     |
+# |                 |     -add outer Ethernet header          |
+# |                 |     -redirect to $mpls2 (egress)        |
+# +-----------------|-----------------------------------------|
+#                   |
+#                   | (Plain Ethernet traffic)
+#                   |
+# +-----------------|-----+
+# | H2 (v$h2)       |     |
+# |                 + $h2 |
+# | 192.0.2.2/24          |
+# | 2001:db8::2/124       |
+# +-----------------------+
+#
+# LER1 and LER2 logically represent two different routers. However, no VRF is
+# created for them, as they don't do any IP routing.
+
+ALL_TESTS="mpls_forward_eth"
+NUM_NETIFS=6
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1 192.0.2.1/24 2001:db8::1/124
+}
+
+h1_destroy()
+{
+	simple_if_fini $h1 192.0.2.1/24 2001:db8::1/124
+}
+
+h2_create()
+{
+	simple_if_init $h2 192.0.2.2/24 2001:db8::2/124
+}
+
+h2_destroy()
+{
+	simple_if_fini $h2 192.0.2.2/24 2001:db8::2/124
+}
+
+ler1_create()
+{
+	tc qdisc add dev $edge1 ingress
+	tc filter add dev $edge1 ingress                            \
+	   matchall                                                 \
+	   action mpls mac_push label 102                           \
+	   action vlan push_eth dst_mac $mpls2mac src_mac $mpls1mac \
+	   action mirred egress redirect dev $mpls1
+	ip link set dev $edge1 up
+
+	tc qdisc add dev $mpls1 ingress
+	tc filter add dev $mpls1 ingress            \
+	   protocol mpls_uc                         \
+	   flower mpls_label 101                    \
+	   action vlan pop_eth                      \
+	   action mpls pop protocol teb             \
+	   action mirred egress redirect dev $edge1
+	ip link set dev $mpls1 up
+}
+
+ler1_destroy()
+{
+	ip link set dev $mpls1 down
+	tc qdisc del dev $mpls1 ingress
+
+	ip link set dev $edge1 down
+	tc qdisc del dev $edge1 ingress
+}
+
+ler2_create()
+{
+	tc qdisc add dev $edge2 ingress
+	tc filter add dev $edge2 ingress                            \
+	   matchall                                                 \
+	   action mpls mac_push label 101                           \
+	   action vlan push_eth dst_mac $mpls1mac src_mac $mpls2mac \
+	   action mirred egress redirect dev $mpls2
+	ip link set dev $edge2 up
+
+	tc qdisc add dev $mpls2 ingress
+	tc filter add dev $mpls2 ingress            \
+	   protocol mpls_uc                         \
+	   flower mpls_label 102                    \
+	   action vlan pop_eth                      \
+	   action mpls pop protocol teb             \
+	   action mirred egress redirect dev $edge2
+	ip link set dev $mpls2 up
+}
+
+ler2_destroy()
+{
+	ip link set dev $mpls2 down
+	tc qdisc del dev $mpls2 ingress
+
+	ip link set dev $edge2 down
+	tc qdisc del dev $edge2 ingress
+}
+
+mpls_forward_eth()
+{
+	ping_test $h1 192.0.2.2
+	ping6_test $h1 2001:db8::2
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	edge1=${NETIFS[p2]}
+
+	mpls1=${NETIFS[p3]}
+	mpls2=${NETIFS[p4]}
+
+	edge2=${NETIFS[p5]}
+	h2=${NETIFS[p6]}
+
+	mpls1mac=$(mac_get $mpls1)
+	mpls2mac=$(mac_get $mpls2)
+
+	vrf_prepare
+
+	h1_create
+	h2_create
+	ler1_create
+	ler2_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	ler2_destroy
+	ler1_destroy
+	h2_destroy
+	h1_destroy
+
+	vrf_cleanup
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+tc_offload_check
+if [[ $? -ne 0 ]]; then
+	log_info "Could not test offloaded functionality"
+else
+	tcflags="skip_sw"
+	tests_run
+fi
+
+exit $EXIT_STATUS
-- 
2.21.3

