Return-Path: <linux-kselftest+bounces-35538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B36DAE2811
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01C81BC019B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE471A23A0;
	Sat, 21 Jun 2025 08:47:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC69149C41;
	Sat, 21 Jun 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495665; cv=none; b=df+eGTa6aDaTNrDeIVa/VAi9QFhQ+yVMs04AQKo6GAkABi+14WZun1XU2ikazrP/3+tUbVvLMcXpGo/K9FyqeubhjT1TrjDex4y9UiqO0no4ePT3hvy5ipj/mJ6Ak8uwgx31uDWTEOX4jyf3BVygGMNN0vdzJtXpmCHxuK/uuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495665; c=relaxed/simple;
	bh=bEnX1lr/fBedx4vzGgYMYRn4xNBRE4X3SQZFlixhEMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFGfZWjTDoAlFcRjvTAOiOW372t3QOztkwPWY8i2+g21jONqfTkQ83OykoIs7AaIO7iyY61Tct1faB6Og1EL4CfB7iVKLTqGlXJWwxdz33ICPqIAbBWFnJ0aNndYQuaSlJh2z3+A5yZo999gUZBZpry8C9Q6XXUgA0ZSugKTiAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 55L8ldQx026961;
	Sat, 21 Jun 2025 10:47:39 +0200
Date: Sat, 21 Jun 2025 10:47:39 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] selftests/nolibc: rename Makefile
Message-ID: <20250621084739.GC26934@1wt.eu>
References: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
 <20250620-nolibc-selftests-v1-3-f6b2ce7c5071@weissschuh.net>
 <20250621041421.GA26603@1wt.eu>
 <20db87b0-05ff-476b-a58f-d0945bfacf20@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20db87b0-05ff-476b-a58f-d0945bfacf20@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Jun 21, 2025 at 10:34:38AM +0200, Thomas Weißschuh wrote:
> On 2025-06-21 06:14:21+0200, Willy Tarreau wrote:
> > Hi Thomas,
> > 
> > On Fri, Jun 20, 2025 at 11:39:32PM +0200, Thomas Weißschuh wrote:
> > > The nolibc tests are not real kselftests, they work differently and
> > > provide a different interface. Users trying to use them like real
> > > selftests may be confused and the tests are not executed by CI systems.
> > > 
> > > To make space for an integration with the kselftest framework, move the
> > > custom tests out of the way.
> > > The custom tests are still useful to keep as they provide functionality
> > > not provided by kselftests.
> > 
> > I'm wondering, what prevents us from merging the new rules into the
> > current makefile instead of renaming it, especially considering the
> > fact that we initially took care of not confiscating the "all" target ?
> 
> We'll have conflicts around CFLAGS, the nolibc-test target and probably
> other things.

OK I understand.

> It will also make everything harder to understand and may
> break unexpectedly in the future.
> 
> > I'm asking because: 
> > 
> >   $ make -f Makefile.nolibc help
> > 
> > is clearly less convenient and intuitive than:
> > 
> >   $ make help
> 
> Is your issue specifically with the help target?

Not just but that's an entry point. Admittedly it's not a big problem,
I was merely asking if there was a real reason for splitting them apart
or if it was just to keep the stuff clean.

> We should be able to show the help message from the main Makefile with a
> hint to the Makefile.nolibc.

I thought about it as well, we could have a help target in the main
makefile that just emits "Please run make -f Makefile.nolibc with the
following targets:", and then runs "make -f Makefile.nolibc help".

> Another, more general, possibility would be to move the special Makefile
> to tools/testing/nolibc/ and keep only the selftest parts in
> tools/testing/selftests/nolibc/.

I hadn't thought about this, but that could indeed make sense. Let's see
later how it goes and let's not add burden about this for now. Please just
keep your patch as-is.

Thanks,
Willy

