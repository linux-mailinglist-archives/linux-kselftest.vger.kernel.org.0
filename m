Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5E18F070
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 08:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgCWHwM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 03:52:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37756 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgCWHwM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 03:52:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id d1so13524045wmb.2;
        Mon, 23 Mar 2020 00:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jOKDfoqRBe4k58qisxZytfR8oDaOcRrtygxWW35hmxQ=;
        b=eMvAzVpLjccS/awY1GwiA75b8Hxq7/h1y+jeUIn2RaUPx5z6ptQj+AQU8Lhwtr9EgO
         WeUw/Oe4VwyR/uS01Se60NU+l4qRtbyJYSiQruY+qLc1QrVuBzlDQgwVyf3nkIX5G1cG
         aO9CrvTMvHY8HkywthHacSUJHpi/ygTI2fcCQFCWTtalXmaB7Lxk5nGW/744BZRJ6HhJ
         n4F+DI/MkpTiRVQjg9alXl8PXs1WOmtlYpW29B4Fz7xpT5PYWZ5YLKR5JjT3K3lS1sOn
         CicoHZdNILuA51VEoxMGJHNQ3PB9yN7PDjEHdavMKBOxpGSRcg+nieQsvmpBmNHPUKuX
         D1rw==
X-Gm-Message-State: ANhLgQ2MQ7q3DU8NWAK9BJWyB72OZVyAyEqwfNBtEVWrF20EJWmMqpVM
        ymb2ehGzIZF/5uJqITIQIEk=
X-Google-Smtp-Source: ADFU+vsUItBZCj529pyGAXMjTwrfq25uNWscZdXvQuumhHorAO+WpDKaHTBJXE7x+Zr0wdiJVB8K2w==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr26672662wmj.40.1584949930173;
        Mon, 23 Mar 2020 00:52:10 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id g3sm5291039wrm.66.2020.03.23.00.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 00:52:09 -0700 (PDT)
Date:   Mon, 23 Mar 2020 08:52:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323075208.GC7524@dhcp22.suse.cz>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s>
 <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
 <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun 22-03-20 09:36:49, Shakeel Butt wrote:
> On Sat, Mar 21, 2020 at 9:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> >
> > > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > > + */
> > > > > +static void force_lru_add_drain_all(void)
> > > > > +{
> > > > > + sched_yield();
> > > > > + system("echo 1 > /proc/sys/vm/compact_memory");
> > > > > +}
> > > >
> > > > What is the sched_yield() for?
> > > >
> > >
> > > Mostly it's there to provide a sleeping gap after the fault, whithout
> > > actually adding an arbitrary value with usleep().
> > >
> > > It's not a hard requirement, but, in some of the tests I performed
> > > (whithout that sleeping gap) I would still see around 1% chance
> > > of hitting the false-negative. After adding it I could not hit
> > > the issue anymore.
> >
> > It's concerning that such deep machinery as pagevec draining is visible
> > to userspace.
> >
> 
> We already have other examples like memcg stats where the
> optimizations like batching per-cpu stats collection exposes
> differences to the userspace. I would not be that worried here.

Agreed! Tests should be more tolerant for counters imprecision.
Unevictable LRU is an optimization and transition to that list is a
matter of an internal implementation detail.
 
> > I suppose that for consistency and correctness we should perform a
> > drain prior to each read from /proc/*/pagemap.  Presumably this would
> > be far too expensive.
> >
> > Is there any other way?  One such might be to make the MLOCK_ONFAULT
> > pages bypass the lru_add_pvecs?
> >
> 
> I would rather prefer to have something similar to
> /proc/sys/vm/stat_refresh which drains the pagevecs.

No, please don't. Pagevecs draining is by far not the only batching
scheme we use and an interface like this would promise users to
effectivelly force flushing all of them.

Can we simply update the test to be more tolerant to imprecisions
instead?

-- 
Michal Hocko
SUSE Labs
