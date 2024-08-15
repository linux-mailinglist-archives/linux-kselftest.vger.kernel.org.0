Return-Path: <linux-kselftest+bounces-15387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01BE952A6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAEC282EAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4619DF5C;
	Thu, 15 Aug 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMfydG7N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B6198E78;
	Thu, 15 Aug 2024 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708814; cv=none; b=sEulDzUQAKFNI7oTmOrBvqXBIz2b/s4wO2+qIIzOl0wvcwvW//mpjhy9vWXVK1vD2Uqjp6zwRx9ReZIeY8/kzv60ydPnJ8mls7i6K+SW+4Ko9z5cJinDQji5Bz2FsvYMWkWkSGRyOO7hGlfFTlSVF11DdfbPcNoXUZATynEYfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708814; c=relaxed/simple;
	bh=/Mz/boUjXmOmN32HvNGQfixcUt/wZi69BHjt1UV0Bnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBfIX5UB0mGYZBfuLd7tSMgwFk9bKtL3iR9jtDZnbyEMM4H4Fd9ydSq6Si8YTbCzmTVOBpZxGIFz08z/iNvUpLniDT1VVLE/u0eHU1Tcl33L2LVppVkKJ7fNZUje1PFtMw+2fzqeiXmzsW7DHZvXwSnBPp1SVPFl/RfYN2Pd9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMfydG7N; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc56fd4de1so4992605ad.0;
        Thu, 15 Aug 2024 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723708812; x=1724313612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hiH07ToBeYPOHQhWubo3If8QklSP7VD5jj+EhGHa3U=;
        b=CMfydG7N9GP0titnfHZzxBYwYvURl7l9O49wPx2N5uzkDSS8+SH5pRMRcmFYUePVGt
         C6Ez3qrcEd5G1lSyzXPN94FJiUnsfgKwmzEh4piTbBnRcIS1niHgZ1O/cVjnthvk+NN2
         r4sLKxyehyXob1Zp7l0XzTUASiwTEBTw7G6BONlggw+zFTFvvuiKD3+2ZMarInzY+Zvy
         5NoYmYStqdPh0QeC0WVeNYMJD5+1tSU7T3qsFsL4ul7ChaQGUMFqwM/meXzgMigus13L
         YKpFpUGHhOCEPD/H0zHrp6J5vEgw90/DozTZoM3KB7trVp5r/iRulAJ+vyeUFF9x4kic
         yvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723708812; x=1724313612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hiH07ToBeYPOHQhWubo3If8QklSP7VD5jj+EhGHa3U=;
        b=RCl+F09btA+l/S/2I5kTvcBdP+3n3ETXMPPTid4S6MmGNm2gbmeSUneaHx+ECeno80
         POjsUwdh4+ayvvEj4agfnZtjaeiNW8mwmk0nPLDW+8Rv/B/lmOJ8LqMOIFw0cHlglZgo
         eW1i1yGpEmWcz/QfTMVxlGorZO02PPfbFtrwJKfDOuiQK4kMzSEw3S1IgXl3gZCYQYLV
         4ziAGqme2ktGRKFWPxtYoHRnb00/HXcW/S+xNFhWZ/q0Rh/K9JMu9YenfPoR3pKa1xIn
         ao4rxbU5tFxuepQnBkjQz6X5Vmuk2HNgQsVYxiuOQw5CNE4B6apKsjfagQxZqERc4jAf
         n6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSNbh7jxlUkKnsEC7T8Ql3jTA6eyM4jco8dTISRPA+a/3rc2app3UY8LYhk5r0tN3ctD9wNU8VSgYvaWhk45eBN741BYRBHY6jeNzI+PjWaZ1pBgzj52c0gZMYbJoIZP0kh2h8
X-Gm-Message-State: AOJu0Yx4CdIJcwqbdyWxRFYpHuuFSbujzG5zMABwx5nMyv1p04J284u/
	6CQpqtTm23DB9dayGpPY550M5/bXreByOP32Ca8BgYMAOTLowNQOLHNGlu0L
X-Google-Smtp-Source: AGHT+IGRtQzMUFIQNdBN1SXClgGfpcrknv45ij3BGzsmSDhz/5haklkzl772ncKUn1lyzFwH10QBYQ==
X-Received: by 2002:a17:903:41ca:b0:1fd:a412:5df2 with SMTP id d9443c01a7336-201ee515b17mr37563005ad.29.1723708811839;
        Thu, 15 Aug 2024 01:00:11 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375649sm6250515ad.124.2024.08.15.01.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:00:11 -0700 (PDT)
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
Subject: [PATCHv2 net 1/2] selftests: udpgro: report error when receive failed
Date: Thu, 15 Aug 2024 15:59:50 +0800
Message-ID: <20240815075951.189059-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240815075951.189059-1-liuhangbin@gmail.com>
References: <20240815075951.189059-1-liuhangbin@gmail.com>
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
  bad GRO lookup       ok
  multiple GRO socks   ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

 ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

 failed
 $ echo $?
 0

After:
  bad GRO lookup       ok
  multiple GRO socks   ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

 ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

 failed
 $ echo $?
 1

Fixes: 3327a9c46352 ("selftests: add functionals test for UDP GRO")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: init local ret for check_err. With this the current failure will not
    affect later test result.
---
 tools/testing/selftests/net/udpgro.sh | 44 ++++++++++++++++-----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 11a1ebda564f..4659cf01e438 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -46,17 +46,19 @@ run_one() {
 	local -r all="$@"
 	local -r tx_args=${all%rx*}
 	local -r rx_args=${all#*rx}
+	local ret=0
 
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
 
@@ -73,6 +75,7 @@ run_one_nat() {
 	local -r all="$@"
 	local -r tx_args=${all%rx*}
 	local -r rx_args=${all#*rx}
+	local ret=0
 
 	if [[ ${tx_args} = *-4* ]]; then
 		ipt_cmd=iptables
@@ -93,16 +96,17 @@ run_one_nat() {
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
 
@@ -111,20 +115,26 @@ run_one_2sock() {
 	local -r all="$@"
 	local -r tx_args=${all%rx*}
 	local -r rx_args=${all#*rx}
+	local ret=0
 
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


