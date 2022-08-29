Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C165A4622
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiH2Jcf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 05:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH2Jcd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 05:32:33 -0400
Received: from mailout-taastrup.gigahost.dk (mailout-taastrup.gigahost.dk [46.183.139.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65405466D;
        Mon, 29 Aug 2022 02:32:31 -0700 (PDT)
Received: from mailout.gigahost.dk (mailout.gigahost.dk [89.186.169.112])
        by mailout-taastrup.gigahost.dk (Postfix) with ESMTP id 22BC1188493F;
        Mon, 29 Aug 2022 09:32:30 +0000 (UTC)
Received: from smtp.gigahost.dk (smtp.gigahost.dk [89.186.169.109])
        by mailout.gigahost.dk (Postfix) with ESMTP id 10FD125032B7;
        Mon, 29 Aug 2022 09:32:30 +0000 (UTC)
Received: by smtp.gigahost.dk (Postfix, from userid 1000)
        id 0C1E59EC0005; Mon, 29 Aug 2022 09:32:30 +0000 (UTC)
X-Screener-Id: 413d8c6ce5bf6eab4824d0abaab02863e8e3f662
MIME-Version: 1.0
Date:   Mon, 29 Aug 2022 11:32:29 +0200
From:   netdev@kapio-technology.com
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yuwei Wang <wangyuweihx@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        bridge@lists.linux-foundation.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 net-next 1/6] net: bridge: add locked entry fdb flag to
 extend locked port feature
In-Reply-To: <Ywo16vHMqxxszWzX@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-2-netdev@kapio-technology.com>
 <Ywo16vHMqxxszWzX@shredder>
User-Agent: Gigahost Webmail
Message-ID: <42392a323bdc5324e1e4682fca378c90@kapio-technology.com>
X-Sender: netdev@kapio-technology.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-08-27 17:19, Ido Schimmel wrote:
> On Fri, Aug 26, 2022 at 01:45:33PM +0200, Hans Schultz wrote:
> How about the below (untested):
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 68b3e850bcb9..9143a94a1c57 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -109,9 +109,18 @@ int br_handle_frame_finish(struct net *net,
> struct sock *sk, struct sk_buff *skb
>                 struct net_bridge_fdb_entry *fdb_src =
>                         br_fdb_find_rcu(br, eth_hdr(skb)->h_source, 
> vid);
> 
> -               if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
> -                   test_bit(BR_FDB_LOCAL, &fdb_src->flags))
> +               if (!fdb_src) {
> +                       if (p->flags & BR_PORT_MAB) {
> +                               __set_bit(BR_FDB_ENTRY_LOCKED, &flags);
> +                               br_fdb_update(br, p, 
> eth_hdr(skb)->h_source,
> +                                             vid, flags);
> +                       }
> +                       goto drop;
> +               } else if (READ_ONCE(fdb_src->dst) != p ||
> +                          test_bit(BR_FDB_LOCAL, &fdb_src->flags) ||
> +                          test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
>                         goto drop;
> +               }
>         }
> 
> The semantics are very clear, IMO. On FDB miss, add a locked FDB entry
> and drop the packet. On FDB mismatch, drop the packet.
> 
> Entry can roam from an unauthorized port to an authorized port, but not
> the other way around. Not sure what is the use case for allowing 
> roaming
> between unauthorized ports.
> 
> Note that with the above, locked entries are not refreshed and will
> therefore age out unless replaced by user space.
> 

Okay I was under the impression that entries should be able to roam 
freely between authorized and unauthorized ports in the bridge as long 
as the locked flag is on when roaming to the MAB enabled port. As you 
know roaming is not a big issue with mv88e6xxx.

As I see this code, an entry cannot roam to an authorized port as there 
is no update after the port mismatch check and the packet is dropped as 
it should in this case in the locked section.

