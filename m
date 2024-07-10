Return-Path: <linux-kselftest+bounces-13450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8592CDDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213972830B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B518EFF6;
	Wed, 10 Jul 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/hcbbEj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F07CF34
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602312; cv=none; b=aYsnyFwi/BTYHKeBB9dBKvVJtIBcuOE7VH3+3LsHppKguQZBeXhCr8zrmSxgliKc8kydnAPaxTYx9b0Myd7ro1MUtNi/mJqTT4D7xnzU0zqi8QWiADP74/VaGbS+lyNQ2UEh4gJOrYjV/TsUCSE/YR69vuY2txNzLfqW1kmKP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602312; c=relaxed/simple;
	bh=PBIpta0YjOKEnNozLsSWGsjK6vJDUcH8zexdl5Nhcxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wtwt99mGLoNpCULqINKc9MKrBbrUz8LasJ4J7u3wz+aKIr34+vN5dmcPugks04VJjisQ9CSbqUY643p/W9hUGmag4S96WNGe79GvieiPr2ibJCuw25+xUcKfcLfXif4S6HlSmiYaVeeqcRQdf6l9v3MpK6fkR8TuoXOqtx5Ycy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/hcbbEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720602309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lo9HjTqXg+zsuHsAZC/cmPCTHvmkkLcTQoYiizXM1HQ=;
	b=Z/hcbbEjXANyw+kUUHy5fN6HA4fsUN9FcZiYqndnKpXRUyHdgA1Cx7JVKi53Tq08ajQbwF
	Wvq/gQMLIZOcGhBP3IxGsdkIUhlK//V8n8PblnOFrbsac3KLTKV/PWXxd/b+sGmddAk2QS
	58NVskoUT9YpmRNDGSuETw+nPtMEILs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-zbX3YZPhOjaKYtuR5Kmb6g-1; Wed,
 10 Jul 2024 05:05:08 -0400
X-MC-Unique: zbX3YZPhOjaKYtuR5Kmb6g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75FAC19560AA;
	Wed, 10 Jul 2024 09:05:06 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCE313000181;
	Wed, 10 Jul 2024 09:05:02 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] selftests: openvswitch: retry instead of sleep
Date: Wed, 10 Jul 2024 11:04:59 +0200
Message-ID: <20240710090500.1655212-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 .../selftests/net/openvswitch/openvswitch.sh  | 45 +++++++++++++++----
 .../selftests/net/openvswitch/ovs-dpctl.py    |  1 +
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index bc71dbc18b21..cc0bfae2bafa 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -11,6 +11,11 @@ ksft_skip=4
 PAUSE_ON_FAIL=no
 VERBOSE=0
 TRACING=0
+WAIT_TIMEOUT=5
+
+if test "X$KSFT_MACHINE_SLOW" == "Xyes"; then
+	WAIT_TIMEOUT=10
+fi
 
 tests="
 	arp_ping				eth-arp: Basic arp ping between two NS
@@ -29,6 +34,30 @@ info() {
 	[ $VERBOSE = 0 ] || echo $*
 }
 
+ovs_wait() {
+	info "waiting $WAIT_TIMEOUT s for: $@"
+
+	if "$@" ; then
+		info "wait succeeded immediately"
+		return 0
+	fi
+
+	# A quick re-check helps speed up small races in fast systems.
+	# However, fractional sleeps might not necessarily work.
+	local start=0
+	sleep 0.1 || { sleep 1; start=1; }
+
+	for (( i=start; i<WAIT_TIMEOUT; i++ )); do
+		if "$@" ; then
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
@@ -278,20 +307,19 @@ test_psample() {
 
 	# Record psample data.
 	ovs_spawn_daemon "test_psample" python3 $ovs_base/ovs-dpctl.py psample-events
+	ovs_wait grep -q "listening for psample events" ${ovs_dir}/stdout
 
 	# Send a single ping.
-	sleep 1
 	ovs_sbx "test_psample" ip netns exec client ping -I c1 172.31.110.20 -c 1 || return 1
-	sleep 1
 
 	# We should have received one userspace action upcall and 2 psample packets.
-	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || return 1
+	ovs_wait grep -q "userspace action command" $ovs_dir/s0.out || return 1
 
 	# client -> server samples should only contain the first 14 bytes of the packet.
-	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
-			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
-	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
-			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
+	ovs_wait grep -qE "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
+		$ovs_dir/stdout || return 1
+
+	ovs_wait grep -q "rate:4294967295,group:2,cookie:eeff0c" $ovs_dir/stdout || return 1
 
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


