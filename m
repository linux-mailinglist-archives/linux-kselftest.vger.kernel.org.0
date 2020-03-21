Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7039318E4EB
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Mar 2020 22:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgCUVzK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Mar 2020 17:55:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33238 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgCUVzJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Mar 2020 17:55:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id d22so8452737qtn.0
        for <linux-kselftest@vger.kernel.org>; Sat, 21 Mar 2020 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CmG5rzS1VTJ/Gtn12pCRpchEX5vnXgpD/KCibm4JPWQ=;
        b=QXg0ZNos1/J6d1p0hrWrf/BNlal1wCBZAa4x4E5PIa8BDk8jeEY0GblJxuI4oFmQT/
         NEFlXQButDNW6Sy8rWCrWEBqBlDVBmAq88Oe1Os3P4X8W9sHapEqJpHApMkG11UZBuGc
         b5c/Qy70trzWRO+uM2yXpARmvj2AlCEyD9eXx6cUiReoJKwIlahoUDHxSd5sVQiu5kWj
         lVf+vPf/2xCoROinRkXtRalmj0jS8jiUcIn3LB1fR12o0e5z5NIXXdxa+F/1bZGwg4Ye
         oRdVryO7nhpz8T7n1j5VtSpK27aodaU2eCFv/2TbkyAf3cxW7xJHjI725K50b1LhbcfF
         k1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CmG5rzS1VTJ/Gtn12pCRpchEX5vnXgpD/KCibm4JPWQ=;
        b=IWAMo83OM1qBDWpRjmTSoWvbNawIqVoBjHV35nbFzoDkeCR8lJA1BkCqFLoP8H8Wp2
         dWcj8jwt3qYdBXoLU4p7EgS+BiTvCvcQxsW+LIK96h0cNSIoePxLtRhnl1bcXkhmjIA/
         JicsuiqaE3RZfxLSvUepOvvq6/LrKPI1SXH3tRmIw7t9mHJfUgQiz7ZZ1AbXFYW9KOyt
         szO8TZMPebx2hbEXxhvkPh+uIpfY9J5Ya57oXLDzNjmBBq0p4eMWlwoJtlpf/CpjzMQt
         ZgEhArUp03HNMP7xdTq61pmShFsdPmUvs23i6x24deOprLzd9TmXu83/B6hjO/p/h84B
         FQlw==
X-Gm-Message-State: ANhLgQ2BDlDVXO86DocW4xXmnTEFiHIQT6I9J8cfmUqrOOHkQWJtJHmA
        KaRpvv6neYrcOsfAGR2Pf6LFHw==
X-Google-Smtp-Source: ADFU+vv/Zh+hyXfiOpNLqojKXOQJzZZr2FWGVPNjpoK48D71dPO0p426cqJtcyzUzhZk5VY+Qlxcbw==
X-Received: by 2002:ac8:7499:: with SMTP id v25mr15399957qtq.237.1584827707243;
        Sat, 21 Mar 2020 14:55:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p191sm7884005qke.6.2020.03.21.14.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Mar 2020 14:55:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jFm5B-0002J4-FR; Sat, 21 Mar 2020 18:55:05 -0300
Date:   Sat, 21 Mar 2020 18:55:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200321215505.GW20941@ziepe.ca>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
 <20200321090047.GM514123@unreal>
 <396f0c30-4a49-6a18-ff02-a73ee1a09883@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396f0c30-4a49-6a18-ff02-a73ee1a09883@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 21, 2020 at 10:27:46AM -0700, Ralph Campbell wrote:
> 
> On 3/21/20 2:00 AM, Leon Romanovsky wrote:
> > On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
> > > This series adds basic self tests for HMM and are intended for Jason
> > > Gunthorpe's rdma tree which has a number of HMM patches applied.
> > > 
> > > Changes v7 -> v8:
> > > Rebased to Jason's rdma/hmm tree, plus Jason's 6 patch series
> > >    "Small hmm_range_fault() cleanups".
> > > Applied a number of changes from Jason's comments.
> > > 
> > > Changes v6 -> v7:
> > > Rebased to linux-5.6.0-rc6
> > > Reverted back to just using mmu_interval_notifier_insert() and making
> > >    this series only introduce HMM self tests.
> > > 
> > > Changes v5 -> v6:
> > > Rebased to linux-5.5.0-rc6
> > > Refactored mmu interval notifier patches
> > > Converted nouveau to use the new mmu interval notifier API
> > > 
> > > Changes v4 -> v5:
> > > Added mmu interval notifier insert/remove/update callable from the
> > >    invalidate() callback
> > > Updated HMM tests to use the new core interval notifier API
> > > 
> > > Changes v1 -> v4:
> > > https://lore.kernel.org/linux-mm/20191104222141.5173-1-rcampbell@nvidia.com
> > > 
> > > Ralph Campbell (3):
> > >    mm/hmm/test: add selftest driver for HMM
> > >    mm/hmm/test: add selftests for HMM
> > >    MAINTAINERS: add HMM selftests
> > > 
> > >   MAINTAINERS                            |    3 +
> > >   include/uapi/linux/test_hmm.h          |   59 ++
> > 
> > Isn't UAPI folder supposed to be for user-visible interfaces that follow
> > the rule of non-breaking user space and not for selftests?
> > 
> > Thanks
> > 
> 
> Most of the other kernel module tests seem to invoke the test as part of the
> module load/init. I'm open to moving it if there is a more appropriate location.

Is it even possible to create a user mm_struct and put crazy things in
it soley from a kernel module?

Jason 

