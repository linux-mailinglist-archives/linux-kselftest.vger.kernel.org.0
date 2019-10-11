Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8844D3CA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfJKJpb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 05:45:31 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45280 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJpb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 05:45:31 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E7B3125AD5C;
        Fri, 11 Oct 2019 20:45:28 +1100 (AEDT)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id ED00E940958; Fri, 11 Oct 2019 11:45:26 +0200 (CEST)
Date:   Fri, 11 Oct 2019 11:45:26 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] selftests: netfilter: introduce test cases for
 ipvs
Message-ID: <20191011094524.ruopnvvh6bedhhgl@verge.net.au>
References: <1570719055-25110-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570719055-25110-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 10, 2019 at 10:50:52PM +0800, Haishuang Yan wrote:
> This series patch include test cases for ipvs.
> 
> The test topology is who as below:
> +--------------------------------------------------------------+
> |                      |                                       |
> |         ns0          |         ns1                           |
> |      -----------     |     -----------    -----------        |
> |      | veth01  | --------- | veth10  |    | veth12  |        |
> |      -----------    peer   -----------    -----------        |
> |           |          |                        |              |
> |      -----------     |                        |              |
> |      |  br0    |     |-----------------  peer |--------------|
> |      -----------     |                        |              |
> |           |          |                        |              |
> |      ----------     peer   ----------      -----------       |
> |      |  veth02 | --------- |  veth20 |     | veth12  |       |
> |      ----------      |     ----------      -----------       |
> |                      |         ns2                           |
> |                      |                                       |
> +--------------------------------------------------------------+
> 
> Test results:
> # selftests: netfilter: ipvs.sh
> # Testing DR mode...
> # Testing NAT mode...
> # Testing Tunnel mode...
> # ipvs.sh: PASS
> ok 6 selftests: netfilter: ipvs.sh
> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Thanks, applied to ipvs-next.
