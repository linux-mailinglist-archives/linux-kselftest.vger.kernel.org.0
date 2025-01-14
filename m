Return-Path: <linux-kselftest+bounces-24500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3449A10F58
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 19:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4969188B93B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255EB225A41;
	Tue, 14 Jan 2025 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjCayaiY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8544225785;
	Tue, 14 Jan 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877822; cv=none; b=lb5ZbLxJ8fpcjRmz28edBF6+tqXuxv0TuyJrhr4TMQe7tupZrk8zi6qHLBjWtqhoFnnD32oDPBxHT8zI8ZKs6XEspYoQxT52PozdsC6AXUBfiqKudAqu0WtTSDuH+R07XZV8GY+D+Bkjjy6zaG3R6bKxvwUYkumbJpbjotEdz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877822; c=relaxed/simple;
	bh=txZfXf0LdEubQEytQZHPcz62G7KPx882XPWtXcCYOwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJYNcRgadXHNcauYYzCe0WbqXyESnedVYnIa/mH0DkgUXy/7fBULpalftk0FSJWt5gt5zsjS0p1AR6bF1L9SPHGuXY0srrAS7YJnZe4sKaJkMJm06MTKLGV8antOjy8gA1bh+Vz1RmtDYxDjCkLo0J82P1YAqvNSRri+X4Zb8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjCayaiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0FBC4CEE0;
	Tue, 14 Jan 2025 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877821;
	bh=txZfXf0LdEubQEytQZHPcz62G7KPx882XPWtXcCYOwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gjCayaiY2OCLSbe4cyoef4y3/a5yU32CwPOlaCMCtL3TEo4b+74rqplKFbq5cuyPe
	 zo6fBEGlzplLHBaYbBz3OdiDNklyglSnJkXVYMR8pLk2bDepBYmL2F8l3mGFMplv1p
	 Z6crwd7kHpx3sBiVzzl3d8fjwhP7mkBmJbvnGTJrk4FRNpBBhEf2+cWS6H2TBK2L/j
	 w/2M5gzUp0atTfIPesj8Ad8S2cvUtXNWTiZxH+G1cVJwDPuErmHJTWE8LsbY/FalEA
	 igQSXbCQRKtHrDl/SWbd9SsF14OSM2ro6sd8ULjcJ/w1Mk45JQSBXFRBGlu4X9gRHp
	 MMztFime0SHfw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 19:03:15 +0100
Subject: [PATCH net-next 5/6] selftests: mptcp: connect: remove unused
 variable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-net-next-mptcp-st-more-debug-err-v1-5-2ffb16a6cf35@kernel.org>
References: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
In-Reply-To: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=txZfXf0LdEubQEytQZHPcz62G7KPx882XPWtXcCYOwk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqbo4zCngECBBc6Ypu9Bz2UiCyOSF0uW4bn6m
 B3T46b64AmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4am6AAKCRD2t4JPQmmg
 c30OD/9QAuzpECAjdIWfPRuf/CXDIS7K/8KnIV+AkANbGdNi3Ajesk1L7UXBf8I4+D2egITVyTm
 c2Yd/kpIdTgrVrKNRaSVJf8nCP5CjDBaA8hkUXKNgufg8t3YWgleqlJRcdfHqzowSfA5+lo4AiB
 C5cxJ77nGCeRKQA2PJmxYxrUEC/ICeRL2YnAWCBuq3DT4pd7qL/TWJSFSGlSeMrJ+uXF/CBOwT8
 7F4fn40JO8lnA2XdoMiq0B3DC1S9XfLiwM7kRe9jQQXBiEBl8uwgwaCQWQyxfY31+cIRlS1cb1O
 I/viREfoc7TXj5typY85DnDeKFCs+yWmMGWgFIoUV0EKVMw3Aa9Sj8SYXcFLJnx1Hx33uANG/w9
 kF4vdwYZRHjqeef0muvTV9PRfByDL19LwKa86kU+OZv8n8QqhYLn9y1K9XuSuFha9S8SutrtMH4
 1gOFVXewdHY+6H+KYbz3sCrQKdj0h7o/UX3lo3YcdT8mF1SWGXrwzKCKso+x3fi5LsYeBhH0k7P
 OkqGi0OI0IpV8QWk2OyatwPXRvRCZSAZENlQUgZdjJNKihrcSYKEUiWlWww7uetkr5MNRietR4q
 LPbXr79L/wizLT4MDlAbXtCFbQjvuBuccn+TmLLg809CIXDEESlHyL5YPFkP92G2a+R9DHkaqSy
 NXZZYPLA+MNJT0w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'cin_disconnect' is used in run_tests_disconnect(), but not
'cout_disconnect', so it is safe to drop it.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index bfdaecd0a6a0564020530345daf91bed296bc15c..e508d356fcdaebbfb95750bba0fa834a8463e32a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -137,7 +137,7 @@ TEST_GROUP=""
 #shellcheck disable=SC2317
 cleanup()
 {
-	rm -f "$cin_disconnect" "$cout_disconnect"
+	rm -f "$cin_disconnect"
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
@@ -155,7 +155,6 @@ cin=$(mktemp)
 cout=$(mktemp)
 capout=$(mktemp)
 cin_disconnect="$cin".disconnect
-cout_disconnect="$cout".disconnect
 trap cleanup EXIT
 
 mptcp_lib_ns_init ns1 ns2 ns3 ns4

-- 
2.47.1


