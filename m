Return-Path: <linux-kselftest+bounces-15298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A98F9515EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 09:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89291F21FA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 07:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD013D28A;
	Wed, 14 Aug 2024 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkezNfoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23086126;
	Wed, 14 Aug 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622302; cv=none; b=glVzhzz0SWQ1zwrS1Zq8byzaZvrCe9IQ2P9zqAHLxT8kl0l5/XNMfFXwsiTlwI46XUFL/t0Vs68MVZjJl992x6OoVwe9kWxnZFdEwl+8EP558GkTw8ZrsT0Ve9NxK/FDYWOS8Snd81CaCdTRMzrrEmjAXU26QCGb1FsGt8Fj8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622302; c=relaxed/simple;
	bh=5ehB49R2pGsW4AXFpwHjINbiSJM6SBCKjy7zrbMO+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYrFuQncu3OybnXXug0K1i1QIjnvm4i2n6dain68AutQZKCmVg4/GqYlG6QCWiX6tMLK8QbIxd/gWv1SZTyi5UkLZi49TvYKxidnwAo82ngyF54V8KMrBZF9efAO+qnLBFEL0Krs6FuyQBJ9NdO6tB4xCw6FXt3r/jCGnDJE4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkezNfoP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc569440e1so58280115ad.3;
        Wed, 14 Aug 2024 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723622300; x=1724227100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI1uFNMAgefINTV6709quHoxTKHlUabYhuIVTkxBxpU=;
        b=YkezNfoPJNcl9+SmCI8VSF1ciaOYFQxY5/AtQ5r7pXJZH6xe279onrrfo5fuTp5r7P
         D+5QcPd7/o0KqocH9j/q8rFAcyYO2iqzvFlXmYsr+mU+/K2eH1Q/tx4bcI+vNgEZ+tth
         LeSdxxaQm4amh5YrnBtUnJ9f5R4zepHgH6bRzstmXPktGzC6DpHUROByeW+UAET2EkCo
         LPKZMaCvtcq50/EH8OL1VTjyzmhlFil/8vbHbsbM8GdMeUXYvUQ/V5FRZ+9Ws7225jjW
         GdLbzi3UFhCNOFmnP0miC2+tKJMa84I9mjia5P23NW9Zscx3bbsth8cC7VlAIffJq/ZI
         wKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622300; x=1724227100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI1uFNMAgefINTV6709quHoxTKHlUabYhuIVTkxBxpU=;
        b=NaPWkdlQdkJgC/5zrOrlwTIZGvSd+4m5e4zoNQkQdr7fmUbztQp7wVApKFNgWWyPs9
         NF1P6OVRTGgXkDG9bTBdssCcsj/sfa0UpE8YZzuAH3emQS7j5SjBEteSKGifqRHF/9nb
         UuRMJaU/8afyUbRNPMqFU+OCAxFrSXl6zLa8aFsjBX9qnIv1F8DLMSBZd6MYMeHkxXKF
         u0ruYcQNuiWdYgXIhWnfowBeKpwPewZR905SFnv65TSKtsy5uNkBB24WaFnSNss6sFUR
         g0qi8KPhp1AVwk678Iwupn9MyA1do9vSFtVxm2ygUbFKeZ+1b/20NO7fAw0CiOX1G0DL
         7QSA==
X-Forwarded-Encrypted: i=1; AJvYcCVdiyIh9QheOQ7P35PjJiVLlXgEWyc2XQ53LcHmhuaIUcRS7TiGGz86uFzjEsj6GBFz/3xv4BmzEufmfihLlvIsMq6tEnwK0RILEuqyehapjtzsHoIRQRlPGFUKTSzAsZn49www
X-Gm-Message-State: AOJu0YypVGydh62P6CrrO5FZ2thynyGgWXGBVc5dcUM1aYd9Y7g3NtOL
	E/om7d7UYLuxRyoLQKmqlCHv7ffTOJs/RpIZfuebPE7hxgz4JFHG8EISCQDZnkGQIw==
X-Google-Smtp-Source: AGHT+IGw+NwV2FkUO2uCTJf3MtKEd2xGpjn6tdukKp/g/y/PVMdmC/j1yrAfkIVKEpt19GCSHxVmRQ==
X-Received: by 2002:a17:903:360d:b0:1fd:5e91:2b13 with SMTP id d9443c01a7336-201d638d811mr25618965ad.1.1723622300363;
        Wed, 14 Aug 2024 00:58:20 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1ba02bsm24475865ad.229.2024.08.14.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:58:20 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 1/2] selftests: udpgro: report error when receive failed
Date: Wed, 14 Aug 2024 15:57:57 +0800
Message-ID: <20240814075758.163065-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240814075758.163065-1-liuhangbin@gmail.com>
References: <20240814075758.163065-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we only check the latest senders's exit code. If the receiver
report failed, it is not recoreded. Fix it by checking the exit code
of all the involved processes.

Before:
  bad GRO lookup                          ok
  multiple GRO socks                      ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

 ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

 failed
 $ echo $?
 0

After:
  bad GRO lookup                          ok
  multiple GRO socks                      ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

 ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

 failed
 $ echo $?
 1

Fixes: 3327a9c46352 ("selftests: add functionals test for UDP GRO")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/udpgro.sh | 41 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 11a1ebda564f..7e0164247b83 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -49,14 +49,15 @@ run_one() {
 
 	cfg_veth
 
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} && \
-		echo "ok" || \
-		echo "failed" &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} &
+	local PID1=$!
 
 	wait_local_port_listen ${PEER_NS} 8000 udp
 	./udpgso_bench_tx ${tx_args}
-	ret=$?
-	wait $(jobs -p)
+	check_err $?
+	wait ${PID1}
+	check_err $?
+	[ "$ret" -eq 0 ] && echo "ok" || echo "failed"
 	return $ret
 }
 
@@ -93,16 +94,17 @@ run_one_nat() {
 	# ... so that GRO will match the UDP_GRO enabled socket, but packets
 	# will land on the 'plain' one
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -G ${family} -b ${addr1} -n 0 &
-	pid=$!
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${family} -b ${addr2%/*} ${rx_args} && \
-		echo "ok" || \
-		echo "failed"&
+	local PID1=$!
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${family} -b ${addr2%/*} ${rx_args} &
+	local PID2=$!
 
 	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
-	ret=$?
-	kill -INT $pid
-	wait $(jobs -p)
+	check_err $?
+	kill -INT ${PID1}
+	wait ${PID2}
+	check_err $?
+	[ "$ret" -eq 0 ] && echo "ok" || echo "failed"
 	return $ret
 }
 
@@ -115,16 +117,21 @@ run_one_2sock() {
 	cfg_veth
 
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} -p 12345 &
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} && \
-		echo "ok" || \
-		echo "failed" &
+	local PID1=$!
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} &
+	local PID2=$!
 
 	wait_local_port_listen "${PEER_NS}" 12345 udp
 	./udpgso_bench_tx ${tx_args} -p 12345
+	check_err $?
 	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
-	ret=$?
-	wait $(jobs -p)
+	check_err $?
+	wait ${PID1}
+	check_err $?
+	wait ${PID2}
+	check_err $?
+	[ "$ret" -eq 0 ] && echo "ok" || echo "failed"
 	return $ret
 }
 
-- 
2.45.0


