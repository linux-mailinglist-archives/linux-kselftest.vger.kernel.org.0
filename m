Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F578B7A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjH1S4i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjH1S4S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 14:56:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2C1A6
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42B8628B7
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 18:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44D8C433C7;
        Mon, 28 Aug 2023 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693248974;
        bh=JwnLAkbhxcncGRnCHwKRB/NFxSy61OM35yNq0/gtTq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eAfVMhl1yaJIMzTZyoyw5uIEji7gz6SNMm6rtc8RFfNMAku2WhZ1+S8atkZ9JzlcO
         Owe4Ql58KjLQUSyQUa94Un6n43Lkrz0kx6xPZuj2bJOZLulg5KF8HkcO8iKK1//d/w
         9JDd97DPV0vFnwQCFeUyy6y116rJP/kQMcjbpmHeU21AWp95m/G1gwLf5eS4x85yUz
         KEz/ZtXhebZdmWV/FyhH1VSVw1oHAhsvZKENrOO7sLdfcTUtiF2BKmw60tt5g7dMln
         YRy2+L/OigoEUVYwajHltuNMmzyN0tWX33a7EjF6fFLgRrPsbdn4OluNhAzV1I5to4
         yi+w62tJQxn8A==
Message-ID: <bf01b809-b4ee-9d8c-711e-9b7324662e67@kernel.org>
Date:   Mon, 28 Aug 2023 12:56:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net v3 2/3] ipv6: ignore dst hint for multipath routes
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
 <20230828113221.20123-3-sriram.yagnaraman@est.tech>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230828113221.20123-3-sriram.yagnaraman@est.tech>
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
> A new SKB flag IP6SKB_MULTIPATH is introduced for this purpose, set the
> flag when route is looked up in fib6_select_path() and use it in
> ip6_can_use_hint() to check for the existence of the flag.
> 
> Fixes: 197dbf24e360 ("ipv6: introduce and uses route look hints for list input.")
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> ---
>  include/linux/ipv6.h | 1 +
>  net/ipv6/ip6_input.c | 3 ++-
>  net/ipv6/route.c     | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

