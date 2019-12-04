Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692361120AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 01:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLDAnF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 19:43:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33755 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLDAnF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 19:43:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so2464628pgk.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 16:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTzMjkRz8igkqTydLerD9176xU658ZlUYiWKHY2ex6s=;
        b=HSQcW8Wzpl9ub6BBhV1+tep82/q+mNh8FuYwLl4NImQYAdOza4YA0qERBlJYtkgxaR
         zCpeMGmqtvrSrlcNlGxaZZbcGxxlRqK7boYqUouT31jH0I6mDnnliaWoScsiLD4ftr4W
         MCGn7IXOrq2ysXcInTybP3E3rs5XEzPDjnBigi961bzuEErNeWOPLZBj0IX7VIRNrYCq
         3zkHbZ3xxnW0BdUtpjQUmhLj/uIc6yFmEUZpWyPiqdwYg8t1cT8R7ipvn36mwaNx/6Ga
         8OO2PH8F932g5RY5wQWRWmFoUPR42+i1e7U5qgqUNBQha2CvuRx55CS5VQdOZF+Xl3wF
         32Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTzMjkRz8igkqTydLerD9176xU658ZlUYiWKHY2ex6s=;
        b=JybNUyUT5WP4owRqLIsoKKztrj2eM6zLvvIGKSWP5tdY8zR5KvYX3ThAjLI4Ew1m+N
         7xsFT2V2riimZrk/7D8uM1Y/iMnTAb4Gcg8XqNtqC1cjwpdbDsvsrQHdvBuVOuKid5x8
         tB6VjOrneEzPImhUBzGwDW/w80qYP0Ez6LF9PjCTM4uq48AweMC4JpQktCi6LDi1SYfI
         otdHL1dQHCq84gQfA6mY5dJgjvtN1gALBE9Drf+10OBCUI/RwpkdcHmLonTl8P2zAJW8
         gcof8Y8bmd/vNSggvLF7fQUMEYHkH4w5wpAlSlxqCqXGRXdY0HD15exG77LkAOb6D+1W
         ba5Q==
X-Gm-Message-State: APjAAAU5Rj+KE80xbwk2lIfkIJcXKuynRsEdOSokjeY1wSF92VmfFMq0
        /WfA1dRL7urItmb1oJS+hKEDZtt7tKaCOchbvVdUsQ==
X-Google-Smtp-Source: APXvYqyGKeGtcjtUngbNRBrUiYGZIBnvEvbM9zW11nSo8Qb6u5cQtLoGC1yYUMbx1bhlZS10pfYLS6CT7DhUATPpN4E=
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr550233pgi.159.1575420184378;
 Tue, 03 Dec 2019 16:43:04 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com>
 <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
 <CAFd5g47dRP9HvsZD3sqzzfbAthNq8gxEdh57owo3CqVHLNOf6w@mail.gmail.com> <20191204003851.GF86484@mit.edu>
In-Reply-To: <20191204003851.GF86484@mit.edu>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 16:42:53 -0800
Message-ID: <CAFd5g46A5gyGg0g+GmLRFM1DY=ySf_85P2T7+VYqm4nD8J9wBA@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 4:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Dec 03, 2019 at 09:54:25AM -0800, Brendan Higgins wrote:
> > On Tue, Dec 3, 2019 at 4:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > As tests are added to kunit, it will become less feasible to execute
> > > all built tests together.  By supporting modular tests we provide
> > > a simple way to do selective execution on a running system; specifying
> > >
> > > CONFIG_KUNIT=y
> > > CONFIG_KUNIT_EXAMPLE_TEST=m
> > >
> > > ...means we can simply "insmod example-test.ko" to run the tests.
> > >
> > > To achieve this we need to do the following:
> > >
> > > o export the required symbols in kunit
> > > o string-stream tests utilize non-exported symbols so for now we skip
> > >   building them when CONFIG_KUNIT_TEST=m.
> > > o support a new way of declaring test suites.  Because a module cannot
> > >   do multiple late_initcall()s, we provide a kunit_test_suites() macro
> > >   to declare multiple suites within the same module at once.
> > > o some test module names would have been too general ("test-test"
> > >   and "example-test" for kunit tests, "inode-test" for ext4 tests);
> > >   rename these as appropriate ("kunit-test", "kunit-example-test"
> > >   and "ext4-inode-test" respectively).
> > >
> > > Co-developed-by: Knut Omang <knut.omang@oracle.com>
> > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> Acked-by: Theodore Ts'o <tytso@mit.edu> # for ext4 bits
>
>
> I do have one question, out of curiosity --- for people who aren't
> using UML to run Kunit tests, and are either running the kunit tests
> during boot, or when the module is loaded, is there the test framework
> to automatically extract the test reports out of dmesg?
>
> I can boot a kernel with kunit tests enabled using kvm, and I see it
> splatted intermixed with the rest of the kernel boot messages.  This
> is how I tested the 32-bit ext4 inode test fix.  But I had to manually
> find the test output.  Is that the expected way people are supposed to
> be using Kunit tests w/o using UML and the python runner?

For now, yes. We do not currently have a piece that extracts the test
reports; however, we are planning on pulling that bit out of
tools/testing/kunit/; we just haven't gotten around to it yet.
