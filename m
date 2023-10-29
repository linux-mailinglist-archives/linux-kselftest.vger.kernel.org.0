Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54E57DAFD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 00:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjJ2XAX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Oct 2023 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjJ2W7e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Oct 2023 18:59:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7F810C2;
        Sun, 29 Oct 2023 15:58:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC65C116B3;
        Sun, 29 Oct 2023 22:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620332;
        bh=QwfpkMu8hEX1oGwTIu/sT+qOKjgyXtxLOPnbP6puEvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugz4oPdd4SoLnTjPJ1JUDqagq3GL7YUeH7AgrHGvLOVWd8YSFatwufjWs1pBbsDwR
         JEbykFG0KHP7oEma8jbOs0AE3u6B99llNHwIt3zBJ2ztRjpxu7URieTrDXtoqWAKTe
         M1HCldPpV4T21bRTTCGx6Ls9uzfLf0xZRcqNpuyxov6YEM2DBqfsY10Lexi/E2loib
         KCGA+Zs5eStQ+4mGxyLh16HQ/LwewIm9K9BdYolhLTNkoFCb+FOUHPaUxYuR8O+4rk
         kcgznITlAZLu9sw0vTzCmdVF6HICbuTxe4Uy3lkvU3+kGNnk+SuHs2JGq6zvrwiN/v
         t17QV4jqlk9Sw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Phil Sutter <phil@nwl.cc>, Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>, pablo@netfilter.org,
        kadlec@netfilter.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 35/39] netfilter: nf_tables: audit log object reset once per table
Date:   Sun, 29 Oct 2023 18:57:07 -0400
Message-ID: <20231029225740.790936-35-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 1baf0152f7707c6c7e4ea815dcc1f431c0e603f9 ]

When resetting multiple objects at once (via dump request), emit a log
message per table (or filled skb) and resurrect the 'entries' parameter
to contain the number of objects being logged for.

To test the skb exhaustion path, perform some bulk counter and quota
adds in the kselftest.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Acked-by: Paul Moore <paul@paul-moore.com> (Audit)
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c                 | 50 +++++++++++--------
 .../testing/selftests/netfilter/nft_audit.sh  | 46 +++++++++++++++++
 2 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 5e3dbe2652dbd..5c783199b4999 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7324,6 +7324,16 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 	return -1;
 }
 
+static void audit_log_obj_reset(const struct nft_table *table,
+				unsigned int base_seq, unsigned int nentries)
+{
+	char *buf = kasprintf(GFP_ATOMIC, "%s:%u", table->name, base_seq);
+
+	audit_log_nfcfg(buf, table->family, nentries,
+			AUDIT_NFT_OP_OBJ_RESET, GFP_ATOMIC);
+	kfree(buf);
+}
+
 struct nft_obj_filter {
 	char		*table;
 	u32		type;
@@ -7338,8 +7348,10 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 	struct nftables_pernet *nft_net;
+	unsigned int entries = 0;
 	struct nft_object *obj;
 	bool reset = false;
+	int rc = 0;
 
 	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETOBJ_RESET)
 		reset = true;
@@ -7352,6 +7364,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
+		entries = 0;
 		list_for_each_entry_rcu(obj, &table->objects, list) {
 			if (!nft_is_active(net, obj))
 				goto cont;
@@ -7367,34 +7380,27 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 			    filter->type != NFT_OBJECT_UNSPEC &&
 			    obj->ops->type->type != filter->type)
 				goto cont;
-			if (reset) {
-				char *buf = kasprintf(GFP_ATOMIC,
-						      "%s:%u",
-						      table->name,
-						      nft_net->base_seq);
-
-				audit_log_nfcfg(buf,
-						family,
-						obj->handle,
-						AUDIT_NFT_OP_OBJ_RESET,
-						GFP_ATOMIC);
-				kfree(buf);
-			}
 
-			if (nf_tables_fill_obj_info(skb, net, NETLINK_CB(cb->skb).portid,
-						    cb->nlh->nlmsg_seq,
-						    NFT_MSG_NEWOBJ,
-						    NLM_F_MULTI | NLM_F_APPEND,
-						    table->family, table,
-						    obj, reset) < 0)
-				goto done;
+			rc = nf_tables_fill_obj_info(skb, net,
+						     NETLINK_CB(cb->skb).portid,
+						     cb->nlh->nlmsg_seq,
+						     NFT_MSG_NEWOBJ,
+						     NLM_F_MULTI | NLM_F_APPEND,
+						     table->family, table,
+						     obj, reset);
+			if (rc < 0)
+				break;
 
+			entries++;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 cont:
 			idx++;
 		}
+		if (reset && entries)
+			audit_log_obj_reset(table, nft_net->base_seq, entries);
+		if (rc < 0)
+			break;
 	}
-done:
 	rcu_read_unlock();
 
 	cb->args[0] = idx;
@@ -7499,7 +7505,7 @@ static int nf_tables_getobj(struct sk_buff *skb, const struct nfnl_info *info,
 
 		audit_log_nfcfg(buf,
 				family,
-				obj->handle,
+				1,
 				AUDIT_NFT_OP_OBJ_RESET,
 				GFP_ATOMIC);
 		kfree(buf);
diff --git a/tools/testing/selftests/netfilter/nft_audit.sh b/tools/testing/selftests/netfilter/nft_audit.sh
index bb34329e02a7f..e94a80859bbdb 100755
--- a/tools/testing/selftests/netfilter/nft_audit.sh
+++ b/tools/testing/selftests/netfilter/nft_audit.sh
@@ -93,6 +93,12 @@ do_test 'nft add counter t1 c1' \
 do_test 'nft add counter t2 c1; add counter t2 c2' \
 'table=t2 family=2 entries=2 op=nft_register_obj'
 
+for ((i = 3; i <= 500; i++)); do
+	echo "add counter t2 c$i"
+done >$rulefile
+do_test "nft -f $rulefile" \
+'table=t2 family=2 entries=498 op=nft_register_obj'
+
 # adding/updating quotas
 
 do_test 'nft add quota t1 q1 { 10 bytes }' \
@@ -101,6 +107,12 @@ do_test 'nft add quota t1 q1 { 10 bytes }' \
 do_test 'nft add quota t2 q1 { 10 bytes }; add quota t2 q2 { 10 bytes }' \
 'table=t2 family=2 entries=2 op=nft_register_obj'
 
+for ((i = 3; i <= 500; i++)); do
+	echo "add quota t2 q$i { 10 bytes }"
+done >$rulefile
+do_test "nft -f $rulefile" \
+'table=t2 family=2 entries=498 op=nft_register_obj'
+
 # changing the quota value triggers obj update path
 do_test 'nft add quota t1 q1 { 20 bytes }' \
 'table=t1 family=2 entries=1 op=nft_register_obj'
@@ -150,6 +162,40 @@ done
 do_test 'nft reset set t1 s' \
 'table=t1 family=2 entries=3 op=nft_reset_setelem'
 
+# resetting counters
+
+do_test 'nft reset counter t1 c1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset counters t1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset counters t2' \
+'table=t2 family=2 entries=342 op=nft_reset_obj
+table=t2 family=2 entries=158 op=nft_reset_obj'
+
+do_test 'nft reset counters' \
+'table=t1 family=2 entries=1 op=nft_reset_obj
+table=t2 family=2 entries=341 op=nft_reset_obj
+table=t2 family=2 entries=159 op=nft_reset_obj'
+
+# resetting quotas
+
+do_test 'nft reset quota t1 q1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset quotas t1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset quotas t2' \
+'table=t2 family=2 entries=315 op=nft_reset_obj
+table=t2 family=2 entries=185 op=nft_reset_obj'
+
+do_test 'nft reset quotas' \
+'table=t1 family=2 entries=1 op=nft_reset_obj
+table=t2 family=2 entries=314 op=nft_reset_obj
+table=t2 family=2 entries=186 op=nft_reset_obj'
+
 # deleting rules
 
 readarray -t handles < <(nft -a list chain t1 c1 | \
-- 
2.42.0

