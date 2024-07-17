Return-Path: <linux-kselftest+bounces-13825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572E99335E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 05:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5EC1F23A3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 03:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C47494;
	Wed, 17 Jul 2024 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWelCD8k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B969D51A;
	Wed, 17 Jul 2024 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188418; cv=none; b=SR6hVZ+MVrHHPFRd1mT/f8y/MS3V5TAKpSA6BI/G1BiUu2M0Tqm2RBA8MGkbjgpnV+EOifmnRdiPtLGSNsVB750K9dyDwg3UFTulNbEefsCjT1otaXTDj1/Kyw6SiC3UVoFuJWe5e85Klxcim1GQK/Wu49Dz5kXOZYFQt5D2vrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188418; c=relaxed/simple;
	bh=UX5Few9lIWfE7jJZCw+YlLNkyj0syCCjowl2Opf4AV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kuw7Omk8+MIcHRJjkqQ2rFreH80uMhvytHfF0UNIJR1PKfQGKhOVnHP7Xki+MbXB+mH97w6e0m57X9zbt282rs9+2GJ7lfK8/oOu/QHB7rma6O98VqYL38CPQt1etRSbH4E0gjGPZv2m4NgNaOqIctc+Xnm+0bh0lXrmUwK9fkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWelCD8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260AEC4AF0C;
	Wed, 17 Jul 2024 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721188418;
	bh=UX5Few9lIWfE7jJZCw+YlLNkyj0syCCjowl2Opf4AV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWelCD8kS4J6SJVOqkBVmaiAiYk2WK1RWvrSOo2wz+vrCPzqSyjoPGIV2ZwLGXS9Q
	 Y01t7mkMfvUoaN0FyB5mKT+36GnKTPc5zBT0g8FapKGVa0uvL3YanJuuED9Hry9Q2B
	 bH00piMf21T66Ny4VkXy8E+MnnnsRbxbyl5GBr6D0q6sehYRZh3hlKfL4iqg/PWL9p
	 NdCjXkYzRUw792dmIiDnF7IwwdI6fKYspihLFoxJl71Od0l57Ent/37Ugc3AUmCH+f
	 3UropW6JGK9xc76kPmFx81khuBicnRoWWv3IwP/EYcCIBrl/BZoW9noHmeOhg/dCrk
	 71P7M2rkzBVJQ==
Date: Tue, 16 Jul 2024 20:53:37 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: KUnit file naming conventions (was Re: [GIT PULL] execve updates for
 v6.11-rc1)
Message-ID: <202407161505.A5AE57869@keescook>
References: <202407150921.BD2B798C6A@keescook>
 <CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com>

On Tue, Jul 16, 2024 at 01:10:41PM -0700, Linus Torvalds wrote:
> On Mon, 15 Jul 2024 at 09:21, Kees Cook <kees@kernel.org> wrote:
> >
> >  fs/exec.c                                   |  49 ++++++++--
> >  fs/exec_test.c                              | 141 ++++++++++++++++++++++++++++
> 
> I've pulled this, but *PLEASE* don't do this.
> 
> This screws up my workflow of just using tab-completion for filenames.
> As a result, I absolutely abhor anybody who uses the same base-name
> for different things.
> 
> No, this is not the first time it happens, and it won't be the last.
> And we had that same horrific pattern for fs/binfmt_elf_test.c from
> before, and I didn't notice because it's not a core file to me, and I
> seldom actually edit it.
> 
> I would suggest that people use the patterns from lib/, which is
> admittedly a bit schizophrenic in that you can either use
> "lib/kunit/*.c" (probably preferred) or "lib/test_xyz.c".
> 
> (Other subsystems use a "tests" subdirectory, so we do have a lot of
> different ways to deal with this).
> 
> Any of those models will keep the unit testing parts clearly separate,
> and not mess up basic command line workflows.
> 
> But do *not* use this "*_test.c" naming model. It's the worst of all
> possible worlds.
> 
> Please?

Oh, sure, no problem! I have no attachment to this convention at all;
I was trying to follow the Kunit docs:
https://docs.kernel.org/dev-tools/kunit/style.html#test-file-and-module-names

If I look at the existing naming, it's pretty scattered:

$ git grep '^static struct kunit_suite\b' | cut -d: -f1 | sort -u

/test/*		 7
/tests/*	47
*-test.[ch]	27
*_test.[ch]	27
test-*.c	 1
test_*.c	10
*-kunit.c	 1
*_kunit.c	17
kunit-*.c	 2
kunit_*.c	 1

Should we go with "put it all under a 'tests' subdirectory" ?

So for fs/exec_test.c and fs/binfmt_elf_test.c, perhaps fs/tests/exec.c
and fs/tests/binfmt_elf.c respectively?

And for the lib/*_kunit.c files, use lib/tests/*.c ?

Then we can update the docs, etc.

-- 
Kees Cook

