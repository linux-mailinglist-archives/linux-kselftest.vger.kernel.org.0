Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C528E1E941
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 09:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEOHls (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 May 2019 03:41:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40163 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfEOHls (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 May 2019 03:41:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id j12so2755665eds.7
        for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2019 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2zskjbN09R5wendyqZQRHX/H4SiND0VyVsc8hHlWH90=;
        b=JZJQkfh5WJgpd9RQilQ/pHLDXquURzd9PP7da/2TJy+L6MibswSPsSTQCbNlnr0bG1
         H1IOgDxbiga6cG2caK4SV6oMYSjkhxEj+JDTxsL4iMvHGMPynSqbwQ1+W1ZidZdyDUfp
         A4O6d8SaTe4aarn+lAeSUMg2L9dS5IRK1y5uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2zskjbN09R5wendyqZQRHX/H4SiND0VyVsc8hHlWH90=;
        b=aP7v2Cgyyq1DtUtuY8R44jOhQ4PoHWp3F9Xqw7C7QM/5wze8inS+3RFgUJWBme5aVt
         qNO1AJZrnPBY3rpAXv54iBPDgP4mavs0HNFfp/EClV3bo1/Tlfa51hQJYbVe1Zs2oIS8
         IhiRd9Lhf7ATEb9NobLyaJjv8jN/VXBGKITqZiJCEUnAujzIa9js6nHNXKKlMRz868wE
         0oMwPaVMSHXPwL8eIlduXciZFTli3J2gOGUmIcD1f/CieuIC3J0tWBEW38ytooaoBS2+
         KieZW14rkfkh6vhwZTQkkQpG6G//lKHIvoz9sibs/E2i1B9BwCdHKUeXOxRop4hM7RZp
         dTdA==
X-Gm-Message-State: APjAAAVTyz3x45gA+5QMKYWDbfj0fvk7gze2DCVmmaY3ftwT2gMl3FHW
        PZRxElNVjBx+gRmz3NkrJnNTNQ==
X-Google-Smtp-Source: APXvYqxlVorrQMT/bjOZ2bxd9Tq8NFaUM6+xiZePbw/NWhiH17BnzbbypQzqxmDX8X/b0giy2e7tHQ==
X-Received: by 2002:a50:8dcd:: with SMTP id s13mr40466209edh.247.1557906106265;
        Wed, 15 May 2019 00:41:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b48sm515288edb.28.2019.05.15.00.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 00:41:45 -0700 (PDT)
Date:   Wed, 15 May 2019 09:41:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        Knut Omang <knut.omang@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, sboyd@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>, jdike@addtoit.com,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190515074141.GY17751@phenom.ffwll.local>
Mail-Followup-To: Brendan Higgins <brendanhiggins@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        Knut Omang <knut.omang@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, sboyd@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>, jdike@addtoit.com,
        Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>, Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
References: <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
 <20190511173344.GA8507@mit.edu>
 <20190513144451.GQ17751@phenom.ffwll.local>
 <20190514060433.GA181462@google.com>
 <CAKMK7uHqtSF_sazJTbFL+xmQJRk4iwukCKZHoDHhsKkLXk=ECQ@mail.gmail.com>
 <20190514183618.GC109557@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514183618.GC109557@google.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 14, 2019 at 11:36:18AM -0700, Brendan Higgins wrote:
> On Tue, May 14, 2019 at 02:05:05PM +0200, Daniel Vetter wrote:
> > On Tue, May 14, 2019 at 8:04 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Mon, May 13, 2019 at 04:44:51PM +0200, Daniel Vetter wrote:
> > > > On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> > > > > On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > > > > > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > > > > > is the context here) can be configured as built in instead of as
> > > > > > a module, and built in a UML kernel.  The UML kernel can boot,
> > > > > > running the in-kernel tests before UML attempts to invoke the
> > > > > > init process.
> > > > >
> > > > > Um, Citation needed?
> > > > >
> > > > > I don't see any evidence for this in the kselftest documentation, nor
> > > > > do I see any evidence of this in the kselftest Makefiles.
> > > > >
> > > > > There exists test modules in the kernel that run before the init
> > > > > scripts run --- but that's not strictly speaking part of kselftests,
> > > > > and do not have any kind of infrastructure.  As noted, the
> > > > > kselftests_harness header file fundamentally assumes that you are
> > > > > running test code in userspace.
> > > >
> > > > Yeah I really like the "no userspace required at all" design of kunit,
> > > > while still collecting results in a well-defined way (unless the current
> > > > self-test that just run when you load the module, with maybe some
> > > > kselftest ad-hoc wrapper around to collect the results).
> > > >
> > > > What I want to do long-term is to run these kernel unit tests as part of
> > > > the build-testing, most likely in gitlab (sooner or later, for drm.git
> > >
> > > Totally! This is part of the reason I have been insisting on a minimum
> > > of UML compatibility for all unit tests. If you can suffiently constrain
> > > the environment that is required for tests to run in, it makes it much
> > > easier not only for a human to run your tests, but it also makes it a
> > > lot easier for an automated service to be able to run your tests.
> > >
> > > I actually have a prototype presubmit already working on my
> > > "stable/non-upstream" branch. You can checkout what presubmit results
> > > look like here[1][2].
> > 
> > ug gerrit :-)
> 
> Yeah, yeah, I know, but it is a lot easier for me to get a project set
> up here using Gerrit, when we already use that for a lot of other
> projects.
> 
> Also, Gerrit has gotten a lot better over the last two years or so. Two
> years ago, I wouldn't touch it with a ten foot pole. It's not so bad
> anymore, at least if you are used to using a web UI to review code.

I was somewhat joking, I'm just not used to gerrit ... And seems to indeed
be a lot more polished than last time I looked at it seriously.

> > > > only ofc). So that people get their pull requests (and patch series, we
> > > > have some ideas to tie this into patchwork) automatically tested for this
> > >
> > > Might that be Snowpatch[3]? I talked to Russell, the creator of Snowpatch,
> > > and he seemed pretty open to collaboration.
> > >
> > > Before I heard about Snowpatch, I had an intern write a translation
> > > layer that made Prow (the presubmit service that I used in the prototype
> > > above) work with LKML[4].
> > 
> > There's about 3-4 forks/clones of patchwork. snowpatch is one, we have
> > a different one on freedesktop.org. It's a bit a mess :-/
> 
> Oh, I didn't realize that. I found your patchwork instance here[5], but
> do you have a place where I can see the changes you have added to
> support presubmit?

Ok here's a few links. Aside from the usual patch view we've also added a
series view:

https://patchwork.freedesktop.org/project/intel-gfx/series/?ordering=-last_updated

This ties the patches + cover letter together, and it even (tries to at
least) track revisions. Here's an example which is currently at revision
9:

https://patchwork.freedesktop.org/series/57232/

Below the patch list for each revision we also have the test result list.
If you click on the grey bar it'll expand with the summary from CI, the
"See full logs" is link to the full results from our CI. This is driven
with some REST api from our jenkins.

Patchwork also sends out mails for these results.

Source is on gitlab: https://gitlab.freedesktop.org/patchwork-fdo
 
> > > I am not married to either approach, but I think between the two of
> > > them, most of the initial legwork has been done to make presubmit on
> > > LKML a reality.
> > 
> > We do have presubmit CI working already with our freedesktop.org
> > patchwork. The missing glue is just tying that into gitlab CI somehow
> > (since we want to unify build testing more and make it easier for
> > contributors to adjust things).
> 
> I checked out a couple of your projects on your patchwork instance: AMD
> X.Org drivers, DRI devel, and Wayland. I saw the tab you added for
> tests, but none of them actually had any test results. Can you point me
> at one that does?

Atm we use the CI stuff only on intel-gfx, with the our gpu CI farm, see
links above.

Cheers, Daniel

> 
> Cheers!
> 
> [5] https://patchwork.freedesktop.org/
> 
> > > > super basic stuff.
> > >
> > > I am really excited to hear back on what you think!
> > >
> > > Cheers!
> > >
> > > [1] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-7bfa40efb132e15c8388755c273837559911425c
> > > [2] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-a6784496eafff442ac98fb068bf1a0f36ee73509
> > > [3] https://developer.ibm.com/open/projects/snowpatch/
> > > [4] https://kunit.googlesource.com/prow-lkml/
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
