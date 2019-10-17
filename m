Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE81DAD5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfJQMwJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 08:52:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33304 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbfJQMwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 08:52:09 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9HCps5C002361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 08:51:55 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5B5A0420458; Thu, 17 Oct 2019 08:51:54 -0400 (EDT)
Date:   Thu, 17 Oct 2019 08:51:54 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Theodore Ts'o" <theodore.tso@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Subject: Re: kunit.py should default to --build_dir=.kunit
Message-ID: <20191017125154.GD25548@mit.edu>
References: <c99604e5-2ea4-4075-9a39-470104298368@googlegroups.com>
 <CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com>
 <291f012c-0ffd-599e-0dac-a6b4e05ebb97@infradead.org>
 <CAFd5g455KciviPA50cVDxK8XMB8ufcLrRq9DPA0d=f-1qXezWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g455KciviPA50cVDxK8XMB8ufcLrRq9DPA0d=f-1qXezWg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 16, 2019 at 02:04:35PM -0700, Brendan Higgins wrote:
> > > Should we maybe drop `--build_dir` in favor of `O`?
> >
> > Yes, preferably be consistent with the rest of the kernel makefiles.
> 
> Alright, probably a good idea to make this change fairly soon then
> before we have to worry about backwards compatibility and such.

I'm not sure how this would work; so something like:

    .../kunit.py run O=/build_dir

Should other flags we can pass in via the makefile processing, such as
V=1, etc., also work?  What other things can we pass in via after the
"run" command?

And if we're going to go this far, maybe we should make "make kunit"
run tools/testing/kunit/kunit.py?
    

Some minor other nits if you're going to be making changes to
kunit.py's CLI parsing:

1) It would be nice if there was a help command so that "kunit.py
   help" does what kunit.py -h does.

2) The top-level help message should indicate that "kunit.py run"
   takes various optional arguments and the way to find them is
   "kunit.py run -h".  This was *not* obvious, and the way I figured
   out there was even --build_dir option was via purusing the source
   code.  (It wasn't in the documentation that I could find.)

3) And maybe then "kunit.py help run" should display the help message
   for "kunit.py urn".  This would make it consistent with other tools
   that some of us might be familiar with (e.g., gcloud, gsutil, etc.)

Of course, if the front entry for kunit starts being "make kunit" as
opposed to ./tools/testing/kunit/kunit.py, then we really need to
figure out how to pass in the equivalent of --timeout.  (Maybe
--raw_output is enabled if we run make kunit V=1?).  And of course,
all of this would need to be documented.

					- Ted
