Return-Path: <linux-kselftest+bounces-4503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2B851092
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 11:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FEF1F2246E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79DE182A1;
	Mon, 12 Feb 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0/5Oioz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AAF18658
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733192; cv=none; b=pU/NV2NbP2vb2L4FYDhPelgBEQLd1nNyY88VAoc0D26Ld55OQq7jzg/PfI27fIHNvjzoPqbJ3Bq6qW4E7mysyAntFT10VOIXIQlnRM19Pz+lh6t303sm+Z2sYSFLgfckOYP+JvB2Gp3/O07nT1nE2XXJ/J0URqVJxPbk10ITVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733192; c=relaxed/simple;
	bh=Nh7zNaVj2z2nIHELrgu2r2ca6IhD3UZiSO/W7s/DQ08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBBLPS5GAvjopkLiX7oXhx6Okb14cMSyoUWfFxP76C7mHNpVi/8KPk4psp4cLbOX3w95n4oiWcx+L5oZDzyC4wPiOcfOEXMvXGZ2Q5qhjSyoWlj1EpC6ADJDTBkCA8GKvb4ZWH3NvMvkyfY/cOT9s0DoS66WiOOQUkPnjbSH3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0/5Oioz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707733190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ML+ks/mrmJ+yWpnB72GddVe4Srfa3RY8o++1uILmJOk=;
	b=W0/5OiozsWhvn91ZBPKhPaJRBlN2bJA3s1HrdAnkRHVPsY6pr5cFPSPn/ApeoIfFoI1jVh
	im0wPAkRzaS13SIcsphegtV35bNdSpxMACnxK+0cJkQkBBef5jgrB2WqAhAltGTJHviBFM
	rUFYz+CpdFPsFi6jXYsgzj3ARLFPf7g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Hi0QFMrYNTeaeILGn6R0XQ-1; Mon, 12 Feb 2024 05:19:48 -0500
X-MC-Unique: Hi0QFMrYNTeaeILGn6R0XQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8094783DE17;
	Mon, 12 Feb 2024 10:19:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D50346EDD4;
	Mon, 12 Feb 2024 10:19:37 +0000 (UTC)
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
Subject: [PATCH net 2/2] selftests: net: more pmtu.sh fixes
Date: Mon, 12 Feb 2024 11:19:24 +0100
Message-ID: <4f51c11a1ce7ca7a4dabd926cffff63dadac9ba1.1707731086.git.pabeni@redhat.com>
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

The netdev CI is reporting failures for the pmtu test:

  [  115.929264] br0: port 2(vxlan_a) entered forwarding state
  # 2024/02/08 17:33:22 socat[7871] E bind(7, {AF=10 [0000:0000:0000:0000:0000:0000:0000:0000]:50000}, 28): Address already in use
  # 2024/02/08 17:33:22 socat[7877] E write(7, 0x5598fb6ff000, 8192): Connection refused
  # TEST: IPv6, bridged vxlan4: PMTU exceptions                         [FAIL]
  # File size 0 mismatches exepcted value in locally bridged vxlan test

The root cause is apparently a socket created by a previous iteration
of the relevant loop still lasting in LAST_ACK state.

Note that even the file size check is racy, the receiver process dumping
the file could still be running in background

Allow the listener to bound on the same local port via SO_REUSEADDR and
collect file output file size only after the listener completion.

Fixes: 136a1b434bbb ("selftests: net: test vxlan pmtu exceptions with tcp")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index d65fdd407d73..cfc84958025a 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1336,16 +1336,16 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 		else
 			TCPDST="TCP:[${dst}]:50000"
 		fi
-		${ns_b} socat -T 3 -u -6 TCP-LISTEN:50000 STDOUT > $tmpoutfile &
+		${ns_b} socat -T 3 -u -6 TCP-LISTEN:50000,reuseaddr STDOUT > $tmpoutfile &
 		local socat_pid=$!
 
 		wait_local_port_listen ${NS_B} 50000 tcp
 
 		dd if=/dev/zero status=none bs=1M count=1 | ${target} socat -T 3 -u STDIN $TCPDST,connect-timeout=3
 
+		wait ${socat_pid}
 		size=$(du -sb $tmpoutfile)
 		size=${size%%/tmp/*}
-		wait ${socat_pid}
 
 		[ $size -ne 1048576 ] && err "File size $size mismatches exepcted value in locally bridged vxlan test" && return 1
 	done
-- 
2.43.0


