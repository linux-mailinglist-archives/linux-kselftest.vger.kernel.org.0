Return-Path: <linux-kselftest+bounces-22074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A269CCD1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 01:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE082821B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390EB1E53A;
	Fri, 15 Nov 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXwOrYMg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2661E49F;
	Fri, 15 Nov 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630715; cv=none; b=O1fNZuEwJojsGSTU1o3m7ksRTKb9aCCZikF5M5Vg8chrl0eM5CbjAbx8qCHeVuyEUzj/dhMSKKTCnAx4Bz/ZC5bGol3jVCI6LQkhiqLCOoIGsBnyO3l7MxRf6UDf7g1Kw3lP/VFifADKbiFYnRyhmJaiJVn1g4It+T18I2ocEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630715; c=relaxed/simple;
	bh=LdyZfhGLcAffeQWdZ9vyCIw4OGV0nYZirm1HjPWiJ4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU+hVQn5i6kv+FDG47pTzVwWuPDyAwjXoJSTfg3FBJmp0au70ag4tCdc5/hlBYZc+AbASRDs5onBkL0BW1ZbWz8XMbqY9KkrE0BJ5h2lu/+2JKY61cr4XVmT/uKSJNc2JiwIX9k+hBKSEc2nbHshxrRNQFV9uHtzXgcIp29PIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXwOrYMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CED8C4CED4;
	Fri, 15 Nov 2024 00:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731630714;
	bh=LdyZfhGLcAffeQWdZ9vyCIw4OGV0nYZirm1HjPWiJ4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXwOrYMgGmyxfYqfFsUZXEUGR0kZH5McM15cOenYsvWgCzwWIyqst8hJYGSbEEfXI
	 IcxiFRB9gAvOgZzAOFIh2IsQ0Kdj/FQBtQzDX5c78qwJU1op3siUY+H83HH4v105yU
	 4CttpV+2lgbYc1CJAv2+WPP+PMicar1U+Md6pZBN+DCWMEyqLHlskMFgXMeEJxMYFo
	 XQrxFx0dWo2Ftq3+XYg1tcAuIe4526kUAkYmabUSVe4qMOfFf8C9f+QYdJtGa5B9AX
	 oJOvYr0Zn1uDbVz5zeH1yEaqtQMZMMsXnGQL808PXmTBBFRr1PLh2g3rQHYepmfYqL
	 XPoeKbekSewSA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/2] selftests: net: test extacks in netlink dumps
Date: Thu, 14 Nov 2024 16:31:50 -0800
Message-ID: <20241115003150.733141-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115003150.733141-1-kuba@kernel.org>
References: <20241115003150.733141-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that extacks in dumps work. The test fills up the receive buffer
to test both the inline dump (as part of sendmsg()) and delayed one
(run during recvmsg()).

Use YNL helpers to parse the messages. We need to add the test to YNL
file to make sure the right include path are used.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/Makefile        |   3 +-
 tools/testing/selftests/net/netlink-dumps.c | 129 ++++++++++++++++++++
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5e86f7a51b43..c427ee32b193 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -78,7 +78,6 @@ TEST_PROGS += test_vxlan_vnifiltering.sh
 TEST_GEN_FILES += io_uring_zerocopy_tx
 TEST_PROGS += io_uring_zerocopy_tx.sh
 TEST_GEN_FILES += bind_bhash
-TEST_GEN_PROGS += netlink-dumps
 TEST_GEN_PROGS += sk_bind_sendto_listen
 TEST_GEN_PROGS += sk_connect_zero_addr
 TEST_GEN_PROGS += sk_so_peek_off
@@ -100,7 +99,7 @@ TEST_PROGS += bpf_offload.py
 
 # YNL files, must be before "include ..lib.mk"
 EXTRA_CLEAN += $(OUTPUT)/libynl.a
-YNL_GEN_FILES := ncdevmem
+YNL_GEN_FILES := ncdevmem netlink-dumps
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 
 TEST_FILES := settings
diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7ee6dcd334df..195febbf6a61 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -12,11 +12,140 @@
 #include <unistd.h>
 
 #include <linux/genetlink.h>
+#include <linux/neighbour.h>
+#include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/mqueue.h>
+#include <linux/rtnetlink.h>
 
 #include "../kselftest_harness.h"
 
+#include <ynl.h>
+
+struct ext_ack {
+	int err;
+
+	__u32 attr_offs;
+	__u32 miss_type;
+	__u32 miss_nest;
+	const char *str;
+};
+
+/* 0: no done, 1: done found, 2: extack found, -1: error */
+static int nl_get_extack(char *buf, size_t n, struct ext_ack *ea)
+{
+	const struct nlmsghdr *nlh;
+	const struct nlattr *attr;
+	ssize_t rem;
+
+	for (rem = n; rem > 0; NLMSG_NEXT(nlh, rem)) {
+		nlh = (struct nlmsghdr *)&buf[n - rem];
+		if (!NLMSG_OK(nlh, rem))
+			return -1;
+
+		if (nlh->nlmsg_type != NLMSG_DONE)
+			continue;
+
+		ea->err = -*(int *)NLMSG_DATA(nlh);
+
+		if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS))
+			return 1;
+
+		ynl_attr_for_each(attr, nlh, sizeof(int)) {
+			switch (ynl_attr_type(attr)) {
+			case NLMSGERR_ATTR_OFFS:
+				ea->attr_offs = ynl_attr_get_u32(attr);
+				break;
+			case NLMSGERR_ATTR_MISS_TYPE:
+				ea->miss_type = ynl_attr_get_u32(attr);
+				break;
+			case NLMSGERR_ATTR_MISS_NEST:
+				ea->miss_nest = ynl_attr_get_u32(attr);
+				break;
+			case NLMSGERR_ATTR_MSG:
+				ea->str = ynl_attr_get_str(attr);
+				break;
+			}
+		}
+
+		return 2;
+	}
+
+	return 0;
+}
+
+static const struct {
+	struct nlmsghdr nlhdr;
+	struct ndmsg ndm;
+	struct nlattr ahdr;
+	__u32 val;
+} dump_neigh_bad = {
+	.nlhdr = {
+		.nlmsg_len	= sizeof(dump_neigh_bad),
+		.nlmsg_type	= RTM_GETNEIGH,
+		.nlmsg_flags	= NLM_F_REQUEST | NLM_F_ACK | NLM_F_DUMP,
+		.nlmsg_seq	= 1,
+	},
+	.ndm = {
+		.ndm_family	= 123,
+	},
+	.ahdr = {
+		.nla_len	= 4 + 4,
+		.nla_type	= NDA_FLAGS_EXT,
+	},
+	.val = -1, // should fail MASK validation
+};
+
+TEST(dump_extack)
+{
+	int netlink_sock;
+	char buf[8192];
+	int one = 1;
+	int i, cnt;
+	ssize_t n;
+
+	netlink_sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	ASSERT_GE(netlink_sock, 0);
+
+	n = setsockopt(netlink_sock, SOL_NETLINK, NETLINK_CAP_ACK,
+		       &one, sizeof(one));
+	ASSERT_EQ(n, 0);
+	n = setsockopt(netlink_sock, SOL_NETLINK, NETLINK_EXT_ACK,
+		       &one, sizeof(one));
+	ASSERT_EQ(n, 0);
+	n = setsockopt(netlink_sock, SOL_NETLINK, NETLINK_GET_STRICT_CHK,
+		       &one, sizeof(one));
+	ASSERT_EQ(n, 0);
+
+	/* Dump so many times we fill up the buffer */
+	cnt = 64;
+	for (i = 0; i < cnt; i++) {
+		n = send(netlink_sock, &dump_neigh_bad,
+			 sizeof(dump_neigh_bad), 0);
+		ASSERT_EQ(n, sizeof(dump_neigh_bad));
+	}
+
+	/* Read out the ENOBUFS */
+	n = recv(netlink_sock, buf, sizeof(buf), MSG_DONTWAIT);
+	EXPECT_EQ(n, -1);
+	EXPECT_EQ(errno, ENOBUFS);
+
+	for (i = 0; i < cnt; i++) {
+		struct ext_ack ea = {};
+
+		n = recv(netlink_sock, buf, sizeof(buf), MSG_DONTWAIT);
+		if (n < 0) {
+			ASSERT_GE(i, 10);
+			break;
+		}
+		ASSERT_GE(n, (ssize_t)sizeof(struct nlmsghdr));
+
+		EXPECT_EQ(nl_get_extack(buf, n, &ea), 2);
+		EXPECT_EQ(ea.attr_offs,
+			  sizeof(struct nlmsghdr) + sizeof(struct ndmsg));
+	}
+}
+
 static const struct {
 	struct nlmsghdr nlhdr;
 	struct genlmsghdr genlhdr;
-- 
2.47.0


