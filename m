Return-Path: <linux-kselftest+bounces-47999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 639ECCE7D36
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 19:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E17303092C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A153314C2;
	Mon, 29 Dec 2025 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="Z1grI7E+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster3-host9-snip4-5.eps.apple.com [57.103.77.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333B33032A
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Dec 2025 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033252; cv=none; b=St2FZu3xQHwx01waUTt16fm/2bxaUjukI1HjWul3QqNusBl1IOvKYjDbv1CwAAC4IZA2iXRuK0qopP5pSr6d4t8f+GKnR261pLbb4VGCZDv8VQBk9N5IbTKJ3t9mvjNOH0kz6LbHfJIwbeWBfcriE4TpyskX4PxEsqsIDf9GvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033252; c=relaxed/simple;
	bh=Mi130XGYCHec4OXzL+gxRDI9DMokNqaQL0EQ6yw0ngM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZjuVpyhPRN+meD8wd6RPW+OFw9MX6O3N6qfGvmI2hJYSP/MhOMD7/w2x5lXo3RjwKTAwLANhmSyDyCSdzqdKBXv+4vhD74oau8PCWOlnJg7vwj0uiBNCYP/cKtCZGxyR5jBagOR4ZfwMQrhSwZDI49tN6CJET9cVQVRLKWkPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=Z1grI7E+ reason="key not found in DNS"; arc=none smtp.client-ip=57.103.77.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPS id 8E80718005EA;
	Mon, 29 Dec 2025 18:34:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=cV2EwEWsfYK4Aqz7v9TjiRD2mRX34Z/MplIFfUXaEsc=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Z1grI7E+EQcIOGcg+LAGj5ShSSBosgR3KZfXb0F/BhoWpFcDHKj4kX4Ww+VokN21QLuudilj1G7wZOHGzRQWQ43T06Qd0T4caR5sajU0F7xlRGEsibNqaPmu3I/xlN/qIgZeOgjSGFba8DSF9AgYak99pDsSDIwBwn41XPJHd+4IXwjW71SPev9Amn3qGmC7BiJQMAHthJkp78d8uioSSwT9W4ZYOrECHtSofs7aJB3TdXaOEM7ahZfkEr+E7BNw+t2YOUNHt3Cc8qAytt/It3dAmRLMujd4QDfh5hz7mHI/U+938D+D1lVjqse0tzeDSBuGvd2u7H0v7eLMXdbvTQ==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPSA id 0F1EF18000AD;
	Mon, 29 Dec 2025 18:34:05 +0000 (UTC)
From: yk@y-koj.net
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 5/5] selftests: net: report SKIP if TFO test processes timed out
Date: Tue, 30 Dec 2025 03:32:38 +0900
Message-ID: <a4b42beade5730803bdee9c2631b1f4e1364c3f6.1767032397.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1767032397.git.yk@y-koj.net>
References: <cover.1767032397.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=ALPFdfBd c=1 sm=1 tr=0 ts=6952c9a1 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8
 a=wXUYcULF-yfjjPYjaGEA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MCBTYWx0ZWRfX8XIWiNzE9coh
 gNKgFdgDEPbBr/KAy5PCfXJNUNVdigB/BFVxof17xRgAwIHiDRFTFImTN4sVMd1TJT2/KUcMzN1
 LPg4JUf6UR2JJZhRZsFLSvdfn3thjOncNqTz0z9suvvJzbZZbz1QeKKoR/v0ChXHtPptCHilkqK
 c7hmmQ/dZhF8zQGdmxqpVOeJObGdVbSKOjS2Y9shoHBgOw8jydlC/6/0tfGzIGrdRjiILU42pMV
 1wGoUd85YiHAPAG5suTTIe0gru8oHhutfFGEMcJLGuGNpdC0S8R1UBnDiCVgf80ChIijuITJ3wM
 uFy9plcnel08m5ISkhn
X-Proofpoint-ORIG-GUID: sHOBAgfL0sHsPGdOQuD2Gi6xE1gBmejO
X-Proofpoint-GUID: sHOBAgfL0sHsPGdOQuD2Gi6xE1gBmejO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0 mlxlogscore=853 adultscore=0 clxscore=1030
 malwarescore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290170
X-JNJ: AAAAAAABIHpUnPxyaBlu0UN7W1AkFKyQaI67vP7qv/bn+r4h+oBdm62Fh4Wl1HDnQp5WO4f+4GkDElNQbvf2VlFbmP01ou1qOrjm/hpoDJVetUZM6NnxSwkRxorjmp17YcK/ngAdGjVzmgtJRKnE428HD+F5spMYwBC2wjHH9FDlncILAkj9U680Ok3a1ArJyYNl80h26TyhK1m1aBX4/79Li2jjHJaw/B9gzS3PC2ALQEv6jWjvnKy5uuXsYvwacCESAuOttoFm25Lrha4AmwaQOvM7ySHAXylbVyEXn1NhVHRSBUITeMSDLXGDxZbZeCOF7PYVeR4NDlXTt9L3/vu97CnPASQrBL53OmC3US2dYsBhhkw30eclMfgoEUGSJDb3zG2gppN0/IQtEzeEjcaZgnLqz6NcBEy8LGi/qXc0KWpxDz7B9sW3LR1UR79jWQvNXNTZKAn9Akdskac3OlCyfQIPlbsmp2mCY2GMYuZBdYV8iZq/PY6ZR7V12t55nUqxel5eucbwdY0e1+dwKdywLFoG9j3pfde3Ppk9YWrGjNQaYccNmy9BuqnObfBjnbJtOjaAUKdPBBJCDjpS8dswRwPpw/D/IW69edmF+v4vOSWYkgYojmwnKPamJvkEN6RgRpJWSfdwbxkOJEqqoO5S5x3HzfVLO9tZrONpetqTtwMnJ9p7S5ZbjFT9ahs8YK954QaFve+e/ac93V9d5ZgER5/NzC1KgIQ=

From: Yohei Kojima <yk@y-koj.net>

This patch improves the TCP Fast Open (TFO) test to report the timeout
events and client/server error events by introducing better process
management.

Previously, TFO test didn't provide any information about the test
client/server processes' exit status, and just reported "ok". This
behavior is sometimes misleading in case TFO is unsupported by the
kernel, or there was a bug in the backing network devices (netdevsim).

Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
 tools/testing/selftests/net/tfo_passive.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
index a4550511830a..1e89f1006c42 100755
--- a/tools/testing/selftests/net/tfo_passive.sh
+++ b/tools/testing/selftests/net/tfo_passive.sh
@@ -76,7 +76,7 @@ echo "$NSIM_SV_FD:$NSIM_SV_IFIDX $NSIM_CL_FD:$NSIM_CL_IFIDX" > \
 if [ $? -ne 0 ]; then
 	echo "linking netdevsim1 with netdevsim2 should succeed"
 	cleanup_ns
-	exit 1
+	exit "$ksft_fail"
 fi
 
 out_file=$(mktemp)
@@ -85,12 +85,15 @@ timeout -k 1s 30s ip netns exec nssv ./tfo        \
 				-s                \
 				-p ${SERVER_PORT} \
 				-o ${out_file}&
+server_pid="$!"
 
 wait_local_port_listen nssv ${SERVER_PORT} tcp
 
 ip netns exec nscl ./tfo -c -h ${SERVER_IP} -p ${SERVER_PORT}
+client_exit_status="$?"
 
-wait
+wait "$server_pid"
+server_exit_status="$?"
 
 res=$(cat $out_file)
 rm $out_file
@@ -101,6 +104,14 @@ if [ "$res" = "0" ]; then
 	exit 1
 fi
 
+if [ "$client_exit_status" -ne 0 ] || [ "$server_exit_status" -ne 0 ]; then
+	# Note: timeout(1) exits with 124 if it timed out
+	echo "client exited with ${client_exit_status}"
+	echo "server exited with ${server_exit_status}"
+	cleanup_ns
+	exit "$ksft_skip"
+fi
+
 echo "$NSIM_SV_FD:$NSIM_SV_IFIDX" > $NSIM_DEV_SYS_UNLINK
 
 echo $NSIM_CL_ID > $NSIM_DEV_SYS_DEL
-- 
2.51.2


