Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25D65A4C13
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 14:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiH2MkL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 08:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiH2Mjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 08:39:42 -0400
Received: from mailout-taastrup.gigahost.dk (mailout-taastrup.gigahost.dk [46.183.139.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9882ED65;
        Mon, 29 Aug 2022 05:23:38 -0700 (PDT)
Received: from mailout.gigahost.dk (mailout.gigahost.dk [89.186.169.112])
        by mailout-taastrup.gigahost.dk (Postfix) with ESMTP id 38ADC18839D6;
        Mon, 29 Aug 2022 11:09:13 +0000 (UTC)
Received: from smtp.gigahost.dk (smtp.gigahost.dk [89.186.169.109])
        by mailout.gigahost.dk (Postfix) with ESMTP id 137FC25032B8;
        Mon, 29 Aug 2022 11:09:13 +0000 (UTC)
Received: by smtp.gigahost.dk (Postfix, from userid 1000)
        id E69209EC0002; Mon, 29 Aug 2022 11:09:12 +0000 (UTC)
X-Screener-Id: 413d8c6ce5bf6eab4824d0abaab02863e8e3f662
MIME-Version: 1.0
Date:   Mon, 29 Aug 2022 13:09:12 +0200
From:   netdev@kapio-technology.com
To:     Nikolay Aleksandrov <razor@blackwall.org>
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
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yuwei Wang <wangyuweihx@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        bridge@lists.linux-foundation.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 net-next 1/6] net: bridge: add locked entry fdb flag to
 extend locked port feature
In-Reply-To: <e9eb5b72-073a-f182-13b7-37fc53611d5f@blackwall.org>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-2-netdev@kapio-technology.com>
 <e9eb5b72-073a-f182-13b7-37fc53611d5f@blackwall.org>
User-Agent: Gigahost Webmail
Message-ID: <d90a67c5ca6035f7ae75b7bada430e03@kapio-technology.com>
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

> On 2022-08-27 13:30, Nikolay Aleksandrov wrote:

>> @@ -879,6 +888,10 @@ void br_fdb_update(struct net_bridge *br, struct 
>> net_bridge_port *source,
>>  						      &fdb->flags)))
>>  					clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
>>  						  &fdb->flags);
>> +				if (source->flags & BR_PORT_MAB)
>> +					set_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
>> +				else
>> +					clear_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
> Please add a test for that bit and only then change it.
> 

Something like this?

@@ -749,6 +756,12 @@ void br_fdb_update(struct net_bridge *br, struct 
net_bridge_port *source,
                                                       &fdb->flags)))
                                         
clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
                                                   &fdb->flags);
+                               if 
(unlikely(test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags))) {
+                                       if (!(source->flags & 
BR_PORT_MAB))
+                                               
clear_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
+                               } else
+                                       if (source->flags & BR_PORT_MAB)
+                                               
set_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
                         }

                         if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, 
&flags)))


