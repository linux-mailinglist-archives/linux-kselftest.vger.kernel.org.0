Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B4F752374
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjGMNVa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbjGMNVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:21:04 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFCA30C8
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 06:20:49 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-3wzTFMkIM1C2YrMdrEhgpg-1; Thu, 13 Jul 2023 09:20:32 -0400
X-MC-Unique: 3wzTFMkIM1C2YrMdrEhgpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBFF588D06C;
        Thu, 13 Jul 2023 13:20:31 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3ADD2166B26;
        Thu, 13 Jul 2023 13:20:30 +0000 (UTC)
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     netdev@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>, kuba@kernel.org,
        simon.horman@corigine.com, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 2/2] selftests: rtnetlink: add MACsec offload tests
Date:   Thu, 13 Jul 2023 15:20:24 +0200
Message-Id: <c31ec07ad34e8ed5249e0667e44091332d1d48d4.1689173906.git.sd@queasysnail.net>
In-Reply-To: <cover.1689173906.git.sd@queasysnail.net>
References: <cover.1689173906.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Like the IPsec offload test, this requires netdevsim.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/rtnetlink.sh | 83 ++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index ba286d680fd9..488f4964365e 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -21,6 +21,7 @@ ALL_TESTS="
 	kci_test_vrf
 	kci_test_encap
 	kci_test_macsec
+	kci_test_macsec_offload
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -643,6 +644,88 @@ kci_test_macsec()
 	echo "PASS: macsec"
 }
 
+kci_test_macsec_offload()
+{
+	sysfsd=/sys/kernel/debug/netdevsim/netdevsim0/ports/0/
+	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
+	probed=false
+	local ret=0
+
+	ip macsec help 2>&1 | grep -q "^Usage: ip macsec"
+	if [ $? -ne 0 ]; then
+		echo "SKIP: macsec: iproute2 too old"
+		return $ksft_skip
+	fi
+
+	# setup netdevsim since dummydev doesn't have offload support
+	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
+		modprobe -q netdevsim
+		check_err $?
+		if [ $ret -ne 0 ]; then
+			echo "SKIP: macsec_offload can't load netdevsim"
+			return $ksft_skip
+		fi
+		probed=true
+	fi
+
+	echo "0" > /sys/bus/netdevsim/new_device
+	while [ ! -d $sysfsnet ] ; do :; done
+	udevadm settle
+	dev=`ls $sysfsnet`
+
+	ip link set $dev up
+	if [ ! -d $sysfsd ] ; then
+		echo "FAIL: macsec_offload can't create device $dev"
+		return 1
+	fi
+
+	ethtool -k $dev | grep -q 'macsec-hw-offload: on'
+	if [ $? -eq 1 ] ; then
+		echo "FAIL: macsec_offload netdevsim doesn't support MACsec offload"
+		return 1
+	fi
+
+	ip link add link $dev kci_macsec1 type macsec port 4 offload mac
+	check_err $?
+
+	ip link add link $dev kci_macsec2 type macsec address "aa:bb:cc:dd:ee:ff" port 5 offload mac
+	check_err $?
+
+	ip link add link $dev kci_macsec3 type macsec sci abbacdde01020304 offload mac
+	check_err $?
+
+	ip link add link $dev kci_macsec4 type macsec port 8 offload mac 2> /dev/null
+	check_fail $?
+
+	msname=kci_macsec1
+
+	ip macsec add "$msname" tx sa 0 pn 1024 on key 01 12345678901234567890123456789012
+	check_err $?
+
+	ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef"
+	check_err $?
+
+	ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef" sa 0 pn 1 on \
+		key 00 0123456789abcdef0123456789abcdef
+	check_err $?
+
+	ip macsec add "$msname" rx port 1235 address "1c:ed:de:ad:be:ef" 2> /dev/null
+	check_fail $?
+
+	# clean up any leftovers
+	for msdev in kci_macsec{1,2,3,4} ; do
+	    ip link del $msdev 2> /dev/null
+	done
+	echo 0 > /sys/bus/netdevsim/del_device
+	$probed && rmmod netdevsim
+
+	if [ $ret -ne 0 ]; then
+		echo "FAIL: macsec_offload"
+		return 1
+	fi
+	echo "PASS: macsec_offload"
+}
+
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
-- 
2.40.1

