Return-Path: <linux-kselftest+bounces-37564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F3B0A5FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0151C80687
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284CD2DC32A;
	Fri, 18 Jul 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cV0ZtEwA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6A1459FA
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848205; cv=none; b=Mr3Ep0mp5EIH6i66FOMnx/tmauhXtjBYxfyslmxqZA81QVZYluXMATzP5YxLdliGA8He/6gvuq6cfYT/jBSxLt8KppleAnCmC+GIbWgvGHKJ0Y+6HUO0v8Rgu5Qb1NFiv7p0Q6M5boC0AVdFEqfkGvHocNcU1JHfLigOjHv1eg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848205; c=relaxed/simple;
	bh=IEpz5MuPybctEE6oMtgWNR5YKWeY5hFOXCAWZ+aBtvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNVKgddzZoVKIoqyCdzAQ+TzIUoBr770xZeG2Ma5QcR7W+2YsvUK4KOssavjd1BzIswzAPobjfnORvWla8AhkInpwpP6Aqye+aZ+Ezuge69NTOaNy7kSttCJU5OL91XbhP+32o6VLw9/Fb8l2hVLvJ+2A2yKy3LujfFtK857fSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cV0ZtEwA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752848202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jTEbkRUl2wcpnkebbyZvnRyOtKvRlXMkLNOPG34fi+M=;
	b=cV0ZtEwAIuMrg0frJ/mQHMoFPVvkA++eSOQD1lfHNiiNtl3f7eqZRk6blt1U5vNerGr/Yc
	OBVgZubPcxJR/V9q708Dcu1psga2TzsoHsZIbC5+9BNoCf3Mziiu/xkw2vKEXuSt4Kb281
	XzXwO0cnT111DGfa3lDCQO+GVf+Ldfc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-QqyLjZqaO86O4eA9wIyn-w-1; Fri,
 18 Jul 2025 10:16:37 -0400
X-MC-Unique: QqyLjZqaO86O4eA9wIyn-w-1
X-Mimecast-MFC-AGG-ID: QqyLjZqaO86O4eA9wIyn-w_1752848195
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B12B1800291;
	Fri, 18 Jul 2025 14:16:35 +0000 (UTC)
Received: from redhat.com (unknown [10.72.116.131])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68DEE18016F9;
	Fri, 18 Jul 2025 14:16:27 +0000 (UTC)
From: shuali@redhat.com
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: tc: Add generic erspan_opts matching support for tc-flower
Date: Fri, 18 Jul 2025 22:16:12 +0800
Message-ID: <1f354a1afd60f29bbbf02bd60cb52ecfc0b6bd17.1752848172.git.shuali@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Li Shuang <shuali@redhat.com>

Add test cases to tc_flower.sh to validate generic matching on ERSPAN
options. Both ERSPAN Type II and Type III are covered.

Also add check_tc_erspan_support() to verify whether tc supports
erspan_opts.

Signed-off-by: Li Shuang <shuali@redhat.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 14 +++++
 .../selftests/net/forwarding/tc_flower.sh     | 52 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9308b2f77fed..890b3374dacd 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -142,6 +142,20 @@ check_tc_version()
 	fi
 }
 
+check_tc_erspan_support()
+{
+	local dev=$1; shift
+
+	tc filter add dev $dev ingress pref 1 handle 1 flower \
+		erspan_opts 1:0:0:0 &> /dev/null
+	if [[ $? -ne 0 ]]; then
+		echo "SKIP: iproute2 too old; tc is missing erspan support"
+		return $ksft_skip
+	fi
+	tc filter del dev $dev ingress pref 1 handle 1 flower \
+		erspan_opts 1:0:0:0 &> /dev/null
+}
+
 # Old versions of tc don't understand "mpls_uc"
 check_tc_mpls_support()
 {
diff --git a/tools/testing/selftests/net/forwarding/tc_flower.sh b/tools/testing/selftests/net/forwarding/tc_flower.sh
index b1daad19b01e..b58909a93112 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower.sh
@@ -6,7 +6,7 @@ ALL_TESTS="match_dst_mac_test match_src_mac_test match_dst_ip_test \
 	match_ip_tos_test match_indev_test match_ip_ttl_test
 	match_mpls_label_test \
 	match_mpls_tc_test match_mpls_bos_test match_mpls_ttl_test \
-	match_mpls_lse_test"
+	match_mpls_lse_test match_erspan_opts_test"
 NUM_NETIFS=2
 source tc_common.sh
 source lib.sh
@@ -676,6 +676,56 @@ match_mpls_lse_test()
 	log_test "mpls lse match ($tcflags)"
 }
 
+match_erspan_opts_test()
+{
+	RET=0
+
+	check_tc_erspan_support $h2 || return 0
+
+	# h1 erspan setup
+	tunnel_create erspan1 erspan 192.0.2.1 192.0.2.2 dev $h1 seq key 1001 \
+		tos C ttl 64 erspan_ver 1 erspan 6789 # ERSPAN Type II
+	tunnel_create erspan2 erspan 192.0.2.1 192.0.2.2 dev $h1 seq key 1002 \
+		tos C ttl 64 erspan_ver 2 erspan_dir egress erspan_hwid 63 \
+		# ERSPAN Type III
+	ip link set dev erspan1 master v$h1
+	ip link set dev erspan2 master v$h1
+	# h2 erspan setup
+	ip link add ep-ex type erspan ttl 64 external # To collect tunnel info
+	ip link set ep-ex up
+	ip link set dev ep-ex master v$h2
+	tc qdisc add dev ep-ex clsact
+
+	# ERSPAN Type II [decap direction]
+	tc filter add dev ep-ex ingress protocol ip  handle 101 flower \
+		$tcflags enc_src_ip 192.0.2.1 enc_dst_ip 192.0.2.2 \
+		enc_key_id 1001 erspan_opts 1:6789:0:0 \
+		action drop
+	# ERSPAN Type III [decap direction]
+	tc filter add dev ep-ex ingress protocol ip  handle 102 flower \
+		$tcflags enc_src_ip 192.0.2.1 enc_dst_ip 192.0.2.2 \
+		enc_key_id 1002 erspan_opts 2:0:1:63 action drop
+
+	ep1mac=$(mac_get erspan1)
+	$MZ erspan1 -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q
+	tc_check_packets "dev ep-ex ingress" 101 1
+	check_err $? "ERSPAN Type II"
+
+	ep2mac=$(mac_get erspan2)
+	$MZ erspan2 -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q
+	tc_check_packets "dev ep-ex ingress" 102 1
+	check_err $? "ERSPAN Type III"
+
+	# h2 erspan cleanup
+	tc qdisc del dev ep-ex clsact
+	tunnel_destroy ep-ex
+	# h1 erspan cleanup
+	tunnel_destroy erspan2 # ERSPAN Type III
+	tunnel_destroy erspan1 # ERSPAN Type II
+
+	log_test "erspan_opts match ($tcflags)"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.50.1


