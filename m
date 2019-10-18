Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26A4DBB5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 03:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409479AbfJRBkj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 21:40:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42302 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388373AbfJRBkj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 21:40:39 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9I1eRNO012456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 21:40:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 21C79420458; Thu, 17 Oct 2019 21:40:27 -0400 (EDT)
Date:   Thu, 17 Oct 2019 21:40:27 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Tim.Bird@sony.com
Cc:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kselftest@vger.kernel.org,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Message-ID: <20191018014027.GA21137@mit.edu>
References: <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
 <20191017225637.GB6371@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D00A4@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977D00A4@USCULXMSG01.am.sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 11:40:01PM +0000, Tim.Bird@sony.com wrote:
> 
> No. Well, the data might be provided at some time independent
> of the test compilation time, but it would not be made up on the fly.
> So the data might be provided at run time, but that shouldn't imply
> that the data is random, or that there is some lengthy fabrication
> process that happens at test execution time.

So how would the data be provided?  Via a mounted file system?  There
is no mounted file system when we're running a kunit test.  One of the
reasons why kunit is fast is because we're not running init scripts,
and we're not mounting a file system.

The fabrication process isn't really lengthy, though.  If I modify
fs/ext4/inode-test.c to add or remove a test, it takes:

Elapsed time: 2.672s total, 0.001s configuring, 2.554s building, 0.116s running

Compare and contrast this with running "kvm-xfstests -c 4k generic/001"

The actual time to run the test generic/001 is 3 seconds.  But there
is a 9 second overhead in starting the VM, for a total test time of 12
seconds.  So sure, with kvm-xfstests I can drop a config file in
/tmp/kvm-xfstests-tytso, which is mounted as /vtmp using 9p, so you
could provide "user provided data" via a text file.  But the overhead
of starting up a full KVM, mounting a file system, starting userspace,
etc., is 9 seconds.

Contrast this with 2.5 seconds to recompile and relink
fs/ext4/inode-test.c into the kunit library.  I wouldn't call that a
"length fabrication process".  Is it really worth it to add in some
super-complex way to feed a data text file into a Kunit test, when
editing the test file and rerunning the test really doesn't take that
long?

> In this case, the cost of parsing the data file does add some overhead,
> but it's not onerous.  I'm not sure how, or whether, kunit handles
> the issue of reading data from a file at test time.  But it doesn't have
> to be a file read.  I'm just talking separating data from code.

It's not the cost of parsing the data file is how to *feed* the data
file into the test file.  How exactly are we supposed to do it?  9p?
Some other mounted file system?  That's where all the complexity and
overhead is going to be.

> Not necessarily.  Maybe the root privilege example is not a good one.
> How about a test that probes the kernel config, and executes
> some variation of the tests based on the config values it detects?

But that's even easier.  We can put "#ifdef CONFIG_xxx" into the
fs/ext4/inode-test.c file.  Again, it doesn't take that long to
recompile and relink the test .c file.

Apologies, but this really seems like complexity in search of a
problem....

						- Ted
