Return-Path: <linux-kselftest+bounces-34211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B1ACC689
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 14:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB1A172074
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032E22D7B0;
	Tue,  3 Jun 2025 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oIyeAiXy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4D22F774;
	Tue,  3 Jun 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953584; cv=none; b=XDsSsyCNxzSibyUMUc38W5RITPcj78lWXD0EShp7X8hLEOod2y4JnKwhnI6783gIvMALl9BT/6PA50hJIX93GeBUJ+vF4VGVy//glSCpEKIk6WneCAdv6ON7ywbPDrWBAAYXJ5O7ReH7rwhpDGdRujkuyoPAzxZX6TqEL3C/odY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953584; c=relaxed/simple;
	bh=DluH728ii1EO703dxfxEx2UaGwKCfhTtTW0HCAZeC4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeAOmlcToPVqGvTdWbdIX+9Tr0tzcVIERERrAuNP8cgxb9XGwAt4DMxcu1NNyefqK1U0U8dsSapM4kC4DZEr4gwrf9x1UtUavQZeOHApy61nxy4LYiXwccDHQRnsrWXNm3T64qNdPzmsQf1C9kNWf7Kfm4FJDmqKrabsItl+94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oIyeAiXy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DluH728ii1EO703dxfxEx2UaGwKCfhTtTW0HCAZeC4Q=; b=oIyeAiXyOldaNVtPlBKKZqTGD3
	mpDagybwF9S+hqKsQSW31foTSUCygvvm5wxKgCjiGNRlSp7Nkii/G/lle/aZvQtrDX5u6tQnkTnr9
	PSQqrzLLfGGAAptQ1I+HnHxOMuO32HSdb5gjN/KA04ILM9U7jY+rK6wBQXsTWD/Ue0b9LBYeFgJva
	0CuUx6pySzhKoO/3JjDgsnwOSr3Kmw/St8ljRKEhtUfPNKlpvxNycRC83i/4YLpbOWSYeeEoDqFxX
	MFsHCU3T9lb5WX75CSy7Fbv7TsSGs2sno7k39o++eb3EN4GQT4RB0qtuUmucFxlG/XzNFilfK47iW
	ipNoANSQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMQiS-000000020dE-2aYw;
	Tue, 03 Jun 2025 12:26:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0037930057C; Tue,  3 Jun 2025 14:26:03 +0200 (CEST)
Date: Tue, 3 Jun 2025 14:26:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20250603122603.GK21197@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
 <202505301037.D816A49@keescook>
 <20250531102304.GF21197@noisy.programming.kicks-ass.net>
 <20250602-phenomenal-turkey-of-hurricane-aadcde@houat>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250602-phenomenal-turkey-of-hurricane-aadcde@houat>

On Mon, Jun 02, 2025 at 01:13:29PM +0200, Maxime Ripard wrote:

> > I can't operate kunit
>=20
> Why not?

Too complicated. People have even wrecked tools/testing/selftests/ to
the point that it is now nearly impossible to run the simple selftests
:-(

And while I don't mind tests -- they're quite useful. Kunit just looks
to make it all more complicated that it needs to be. Not to mention
there seems to be snakes involved -- and I never can remember how that
works.

Basically, if the stuff takes more effort to make run, than the time it
runs for, its a loss. And in that respect much of the kernel testing
stuff is a fail. Just too damn hard to make work.

I want to: make; ./run.sh or something similarly trivial. But clearly
that is too much to task these days :-(

I spent almost a full day trying to get kvm selftests working a couple
of weeks ago; that's time I don't have. And it makes me want to go hulk
and smash things.

