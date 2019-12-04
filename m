Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED81120AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 01:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLDAjY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 19:39:24 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47416 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbfLDAjY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 19:39:24 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xB40cpqi007825
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Dec 2019 19:38:52 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2474D421A48; Tue,  3 Dec 2019 19:38:51 -0500 (EST)
Date:   Tue, 3 Dec 2019 19:38:51 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Brendan Higgins <brendanhiggins@google.com>
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
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
Message-ID: <20191204003851.GF86484@mit.edu>
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com>
 <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
 <CAFd5g47dRP9HvsZD3sqzzfbAthNq8gxEdh57owo3CqVHLNOf6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47dRP9HvsZD3sqzzfbAthNq8gxEdh57owo3CqVHLNOf6w@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 03, 2019 at 09:54:25AM -0800, Brendan Higgins wrote:
> On Tue, Dec 3, 2019 at 4:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > As tests are added to kunit, it will become less feasible to execute
> > all built tests together.  By supporting modular tests we provide
> > a simple way to do selective execution on a running system; specifying
> >
> > CONFIG_KUNIT=y
> > CONFIG_KUNIT_EXAMPLE_TEST=m
> >
> > ...means we can simply "insmod example-test.ko" to run the tests.
> >
> > To achieve this we need to do the following:
> >
> > o export the required symbols in kunit
> > o string-stream tests utilize non-exported symbols so for now we skip
> >   building them when CONFIG_KUNIT_TEST=m.
> > o support a new way of declaring test suites.  Because a module cannot
> >   do multiple late_initcall()s, we provide a kunit_test_suites() macro
> >   to declare multiple suites within the same module at once.
> > o some test module names would have been too general ("test-test"
> >   and "example-test" for kunit tests, "inode-test" for ext4 tests);
> >   rename these as appropriate ("kunit-test", "kunit-example-test"
> >   and "ext4-inode-test" respectively).
> >
> > Co-developed-by: Knut Omang <knut.omang@oracle.com>
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Acked-by: Theodore Ts'o <tytso@mit.edu> # for ext4 bits


I do have one question, out of curiosity --- for people who aren't
using UML to run Kunit tests, and are either running the kunit tests
during boot, or when the module is loaded, is there the test framework
to automatically extract the test reports out of dmesg?

I can boot a kernel with kunit tests enabled using kvm, and I see it
splatted intermixed with the rest of the kernel boot messages.  This
is how I tested the 32-bit ext4 inode test fix.  But I had to manually
find the test output.  Is that the expected way people are supposed to
be using Kunit tests w/o using UML and the python runner?

Thanks,

						- Ted
