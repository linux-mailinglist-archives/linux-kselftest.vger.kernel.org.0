Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905FF7CAA2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 15:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjJPNpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 09:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjJPNpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 09:45:39 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85FCD4A;
        Mon, 16 Oct 2023 06:45:34 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 16 Oct 2023 15:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1697463932; bh=NgkBfZvDnp28tB6EIHeiDgFJLnuXeYPOeJIQSM0YMeE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hPiwZJzHDyHwvtw9w3aqRm2XGikiBFzEqbKBz0V43r6/uu5/4J/S14d9BZWyjboIX
         G+OeYavPXwENlHXPSt/1HM5ZcFLoTRjkpox46SxaxlZx4RCs4wHxFRr6TdBJ53xwah
         RIEau2hR8os/+1G2nfCnJSCejFuNp2PSdOpXKhBI=
Received: from localhost (unknown [172.17.88.63])
        by mail-auth.avm.de (Postfix) with ESMTPSA id EB49980A2D;
        Mon, 16 Oct 2023 15:45:31 +0200 (CEST)
From:   Johannes Nixdorf <jnixdorf-oss@avm.de>
Date:   Mon, 16 Oct 2023 15:27:20 +0200
Subject: [PATCH net-next v5 1/5] net: bridge: Set BR_FDB_ADDED_BY_USER
 early in fdb_add_entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-fdb_limit-v5-1-32cddff87758@avm.de>
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
In-Reply-To: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Johannes Nixdorf <jnixdorf-oss@avm.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697462840; l=1476;
 i=jnixdorf-oss@avm.de; s=20230906; h=from:subject:message-id;
 bh=NgkBfZvDnp28tB6EIHeiDgFJLnuXeYPOeJIQSM0YMeE=;
 b=P2CRt2GKCgPCuza2aoXCWsML2X4W2HLuSp+5c1Blm8e6al9ihRSzyw1YQ2TSmaNo4IK/NzDAy
 zXNjq4FN/AGCkUPB6HUXdFIrJyowgO7hwjA9qrATlxO1UWtm/ND3p7T
X-Developer-Key: i=jnixdorf-oss@avm.de; a=ed25519;
 pk=KMraV4q7ANHRrwjf9EVhvU346JsqGGNSbPKeNILOQfo=
X-purgate-ID: 149429::1697463932-D6E320EE-3FD3BFFA/0/0
X-purgate-type: clean
X-purgate-size: 1478
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation of the following fdb limit for dynamically learned entries,
allow fdb_create to detect that the entry was added by the user. This
way it can skip applying the limit in this case.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 net/bridge/br_fdb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e69a872bfc1d..f517ea92132c 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1056,7 +1056,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		fdb = fdb_create(br, source, addr, vid, 0);
+		fdb = fdb_create(br, source, addr, vid,
+				 BIT(BR_FDB_ADDED_BY_USER));
 		if (!fdb)
 			return -ENOMEM;
 
@@ -1069,6 +1070,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 			WRITE_ONCE(fdb->dst, source);
 			modified = true;
 		}
+
+		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 	}
 
 	if (fdb_to_nud(br, fdb) != state) {
@@ -1100,8 +1103,6 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 	if (fdb_handle_notify(fdb, notify))
 		modified = true;
 
-	set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
-
 	fdb->used = jiffies;
 	if (modified) {
 		if (refresh)

-- 
2.42.0

