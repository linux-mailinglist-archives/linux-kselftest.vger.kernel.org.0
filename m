Return-Path: <linux-kselftest+bounces-5979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC38732D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFA5285118
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5695F49B;
	Wed,  6 Mar 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk4axBkM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0D5F47C;
	Wed,  6 Mar 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718189; cv=none; b=g+AqdZZwd/gx1jNTHOVMoyesE7jMAspx0jmcB9yJT+H7SLcitFSW+j7UnvtqHjV8eI+qG7ZX5NA9HP44/vAptZEByXDePDBv8XSzccoUfz7NZRMSRg++WEny70mztasCRsVyr2LfJHnjriEcIU3GFvpR/MRdoGgdwOVzeA2QLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718189; c=relaxed/simple;
	bh=+5YCsCdGmLcwpGBEkiByA48Y8GO6L2mQsOcRmzA3CTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bfmk2gTsqT/+A9dBGWubX0O2KTI/YWZjs7gVZt6Hy6AwOLdMlDCWiI/lp28+EyxMX0oLVMhjbHHBWkxafxOOVpZSNm2h4TBglIn7mvD6ABvXQeTHPxwEMxT+RPNynPo0MYsImlDd0iIoZNGbMbkzq4xzN7j3/gllYbIsYA8a7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk4axBkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15A1C433B1;
	Wed,  6 Mar 2024 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718189;
	bh=+5YCsCdGmLcwpGBEkiByA48Y8GO6L2mQsOcRmzA3CTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lk4axBkMbqhwNgOMPxTKvhxgEgYOkzlI5/CnP+lNMNfod3Pg48Hf9OrPPEhn3PCJV
	 vW9qxZnBb2X1fFw4LNh83YmtsgyMsHItZK4TwNsvaxBlvkadDbvFGBg3od/fAx7w7F
	 kXEr1SnJrE8G8vyj3xZMj45vTzFn/8rDkfCIp9QFSe2SXwH7zma4v19VTssSlVKzYV
	 m9oOVUd3yjxZ+VyBw9n0S+fsh0s+m3QvjLDGRHq2KbSaTo5Kw48myIf+xf7HG+bvaP
	 AoMhzxfjIOGj8iAQmu1zU9DkkM1cLBCiI75RAuuonWgHxF2Is7APv8MIXFZnyjE8Ry
	 K/IgQPTcPgUOQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:42:50 +0100
Subject: [PATCH net-next v2 01/12] selftests: mptcp: stop forcing
 iptables-legacy
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-1-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
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
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6DqmGRP1tZluK9mNCSy/cg+OaX+szuhdusFeb
 28jLrkjpeuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pgAKCRD2t4JPQmmg
 c6M8D/9QuWeXPOXgRljjYmqGHFhSzcMFW0Swj4fIS8n2iq2ngs/kSZots+sBovD1fs65Y2MvuW5
 E555Ik9i+MWLXMk7KvOaanROLcfqsFuK4ObQ7th7/UXGn82yBC/SKAX+qcuH8APceIg42qJY6gg
 nYw1W/gN7iPzHi6YjwYyYeLVBo/9q1t/VANprPy4KYOnnDPuV+NxM4czfQ8h6iWTn/CaU+0ZdqY
 /3zSmbCroEPBgfIRtJN8vJN3yfluCiTlqYx/tYFnRX6r5laCl0K9LWa9oIbsmL5TAdA2LI1on9P
 OokgajUYlF3reElDhai6yWsfSv2ekPVW8JRqpiAkqhoOH5vyrvH69q64xCyibfBGdrbCtlNPOWK
 AtmsDK/7BjJev/YTAXodu+auLh5lBA9ev5JPiMIAE+DSFbfI817o0Iq/hI97OT4+RyxgOWq/gFJ
 X6Jc4KVpIeHcRiun5dx5Y+CmCPza2k36ADkzWyYqyirbKmgKWkR0REgFMoh7F3Pyns9c69F6z2S
 mj5ej/8hPi/v+tOijYhacebshoixHVbLSsW7n7XXreMtyqDOfhV4AdaOnh7YMkz4hvXC0OFqt13
 h4ONf7i5nCCeZfOklXssP3G18O0DJgtW2XIW5Fxu5ah6XLzmBLx8xR3O6J9X9ggL2O0q9PVRHdn
 ZPbVzLGKdDAvfiA==
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


