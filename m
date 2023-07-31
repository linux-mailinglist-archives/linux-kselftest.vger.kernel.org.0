Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF75769FDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 19:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGaR67 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGaR65 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 13:58:57 -0400
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3C210FF;
        Mon, 31 Jul 2023 10:58:54 -0700 (PDT)
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 36VHpZNf005077
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jul 2023 19:51:36 +0200
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net-next 1/2] seg6: add NEXT-C-SID support for SRv6 End.X behavior
Date:   Mon, 31 Jul 2023 19:51:16 +0200
Message-Id: <20230731175117.17376-2-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230731175117.17376-1-andrea.mayer@uniroma2.it>
References: <20230731175117.17376-1-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The NEXT-C-SID mechanism described in [1] offers the possibility of
encoding several SRv6 segments within a single 128 bit SID address. Such
a SID address is called a Compressed SID (C-SID) container. In this way,
the length of the SID List can be drastically reduced.

A SID instantiated with the NEXT-C-SID flavor considers an IPv6 address
logically structured in three main blocks: i) Locator-Block; ii)
Locator-Node Function; iii) Argument.

                        C-SID container
+------------------------------------------------------------------+
|     Locator-Block      |Loc-Node|            Argument            |
|                        |Function|                                |
+------------------------------------------------------------------+
<--------- B -----------> <- NF -> <------------- A --------------->

   (i) The Locator-Block can be any IPv6 prefix available to the provider;

  (ii) The Locator-Node Function represents the node and the function to
       be triggered when a packet is received on the node;

 (iii) The Argument carries the remaining C-SIDs in the current C-SID
       container.

This patch leverages the NEXT-C-SID mechanism previously introduced in the
Linux SRv6 subsystem [2] to support SID compression capabilities in the
SRv6 End.X behavior [3].
An SRv6 End.X behavior with NEXT-C-SID flavor works as an End.X behavior
but it is capable of processing the compressed SID List encoded in C-SID
containers.

An SRv6 End.X behavior with NEXT-C-SID flavor can be configured to support
user-provided Locator-Block and Locator-Node Function lengths. In this
implementation, such lengths must be evenly divisible by 8 (i.e. must be
byte-aligned), otherwise the kernel informs the user about invalid
values with a meaningful error code and message through netlink_ext_ack.

If Locator-Block and/or Locator-Node Function lengths are not provided
by the user during configuration of an SRv6 End.X behavior instance with
NEXT-C-SID flavor, the kernel will choose their default values i.e.,
32-bit Locator-Block and 16-bit Locator-Node Function.

[1] - https://datatracker.ietf.org/doc/html/draft-ietf-spring-srv6-srh-compression
[2] - https://lore.kernel.org/all/20220912171619.16943-1-andrea.mayer@uniroma2.it/
[3] - https://datatracker.ietf.org/doc/html/rfc8986#name-endx-l3-cross-connect

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 108 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 20 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index dd433cc265c8..ea7261872fae 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -109,15 +109,19 @@ struct bpf_lwt_prog {
 #define next_csid_chk_lcnode_fn_bits(flen)		\
 	next_csid_chk_lcblock_bits(flen)
 
+/* flag indicating that flavors are set up for a given End* behavior */
+#define SEG6_F_LOCAL_FLAVORS		SEG6_F_ATTR(SEG6_LOCAL_FLAVORS)
+
 #define SEG6_F_LOCAL_FLV_OP(flvname)	BIT(SEG6_LOCAL_FLV_OP_##flvname)
+#define SEG6_F_LOCAL_FLV_NEXT_CSID	SEG6_F_LOCAL_FLV_OP(NEXT_CSID)
 #define SEG6_F_LOCAL_FLV_PSP		SEG6_F_LOCAL_FLV_OP(PSP)
 
 /* Supported RFC8986 Flavor operations are reported in this bitmask */
 #define SEG6_LOCAL_FLV8986_SUPP_OPS	SEG6_F_LOCAL_FLV_PSP
 
-/* Supported Flavor operations are reported in this bitmask */
-#define SEG6_LOCAL_FLV_SUPP_OPS		(SEG6_F_LOCAL_FLV_OP(NEXT_CSID) | \
+#define SEG6_LOCAL_END_FLV_SUPP_OPS	(SEG6_F_LOCAL_FLV_NEXT_CSID | \
 					 SEG6_LOCAL_FLV8986_SUPP_OPS)
+#define SEG6_LOCAL_END_X_FLV_SUPP_OPS	SEG6_F_LOCAL_FLV_NEXT_CSID
 
 struct seg6_flavors_info {
 	/* Flavor operations */
@@ -411,9 +415,72 @@ static int end_next_csid_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 	return input_action_end_finish(skb, slwt);
 }
 
+static int input_action_end_x_finish(struct sk_buff *skb,
+				     struct seg6_local_lwt *slwt)
+{
+	seg6_lookup_nexthop(skb, &slwt->nh6, 0);
+
+	return dst_input(skb);
+}
+
+static int input_action_end_x_core(struct sk_buff *skb,
+				   struct seg6_local_lwt *slwt)
+{
+	struct ipv6_sr_hdr *srh;
+
+	srh = get_and_validate_srh(skb);
+	if (!srh)
+		goto drop;
+
+	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
+
+	return input_action_end_x_finish(skb, slwt);
+
+drop:
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+static int end_x_next_csid_core(struct sk_buff *skb,
+				struct seg6_local_lwt *slwt)
+{
+	const struct seg6_flavors_info *finfo = &slwt->flv_info;
+	struct in6_addr *daddr = &ipv6_hdr(skb)->daddr;
+
+	if (seg6_next_csid_is_arg_zero(daddr, finfo))
+		return input_action_end_x_core(skb, slwt);
+
+	/* update DA */
+	seg6_next_csid_advance_arg(daddr, finfo);
+
+	return input_action_end_x_finish(skb, slwt);
+}
+
 static bool seg6_next_csid_enabled(__u32 fops)
 {
-	return fops & BIT(SEG6_LOCAL_FLV_OP_NEXT_CSID);
+	return fops & SEG6_F_LOCAL_FLV_NEXT_CSID;
+}
+
+/* Processing of SRv6 End, End.X, and End.T behaviors can be extended through
+ * the flavors framework. These behaviors must report the subset of (flavor)
+ * operations they currently implement. In this way, if a user specifies a
+ * flavor combination that is not supported by a given End* behavior, the
+ * kernel refuses to instantiate the tunnel reporting the error.
+ */
+static int seg6_flv_supp_ops_by_action(int action, __u32 *fops)
+{
+	switch (action) {
+	case SEG6_LOCAL_ACTION_END:
+		*fops = SEG6_LOCAL_END_FLV_SUPP_OPS;
+		break;
+	case SEG6_LOCAL_ACTION_END_X:
+		*fops = SEG6_LOCAL_END_X_FLV_SUPP_OPS;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 
 /* We describe the packet state in relation to the absence/presence of the SRH
@@ -746,21 +813,14 @@ static int input_action_end(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 /* regular endpoint, and forward to specified nexthop */
 static int input_action_end_x(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 {
-	struct ipv6_sr_hdr *srh;
-
-	srh = get_and_validate_srh(skb);
-	if (!srh)
-		goto drop;
-
-	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
-
-	seg6_lookup_nexthop(skb, &slwt->nh6, 0);
+	const struct seg6_flavors_info *finfo = &slwt->flv_info;
+	__u32 fops = finfo->flv_ops;
 
-	return dst_input(skb);
+	/* check for the presence of NEXT-C-SID since it applies first */
+	if (seg6_next_csid_enabled(fops))
+		return end_x_next_csid_core(skb, slwt);
 
-drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	return input_action_end_x_core(skb, slwt);
 }
 
 static int input_action_end_t(struct sk_buff *skb, struct seg6_local_lwt *slwt)
@@ -1404,13 +1464,14 @@ static struct seg6_action_desc seg6_action_table[] = {
 		.action		= SEG6_LOCAL_ACTION_END,
 		.attrs		= 0,
 		.optattrs	= SEG6_F_LOCAL_COUNTERS |
-				  SEG6_F_ATTR(SEG6_LOCAL_FLAVORS),
+				  SEG6_F_LOCAL_FLAVORS,
 		.input		= input_action_end,
 	},
 	{
 		.action		= SEG6_LOCAL_ACTION_END_X,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
-		.optattrs	= SEG6_F_LOCAL_COUNTERS,
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_LOCAL_FLAVORS,
 		.input		= input_action_end_x,
 	},
 	{
@@ -2070,7 +2131,8 @@ static int parse_nla_flavors(struct nlattr **attrs, struct seg6_local_lwt *slwt,
 {
 	struct seg6_flavors_info *finfo = &slwt->flv_info;
 	struct nlattr *tb[SEG6_LOCAL_FLV_MAX + 1];
-	unsigned long fops;
+	int action = slwt->action;
+	__u32 fops, supp_fops = 0;
 	int rc;
 
 	rc = nla_parse_nested_deprecated(tb, SEG6_LOCAL_FLV_MAX,
@@ -2086,7 +2148,8 @@ static int parse_nla_flavors(struct nlattr **attrs, struct seg6_local_lwt *slwt,
 		return -EINVAL;
 
 	fops = nla_get_u32(tb[SEG6_LOCAL_FLV_OPERATION]);
-	if (fops & ~SEG6_LOCAL_FLV_SUPP_OPS) {
+	rc = seg6_flv_supp_ops_by_action(action, &supp_fops);
+	if (rc < 0 || !supp_fops || (fops & ~supp_fops)) {
 		NL_SET_ERR_MSG(extack, "Unsupported Flavor operation(s)");
 		return -EOPNOTSUPP;
 	}
@@ -2618,6 +2681,11 @@ int __init seg6_local_init(void)
 	 */
 	BUILD_BUG_ON(SEG6_LOCAL_MAX + 1 > BITS_PER_TYPE(unsigned long));
 
+	/* Check whether the number of defined flavors exceeds the maximum
+	 * allowed value.
+	 */
+	BUILD_BUG_ON(SEG6_LOCAL_FLV_OP_MAX + 1 > BITS_PER_TYPE(__u32));
+
 	/* If the default NEXT-C-SID Locator-Block/Node Function lengths (in
 	 * bits) have been changed with invalid values, kernel build stops
 	 * here.
-- 
2.20.1

