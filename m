Return-Path: <linux-kselftest+bounces-5906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC55871C0F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CFC1F24F9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239305C8E0;
	Tue,  5 Mar 2024 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLGQ8hdk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F015C61A;
	Tue,  5 Mar 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635366; cv=none; b=k/tu9wsReaXT9EWCxGNBU54MqqdynD/N5vhhzchyVVacD8GFRjsGutGt5GzSCbBe1CdlUDrKHScMY9O2HC9ABAHRlOFnDHj+Q0eViGgW2pawHHe+yAFQOlkSVHLm5paZfAKUN95bx3gwAnjoAR8HxW736xtUsLbH3u1ljrsZlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635366; c=relaxed/simple;
	bh=+5YCsCdGmLcwpGBEkiByA48Y8GO6L2mQsOcRmzA3CTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqekNcRYQyr/xs6LnV1U5PDna4+BF2x/P7WZI4mKCl17PEJgAkMsxnxvG2FNM0pdFsSWl1xsOSG08+GQPp+eltFvGxOB6/ulKwbMq+Nwy49GJon1n6DNpQVcWHx4ARuYkddJjRb2AKlNN0yDDywXz43gHKVDNdg0tcO+nu/gPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLGQ8hdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E52C43390;
	Tue,  5 Mar 2024 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635365;
	bh=+5YCsCdGmLcwpGBEkiByA48Y8GO6L2mQsOcRmzA3CTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uLGQ8hdkVHSRAmw5/bg+B/xrG+FvkKHy2FO5hcJXw54GBTWJ6ODnV8qp8hqoZX7lj
	 FQc7mcgNJTGs01PYD8XUet5shrU5aYr9RG398QKu/zmjldv7clchF/dhwWr4HDDfBr
	 mPpC0mzww9CVV3KoVyE86azbt2HQbzC0wPX6I2dsH829LCac4wzyzO70HM7sBwmps8
	 KUCt5wGiO6+OI1QRJ+7bqdjf+eyJ8IY4+PH7Iqq3H963pluptUMz3nxHnfLcadZMfP
	 0e6pDD3ngKzyU6cVUvY/n8elG3rkzD8TL5drjAK+k2Lp3Qhrm0MLmBSwNcAcQjesZ2
	 L6Pi9J/gPCR3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:31 +0100
Subject: [PATCH net-next 01/13] selftests: mptcp: stop forcing
 iptables-legacy
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-1-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3156; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+5YCsCdGmLcwpGBEkiByA48Y8GO6L2mQsOcRmzA3CTA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vccSvSrU+ujR23th9KSJFboEjj7Le0vuAycJ
 Q5+SLY1sgCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HAAKCRD2t4JPQmmg
 c+fzD/9Zmfz2HPVhcCwZlSZxioFRKS0QIJ7wX4386X5KLvE5ucYmkkNvKZK+hq6A69ZVTID4nkb
 qIgErlxlqd6Pc0bMGJ70UbThL7ogsSTSO43dMtUSDEWtjzm2EAg2c0L4a08CllUjwgDZZsudpXp
 xK/83j9sfSzgBGDaKBTIOVuQik7K25cBog39omgry7oUvuLln5/VTycEAmKhOUcXLfaUCbxDROO
 RnlsyZHH34ZSSfEHCD1ExAl2RFMw2bpTuTV70IVlgb8faCjYhWwS1pNl+N3O3lH1E0FGeOPTwF4
 HX8O8V4w/Xgq0F7qZlML52v3e4YZHDWZxNX83ZHNzsNYh1gNfEBJ7TegBV0f0avk1dDOlY4VrCu
 dYMQkNbmzv9Og3EWXDd7YxzdKawMBvmtO7ziHdr/SWfjLaFWGBxKJDYjzxHdDtA18+ddS0FVuh2
 w+8upiPn2wdmjJiNImazX7nmRruU4H3ek7WVnV+N+nzsraz4e5nLtmvX8vieBSlCSDkEKWVpUi5
 IwNo4B/AEBKaZezOrhNFNTHJrBn6V/RAGX2gizoroYd9PmM1KWRBlC26Fv6cYUVypqJoXJXKjZM
 HS3/p6IIItbzBAUDUrbbAGQwYF1Xc6GtC1F1MHhJ7hs6BlokKdPWFrEjBv7fjlocIw6RgglzFiY
 zLW8cusHxXASk1g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Commit 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if
available") and commit a5a5990c099d ("selftests: mptcp: sockopt: use
'iptables-legacy' if available") forced using iptables-legacy if
available.

This was needed because of some issues that were visible when testing
the kselftests on a v5.15.x with iptables-nft as default backend. It
looks like these errors are no longer present. As mentioned by Pablo [1],
the errors were maybe due to missing kernel config. We can then use
iptables-nft if it is the default one, instead of using a legacy tool.

We can then check the variables iptables and ip6tables are valid. We can
keep the variables to easily change it later or add options.

Link: https://lore.kernel.org/netdev/ZbFiixyMFpQnxzCH@calendula/ [1]
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 12 ++++--------
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 955ee651dcd5..6a4af95cd4c3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -167,15 +167,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
-	# Use the legacy version if available to support old kernel versions
-	if iptables-legacy -V &> /dev/null; then
-		iptables="iptables-legacy"
-		ip6tables="ip6tables-legacy"
-	elif ! iptables -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without iptables tool"
+	if ! "${iptables}" -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without ${iptables} tool"
 		exit $ksft_skip
-	elif ! ip6tables -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without ip6tables tool"
+	elif ! "${ip6tables}" -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without ${ip6tables} tool"
 		exit $ksft_skip
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c643872ddf47..dac8e1fc7143 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -96,15 +96,11 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-# Use the legacy version if available to support old kernel versions
-if iptables-legacy -V &> /dev/null; then
-	iptables="iptables-legacy"
-	ip6tables="ip6tables-legacy"
-elif ! iptables -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without iptables tool"
+if ! "${iptables}" -V &> /dev/null; then
+	echo "SKIP: Could not run all tests without ${iptables} tool"
 	exit $ksft_skip
-elif ! ip6tables -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without ip6tables tool"
+elif ! "${ip6tables}" -V &> /dev/null; then
+	echo "SKIP: Could not run all tests without ${ip6tables} tool"
 	exit $ksft_skip
 fi
 

-- 
2.43.0


