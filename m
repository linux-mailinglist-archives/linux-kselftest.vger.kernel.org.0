Return-Path: <linux-kselftest+bounces-35641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D63AE4E06
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 22:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF1917CA65
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C429CB2D;
	Mon, 23 Jun 2025 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZUb9f1TE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9E19049B;
	Mon, 23 Jun 2025 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709909; cv=none; b=H4Khl0vOPzH/Gz+T1GHSlbnDUwd75DJCQXhYiRXr3ez6KgCEsC9yha7FQ3loEs7GPSVyb5uF5PuG37jS4eqZj1ahRB+qtnendzyjE1cJVsD4ugcyINJZMvTOBKkyP7HwxkKNSyJOA+L3jUvIR+Hh7CaJsmI/Y0jz39g8krs4ExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709909; c=relaxed/simple;
	bh=kuRHvIv37fumvM6+OPh0zwBgnRBW+kKD/tEayVDgNAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o99VMS7T03GH57/TsYyoYw6dLIIG8NmHBvcn2nF/uEEovV54pEVhNuUSja+ewZjsEXeGxe9THYsCqGIL1lW9zxIsM5m7Oq3N0y2E3AKw2auvbJ9/+x1NdYwtsKH3HeRKIGt7jWtbphWklXhWys7hJidh1KM3bfbz0nAK7enm/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZUb9f1TE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750709900;
	bh=kuRHvIv37fumvM6+OPh0zwBgnRBW+kKD/tEayVDgNAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUb9f1TE39uqGs5GA06UbSLPT04PnfAdKoL5LvjX9J8jxHZlkbekwOAfcCLuEPZIF
	 CKLFOwfQCySaDPvZeHFBSZnhBbTxsvh1Op9W40QgxpJed6O+h7nNSb75UeHG2oJySy
	 XiUtCCnVXki32nEg5jQF7W4IIGZDfDEopxUPxUx4=
Date: Mon, 23 Jun 2025 22:18:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] selftests/nolibc: rename Makefile
Message-ID: <0084290f-49b5-4599-953e-0db6bf46e32c@t-8ch.de>
References: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
 <20250620-nolibc-selftests-v1-3-f6b2ce7c5071@weissschuh.net>
 <20250621041421.GA26603@1wt.eu>
 <20db87b0-05ff-476b-a58f-d0945bfacf20@t-8ch.de>
 <20250621084739.GC26934@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250621084739.GC26934@1wt.eu>

On 2025-06-21 10:47:39+0200, Willy Tarreau wrote:
> On Sat, Jun 21, 2025 at 10:34:38AM +0200, Thomas Weißschuh wrote:
> > On 2025-06-21 06:14:21+0200, Willy Tarreau wrote:
> > > Hi Thomas,
> > > 
> > > On Fri, Jun 20, 2025 at 11:39:32PM +0200, Thomas Weißschuh wrote:
> > > > The nolibc tests are not real kselftests, they work differently and
> > > > provide a different interface. Users trying to use them like real
> > > > selftests may be confused and the tests are not executed by CI systems.
> > > > 
> > > > To make space for an integration with the kselftest framework, move the
> > > > custom tests out of the way.
> > > > The custom tests are still useful to keep as they provide functionality
> > > > not provided by kselftests.
> > > 
> > > I'm wondering, what prevents us from merging the new rules into the
> > > current makefile instead of renaming it, especially considering the
> > > fact that we initially took care of not confiscating the "all" target ?
> > 
> > We'll have conflicts around CFLAGS, the nolibc-test target and probably
> > other things.
> 
> OK I understand.
> 
> > It will also make everything harder to understand and may
> > break unexpectedly in the future.
> > 
> > > I'm asking because: 
> > > 
> > >   $ make -f Makefile.nolibc help
> > > 
> > > is clearly less convenient and intuitive than:
> > > 
> > >   $ make help
> > 
> > Is your issue specifically with the help target?
> 
> Not just but that's an entry point. Admittedly it's not a big problem,
> I was merely asking if there was a real reason for splitting them apart
> or if it was just to keep the stuff clean.
> 
> > We should be able to show the help message from the main Makefile with a
> > hint to the Makefile.nolibc.
> 
> I thought about it as well, we could have a help target in the main
> makefile that just emits "Please run make -f Makefile.nolibc with the
> following targets:", and then runs "make -f Makefile.nolibc help".

I'll do that.

> > Another, more general, possibility would be to move the special Makefile
> > to tools/testing/nolibc/ and keep only the selftest parts in
> > tools/testing/selftests/nolibc/.
> 
> I hadn't thought about this, but that could indeed make sense. Let's see
> later how it goes and let's not add burden about this for now. Please just
> keep your patch as-is.

Sounds good. Could you give a formal Ack for the patch/series?


Thomas

