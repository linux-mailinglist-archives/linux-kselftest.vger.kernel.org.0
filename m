Return-Path: <linux-kselftest+bounces-5918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A88871C3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB571F253FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903A62A16;
	Tue,  5 Mar 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3xr6nd8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC262A0F;
	Tue,  5 Mar 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635412; cv=none; b=feUXBZQIyGh7rAMk66Rc6W/bPbotj8awzTeYs1h00BkSerxq9Tty4ifY9Dr4yLl/KYii4E3MbEoyARN6HGfyNHZ4brsKgWmT1CwtLEeatVSSDt+y5xBRSHY0t/J+Ih5bGh4v3puTo7baD/cc0JwCfhpANyjeQIpsOiIjYnJqZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635412; c=relaxed/simple;
	bh=TXr6T5gctPLk+weuAPDK0CvjU5ZW8VNUAi1/4q57pf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5HmHNeYjad11w9aADxzAHtVI1tiYOAicIrNYcetS3t3lCpSooUJ0oKeGlkZGFdW9DSKhTtICIAXE5Uis8526Wfn4CxwXL+lbPeUcQFpz50Zb5q46l7HpmqU4BjWrz82Uij6nra7SJI2KEEVWfMV+KZx1zv4fRl+cqKdKXljDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3xr6nd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0665C43390;
	Tue,  5 Mar 2024 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635412;
	bh=TXr6T5gctPLk+weuAPDK0CvjU5ZW8VNUAi1/4q57pf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z3xr6nd8OG2diHS35Sun6lQrVCP54cyxSEd4HvDucM4XZ7Lr8zqeqJ02UZpl2Md/x
	 hmiIaKDefnhqvqd5uDoIsrdm+iSYJWI6HLTIey2yhv8i3sddQ0727t8qptOFucttNU
	 e38+geUzX8IgZ0+q6POWx9Ws+b4rVsY2ildKn7Zw4wmdewBqvlNck5Y2VV5yal875O
	 twJhRpKX52VrlX5id37RwaJQZDzXXFh+9bVPcIdIrB9vpT/vEPWNXw7/5WkW2mbto7
	 sOLHHTw6m2LjCLDJZ5FhtV2mnicq5ZhYCjn1xm07bQzrUByaH7/dkl29wWtf+GVbsm
	 nnpc8UlDMPZoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:43 +0100
Subject: [PATCH net-next 13/13] selftests: userspace pm: avoid relaunching
 pm events
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-13-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TXr6T5gctPLk+weuAPDK0CvjU5ZW8VNUAi1/4q57pf4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vcdWvZOlF2dPM/bD8EnzbOzzLBJwJOoByS1P
 3r1cAhJyQ+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HQAKCRD2t4JPQmmg
 c4+5EADm9uVDUc6EJ98F/z11Xr2mgCzFqi6CL43XvSyGOX2H9WUjRqBpXarILE96pJKA0UqTBud
 4HmdnxUonGh90yAdafBjv1euH4YvmFcXytveabyynQGhCiTlzBLYivAzRosBvMualqwYleGuyRG
 9zidzrEbtrX/7veysAJKcmt/FL+bhPevPZiluISaVG+4RAyPcg9+t6WXOX4VEYzJoXz/3bfyWsv
 dkjliFqmtY48uUDXNo4mSZtmosKYw/T9Nc7JbkvxKYIeEUp7MnhADjl7NMUU+Og0ekR4Nilz5Ms
 jJgVfeZDqgGBsG8UFCQKlIWugY2N0VTmztjNSxc9L2XZZawoRo5kjwRab5Pnu4oLLbmPUH9AmJk
 iyMrZS81zhAAIndOYMMyihupT8qtainXlGsR23p9Ob79Kc8scwwNFO3TF3agFrBlnDM6v2bMrof
 qNBr/EYSSRyCxVZT57pijkWzAzN3wKWCkqMt+QN5VQSDvwrNYKSLNZAsgxBqpsADyYo/0fx49oR
 pJD3aU2Xm0MMooFItelhJ9TB+5tVY4qVj/g8UYwiY0iKwRe/5F6TZDmf7phc9moYHeSTcfBh61I
 K5j1PWe+gcLNGDXfPgKDGEpPlhf43E9YJLBSjgzM0YbXcxcSDFHJJmRuU91EeetOukvKlRtTEiQ
 AmeOZFiLFh7j2RA==
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


