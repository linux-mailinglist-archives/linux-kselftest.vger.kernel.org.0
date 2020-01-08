Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13811344BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2020 15:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgAHONA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jan 2020 09:13:00 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45590 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAHONA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jan 2020 09:13:00 -0500
Received: by mail-pg1-f171.google.com with SMTP id b9so1631410pgk.12
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2020 06:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOI5BG860h0vH7yTQCyBsKUAeChUvKx+rCYmS5SLzkw=;
        b=Wz+DWmer/jGrH1ORaA/pti5FLZBhYiqAK4WhKgaqvtUdUv2uLo//D1fV3Oyi2aL1a5
         2XBX+pUT01YDPfDSzhR5a27RYecvnf5OW7f8hFXXDvMEJd3vv62gi/0UCsANnd6vMWD/
         aWkhvhafdi/SOJjyEPFjebG39px2lwEtmwP55tRyPASRjOSb2N1MYfwfk97XHBJiaCle
         cX30ziwPyHf/50MR7leB0pDfYbyF8DkRL1zYIsqiplPcwl+STftfjXblGvuewwW1djXu
         oEVbkghL0c+Il5f+4O1XUK57kEKl5w6L7HXxfBfe/Si9nYJ+XAJpXYNDzZRv96iQK9as
         SSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOI5BG860h0vH7yTQCyBsKUAeChUvKx+rCYmS5SLzkw=;
        b=bVB559mdwGtGOTg4pKm6AteVgBI8isUMkXz8eDIglQgoirn3yNoS/8pNzuMnxXQ26X
         mBvF18dPiJWld9IkP0rDryJofx8xPwiaWBzIx5UXkKVE9/i+bFvu2RpY3xAAiLKefCw7
         ZhZzZmAs1E7CO0RVuZBK2ePcJwgmTdTupztNvUWN3/oJcdBk8HCMwH9sW+nOuxuX1cFp
         xEW0v+JpuOb1bKznGOsO44oYBCxT5AT5hEAytiOF2YlvapSmlpXL9MwLk5tK/mJBuAif
         kvfO9uqFWoMPdH8bsinNFdyLRU95+fOH6rNhGS9rT7mlUw/ufIa6IvaXtVuNDRlgMzqX
         R5+A==
X-Gm-Message-State: APjAAAVupkKK708E2VscV9Vcz5RHhG2iue/NV4hdBsKVl/n1I0yQvQIN
        JdpzdqZiZy6OukZzCt2vZoqeJjMDMulq1tiUe7uqrQ==
X-Google-Smtp-Source: APXvYqxXYnISGYqhh65OlFyk1T5mmTwmrC7gpU1waoraE1dS7SopJkNW+C8vOA5O2JPuqb/lVeKX/DfbN3Cf5AUXb6A=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr5233188pfg.23.1578492779096;
 Wed, 08 Jan 2020 06:12:59 -0800 (PST)
MIME-Version: 1.0
References: <CAFd5g47-wi0duBAVxvevDKT7eb7WGT9JMFoKgCJQQSa0P0h9Jw@mail.gmail.com>
 <20200107134910.20347-1-sjpark@amazon.com>
In-Reply-To: <20200107134910.20347-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 8 Jan 2020 06:12:47 -0800
Message-ID: <CAFd5g45Bo=7QXw8tX6MvFHwU6sCdX8UrjMk5erbByjPvujBw1g@mail.gmail.com>
Subject: Re: Re: Re: What is the best way to compare an unsigned and a constant?
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj38.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 7, 2020 at 5:49 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> On   Tue, 7 Jan 2020 05:35:21 -0800   Brendan Higgins <brendanhiggins@google.com> wrote:
>
> > Sorry for the delay, I was on vacation. (I still am, but I was too ;-).)
>
> Happy new year, Brendan :)

Happy New Year!

> >
> > On Tue, Jan 7, 2020 at 3:52 AM SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > On   Fri, 27 Dec 2019 13:52:27 +0100   Bernd Petrovitsch <bernd@petrovits=
> > ch.priv.at> wrote:

[...]

> Oh, right...  Removing the non-sense casting fixed the problem.  Thanks,
> Brendan!

No worries, I do that kind of stuff all the time :-)

Does that fix everything? It looks like there was an encoding issue
with your last email, so I wasn't sure if I got everything.

Cheers!
