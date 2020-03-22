Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E2D18EA82
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Mar 2020 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgCVQhC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Mar 2020 12:37:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33750 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVQhC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Mar 2020 12:37:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id 22so5527618otf.0
        for <linux-kselftest@vger.kernel.org>; Sun, 22 Mar 2020 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GRKFaCcXJ7mdsvy6NUcpQNVCNNISDlTqxog704JRIs=;
        b=tvRFQfNiD4QieIcurY5uIxY68I7r4dirD+9m/gx1ebXGGB/f/fOqlVi+iUP1q7iX4l
         QlZ6nfeCtzcob9S6go+lz1o+N20wI2lOIGJy38i8KoXrV6qmrL58UwgCSPu2FA3x3EPQ
         EouWUxFsnGEl0kFOBxOotjQuXsm0cPSgRB+aCCXRHJNN0yDGeIW9K3tcUw24FFu0sdfv
         gCPMfsGvgv83/EVtsKbnIbpa0x6fEgwEZugjOtgkTQZCGHtDufb0/340NhW4cvoQhaPI
         YmdxCrOtPNNIZoHjEpJCQfk9QDWSn+OpxsBVDkTfsp/Nt9ZTSaQ93wXy1k5HxjlU881w
         WlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GRKFaCcXJ7mdsvy6NUcpQNVCNNISDlTqxog704JRIs=;
        b=d7bCXW7hCvfZAyFJkBfHf3TyX1AqGgMw5mU/Ixh5I9w9aupi/Zz7qT683m1GsD45GI
         tMN6rkC5ngv2UJLRHk1WrDAMM5gp7TlnIasELQka0Yubwm1z1wklGkPB5S0PCoHoWrsy
         yvuxxsCvEERNN/sg2cjYrB1ONuEvv9dFkE87ZWpJeVeVNqn+OmxPTKcsmHlPjCQAe2e/
         0jYVooncAhBmvr9RNmpjx2cgxQ+Fvj6W5gl2omtURn5me5X42WBLDaX3i4I1+Lz637It
         6xHDIRqT4WU2o0ST+nrG86arrzshJL68iw/E7Um3XggFm7hm0zkxhv1vRL2QrlI0R12O
         HgCw==
X-Gm-Message-State: ANhLgQ3nLstYrjy6hwSfH9SjeyYigSs/mbdmrz6pOVkIczRSc/Y4Pjl6
        sxK5HY9/CnyYeOX3bgoB0iDd1AAWzdRJvG7xMP6mkA==
X-Google-Smtp-Source: ADFU+vsSP7GimuLHJKtzBEPg3zUHwQK1tIO0UcChLo5j9UqtFQQL/YtMYuBFA5ZfCdI5L3etshgrsJzMNdGsYzRsHpA=
X-Received: by 2002:a9d:1a2:: with SMTP id e31mr15534935ote.30.1584895020899;
 Sun, 22 Mar 2020 09:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200322013525.1095493-1-aquini@redhat.com> <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s> <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
In-Reply-To: <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 22 Mar 2020 09:36:49 -0700
Message-ID: <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rafael Aquini <aquini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 21, 2020 at 9:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
>
> > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > + */
> > > > +static void force_lru_add_drain_all(void)
> > > > +{
> > > > + sched_yield();
> > > > + system("echo 1 > /proc/sys/vm/compact_memory");
> > > > +}
> > >
> > > What is the sched_yield() for?
> > >
> >
> > Mostly it's there to provide a sleeping gap after the fault, whithout
> > actually adding an arbitrary value with usleep().
> >
> > It's not a hard requirement, but, in some of the tests I performed
> > (whithout that sleeping gap) I would still see around 1% chance
> > of hitting the false-negative. After adding it I could not hit
> > the issue anymore.
>
> It's concerning that such deep machinery as pagevec draining is visible
> to userspace.
>

We already have other examples like memcg stats where the
optimizations like batching per-cpu stats collection exposes
differences to the userspace. I would not be that worried here.

> I suppose that for consistency and correctness we should perform a
> drain prior to each read from /proc/*/pagemap.  Presumably this would
> be far too expensive.
>
> Is there any other way?  One such might be to make the MLOCK_ONFAULT
> pages bypass the lru_add_pvecs?
>

I would rather prefer to have something similar to
/proc/sys/vm/stat_refresh which drains the pagevecs.
