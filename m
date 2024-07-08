Return-Path: <linux-kselftest+bounces-13313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F4192A3F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 15:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680A128159C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034C76035;
	Mon,  8 Jul 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0ZZAFXY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48B2744B
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446340; cv=none; b=Hun/6BRbxCQJs6gtch+5sVMSXNIAp795ilwudoB/8nxjnEwLUl+IY66XBg2rJ0r7oT8fGrg9Sa63mB3csXj5RToGRb+h8rPFccFzP23I3rxJtvNH6v54sE1KdkmhpzjKewy8yrTepxc5ZU93HoaA/rIpbPBGgQLz4kryRm/7RuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446340; c=relaxed/simple;
	bh=hKsC8hLKhAOme5JLNrdbUYNktX7OC48C0XxC+BBv+hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTyn7ScQmoxK0obo8Ge0oWxdg1kkoH9nf5tTcN0NAJtiJvPxCSZdlQu04n8bWO+yIsc+BLNFACOCmItnYS1GtFgiW1r4YlcOCcFK8Y+kgqyfGMHEbeCOaYeBFam22PmuCA3uLQkjKioI9FnlBzehURHqFTIbY9PfG0SL6BJ0dCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0ZZAFXY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720446337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oKoWxhmEZfLLj02S5HWOBt9H4nPDVhLNXef78/NS5KU=;
	b=G0ZZAFXYhJH5Al/P05VUxwLUwt6w0FSZGKQf3NTnvZtWg+11FYTT42bLW2FGb2jRajXCTu
	2Nkr6vDFQiGuHfhySpWMn5Z5fcKaRnPcNAA7sMOu4i/6lHpUw8skUiE4aiq6qmkV3KFeV3
	CxrQPt2fAxMhCjGY+EU7IMR4lsAmmWE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-ocPFQvYHOBmBMUaUp-3xmQ-1; Mon,
 08 Jul 2024 09:45:34 -0400
X-MC-Unique: ocPFQvYHOBmBMUaUp-3xmQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D9B91977338;
	Mon,  8 Jul 2024 13:45:26 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9373C1955F40;
	Mon,  8 Jul 2024 13:45:22 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] selftests: openvswitch: retry instead of sleep
Date: Mon,  8 Jul 2024 15:44:49 +0200
Message-ID: <20240708134451.3489802-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

There are a couple of places where the test script "sleep"s to wait for
some external condition to be met.

This is error prone, specially in slow systems (identified in CI by
"KSFT_MACHINE_SLOW=yes").

To fix this, add a "ovs_wait" function that tries to execute a command
a few times until it succeeds. The timeout used is set to 5s for
"normal" systems and doubled if a slow CI machine is detected.

This should make the following work:

$ vng --build  \
    --config tools/testing/selftests/net/config \
    --config kernel/configs/debug.config

$ vng --run . --user root -- "make -C tools/testing/selftests/ \
    KSFT_MACHINE_SLOW=yes TARGETS=net/openvswitch run_tests"

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 49 ++++++++++++++++---
 .../selftests/net/openvswitch/ovs-dpctl.py    |  1 +
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index bc71dbc18b21..83407b42073a 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -11,6 +11,7 @@ ksft_skip=4
 PAUSE_ON_FAIL=no
 VERBOSE=0
 TRACING=0
+WAIT_TIMEOUT=5
 
 tests="
 	arp_ping				eth-arp: Basic arp ping between two NS
@@ -29,6 +30,32 @@ info() {
 	[ $VERBOSE = 0 ] || echo $*
 }
 
+ovs_wait() {
+	info "waiting $WAIT_TIMEOUT s for: $@"
+
+	"$@"
+	if [[ $? -eq 0 ]]; then
+		info "wait succeeded inmediately"
+		return 0
+	fi
+
+	# A quick re-check helps speed up small races in fast systems.
+	# However, fractional sleeps might not necessarily work.
+	local start=0
+	sleep 0.1 || { sleep 1; start=1; }
+
+	for (( i=start; i<WAIT_TIMEOUT; i++ )); do
+		"$@"
+		if [[ $? -eq 0 ]]; then
+			info "wait succeeded after $i seconds"
+			return 0
+		fi
+		sleep 1
+	done
+	info "wait failed after $i seconds"
+	return 1
+}
+
 ovs_base=`pwd`
 sbxs=
 sbx_add () {
@@ -278,20 +305,21 @@ test_psample() {
 
 	# Record psample data.
 	ovs_spawn_daemon "test_psample" python3 $ovs_base/ovs-dpctl.py psample-events
+	ovs_wait grep -q "listening for psample events" ${ovs_dir}/stdout
 
 	# Send a single ping.
-	sleep 1
 	ovs_sbx "test_psample" ip netns exec client ping -I c1 172.31.110.20 -c 1 || return 1
-	sleep 1
 
 	# We should have received one userspace action upcall and 2 psample packets.
-	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || return 1
+	ovs_wait grep -q "userspace action command" $ovs_dir/s0.out
+	[[ $? -eq 0 ]] || return 1
 
 	# client -> server samples should only contain the first 14 bytes of the packet.
-	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
-			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
-	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
-			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
+	ovs_wait grep -qE "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" $ovs_dir/stdout
+	[[ $? -eq 0 ]] || return 1
+
+	ovs_wait grep -q "rate:4294967295,group:2,cookie:eeff0c" $ovs_dir/stdout
+	[[ $? -eq 0 ]] || return 1
 
 	return 0
 }
@@ -711,7 +739,8 @@ test_upcall_interfaces() {
 	ovs_add_netns_and_veths "test_upcall_interfaces" ui0 upc left0 l0 \
 	    172.31.110.1/24 -u || return 1
 
-	sleep 1
+	ovs_wait grep -q "listening on upcall packet handler" ${ovs_dir}/left0.out
+
 	info "sending arping"
 	ip netns exec upc arping -I l0 172.31.110.20 -c 1 \
 	    >$ovs_dir/arping.stdout 2>$ovs_dir/arping.stderr
@@ -811,6 +840,10 @@ shift $(($OPTIND-1))
 IFS="	
 "
 
+if test "X$KSFT_MACHINE_SLOW" == "Xyes"; then
+	WAIT_TIMEOUT=10
+fi
+
 for arg do
 	# Check first that all requested tests are available before running any
 	command -v > /dev/null "test_${arg}" || { echo "=== Test ${arg} not found"; usage; }
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 1e15b0818074..8a0396bfaf99 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -2520,6 +2520,7 @@ class PsampleEvent(EventSocket):
     marshal_class = psample_msg
 
     def read_samples(self):
+        print("listening for psample events", flush=True)
         while True:
             try:
                 for msg in self.get():
-- 
2.45.2


