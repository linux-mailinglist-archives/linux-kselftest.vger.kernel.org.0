Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68815C4871
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2019 09:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJBH3g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 03:29:36 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:54588 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfJBH3f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 03:29:35 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 9D0E925B7E3;
        Wed,  2 Oct 2019 17:29:33 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id A9CD4940376; Wed,  2 Oct 2019 09:29:31 +0200 (CEST)
Date:   Wed, 2 Oct 2019 09:29:31 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Julian Anastasov <ja@ssi.bg>,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] selftests: netfilter: introduce test cases for
 ipvs
Message-ID: <20191002072931.fmrxcfggn7b5stud@verge.net.au>
References: <1569939599-1872-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <alpine.LFD.2.21.1910012133330.3887@ja.home.ssi.bg>
 <20191002012726.GB9810@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002012726.GB9810@dimstar.local.net>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 02, 2019 at 11:27:26AM +1000, Duncan Roe wrote:
> On Tue, Oct 01, 2019 at 09:34:13PM +0300, Julian Anastasov wrote:
> >
> > 	Hello,
> >
> > On Tue, 1 Oct 2019, Haishuang Yan wrote:
> >
> > > This series patch include test cases for ipvs.
> > >
> > > The test topology is who as below:
> > > +--------------------------------------------------------------+
> > > |                      |                                       |
> > > |         ns0          |         ns1                           |
> > > |      -----------     |     -----------    -----------        |
> > > |      | veth01  | --------- | veth10  |    | veth12  |        |
> > > |      -----------    peer   -----------    -----------        |
> > > |           |          |                        |              |
> > > |      -----------     |                        |              |
> > > |      |  br0    |     |-----------------  peer |--------------|
> > > |      -----------     |                        |              |
> > > |           |          |                        |              |
> > > |      ----------     peer   ----------      -----------       |
> > > |      |  veth02 | --------- |  veth20 |     | veth12  |       |
> > > |      ----------      |     ----------      -----------       |
> > > |                      |         ns2                           |
> > > |                      |                                       |
> > > +--------------------------------------------------------------+
> > >
> > > Test results:
> > > # selftests: netfilter: ipvs.sh
> > > # Testing DR mode...
> > > # Testing NAT mode...
> > > # Testing Tunnel mode...
> > > # ipvs.sh: PASS
> > > ok 6 selftests: netfilter: ipvs.sh
> > >
> > > Haishuang Yan (3):
> > >   selftests: netfilter: add ipvs test script
> > >   selftests: netfilter: add ipvs nat test case
> > >   selftests: netfilter: add ipvs tunnel test case
> >
> > Acked-by: Julian Anastasov <ja@ssi.bg>
> >
> > >  tools/testing/selftests/netfilter/Makefile |   2 +-
> > >  tools/testing/selftests/netfilter/ipvs.sh  | 234 +++++++++++++++++++++++++++++
> > >  2 files changed, 235 insertions(+), 1 deletion(-)
> > >  create mode 100755 tools/testing/selftests/netfilter/ipvs.sh
> >
> > Regards
> >
> > --
> > Julian Anastasov <ja@ssi.bg>
> 
> I still prefer #!/bin/sh in 1/3. You never know what's in someone's environment

That would be my preference too.
