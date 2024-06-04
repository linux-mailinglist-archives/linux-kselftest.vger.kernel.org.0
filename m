Return-Path: <linux-kselftest+bounces-11209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872378FB880
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54781C23E04
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D15A14883B;
	Tue,  4 Jun 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hFtnqX57"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4E1487DC
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517226; cv=none; b=nsE3ZZJeDUQEGo146w6k05yhtnjGxeuasnkM12yYN8WQsA1Hgn7TxvQc8hWG8hob5U1eiZKR7rrzRgm8J25lBRJm1sVBo7YR9JfhET1c5yLQQRp1BluO2gEPPVXkDAqhhAEcA3VDV9u9KX8CrM8m64sBpcHxn84yRdjwTyxlwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517226; c=relaxed/simple;
	bh=LiSw4cTkRlKkl50Td/1EOWuYousa7uj5W+u2v+62BuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scU4YaDR0zRJepYovtYNzbBiNAeeKBy22UojSO4gqlb0LqZJvtTamg+Hd1O6WAMmA6zNuj3Rj95VIVim2m+7Zi2Y8hNBYZ9J+jnVttWBy1lGalyHwdQ/DQlEvaECdw1gHYWNdAMBVinBL01WY3ayujUwPq/khFmC5IAK/THFrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hFtnqX57; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VtwTB71FQzR2Y;
	Tue,  4 Jun 2024 18:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1717517214;
	bh=aNLMmrtRqyR3S0obQrH4DObn3P8MphMPMTJP3cciKvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hFtnqX57SJl/4Fh9aQvCi1KoonGg5N4DjhRPZByVGizbDmtLtvsZMh03LYRvUKPzh
	 oluqoBSNi6W59lxCYFr6Va/1Ifx551otm6KY9D1p5DEAHJdc3nW+DCr57SHC9r3grY
	 pCgBICWchLUQPM8ecx8uhp9WxlYZ68yjuYOOyKQc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VtwT80YykzC0N;
	Tue,  4 Jun 2024 18:06:51 +0200 (CEST)
Date: Tue, 4 Jun 2024 18:06:48 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Sasha Levin <sashal@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Shengyu Li <shengyu.li.evgeny@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jon Hunter <jonathanh@nvidia.com>, Ron Economos <re@w6rz.net>, 
	Ronald Warsow <rwarsow@gmx.de>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Will Drewry <wad@chromium.org>, kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v7 04/10] selftests/harness: Fix interleaved scheduling
 leading to race conditions
Message-ID: <20240604.KaT6shae5eip@digikod.net>
References: <20240511171445.904356-1-mic@digikod.net>
 <20240511171445.904356-5-mic@digikod.net>
 <9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk>
 <187423fb-ec78-4318-9da0-5b27df62b71f@sirena.org.uk>
 <9eb1e48e-b273-475a-9740-52deedf11ee2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9eb1e48e-b273-475a-9740-52deedf11ee2@sirena.org.uk>
X-Infomaniak-Routing: alpha

On Mon, Jun 03, 2024 at 06:22:32PM +0100, Mark Brown wrote:
> On Mon, Jun 03, 2024 at 05:27:52PM +0100, Mark Brown wrote:
> > On Mon, May 27, 2024 at 08:07:40PM +0100, Mark Brown wrote:
> 
> > > This is now in mainline and appears to be causing several tests (at
> > > least the ptrace vmaccess global_attach test on arm64, possibly also
> > > some of the epoll tests) that previously were timed out by the harness
> > > to to hang instead.  A bisect seems to point at this patch in
> > > particular, there was a bunch of discussion of the fallout of these
> > > patches but I'm afraid I lost track of it, is there something in flight
> > > for this?  -next is affected as well from the looks of it.

Thanks for the heads up.  I warned about not being able to test
everything when fixing kselftest last time, but nobody show up.  Is
there an easy way to run most kselftests?  We really need a (more
accessible) CI...

> 
> > FWIW I'm still seeing this on -rc2...
> 
> AFAICT this is due to the switch to using clone3() with CLONE_VFORK

I guess it started with the previous vfork() that was later replaced
with CLONE_VFORK.

> to start the test which means we never even call alarm() to set up the
> timeout for the test, let alone have the signal for it delivered.  I'm a
> confused about how this could ever work, with clone_vfork() the parent
> shouldn't run until the child execs (which won't happen here) or exits.
> Since we don't call alarm() until after we started the child we never
> actually get that far, but even if we reorder things we'll not get the
> signal for the alarm if the child messes up since the parent is
> suspended.
> 
> I'm not clear what the original race being fixed here was but it seems
> like we should revert this since the timeout functionality is pretty
> important?

It took me a while to fix all the previous issues and it would be much
easier to just fix this issue too.

I'm working on it.

