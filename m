Return-Path: <linux-kselftest+bounces-4020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6614C84743D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EC01F2CF34
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE991487F1;
	Fri,  2 Feb 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fakxJMDE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36014690E
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890040; cv=none; b=R4tCjT9nJWBntoQYARCbiSvvoFdyeB0zlndI+6T/ozgrNme2Zaqgr6pPxBKqfjgU9owSjPnGDz00CqCIc/lJ5R4LhjAmeTfjOBTAYRKuWvtHTkFHnMbBqKrqjSY4Ew0j1vBxJ11+5xiZg06E7sj/vE4Jpbx8+q++j9Hcux1G8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890040; c=relaxed/simple;
	bh=dWqDluAGebC9iUHazZC6G1amxNpPOt/EUwg+LbLuE9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GmvjcgfQg8mwX2f2q4p6DU76aFuvZ5suBGlCDKnXwFzKWkLqantzmAqeSQY2EzQMlL278RuxqR9bAkGJIbi17qzYVjWOHpeEp/CoAzt1ISkfcB1WCmeGi3J3i0lyQ63+hf3D8VmSm+OXI/sFVj0VACvY1DyNugMslAXe2zP7AS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fakxJMDE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706890037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TeQN/mgjI+NOMRyCt7BGpixz6liM9dhqEGJXdte70KM=;
	b=fakxJMDEjaTWoaVBLG+PHicGBFJVDwNVZzuwR9F34R7SjXHYPRcjMjA9SHAuCTcG4X0PMl
	f6Xt7zwj0nTfLQegUi1uBYsbkZqBF4B4QnnPjtaotvK3jDRlDNRW2OV11GQahlyG5xp4EB
	VXywvOPQLUeKglLQrXE64sIRXWcpLgU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-y4sGsZFIMTuYSlqJTZ9amQ-1; Fri,
 02 Feb 2024 11:07:14 -0500
X-MC-Unique: y4sGsZFIMTuYSlqJTZ9amQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D2893C23FC3;
	Fri,  2 Feb 2024 16:07:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EBA7F492BC6;
	Fri,  2 Feb 2024 16:07:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: let big_tcp test cope with slow env
Date: Fri,  2 Feb 2024 17:06:59 +0100
Message-ID: <f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

In very slow environments, most big TCP cases including
segmentation and reassembly of big TCP packets have a good
chance to fail: by default the TCP client uses write size
well below 64K. If the host is low enough autocorking is
unable to build real big TCP packets.

Address the issue using much larger write operations.

Note that is hard to observe the issue without an extremely
slow and/or overloaded environment; reduce the TCP transfer
time to allow for much easier/faster reproducibility.

Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/big_tcp.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
index cde9a91c4797..2db9d15cd45f 100755
--- a/tools/testing/selftests/net/big_tcp.sh
+++ b/tools/testing/selftests/net/big_tcp.sh
@@ -122,7 +122,9 @@ do_netperf() {
 	local netns=$1
 
 	[ "$NF" = "6" ] && serip=$SERVER_IP6
-	ip net exec $netns netperf -$NF -t TCP_STREAM -H $serip 2>&1 >/dev/null
+
+	# use large write to be sure to generate big tcp packets
+	ip net exec $netns netperf -$NF -t TCP_STREAM -l 1 -H $serip -- -m 262144 2>&1 >/dev/null
 }
 
 do_test() {
-- 
2.43.0


