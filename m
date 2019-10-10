Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46DD268D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbfJJJmU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 05:42:20 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:43010 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfJJJmU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 05:42:20 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1D02725B7E8;
        Thu, 10 Oct 2019 20:42:18 +1100 (AEDT)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 245009405EE; Thu, 10 Oct 2019 11:42:16 +0200 (CEST)
Date:   Thu, 10 Oct 2019 11:42:16 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] selftests: netfilter: add ipvs test script
Message-ID: <20191010094215.73rlcbn2tt4wgr54@verge.net.au>
References: <1570619790-6086-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <1570619790-6086-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570619790-6086-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 09, 2019 at 07:16:28PM +0800, Haishuang Yan wrote:
> Test virutal server via directing routing for IPv4.
> 
> Tested:
> 
> # selftests: netfilter: ipvs.sh
> # Testing DR mode...
> # ipvs.sh: PASS
> ok 6 selftests: netfilter: ipvs.sh
> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---
> v5: use cmp to compare two file contents suggested by Simon Horman
> v4: use #!/bin/bash -p suggested by Duncan Roe
> v3: use bash style
> v2: optimize test script
> ---
>  tools/testing/selftests/netfilter/Makefile |   2 +-
>  tools/testing/selftests/netfilter/ipvs.sh  | 178 +++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/netfilter/ipvs.sh
> 
> diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
> index 4144984..de1032b 100644
> --- a/tools/testing/selftests/netfilter/Makefile
> +++ b/tools/testing/selftests/netfilter/Makefile
> @@ -2,6 +2,6 @@
>  # Makefile for netfilter selftests
>  
>  TEST_PROGS := nft_trans_stress.sh nft_nat.sh bridge_brouter.sh \
> -	conntrack_icmp_related.sh nft_flowtable.sh
> +	conntrack_icmp_related.sh nft_flowtable.sh ipvs.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/netfilter/ipvs.sh b/tools/testing/selftests/netfilter/ipvs.sh
> new file mode 100755
> index 0000000..f844c0a
> --- /dev/null
> +++ b/tools/testing/selftests/netfilter/ipvs.sh
> @@ -0,0 +1,178 @@
> +#!/bin/bash -p

Please change this to /bin/sh
