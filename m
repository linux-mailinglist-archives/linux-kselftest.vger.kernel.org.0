Return-Path: <linux-kselftest+bounces-3868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70E84468C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 18:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6B61C21FD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8612DDBA;
	Wed, 31 Jan 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBO+9oSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522912F592
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723574; cv=none; b=isuAoDoXyrwpFFD0YD7muOlyVh6o+VyV43xh+DNaMyh8SwBd6kk2DjEeAxsgM6/2a4IbSNUN4Gsb4MwnhksUcTy/W6Oy0FfgFMHnEw1yRidSeMhYtAOP38olUynJ1F8gRNJ2iL4mlG9PJ+ha6XmarqSWRyvSDhZhmNaooTQV2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723574; c=relaxed/simple;
	bh=/U3++LNgHNq5LoSfa03kHjmpVY/55mZ0Wq4o9X3+CQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJcRYWl2a7YgmNVkr+DQW9mJtj3wJ20mvgN3cyeK+MP3vIDVjx9MW2Y3nsob1/8dfxHX/gb8Hi1LgwgOlV9PvUt5VPtBCQaQ42z/Pfzlr+FpipGKkk7NL7/0vS3fQBJU8He1Qh8HhguxQS2MOJZoIbYLoRtDnY0E9WxsS81rxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBO+9oSa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706723571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFXJQBZcC1NUjddVG97YNlr9vxCb4Zf6zNEjvTg+J5M=;
	b=cBO+9oSa/cT6HLGj4BHasUz3zBVk2C72sEI86G0aOm/1dOPV8NsWayz8aXQZQRs43SNbLt
	eN+oCx7u4l0TJ29ZGE5+CsTWlxSuWI2TpdbG4+/bauDmL0pf1tF+zKKJHh5JpqZExqVIQB
	4PP9pyIZhLpjZyuLasZtjOugDS9Zgp8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-Xw3uo8FxMw-rPi4N7_z3Kg-1; Wed, 31 Jan 2024 12:52:45 -0500
X-MC-Unique: Xw3uo8FxMw-rPi4N7_z3Kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5BBD868A00;
	Wed, 31 Jan 2024 17:52:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.202])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4729A8B;
	Wed, 31 Jan 2024 17:52:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/3] selftests: net: fix setup_ns usage in rtnetlink.sh
Date: Wed, 31 Jan 2024 18:52:28 +0100
Message-ID: <41353e7d44663b76d8e4e26eaddf116adf477903.1706723341.git.pabeni@redhat.com>
In-Reply-To: <cover.1706723341.git.pabeni@redhat.com>
References: <cover.1706723341.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The setup_ns helper marks the testns global variable as
readonly. Later attempts to set such variable are unsuccessful,
causing a couple test failures.

Avoid completely the variable re-initialization and let the
function access the global value.

Fixes: ("selftests: rtnetlink: use setup_ns in bonding test")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 4667d74579d1..874a2952aa8e 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -440,7 +440,6 @@ kci_test_encap_vxlan()
 	local ret=0
 	vxlan="test-vxlan0"
 	vlan="test-vlan0"
-	testns="$1"
 	run_cmd ip -netns "$testns" link add "$vxlan" type vxlan id 42 group 239.1.1.1 \
 		dev "$devdummy" dstport 4789
 	if [ $? -ne 0 ]; then
@@ -485,7 +484,6 @@ kci_test_encap_fou()
 {
 	local ret=0
 	name="test-fou"
-	testns="$1"
 	run_cmd_grep 'Usage: ip fou' ip fou help
 	if [ $? -ne 0 ];then
 		end_test "SKIP: fou: iproute2 too old"
@@ -526,8 +524,8 @@ kci_test_encap()
 	run_cmd ip -netns "$testns" link set lo up
 	run_cmd ip -netns "$testns" link add name "$devdummy" type dummy
 	run_cmd ip -netns "$testns" link set "$devdummy" up
-	run_cmd kci_test_encap_vxlan "$testns"
-	run_cmd kci_test_encap_fou "$testns"
+	run_cmd kci_test_encap_vxlan
+	run_cmd kci_test_encap_fou
 
 	ip netns del "$testns"
 	return $ret
-- 
2.43.0


