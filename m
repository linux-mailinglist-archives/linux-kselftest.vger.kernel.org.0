Return-Path: <linux-kselftest+bounces-4126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C1484972C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 11:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7226B26E90
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4112E6F;
	Mon,  5 Feb 2024 10:00:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127215; cv=none; b=ryj18xpNY2ASbtuUPN5863JB0INg6ThJvZbpV4QsIkjdx0ZQdSnKBsjhgURGViBAIhDKHsRZJ2taxEGjWx+KovXfr7kEh1Kvpbqq/U6jQhKxYxRoODhcA7Qnsl0J70yBBSGFpXVd0Cpb9FiCHzBtaOobJ6k3kFvXvt34zV6XqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127215; c=relaxed/simple;
	bh=dYKCZabY3lFmUYHQsfVCFzbThGdD+DrjIGV2B0xJVoc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=erudUX48MQyreTyGWfz3VbJyHTDO686igjc8Qt5JerIkJGOTzKF5CGRM/U83ujsvDey3Sm8BzRq2whcBsW7F4WUNsS+vhv2o2/VQ/ujfcS/T4TJ1ZF98l1OUEX9lr/qdIm9WuDRruOfzFwnm2loaI8crj6o1C3zomrHZWH0eME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.19
Received: from mail22.mail.schwarz (mail22.mail.schwarz [185.124.192.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1497;
	Mon,  5 Feb 2024 02:00:08 -0800 (PST)
X-SCHWARZ-TO: coreteam@netfilter.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net, kadlec@netfilter.org, i.maximets@ovn.org,
 netfilter-devel@vger.kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 edumazet@google.com, pablo@netfilter.org, linux-kselftest@vger.kernel.org,
 horms@ovn.org, shuah@kernel.org
X-SCHWARZ-ENVELOPEFROM: felix.huettner@mail.schwarz
Received: from felix.runs.onstackit.cloud ([45.129.43.133])
  by mail22.mail.schwarz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:00:00 +0000
Date: Mon, 5 Feb 2024 09:59:59 +0000
From: Felix Huettner <felix.huettner@mail.schwarz>
To: pablo@netfilter.org, i.maximets@ovn.org
Cc: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
	fw@strlen.de, horms@ovn.org, kadlec@netfilter.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	luca.czesla@mail.schwarz, max.lamprecht@mail.schwarz,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	pabeni@redhat.com, shuah@kernel.org
Subject: [PATCH net] net: ctnetlink: fix filtering for zone 0
Message-ID: <ZcCxn9HDsB8DUPrI@felix.runs.onstackit.cloud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

previously filtering for the default zone would actually skip the zone
filter and flush all zones.

Fixes: eff3c558bb7e ("netfilter: ctnetlink: support filtering by zone")
Reported-by: Ilya Maximets <i.maximets@ovn.org>
Closes: https://lore.kernel.org/netdev/2032238f-31ac-4106-8f22-522e76df5a12@ovn.org/
Signed-off-by: Felix Huettner <felix.huettner@mail.schwarz>
---
 net/netfilter/nf_conntrack_netlink.c          | 12 ++++--
 .../netfilter/conntrack_dump_flush.c          | 43 ++++++++++++++++++-
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 0c22a02c2035..3b846cbdc050 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -876,6 +876,7 @@ struct ctnetlink_filter_u32 {
 
 struct ctnetlink_filter {
 	u8 family;
+	bool zone_filter;
 
 	u_int32_t orig_flags;
 	u_int32_t reply_flags;
@@ -992,9 +993,12 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 	if (err)
 		goto err_filter;
 
-	err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
-	if (err < 0)
-		goto err_filter;
+	if (cda[CTA_ZONE]) {
+		err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
+		if (err < 0)
+			goto err_filter;
+		filter->zone_filter = true;
+	}
 
 	if (!cda[CTA_FILTER])
 		return filter;
@@ -1148,7 +1152,7 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
 	if (filter->family && nf_ct_l3num(ct) != filter->family)
 		goto ignore_entry;
 
-	if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
+	if (filter->zone_filter &&
 	    !nf_ct_zone_equal_any(ct, &filter->zone))
 		goto ignore_entry;
 
diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
index f18c6db13bbf..b11ea8ee6719 100644
--- a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -13,7 +13,7 @@
 #include "../kselftest_harness.h"
 
 #define TEST_ZONE_ID 123
-#define CTA_FILTER_F_CTA_TUPLE_ZONE (1 << 2)
+#define NF_CT_DEFAULT_ZONE_ID 0
 
 static int reply_counter;
 
@@ -336,6 +336,9 @@ FIXTURE_SETUP(conntrack_dump_flush)
 	ret = conntrack_data_generate_v4(self->sock, 0xf4f4f4f4, 0xf5f5f5f5,
 					 TEST_ZONE_ID + 2);
 	EXPECT_EQ(ret, 0);
+	ret = conntrack_data_generate_v4(self->sock, 0xf6f6f6f6, 0xf7f7f7f7,
+					 NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
 
 	src = (struct in6_addr) {{
 		.__u6_addr32 = {
@@ -395,6 +398,26 @@ FIXTURE_SETUP(conntrack_dump_flush)
 					 TEST_ZONE_ID + 2);
 	EXPECT_EQ(ret, 0);
 
+	src = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x07000000
+		}
+	}};
+	dst = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x08000000
+		}
+	}};
+	ret = conntrack_data_generate_v6(self->sock, src, dst,
+					 NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+
 	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
 	EXPECT_GE(ret, 2);
 	if (ret > 2)
@@ -425,6 +448,24 @@ TEST_F(conntrack_dump_flush, test_flush_by_zone)
 	EXPECT_EQ(ret, 2);
 	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 2);
 	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 2);
+}
+
+TEST_F(conntrack_dump_flush, test_flush_by_zone_default)
+{
+	int ret;
+
+	ret = conntrack_flush_zone(self->sock, NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 1);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 2);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
 }
 
 TEST_HARNESS_MAIN

base-commit: eef00a82c568944f113f2de738156ac591bbd5cd
-- 
2.43.0


