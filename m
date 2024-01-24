Return-Path: <linux-kselftest+bounces-3493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889683B404
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 22:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D0F28723C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB61135403;
	Wed, 24 Jan 2024 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUDUJXo2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442F135418
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132081; cv=none; b=WzXTMw+6MTDZHkOYFcFS6GSvd0mJYkKZt8zM1fOn3zOf251G08evlEztwPNblnGuJxFtTO8ktxVjACJNddxtuy2Yf4LDc2jijjDmAWJ1DWQD1ahY0vRBa8m6tyoiXFvG9/yBq9jF3DCWetA3FdcyslEFDfLxBki/DiSxaL9WZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132081; c=relaxed/simple;
	bh=5WuvJY3aN3BdxPSU6MNv5FAhNY4DCF0eIbhGXWMwsiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyGvTrQhTli0zT0YuXSeXqOytziZyf8ciMxv52cO7CnXQW8osq5e9PG91tsr/jEkroiAVFScI/jDPzx3S3anTUzAN3Z83d1JVr9z+rO3sYXg2yVblenPpmzXyFAmjpicQ7iYwLl8z6ivch5UzDhHeZgQjgzfPtS17dqAuYHM7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUDUJXo2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706132078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8G9xRkMOo+i1Iah9aKA8dHZj7Qv1QBS8lrHWTGi9AAg=;
	b=dUDUJXo2D1UNOj6pT7U4ZfqSV0TQ6SuzE2WWlA1iigBx1hKjLre9BUqZg6hQarS8FI0JfE
	I3RcBexUDsqmMGY3wZbm5IT06Rge2uWUQKXwVQh/dTP4WeksBUi5VfZFjw5VlMut8qlZT7
	oWZexhmkJ6oyScwhajzVYT8oLlmdxxA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-JxB-9tKWPaSNU0njxx9bNQ-1; Wed,
 24 Jan 2024 16:34:33 -0500
X-MC-Unique: JxB-9tKWPaSNU0njxx9bNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BAE638212E6;
	Wed, 24 Jan 2024 21:34:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 117AE2166B32;
	Wed, 24 Jan 2024 21:34:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/3] selftests: net: explicitly wait for listener ready
Date: Wed, 24 Jan 2024 22:33:22 +0100
Message-ID: <4d58900fb09cef42749cfcf2ad7f4b91a97d225c.1706131762.git.pabeni@redhat.com>
In-Reply-To: <cover.1706131762.git.pabeni@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The UDP GRO forwarding test still hard-code an arbitrary pause
to wait for the UDP listener becoming ready in background.

That causes sporadic failures depending on the host load.

Replace the sleep with the existing helper waiting for the desired
port being exposed.

Fixes: a062260a9d5f ("selftests: net: add UDP GRO forwarding self-tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 5fa8659ab13d..d6b9c759043c 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+source net_helper.sh
+
 BPF_FILE="xdp_dummy.o"
 readonly BASE="ns-$(mktemp -u XXXXXX)"
 readonly SRC=2
@@ -119,7 +121,7 @@ run_test() {
 	ip netns exec $NS_DST $ipt -A INPUT -p udp --dport 8000
 	ip netns exec $NS_DST ./udpgso_bench_rx -C 1000 -R 10 -n 10 -l 1300 $rx_args &
 	local spid=$!
-	sleep 0.1
+	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC ./udpgso_bench_tx $family -M 1 -s 13000 -S 1300 -D $dst
 	local retc=$?
 	wait $spid
@@ -168,7 +170,7 @@ run_bench() {
 	ip netns exec $NS_DST bash -c "echo 2 > /sys/class/net/veth$DST/queues/rx-0/rps_cpus"
 	ip netns exec $NS_DST taskset 0x2 ./udpgso_bench_rx -C 1000 -R 10  &
 	local spid=$!
-	sleep 0.1
+	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC taskset 0x1 ./udpgso_bench_tx $family -l 3 -S 1300 -D $dst
 	local retc=$?
 	wait $spid
-- 
2.43.0


