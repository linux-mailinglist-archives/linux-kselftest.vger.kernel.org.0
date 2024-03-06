Return-Path: <linux-kselftest+bounces-5990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4108732F4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A21C26432
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7760DE8;
	Wed,  6 Mar 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqKIkW92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688960DDE;
	Wed,  6 Mar 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718221; cv=none; b=btnksAWmANynmt5OLTID7WqYcqPAm7LMzDegYwZzRF3YL4Od+zCbAlDQXKfQUYwW4+ZiHissyS47Ua7fcqrYKYKmoU8jWkq8ZbSE3Alf5BFVBj3/qk+gBmXVayb1m7vD8M4YGKmVQMbo/FL+WVVKecA4iwpGdlmvA0Xzko9TV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718221; c=relaxed/simple;
	bh=TXr6T5gctPLk+weuAPDK0CvjU5ZW8VNUAi1/4q57pf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzZHTPjAQuXZAq6K8GTTtaVtls/ktV6O+HDt23iUQNROl8allnwzFji8Fqv2CrBJ4vi72YeTPVUv4t2TqqtS8A/XmmBVhXtTopu58D0lrHUfLtVmxUiWA++V3sEsBJ75LA9kXxuL8lNgFqByUmg7b6wKdNGxm6hNMpkQocx9Zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqKIkW92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B997AC43394;
	Wed,  6 Mar 2024 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718221;
	bh=TXr6T5gctPLk+weuAPDK0CvjU5ZW8VNUAi1/4q57pf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hqKIkW92n6YI3RrTE31cbQs+D4nShq9qFbUe9q0QbSeRNFoAze+VcAPg6Vh/UwhMn
	 lhGS+YheKA4USCBL4xp0MTnoX3qa2mZi6LJuqeHjCXSKkNqs4VSEp1uHNfHs1yBdzG
	 8Z9ZCWUx8g3HyF8zlWpAnw4EaASqz/yi22BHGNp6Hm03yeJ4wVNnIkILrYv7ODD9qN
	 PCBlxYLAhmMPX3MIdoBFjohOKDj160MeFleBpAkvqnFTBrc/KFJHZXOHaIeyWR5qNN
	 B+/KjXNH2l/90m6XxGhAAAnGPd4bZyjmSTceypzu4Rhem/OqY1GO9fkXVY4lgHw+Pk
	 dF2QotIDDzguQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:43:01 +0100
Subject: [PATCH net-next v2 12/12] selftests: userspace pm: avoid
 relaunching pm events
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-12-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TXr6T5gctPLk+weuAPDK0CvjU5ZW8VNUAi1/4q57pf4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6DqnnvKD6kkrhkEHHr19YMe9Cu8g1S1GcYRAY
 0HRl4AuWOuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pwAKCRD2t4JPQmmg
 c2UWEACtz0bJ+al4KBOIPNZn32mKMkgA1r7et63FIYhJccg66dhsLZardA0U68Y15KAAvHBbhTQ
 EKFqGxtGP7VhuRMoeVjWqARBqLUQ5mrOVj5yvm1X5ZYE3JWEw0u40ZZFT4Qzva1UcdlCxVOAZXB
 q3m8c64PxEeReQf7qciakJAKUdROpYKCH3iA0y2QGkLye/4LSAGak4WTKwvaA9Xm5zPy+Rh4o3m
 Gg3S5axHC1sANZdn+WrrQ3I+8fNm2R0eNUqWuaCqHrCueSnRbtpe2hrrD3QCOCstKdnM5mY+gkw
 rHpKwheJsQgyn7Y8nzaw/ervviyh9TP5LkgTV8u2FownBZKIeLdrI2jEqyQ+Aglvn3nI+xfC4oE
 B9Mwn/dWszqIsYE22tqeeVyTlHDeT8rJPMTc3jC1998zcDeWPUxDS7ZXkPDdddCr4CgtsNrx6XS
 g6pYyrCF59d24rCDNr+FHVZ+qxDmBypVEmW8TrTwBwcR9uDAkN9tnKf4UqXEOEddhmzn2SZ0yuj
 usJexU5jyaxzpzFUBLpvZzNI4dfQsWiYKwvj6NgpE5CfEaPsMhBBhz/tPMxfKEwNlNr4Wow73pB
 5oAufijlEEvmGVqNPDMHXDxknEJHmmDKHfsLdb4nKWIEAq4OyIn1xxX77b4s2AAJUxyXqFZoXaz
 Gu8avI/uJDp0MpQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'make_connection' is launched twice: once for IPv4, once for IPv6.

But then, the "pm_nl_ctl events" was launched a first time, killed, then
relaunched after for no particular reason.

We can then move this code, and the generation of the temp file to
exchange, to the init part, and remove extra conditions that no longer
needed.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 29 ++++++++++-------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3200d0b96d53..b0cce8f065d8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -149,17 +149,23 @@ ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
 ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
 ip -net "$ns2" link set ns2eth1 up
 
+file=$(mktemp)
+mptcp_lib_make_file "$file" 2 1
+
+# Capture netlink events over the two network namespaces running
+# the MPTCP client and server
+client_evts=$(mktemp)
+mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
+server_evts=$(mktemp)
+mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
+sleep 0.5
+
 print_title "Init"
 print_test "Created network namespaces ns1, ns2"
 test_pass
 
 make_connection()
 {
-	if [ -z "$file" ]; then
-		file=$(mktemp)
-	fi
-	mptcp_lib_make_file "$file" 2 1
-
 	local is_v6=$1
 	local app_port=$app4_port
 	local connect_addr="10.0.1.1"
@@ -173,17 +179,8 @@ make_connection()
 		is_v6="v4"
 	fi
 
-	# Capture netlink events over the two network namespaces running
-	# the MPTCP client and server
-	if [ -z "$client_evts" ]; then
-		client_evts=$(mktemp)
-	fi
-	mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
-	if [ -z "$server_evts" ]; then
-		server_evts=$(mktemp)
-	fi
-	mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
-	sleep 0.5
+	:>"$client_evts"
+	:>"$server_evts"
 
 	# Run the server
 	ip netns exec "$ns1" \

-- 
2.43.0


