Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F557CAA25
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 15:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjJPNpl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 09:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjJPNpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 09:45:39 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E924E6;
        Mon, 16 Oct 2023 06:45:34 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 16 Oct 2023 15:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1697463932; bh=WMHTWn0lzdZOJlUHydcATxCX7rNJUapqeqgSH/9Czxc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aeSwQC4kNzxsKoVOEG24z2ghHtJ3HcnBKZrokW+L7E3garrMeBmAaHW0ixzYTQ/lE
         pV0J6WcMnwfol76rJY1C47I1AdKiJOBDA5FwOVLkj8pATgyGG5373IwTw2FSrCdL6j
         kmweacdVj+P41M/V6VXK6NtRVkkopnmuD3Jrk99o=
Received: from localhost (unknown [172.17.88.63])
        by mail-auth.avm.de (Postfix) with ESMTPSA id AF9DD80463;
        Mon, 16 Oct 2023 15:45:32 +0200 (CEST)
From:   Johannes Nixdorf <jnixdorf-oss@avm.de>
Date:   Mon, 16 Oct 2023 15:27:23 +0200
Subject: [PATCH net-next v5 4/5] net: bridge: Set strict_start_type for
 br_policy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697462840; l=807;
 i=jnixdorf-oss@avm.de; s=20230906; h=from:subject:message-id;
 bh=WMHTWn0lzdZOJlUHydcATxCX7rNJUapqeqgSH/9Czxc=;
 b=T9u4sURSiCaNXZzQHRNZ49OmpzQLzcXSoa6jHXmSuSN0/chz3AUafsFqnGeMtjqfpjU1IKBto
 kNwPnMrNUWBAz5qDbdRWI/24/WcYh5FRu+O3YKuAn/J2A5e2+QRFySb
X-Developer-Key: i=jnixdorf-oss@avm.de; a=ed25519;
 pk=KMraV4q7ANHRrwjf9EVhvU346JsqGGNSbPKeNILOQfo=
X-purgate-ID: 149429::1697463932-6162842D-5BCF9E75/0/0
X-purgate-type: clean
X-purgate-size: 809
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

Set any new attributes added to br_policy to be parsed strictly, to
prevent userspace from passing garbage.

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 net/bridge/br_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 0c3cf6e6dea2..5ad4abfcb7ba 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
 }
 
 static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
+	[IFLA_BR_UNSPEC]	= { .strict_start_type =
+				    IFLA_BR_FDB_N_LEARNED },
 	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
 	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
 	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },

-- 
2.42.0

