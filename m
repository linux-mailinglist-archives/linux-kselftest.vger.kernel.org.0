Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA312354
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2019 22:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfEBU0I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 May 2019 16:26:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43170 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfEBU0H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 May 2019 16:26:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id e108so3321220ote.10
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjYVT5cAdmQKUfv9t8ccIVDdyBls+aL8RkatsPsXvcs=;
        b=S/NLBkmmg3Md+sTx08gED5HrktmpwZikr8idsPoedLBx4NGY0vsICG/2JByh1OPLMl
         SoIkyImRxqPDEOFyC2ZMo66T4y64AzxZJe60LUPIIZ+2whbKVnm1u/h2cZWzkh0Pg7xc
         EXNw4yJNZ9fhJbGVtdrs9Sah16nUmTboVs4KkvhykHpn/i4zj9XsNumXBLK6Ynb0YPNG
         +tpKFc1Qf+4khDJxrAPPVZg4LS8WUK6j1vznFw5a8jr0zVqX9peLg5vYA1eBwQqixHhg
         xvPSDH5tHp5fJ/MAFS5gSf8uCUub0+kg9vZwn+lDYmBqYVC0qg8nx8pyREf5ogAUd63R
         E26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjYVT5cAdmQKUfv9t8ccIVDdyBls+aL8RkatsPsXvcs=;
        b=pc4J7xPpQd6s2FfBh+3wdOd9/Ob+SkSkCBCivZM01Due8FagJTerZeNLZOue5hj0oy
         r0ElI7NEe1unv1JZBlkePGIQUrjnfqSudJqbnc5FsLTLGXKaicP7DflNUfHOrBaa3/Rb
         5UIgGqeHq3nHtMp2n8ZulalYx/L38uxft/g1GUESHtOKIGjUX30mSgovTI8yOiywpS9R
         IqgOKIZ+WIRqoOhSGqd69AW9BxX/XqZeIJdLvSE0bTKijEhax6PKCHOd99IJuO576l3d
         OaYT0TNmJLre8QUcHKS8YbvAO0DBy9gSMP1uRMgVkoLDruO2mytNVtOuai7Qp/Icd/N2
         PbYA==
X-Gm-Message-State: APjAAAUw5qUsH1BNim3qoBwOkFf9qlFZXpCPOzMMQFrxZYmfYREVuuJ0
        kMvNzKjclvgns8xiAVx1c20RuLmzLD6R4DrdKiQqIQ==
X-Google-Smtp-Source: APXvYqxyYrm8zG8OMTTxqGADAYUvr/vXQpVESafN7Cz0pZWyjDkgKl1eFOtZxYdb1jr2uV1YoMkUpLh/i+1PnNqQJjM=
X-Received: by 2002:a05:6830:204a:: with SMTP id f10mr3731908otp.83.1556828766432;
 Thu, 02 May 2019 13:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-5-brendanhiggins@google.com> <20190502110008.GC12416@kroah.com>
In-Reply-To: <20190502110008.GC12416@kroah.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 2 May 2019 13:25:54 -0700
Message-ID: <CAFd5g47ssM7RQZxQsUJ86UigcF-Uz+Kwv2yvKN_gZK-TtW89bA@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] kunit: test: add kunit_stream a std::stream like logger
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah@kernel.org, devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 2, 2019 at 4:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 01, 2019 at 04:01:13PM -0700, Brendan Higgins wrote:
> > A lot of the expectation and assertion infrastructure prints out fairly
> > complicated test failure messages, so add a C++ style log library for
> > for logging test results.
>
> Ideally we would always use a standard logging format, like the
> kselftest tests all are aiming to do.  That way the output can be easily
> parsed by tools to see if the tests succeed/fail easily.
>
> Any chance of having this logging framework enforcing that format as
> well?

I agree with your comment on the later patch that we should handle
this at the wrapper script layer (KUnit tool).
