Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8188AE70
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 07:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfHMFDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 01:03:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39904 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHMFDz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 01:03:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so1951747pln.6
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Aug 2019 22:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKOfFTV6VGP5BNUB1Vnarc/F0DL+26vq0829FAbZrqo=;
        b=svgoSdNRxSLsCnnIOc7xbQg9GgF9oKMJ1Zy9kd11vWwaKXoOnKpb4m3E5VD5iVlgYD
         +Q8GW61vmO7pSODND/EU3ySpZFU6zBm/nnzXrEdbXjYeyp0z5HZ4MlPGEFDVamV7AnNt
         YxSzN7MGuqE5YtmeQLv8pM8cwjVoHM11Q7HgFuNs7NBSHTrEDEHtBfVlPMX1tM122Zoh
         /lJWbiyvCy294xIaxGNy1x0QeVRdkekMXrwW6vrlb0zY+yiiNnJIqQVHv78TipzeF0fL
         lbgrIbrBSmtQjgptdFMq0Sq8pSiArBm+sF/Wu+BeNyqHXo/vQXv7UP+JqfWMmgemFjSH
         IU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKOfFTV6VGP5BNUB1Vnarc/F0DL+26vq0829FAbZrqo=;
        b=HIBXOhztYKrDPC8sZrx9xv3bnJVzDqIJFXQ0039kE5kVzf14s2mOtejUfzliuoR5r6
         U2IMRrVjCHjewkq4M7/4wPZ+DYutuzvWN5ICUwXWsU3dIrWFXRuht37i2QK1HMfXWPV1
         bIoreRpdFPhyy4i+xhWGrKca9tEDFKgNxeB3FNlpfLpnFAUZOC1i5se0LWCd5sAccgH7
         PGFgTDrptDb1+P73M/hQRlT5Ts5Km8cxzfPzl5Jwj4UCvxAYR3e7//qpTHx77G6ZRMAc
         y2eCMsqnoIcmlzPTz8jyzp/9kiAq6tbFkfqI780FL240/ePwQrY/jSISRES+eam/ts5o
         NDyw==
X-Gm-Message-State: APjAAAUgUUMmwBJThG+qR1PH+EEJBTtt2CILE8xA0mELYld5DJJNI4kO
        Ew30W5qnIk1B7rQg7MwrfxysGf+ngxLBhTtGg0o/Qg==
X-Google-Smtp-Source: APXvYqwgOw9EQ70Umy0oEnQ5G5LCL6qyMyWjnNbSVpHRs20m04I8HxLTnoiIjpuTiP19er8DvO/pyE/cwQSXqDyWk+Y=
X-Received: by 2002:a17:902:5983:: with SMTP id p3mr26758654pli.232.1565672634067;
 Mon, 12 Aug 2019 22:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-5-brendanhiggins@google.com> <20190812234644.E054D20679@mail.kernel.org>
 <CAFd5g44huOiR9B0H1C2TtiPy63BDuwi_Qpb_exF3zmT3ttV8eg@mail.gmail.com>
 <CAFd5g44GxE-p+Jk_46GYA-WWVHLW7w=yE+K_tbbdiniDfrk-2w@mail.gmail.com> <20190813045747.3AF0A206C2@mail.kernel.org>
In-Reply-To: <20190813045747.3AF0A206C2@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Aug 2019 22:03:42 -0700
Message-ID: <CAFd5g47OUymztYcWngDUd10WswVOrO-PTmX+KNF_T=cg_OcJNg@mail.gmail.com>
Subject: Re: [PATCH v12 04/18] kunit: test: add assertion printing library
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 12, 2019 at 9:57 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 21:27:05)
> > On Mon, Aug 12, 2019 at 4:56 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Mon, Aug 12, 2019 at 4:46 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Brendan Higgins (2019-08-12 11:24:07)
> > > > > +#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {                           \
> > > > > +               .assert = KUNIT_INIT_ASSERT_STRUCT(test,                       \
> > > > > +                                                  type,                       \
> > > > > +                                                  kunit_fail_assert_format)   \
> > > >
> > > > This one got indented one too many times?
> > >
> > > Not unless I have been using the wrong formatting for multiline
> > > macros. You can see this commit applied here:
> > > https://kunit.googlesource.com/linux/+/870964da2990920030990dd1ffb647ef408e52df/include/kunit/assert.h#59
> > >
> > > I have test, type, and kunit_fail_assert_format all column aligned (it
> > > just doesn't render nicely in the patch format).
> >
> > Disregard that last comment. I just looked at the line immediately
> > above your comment and thought it looked correct. Sorry about that
> > (you were pointing out that the .assert line looked wrong, correct?).
>
> Yes. .assert is double tabbed?

Yes it is. Sorry about the confusion. Will fix.
