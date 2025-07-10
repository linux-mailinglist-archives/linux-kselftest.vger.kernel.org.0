Return-Path: <linux-kselftest+bounces-37018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5CAB00828
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84951188A92B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398E827A93D;
	Thu, 10 Jul 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFqP+RSm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A5198E9B
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163664; cv=none; b=EI+uQcTuX+5FX/fCWw69sBG/dmT5bZBpquiUUOu4/hUK/C7BvltDQf3DFs7wFrlWF2ppD3pdi2PDAbLQGsLkMm11KMuRLjkcJe778TduKARthQCazu5zSeYXUMVz0BsN2+03yOuJCsBhothekcY5uoOPwyhgK02MJp8CVosH6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163664; c=relaxed/simple;
	bh=1JPAgGXcOjSiPvGfcRcDiRFVmTU5ibj/DlZ8O3yc4bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pid6iGK99k1kOaNTF8Q9O16o/ZqHhxCqeflVuTcU3yCTbSBEb9eoQR9q+BJkjQbB0EZLvKIh4nq/WFd5d4yjZ2IOXaT5XERH0wQ9jNJQZK27CX4FQh6ORLsSzuefGixEbXThz2KI7McXA9QAH7IjDleAvsQscoBAlUpIyepcwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFqP+RSm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rC5Jhn+8+NRUFPS6Yn1vypt+ltUNxeE/XqdW1MRUqDU=;
	b=FFqP+RSmrWD+nuytOqDIY9UcVv5dZJTAmRF9exB2ohBOJ1Wa9GgJfCTbZmim6kDqfeCh0X
	7kO7U6qyPxrgjdCI3PAZiUuolBUKEDdH+BLq/ANH28R9F+pzZ+CWRz2p88dbniq8sxczQF
	BplZ5KIAodX9T4qj0YSOhEPCdbHY+JY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-yIiuJgkBMNKpKVKsYTlR1A-1; Thu,
 10 Jul 2025 12:07:34 -0400
X-MC-Unique: yIiuJgkBMNKpKVKsYTlR1A-1
X-Mimecast-MFC-AGG-ID: yIiuJgkBMNKpKVKsYTlR1A_1752163652
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F411319560B5;
	Thu, 10 Jul 2025 16:07:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.173])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32CB6180035C;
	Thu, 10 Jul 2025 16:07:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: increase inter-packet timeout in udpgro.sh
Date: Thu, 10 Jul 2025 18:04:50 +0200
Message-ID: <b0370c06ddb3235debf642c17de0284b2cd3c652.1752163107.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The mentioned test is not very stable when running on top of
debug kernel build. Increase the inter-packet timeout to allow
more slack in such environments.

Fixes: 3327a9c46352 ("selftests: add functionals test for UDP GRO")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/udpgro.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 1dc337c709f8..b17e032a6d75 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -48,7 +48,7 @@ run_one() {
 
 	cfg_veth
 
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 100 ${rx_args} &
 	local PID1=$!
 
 	wait_local_port_listen ${PEER_NS} 8000 udp
@@ -95,7 +95,7 @@ run_one_nat() {
 	# will land on the 'plain' one
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -G ${family} -b ${addr1} -n 0 &
 	local PID1=$!
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${family} -b ${addr2%/*} ${rx_args} &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 100 ${family} -b ${addr2%/*} ${rx_args} &
 	local PID2=$!
 
 	wait_local_port_listen "${PEER_NS}" 8000 udp
@@ -117,9 +117,9 @@ run_one_2sock() {
 
 	cfg_veth
 
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} -p 12345 &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 100 ${rx_args} -p 12345 &
 	local PID1=$!
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 100 ${rx_args} &
 	local PID2=$!
 
 	wait_local_port_listen "${PEER_NS}" 12345 udp
-- 
2.50.0


