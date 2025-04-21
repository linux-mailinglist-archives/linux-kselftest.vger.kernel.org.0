Return-Path: <linux-kselftest+bounces-31259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66215A9550E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB0A18954FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD31E5B82;
	Mon, 21 Apr 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw+kYY86"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F42F1E8358;
	Mon, 21 Apr 2025 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255296; cv=none; b=g2jLDxNyaIHl7Vnn7kUAmkB1cBjsoj4K9kiXzCEzIUQrXeBlv1nfoJJGEQ/FCw3o/Bv1pwAee73Cia0OR0U7+7KzS9T7ZFbVrKFmZtQ1Y3sz60Jq1Sd2no/9DukbFi8uv7J2Y1EyxXUAbjFd6pUEKRMfuUYiXa0+KHEQKUnOfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255296; c=relaxed/simple;
	bh=7M9VEbNw/wxshPV8CHZ1wPPNOjwcbLcxoHMPDHW572c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKlLUBUtDxYEZRUafRzhBQRhdBQyfSnbNn1/4ItlUsPPyROQ7mOidBypU5scqJyMNnxUSo5zAlJyOxquakMx0VabbvMoGklui+b5LU87iH5oL+DJ08HGAxpMLO0IhANgj/o7qbmYpOKJJtF7y1M6DLZmkZn3w0jCKNXvb5G73GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw+kYY86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219F8C4CEEC;
	Mon, 21 Apr 2025 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745255295;
	bh=7M9VEbNw/wxshPV8CHZ1wPPNOjwcbLcxoHMPDHW572c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pw+kYY86U/fEJhD1CJycV+A1ZxHSyEYx2Z7m9Z+F2BO2KnJ65R+knO8VAk5df248g
	 V111OQbe0+bTwBxxsoEaSW1LUP7cLcn60TNzHgaNOL+oN1qpfdlWFVqYG/OO1v/9QH
	 z4JY2hvqfp2riUkpL7XbEaRAJir5LODbX2Mw5jnnkZeAyjTfJc6UszGVeMbtxe15+C
	 dvrvY1pL5Q6qcbi4Fsy0UC7CdeSNneR1cuurpqJzshcWwywmYBmDdG/N60zLjZZ6Wz
	 LpUXsEjCOXfv8UXkV6HEDeojsyACrWAEhEjHzVd70ElSxag5OrYq8Bz5df+hbxxIdN
	 3Eem0+G2GHWZQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 21 Apr 2025 19:07:14 +0200
Subject: [PATCH net 2/2] selftests: mptcp: diag: use
 mptcp_lib_get_info_value
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-net-mptcp-pm-defer-freeing-v1-2-e731dc6e86b9@kernel.org>
References: <20250421-net-mptcp-pm-defer-freeing-v1-0-e731dc6e86b9@kernel.org>
In-Reply-To: <20250421-net-mptcp-pm-defer-freeing-v1-0-e731dc6e86b9@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Gang Yan <yangang@kylinos.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5uqavJtPDjFSLzxOBtTDk/jrKu7HjOYDEmUMS8zpsNA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLYqsv+SbQJ5EoX8b19GpCwXKd91ZHuB7EHfs1WENfh2
 fpcoMW4o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKtRxkZ3ul3Tek8ah2/NDbI
 watk8Y7qGU/3Mz6xYjHdXTv3wvdDTgy/WS89eu/3+u5Ts8k2ZxTP1KzT2HU/znb/xAU+Z2uaovk
 4eQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

When running diag.sh in a loop, chk_dump_one will report the following
"grep: write error":

 13 ....chk 2 cestab                                  [ OK ]
 grep: write error
 14 ....chk dump_one                                  [ OK ]
 15 ....chk 2->0 msk in use after flush               [ OK ]
 16 ....chk 2->0 cestab after flush                   [ OK ]

This error is caused by a broken pipe. When the output of 'ss' is processed
by grep, 'head -n 1' will exit immediately after getting the first line,
causing the subsequent pipe to close. At this time, if 'grep' is still
trying to write data to the closed pipe, it will trigger a SIGPIPE signal,
causing a write error.

One solution is not to use this problematic "head -n 1" command, but to use
mptcp_lib_get_info_value() helper defined in mptcp_lib.sh to get the value
of 'token'.

Fixes: ba2400166570 ("selftests: mptcp: add a test for mptcp_diag_dump_one")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Tested-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4f55477ffe087721ad13774e82a5e2b1e6cec7c4..e7a75341f0f32304ff4e58c9b2500d405124dc74 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -206,9 +206,8 @@ chk_dump_one()
 	local token
 	local msg
 
-	ss_token="$(ss -inmHMN $ns | grep 'token:' |\
-		    head -n 1 |\
-		    sed 's/.*token:\([0-9a-f]*\).*/\1/')"
+	ss_token="$(ss -inmHMN $ns |
+		    mptcp_lib_get_info_value "token" "token")"
 
 	token="$(ip netns exec $ns ./mptcp_diag -t $ss_token |\
 		 awk -F':[ \t]+' '/^token/ {print $2}')"

-- 
2.48.1


