Return-Path: <linux-kselftest+bounces-4806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4061856C9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982141F2278E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAB91468E5;
	Thu, 15 Feb 2024 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnuMB//x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4D14601F;
	Thu, 15 Feb 2024 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021577; cv=none; b=ghx30YcyF6QAxOAI2+bx0+xe0rnT2/86RfoXxr092odVL1ge78Tn0Cp6CnHfSFgCaa+Tezi5uVYSfN5D3vFfIoBWeLLoT9vK4jIGfo03f7nggbTvagjNvsFfoU5JeXjosrYo9t2REQe6aDiECJxx1fFualwCuq6sHujU/FuWnwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021577; c=relaxed/simple;
	bh=YZAGyjoJufUlAX5E7tD1GHS0mVfFjCwLVwMbYPCraK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9+xuXeZkteNvC3DX/P8LIGgvYeHea7LYxbX4af9CJJLL/+r0ajkm2+PLMJrClrswtZeCc/yBKCs0y7yg7dhTJptnoWWa/viFQijGPVrtRCeJOjEfEP88PcpsNhJ0CMq0fHYW9B6BVYBQRw1yi2gxx3PXzMn9Gqv0ETYvpmtX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnuMB//x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD30C43601;
	Thu, 15 Feb 2024 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021576;
	bh=YZAGyjoJufUlAX5E7tD1GHS0mVfFjCwLVwMbYPCraK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BnuMB//xUiDUYNJ6txw8eoPXXlw+VX9fenuyiaWK93M/uNJ/v5whURi9Npvb/cnvG
	 iQm7WiY4Zd4zKtZOtKIrej10VlZXl8LtllYbVRh+619WAf0TvZV7CnN40Ozqo7Yo1W
	 uG9jztY37ehl0pqE3dBu7xykRGcWwZ1yzkbCbeP1UCtjy9eNIoK33PX6tT89guGmFf
	 mXnwe+WkngEyUk793edAcUJzOUsJS7xhHO242PExkxDsUUYIUDY7Dd7PrWn9NiFZVA
	 zI1kTRa2zU1SRZLBH1WW2xaMrppEd8wwy8AZqmAlBPEtE1HzuEkb72UXyCsc/NhtSo
	 LBeO4zHyJSvCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:39 +0100
Subject: [PATCH net 12/13] selftests: mptcp: diag: unique 'in use' subtest
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-12-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YZAGyjoJufUlAX5E7tD1GHS0mVfFjCwLVwMbYPCraK8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcdrMQGAJCFZGj0ryoKgsMZV5OcxK3UZfTsB
 CFpYzwF+KuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHQAKCRD2t4JPQmmg
 c5a5EAC/h2na7rwOfRvKah5bpW5oWXK4sI/I3aJgrgC91O6IaiXs3B9YgeqHMDuAAEsnLkm7Ywu
 44qkBueydUcCZiT4BRHviTjR9fpBmTbWQPnhwtkEpZyKabSMOzeeDRCNvm4HvkIplkWR4e0Akft
 H+twoJl6DII+2u2P/w0y4laSDBePCjc7ty+5YR9iYuhxFj9s/uCZ4GQFyKAS8Bicdx4F3Ota/ZV
 W+47rlDatQNDCyhUzndGydWLTsXnPWedEqgJuGo2Qmsh6+oo5KVX7n5LNVveVET+TH84S/VurXX
 OmlG54K5+rPzBO+4BbkJ32laSU+JH9XHMb3Y6/lNm7DcVX4y84hm7w5JSEF0GTsdlJe9asjmV4/
 r1hKN62noNrQnIdDDoaoAzFmIKmIYzWqdHb+yr6jDJ4RxuqWJIGcOfliL/QZYHOKGR/0COjUyBL
 viOWdUuaWPUq1Q4Ogt9b5zce3s8FcZyVeNzAMgbQbtrzPELFQHyXkpHq4Onkx8Ig7SpkpHgMB5B
 nzuHK2rTNSoB01LfMU42Mum4wAGUp6QZbNkQEcC8xnt6y/MySypZRUgdEJ70hWzTT68MQeE1t9f
 OYPSHa/s6AfPnESvMBKtET+60WPQUiiTdvTq9w3ldx+2O8GG0CdrMMY1ke64dH0i6FOeCvTr8RO
 fua5GtI6eBIBQNA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated name.

Some 'in use' subtests from the diag selftest had the same names, e.g.:

    chk 0 msk in use after flush

Now the previous value is taken, to have different names, e.g.:

    chk 2->0 msk in use after flush

While at it, avoid repeating the full message, declare it once in the
helper.

Fixes: ce9902573652 ("selftests: mptcp: diag: format subtests results in TAP")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e0615c6ffb8d..266656a16229 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -166,9 +166,13 @@ chk_msk_listen()
 chk_msk_inuse()
 {
 	local expected=$1
-	local msg="$2"
+	local msg="....chk ${2:-${expected}} msk in use"
 	local listen_nr
 
+	if [ "${expected}" -eq 0 ]; then
+		msg+=" after flush"
+	fi
+
 	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
@@ -179,7 +183,7 @@ chk_msk_inuse()
 		sleep 0.1
 	done
 
-	__chk_nr get_msk_inuse $expected "$msg" 0
+	__chk_nr get_msk_inuse $expected "${msg}" 0
 }
 
 # $1: cestab nr
@@ -227,11 +231,11 @@ wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
-chk_msk_inuse 2 "....chk 2 msk in use"
+chk_msk_inuse 2
 chk_msk_cestab 2
 flush_pids
 
-chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_inuse 0 "2->0"
 chk_msk_cestab 0
 
 echo "a" | \
@@ -247,11 +251,11 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
-chk_msk_inuse 1 "....chk 1 msk in use"
+chk_msk_inuse 1
 chk_msk_cestab 1
 flush_pids
 
-chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_inuse 0 "1->0"
 chk_msk_cestab 0
 
 NR_CLIENTS=100
@@ -273,11 +277,11 @@ for I in `seq 1 $NR_CLIENTS`; do
 done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
-chk_msk_inuse $((NR_CLIENTS*2)) "....chk many msk in use"
+chk_msk_inuse $((NR_CLIENTS*2)) "many"
 chk_msk_cestab $((NR_CLIENTS*2))
 flush_pids
 
-chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_inuse 0 "many->0"
 chk_msk_cestab 0
 
 mptcp_lib_result_print_all_tap

-- 
2.43.0


