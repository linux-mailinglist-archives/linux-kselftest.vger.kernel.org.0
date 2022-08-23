Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C398C59D25F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 09:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiHWHh7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 03:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbiHWHh6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 03:37:58 -0400
Received: from mailout-taastrup.gigahost.dk (mailout-taastrup.gigahost.dk [46.183.139.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FC9642F8;
        Tue, 23 Aug 2022 00:37:56 -0700 (PDT)
Received: from mailout.gigahost.dk (mailout.gigahost.dk [89.186.169.112])
        by mailout-taastrup.gigahost.dk (Postfix) with ESMTP id B7DBF1884AE4;
        Tue, 23 Aug 2022 07:37:54 +0000 (UTC)
Received: from smtp.gigahost.dk (smtp.gigahost.dk [89.186.169.109])
        by mailout.gigahost.dk (Postfix) with ESMTP id AE68E25032BA;
        Tue, 23 Aug 2022 07:37:54 +0000 (UTC)
Received: by smtp.gigahost.dk (Postfix, from userid 1000)
        id 86C83A1A0060; Tue, 23 Aug 2022 07:37:54 +0000 (UTC)
X-Screener-Id: 413d8c6ce5bf6eab4824d0abaab02863e8e3f662
MIME-Version: 1.0
Date:   Tue, 23 Aug 2022 09:37:54 +0200
From:   netdev@kapio-technology.com
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 net-next 3/6] drivers: net: dsa: add locked fdb entry
 flag to drivers
In-Reply-To: <YwSAtgS7fgHNLMEy@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <ce4266571b2b47ae8d56bd1f790cb82a@kapio-technology.com>
 <YwMW4iGccDu6jpaZ@shredder>
 <c2822d6dd66a1239ff8b7bfd06019008@kapio-technology.com>
 <YwR4MQ2xOMlvKocw@shredder>
 <9dcb4db4a77811308c56fe5b9b7c5257@kapio-technology.com>
 <YwSAtgS7fgHNLMEy@shredder>
User-Agent: Gigahost Webmail
Message-ID: <553c573ad6a2ddfccfc47c7847cc5fb7@kapio-technology.com>
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

On 2022-08-23 09:24, Ido Schimmel wrote:
> On Tue, Aug 23, 2022 at 09:13:54AM +0200, netdev@kapio-technology.com 
> wrote:
>> On 2022-08-23 08:48, Ido Schimmel wrote:
>> > On Mon, Aug 22, 2022 at 09:49:28AM +0200, netdev@kapio-technology.com
>> > wrote:
>> 
>> > > As I am not familiar with roaming in this context, I need to know
>> > > how the SW
>> > > bridge should behave in this case.
>> >
>> 
>> > > In this case, is the roaming only between locked ports or does the
>> > > roaming include that the entry can move to a unlocked port, resulting
>> > > in the locked flag getting removed?
>> >
>> > Any two ports. If the "locked" entry in mv88e6xxx cannot move once
>> > installed, then the "sticky" flag accurately describes it.
>> >
>> 
>> But since I am also doing the SW bridge implementation without 
>> mv88e6xxx I
>> need it to function according to needs.
>> Thus the locked entries created in the bridge I shall not put the 
>> sticky
>> flag on, but there will be the situation where a locked entry can move 
>> to an
>> unlocked port, which we regarded as a bug.
> 
> I do not regard this as a bug. It makes sense to me that an authorized
> port can cause an entry pointing to an unauthorized port to roam to
> itself. Just like normal learned entries. What I considered as a bug is
> the fact that the "locked" flag is not cleared when roaming to an
> authorized port.
> 
>> In that case there is two possibilities, the locked entry can move to
>> an unlocked port with the locked flag being removed or the locked
>> entry can only move to another locked port?
> 
> My suggestion is to allow roaming and maintain / clear the "locked" 
> flag
> based on whether the new destination port is locked or not.

Thus I understand it as saying that the "locked" flag can also be set 
when roaming from an unlocked port to a locked port?
