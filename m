Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B61344F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2020 15:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgAHO0m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jan 2020 09:26:42 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:48536 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgAHO0m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jan 2020 09:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578493601; x=1610029601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=rjxWkNsjq3LvxQA4yvWNzVHyhhHhHG2eEIkAaTQ/8sA=;
  b=kKcz7HVPKexOrWK29e4Mc8+PvpLGZiHj/S2WOIjYIT+RDoxBmI7iHHHo
   vdSec4e2p3evOhuKF2qYeKLI9mIgWpMkDKdkP/76sjWNJPmVNoAcPrfFa
   I/L4MeLqXNN3YWhioQdfHsKvQfr1LzLDFoqOTBo17xL2idWig3vKO6jAb
   s=;
IronPort-SDR: H/HqF/djMvOcIUjZf5gRf1bmKTAfyn6PTdTEgikltkR9CRYnwVcLWc/3euUfmjWQDr729bWeZp
 1JjobmAOxHTw==
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="18844987"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 08 Jan 2020 14:26:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 0127FA1CEE;
        Wed,  8 Jan 2020 14:26:29 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 8 Jan 2020 14:26:29 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.18) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 8 Jan 2020 14:26:26 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj38.park@gmail.com>
Subject: Re: Re: Re: Re: What is the best way to compare an unsigned and a constant?
Date:   Wed, 8 Jan 2020 15:26:11 +0100
Message-ID: <20200108142611.19532-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g45Bo=7QXw8tX6MvFHwU6sCdX8UrjMk5erbByjPvujBw1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.18]
X-ClientProxiedBy: EX13D38UWB003.ant.amazon.com (10.43.161.178) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On   Wed, 8 Jan 2020 06:12:47 -0800   Brendan Higgins <brendanhiggins@google.com> wrote:

> On Tue, Jan 7, 2020 at 5:49 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On   Tue, 7 Jan 2020 05:35:21 -0800   Brendan Higgins <brendanhiggins@google.com> wrote:
> >
> > > Sorry for the delay, I was on vacation. (I still am, but I was too ;-).)
> >
> > Happy new year, Brendan :)
> 
> Happy New Year!
> 
> > >
> > > On Tue, Jan 7, 2020 at 3:52 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > >
> > > > On   Fri, 27 Dec 2019 13:52:27 +0100   Bernd Petrovitsch <bernd@petrovits=
> > > ch.priv.at> wrote:
> 
> [...]
> 
> > Oh, right...  Removing the non-sense casting fixed the problem.  Thanks,
> > Brendan!
> 
> No worries, I do that kind of stuff all the time :-)

Thanks :)

> 
> Does that fix everything? It looks like there was an encoding issue
> with your last email, so I wasn't sure if I got everything.

Yes, it fixed my every problem.  Both 'kunit' and 'checkpatch.pl' shows no
warning, now.


Thanks,
SeongJae Park

> 
> Cheers!
> 
