Return-Path: <linux-kselftest+bounces-13842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB809340C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA411C21824
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04067181CF2;
	Wed, 17 Jul 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gsmw6VHV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74C17E8FA;
	Wed, 17 Jul 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234951; cv=none; b=kbdlpIOr9lg24IxZsilU15bg3R1rLPJbo2Wf5vMUVPdL6SOIpaxMrXttXO+/VaSt6R9N1B/rhiWo5z5azA6oBm0aPkJaX0CYa+RUaMfMF1qV2Nwhvgmxg6K5SoVE8qhjPrEDf2MQwuQThBnSnPQGTi1BbbMpNYR3Iqzg7EzneHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234951; c=relaxed/simple;
	bh=/GcYn2xIOIxtMHa2a538mtKlhzi2C+ABgdKiJAb2UUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRnyYCZnW9IKiMY7lbFzJ24xfN0t+3HL9LFFZ1IhfYiNFoUx1TSQRJrRyG5xUOJUHmo76BECBFG2j28WwzGjB1tgatw1U5Kjffm18uxHWbjGVTbTu7LZ/cd/EsT30N/02R3IYDkv0PkvAzkq7pc/gtKCOr5gxffkMiykoQtT58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gsmw6VHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E9DC2BD10;
	Wed, 17 Jul 2024 16:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721234951;
	bh=/GcYn2xIOIxtMHa2a538mtKlhzi2C+ABgdKiJAb2UUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gsmw6VHVyAfb9umtgvpXXnze76ZyOluV6/YdVo9a5bPgHdj20MuhLiOEQguZ1FcJG
	 t+Hv3eqfsUEs3C2d0iC4oz9hUQJGxnPt3isA/QVfONZIwi3cnX+DMgLZxYd85dk9Gf
	 fBc2vwOXGiFTkZNZefEVk6j2LFb4LH6HzELPjGo6viiZ9qWHKdsLZulY/uugu8b7Vl
	 t6GiHFBjYotHSbRuJi7mPkHI/EgG3vtHt/Mii4I8rFmGmlWoxyyObZwnlxLO+lledq
	 UQHXVD6MxVjNMDsVbyzMWPcDb9RCsFLn9pnz5gC3zpAjpOzP0ky0yk4h3z32bNa+JI
	 eTNHHdwlbco+A==
Date: Wed, 17 Jul 2024 09:49:10 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: KUnit file naming conventions (was Re: [GIT PULL] execve updates
 for v6.11-rc1)
Message-ID: <202407170944.FFC1A804@keescook>
References: <202407150921.BD2B798C6A@keescook>
 <CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com>
 <202407161505.A5AE57869@keescook>
 <CABVgOS=pUdWb6NDHszuwb1HYws4a1-b1UmN=i8U_ED7HbDT0mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=pUdWb6NDHszuwb1HYws4a1-b1UmN=i8U_ED7HbDT0mg@mail.gmail.com>

On Wed, Jul 17, 2024 at 02:28:15PM +0800, David Gow wrote:
> On Wed, 17 Jul 2024 at 11:53, Kees Cook <kees@kernel.org> wrote:
> >
> > On Tue, Jul 16, 2024 at 01:10:41PM -0700, Linus Torvalds wrote:
> > > On Mon, 15 Jul 2024 at 09:21, Kees Cook <kees@kernel.org> wrote:
> > > >
> > > >  fs/exec.c                                   |  49 ++++++++--
> > > >  fs/exec_test.c                              | 141 ++++++++++++++++++++++++++++
> > >
> > > I've pulled this, but *PLEASE* don't do this.
> > >
> > > This screws up my workflow of just using tab-completion for filenames.
> > > As a result, I absolutely abhor anybody who uses the same base-name
> > > for different things.
> > >
> > > No, this is not the first time it happens, and it won't be the last.
> > > And we had that same horrific pattern for fs/binfmt_elf_test.c from
> > > before, and I didn't notice because it's not a core file to me, and I
> > > seldom actually edit it.
> > >
> > > I would suggest that people use the patterns from lib/, which is
> > > admittedly a bit schizophrenic in that you can either use
> > > "lib/kunit/*.c" (probably preferred) or "lib/test_xyz.c".
> > >
> > > (Other subsystems use a "tests" subdirectory, so we do have a lot of
> > > different ways to deal with this).
> > >
> > > Any of those models will keep the unit testing parts clearly separate,
> > > and not mess up basic command line workflows.
> > >
> > > But do *not* use this "*_test.c" naming model. It's the worst of all
> > > possible worlds.
> > >
> > > Please?
> >
> > Oh, sure, no problem! I have no attachment to this convention at all;
> > I was trying to follow the Kunit docs:
> > https://docs.kernel.org/dev-tools/kunit/style.html#test-file-and-module-names
> >
> > If I look at the existing naming, it's pretty scattered:
> >
> > $ git grep '^static struct kunit_suite\b' | cut -d: -f1 | sort -u
> >
> > /test/*          7
> > /tests/*        47
> > *-test.[ch]     27
> > *_test.[ch]     27
> > test-*.c         1
> > test_*.c        10
> > *-kunit.c        1
> > *_kunit.c       17
> > kunit-*.c        2
> > kunit_*.c        1
> >
> > Should we go with "put it all under a 'tests' subdirectory" ?
> 
> I think that's probably best overall. I still think it isn't quite as
> elegant as the suffix, but I'm happy to sacrifice theoretical elegance
> for a practical reason like this.

Okay, I will send a follow-up patch to rename things.

> > So for fs/exec_test.c and fs/binfmt_elf_test.c, perhaps fs/tests/exec.c
> > and fs/tests/binfmt_elf.c respectively?
> 
> We might want to use both the directory and the suffix, e.g.
> fs/tests/exec_test.c, because:
> - it makes sure the module name contains 'test', so it's obvious that
> it's a test and it is less likely to conflict.
> - this matches what drm is doing, and they've got the most tests thus far; and
> - we won't be renaming the file, just moving it, so it's less likely
> to cause friction with workflows, etc.
> 
> On the other hand, it has few disadvantages:
> - we end up with the same prefix issue with module names (e.g., for
> those who have tab completion for modprobe);
> - the module name can be changed in the Makefile anyway; and
> - it's ugly.
> 
> I'm leaning towards tolerating the ugliness and keeping _test suffixes
> on the files, at least for existing tests, but could be persuaded
> otherwise. I'd even grow to accept a test_ prefix if I had to, though
> that'd make my tab completion terribly boring.

I'd been using _test for #included files, and _kunit for kunit modules,
but perhaps this isn't a needed distinction?

> > And for the lib/*_kunit.c files, use lib/tests/*.c ?
> 
> Sounds good to me. I'd rather not put them in lib/kunit unless they're
> actively testing KUnit itself (which, under this scheme, would want to
> be in lib/kunit/tests).

Right -- I didn't want to confuse things between kunit itself and kunit
tests, so I too prefer the "tests" directory name.

> > Then we can update the docs, etc.
> 
> Even if we don't rename existing tests, we'll probably want to update
> these just to avoid making the problem worse.

Sounds good.

-- 
Kees Cook

