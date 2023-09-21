Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC357A962E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjIURAJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIURAC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 13:00:02 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CF1BD1;
        Thu, 21 Sep 2023 09:57:09 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Thu, 21 Sep 2023 09:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1695281357; bh=JrvLZ3k9m+n64XkQmbpSU7bQlFJHydepu1VAgRC4fjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMB2AQTpZscNAsuFSRfZScH0ybRFIyIeR53TSy4h86jjz5qDM+IzU+FIw2oL/NPcl
         zhnc8wxUO+ZdzqqQLZ5HFVD3mlxjE1z4ClyazOPfmM3gJPEuiEQScC5o5xl2i2QhPt
         qFtFi76Fs4cMWLI6YWP2dAXrJ9tB8LL8+dqewJFg=
Received: from localhost (unknown [172.17.88.63])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 29320800AA;
        Thu, 21 Sep 2023 09:29:17 +0200 (CEST)
Date:   Thu, 21 Sep 2023 09:29:17 +0200
From:   Johannes Nixdorf <jnixdorf-oss@avm.de>
To:     Nikolay Aleksandrov <razor@blackwall.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/6] net: bridge: Add netlink knobs for
 number / max learned FDB entries
Message-ID: <ZQvwzZrqC7pjaeS1@u-jnixdorf.ads.avm.de>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
 <f5aca33e-693f-9d8d-c45a-41ada00a9f03@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5aca33e-693f-9d8d-c45a-41ada00a9f03@blackwall.org>
X-purgate-ID: 149429::1695281356-9EC789BA-37F48EE5/0/0
X-purgate-type: clean
X-purgate-size: 786
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 01:50:32PM +0300, Nikolay Aleksandrov wrote:
> On 9/19/23 11:12, Johannes Nixdorf wrote:
> > [...]
> > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > index 505683ef9a26..f5d49a05e61b 100644
> > --- a/net/bridge/br_netlink.c
> > +++ b/net/bridge/br_netlink.c
> > @@ -1267,6 +1267,8 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> >   	[IFLA_BR_VLAN_STATS_PER_PORT] = { .type = NLA_U8 },
> >   	[IFLA_BR_MULTI_BOOLOPT] =
> >   		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
> > +	[IFLA_BR_FDB_N_LEARNED] = { .type = NLA_U32 },
> 
> hmm? I thought this one was RO.

You are right. I set this to NLA_REJECT locally for v5 now, analogously
to how IFLA_BRPORT_MCAST_N_GROUPS is specified.

> > [...]
