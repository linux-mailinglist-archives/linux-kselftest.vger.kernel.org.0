Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414391AE917
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 03:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgDRBIy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 21:08:54 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:48952 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgDRBIy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 21:08:54 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2020 21:08:54 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id E622018034A50;
        Sat, 18 Apr 2020 01:01:19 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7E45F1801EDC8;
        Sat, 18 Apr 2020 01:01:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3351:3622:3870:3876:4250:4321:5007:6119:6120:7901:10004:10400:10848:11232:11657:11658:11914:12043:12048:12297:12555:12740:12760:12895:12986:13069:13184:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30056:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: page10_627b1b350bf5d
X-Filterd-Recvd-Size: 1847
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Apr 2020 01:01:16 +0000 (UTC)
Message-ID: <13a8e8efd56d00945e375760f7f065fb020287a1.camel@perches.com>
Subject: Re: [PATCH v9 3/3] MAINTAINERS: add HMM selftests
From:   Joe Perches <joe@perches.com>
To:     Ralph Campbell <rcampbell@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Date:   Fri, 17 Apr 2020 17:59:03 -0700
In-Reply-To: <20200417235458.13462-4-rcampbell@nvidia.com>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
         <20200417235458.13462-4-rcampbell@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2020-04-17 at 16:54 -0700, Ralph Campbell wrote:
> Add files for HMM selftests.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..072921b7bae2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7729,6 +7729,9 @@ S:	Maintained
>  F:	Documentation/vm/hmm.rst
>  F:	include/linux/hmm*
>  F:	mm/hmm*
> +F:	include/uapi/linux/test_hmm*
> +F:	lib/test_hmm*
> +F:	tools/testing/selftests/vm/*hmm*

file patterns in alphabetic order please:

F	Documentation/vm/hmm.rst
F:	include/linux/hmm*
F:	include/uapi/linux/test_hmm*
F:	lib/test_hmm*
F:	mm/hmm*
F:	tools/testing/selftests/vm/*hmm*	

