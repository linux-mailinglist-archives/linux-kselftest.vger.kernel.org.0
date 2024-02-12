Return-Path: <linux-kselftest+bounces-4504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC56F851091
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 11:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97711282E85
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D381AAD0;
	Mon, 12 Feb 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwDflgyX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422118AE4
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733192; cv=none; b=ah9JqSiVmshP1iViVE5giYd+grEOvQL0p0ijswSzjkm1mhaYGnw45U3koAVTCQZC8hFHMxy9n5lRZLlrVye+MSME6J6DOKkOu4c6ElcaOtF6+H3O36evLXlNaqS6P5RZrIiQFGrHRnD2EriRLVfVGx3Yox8ZLPQjkaH89umOMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733192; c=relaxed/simple;
	bh=G1u5IgLvZZEE5qO/VlNIX+15/Yl7wlSKTZ7a+esQyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kdhuwi3bxYqvItbLZ4iKgONpPrCzBsiy1GhP9pdepLw2pVkWn74tTcD4HjbyH59q/0wwJrlgzbD358CXr0QW2sNlV45LlsKrFiWPBOXIG3zRipW6jIx5NxdT2Pd7PX5RtPX2K2mEVycHcYAXmtI4LeHQZ8tY5HoFod9zQQjxR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwDflgyX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707733190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cj7JHEQ3aEOOqtHo86kfYJieZSXleOCNgtlV9sLANrk=;
	b=FwDflgyX01dLXtOZvTUN+1Nmn2SxZ7AdxFscB3VKFc6aJv9wRZB006sXipycfTqQKGBTFQ
	Uio4rFIoPeZ3K0BAhmaJYyX7MzdZOA1zjNjIs8hVBxPnBfuTFcqnyUvGyQ3f5xq9wt7H1K
	W/q8UNWxPG8WrbZs1ZfzOjBnMzslQkU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-YtXNUmEzOyaGAmJGKmMF6Q-1; Mon,
 12 Feb 2024 05:19:47 -0500
X-MC-Unique: YtXNUmEzOyaGAmJGKmMF6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F3901C172AC;
	Mon, 12 Feb 2024 10:19:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C23CF4AE3F1;
	Mon, 12 Feb 2024 10:19:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/2] selftests: net: more strict check in net_helper
Date: Mon, 12 Feb 2024 11:19:23 +0100
Message-ID: <192b3dbc443d953be32991d1b0ca432bd4c65008.1707731086.git.pabeni@redhat.com>
In-Reply-To: <cover.1707731086.git.pabeni@redhat.com>
References: <cover.1707731086.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The helper waiting for a listener port can match any socket whose
hexadecimal representation of source or destination addresses
matches that of the given port.

Additionally, any socket state is accepted.

All the above can let the helper return successfully before the
relevant listener is actually ready, with unexpected results.

So far I could not find any related failure in the netdev CI, but
the next patch is going to make the critical event more easily
reproducible.

Address the issue matching the port hex only vs the relevant socket
field and additionally checking the socket state for TCP sockets.

Fixes: 3bdd9fd29cb0 ("selftests/net: synchronize udpgro tests' tx and rx connection")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/net_helper.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
index 4fe0befa13fb..6596fe03c77f 100644
--- a/tools/testing/selftests/net/net_helper.sh
+++ b/tools/testing/selftests/net/net_helper.sh
@@ -8,13 +8,16 @@ wait_local_port_listen()
 	local listener_ns="${1}"
 	local port="${2}"
 	local protocol="${3}"
-	local port_hex
+	local pattern
 	local i
 
-	port_hex="$(printf "%04X" "${port}")"
+	pattern=":$(printf "%04X" "${port}") "
+
+	# for tcp protocol additionally check the socket state
+	[ ${protocol} = "tcp" ] && pattern="${pattern}0A"
 	for i in $(seq 10); do
-		if ip netns exec "${listener_ns}" cat /proc/net/"${protocol}"* | \
-		   grep -q "${port_hex}"; then
+		if ip netns exec "${listener_ns}" awk '{print $2" "$4}' \
+		   /proc/net/"${protocol}"* | grep -q "${pattern}"; then
 			break
 		fi
 		sleep 0.1
-- 
2.43.0


