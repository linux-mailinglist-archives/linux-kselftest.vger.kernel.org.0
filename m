Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64E716638
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjE3PIs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjE3PIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 11:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8512D
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 08:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 895116324B
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 15:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42DDC433D2;
        Tue, 30 May 2023 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685459283;
        bh=atU19E5ZqI+mbGrZ/FLjNQbQSHe+ozwX2f3ifK8RkQY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nd1bhVz2U0pD0hGPiOjcSlV2Y2D1hiYdG0UIjMfqW4DZMWlbn5IiGu6tFd25khzt3
         gcdZMosDO+2qYBixXBrSU+DBtR6Shbjk+FjNoiym3nQsX7KuUwybA6gj40apJ+RKl9
         fvZ6gtGnK1Xh19bWnireVarn95pxcxkp1JBWNNS/UxdKUnv2QTtoff+u4n4emS5R7b
         vI75tuYlHqJ/TvZioygfqkXb79DnXvkOW/VMAUgs6y9uzYoWvgkamXP1zGpILeJPxr
         xXKKVfu4YGMEiUxkBG/YkmdNQuoJ/1L5zb0nEHwIHScn8Ba2HU294LJhmWIxNBfhtx
         A7vsuhpepmJ6A==
Message-ID: <eb6a1866-7c71-53c6-241f-0a38a4047f7e@kernel.org>
Date:   Tue, 30 May 2023 09:08:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net-next 3/4] nexthop: Do not return invalid nexthop
 object during multipath selection
Content-Language: en-US
To:     Benjamin Poirier <bpoirier@nvidia.com>, netdev@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ido Schimmel <idosch@nvidia.com>
References: <20230529201914.69828-1-bpoirier@nvidia.com>
 <20230529201914.69828-4-bpoirier@nvidia.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230529201914.69828-4-bpoirier@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/29/23 2:19 PM, Benjamin Poirier wrote:
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index c12acbf39659..ca501ced04fb 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -1186,6 +1186,7 @@ static struct nexthop *nexthop_select_path_fdb(struct nh_group *nhg, int hash)
>  static struct nexthop *nexthop_select_path_hthr(struct nh_group *nhg, int hash)
>  {
>  	struct nexthop *rc = NULL;
> +	bool first = false;
>  	int i;
>  
>  	if (nhg->fdb_nh)
> @@ -1194,20 +1195,24 @@ static struct nexthop *nexthop_select_path_hthr(struct nh_group *nhg, int hash)
>  	for (i = 0; i < nhg->num_nh; ++i) {
>  		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
>  
> -		if (hash > atomic_read(&nhge->hthr.upper_bound))
> -			continue;
> -
>  		/* nexthops always check if it is good and does
>  		 * not rely on a sysctl for this behavior
>  		 */
> -		if (nexthop_is_good_nh(nhge->nh))
> -			return nhge->nh;
> +		if (!nexthop_is_good_nh(nhge->nh))
> +			continue;
>  
> -		if (!rc)
> +		if (!first) {

Setting 'first' and 'rc' are equivalent, so 'first' is not needed. As I
recall it was used in fib_select_multipath before the nexthop
refactoring (eba618abacade) because nhsel == 0 is valid, so the loop
could not rely on it.



>  			rc = nhge->nh;
> +			first = true;
> +		}
> +
> +		if (hash > atomic_read(&nhge->hthr.upper_bound))
> +			continue;
> +
> +		return nhge->nh;
>  	}
>  
> -	return rc;
> +	return rc ? : nhg->nh_entries[0].nh;
>  }
>  
>  static struct nexthop *nexthop_select_path_res(struct nh_group *nhg, int hash)


