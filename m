Return-Path: <linux-kselftest+bounces-32181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA1AA71E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAE04A48B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CE255F49;
	Fri,  2 May 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixSHneR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A88255F43;
	Fri,  2 May 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188991; cv=none; b=NH5V82ROpTUAQdzATSF4COFHa8JdqXQbf8jzG7XiwGyvKnpGv+2dnu4/qVghCoys8YEP+PNeAGMIiU+dDcwxrUXKw6VgRaUkTve3kknEdSCRWa+zEEqXTLX5KzhV47qgk0XBcL6HvqaMzUkZmNPyBYH9qw4aUdCDvnf8195jScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188991; c=relaxed/simple;
	bh=cqB9dz1yBk4G81aoXsuf6a8tTtHU627jMvKTo5XIkLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOZclRrm2XwZBUD6d23dKDh2pYBRH/2AmgC9fI9/g3Rwg8bBVdjgFl4eN90ZnliaZfpjyJK1B0kJTu0Al83ojyaYqZwZtCpCsezVZ3cRR7gOCJ2dkbHTKisro0Cj1nY+NAz/zhPQrhjdXaTvFGKb4donXhOGboVhTunzbwIUcaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixSHneR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3ECC4CEEE;
	Fri,  2 May 2025 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746188990;
	bh=cqB9dz1yBk4G81aoXsuf6a8tTtHU627jMvKTo5XIkLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ixSHneR+uCbN151wtIhGEfQvIRIBRAy/F1cvPUbHvkZLSpUia09upwXhD+liBdJSK
	 5di+7MFiySJRbh7I1J3JitTSskBAZGQM2EGiu+hsEBBRHAhKNEgVzIXrzXsJ89BapW
	 Mi1GvDJKzqw9MxHcBF8U8UKjAWovPFvFbSJ6js9hxGifJfmzm8TywHZyHcl5QSe1Qy
	 NAko+pvaJtoAyiDHzLeef8I5KCCxjz+snXN5zAwyVUVdxoz5pHWYzJcBdsadSzOwJA
	 0shlt5t/RIG+vYy8KbrtRmw2aSekQBsxJOs9HYUxtS6cbSWAOXOMOeBp6GeEieUGkL
	 Tsy5/sXewGUSA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 May 2025 14:29:25 +0200
Subject: [PATCH net-next 5/7] selftests: mptcp: refactor NLMSG handling
 with 'proto'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-net-next-mptcp-sft-inc-cover-v1-5-68eec95898fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4189; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6gMy9j0i075KIh14EymklHuMxOQb1xA+ZLGrQ9vl9ZE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJEdq1e2dpqejnUjSPg78pNEim3Gfbttlv4e5J/9u2qw
 HNW2nZzO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYSPJ+R4fTbl46NDrUNiS6m
 pnF7PpyftZ/z3EJ545IVfm7a53XXuzEyXHJ/Gt25ZWX+nlsfd3QmvflsdLYnwPZqrlH1evPtEn8
 42AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

This patch introduces the '__u32 proto' variable to the 'send_query' and
'recv_nlmsg' functions for further extending function.

In the 'send_query' function, the inclusion of this variable makes the
structure clearer and more readable.

In the 'recv_nlmsg' function, the '__u32 proto' variable ensures that
the 'diag_info' field remains unmodified when processing IPPROTO_TCP data,
thereby preventing unintended transformation into 'mptcp_info' format.

While at it, increment iovlen directly when an item is added to simplify
this portion of the code and improve its readaility.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 38 ++++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 76135aba71ad24c25c7babb6875e8a6dd7636b21..cc0326548e4ec44060da83f1f77e498bcedc82a9 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -62,7 +62,7 @@ static void die_usage(int r)
 	exit(r);
 }
 
-static void send_query(int fd, struct inet_diag_req_v2 *r)
+static void send_query(int fd, struct inet_diag_req_v2 *r, __u32 proto)
 {
 	struct sockaddr_nl nladdr = {
 		.nl_family = AF_NETLINK
@@ -80,21 +80,22 @@ static void send_query(int fd, struct inet_diag_req_v2 *r)
 	};
 	struct rtattr rta_proto;
 	struct iovec iov[6];
-	int iovlen = 1;
-	__u32 proto;
+	int iovlen = 0;
 
-	proto = IPPROTO_MPTCP;
-	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
-	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
-
-	iov[0] = (struct iovec) {
+	iov[iovlen++] = (struct iovec) {
 		.iov_base = &req,
 		.iov_len = sizeof(req)
 	};
-	iov[iovlen] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
-	iov[iovlen + 1] = (struct iovec){ &proto, sizeof(proto)};
-	req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
-	iovlen += 2;
+
+	if (proto == IPPROTO_MPTCP) {
+		rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
+		rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
+
+		iov[iovlen++] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
+		iov[iovlen++] = (struct iovec){ &proto, sizeof(proto)};
+		req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
+	}
+
 	struct msghdr msg = {
 		.msg_name = &nladdr,
 		.msg_namelen = sizeof(nladdr),
@@ -158,7 +159,7 @@ static void print_info_msg(struct mptcp_info *info)
 	printf("bytes_acked:      %llu\n", info->mptcpi_bytes_acked);
 }
 
-static void parse_nlmsg(struct nlmsghdr *nlh)
+static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 {
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	struct rtattr *tb[INET_DIAG_MAX + 1];
@@ -167,7 +168,7 @@ static void parse_nlmsg(struct nlmsghdr *nlh)
 			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
 			   NLA_F_NESTED);
 
-	if (tb[INET_DIAG_INFO]) {
+	if (proto == IPPROTO_MPTCP && tb[INET_DIAG_INFO]) {
 		int len = RTA_PAYLOAD(tb[INET_DIAG_INFO]);
 		struct mptcp_info *info;
 
@@ -183,7 +184,7 @@ static void parse_nlmsg(struct nlmsghdr *nlh)
 	}
 }
 
-static void recv_nlmsg(int fd)
+static void recv_nlmsg(int fd, __u32 proto)
 {
 	char rcv_buff[8192];
 	struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buff;
@@ -216,7 +217,7 @@ static void recv_nlmsg(int fd)
 			       -(err->error), strerror(-(err->error)));
 			break;
 		}
-		parse_nlmsg(nlh);
+		parse_nlmsg(nlh, proto);
 		nlh = NLMSG_NEXT(nlh, len);
 	}
 }
@@ -230,14 +231,15 @@ static void get_mptcpinfo(__u32 token)
 		.idiag_ext              = 1 << (INET_DIAG_INFO - 1),
 		.id.idiag_cookie[0]     = token,
 	};
+	__u32 proto = IPPROTO_MPTCP;
 	int fd;
 
 	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
 	if (fd < 0)
 		die_perror("Netlink socket");
 
-	send_query(fd, &r);
-	recv_nlmsg(fd);
+	send_query(fd, &r, proto);
+	recv_nlmsg(fd, proto);
 
 	close(fd);
 }

-- 
2.48.1


