Return-Path: <linux-kselftest+bounces-16509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D3961F68
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD61C1F2572E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE415D5CF;
	Wed, 28 Aug 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An6nV8IF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1415D5BB;
	Wed, 28 Aug 2024 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825703; cv=none; b=DPlwIr9kkXOuiFAr9yN3mrQs67XdXZGPhMaCIXa8OQemX3KIyYktkYLoeRgzcm0hPfr9gl56o/bMFuUxXqIXxxOaSoijmAaoyTjfd1pmbzXpcQQFY0PKgN+zMlAueRDOLzRM/XVLqtHB2eXjvASXObNhsFKGl64rv5sZuE7TcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825703; c=relaxed/simple;
	bh=zD14IgkrP7F9qwGDtpw5DaWjyzIIBMIxJcVVx+IfUhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lNHFXerFQX+FjwCNQn0vL64BOkYzEvFXT3j+Ar4V+QjAX96s/H6AAmVu/iukSFLA0ZgKFdhdFnHXVwjBjxSwYhMaD8rxGRegkgfVAu8uXQkLj6jCQVgkkYKgg1lIkN+LMkMkA3mptJ2xFtutxcqiecKUgajowRU1hEK1OhGqTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An6nV8IF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D92C4AF65;
	Wed, 28 Aug 2024 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825702;
	bh=zD14IgkrP7F9qwGDtpw5DaWjyzIIBMIxJcVVx+IfUhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=An6nV8IFGFLbtVS9sYfmFzSEKimxlgdF7zS2RZZXzB89sX5Uu6gTT4Nc4VJyLbn3n
	 Ugus9oOc7P9rE45eAcqsQ+qVGfUYi2H/f3mKieeTdSngMVbMAV9wXnY9kjfO737mtt
	 0vtapQEe/KZMkGHWw8Nxchx6Fyo0TV+wpElxdltfGFLJ+KebpjPZRCXvActl75tF1W
	 yfq2A2T1YoTiyq9dWPttKIOMYNrvUIvGcX+3UrswzmW6v+VIyGSKwgItj3g8f0rU4t
	 24q9TVq1J8AUgbCsVlWWtRDwtQumBMcM93FAwhHSZuG5/9UihDkFb4MawqcVwd1znP
	 4EYiTftt1GujQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:31 +0200
Subject: [PATCH net v2 08/15] selftests: mptcp: join: no extra msg if no
 counter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-8-7f11b283fff7@kernel.org>
References: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
In-Reply-To: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3270; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zD14IgkrP7F9qwGDtpw5DaWjyzIIBMIxJcVVx+IfUhg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHURmRg1OCRlCYFNTVLv52hb4Ntq3OT42Wv
 gVeb4/ZHfSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 c+06EACsiAC+u38CZcjgyOs5BHlbt8mPS5txOHGL7f8xp6uL9RfUI99xoAsV/osmVBn9qQESOX2
 M7JfyHF2qaK+OaJBM/CUN+EicrPdt+bLX5qK198yAdYk7irYoVVTJ7Y/Nm/LeENW7Io1WNwGrKK
 xuaaaJ5Jxib/JaEMqJ+F3gnsLlDOA86vCsdSqo3n5MZXWD7OkE0h9OrbzO9OyzhYkcEewguetiv
 R3hsH9O7i4bWSPqTQdlI/Q9ErLzS/8EYjVonqypxmQIv6I/sb/BZu/HbpFVYOaZBEA/GcrQ8OjG
 0983QGJvYC1E1fVOEddnrXq7cjfUUZ63NMVCFutBtAQSjDLgahhymvovI0VjGzu68OiobsDvtup
 7h2FBRX2zufZT6MaTTLRhNPPfsrDJPOxbFZIB5iIyTSt8ZVA4VN6esrG9oAPzlWSgQEuP9Beylg
 f3KtDmUvso7yNwtsxUSf2L61yedkMsyNIUp1Yun/sIQNxPJtzW6X4rsuIkTbcupCthjWEU+bNY5
 Rlvc1gpSrveo5Hzo+7vzcMIL7oC28cyb6oF6QuUUkcuCEtSVe1FGcaQuBgkmzFf3+icMDf2ToVZ
 xTk1lP3stBtO8rqj0XrwgHntibYUB8LXZkI+Emn2xL6DJma1U1w/9aGycRStTDrqY0jlccJoq3M
 TvyA+NtsHiWmLSw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The checksum and fail counters might not be available. Then no need to
display an extra message with missing info.

While at it, fix the indentation around, which is wrong since the same
commit.

Fixes: 47867f0a7e83 ("selftests: mptcp: join: skip check if MIB counter not supported")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 75458ade32c7..a10714b6952f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1112,26 +1112,26 @@ chk_csum_nr()
 
 	print_check "sum"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns1" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg+=" ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		fail_test "got $count data checksum error[s] expected $csum_ns1"
 	else
 		print_ok
 	fi
 	print_check "csum"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns2" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg+=" ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		fail_test "got $count data checksum error[s] expected $csum_ns2"
 	else
 		print_ok
@@ -1169,13 +1169,13 @@ chk_fail_nr()
 
 	print_check "ftx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
-	if [ "$count" != "$fail_tx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg+=",tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		fail_test "got $count MP_FAIL[s] TX expected $fail_tx"
 	else
 		print_ok
@@ -1183,13 +1183,13 @@ chk_fail_nr()
 
 	print_check "failrx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
-	if [ "$count" != "$fail_rx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg+=",rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		fail_test "got $count MP_FAIL[s] RX expected $fail_rx"
 	else
 		print_ok

-- 
2.45.2


