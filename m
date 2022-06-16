Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9204254DE79
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 11:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358706AbiFPJxq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 05:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFPJxp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 05:53:45 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3A425AEFC;
        Thu, 16 Jun 2022 02:53:44 -0700 (PDT)
Date:   Thu, 16 Jun 2022 11:53:41 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jie2x Zhou <jie2x.zhou@intel.com>
Cc:     shuah@kernel.org, sbrivio@redhat.com, liuhangbin@gmail.com,
        fw@strlen.de, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] selftests: netfilter: correct PKTGEN_SCRIPT_PATHS in
 nft_concat_range.sh
Message-ID: <Yqr9pQ9QsVaGjNW/@salvia>
References: <20220616074046.49349-1-jie2x.zhou@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220616074046.49349-1-jie2x.zhou@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cc'ing netfilter-devel and Stefano Brivio.

On Thu, Jun 16, 2022 at 03:40:46PM +0800, Jie2x Zhou wrote:
> Before change:
> make -C netfilter
>  TEST: performance
>    net,port                                                      [SKIP]
>    perf not supported
>    port,net                                                      [SKIP]
>    perf not supported
>    net6,port                                                     [SKIP]
>    perf not supported
>    port,proto                                                    [SKIP]
>    perf not supported
>    net6,port,mac                                                 [SKIP]
>    perf not supported
>    net6,port,mac,proto                                           [SKIP]
>    perf not supported
>    net,mac                                                       [SKIP]
>    perf not supported
> 
> After change:
>    net,mac                                                       [ OK ]
>      baseline (drop from netdev hook):               2061098pps
>      baseline hash (non-ranged entries):             1606741pps
>      baseline rbtree (match on first field only):    1191607pps
>      set with  1000 full, ranged entries:            1639119pps
> ok 8 selftests: netfilter: nft_concat_range.sh
> 
> Fixes: 611973c1e06f ("selftests: netfilter: Introduce tests for sets with range concatenation")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jie2x Zhou <jie2x.zhou@intel.com>
> ---
>  tools/testing/selftests/netfilter/nft_concat_range.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/netfilter/nft_concat_range.sh b/tools/testing/selftests/netfilter/nft_concat_range.sh
> index b35010cc7f6a..a6991877e50c 100755
> --- a/tools/testing/selftests/netfilter/nft_concat_range.sh
> +++ b/tools/testing/selftests/netfilter/nft_concat_range.sh
> @@ -31,7 +31,7 @@ BUGS="flush_remove_add reload"
>  
>  # List of possible paths to pktgen script from kernel tree for performance tests
>  PKTGEN_SCRIPT_PATHS="
> -	../../../samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh
> +	../../../../samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh
>  	pktgen/pktgen_bench_xmit_mode_netif_receive.sh"
>  
>  # Definition of set types:
> -- 
> 2.34.1
> 
