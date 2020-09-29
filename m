Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF8627D754
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 21:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgI2TyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 15:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgI2TyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 15:54:00 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C5C0613D0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 12:53:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n10so4669022qtv.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3mRajUIo4XOPD3LXyp5jDugEU5fV0eJ4P4CT7IZza1k=;
        b=PM6IZxPJuaxo3YsUROHrk+LFZrIuZBkuiJUqbgk6s/7FM110mjvX+XKO+hwjH4iHxs
         /GvBYPiPVoIi1da7WKtiHzwvL0VL71aYCm2twizjNLwo6yd7+iSBVJtfn3JyiNPDgp3r
         ozlZg/bNaujXv/xbVf00OPrjIgQYiDuQ8pWMPhWy02DNIWW7Z3ZW20OrcjXXVopmH6qa
         iC5vcXudPZdFvg7ocAKFfWUYJ0TlkooLKa/OMPqnsMHPcug7fQ7vPJ6Ag7edxGv0k51d
         XMw3/5qURiqjXiFQrLZweYGuGV85XSDjdHGJWuoeLWo/zkMxlVeUn/F1dDMrhIeH+9gc
         0OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3mRajUIo4XOPD3LXyp5jDugEU5fV0eJ4P4CT7IZza1k=;
        b=d8wbhZlT8v95rnsktXKwFWUg1G0EqMhaWLd5ttAEKEiSsA0U7yI7b7cSxkJshmL/jR
         BqKSpSOg4uWdTiFBDib1vJTquhk4QPJ2L3SdQjZNT6PZly6hNpX5rtpfpMNMpuM/CFw7
         ehnNX+eAoJE4MDLx0zbuSwTAupKyVryTHiIDRbazJcNeTmvJazob0wM/z6apB+p4PSpc
         FQ349R3hSxjJZ2UW77zxIsAq8/A59LYC2ZEBoxaTS1p6hQanIxfZWaqXoALaa5ehzphq
         y7NXxQqIetxGLHKgDCnOFiWDNfZN2d7Jqo2IUKJ5G70TIJA170mXC4CBuMLc0VwOchAz
         VV+Q==
X-Gm-Message-State: AOAM5302M74Ra0IJs/51dvSAu5xlfbMC2WtaEita+YaL6t5LIoFZR/Pm
        767m8UW85f6fKahcYRy2E03FyA==
X-Google-Smtp-Source: ABdhPJz8dZwJGVGgqnvNCaakOsX+4PEGTifP8JSz4ukCPx2Qp5OPg1bkTA0k/vzC6egTBA6VrjFJ3Q==
X-Received: by 2002:ac8:774f:: with SMTP id g15mr4923587qtu.294.1601409237342;
        Tue, 29 Sep 2020 12:53:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v18sm6425459qtq.15.2020.09.29.12.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:53:56 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kNLhE-003G4U-1G; Tue, 29 Sep 2020 16:53:56 -0300
Date:   Tue, 29 Sep 2020 16:53:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
Message-ID: <20200929195356.GZ9916@ziepe.ca>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
 <20200928125739.GP9916@ziepe.ca>
 <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
 <20200929163507.GV9916@ziepe.ca>
 <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
 <20200929175524.GX9916@ziepe.ca>
 <715c49ec-d2a8-45cb-8ace-c6b1b4b8f978@nvidia.com>
 <20200929190816.GY9916@ziepe.ca>
 <3022912c-f11b-f564-3a8a-f516ca259a37@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3022912c-f11b-f564-3a8a-f516ca259a37@nvidia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 29, 2020 at 12:48:43PM -0700, John Hubbard wrote:
> On 9/29/20 12:08 PM, Jason Gunthorpe wrote:
> > On Tue, Sep 29, 2020 at 11:59:55AM -0700, John Hubbard wrote:
> > > On 9/29/20 10:55 AM, Jason Gunthorpe wrote:
> > > > On Tue, Sep 29, 2020 at 10:44:31AM -0700, John Hubbard wrote:
> > > > > On 9/29/20 9:35 AM, Jason Gunthorpe wrote:
> > > > > > On Mon, Sep 28, 2020 at 01:10:24PM -0700, John Hubbard wrote:
> > > > > > > On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
> > > > > > > > On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
> > > ...
> > > > > I don't see any "gcc -m" type of dependency generation pass happening
> > > > > in this relatively simple Make system.
> > > > 
> > > > It happens with -MD, all the deps are stored in files like mm/.init-mm.o.cmd
> > > > and sucked into the build.
> > > 
> > > You are thinking of kbuild. This is not kbuild. There are no such artifacts
> > > being generated.
> > 
> > Oh. Really? That's horrible.
> > 
> 
> Well, yes, it's not a perfect build system down here in selftests/. Are you saying
> that it is worth upgrading? I'm open to suggestions and ideas for improvements,
> and at the moment, I have the miniature build system here mostly loaded into my
> head. So for a brief shining moment I can probably understand it well enough to
> work on it. :)

I only remarked because I didn't know it wasn't using kbuild. I
thought it would have used the existing HOSTCC stuff, not sure why it
is special.

The only investment that seems worthwhile would be to switch it to use
the normal kbuild stuff??

Jason
