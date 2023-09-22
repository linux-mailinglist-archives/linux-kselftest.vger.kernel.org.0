Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8027AB1FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 14:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjIVMSs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjIVMSr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 08:18:47 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D699;
        Fri, 22 Sep 2023 05:18:39 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri, 22 Sep 2023 14:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1695385116; bh=MB5t/v3/1POR6o/v9qEGKwe4oDvbnw1fKTLa0smSnIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgkpCoMm9gpKNSJoMOa4nsPLy54Kenxk7W7YPcWMVxYStCJi3GNg2nIbT64NRTGTs
         kqpIJLNeQlVB1YFRVp3sBHEaWzbJ4DXffxixagYWCI7+OKjAl3zH6MEcLaInukRNIu
         cUghr0zYKg7+jF6xmY2tfsGW2riOpKp+BuuKuHDs=
Received: from localhost (unknown [172.17.88.63])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 4365D804E8;
        Fri, 22 Sep 2023 14:18:37 +0200 (CEST)
Date:   Fri, 22 Sep 2023 14:18:37 +0200
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
Subject: Re: [PATCH net-next v4 2/6] net: bridge: Set strict_start_type for
 br_policy
Message-ID: <ZQ2GHS2r1W77iE50@u-jnixdorf.ads.avm.de>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
 <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
 <ZQvvgiz4rE8u6vba@u-jnixdorf.ads.avm.de>
 <ab1130bb-38ce-1804-7981-6a4532d6ff7b@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1130bb-38ce-1804-7981-6a4532d6ff7b@blackwall.org>
X-purgate-ID: 149429::1695385116-BF7ECD89-F100B9A2/0/0
X-purgate-type: clean
X-purgate-size: 2206
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

On Thu, Sep 21, 2023 at 01:14:43PM +0300, Nikolay Aleksandrov wrote:
> On 9/21/23 10:23, Johannes Nixdorf wrote:
> > On Wed, Sep 20, 2023 at 01:46:02PM +0300, Nikolay Aleksandrov wrote:
> > > On 9/19/23 11:12, Johannes Nixdorf wrote:
> > > > Set any new attributes added to br_policy to be parsed strictly, to
> > > > prevent userspace from passing garbage.
> > > > 
> > > > Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> > > > ---
> > > >    net/bridge/br_netlink.c | 2 ++
> > > >    1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > > > index 10f0d33d8ccf..505683ef9a26 100644
> > > > --- a/net/bridge/br_netlink.c
> > > > +++ b/net/bridge/br_netlink.c
> > > > @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
> > > >    }
> > > >    static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> > > > +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
> > > > +				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
> > > >    	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
> > > >    	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
> > > >    	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
> > > > 
> > > 
> > > instead of IFLA_BR_MCAST_QUERIER_STATE + 1, why not move around the patch
> > > and just use the new attribute name?
> > > These are uapi, they won't change.
> > 
> > I wanted to avoid having a state between the two commits where the new
> > attributes are already added, but not yet strictly verified. Otherwise
> > they would present a slightly different UAPI at that one commit boundary
> > than after this commit.
> > 
> 
> That's not really a problem, the attribute is the same.
> 
> > This is also not the only place in the kernel where strict_start_type
> > is specified that way. See e.g. commit c00041cf1cb8 ("net: bridge: Set
> > strict_start_type at two policies"), even though that seems mostly be
> > done to turn on strict_start_type preemtively, not in the same series
> > that adds the new attribute.
> 
> Please, just use the new attribute to be more explicit where the strict
> parsing starts.

Ok. I've changed it locally for v5.
