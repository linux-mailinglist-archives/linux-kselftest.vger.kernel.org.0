Return-Path: <linux-kselftest+bounces-6129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED54876CE5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E889D1F2251D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6000C64CC1;
	Fri,  8 Mar 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZb5nU/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3308E64AB6;
	Fri,  8 Mar 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935865; cv=none; b=gIGyjk3eA2uqAHcqEsXiL4DigvgBRtUZsv96bNKHygJ03BLc0RSyBtE9TgoKLDASEUtArg0XQKqYYFGAB7antS5oy9wVKL2+BzrndINInTDhZdDH7M2SVHmZx3d5LdDOEZj4Wp/0vvawnbmjjuCLSLCxgdo1BZllCW4oC20Tv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935865; c=relaxed/simple;
	bh=ZIYQB+KzyVVuQY99Ima/pHk8e/qhoSdaRzLvkUvByoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jyif2j3G70harHXs3e9D+N+u0Ny8JTNCFrVsFHbiR2k3+8+TR5iSxwCQxfa6WAiir7a1sG2lA01xmk9GwsslAmNePtLBOzaJO7ygtCnp7Is1BTn12W7t5jUS8GCR0sNUxUkcisQWqMpstcpjIQrc4mJ2keu1BnzAWV9S+TpAiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZb5nU/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3364C433A6;
	Fri,  8 Mar 2024 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935865;
	bh=ZIYQB+KzyVVuQY99Ima/pHk8e/qhoSdaRzLvkUvByoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lZb5nU/9OrGHjO6k54vqrE46viLbAWBqhuSh9Bf8O5Twjjsnw9dNcUvjB7/Y19sZq
	 UPa+Skse/uHx6SXuCljbxT1VqaRSXQU4Gc3U0AjpjCko4aFaurT3md/tDlD1dDAH6r
	 9GNU2/jUoMv+yGYrlVtM8mOZn2p98JJBw+t9OSfqrp+/3HyPM01UpMmlJy4PvRH2FO
	 DOGnu2fBgFdFs+iD0C+X8WiUUiTE4ARnKIKqP0HFl4FREOZzfJuFnSMh9CZOcdfGsm
	 ztB6cVCF1nZlzyCegkwpNMX+rOyTH3BusoOfeBh3ExHTaScvXP7l1iuzh+BPBvpXMA
	 lygEwEFS5GI7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:19 +0100
Subject: [PATCH net-next 12/15] selftests: mptcp: print_test out of
 verify_listener_events
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-12-4f42c347b653@kernel.org>
References: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
In-Reply-To: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=p0AphtGjcDw+iiDKBH/TekIuR6JxnoGE+w4YmACLQaY=;
 b=owEBawKU/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJNNdI9bL+Lp4gaXO54fqB3FpDQM2Em4sAH
 /fwxSeu1nmJAjEEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 c4NJD+0a4wVzQzMtGhDUW/8Wuf1sf8M+bsbE9NO7RfuKtZigCLLPKwAWCJVJQtsp7HRTbwM7ASa
 ZLpDXDcOZDTUGbLntA+mN2DgnsVT0tZcDnVUNawjT9tQ5H04ZUBxxaIzDTBrAWres+iJHbk4J3d
 V5lZsfF7R3Uhz87xZCp7VDoxYwoYyb/RqPxtQrC4Q7TxA0o73+wD+Ri0Hl5FJYApyPDVNbWj1gB
 yLYVhnWcyWgvjmLW+VzKVEQFfcBLIFILFyn8g9/LYm1AoXq9KUVcVeb0vjNO8SiruBsXRrVqec5
 rupMLOYAFpNl3THAlaVen2f7B1FSx/Fft544J/XtxENCciSjrwVBLJzcKleftnc6VSzCcKBbDIS
 9EDPIv9g+lyXK3DMJlSUFb5ULsh1zCpWIV+JM3pmX1vIfhLcbcOdr2V3xi8gRXDYIFu0+Amnohc
 snpHq4vko1Y2urO5jj/tXiXz7RtL/HxR0Ozj3P8q9Yk9atIAWKhrG6EWMLJrLScg3YHg/WbT9U1
 qyZCU0/ppkpXkFocbMKoVwJqPg5b+5Mtus0iBip++DJfszM+CumwhcAQf1oCqRL+MBayT4c3Dan
 GgVC2oaGF8H3xf7KxBc4y30c57TAQ6mkD4erHrl0USDSKYD8wbjLE5OUZdNcGVQj6D0zwP/9RGy
 8HYf77bJVkfg=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

verify_listener_events() helper will be exported into mptcp_lib.sh as a
public function, but print_test() is invoked in it, which is a private
function in userspace_pm.sh only. So this patch moves print_test() out of
verify_listener_events().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6d0862a1b68d..e9aea44edee5 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -845,12 +845,6 @@ verify_listener_events()
 	local saddr
 	local sport
 
-	if [ $e_type = $LISTENER_CREATED ]; then
-		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
-		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
-	fi
-
 	type=$(mptcp_lib_evts_get_info type $evt $e_type)
 	family=$(mptcp_lib_evts_get_info family $evt $e_type)
 	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
@@ -882,6 +876,7 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
+	print_test "CREATE_LISTENER 10.0.2.2:$client4_port"
 	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
@@ -898,6 +893,7 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
+	print_test "CLOSE_LISTENER 10.0.2.2:$client4_port"
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 

-- 
2.43.0


