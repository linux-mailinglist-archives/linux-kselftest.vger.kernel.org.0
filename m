Return-Path: <linux-kselftest+bounces-5981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A077B8732D7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEDD1F243A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B635F879;
	Wed,  6 Mar 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D40qEK3X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8D5F875;
	Wed,  6 Mar 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718195; cv=none; b=gBGTEZ5VXnpQAXtlpnBhCA6W9TGjls0ogJq9ibf5gbbQ6IzKd5ljcmmJEkRMqWJzoU+UHYtavMtJB2jS8GEaXS2IHsxdVVDm0QrhV1G3SSy2c6X4BQg8o0uCwaKyJV70kDzSJf/0VIxYD1cY+84hOSIf0BDp2oGiAbhj/MsMwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718195; c=relaxed/simple;
	bh=NwaGraVY2orMRXPc4dj4/mlBtx6flfWWyqqm+KZIYZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTFN89SxYkDT2gwZpuupsGWFs/BrR4eH7Cl0vcRJQAl1syQ/Z7o7Fz1OlqhxZayuog7DtJSYSKHL1+oe/IKstMytq6AVXE2csBOzgvxO6mOQeeODmKWgogme5COvNXRaul7MC71qrj9jBH1LHmP5Om2M4HIpcaYGJnYwSKSYx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D40qEK3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2941C433A6;
	Wed,  6 Mar 2024 09:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718195;
	bh=NwaGraVY2orMRXPc4dj4/mlBtx6flfWWyqqm+KZIYZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D40qEK3XHobEf8VMQlXkDCSzbPfP2fUkEi6MskUu10kQWIW7iYYpJkRLJqTQhkdY1
	 Fcik+sVsZinFh0iQxO0d9rLotOPLdMpNF6s30Bj3/AqZ6OKRFQmvkoo2AkHsjKQuHk
	 92s69EJ3Kc2azaRO/J34b365ZpSfA4Py0jHlnoYBDgo4X4/gWuhDKGjwmLwKMXI34+
	 Yy2znTSbjOnpAqeX7ObhfCgepF6rcqJioCG1hBcjUpkCC/0dfAYkMWAdib+uRvcWkY
	 LHqbkcTn6CPpDPKsqGDvoPFe7iC5kWE2oqN2kasapbX84tcSn32KgdZFlNZbYr0jkJ
	 1+E3p4T7Ww/0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:42:52 +0100
Subject: [PATCH net-next v2 03/12] selftests: mptcp: add local variables
 rndh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-3-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rR83I8+9RuJUsNHRpTCHk6/7gRGCW52wxZZeqhezDd0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6Dqmq+9sY1TiJQMuXen10BtKITuoVu2MJFA4S
 2M6agxstH+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pgAKCRD2t4JPQmmg
 c0iPD/4jN4B1QHxOW2VJfwF7JBSg+uB2jHZWgjPSO4GVonk0P7rOjMaqHOvuPo34Eb7pp9sBH00
 RbMxavHSkDQI7JshN+Nt7TcqwQvaSfuGE4LqnFeeWphczt+2H+thcsjjAyzBNsYHszcHdL4b5K/
 K1fELlwfzR6NqgJlfNmBiF1CbzdWPW7nIKQ8hD8GW/JH9SHf3re6lmVDEgWZHwOHU3GKI5Z85eU
 XFPuaj6q4Stn0g0M+Vxqj33iSwZuQIR7wx7ljfOL2dqj0hbNXX+a4raOcxx8iDexh8VPnd0f2wp
 WwjUW3+hBKF26GIYK0FryjGdgFvEfhvWDhwsdP0yxQWoSdjstkyiqnDq6VsVAskp72zIuEdIB3T
 YITU1Kp+CZZ450dSEb9AgVj1iTObHb0pyLQIckaD30MkO3A6Qc+ujEPWJ8thatDBdlB7dkycVli
 untK2VW731Is4XgI7Pochd+7CNa3Qv8bC8evwnselQRd7lYITc1GTSp03ujzLUELQFrs9S4FDUI
 M16Q+nSthbOWjhR0cFGruOAU46xxwh5atkZ7QgCUI7I8UMePkd1ErfRy0SGuub835YQJUT571rg
 Gv+Z+hR3M+H3AAD7zNwqtuJ3cahgKS659RkCz6VwMQEkdywAq3az3s34MuhISxDVQQWb2tptFS2
 /+PrF6WYerjJLQw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds local variables rndh in do_transfer() functions both in
mptcp_connect.sh and simult_flows.sh, setting it with ${ns1:4}, not the
global variable rndh. The global one is hidden in the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ea52110c3fbc..b609649311f6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -348,6 +348,7 @@ do_transfer()
 
 	if $capture; then
 		local capuser
+		local rndh="${connector_ns:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index dbbb13d1d74e..3d08116500a4 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -139,6 +139,7 @@ do_transfer()
 
 	if $capture; then
 		local capuser
+		local rndh="${ns1:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else

-- 
2.43.0


