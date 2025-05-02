Return-Path: <linux-kselftest+bounces-32180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C3AA71DB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A9C1BC4153
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2AD255E4D;
	Fri,  2 May 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0Bxm6ku"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE30255E34;
	Fri,  2 May 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188988; cv=none; b=ofM+ewGVq3e7JU0bKzlgzjjGW226MYiSibD7iZ9imNLUZ/AnyXc0LOMD9OVbaUNt1R3QsjfSFYy96CItD6knFXqsY5VUegVK2hrXT6/VOG7yp/qHU9o3d5ypCFS710xsUiwByJl6zeDlrOfMzt3PRBNhdiFEPySS3fl/0PjLROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188988; c=relaxed/simple;
	bh=Ya2+jFEI7mJuT3ncP/RsKk1LdroKEiKCPg02KaA8Zbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlT39L42BWqZwLXZAqiHkz4PX0NfqFHtHj2Ath8y621r/x6ngvQ2vWvjBRFDiR/9FWrnOidlBkWmyAxWFGGTR/POKiDAs7APOTSseqzr5rpu93n4nBJrtDq0hRN89thkd41Xubh6YsW9tREujFMIQlBgr6mtJU0CRsnPp2S+168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0Bxm6ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599D7C4CEEB;
	Fri,  2 May 2025 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746188987;
	bh=Ya2+jFEI7mJuT3ncP/RsKk1LdroKEiKCPg02KaA8Zbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a0Bxm6kud/b3GtZpAvBrjnOqkSBYN5DcTHB2Mf4RDaC3mvM+sOEb79YztFv3Xf2dK
	 2yC0avJkx5m4tDNpt/FlN8IFZt4+Z3ayw0WQiSN26ibbOQd6IMGhHQP3DrcbySUkLu
	 Pr3lQUoGul4Yee+L3SzhfZR4ITNpt3kPb4mupkgrGS9iIks5EJ44Id7RhSNUKy+O7H
	 QvHQkneMn6Fo0oSRw1eI/45ksvZHf8qaT0EJqp04qCex0qKTDT2SVQT1N9JahYB9Tu
	 cfjWaenrzEwNx8nllLudxsunBVNREU2Pp4V6imL0cy6All3yKfyYEMQzSNacdJZ8uW
	 Zi5AfqYiSBx4Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 May 2025 14:29:24 +0200
Subject: [PATCH net-next 4/7] selftests: mptcp: refactor send_query
 parameters for code clarity
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-net-next-mptcp-sft-inc-cover-v1-4-68eec95898fb@kernel.org>
References: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
In-Reply-To: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tTuaDYFXrdjZ2f7/7lgt2gZN6EWhTltwwGFKgN6cy80=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJEdq3KZJsWOH3axp97Jvr08S/SXCV80Vji5Hlh9tSHc
 V8ndQWs7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI9FyGfwYK/l1xgjfXf/f9
 8qL2rsKekzwb11tb9YR7PlqV3X0+hJ+R4SNH4EWDRT8SeJe8zLmz/Nw50bJGA/0/qx5bfMlZcYi
 XhxUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

This patch use 'inet_diag_req_v2' instead of 'token' as parameters of
send_query, and construct the req in 'get_mptcpinfo'.

This modification enhances the clarity of the code, and prepare for the
dump_subflow_info.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index ea7cb1128044ab7f9bad50cb29856c2e290f385f..76135aba71ad24c25c7babb6875e8a6dd7636b21 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -62,7 +62,7 @@ static void die_usage(int r)
 	exit(r);
 }
 
-static void send_query(int fd, __u32 token)
+static void send_query(int fd, struct inet_diag_req_v2 *r)
 {
 	struct sockaddr_nl nladdr = {
 		.nl_family = AF_NETLINK
@@ -76,19 +76,13 @@ static void send_query(int fd, __u32 token)
 			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
 			.nlmsg_flags = NLM_F_REQUEST
 		},
-		.r = {
-			.sdiag_family = AF_INET,
-			/* Real proto is set via INET_DIAG_REQ_PROTOCOL */
-			.sdiag_protocol = IPPROTO_TCP,
-			.id.idiag_cookie[0] = token,
-		}
+		.r = *r
 	};
 	struct rtattr rta_proto;
 	struct iovec iov[6];
 	int iovlen = 1;
 	__u32 proto;
 
-	req.r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
 	proto = IPPROTO_MPTCP;
 	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
 	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
@@ -229,13 +223,20 @@ static void recv_nlmsg(int fd)
 
 static void get_mptcpinfo(__u32 token)
 {
+	struct inet_diag_req_v2 r = {
+		.sdiag_family           = AF_INET,
+		/* Real proto is set via INET_DIAG_REQ_PROTOCOL */
+		.sdiag_protocol         = IPPROTO_TCP,
+		.idiag_ext              = 1 << (INET_DIAG_INFO - 1),
+		.id.idiag_cookie[0]     = token,
+	};
 	int fd;
 
 	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
 	if (fd < 0)
 		die_perror("Netlink socket");
 
-	send_query(fd, token);
+	send_query(fd, &r);
 	recv_nlmsg(fd);
 
 	close(fd);

-- 
2.48.1


