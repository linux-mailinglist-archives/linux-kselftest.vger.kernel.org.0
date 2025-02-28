Return-Path: <linux-kselftest+bounces-27908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27569A49C30
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9E918956F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B042702CD;
	Fri, 28 Feb 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggj9z3F4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756D2702C6;
	Fri, 28 Feb 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753548; cv=none; b=qjmgP7wy8fzBzYUCWyeBQxIjUT59iJCHJMhdK/0n0GbNzvwOBcktD8lpYfQZr4J11WAcK2IC15k70KicvlqsS11+tGDU0qjKfYXHS/2E+V1aiaWLJ/4r3n9qj7ZgWOHZJhV5TsnMrlQNFBUSzMlz4ZlAMwAxVlxh/Aml/1fKgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753548; c=relaxed/simple;
	bh=F7sCftthae2wa//4XS+FXxznTP6sqKdBsyQYVRXN+iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oS17Wxym7STzhue2qMeGCabHKCgnb8c+r0maymc+QOrgzm0AbGdPuy/Y6tL9HYSTcuq0msiI5ivzHwbuVzgDtY3NaNwnJjpfGwl9ja39hW+L5hiPaBjWaPx6pLOpzpXP3CRMfKaamG+x//N3CKNdtGnL0UDZZERzxxufmoxYhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggj9z3F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A82AC4CEE2;
	Fri, 28 Feb 2025 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740753548;
	bh=F7sCftthae2wa//4XS+FXxznTP6sqKdBsyQYVRXN+iE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ggj9z3F49R7eJmL9qHzdO7kPBljmqDW6Wjn12LOZc5oRr/0xpp0THlTGA9jYCvwkz
	 Qnycz8axmL9kx/Jr8xAF7FZRMiPupR2Ojry8ocICLmwbEQCtZZOAzwpwaDzF6fKU4S
	 8IN6wdh1l3So8kuGl5hshHyFa34H+Z/gf6k83kf5BZoUHfK9MOaGi8i32clUo/tXr2
	 RaUlmQcvAKoPlrWQtPLpheWlSYGfzhenbfClSVqD6EEQAT3ahfGabinadZhoig0Smz
	 iEanav1aXEHhRTNY7+M1gqk3OBruwBF0lLxfnpmQCNwI7Qd/hPRM3gtBznV5IeWvge
	 wEqPutnjCZ41g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 15:38:35 +0100
Subject: [PATCH net-next 1/5] selftests: mptcp: Add a tool to get specific
 msk_info
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-net-next-mptcp-coverage-small-opti-v1-1-f933c4275676@kernel.org>
References: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
In-Reply-To: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8905; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BPMlcuYIqfZjtMs9VzdA6ZxF7h9sHTiG/5jq1JkELC0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwcqFss5jThjCneGl+pec40JwvkVftOhdpjgqU
 tmKdLYiK3WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8HKhQAKCRD2t4JPQmmg
 c/PJD/49MlX4L/ee04Xf7WeOuoLzPEgvF9bfF+h2cBqVPp7WWOfxS8Un4LRo0LV9xY5ohekyNqs
 42GKi2I12MokHA5Z6eT6sTzbI6AiyT8gZyJfHYgLrZufBnYXjm7wSBYDfpRz0FWh4bfRm+cvWqz
 gwI7h6PTazPlMfzFP0J1TieLwaQpDkcQSk/JDBvYQlAc1yzHYod1bxSbWLv94zhbeEUvULthJP5
 kuVQ5sCAt2FaSAnHJxyJwKXsDx8324BoJvGpKPrlSVzq8Jxq5JIwfQLCKUlMwvVL2Q6fDWfbTd0
 bMN8LOXIjS8e1G1qobUSVlpV9+ulXQTmT0FfHsiDQiL4jGlW1DKGfFssBbAAwyvZus778Xo2ca1
 getGWPIaKuwcdkuEKBsARm8kxB5ADHcFW4F2mabzt03t2mxZJ+JQC/c+KHY/J5v0ciQ0EMDeL1d
 TPNUIvgxyMXjkQF2yFBHroMNSZ3wCe0xjZulVY9oh7G6n+5pAa+4jvX867SkGuzpGSoXWOAEeQQ
 qBO8qy0mMihJcu2Y1p9Yv6REC2GAxWJIzmKdTgG8QPDVuE9zX55ZUpkPQJWoJ3K9HEyzguzhL+2
 Jic9mRGFlKZwZnXBmKNIGdlI1XwNjdRKlIxhCBdVnbNZ7/cDliw/ZFrIqxTRsggy62aFYYWevgM
 Z9b6E8eXs0r9AiA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

This patch enables the retrieval of the mptcp_info structure corresponding
to a specified MPTCP socket (msk). When multiple MPTCP connections are
present, specific information can be obtained for a given connection
through the 'mptcp_diag_dump_one' by using the 'token' associated with
the msk.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile     |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 272 +++++++++++++++++++++++++
 2 files changed, 273 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index c76525fe2b84d503646429d1ddfb4a323a722ae9..340e1a777e16a893300e01d19fdb5191fab8e00b 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -7,7 +7,7 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
-TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
+TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
 
 TEST_FILES := mptcp_lib.sh settings
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
new file mode 100644
index 0000000000000000000000000000000000000000..284286c524cfeff5f49b0af1a4da5a376c9e3140
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Kylin Software */
+
+#include <linux/sock_diag.h>
+#include <linux/rtnetlink.h>
+#include <linux/inet_diag.h>
+#include <linux/netlink.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <linux/tcp.h>
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <stdio.h>
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
+struct mptcp_info {
+	__u8	mptcpi_subflows;
+	__u8	mptcpi_add_addr_signal;
+	__u8	mptcpi_add_addr_accepted;
+	__u8	mptcpi_subflows_max;
+	__u8	mptcpi_add_addr_signal_max;
+	__u8	mptcpi_add_addr_accepted_max;
+	__u32	mptcpi_flags;
+	__u32	mptcpi_token;
+	__u64	mptcpi_write_seq;
+	__u64	mptcpi_snd_una;
+	__u64	mptcpi_rcv_nxt;
+	__u8	mptcpi_local_addr_used;
+	__u8	mptcpi_local_addr_max;
+	__u8	mptcpi_csum_enabled;
+	__u32	mptcpi_retransmits;
+	__u64	mptcpi_bytes_retrans;
+	__u64	mptcpi_bytes_sent;
+	__u64	mptcpi_bytes_received;
+	__u64	mptcpi_bytes_acked;
+	__u8	mptcpi_subflows_total;
+	__u8	reserved[3];
+	__u32	mptcpi_last_data_sent;
+	__u32	mptcpi_last_data_recv;
+	__u32	mptcpi_last_ack_recv;
+};
+
+static void die_perror(const char *msg)
+{
+	perror(msg);
+	exit(1);
+}
+
+static void die_usage(int r)
+{
+	fprintf(stderr, "Usage: mptcp_diag -t\n");
+	exit(r);
+}
+
+static void send_query(int fd, __u32 token)
+{
+	struct sockaddr_nl nladdr = {
+		.nl_family = AF_NETLINK
+	};
+	struct {
+		struct nlmsghdr nlh;
+		struct inet_diag_req_v2 r;
+	} req = {
+		.nlh = {
+			.nlmsg_len = sizeof(req),
+			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
+			.nlmsg_flags = NLM_F_REQUEST
+		},
+		.r = {
+			.sdiag_family = AF_INET,
+			/* Real proto is set via INET_DIAG_REQ_PROTOCOL */
+			.sdiag_protocol = IPPROTO_TCP,
+			.id.idiag_cookie[0] = token,
+		}
+	};
+	struct rtattr rta_proto;
+	struct iovec iov[6];
+	int iovlen = 1;
+	__u32 proto;
+
+	req.r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
+	proto = IPPROTO_MPTCP;
+	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
+	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
+
+	iov[0] = (struct iovec) {
+		.iov_base = &req,
+		.iov_len = sizeof(req)
+	};
+	iov[iovlen] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
+	iov[iovlen + 1] = (struct iovec){ &proto, sizeof(proto)};
+	req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
+	iovlen += 2;
+	struct msghdr msg = {
+		.msg_name = &nladdr,
+		.msg_namelen = sizeof(nladdr),
+		.msg_iov = iov,
+		.msg_iovlen = iovlen
+	};
+
+	for (;;) {
+		if (sendmsg(fd, &msg, 0) < 0) {
+			if (errno == EINTR)
+				continue;
+			die_perror("sendmsg");
+		}
+		break;
+	}
+}
+
+static void parse_rtattr_flags(struct rtattr *tb[], int max, struct rtattr *rta,
+			       int len, unsigned short flags)
+{
+	unsigned short type;
+
+	memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
+	while (RTA_OK(rta, len)) {
+		type = rta->rta_type & ~flags;
+		if (type <= max && !tb[type])
+			tb[type] = rta;
+		rta = RTA_NEXT(rta, len);
+	}
+}
+
+static void print_info_msg(struct mptcp_info *info)
+{
+	printf("Token & Flags\n");
+	printf("token:        %x\n", info->mptcpi_token);
+	printf("flags:        %x\n", info->mptcpi_flags);
+	printf("csum_enabled: %u\n", info->mptcpi_csum_enabled);
+
+	printf("\nBasic Info\n");
+	printf("subflows:              %u\n", info->mptcpi_subflows);
+	printf("subflows_max:          %u\n", info->mptcpi_subflows_max);
+	printf("subflows_total:        %u\n", info->mptcpi_subflows_total);
+	printf("local_addr_used:       %u\n", info->mptcpi_local_addr_used);
+	printf("local_addr_max:        %u\n", info->mptcpi_local_addr_max);
+	printf("add_addr_signal:       %u\n", info->mptcpi_add_addr_signal);
+	printf("add_addr_accepted:     %u\n", info->mptcpi_add_addr_accepted);
+	printf("add_addr_signal_max:   %u\n", info->mptcpi_add_addr_signal_max);
+	printf("add_addr_accepted_max: %u\n", info->mptcpi_add_addr_accepted_max);
+
+	printf("\nTransmission Info\n");
+	printf("write_seq:        %llu\n", info->mptcpi_write_seq);
+	printf("snd_una:          %llu\n", info->mptcpi_snd_una);
+	printf("rcv_nxt:          %llu\n", info->mptcpi_rcv_nxt);
+	printf("last_data_sent:   %u\n", info->mptcpi_last_data_sent);
+	printf("last_data_recv:   %u\n", info->mptcpi_last_data_recv);
+	printf("last_ack_recv:    %u\n", info->mptcpi_last_ack_recv);
+	printf("retransmits:      %u\n", info->mptcpi_retransmits);
+	printf("retransmit bytes: %llu\n", info->mptcpi_bytes_retrans);
+	printf("bytes_sent:       %llu\n", info->mptcpi_bytes_sent);
+	printf("bytes_received:   %llu\n", info->mptcpi_bytes_received);
+	printf("bytes_acked:      %llu\n", info->mptcpi_bytes_acked);
+}
+
+static void parse_nlmsg(struct nlmsghdr *nlh)
+{
+	struct inet_diag_msg *r = NLMSG_DATA(nlh);
+	struct rtattr *tb[INET_DIAG_MAX + 1];
+
+	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r + 1),
+			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
+			   NLA_F_NESTED);
+
+	if (tb[INET_DIAG_INFO]) {
+		int len = RTA_PAYLOAD(tb[INET_DIAG_INFO]);
+		struct mptcp_info *info;
+
+		/* workaround fort older kernels with less fields */
+		if (len < sizeof(*info)) {
+			info = alloca(sizeof(*info));
+			memcpy(info, RTA_DATA(tb[INET_DIAG_INFO]), len);
+			memset((char *)info + len, 0, sizeof(*info) - len);
+		} else {
+			info = RTA_DATA(tb[INET_DIAG_INFO]);
+		}
+		print_info_msg(info);
+	}
+}
+
+static void recv_nlmsg(int fd, struct nlmsghdr *nlh)
+{
+	char rcv_buff[8192];
+	struct sockaddr_nl rcv_nladdr = {
+		.nl_family = AF_NETLINK
+	};
+	struct iovec rcv_iov = {
+		.iov_base = rcv_buff,
+		.iov_len = sizeof(rcv_buff)
+	};
+	struct msghdr rcv_msg = {
+		.msg_name = &rcv_nladdr,
+		.msg_namelen = sizeof(rcv_nladdr),
+		.msg_iov = &rcv_iov,
+		.msg_iovlen = 1
+	};
+	int len;
+
+	len = recvmsg(fd, &rcv_msg, 0);
+	nlh = (struct nlmsghdr *)rcv_buff;
+
+	while (NLMSG_OK(nlh, len)) {
+		if (nlh->nlmsg_type == NLMSG_DONE) {
+			printf("NLMSG_DONE\n");
+			break;
+		} else if (nlh->nlmsg_type == NLMSG_ERROR) {
+			struct nlmsgerr *err;
+
+			err = (struct nlmsgerr *)NLMSG_DATA(nlh);
+			printf("Error %d:%s\n",
+			       -(err->error), strerror(-(err->error)));
+			break;
+		}
+		parse_nlmsg(nlh);
+		nlh = NLMSG_NEXT(nlh, len);
+	}
+}
+
+static void get_mptcpinfo(__u32 token)
+{
+	struct nlmsghdr *nlh = NULL;
+	int fd;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
+	if (fd < 0)
+		die_perror("Netlink socket");
+
+	send_query(fd, token);
+	recv_nlmsg(fd, nlh);
+
+	close(fd);
+}
+
+static void parse_opts(int argc, char **argv, __u32 *target_token)
+{
+	int c;
+
+	if (argc < 2)
+		die_usage(1);
+
+	while ((c = getopt(argc, argv, "ht:")) != -1) {
+		switch (c) {
+		case 'h':
+			die_usage(0);
+			break;
+		case 't':
+			sscanf(optarg, "%x", target_token);
+			break;
+		default:
+			die_usage(1);
+			break;
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	__u32 target_token;
+
+	parse_opts(argc, argv, &target_token);
+	get_mptcpinfo(target_token);
+
+	return 0;
+}
+

-- 
2.47.1


