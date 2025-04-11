Return-Path: <linux-kselftest+bounces-30581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C4DA85B2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4B8176026
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A21129DB6E;
	Fri, 11 Apr 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBYVclk0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54229DB64;
	Fri, 11 Apr 2025 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369536; cv=none; b=Ibk+xSEvZk2qq1YNXrvankWaT7j7r+mZl7/L6zxaAREGqqQmuajgaB+RiPGuWuw5A3I+o8/+PA9Q+jiMHJxyW532nRvETIFn3GOj9SWdJs2IwwEovm1MpyXvUW6dLT+J5xP+lRK/KiOAz/UHuvTKBrjjx7e+BejaMqfHxyVJT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369536; c=relaxed/simple;
	bh=rKIA8P8ck0NbKkzwHpkUlyV4dTbzRC4THZQ1beZsiJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCcMHWSb0TpOoAHDQ4qbE1i6iKdzmqzYJUPCMUr5hqYGkqR5MGIyBoturbf1kNRZGQ1R2T2Oq1cI+ecsJEmpq9Nm48nryzWoQiOZfHhPBUfV6YF3HSkgDLwRRurfRR1cZXbYJVqM2ZdZaPm0RPvvm9ud38nitePG2nRMYDwmWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBYVclk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8780C4CEE8;
	Fri, 11 Apr 2025 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744369534;
	bh=rKIA8P8ck0NbKkzwHpkUlyV4dTbzRC4THZQ1beZsiJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IBYVclk0RDcl+6Qi1L1gdYAv7BtmBzryU0DAjp4TfkRF/soatOdRw0xkzB3ePxNxQ
	 oHkcMYOAUmpyDnUuUOIJcDafRdznMsULb+tTxGoyI11nLNqHKDbAuBEaoUKAFX+Mmt
	 sOs2wUSIQw66nk6w3nfvC7z+HpSB/YxCSc/RbV/uhbZVvh4RWCaaIp9yJM1u2sEFcz
	 BwOb7MgLVd4sjHl19DvSpUyehbULaA8xcB4ONUOyXXnCcpo3rZl+Ux2Y8R2/BjUnA4
	 paDf112/74JFfovp4gI5oLpQE3VNXz3MyaSfctVijcLLK+aXx5J8Lr6wzHkevJ8Ifv
	 LbpdXt3Nm74bw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 11 Apr 2025 13:04:54 +0200
Subject: [PATCH net-next 8/8] selftests: mptcp: use IPPROTO_MPTCP for
 getaddrinfo
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-8-85ac8c6654c3@kernel.org>
References: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
In-Reply-To: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 zhenwei pi <pizhenwei@bytedance.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hAqb+9EwIsZn40xu+6ctRkc54LS4FAN8XGDT4iQnIuE=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+PdlbPUd21AsOdYhyIUyuF04g+5hcYhzWrwS1
 KASAoBqkS2JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/j3ZQAKCRD2t4JPQmmg
 c4RYD/9fB/KGOne2fdX6ZppR7lISrMhvvQVtN15vyE6HR7rI1zMeh02FrmTi+M5jQaMiq3H71nl
 0lGZ4CMF0h1K0SAptpMy6VoMjxg2gtHnTIl+JHiuw/0xLZSD/stL2NUl2KxZ+ZWPwIPPVCcY8Tl
 0x6yecMgDjvZVEeUD2z4S1QvGCt7IWPbbselLkeXfyyLNR+YwkjtUhKrAGVyta9MGn3TgSagNNh
 Fv2/3mS9ljUzbzbrZ90f1M5a1y1Qha4dJca8RZrxE1VrGqRcMkgGYcXGnyCipBiT/zPTm2XfU2f
 N+gmCqsdnA0Yti06GapgUpsx4pa3vAK0+qDT6poSAfuzMixuKMCix5YuMkunn2O3tGfGy3UnbhM
 mLGuZWE2M4fDGWg/uoE9Iqnv+y7pnB2pJo/+hGn2cry1vGylstPL347hh8LRoc0m65Rv7FV4NLe
 Sj5UjFCKgXKTLpB8XFctKoCzdNpBLHb1aQOYnAd0y9tNCKUB1ZM5m0GUXdYNNPrt5bmXrH3Kl24
 IL4bfXY1lL3u7SoeypRFnlcpA4lsDWi5S5wtmGPuGWusa7uyCcyGHTi4thvFyJlBaY5zvLrK3s/
 2uEdVgE8ccJowvjAIx2eTHAe8XfAASWd971Dmnq+rTm/9hK/3DaKz5DjRADcROo7ctP+VtdOeFw
 swTzLpp55VtuVGA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: zhenwei pi <pizhenwei@bytedance.com>

mptcp_connect.c is a startup tutorial of MPTCP programming, however
there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
getaddrinfo MPTCP support.

This patch first uses IPPROTO_MPTCP to get addrinfo, and if glibc
version is too old, it falls back to using IPPROTO_TCP.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- a previous version has already been sent to Netdev. ChangeLog:
  - show how to use IPPROTO_MPTCP with getaddrinfo, not only a comment.
  - Link to this version:
    https://lore.kernel.org/20250407085122.1203489-1-pizhenwei@bytedance.com
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c83a8b47bbdfa5fcf1462e2b2949b41fd32c9b14..ac1349c4b9e5404c95935eb38b08a15d774eb1d9 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -180,13 +180,26 @@ static void xgetnameinfo(const struct sockaddr *addr, socklen_t addrlen,
 }
 
 static void xgetaddrinfo(const char *node, const char *service,
-			 const struct addrinfo *hints,
+			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
+again:
 	int err = getaddrinfo(node, service, hints, res);
 
 	if (err) {
-		const char *errstr = getxinfo_strerr(err);
+		const char *errstr;
+
+		/* glibc starts to support MPTCP since v2.42.
+		 * For older versions, use IPPROTO_TCP to resolve,
+		 * and use TCP/MPTCP to create socket.
+		 * Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
+		 */
+		if (err == EAI_SOCKTYPE) {
+			hints->ai_protocol = IPPROTO_TCP;
+			goto again;
+		}
+
+		errstr = getxinfo_strerr(err);
 
 		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
 			node ? node : "", service ? service : "", errstr);
@@ -292,7 +305,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 {
 	int sock = -1;
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
 	};
@@ -356,7 +369,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			      int infd, struct wstate *winfo)
 {
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 	};
 	struct addrinfo *a, *addr;

-- 
2.48.1


