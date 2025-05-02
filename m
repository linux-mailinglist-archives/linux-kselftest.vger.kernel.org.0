Return-Path: <linux-kselftest+bounces-32178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC25AA71D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93AB4C6CBD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FF02550A6;
	Fri,  2 May 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku/nlL6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C3254B1B;
	Fri,  2 May 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188983; cv=none; b=ZYDw/frC4EukSxkMUnjMY2klbxrznP30eNjVdcOQEGRoQE7jyQs4zMBOz4nb1XBqMU8WQuX4jutialllOQDnFbxRfUeUBKWx13WCbMGoJLkB38WcwHIeTwQM10eq4ozZ2Ancu3Fe2kUruj16b1fTPYCtlcofm46KdzKQAJ496hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188983; c=relaxed/simple;
	bh=+8h2bBaXFvBYeApUD14GhuhytbONYgeQNFr6X5ImztQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNwKIfKVemp9OQFTnlNcvPJKE+Wof8ADgXKfWbe13lFvQqBxL5II7nPup7LTNjqs5nCvyI34Xvv+ceydJ3hPIdgm+MNTHVwZXmcs6h0DdjgK4yEa0nwxp5B1n1Nh5BLnR5aLQFARLzNPRbfahGou+dO7w77rXyCLMtzeqhoiYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku/nlL6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9D3C4CEE4;
	Fri,  2 May 2025 12:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746188982;
	bh=+8h2bBaXFvBYeApUD14GhuhytbONYgeQNFr6X5ImztQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ku/nlL6dneEz7IDa6Juf+mJ7IXYE/PgG5+2opOEGtkVs0z5ayHTEjFm/j1T8vpn8Y
	 NOV3wbOeOkTz3KeERLvkoVHHfavIngFzd9+7picPhipmiK793rjQlC+BP4rdu38Vn6
	 tx5CazxgqdwwRsA1i1ZfkRIavyJlqj9aey7cVymyN5uYWtGDze6/32WDYoqc0WMGaN
	 +GwL46Yd+eir38qNLYD0C0DKKKLkCx/gDWDfe87tbEe+mWZnZgqRsSRYuXCMAXy0V6
	 Yx8O6gRcOkOXO9d5JteLmjIvBPMKrjawwQuValSY9dlD2NrhBOSM3p5grIGs9E79Lt
	 Sql5wHtgt68lw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 May 2025 14:29:22 +0200
Subject: [PATCH net-next 2/7] selftests: mptcp: sockopt: use IPPROTO_MPTCP
 for getaddrinfo
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-net-next-mptcp-sft-inc-cover-v1-2-68eec95898fb@kernel.org>
References: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
In-Reply-To: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3683; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sduBQPtFEpZUQE4iqnz88Fv2x9sSGoedrY37aNpWYUA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJEdi33vjv39J/pMyZPD5j95JzJ0mtHdBNLPlb0dDlNn
 NG49qpUXEcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEHh5hZPhe/aQ3+uO9IMmj
 CXfXrGUybJmvyNr6NVD84pldvouk37ow/GY7x58wdZH55dV9J5vaV2/d8VDuSV9rZe7klIWL86N
 tL7MAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

getaddrinfo MPTCP is recently supported in glibc and IPPROTO_MPTCP for
getaddrinfo is used in mptcp_connect.c. But in mptcp_sockopt.c and
mptcp_inq.c, IPPROTO_TCP are still used for getaddrinfo, So this patch
updates them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 16 ++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 16 ++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 218aac46732125c005212d0d561ae3bce8f91a74..3cf1e2a612cef911028f46569563d16dd5d32129 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -72,13 +72,21 @@ static const char *getxinfo_strerr(int err)
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
+		if (err == EAI_SOCKTYPE) {
+			hints->ai_protocol = IPPROTO_TCP;
+			goto again;
+		}
+
+		errstr = getxinfo_strerr(err);
 
 		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
 			node ? node : "", service ? service : "", errstr);
@@ -91,7 +99,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 {
 	int sock = -1;
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
 	};
@@ -136,7 +144,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto)
 {
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 	};
 	struct addrinfo *a, *addr;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 926b0be87c9905e763cfb5ba6df974d3518f0b49..9934a68df23708ecb413c4ab26523989e3b9f158 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -159,13 +159,21 @@ static const char *getxinfo_strerr(int err)
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
+		if (err == EAI_SOCKTYPE) {
+			hints->ai_protocol = IPPROTO_TCP;
+			goto again;
+		}
+
+		errstr = getxinfo_strerr(err);
 
 		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
 			node ? node : "", service ? service : "", errstr);
@@ -178,7 +186,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 {
 	int sock = -1;
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
 	};
@@ -223,7 +231,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto)
 {
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 	};
 	struct addrinfo *a, *addr;

-- 
2.48.1


