Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68F6D40EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfJKNTN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 09:19:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43381 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728344AbfJKNTN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 09:19:13 -0400
Received: from callcc.thunk.org (guestnat-104-132-34-105.corp.google.com [104.132.34.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9BDJ2BT010295
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 09:19:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 63F8F42045A; Fri, 11 Oct 2019 09:19:02 -0400 (EDT)
Date:   Fri, 11 Oct 2019 09:19:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Iurii Zaikin <yzaikin@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, kunit-dev@googlegroups.com
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Message-ID: <20191011131902.GC16225@mit.edu>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 11, 2019 at 03:05:43AM -0700, Brendan Higgins wrote:
> That's an interesting point. Should we try to establish a pattern for
> how tests should be configured? My *very long term* goal is to
> eventually have tests able to be built and run without any kind of
> kernel of any kind, but I don't think that having a single config for
> all tests in a subsystem gets in the way of that, so I don't think I
> have a strong preference in terms of what I want to do.
> 
> Nevertheless, I think establishing patterns is good. Do we want to try
> to follow Ted's preference as a general rule from now on?

As I suggested on another thread (started on kunit-dev, but Brendan
has cc'ed in linux-kselftest), I think it might really work well if
"make kunit" runs all of the kunit tests automatically.  As we add
more kunit tests, finding all of the CONFIG options so they can be
added to the kunitconfig file is going to be hard, so kunit.py really
needs an --allconfig which does this automatically.

Along these lines, perhaps we should state that as a general rule the
CONFIG option for Kunit tests should only depend on KUINIT, and use
select to enable other dependencies.  i.e., for the ext4 kunit tests,
it should look like this:

config EXT4_KUNIT_TESTS
	bool "KUnit test for ext4 inode"
	select EXT4_FS
	depends on KUNIT
...

In the current patch, we use "depends on EXT4_FS", which meant that
when I first added "CONFIG_EXT4_KUNIT_TESTS=y" to the kunitconfig
file, I got the following confusing error message:

% ./tools/testing/kunit/kunit.py  run
Regenerating .config ...
ERROR:root:Provided Kconfig is not contained in validated .config!

Using "select EXT4_FS" makes it much easier to enable the ext4 kunit
tests in kunitconfig.  At the moment requiring that we two lines to
kunitconfig to enable ext4 isn't _that_ bad:

CONFIG_EXT4_FS=y
CONFIG_EXT4_KUNIT_TESTS=y

but over time, if many subsystems start adding unit tests, the
overhead of managing the kunitconfig file is going to get unwieldy.
Hence my suggestion that we just make all Kunit CONFIG options depend
only on CONFIG_KUNIT.

> I agree with Iurii. I don't think that this example alone warrants
> adding support for being able to read test data in from a separate
> file (I would also like some clarification here on what is meant by
> reading in from a separate file). I can imagine some scenarios where
> that might make sense, but I think it would be better to get more
> examples before trying to support that use case.

So what I was thinking might happen is that for some of the largest
unit tests before I would transition to deciding that xfstests was the
better way to go, I *might* have a small, 100k ext4 file system which
would checked into the kernel sources as fs/ext4/kunit_test.img, and
there would be a makefile rule that would turn that into
fs/ext4/kunit_test_img.c file that might look something like:

const ext4_kunit_test_img[] = {
      0xde, ...

But I'm not sure I actually want to go down that path.  It would
certainly better from a test design perspective to create test mocks
at a higher layer, such as ext4_iget() and ext4_read_block_bitmap().

The problem is that quite a bit of code in ext4 would have to be
*extensively* refactored in order to allow for easy test mocking,
since we have calls to sb_bread, ext4_bread(), submit_bh(), etc.,
sprinkled alongside the code logic that we would want to test.

So using a small test image and making the cut line be at the buffer
cache layer is going to be much, *much* simpler at least in the short
term.  So the big question is how much of an investment (or technical
debt paydown) do I want to do right away, versus taking a shortcut to
get better unit test coverage more quickly, and then do further tech
debt reduction later?

   	       	     	    	       - Ted
