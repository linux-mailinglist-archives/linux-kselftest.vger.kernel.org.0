Return-Path: <linux-kselftest+bounces-47996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C315DCE7D0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 19:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104443011745
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CBB32B9B8;
	Mon, 29 Dec 2025 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="fuJsmsxA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster5-host9-snip4-10.eps.apple.com [57.103.79.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB6272E7C
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Dec 2025 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033226; cv=none; b=Wh4X4jGyhJgzVavMc2bSlyfKul3DYnuVCoULrztuParONMYnvAdUictmTxVOxrdvix7ivhKi//xEW5KbQcRB6yNb3XeYFCU9csOUgabPnjBl8yuFlh95vcYeetQnAnwQqZX/pGoy1zjjm55gzj0jnD6w7fdCqE8gfQoLALvhYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033226; c=relaxed/simple;
	bh=WIJZFHxopcZP3hq9cJLwq5KZ8bfy6f+I6dRSNFZL4Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bu+j3Xot3ykOdysTzFsDRo0ClWQxhGcpxG4XwQaqjIwFCUUHE51sCdPn9JVQJBnVTslONI97cUnJQBs+dYtdthGNOI9Vepzglioqao8yP42jy/PWjel46Yj5Zoo3D4b4XzlvdlKafK64WGdsKMwHI/rg6M55EJMu0Lz61fnIChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=fuJsmsxA reason="key not found in DNS"; arc=none smtp.client-ip=57.103.79.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPS id 5C8B518002AC;
	Mon, 29 Dec 2025 18:33:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=ITzwEJsX00BYHWgmEn1JR4A/qizeksR08w/s7ajzdkI=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=fuJsmsxARu1zebx5G+m8XOjBINKKPFI96mwYiEWIsErB50CUc3a8Mz9SxBjNprJPKk0/dsralzOKj9vlDKc1m7kRZKeAJ1ycfFXn0J65lzrsinuTwBgkJiqxQ0NEax0yGSqYzjL8omQeoPzqW3SMXf8x6SCnQ0ueENDc7IECP1rOccjwRLdkTZi8Hlw0yVF49xtiQKMXGYhW8v0PZlRfRRQw2QFRKLrxM4Tnb3IQUmK63/uO5YUqgD40HEK26Yj2IsTk3r7EqnKOjmP6P8O4vdGaBg1G/3kGgIJD51QooAG4NVrhK+OTK9PZC5eZQlsRfMJHkd0t+1nH7SEd9YjhcA==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPSA id DA82918005C5;
	Mon, 29 Dec 2025 18:33:39 +0000 (UTC)
From: yk@y-koj.net
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/5] selftests: netdevsim: test that linking already-connected devices fails
Date: Tue, 30 Dec 2025 03:32:35 +0900
Message-ID: <1ae982f132f78d7c56533e0761844445ad914d5f.1767032397.git.yk@y-koj.net>
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
X-Proofpoint-GUID: WNXcMd3n1UUiY-QCY9IpddD-er7lXVwI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MCBTYWx0ZWRfXyjoSntZy5fW+
 gqA2O57V9LCgVJuSufeYTCSF9x0ik8O88MlFFkRIsFOmQ1udD3UPuRdeUisnI4OLm06jjPlCNmN
 GdhS3p0e/647//DYeyoyytg1LpKsCFNCavs5Om1gaBioB0Vwf0cFsSipZRFZ8d3Wn/ACjeF7ZNa
 lPAf9soMz9ew/lhEMnv37DBYEJ6uRXPJX9Xw1ULSg5FNJF5KM+oARZkAkhKcjuQDhJcXyqkHF3j
 g9J/2gGd8RiB2yrL1Y3X6sygfdJ8CNxbg2W2dH8qdEADnz5p8VB1es67WGauUwva60cAW2C0JgE
 m0g1lHU6WQMaODjgOMI
X-Proofpoint-ORIG-GUID: WNXcMd3n1UUiY-QCY9IpddD-er7lXVwI
X-Authority-Info: v=2.4 cv=drDWylg4 c=1 sm=1 tr=0 ts=6952c987 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8
 a=ifwVX88EVhsuK1YnTlsA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1030 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512290170
X-JNJ: AAAAAAABFXnnCsjl6jwj1pjAUe7pQ+9OUKxTqRiZSUE1nqYXI6Db2p39VgVdJqlg7EtCdxgHgaNG47ve+5Esc+MYRo6jOfXzTBE9liY7QiZYJQJc6Q7s1hADVxLT9Up3HjdK93gFa8jk5NcZ3dGkoqco938FIcVfxspt9v2J3sJyRLJ5zuRLl1+Tyj9k1Fgdaq6SVw8ph23tfD+bggZe1uhFJAYIxk61/szNNpW08YRiK2uucz9uUbNKXy9NJxZeG8kx32jhxPkKt/z2KHMk7EbKXFHRwPY19BuC+FROjduW8qIvr07k0AXx7ohwTcaOFRRtIMFxjyWpifSMs9TlNe6NjV5hXaAymFNosVulPUHDJRxX/lN7aKbfz2xSll+E0xJhzb2GsF3gWCNda1XGbqiKmpXVVmUNfYYxL0/PcYAFKBOOpkPyLyH9h1bPpAXlqqFTHbv377YnWKYVmZ0CEx21mxaEnaStfgHylosU71l+zpu4RfqdvuwOD39B9AmA+oYDNLRjgZZfQxvx+S/614IYmnPpZNzj4dmvwIUjaP7KxhViJEj28gQ5XCmPfsTFRmrZsAnikzyxzcB3F/DBzI9p35JG1RuLGy5qOw8bJWws/WfaWL/shOA9OOKUbW40+UV1c20OGjh6tgTYGN+OOI/wfEys0f6Xb4v+V8h2JhP4fL8TXMizNokFrpwcKgzO3uXTy89WIvgm14OPQRJbqb8FWUzZCQFDTP4ya9BbLYGZzSHF28rnZAgIdxo=

From: Yohei Kojima <yk@y-koj.net>

This patch adds a testcase to check if linking already-connected
netdevsim interfaces fails.

This patch also moves the testcase on invalid ifidx before linking
two netdevsims so that the test would fail if argument validation code
got broken: after linking two netdevsims, the test might not fail
because it attempts to link an already-connected netdevsim with
non-existing netdevsim.

Additionally, this patch adds comments for readability and details the
error message.

Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
 .../selftests/drivers/net/netdevsim/peer.sh      | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
index 7f32b5600925..338c844fe632 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/peer.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -76,6 +76,7 @@ NSIM_DEV_2_FD=$((256 + RANDOM % 256))
 exec {NSIM_DEV_2_FD}</var/run/netns/nscl
 NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
 
+# argument error checking
 echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:2000" > $NSIM_DEV_SYS_LINK 2>/dev/null
 if [ $? -eq 0 ]; then
 	echo "linking with non-existent netdevsim should fail"
@@ -97,6 +98,14 @@ if [ $? -eq 0 ]; then
 	exit 1
 fi
 
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with invalid ifidx should fail"
+	cleanup_ns
+	exit 1
+fi
+
+# link two netdevsim interfaces
 echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
 if [ $? -ne 0 ]; then
 	echo "linking netdevsim1 with netdevsim2 should succeed"
@@ -104,11 +113,10 @@ if [ $? -ne 0 ]; then
 	exit 1
 fi
 
-# argument error checking
-
-echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
+# semantic error checking
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
 if [ $? -eq 0 ]; then
-	echo "invalid arg should fail"
+	echo "linking already-connected netdevsim should fail"
 	cleanup_ns
 	exit 1
 fi
-- 
2.51.2


