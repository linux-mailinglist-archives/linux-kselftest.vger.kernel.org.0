Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069251AE91C
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 03:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgDRBNY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 21:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgDRBNY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 21:13:24 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D6FF20771;
        Sat, 18 Apr 2020 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587172403;
        bh=fvX/Qz6qSB/x3JBg8PAKFoPq3kL6NK7kMJ1hoT4JyA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e7hamrPrFYzKqNv/IdrC8Zher/mEVsByBRjVA/QWIlg6d5sOiMQdeMtlZYyZgYd+f
         dLj5WzQwyDcfN/Iww3cfVHi6034edz1Qt5HH8Aj0x/Rpo60la4tnNjlX5GbHzO2tAM
         d9RMMTKMpyixLpcAPMs9FRA+2XNNqxNpOuZE8qbg=
Date:   Fri, 17 Apr 2020 18:13:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v9 3/3] MAINTAINERS: add HMM selftests
Message-Id: <20200417181323.10e263aeb79b51fe5991e3f2@linux-foundation.org>
In-Reply-To: <13a8e8efd56d00945e375760f7f065fb020287a1.camel@perches.com>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
        <20200417235458.13462-4-rcampbell@nvidia.com>
        <13a8e8efd56d00945e375760f7f065fb020287a1.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 17 Apr 2020 17:59:03 -0700 Joe Perches <joe@perches.com> wrote:

> On Fri, 2020-04-17 at 16:54 -0700, Ralph Campbell wrote:
> > Add files for HMM selftests.
> > 
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e64e5db31497..072921b7bae2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7729,6 +7729,9 @@ S:	Maintained
> >  F:	Documentation/vm/hmm.rst
> >  F:	include/linux/hmm*
> >  F:	mm/hmm*
> > +F:	include/uapi/linux/test_hmm*
> > +F:	lib/test_hmm*
> > +F:	tools/testing/selftests/vm/*hmm*
> 
> file patterns in alphabetic order please:
> 
> F	Documentation/vm/hmm.rst
> F:	include/linux/hmm*
> F:	include/uapi/linux/test_hmm*
> F:	lib/test_hmm*
> F:	mm/hmm*
> F:	tools/testing/selftests/vm/*hmm*	

checkpatch rule for this, please ;)
