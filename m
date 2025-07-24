Return-Path: <linux-kselftest+bounces-37905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E960B0FEE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 04:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750D87A391A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 02:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB61C6FF5;
	Thu, 24 Jul 2025 02:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrEb3W8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DA1B4F0A
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325040; cv=none; b=IZxJPw4lE/o51zUVIIC8V8NiefDKyXriqARYdz1E2PMW5ticmho8QkRjMToBhXWXwNsoV2tjlfS/7e9YuGJB9JWuLHaUJXwGftmlSQ6mZE2m1KD0nQj3MG4cKxb4xKIr/vNk3KhYQqmio3WpF59oal4RetF6VKmK2r8g7FGbLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325040; c=relaxed/simple;
	bh=sI5HoohiMh0dJoXH8Vn8sqbTfP+fPsv61JOjgpUYAGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acEiq5tEQNob1Q2CkGZSIlEIiZfQuYMJfAvsHPTOxTvU6s8gbNpd4icaHSYRoaNttz7t8GGX8n3KJtf7gVE/SDEq9CYntz8m3ZMVxxhKDnSAzVTvGcmUSOR47Q2Yaae1oRcVubeH/CFZQZUm9PM/1RYalCl3csN/gn7i2KhW+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrEb3W8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753325037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W+z2/dCvz+mstswbVtlHckvv536KTI/pOMjzMb8SkxU=;
	b=ZrEb3W8p39g7hIWvamnWUu6u8DxI08w/Oc5YvEG1I8+MsTOFdXZcpWRn6fjQ7+s3tcogSK
	mB9wSx0gM+gDGN2EdjBzR3qntpAM7Vg9fsnjGVip64859S06JCSwlh1SKVwr4Jg4WC8SKs
	ao5MD+uYlcWxhOHdHjQzt4x2lOKhuQk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-AF4RkuWpMK6iofgrW7DZmQ-1; Wed,
 23 Jul 2025 22:43:52 -0400
X-MC-Unique: AF4RkuWpMK6iofgrW7DZmQ-1
X-Mimecast-MFC-AGG-ID: AF4RkuWpMK6iofgrW7DZmQ_1753325030
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69375195FD06;
	Thu, 24 Jul 2025 02:43:49 +0000 (UTC)
Received: from yiche-laptop.redhat.com (unknown [10.72.112.178])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEEFF195608D;
	Thu, 24 Jul 2025 02:43:41 +0000 (UTC)
From: Yi Chen <yiche@redhat.com>
To: netdev@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	coreteam@netfilter.org,
	fw@strlen.de
Subject: [PATCH] selftests: netfilter: ipvs.sh: Explicity disable rp_filter on interface tunl0
Date: Thu, 24 Jul 2025 10:43:39 +0800
Message-ID: <20250724024339.11799-1-yiche@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Although setup_ns() set net.ipv4.conf.default.rp_filter=0,
loading certain module such as ipip will automatically create a tunl0 interface
in all netns including new created ones, this in script is before than
default.rp_filter=0 applied, as a result tunl0.rp_filter remains set to 1
which causes the test report FAIL when ipip module is preloaded.

Before fix:
Testing DR mode...
Testing NAT mode...
Testing Tunnel mode...
ipvs.sh: FAIL

After fix:
Testing DR mode...
Testing NAT mode...
Testing Tunnel mode...
ipvs.sh: PASS

Fixes: ("7c8b89ec5 selftests: netfilter: remove rp_filter configuration")

Signed-off-by: Yi Chen <yiche@redhat.com>
---
 tools/testing/selftests/net/netfilter/ipvs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/ipvs.sh b/tools/testing/selftests/net/netfilter/ipvs.sh
index 6af2ea3ad6b8..9c9d5b38ab71 100755
--- a/tools/testing/selftests/net/netfilter/ipvs.sh
+++ b/tools/testing/selftests/net/netfilter/ipvs.sh
@@ -151,7 +151,7 @@ test_nat() {
 test_tun() {
 	ip netns exec "${ns0}" ip route add "${vip_v4}" via "${gip_v4}" dev br0
 
-	ip netns exec "${ns1}" modprobe -q ipip
+	modprobe -q ipip
 	ip netns exec "${ns1}" ip link set tunl0 up
 	ip netns exec "${ns1}" sysctl -qw net.ipv4.ip_forward=0
 	ip netns exec "${ns1}" sysctl -qw net.ipv4.conf.all.send_redirects=0
@@ -160,10 +160,10 @@ test_tun() {
 	ip netns exec "${ns1}" ipvsadm -a -i -t "${vip_v4}:${port}" -r ${rip_v4}:${port}
 	ip netns exec "${ns1}" ip addr add ${vip_v4}/32 dev lo:1
 
-	ip netns exec "${ns2}" modprobe -q ipip
 	ip netns exec "${ns2}" ip link set tunl0 up
 	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.arp_ignore=1
 	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.arp_announce=2
+	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.tunl0.rp_filter=0
 	ip netns exec "${ns2}" ip addr add "${vip_v4}/32" dev lo:1
 
 	test_service
-- 
2.50.1


