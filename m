Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91047C3FED
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2019 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfJASei (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Oct 2019 14:34:38 -0400
Received: from ja.ssi.bg ([178.16.129.10]:60728 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfJASei (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Oct 2019 14:34:38 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id x91IYDF3004229;
        Tue, 1 Oct 2019 21:34:13 +0300
Date:   Tue, 1 Oct 2019 21:34:13 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
cc:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] selftests: netfilter: introduce test cases for
 ipvs
In-Reply-To: <1569939599-1872-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Message-ID: <alpine.LFD.2.21.1910012133330.3887@ja.home.ssi.bg>
References: <1569939599-1872-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


	Hello,

On Tue, 1 Oct 2019, Haishuang Yan wrote:

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
> Haishuang Yan (3):
>   selftests: netfilter: add ipvs test script
>   selftests: netfilter: add ipvs nat test case
>   selftests: netfilter: add ipvs tunnel test case

Acked-by: Julian Anastasov <ja@ssi.bg>

>  tools/testing/selftests/netfilter/Makefile |   2 +-
>  tools/testing/selftests/netfilter/ipvs.sh  | 234 +++++++++++++++++++++++++++++
>  2 files changed, 235 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/netfilter/ipvs.sh

Regards

--
Julian Anastasov <ja@ssi.bg>
