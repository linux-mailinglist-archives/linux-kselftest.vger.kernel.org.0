Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6275B24A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 17:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjGTPS3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjGTPSX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 11:18:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F4A26B5;
        Thu, 20 Jul 2023 08:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F182661B4C;
        Thu, 20 Jul 2023 15:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE618C433CA;
        Thu, 20 Jul 2023 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866298;
        bh=sa++SOpu0OOLby+nKZrbEuQPjr0iW/gaMnyzIgw8AIU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DXSLZmG9sH0SlU10hMwLPvpQ57q5vtc5mk3AOtculg3jPG/bzaG/46wihnNLqpBMY
         yIxcbT7DTFFZDQOfrHs48EqyD+YFZbAGdxgkLCqj+8CMxTBt3HQ++0NhH7u0iTVTx9
         x9NsVsjIEjoWKrgfh7HYIk/yjxAiADzoiff2n14ynez7axrZy1+OeL0bK/ZlHPv1in
         SUeHNo0McwOMg4p70PH1whla7mm4AVI8Fnsor4TXJYlo4AK5+fbA0gSA5g5JNf7dzL
         +98fyTCfeFq3OBJ+yj2bWcRfYyfQFTsn75Eu4WrGrp7Bh5nFmFeod55CvzgTXrmpWP
         rlxluoJWrdcyA==
Message-ID: <dae3fc04-5e59-dff5-db77-ea7d0a3d154e@kernel.org>
Date:   Thu, 20 Jul 2023 09:18:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 3/4] nexthop: Do not return invalid nexthop
 object during multipath selection
Content-Language: en-US
To:     Benjamin Poirier <bpoirier@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ido Schimmel <idosch@nvidia.com>
References: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
 <20230719-nh_select-v2-3-04383e89f868@nvidia.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230719-nh_select-v2-3-04383e89f868@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/19/23 7:57 AM, Benjamin Poirier wrote:
> With legacy nexthops, when net.ipv4.fib_multipath_use_neigh is set,
> fib_select_multipath() will never set res->nhc to a nexthop that is not
> good (as per fib_good_nh()). OTOH, with nexthop objects,
> nexthop_select_path_hthr() may return a nexthop that failed the
> nexthop_is_good_nh() test even if there was one that passed. Refactor
> nexthop_select_path_hthr() to follow a selection logic more similar to
> fib_select_multipath().
> 
> The issue can be demonstrated with the following sequence of commands. The
> first block shows that things work as expected with legacy nexthops. The
> last sequence of `ip rou get` in the second block shows the problem case -
> some routes still use the .2 nexthop.
> 
> sysctl net.ipv4.fib_multipath_use_neigh=1
> ip link add dummy1 up type dummy
> ip rou add 198.51.100.0/24 nexthop via 192.0.2.1 dev dummy1 onlink nexthop via 192.0.2.2 dev dummy1 onlink
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip neigh add 192.0.2.1 dev dummy1 nud failed
> echo ".1 failed:"  # results should not use .1
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip neigh del 192.0.2.1 dev dummy1
> ip neigh add 192.0.2.2 dev dummy1 nud failed
> echo ".2 failed:"  # results should not use .2
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip link del dummy1
> 
> ip link add dummy1 up type dummy
> ip nexthop add id 1 via 192.0.2.1 dev dummy1 onlink
> ip nexthop add id 2 via 192.0.2.2 dev dummy1 onlink
> ip nexthop add id 1001 group 1/2
> ip rou add 198.51.100.0/24 nhid 1001
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip neigh add 192.0.2.1 dev dummy1 nud failed
> echo ".1 failed:"  # results should not use .1
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip neigh del 192.0.2.1 dev dummy1
> ip neigh add 192.0.2.2 dev dummy1 nud failed
> echo ".2 failed:"  # results should not use .2
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip link del dummy1
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


