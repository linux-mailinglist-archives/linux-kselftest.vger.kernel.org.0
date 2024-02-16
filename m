Return-Path: <linux-kselftest+bounces-4860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86B85813E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 16:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D821C20B5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6710813A88B;
	Fri, 16 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXDK3dxz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D612FF87
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097336; cv=none; b=rSgIpchEa1J4WeSPoWuGSewkIYPSMafwNA4UtUTD7jH262jk4OI3UVOa8BqAzPZhPxTLxoP7evYnVunr7YR/6HUSAUCNL+b0aCVrKtzPGKSchAFCdNCh6iydbda8h9+B9oKrTdkf7zh6aLnjh9sCA4DMJ+ww18tI/Uua9QMtUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097336; c=relaxed/simple;
	bh=2ScCJrJA5lZdY9sBm7rVR9EfM9rjVK16M7AEmsYUz5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwbkOH5uQVBIDLVG4mfDsa/p0nLqg8jyuUCLBIEaxfAA8PE/eNePt6+YryLFMR2ABVoLUVEsVS0+iAGm+a6myITThoEO9MC9n9ahOnSjvcfRTfGeFC32nP/o7o2SRxlET42B+OD3VpCI7FVlqRzn2Oof67ko60CtugBP7ZsVsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXDK3dxz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708097333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cS43J9B9DiB6M1fCrf9zR1TxskmGVyf4cYBuBgPYnU4=;
	b=NXDK3dxzekYk6Mrzi2c2Pp4UFuw04thXB7ejwQ5qrALQT0VI2h9im45tZXTRbB0BgRagfa
	f8V3dxx1+VlxZenq/LZza0jJEq58BGCUw3td39Bgeqi0EOmBSjlhEeTIjesynIX8Hjfwj7
	PtI9Tn5QIE0bbA3J3ZuPksqOXK7g4GA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-atuG1hO_OXqmsDcTnLLUYQ-1; Fri, 16 Feb 2024 10:28:50 -0500
X-MC-Unique: atuG1hO_OXqmsDcTnLLUYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71681863725;
	Fri, 16 Feb 2024 15:28:49 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F2B4D1C06890;
	Fri, 16 Feb 2024 15:28:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC 3/7] selftests: openvswitch: use non-graceful kills when needed
Date: Fri, 16 Feb 2024 10:28:42 -0500
Message-ID: <20240216152846.1850120-4-aconole@redhat.com>
In-Reply-To: <20240216152846.1850120-1-aconole@redhat.com>
References: <20240216152846.1850120-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Normally a spawned process under OVS is given a SIGTERM when the test
ends as part of cleanup.  However, in case the process is still lingering
for some reason, we also send a SIGKILL to force it down faster.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/openvswitch.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a5dbde482ba4..678a72ad47c1 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -91,7 +91,8 @@ ovs_add_if () {
 		python3 $ovs_base/ovs-dpctl.py add-if \
 		    -u "$2" "$3" >$ovs_dir/$3.out 2>$ovs_dir/$3.err &
 		pid=$!
-		on_exit "ovs_sbx $1 kill -TERM $pid 2>/dev/null"
+		on_exit "ovs_sbx $1 kill --timeout 1000 TERM \
+                                        --timeout 1000 KILL $pid 2>/dev/null"
 	fi
 }
 
@@ -108,7 +109,8 @@ ovs_netns_spawn_daemon() {
 	info "spawning cmd: $*"
 	ip netns exec $netns $*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
 	pid=$!
-	ovs_sbx "$sbx" on_exit "kill -TERM $pid 2>/dev/null"
+	ovs_sbx "$sbx" on_exit "kill --timeout 1000 TERM \
+                                    --timeout 1000 KILL $pid 2>/dev/null"
 }
 
 ovs_add_netns_and_veths () {
-- 
2.41.0


