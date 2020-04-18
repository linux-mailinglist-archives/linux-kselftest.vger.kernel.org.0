Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139041AE91F
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 03:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgDRBTX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 21:19:23 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:34468 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgDRBTX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 21:19:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0727C18011956;
        Sat, 18 Apr 2020 01:19:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,3,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2565:2682:2685:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3657:3865:3867:3868:3870:3871:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6120:7901:7903:8531:8985:9025:9388:9545:10010:10049:10400:10848:10967:11232:11657:11658:11914:12043:12050:12297:12438:12555:12679:12740:12760:12895:12986:13017:13018:13019:13069:13161:13229:13311:13357:13439:14089:14090:14091:14181:14659:14721:14777:14849:21063:21080:21347:21433:21451:21627:21811:21819:21889:30022:30054:30056:30064:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: spark31_6e9dbd1434e32
X-Filterd-Recvd-Size: 2995
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Apr 2020 01:19:20 +0000 (UTC)
Message-ID: <fa9b79743b58559794fb46c933206f16ffa5992d.camel@perches.com>
Subject: Re: [PATCH v9 3/3] MAINTAINERS: add HMM selftests
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shuah Khan <shuah@kernel.org>
Date:   Fri, 17 Apr 2020 18:17:07 -0700
In-Reply-To: <20200417181323.10e263aeb79b51fe5991e3f2@linux-foundation.org>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
         <20200417235458.13462-4-rcampbell@nvidia.com>
         <13a8e8efd56d00945e375760f7f065fb020287a1.camel@perches.com>
         <20200417181323.10e263aeb79b51fe5991e3f2@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2020-04-17 at 18:13 -0700, Andrew Morton wrote:
> On Fri, 17 Apr 2020 17:59:03 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > On Fri, 2020-04-17 at 16:54 -0700, Ralph Campbell wrote:
> > > Add files for HMM selftests.
> > > 
> > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > ---
> > >  MAINTAINERS | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e64e5db31497..072921b7bae2 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -7729,6 +7729,9 @@ S:	Maintained
> > >  F:	Documentation/vm/hmm.rst
> > >  F:	include/linux/hmm*
> > >  F:	mm/hmm*
> > > +F:	include/uapi/linux/test_hmm*
> > > +F:	lib/test_hmm*
> > > +F:	tools/testing/selftests/vm/*hmm*
> > 
> > file patterns in alphabetic order please:
> > 
> > F	Documentation/vm/hmm.rst
> > F:	include/linux/hmm*
> > F:	include/uapi/linux/test_hmm*
> > F:	lib/test_hmm*
> > F:	mm/hmm*
> > F:	tools/testing/selftests/vm/*hmm*	
> 
> checkpatch rule for this, please ;)

Already sent a few days ago to you ;)

https://lore.kernel.org/lkml/17677130b3ca62d79817e6a22546bad39d7e81b4.camel@perches.com/

And somehow already in -mm too, at least by the email you sent me:

The patch titled
     Subject: checkpatch: additional MAINTAINER section entry ordering checks
has been added to the -mm tree.  Its filename is
     checkpatch-additional-maintainer-section-entry-ordering-checks.patch

This patch should soon appear at
    http://ozlabs.org/~akpm/mmots/broken-out/checkpatch-additional-maintainer-section-entry-ordering-checks.patch
and later at
    http://ozlabs.org/~akpm/mmotm/broken-out/checkpatch-additional-maintainer-section-entry-ordering-checks.patch





