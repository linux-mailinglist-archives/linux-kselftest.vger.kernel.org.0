Return-Path: <linux-kselftest+bounces-10243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B18C61AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 09:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA304B2246A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 07:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66342072;
	Wed, 15 May 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zu18lLj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918D4594C;
	Wed, 15 May 2024 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758001; cv=none; b=rkQk/2JDXzuDBn0u3ou39duc37HLxxOfh+AZi0pRcoWZNenHJbLSJ+HpGHQDa6qjxtBPdISIL5NnA74u/IgOCXIqqq7msRw0/jAbwylYd4YDwohCpYnvY2axekvvRTMsrhZf24Wuj+bEBEg2H91P+ovzGwdCIJ++G+7AF9hwN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758001; c=relaxed/simple;
	bh=u8ecY2pkyep2NyTRX/R5D56dmzsHqbHlEZaU3YPXR3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxtanXmJ/tpK/ggrPrttjdTyfLw7nI2rXn/+hhAjdxCKlLNnmqh6FIzxyQNauEdwu1H2E6T+srj28+Ha1O2Sy4YrSBgiKHHZq5K1BV9cjWL47wZrLmt/TAP1UA8hewnWNcBUPn8doEjy/gogi9WOMIXYgrnsuJAnSMGXPe1paoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zu18lLj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E36FC32781;
	Wed, 15 May 2024 07:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715758000;
	bh=u8ecY2pkyep2NyTRX/R5D56dmzsHqbHlEZaU3YPXR3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zu18lLj6wD+SQ+PEHwPoC0umWDimHHx8OOEJvIFH0BZNjkEzdR2IYdJrBvHsv+gVa
	 pnbh+DitHPUnTbr0LhnC/eZcJ2CVBISE1+94naPwXlVv7mWQi81tMXeG3l6bSzUWaE
	 O6hOjtRAbvNPaHgraHzNl7essY8CpZY6rLTg1fAw=
Date: Wed, 15 May 2024 09:26:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Liaw <edliaw@google.com>
Cc: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, Mark Brown <broonie@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] kselftest: Add a ksft_perror() helper
Message-ID: <2024051505-french-spoiled-d23c@gregkh>
References: <20240430010628.430427-1-edliaw@google.com>
 <2024043037-debate-capsize-e44c@gregkh>
 <CAG4es9VL8CdROKVygYi3YAo3ZuugXgiyt6uhf+3yq6s8iKfQeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG4es9VL8CdROKVygYi3YAo3ZuugXgiyt6uhf+3yq6s8iKfQeg@mail.gmail.com>

On Tue, Apr 30, 2024 at 10:29:43AM -0700, Edward Liaw wrote:
> On Tue, Apr 30, 2024 at 12:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Apr 30, 2024 at 01:06:27AM +0000, Edward Liaw wrote:
> > > From: Mark Brown <broonie@kernel.org>
> > >
> > > [ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]
> > >
> > > The standard library perror() function provides a convenient way to print
> > > an error message based on the current errno but this doesn't play nicely
> > > with KTAP output. Provide a helper which does an equivalent thing in a KTAP
> > > compatible format.
> > >
> > > nolibc doesn't have a strerror() and adding the table of strings required
> > > doesn't seem like a good fit for what it's trying to do so when we're using
> > > that only print the errno.
> > >
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > > Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers test to generate KTAP output")
> > > Signed-off-by: Edward Liaw <edliaw@google.com>
> > > ---
> > >  tools/testing/selftests/kselftest.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> >
> > This commit is already in 6.6.29, why submit it again?
> 
> Hi Greg,
> I double checked and I don't see this commit in 6.6.29.   As far as I
> can tell the earliest it has been merged is in 6.7.1.  Do you mind
> rechecking?

My fault, yes, you are right, it is not in 6.6.y, I don't know what I
was looking at.

Can you resubmit it if it really is needed there?

thanks,

greg k-h

