Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6875F56B561
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiGHJ1S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiGHJ1S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 05:27:18 -0400
Received: from mailout-taastrup.gigahost.dk (mailout-taastrup.gigahost.dk [46.183.139.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4573D134;
        Fri,  8 Jul 2022 02:27:16 -0700 (PDT)
Received: from mailout.gigahost.dk (mailout.gigahost.dk [89.186.169.112])
        by mailout-taastrup.gigahost.dk (Postfix) with ESMTP id 5D9F318873BF;
        Fri,  8 Jul 2022 09:27:15 +0000 (UTC)
Received: from smtp.gigahost.dk (smtp.gigahost.dk [89.186.169.109])
        by mailout.gigahost.dk (Postfix) with ESMTP id 58FFA25032B7;
        Fri,  8 Jul 2022 09:27:15 +0000 (UTC)
Received: by smtp.gigahost.dk (Postfix, from userid 1000)
        id 4A736A1E00B5; Fri,  8 Jul 2022 09:27:15 +0000 (UTC)
X-Screener-Id: 413d8c6ce5bf6eab4824d0abaab02863e8e3f662
MIME-Version: 1.0
Date:   Fri, 08 Jul 2022 11:27:15 +0200
From:   netdev@kapio-technology.com
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
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
        Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 net-next 3/6] drivers: net: dsa: add locked fdb entry
 flag to drivers
In-Reply-To: <20220708091550.2qcu3tyqkhgiudjg@skbuf>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-4-netdev@kapio-technology.com>
 <20220708084904.33otb6x256huddps@skbuf>
 <e6f418705e19df370c8d644993aa9a6f@kapio-technology.com>
 <20220708091550.2qcu3tyqkhgiudjg@skbuf>
User-Agent: Gigahost Webmail
Message-ID: <463ead20c286688abc9800e487558a3b@kapio-technology.com>
X-Sender: netdev@kapio-technology.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-07-08 11:15, Vladimir Oltean wrote:

> 
> Well, yes, but if I'm correct, the bridge right now can't create locked
> FDB entries, so is_locked will always be false in the ADD_TO_DEVICE
> direction.

The bridge can create locked FDB entries with this patch set. That is 
part of the idea that a SW bridge will have the same features as the HW 
version, so first I made it in the bridge.

> 
> When the possibility for it to be true will exist, _all_ switchdev
> drivers will need to be updated to ignore that (mlxsw, cpss, ocelot,
> rocker, prestera, etc etc), not just DSA. And you don't need to
> propagate the is_locked flag to all individual DSA sub-drivers when 
> none
> care about is_locked in the ADD_TO_DEVICE direction, you can just 
> ignore
> within DSA until needed otherwise.
> 

