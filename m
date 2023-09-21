Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300A77AA278
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 23:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjIUVTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 17:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjIUVTE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 17:19:04 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F2A659B;
        Thu, 21 Sep 2023 11:00:03 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Thu, 21 Sep 2023 09:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1695281026; bh=MGHRpPfMK3dwPqFHNJENwclFJsK7s432jc0AWt8qpKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMv+D89SeUIroDzj3vpDvYr7y3M0PoPLmr9tkOthBnQGSLo+hcx1XT9UFQM0hgSlH
         xHaAXKtsZeL6XEjJmPq0Q4wHjoS0ePKH/Wgj4XjyHyUqWm4LTZ6KyEeZ6ykYL7Hb2p
         9EHrhm5VgBl1R5uzbSvyn+aOT7kXqu9MTNT9n8oM=
Received: from localhost (unknown [172.17.88.63])
        by mail-auth.avm.de (Postfix) with ESMTPSA id E88A582147;
        Thu, 21 Sep 2023 09:23:46 +0200 (CEST)
Date:   Thu, 21 Sep 2023 09:23:46 +0200
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
Message-ID: <ZQvvgiz4rE8u6vba@u-jnixdorf.ads.avm.de>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
 <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
X-purgate-ID: 149429::1695281026-306BAD89-D1FD54B6/0/0
X-purgate-type: clean
X-purgate-size: 1728
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

On Wed, Sep 20, 2023 at 01:46:02PM +0300, Nikolay Aleksandrov wrote:
> On 9/19/23 11:12, Johannes Nixdorf wrote:
> > Set any new attributes added to br_policy to be parsed strictly, to
> > prevent userspace from passing garbage.
> > 
> > Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> > ---
> >   net/bridge/br_netlink.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > index 10f0d33d8ccf..505683ef9a26 100644
> > --- a/net/bridge/br_netlink.c
> > +++ b/net/bridge/br_netlink.c
> > @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
> >   }
> >   static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> > +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
> > +				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
> >   	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
> >   	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
> >   	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
> > 
> 
> instead of IFLA_BR_MCAST_QUERIER_STATE + 1, why not move around the patch
> and just use the new attribute name?
> These are uapi, they won't change.

I wanted to avoid having a state between the two commits where the new
attributes are already added, but not yet strictly verified. Otherwise
they would present a slightly different UAPI at that one commit boundary
than after this commit.

This is also not the only place in the kernel where strict_start_type
is specified that way. See e.g. commit c00041cf1cb8 ("net: bridge: Set
strict_start_type at two policies"), even though that seems mostly be
done to turn on strict_start_type preemtively, not in the same series
that adds the new attribute.
