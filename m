Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BA7DC86D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410505AbfJRP2B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 11:28:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37286 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394233AbfJRP2A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 11:28:00 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9IFRk2g032466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 11:27:47 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A1830420458; Fri, 18 Oct 2019 11:27:46 -0400 (EDT)
Date:   Fri, 18 Oct 2019 11:27:46 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Tim.Bird@sony.com
Cc:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kselftest@vger.kernel.org,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Message-ID: <20191018152746.GF21137@mit.edu>
References: <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
 <20191017225637.GB6371@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D00A4@USCULXMSG01.am.sony.com>
 <20191018014027.GA21137@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D01DC@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977D01DC@USCULXMSG01.am.sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 02:40:50AM +0000, Tim.Bird@sony.com wrote:
> We're just talking past each other.  My original e-mail was a rebuttal
> to your assertion that any test that was data-driven or non-deterministic
> was a fuzzer.  I still believe that's just not the case.  This is independent
> of the mechanics or speed of how the data is input.

Apologies, I was still focused on the original context of this thread,
which was about suggested improvements to Iurii's ext4 kunit test, or
perhaps adding new features to Kunit.

> I also conceded (multiple times) that externally data-driven
> techniques are probably more aptly applied to non-unit tests. I've
> heard your pitch about speed, and I'm sympathetic.  My point is that
> I believe there is a place for data-driven tests.

I guess I would put it differently.  The key goal is it should be
really easy for developers to run, create, and extend tests.
Data-driven tests is certainly one technique to make it easier to
extend tests, and indeed fs/ext4/inode-test.c is data-driven with the
goal to make it easier to add additional tests.

Having the data for the test be external is certainly one option, and
there will be cases where it will make sense.  However, the overhead
in creating the parser for the data, and additional complexity
required to get the test data to be fed to the test program means that
that benefits need to be pretty large in order to balance the
additional costs of having an external data file, especially for
Kunit.

In terms of the abstract question, is there a place for data-driven
tests, I'm in complete agreement with you.  I've used this many times
personally, especially when writing tests which are implemented in
terms of shell scripts.  Examples of this include e2fsprogs's
regression test suite and xfstests.  I don't consider that a terribly
interesting question though; I view that as on the same order as "is
the sky blue?" or "are apple pies yummy?"

The more interesting, and more concrete question is whether there is a
place for external data-driven tests in Kunit, and there I am *much*
more skeptical.  Sure, I could imagine adding some infrastructure
where user-mode linux could read files from its "host" system.  But
there are those people who want to run KUnit tests by cross-compiling
an ARM kernel and then shipping the resulting kernel to an test board,
and then reading the output from the ARM board's serial console.  In
that case, we can't make the assumption that Kunit tests will be
running under user-mode linux, so the complexity of how we get the
external data file into the KUnit test just went up by another order
of magnitude.  It's going to be ***so*** much simpler if the test data
is embedded in the kernel built by KUnit.  That way, it works both in
the ARCH=um case, and in the "build an ARM kernel and push it to a
test board" case.

Cheers,

					- Ted
