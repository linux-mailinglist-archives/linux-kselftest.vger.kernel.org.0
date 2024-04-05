Return-Path: <linux-kselftest+bounces-7269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16997899B59
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB53AB225EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125A16D9AB;
	Fri,  5 Apr 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X447XcDs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9516D9A6;
	Fri,  5 Apr 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314376; cv=none; b=konKgbxQPlvsRmf78dkQ6H7K/u8g7GJFKlpQQ1HfFHRtm0vlbm5bGqZox/RKmkd47hVfMs9s7N9xI7qKzhXOM8tECdW+obSo54ByiK3LM+OT+Ws/U0UnZxUcUEo5YA6JBdPVWEcYfQn5hT4eTqmwTPyNg0eRZA9fvj0DLL+aZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314376; c=relaxed/simple;
	bh=/rTr+QTnJy+nrMoQt/f15OXgmpM5Wqn4Gt7TYRBqYSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rm4CmYIq45W5hGtuWfJvV2eU1M+aMzWDq4PKVHyGKbILR9QmAmw7La6xwxdEf/0Sr4O3B+HPaVINY6Ts6vXcv8r69hgqcGYlvqBT11ze1gsGpWNdnXQVY1ln313s1Cld2DDHRaFaz4XhGZ2Qt0ZUUZQghUob3ARsuQn/SlpYGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X447XcDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384B6C4166B;
	Fri,  5 Apr 2024 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314375;
	bh=/rTr+QTnJy+nrMoQt/f15OXgmpM5Wqn4Gt7TYRBqYSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X447XcDsfh+2FJuGE/f5mcksm9/PT2mN/iUve9nxRiednc3gZ8velid3+k9etmMQ1
	 Nkxa2D8/64fk1HM6Q1L+WoBsn5KojKozePGcQ0S3O271wKVsxo4X9XHSfZfmuPBX2s
	 Zm/e5osyyelqh8cUL68cQbO6RUBwDqlyBzktjqOz/n6tFNwCyqZkyye1QksjHlaptO
	 hC1qtS8yTr2/8r1r3D2IPkGfutcfdNRq5utfoHZvGtBLUc4xKxDW07VT8db4ZY9u7P
	 pcdZZjWCUcRLjlUTgLNYDEZCL6ujFGCYxoPBZlWsXGpC8DkloVwWVLuolQtpOZ9spX
	 TAMBBHsduVD1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:14 +0200
Subject: [PATCH net-next 10/11] selftests: mptcp: ip_mptcp option for more
 scripts
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-10-eabc9b960966@kernel.org>
References: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3081; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7dJfIPeeIjj3sU94QMXAlNLo3Zxg9tDsg6aNaMsGiDQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9fm3g0BXpZOC8lszEBHEYiMIRodGVCNXT5bX
 XMwMC9ldBuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5gAKCRD2t4JPQmmg
 c0aDD/9pQhVSDzcgjjhmdAlvu/f+f41QMN7l3SwTdaD5tyAXovaZRIpy1giASUHh95SUYjob05z
 FTrDUOAL78/MOjtPJSMA9rcg3LjS501a0Fy4Eo8Zo3HmmsVnSda6tQik0Ciq9t+LL1p4GuUDv0P
 LgOUuTlmoqnIhWMlae0mrlIkmNp18cAbcWe9N1KpwVrpiveqQOOV8MgKirxSimxIREjuLRTGc8I
 63aFKhdjI5IcSciAI8VylTCw1gN/3yvy2lv2Qhn9RtDTWXzUNm6g33qbzAel4WusS28uGVUeJRk
 UPS5p0ZMAKe/vKVz2G2skWXQpNruAzIbgoB7AofPopaDLoExAb3DEOMz5voGZ7+T16Z/UAvuXcg
 OLysMbb8k6hToRN+8kf3OYxC7iVApRAzlLd2M+PAh2eF6pGGJ7mFjA+sKZJMbJu/XMkYTsT+xsB
 PMaFWbBNg9aJiY5Noawf4fc/wtxifZhp/GwsylTcFwteP2hjCtUkad3PHro50c79hpR35+1MKz6
 Y/HF5qU0HRVPkoYrmtAWvW+vPrDD0QPQG4PXRfCvrgbrswdGggTm4l/ktGyMm6RG4aScL5KPC9y
 vte/BRfEmf3lQ6hx7HgyxTRP70Ux5MAY5gzOCZ+PD3Mx7G7sKfUwyHI2rMQ+kmKBCfGBlDXZkE2
 zMvMU7PnvKZL84w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds '-i' option for mptcp_sockopt.sh, pm_netlink.sh, and
simult_flows.sh, to use 'ip mptcp' command in the tests instead of
'pm_nl_ctl'. Update usage() correspondingly.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 22 ++++++++++++++++++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  9 +++++++--
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  8 ++++++--
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 36e81383f0e2..68899a303a1a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -22,6 +22,28 @@ ns1=""
 ns2=""
 ns_sbox=""
 
+usage() {
+	echo "Usage: $0 [ -i ] [ -h ]"
+	echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
+	echo -e "\t-h: help"
+}
+
+while getopts "hi" option;do
+	case "$option" in
+	"h")
+		usage "$0"
+		exit ${KSFT_PASS}
+		;;
+	"i")
+		mptcp_lib_set_ip_mptcp
+		;;
+	"?")
+		usage "$0"
+		exit ${KSFT_FAIL}
+		;;
+	esac
+done
+
 add_mark_rules()
 {
 	local ns=$1
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index b3adb39a7d3d..4859fa85d9a0 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -11,16 +11,21 @@
 ret=0
 
 usage() {
-	echo "Usage: $0 [ -h ]"
+	echo "Usage: $0 [ -i ] [ -h ]"
+	echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
+	echo -e "\t-h: help"
 }
 
-optstring=h
+optstring=hi
 while getopts "$optstring" option;do
 	case "$option" in
 	"h")
 		usage $0
 		exit ${KSFT_PASS}
 		;;
+	"i")
+		mptcp_lib_set_ip_mptcp
+		;;
 	"?")
 		usage $0
 		exit ${KSFT_FAIL}
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 3ebb2fb12c8a..4b14b4412166 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -27,10 +27,11 @@ capout=""
 size=0
 
 usage() {
-	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
+	echo "Usage: $0 [ -b ] [ -c ] [ -d ] [ -i]"
 	echo -e "\t-b: bail out after first error, otherwise runs al testcases"
 	echo -e "\t-c: capture packets for each test using tcpdump (default: no capture)"
 	echo -e "\t-d: debug this script"
+	echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
 }
 
 # This function is used in the cleanup trap
@@ -259,7 +260,7 @@ run_test()
 	fi
 }
 
-while getopts "bcdh" option;do
+while getopts "bcdhi" option;do
 	case "$option" in
 	"h")
 		usage $0
@@ -274,6 +275,9 @@ while getopts "bcdh" option;do
 	"d")
 		set -x
 		;;
+	"i")
+		mptcp_lib_set_ip_mptcp
+		;;
 	"?")
 		usage $0
 		exit ${KSFT_FAIL}

-- 
2.43.0


