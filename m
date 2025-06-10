Return-Path: <linux-kselftest+bounces-34623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EBDAD441C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 22:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F5E177EDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632B265CAF;
	Tue, 10 Jun 2025 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ggxcbk4L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579823506D
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749588726; cv=none; b=XWWM440H2VWDbfMJknmYPHKkWNakNkto9RHZXaAhJDXFeDeuS/hG+u4wiqJMID7QNVD0SpBj7CLXN/bupb1YE2fTpqb/tgzlWxYcsHcyoP0k7oI0zA8cVBNNR2fhMEgFjMmHXR+tF2UsTWRdBzm0hFlP1v/+9/9Vl4dx9Gr+PUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749588726; c=relaxed/simple;
	bh=RwxasCzS5SjxC2a/m3Cgf5bT0J9a0n9iNFPaVYjOA1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSbI9Jpz10kk1y73R8mvqzbU7vYrr3WfHOZs7O2R9UnUmDaEQZ7BJK7wwqzDpJhNely4oSW0u08YmG2DReXb3jjMSl7Jp4LSDLmqM7tCfK8JOXUmLX30Z/S12a5Bp7/slAyASt7wWAntxoYfnHdo3wCTs6C4ChSFYRG2L33MVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Ggxcbk4L; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749588723;
	bh=RwxasCzS5SjxC2a/m3Cgf5bT0J9a0n9iNFPaVYjOA1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ggxcbk4L0g0ZWemWUmqjg6bloVffNafarU8KkWIZZENVQWgJUDQUy/eJB3xlhnCEQ
	 NRkblC+oFM6IwTz+PAdhzgNNudc2beJKrLwBpWJSP0K1lv6BZ93rjggKuXL49Ydprz
	 oiMiHCIwPzsO9i1EpvlRRYARigL6OyIGV/oOSN08=
Date: Tue, 10 Jun 2025 22:52:02 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org
Subject: Re: nolibc test target overwites kernel config without asking
Message-ID: <7ea4c9e5-c55e-40ca-986f-a827f04f1f9b@t-8ch.de>
References: <3d5128b9-b4b6-4a8e-94ce-ea5ff4ea655b@sirena.org.uk>
 <5df3037e-2486-43f2-9fc8-e0aeb716c848@t-8ch.de>
 <3f874365-c113-442c-a32f-f0b9611f999e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f874365-c113-442c-a32f-f0b9611f999e@sirena.org.uk>

On 2025-06-10 18:21:27+0100, Mark Brown wrote:
> On Tue, Jun 10, 2025 at 07:05:59PM +0200, Thomas Weißschuh wrote:
> > On 2025-06-09 17:42:47+0100, Mark Brown wrote:
> 
> > > KUnit deals with this by doing it's kernel build in a .kunit directory,
> > > it'd probably be good to do something similar for nolibc.
> 
> > I assume you are using "make" directly. For a more complete
> > kunit.py-like solution we have run-tests.sh, which does indeed use a
> > dedicated build directory.
> 
> Given that the tests were in tools/testing/selftests I initially tried
> to run them via the selftests build infra which didn't work since
> they're not glued into that at all and I ran into this as part of
> debugging.  It didn't actually occur to me to look anywhere other than
> the Makefile, that's how you normally invoke selftests.

Makes sense.

> Given that AFAICT the tests don't use any kselftest infrastructure or
> otherwise overlap with it I think it'd be better to move them to
> tools/testing/nolibc, that'd make it clearer that they're their own
> thing and avoid surprises.

Also makes sense. However I plan to make the tests compatible with
kselftests as one of the next steps. The custom logic will stay, but for
increased test coverage the tests should also work as regular selftests.


Thomas

