Return-Path: <linux-kselftest+bounces-30580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B71A85B43
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C489C5E40
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D01829CB46;
	Fri, 11 Apr 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFwstxkc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B711238C25;
	Fri, 11 Apr 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369533; cv=none; b=XJHvqLSAKl6YoVhyEhadXmuKjKMI3ZMrm10LypAyJaZZ7jLnO1M8IIXThi6F7CnH/vJ9OPtKl+pw6Mo8arE2eaDIEQMfXcC2WixNmA/QxyPQOpPd9C9JLBQltLE8VB6KPaYSDBFm1kfpk7nbI4CSsONgTcULJY5Q+w/tfLwSl5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369533; c=relaxed/simple;
	bh=i/GlvhSN538NE7SBoAjAJPDxGMKLqYYx2haue4B3Izg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzR+iiUfMvkX1z7um0yQbqHAv5J7mPN5WVFz+MJ84iOXHMbZPIKPNVq31sjNCMLSaaxKQOZvrMThkF92bVey9SGOepK2iWksCqaXw2ev4TYyxpy3z1PJxSPhqN8fCTxIj/7Qn07W697l0aIFQoE/dPN1QB1uhoRW2sRkUTTXCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFwstxkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E650C4CEE2;
	Fri, 11 Apr 2025 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744369531;
	bh=i/GlvhSN538NE7SBoAjAJPDxGMKLqYYx2haue4B3Izg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RFwstxkcOB3ej9IeEdoABM156s/0hd0CT/vIL5iPTlUBMyTy4Q9t3FYMs+nDT+inx
	 jGJnalipfswjEyyTZjjC+7xq4uzuoEuIQFcbSNkw1n8hYktjXbzKujLyEweZXvlYUp
	 GU3ffg4utypuHNCZ/DmNe4w6etMwwlhT/SY/9KuzekymCsjZRoV6O9hBStyCVdkS9H
	 nL/xICmrUii2kR+7Hdyyh4Au1nxAbXMIp//+7+r/JH3dI9ctyvwGY4JLBjaOBWEeE+
	 MfgzfZqNJtj1k7U0FTWfCv0uRZ59FaV1D7dhe4busNUgOsmOYTuWkY4tnkb1ZFWd9P
	 Uj32XJr/PWhdg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 11 Apr 2025 13:04:53 +0200
Subject: [PATCH net-next 7/8] selftests: mptcp: diag: drop nlh parameter of
 recv_nlmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-7-85ac8c6654c3@kernel.org>
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
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wxXdsKA19MnqpU94PG1rbDiyKZhsZPhImZMy2xueNYI=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+Pdjlw+3M1F4AfNMVW0omN6hPMChq2fx6pZAM
 a7s8p0t5ySJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/j3YwAKCRD2t4JPQmmg
 c5yaD/0fqG0y6JHszzU83MpM5DvDAJPDMCylizozdCd8+ch2mnOaQRGtsAJPizaCb8c6niur8vx
 r+F5q0D3zq/a3ZTwYkTP+cWRrdCVeUUjpBkOjCTgs5k1otr8kLntsmiN5x0oSWTQDfkjv7aB+vW
 e3KREy1i7Nw1TJAj4kVel8Zw7uikwMYSRpkxlW9H48ZvTebYaeKLg4sSyxHYa0tcZbCOcL3OHSq
 a3RsDy+BbaF0sW59vxwumHr2AbRKifqhsSXq0c0y+NpvncSQvU0yFYqHKPj47+kZ1uybBtEcJ7I
 7fiTgFOdx1mfmiRQvkVcG+4lWXXogz6HnUI2k9+A3cS0tmERVKQimTIQtoJV0Q1lDNt76YOj709
 l2zTBW2f3OqnRjB9+HYVT1KYB70VDZJqLemh9D/D+OseKXXMfSBLYxGpiZoem3KlrnWy+86onuv
 GSjEWFCES+DT1IVonA22wrazO9EQ+930fq5ccwavKgklJvAvHvSJzy/Rokz+JVQZUVd0Iplz7LH
 wXVXigffEubxpgP4dfr0PTUM2/3pOJfl6QpCzI+gEXlUM/fR2BCWKCXRAqPZPtYWyhcD6a8umyn
 Xq8Q9K9zJDJCvc/Umvf6kTlZWQgZ4AiupXbNFOy0RRJVuRrZ6By9I9YJhSi1/2OeDdAOgH/Lyon
 BKeBLOHSXl2gNwQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang@kernel.org>

It's strange that 'nlh' variable is set to NULL in get_mptcpinfo() and then
this NULL pointer is passed to recv_nlmsg(). In fact, this variable should
be defined in recv_nlmsg(), not get_mptcpinfo().

So this patch drops this useless 'nlh' parameter of recv_nlmsg() and define
'nlh' variable in recv_nlmsg().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 284286c524cfeff5f49b0af1a4da5a376c9e3140..37d5015ad08c44485f1964593ecb1a7b25d95934 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -185,9 +185,10 @@ static void parse_nlmsg(struct nlmsghdr *nlh)
 	}
 }
 
-static void recv_nlmsg(int fd, struct nlmsghdr *nlh)
+static void recv_nlmsg(int fd)
 {
 	char rcv_buff[8192];
+	struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buff;
 	struct sockaddr_nl rcv_nladdr = {
 		.nl_family = AF_NETLINK
 	};
@@ -204,7 +205,6 @@ static void recv_nlmsg(int fd, struct nlmsghdr *nlh)
 	int len;
 
 	len = recvmsg(fd, &rcv_msg, 0);
-	nlh = (struct nlmsghdr *)rcv_buff;
 
 	while (NLMSG_OK(nlh, len)) {
 		if (nlh->nlmsg_type == NLMSG_DONE) {
@@ -225,7 +225,6 @@ static void recv_nlmsg(int fd, struct nlmsghdr *nlh)
 
 static void get_mptcpinfo(__u32 token)
 {
-	struct nlmsghdr *nlh = NULL;
 	int fd;
 
 	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
@@ -233,7 +232,7 @@ static void get_mptcpinfo(__u32 token)
 		die_perror("Netlink socket");
 
 	send_query(fd, token);
-	recv_nlmsg(fd, nlh);
+	recv_nlmsg(fd);
 
 	close(fd);
 }

-- 
2.48.1


