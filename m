Return-Path: <linux-kselftest+bounces-5745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD0586E6E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E7F2864A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E2522C;
	Fri,  1 Mar 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhV9oKat"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF8C2C7;
	Fri,  1 Mar 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313102; cv=none; b=FNGAgqgC3nKRnam8WAIpZ3p6YBAa/XA0cdflrJyv41zfwrywBX0SjoJQOXiZQPcKUnN7f7yNO1/pez3QI4LaP26b9jeG1p9Nc6jae7/EBG/sFH5NIv0Ml7mAZDciznLRzkR1oe96MKBPgQjrP0i5e80GqG73aoxEfwIf2ivT7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313102; c=relaxed/simple;
	bh=gGZFgk/rb3EH2O4u8lfqG1pgZeJCOjyIG6p682FNkGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/eMuy3qfkWMTRaBOTyRwrwGL4qmF+IGB5LExNfvesmYWSNW+KLvLFPXuhHAfEbiH4tnUirG2+WUkd/u8meS2nrNsc9RoJ5v4/TCSI+xuGDl44DenJ7UvDEWxV1Yd8tgFmHrkorTNPKwYT75xGuC7bfbpvcM49a1nIDVm4QdaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhV9oKat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732DDC43330;
	Fri,  1 Mar 2024 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709313102;
	bh=gGZFgk/rb3EH2O4u8lfqG1pgZeJCOjyIG6p682FNkGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UhV9oKatb+x3ccw5zp4vQEMKMnNfXTZfuOVZXXqzp2743MSoXYr3HFHsLY3bJ6ugk
	 9iz/DtsYjb66Uwm4KjCQntLHblyil3dqlvKrfwb1tlp75IlcqYtG7TrNA4sdOILfzy
	 yjjiBCiutKhhmN5HqllAUOb0Nlh77Ff4BhzBnlCr99xoxCCz74FtZbYRyNmG1/gIjt
	 //H+ormzVfM41Z72dwUlHyBphFkukQiFAW/srYqGVt1oJvGatgzcIKCdIECTlSYWai
	 xFCbIlvqkCIs16brx6+mBUZKAF4qXAvSK+W2CdijMEOByOY3rK/NDrIYHJZ2FeeKGY
	 TnIfwqnjcJFCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 18:11:22 +0100
Subject: [PATCH net 1/2] selftests: mptcp: diag: return KSFT_FAIL not
 test_cnt
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-1-07cb2fa15c06@kernel.org>
References: <20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-0-07cb2fa15c06@kernel.org>
In-Reply-To: <20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-0-07cb2fa15c06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WbTTSM8dAo+T+IZMAz1wLRiGpMeBimBuli1/EMr2Roo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4gxHM1HZCWFibarJ6yqVSuE472timi0TYr5Kn
 QXCZzjsvCOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIMRwAKCRD2t4JPQmmg
 c3YsEADUXwVLCERIRWmy1crU3vJJugecncwe029ZZr7ZB3dp2JJ24A6V+Exf//JY1Xijke7S8ev
 SxewLG9ASycDeNoCV7WWPSzFuXefgZm/fgjRBHFuA7dV4HBblCw3dR1/2DY2A3ajlUrJIVhLlNq
 W6NjRnIjA4zAIngH3vkDMKzJM03i979orRwh+MBRAxz8KttK6LX/437wlU4vdpnn8DVA/axk9F0
 +PKAYpBlsV04mzJXvbsbHgKfAl61SWJq1FfaNJJJ02GNdLjSQr4KOgPsQa+7HFAJMMTQy3sNFXZ
 XSBM9OlRAwuHQyVjNgGnIZEb1mgAPdZUZuIZb4BaW/Qalza334agQ/JHk8QAJ3ytZc3eNkDT86K
 KvTSL5VoDyUM2MWomRMVVKXSIRZ6gmIinO4Has6+9RzOo9UQPjkiMKQGgwrLDSEFqRCMIh2F9pK
 iSBm7ZKLt1StWfsYbQqJQrDeuds4WHOacgOUch7AHrxe1Mwx9IVeAOcnx0wCEVYoTXfr78HPXw9
 GFkKK41Ib2Mr4CdPboFYOsBSiXtgWI/PMRwBwNTw0kLzBkwGnwPnmTclhRetySyb1hJ8UBgZdWO
 N/Sl5xVx1ATzkNqaNwQUzHYgryuSin/pgj2U2KcCfMayl7B+WpU54JF/eTefy9jC1ilye9StCMo
 6jK5ySXMlu/gWnQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The test counter 'test_cnt' should not be returned in diag.sh, e.g. what
if only the 4th test fail? Will do 'exit 4' which is 'exit ${KSFT_SKIP}',
the whole test will be marked as skipped instead of 'failed'!

So we should do ret=${KSFT_FAIL} instead.

Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Fixes: 42fb6cddec3b ("selftests: mptcp: more stable diag tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index f300f4e1eb59..18d37d4695c1 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -69,7 +69,7 @@ __chk_nr()
 		else
 			echo "[ fail ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
-			ret=$test_cnt
+			ret=${KSFT_FAIL}
 		fi
 	else
 		echo "[  ok  ]"
@@ -124,11 +124,11 @@ wait_msk_nr()
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	else
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"

-- 
2.43.0


