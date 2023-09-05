Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA37279271F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjIEQHh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354470AbjIELzZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 07:55:25 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD631B7;
        Tue,  5 Sep 2023 04:55:20 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 13:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1693914590; bh=LJulS2PK41xRqIXVFIJDhKz2cjHftcib9uFS9jUkoNI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hmNsuVZhXkEP6JEYy9rESDP5Oi/VLaKuZ6KoL9sPKoT6vLkBJEXMMA2ZLNoAcFWCE
         YIA1aTzardwKQdIWGmUaJTRxJaS4X1webWJlKnq1DiuM3DsDfSgr1yyQwrz9ik1lqS
         M494uUBroXgVsNWfJ3VPhPzTdtQi35T8KPzGIoFk=
Received: from localhost (unknown [172.17.88.63])
        by mail-auth.avm.de (Postfix) with ESMTPSA id A478982160;
        Tue,  5 Sep 2023 13:49:50 +0200 (CEST)
From:   Johannes Nixdorf <jnixdorf-oss@avm.de>
Date:   Tue, 05 Sep 2023 13:47:22 +0200
Subject: [PATCH net-next v3 5/6] net: bridge: Add a configurable default
 FDB learning limit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-fdb_limit-v3-5-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
In-Reply-To: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
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
X-purgate-ID: 149429::1693914590-F0CB498B-0A36A1DE/0/0
X-purgate-type: clean
X-purgate-size: 1575
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

Add a Kconfig option to configure a default FDB learning limit system
wide, so a distributor building a special purpose kernel can limit all
created bridges by default.

The limit is only a soft default setting and overrideable on a per bridge
basis using netlink.

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 net/bridge/Kconfig     | 13 +++++++++++++
 net/bridge/br_device.c |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index 3c8ded7d3e84..c0d9c08088c4 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -84,3 +84,16 @@ config BRIDGE_CFM
 	  Say N to exclude this support and reduce the binary size.
 
 	  If unsure, say N.
+
+config BRIDGE_DEFAULT_FDB_MAX_LEARNED
+	int "Default FDB learning limit"
+	default 0
+	depends on BRIDGE
+	help
+	  Sets a default limit on the number of learned FDB entries on
+	  new bridges. This limit can be overwritten via netlink on a
+	  per bridge basis.
+
+	  The default of 0 disables the limit.
+
+	  If unsure, say 0.
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 9a5ea06236bd..8d4221fc5a6c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -531,6 +531,8 @@ void br_dev_setup(struct net_device *dev)
 	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
 	dev->max_mtu = ETH_MAX_MTU;
 
+	br->fdb_max_learned_entries = CONFIG_BRIDGE_DEFAULT_FDB_MAX_LEARNED;
+
 	br_netfilter_rtable_init(br);
 	br_stp_timer_init(br);
 	br_multicast_init(br);

-- 
2.42.0

