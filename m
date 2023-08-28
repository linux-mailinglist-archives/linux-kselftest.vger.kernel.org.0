Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45E878B7A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjH1S4H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 14:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjH1S4B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 14:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE8495
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDD1361326
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 18:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E436BC433C7;
        Mon, 28 Aug 2023 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693248958;
        bh=OVwE6mzVIELEbJ5swUj8Zkbx9K7l1rxzi4K+JUditgk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NnVctViIJx1hQTOd+NrDASUW/R2JNf3xPruN08IQFrxs/f1P+TOSNluKLcVNW9fAG
         wkv0zq6UrkizmO+AUB6JYBjCvSm4fZB7bvUr3QJGlXWft5rBhoOdWSEZ/k/KY2heas
         qYI2vcCUbB17gdPLlU2ng7oRmZvF8y/ujTKchRx17j2L/55RepAsypqUsPiCQt9OGc
         gVeXsRvcFx9sYQYiJgcx9p2fwXjUc40XQ1ZkzjhPyprlfiwy3cldh8enD+RIgCQ3jN
         LVGs2pzx8rpFbU5xKsX+KNnUO8MjTGTqFZDsh/2+QuG3YOiWaLgJlR36C9zbhI57U2
         qYbOK/6Srronw==
Message-ID: <ecba2119-2182-16b5-9ad5-25a9b497b0d6@kernel.org>
Date:   Mon, 28 Aug 2023 12:55:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net v3 1/3] ipv4: ignore dst hint for multipath routes
Content-Language: en-US
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-2-sriram.yagnaraman@est.tech>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230828113221.20123-2-sriram.yagnaraman@est.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/28/23 5:32 AM, Sriram Yagnaraman wrote:
> Route hints when the nexthop is part of a multipath group causes packets
> in the same receive batch to be sent to the same nexthop irrespective of
> the multipath hash of the packet. So, do not extract route hint for
> packets whose destination is part of a multipath group.
> 
> A new SKB flag IPSKB_MULTIPATH is introduced for this purpose, set the
> flag when route is looked up in ip_mkroute_input() and use it in
> ip_extract_route_hint() to check for the existence of the flag.
> 
> Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> ---
>  include/net/ip.h    | 1 +
>  net/ipv4/ip_input.c | 3 ++-
>  net/ipv4/route.c    | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

