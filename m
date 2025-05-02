Return-Path: <linux-kselftest+bounces-32182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC37AA71E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1613A4A52
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C982561BB;
	Fri,  2 May 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6MhFhMR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349F2561B4;
	Fri,  2 May 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188993; cv=none; b=Efr+Sj/gpc0tEqOHjrhLgQQ1gnkUpq9/v9FMeVDPzS4Dn/H2V5XUF1vSGD5SetpSdwr3+KD07uYAk1LFp8EcI2oXJyt2+jLw/kx/kd6Gz8MZ7S2RMEpdMvSy0RHtNdgHI9U04rd0S+cWckwAhVhuJyG94cSqnxf+bpQ45nJLVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188993; c=relaxed/simple;
	bh=HrsUHH/qcXk1q2H9+8cPQnJZjPaeJV60k2cbn77FiW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCzG6q5cqQAorQJEDmdBF5NvU3Pf+Kl0etTUxqd0oxO5NeGCHwff4ergvOFZZFmxtqTb3pA3qRo1NIUVGa5+7lg8GnZwsedTJp5yXkufdwYnJZ+e0dzNhw7W+UtXzZUbZnGAedu886qeueYNDttr28J79Aa4qdhfFo809SN3NKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6MhFhMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3140C4CEEF;
	Fri,  2 May 2025 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746188993;
	bh=HrsUHH/qcXk1q2H9+8cPQnJZjPaeJV60k2cbn77FiW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n6MhFhMRALlVlVlt/huLjvKonv68JMMSW4ipemc/u0gBn14MugCigjIpky7JhU3Bm
	 m4JW5Qx6XmWg33tImH+XiF4hBLLb+x6qoKlplnI975yo43+GJoHJDCZ5cUodcGGfzl
	 Eczt/rWvh8q61Jb3aCPLABPefcM680J3EvDnlYweNcoeI94h8yXy/T7ZhOyUrwOZtm
	 m9Y+5LBvx08fpe69G8xXgcxn+XLGL9T3rNTsrEeOVKlMQ1uZVu83CUqYj54M9SVRJ0
	 812m3Tp6eEOZE6DrZAzcbGRHkZ0uwJc+b/goGu2A4v4WpulovL6A8W3B6yWkLeVqUn
	 G2JIvzivzwSwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 May 2025 14:29:26 +0200
Subject: [PATCH net-next 6/7] selftests: mptcp: add helpers to get
 subflow_info
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-net-next-mptcp-sft-inc-cover-v1-6-68eec95898fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8228; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7miyWEw+OpSZsSyngjOj789UMezB1kb5Lfuy5ZvWtt4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJEdq3p9+dT2CxdWnnR8te3+efWKGUm69+t3PP6CCvbm
 7m+fzOqO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayWJeR4ajqz09t1/7easxY
 e9vIRz37dajmveDVB09VMUrouSmFn2RkuO/0nmNGw9wniyy5P3+Rnfz00f9D5x137d4lWjuNm/l
 vBBsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

This patch adds 'get_subflow_info' in 'mptcp_diag', which can check whether
a TCP connection is an MPTCP subflow based on the "INET_ULP_INFO_MPTCP"
with tcp_diag method.

The helper 'print_subflow_info' in 'mptcp_diag' can print the subflow_filed
of an MPTCP subflow for further checking the 'subflow_info' through
inet_diag method.

The example of the whole output should be:

  $ ./mptcp_diag -s "127.0.0.1:10000 127.0.0.1:38984"
  127.0.0.1:10000 -> 127.0.0.1:38984
  It's a mptcp subflow, the subflow info:
   flags:Mec token:0000(id:0)/4278e77e(id:0) seq:9288466187236176036 \
   sfseq:1 ssnoff:2317083055 maplen:215

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 159 ++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index cc0326548e4ec44060da83f1f77e498bcedc82a9..e084796e804d28e93d04c30cca937fe21be43388 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -8,6 +8,7 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <linux/tcp.h>
+#include <arpa/inet.h>
 
 #include <unistd.h>
 #include <stdlib.h>
@@ -19,8 +20,13 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+#define parse_rtattr_nested(tb, max, rta) \
+	(parse_rtattr_flags((tb), (max), RTA_DATA(rta), RTA_PAYLOAD(rta), \
+			    NLA_F_NESTED))
+
 struct params {
 	__u32 target_token;
+	char subflow_addrs[1024];
 };
 
 struct mptcp_info {
@@ -50,6 +56,37 @@ struct mptcp_info {
 	__u32	mptcpi_last_ack_recv;
 };
 
+enum {
+	MPTCP_SUBFLOW_ATTR_UNSPEC,
+	MPTCP_SUBFLOW_ATTR_TOKEN_REM,
+	MPTCP_SUBFLOW_ATTR_TOKEN_LOC,
+	MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
+	MPTCP_SUBFLOW_ATTR_SSN_OFFSET,
+	MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
+	MPTCP_SUBFLOW_ATTR_FLAGS,
+	MPTCP_SUBFLOW_ATTR_ID_REM,
+	MPTCP_SUBFLOW_ATTR_ID_LOC,
+	MPTCP_SUBFLOW_ATTR_PAD,
+
+	__MPTCP_SUBFLOW_ATTR_MAX
+};
+
+#define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
+
+#define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
+#define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
+#define MPTCP_SUBFLOW_FLAG_JOIN_REM		_BITUL(2)
+#define MPTCP_SUBFLOW_FLAG_JOIN_LOC		_BITUL(3)
+#define MPTCP_SUBFLOW_FLAG_BKUP_REM		_BITUL(4)
+#define MPTCP_SUBFLOW_FLAG_BKUP_LOC		_BITUL(5)
+#define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	_BITUL(6)
+#define MPTCP_SUBFLOW_FLAG_CONNECTED		_BITUL(7)
+#define MPTCP_SUBFLOW_FLAG_MAPVALID		_BITUL(8)
+
+#define rta_getattr(type, value)		(*(type *)RTA_DATA(value))
+
 static void die_perror(const char *msg)
 {
 	perror(msg);
@@ -58,7 +95,9 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_diag -t\n");
+	fprintf(stderr, "Usage:\n"
+			"mptcp_diag -t <token>\n"
+			"mptcp_diag -s \"<saddr>:<sport> <daddr>:<dport>\"\n");
 	exit(r);
 }
 
@@ -159,6 +198,66 @@ static void print_info_msg(struct mptcp_info *info)
 	printf("bytes_acked:      %llu\n", info->mptcpi_bytes_acked);
 }
 
+/*
+ * 'print_subflow_info' is from 'mptcp_subflow_info'
+ * which is a function in 'misc/ss.c' of iproute2.
+ */
+static void print_subflow_info(struct rtattr *tb[])
+{
+	u_int32_t flags = 0;
+
+	printf("It's a mptcp subflow, the subflow info:\n");
+	if (tb[MPTCP_SUBFLOW_ATTR_FLAGS]) {
+		char caps[32 + 1] = { 0 }, *cap = &caps[0];
+
+		flags = rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_FLAGS]);
+
+		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_REM)
+			*cap++ = 'M';
+		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_LOC)
+			*cap++ = 'm';
+		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_REM)
+			*cap++ = 'J';
+		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_LOC)
+			*cap++ = 'j';
+		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_REM)
+			*cap++ = 'B';
+		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_LOC)
+			*cap++ = 'b';
+		if (flags & MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED)
+			*cap++ = 'e';
+		if (flags & MPTCP_SUBFLOW_FLAG_CONNECTED)
+			*cap++ = 'c';
+		if (flags & MPTCP_SUBFLOW_FLAG_MAPVALID)
+			*cap++ = 'v';
+
+		if (flags)
+			printf(" flags:%s", caps);
+	}
+	if (tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM] &&
+	    tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC] &&
+	    tb[MPTCP_SUBFLOW_ATTR_ID_REM] &&
+	    tb[MPTCP_SUBFLOW_ATTR_ID_LOC])
+		printf(" token:%04x(id:%u)/%04x(id:%u)",
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM]),
+		       rta_getattr(__u8, tb[MPTCP_SUBFLOW_ATTR_ID_REM]),
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC]),
+		       rta_getattr(__u8, tb[MPTCP_SUBFLOW_ATTR_ID_LOC]));
+	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ])
+		printf(" seq:%llu",
+		       rta_getattr(__u64, tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ]));
+	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ])
+		printf(" sfseq:%u",
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ]));
+	if (tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET])
+		printf(" ssnoff:%u",
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET]));
+	if (tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN])
+		printf(" maplen:%u",
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN]));
+	printf("\n");
+}
+
 static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 {
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
@@ -182,6 +281,22 @@ static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 		}
 		print_info_msg(info);
 	}
+	if (proto == IPPROTO_TCP && tb[INET_DIAG_ULP_INFO]) {
+		struct rtattr *ulpinfo[INET_ULP_INFO_MAX + 1] = { 0 };
+
+		parse_rtattr_nested(ulpinfo, INET_ULP_INFO_MAX,
+				    tb[INET_DIAG_ULP_INFO]);
+
+		if (ulpinfo[INET_ULP_INFO_MPTCP]) {
+			struct rtattr *sfinfo[MPTCP_SUBFLOW_ATTR_MAX + 1] = { 0 };
+
+			parse_rtattr_nested(sfinfo, MPTCP_SUBFLOW_ATTR_MAX,
+					    ulpinfo[INET_ULP_INFO_MPTCP]);
+			print_subflow_info(sfinfo);
+		} else {
+			printf("It's a normal TCP!\n");
+		}
+	}
 }
 
 static void recv_nlmsg(int fd, __u32 proto)
@@ -244,6 +359,39 @@ static void get_mptcpinfo(__u32 token)
 	close(fd);
 }
 
+static void get_subflow_info(char *subflow_addrs)
+{
+	struct inet_diag_req_v2 r = {
+		.sdiag_family           = AF_INET,
+		.sdiag_protocol         = IPPROTO_TCP,
+		.idiag_ext              = 1 << (INET_DIAG_INFO - 1),
+		.id.idiag_cookie[0]     = INET_DIAG_NOCOOKIE,
+		.id.idiag_cookie[1]     = INET_DIAG_NOCOOKIE,
+	};
+	char saddr[64], daddr[64];
+	int sport, dport;
+	int ret;
+	int fd;
+
+	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr, &sport, daddr, &dport);
+	if (ret != 4)
+		die_perror("IP PORT Pairs has style problems!");
+
+	printf("%s:%d -> %s:%d\n", saddr, sport, daddr, dport);
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
+	if (fd < 0)
+		die_perror("Netlink socket");
+
+	r.id.idiag_sport = htons(sport);
+	r.id.idiag_dport = htons(dport);
+
+	inet_pton(AF_INET, saddr, &r.id.idiag_src);
+	inet_pton(AF_INET, daddr, &r.id.idiag_dst);
+	send_query(fd, &r, IPPROTO_TCP);
+	recv_nlmsg(fd, IPPROTO_TCP);
+}
+
 static void parse_opts(int argc, char **argv, struct params *p)
 {
 	int c;
@@ -251,7 +399,7 @@ static void parse_opts(int argc, char **argv, struct params *p)
 	if (argc < 2)
 		die_usage(1);
 
-	while ((c = getopt(argc, argv, "ht:")) != -1) {
+	while ((c = getopt(argc, argv, "ht:s:")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -259,6 +407,10 @@ static void parse_opts(int argc, char **argv, struct params *p)
 		case 't':
 			sscanf(optarg, "%x", &p->target_token);
 			break;
+		case 's':
+			strncpy(p->subflow_addrs, optarg,
+				sizeof(p->subflow_addrs) - 1);
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -275,6 +427,9 @@ int main(int argc, char *argv[])
 	if (p.target_token)
 		get_mptcpinfo(p.target_token);
 
+	if (p.subflow_addrs[0] != '\0')
+		get_subflow_info(p.subflow_addrs);
+
 	return 0;
 }
 

-- 
2.48.1


