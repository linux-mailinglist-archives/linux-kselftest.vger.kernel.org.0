Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED741524BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 03:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgBECOm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Feb 2020 21:14:42 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37064 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgBECOm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Feb 2020 21:14:42 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so275085pjb.2;
        Tue, 04 Feb 2020 18:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=Fegxb96WbTiaWF4amnd9jGSEj+9x/8LIWAp8pFBqKBA=;
        b=gqD7Casksvyd+oHamPEUb2BvyGbFbSjNXGaf+aQ0ecuOtLM8AiSohvvVH5dt1rYtO6
         uRX1RFEMfZ0BENQFxjLqT+NA0CCJoRzSuQ8zrTJ9wxasKYOFdF3CZQ8kreKB8mPtChVU
         P3Z6bFB9yY4Bmdbwa9ovgD6QKdqDu2Rj7uC1xLnqA592NiKerultYsRIvTNRTvODW+Mf
         NT5oqomCwi4u7D0YgqSatiAbxWM7RNq0Utsl7e/j5t/YpcCSeNaedtlJlp/oHXq18nqo
         ARURaI2TSXG/BljTHLRENIbbhKDzA9L2X/QHhIZPqs0GS6g2kliMTdNFmeAdxL6HJWv/
         Za6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=Fegxb96WbTiaWF4amnd9jGSEj+9x/8LIWAp8pFBqKBA=;
        b=O8CgClCNsrmOauvx4UdMDPdV7xucrj9+Uo9ILnApLB9zASpMQ+g8zZbplMm9apKT/Z
         me6n7Ll9+wDn1jGdJO6h9Xblreb86CvFOJtSTnc8DBDASq89vxSfLz9JbPAWAHe0ZFjQ
         RazjQUGHCJuElKTms3GlypPd5KwFdszTFMAHxo2pIozTH8GqY4Qyk+zanXo6bO0goN0i
         fQDOxatsOunLrBe7H0DFhbvKRH2kffzbMY/pzT9RHHz7KudFT0eBPNbk6Koyp1CnF4nL
         hwhdPKg1bUuaJMcExpe0AoYsWsYKgjMPV6BlRXi5JE+xwrVCF2n28TNYfy8BL3kKKpra
         7uIw==
X-Gm-Message-State: APjAAAWBl3/DdF3Gfe8DhqT00qe/aRDMZckHwZenTjw0GWaK/y0vbpta
        rIMA/1lGfGWTdmiuDvIE3rk=
X-Google-Smtp-Source: APXvYqzgyXkrf5MY2V6rkPJb/lySnGevQuWU9BWrrZ0FpmwWpyQGlet0W3tueHDGlZFDd56tzRYSxA==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr32705929plo.28.1580868881563;
        Tue, 04 Feb 2020 18:14:41 -0800 (PST)
Received: from localhost.localdomain ([211.47.96.9])
        by smtp.gmail.com with ESMTPSA id d69sm23968818pfd.72.2020.02.04.18.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:14:40 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Re: Re: [PATCH] kunit/kunit_kernel: Rebuild .config if .kunitconfig is modified
Date:   Wed,  5 Feb 2020 03:14:28 +0100
Message-Id: <20200205021428.8007-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g448555=dKFQMbjJ6G=tvtfF5oJgTtTgGx+38Ls3VqHo5g@mail.gmail.com> (raw)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 4 Feb 2020 16:46:06 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:

> Sorry for the delay.
> 
> On Mon, Jan 27, 2020 at 10:03 PM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > On Mon, 27 Jan 2020 16:02:48 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:
> >
> > > On Sat, Jan 25, 2020 at 5:59 PM <sj38.park@gmail.com> wrote:
> > > >
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > >
> > > > Deletions of configs in the '.kunitconfig' is not applied because kunit
> > > > rebuilds '.config' only if the '.config' is not a subset of the
> > > > '.kunitconfig'.  To allow the deletions to applied, this commit modifies
> > > > the '.config' rebuild condition to addtionally check the modified times
> > > > of those files.
> > >
> > > The reason it only checks that .kunitconfig is a subset of .config is
> > > because we don't want the .kunitconfig to remove options just because
> > > it doesn't recognize them.
> > >
> > > It runs `make ARCH=um olddefconfig` on the .config that it generates
> > > from the .kunitconfig, and most of the time that means you will get a
> > > .config with lots of things in it that aren't in the .kunitconfig.
> > > Consequently, nothing should ever be deleted from the .config just
> > > because it was deleted in the .kunitconfig (unless, of course, you
> > > change a =y to a =n or # ... is not set), so I don't see what this
> > > change would do.
> > >
> > > Can you maybe provide an example?
> >
> > Sorry for my insufficient explanation.  I added a kunit test
> > (SYSCTL_KUNIT_TEST) to '.kunitconfig', ran the added test, and then removed it
> > from the file.  However, '.config' is not generated again due to the condition
> > and therefore the test still runs.
> >
> > For more detail:
> >
> >     $ ./tools/testing/kunit/kunit.py run --defconfig --build_dir ../kunit.out/
> >     $ echo "CONFIG_SYSCTL_KUNIT_TEST=y" >> ../kunit.out/.kunitconfig
> >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> >     $ sed -i '4d' ../kunit.out/.kunitconfig
> >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> >
> > The 2nd line command adds sysctl kunit test and the 3rd line shows it runs the
> > added test as expected.  Because the default kunit config contains only 3
> > lines, The 4th line command removes the sysctl kunit test from the
> > .kunitconfig.  However, the 5th line still run the test.
> >
> > This patch is for such cases.  Of course, this might make more false positives
> > but I believe it would not be a big problem because .config generation takes no
> > long time.  If I missed something, please let me know.
> 
> I think I understand.
> 
> It is intentional - currently - that KUnit doesn't generate a new
> .config with every invocation. The reason is basically to support
> interaction with other methods of generating .configs. Consider that
> you might want to use make menuconfig to turn something on. It is a
> pretty handy interface if you work on vastly different parts of the
> kernel. Or maybe you have a defconfig that you always use for some
> platform, I think it is easier to run
> 
> make foo_config; tools/testing/kunit/kunit.py run
> 
> Then having to maintain both your defconfig and a .kunitconfig which
> is a superset of the defconfig.
> 
> Your change would make it so that you have to have a .kunitconfig for
> every test environment that you care about, and you could not as
> easily take advantage of menuconfig.

Thank you for this kind answer.  Now I understood the intention and agree with
that. :)

> 
> I think what we do now is a bit janky, and the use cases I mentioned
> are not super well supported. So I am sympathetic to what you are
> trying to do, maybe we could have a config option for it?
> 
> I think Ted and Bjorn might have opinions on this; they had some
> related opinions in the past.

I'm ok with current state, but if related discussions continue and my opinion
is required, I will join in.


Thanks,
SeongJae Park

> 
