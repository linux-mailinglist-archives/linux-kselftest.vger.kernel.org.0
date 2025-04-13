Return-Path: <linux-kselftest+bounces-30650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C298A8715F
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 11:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BBE1897DFD
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 09:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413A1B041A;
	Sun, 13 Apr 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRYDOa9l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2E19E96B;
	Sun, 13 Apr 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536914; cv=none; b=sCfcdXWlccX3aMgVnYTJjpYeJWiqR6PFFkBkJ0SOFAFWxjBfG1dT78knW5Jr1wTaMAYPuNIYRRmiVfdZE0P5HSR0bssxkse3BdmZhPecrZ7qY5EhrUP4D2S+35aAvjT9CEYNyClLK7zpDPym5YrIHSsWVXJFk+vV0NojzTGxfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536914; c=relaxed/simple;
	bh=tyy9AFxNFtpd26xDDYsU7GNnn1KTKoGzwj1OZPYWBw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJO2U/T0lCAiJu3avX5mHQvtjiuFTTxovK+4EtSlyIdvsAJ8YaTtAi59ZbyYi8FmJaQiTTvt538esW9sSmo6JoDdWiLOiX9qhk0uLXOw15NDaVes/6VeIfvgjZ3E2b27p48kSurrsIWKmUJt7l4LWAQf9xK6aDFLU2B1mckFUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRYDOa9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47528C4CEEB;
	Sun, 13 Apr 2025 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536914;
	bh=tyy9AFxNFtpd26xDDYsU7GNnn1KTKoGzwj1OZPYWBw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MRYDOa9l3HfhY8NenYGEDpYZ4fhMGQXGH22X0HkIZExqoYzKEpOi09jv6j6paNqRp
	 Q3SiBK6+DoawQUHernVieq2QrSh8c5EqA79YMkBnjLAN302pp3zslj9DkfaotC9f5K
	 cvd9u9LCfaca4obDzQRBy6Q4CD6gtpe77RCHRVEtlR9gqJpWKFhScKPH1zE+XEPW7V
	 X2cG0zXlj72RgpE5qmr6Ela3S2QXw6JGNLdjiCEvCXqBGETfizOKzGNE9fbGRtyP9i
	 bXefufR652qY9Nupm90QtsEXH90ZpSul3HwANmxDDKIhM5ybTdcSeWlYNDUAEZ6f3/
	 5tVBm9vNsPOSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 13 Apr 2025 11:34:38 +0200
Subject: [PATCH net-next v2 7/8] selftests: mptcp: diag: drop nlh parameter
 of recv_nlmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-7-0f83a4350150@kernel.org>
References: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
In-Reply-To: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bSgd3cMF0dhmJtw1234qL3slJn2RJqdF55LFpsUz5og=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+4U6WG0UbsFgcXLd5ERQenqZRz2xRwKMDRDGn
 JeieHxQ/62JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/uFOgAKCRD2t4JPQmmg
 c/XWD/40p1aYJ7ocmwkSwJ8wRB2DSXKApBDjXauT0aSaey+NGJv0Ocj+lPhc17U5x1Du7Zm3Vn8
 NCQ/Mr6xEEzafZfkH8zQMbRXhADgY1ost1vvSENeNf38r60CqS9nIRr3RMKpcbg+RebkCy1QIDq
 XzYWLvpRw6vg4ZHkqroufMdqS7CUApuERjjly8zgrDrHazrLyjnRtM/laPqmiHmKJVkeUY/tDOc
 tsft3kIBETMOoXnu696iq6XyfYEpgaIy29VDFlyu0MqSP3ukxtVnBLbBD+aoNiXgQqCR1a7s1DT
 mixBnTY+wG5gMcReB9OOZEFGBiP3brYdjYpNcj9/xKBTRy/p/dt23tVwNQBOu+jHm0wROraETfT
 FlcZ49GnAjbM6KU+05h7bSxiiR4oLCVeW6tBss0Os8wUnMwPrk1GFAa0MbR0o9Wxos+TGGNfEXP
 uxz0JT1N1GtmhC5CT/CpdF2u9vr1JT0QiZ/vziNexerdj5HcJh1RdzZMXn68y8Dgz3gMVIGGzTQ
 Vu7L/c1Ay4BJXwDdnvm6h8gPLE9RO0LalKqpK1NZiI83CsiZk00+8jWIqZOdLXPCEJDQFfU6a56
 xknWEcbRm6b3LseSjWXhHfvg4J6Eaiuya5Q74/lbTwg2efPhSx8aCOVAYidPYiU4PyML3ZV4N65
 eS5FOEtytafS+2w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

It's strange that 'nlh' variable is set to NULL in get_mptcpinfo() and then
this NULL pointer is passed to recv_nlmsg(). In fact, this variable should
be defined in recv_nlmsg(), not get_mptcpinfo().

So this patch drops this useless 'nlh' parameter of recv_nlmsg() and define
'nlh' variable in recv_nlmsg().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- v2: fix Author field (--no-mailmap).
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


