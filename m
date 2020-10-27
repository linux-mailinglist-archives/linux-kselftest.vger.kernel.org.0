Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776B329A562
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 08:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgJ0HTl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 03:19:41 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:42518 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgJ0HTi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 03:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603783178; x=1635319178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=MfowExY2M2X/2s1QHjhgoi8PsO3M+98xml+DmfUlIhA=;
  b=vqgG6QEdHUYbkFCBgt3rEM2FkRUbmjXMtGLOPjDthEOemGhiTbSJPnr8
   XsnOcCO0ekck4KKNMYKWKxMTafI7X8Zp1TsLn4/nHWA9cANWzCaZGgw39
   Clb17FncWluVYx106Oob9vi6wJVgrs5Y+SXvPEEm5L40sc/BsUH3tSHCz
   w=;
X-IronPort-AV: E=Sophos;i="5.77,422,1596499200"; 
   d="scan'208";a="61107540"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 27 Oct 2020 07:19:31 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 0CA6CA1F1C;
        Tue, 27 Oct 2020 07:19:28 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.67) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 27 Oct 2020 07:19:24 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kunit: tool: Mark 'kunittest_config' as constant again
Date:   Tue, 27 Oct 2020 08:19:08 +0100
Message-ID: <20201027071908.26454-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g45N_7HTTObU799_S-9QPFXhQkeQ=yqvH-J79ROvKSXs4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.67]
X-ClientProxiedBy: EX13D23UWA001.ant.amazon.com (10.43.160.68) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 26 Oct 2020 13:44:33 -0700 Brendan Higgins <brendanhiggins@google.com> wrote:

> On Sun, Oct 25, 2020 at 5:45 AM <andy@surfacebook.localdomain> wrote:
> >
> > On Thu, Oct 22, 2020 at 08:35:26AM +0200, SeongJae Park wrote:
> > > On Wed, 21 Oct 2020 14:32:52 -0700 Brendan Higgins <brendanhiggins@google.com> wrote:
> > >
> > > > On Mon, Oct 12, 2020 at 3:27 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > > >
> > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > >
> > > > > 'kunit_kernel.kunittest_config' was constant at first, and therefore it
> > > > > used UPPER_SNAKE_CASE naming convention that usually means it is
> > > > > constant in Python world.  But, commit e3212513a8f0 ("kunit: Create
> > > > > default config in '--build_dir'") made it modifiable to fix a use case
> > > > > of the tool and thus the naming also changed to lower_snake_case.
> > > > > However, this resulted in a confusion.  As a result, some successing
> > > > > changes made the tool unittest fail, and a fix[1] of it again incurred
> > > > > the '--build_dir' use case failure.
> > > > >
> > > > > As the previous commit fixed the '--build_dir' use case without
> > > > > modifying the variable again, this commit marks the variable as constant
> > > > > again with UPPER_SNAKE_CASE, to reduce future confusions.
> > > > >
> > > > > [1] Commit d43c7fb05765 ("kunit: tool: fix improper treatment of file location")
> > > > >
> > > > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > >
> > > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > >
> > > Thanks :)
> > >
> > > >
> > > > Thanks for this! This is something I meant to fix a while ago and forgot about.
> > > >
> > > > One minor issue, this patch does not apply on torvalds/master right
> > > > now. Could you please rebase this?
> > >
> > > Surely of course, I will send next version soon.
> >
> > May I ask what happened to [1]?
> > I mean it seems these two are goind to collide.
> >
> > Brendan?
> >
> > [1]: https://lore.kernel.org/linux-kselftest/20201015152348.65147-1-andriy.shevchenko@linux.intel.com/
> 
> Sorry for the confusion here. After an initial glance at your patches
> (before I did the review end of last week) I thought only the first
> patch from SeongJae would potentially conflict with yours (Andy's)
> (hence why I hadn't reviewed it yet, I was waiting until after I
> looked at yours).
> 
> I noticed on Friday that SeongJae's changes were actually fully
> encompassed by Andy's, so I am taking Andy's not SongJae's. Sorry, I
> was going to notify SongJae today, but you beat me to it.
> 
> Sorry everyone.

It's ok, I understand the situation and respect your decision.  After all, what
I really wanted was just fixing the problem by whoever.  I would like to say
thank you to Andy for fixing it instead of me :)  Also, thank you Brendan, for
maintaining the cool Kunit ;)


Thanks,
SeongJae Park
