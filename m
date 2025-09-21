Return-Path: <linux-kselftest+bounces-42026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A65B8E157
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 19:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6B41786AA
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DF24A04D;
	Sun, 21 Sep 2025 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="HJBhxBT+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700991B87E8;
	Sun, 21 Sep 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474549; cv=none; b=tuAlqQwTeHBWYdQmEz0Q5K84nCBcvBiZaEiCTEtIwYkgB75l+vx+EUFD9EIZg4qIoRtXCUUeazWvuPyT+MHc0wymjOvCy2Q66TfjLg2Pob3th6XhTUgpM08P4Tt4ftUbonD4eSP+t/J/qZrB3ZeHskgQPfCR64yhypfmrEvIVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474549; c=relaxed/simple;
	bh=FME+tEtqslZ027V3OHDQSzk/PKBqaB0CoA6wSgJsij4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9m8zkXM7N1Z2Rx7btD3Y8IYmc9dYp40xRkwaPqhbHbdhjPfYqRZvJg3S8Oei3DBOBi5Cxf3nnByOPAlLetuX6SbY3gs8CR8s/n0MJFUFX3K+QvepbD4Pi3CfdbcIwsrXakifm8tjFzqIN0Y276elxL9vB/Wr8w8/Lf/mL5pQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=HJBhxBT+; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758474542; bh=InYdCqa1ZArFVs0L1uXXsNHExwtLRBKBRS0bupvSfvU=;
	h=From:Message-ID:From;
	b=HJBhxBT+5TaX/gUydnZ0Jew3fCSABw1LI/Hlmiz2sqygPV4fSBd//ko4Jjm7XOffx
	 Jpc2MqoPalPWp6oPKYYNNLTnD67WIUBVAkCcLfevq6WMMeusCgXyu6OA6/iHIQpBHa
	 ufh4XSkZHUN4An9tM0Uco5y95pRtpEpgkYSiWGtU=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id D9602C072E;
	Sun, 21 Sep 2025 19:09:02 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58LH91e4028419;
	Sun, 21 Sep 2025 19:09:01 +0200
Date: Sun, 21 Sep 2025 19:09:01 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921170901.GB28238@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Sep 21, 2025 at 06:37:30PM +0200, Thomas Weiﬂschuh wrote:
> On 2025-09-21 09:55:11+0200, Willy Tarreau wrote:
> > Hi Benjamin,
> > 
> > On Fri, Sep 19, 2025 at 05:34:12PM +0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> > > the perror function does not make any sense then and cannot compile.
> > > 
> > > Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > >  tools/include/nolibc/stdio.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > > index 7630234408c5..c512159b8374 100644
> > > --- a/tools/include/nolibc/stdio.h
> > > +++ b/tools/include/nolibc/stdio.h
> > > @@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format, ...)
> > >  	return ret;
> > >  }
> > >  
> > > +#ifndef NOLIBC_IGNORE_ERRNO
> > >  static __attribute__((unused))
> > >  void perror(const char *msg)
> > >  {
> > >  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
> > >  }
> > > +#endif
> > 
> > Please instead place the ifndef inside the function so that code calling
> > perror() continues to build. The original goal of that macro was to
> > further shrink programs at the expense of losing error details. But we
> > should be able to continue to build working programs with that macro
> > defined. There's nothing hard set in stone regarding this but here it's
> > easy to preserve a working behavior by having something like this for
> > example:
> > 
> >   static __attribute__((unused))
> >   void perror(const char *msg)
> >   {
> >  +#ifdef NOLIBC_IGNORE_ERRNO
> >  + 	fprintf(stderr, "%s\n", (msg && *msg) ? msg : "unknown error");
> >  +#else
> >   	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
> >  +#endif
> >   }
> 
> For the plain `errno` variable and printf(%m) we don't have such
> fallbacks. With NOLIBC_IGNORE_ERRNO the compilation either fails or the
> results are undefined. Personally I prefer not defining perror() here.

For me it's still a problem because that breaks the original purpose and
current behavior. You cannot anymore compare the size of with/without errno
for example, like here:

   text    data     bss     dec     hex filename
  20659      24   39424   60107    eacb init
  19836      24   39424   59284    e794 init-noerrno

Perror doesn't just display the error name/number, it also prints a message
about that error that doesn't need errno.

For "%m", that's fair enough, I didn't notice that one. We could imagine
improving it by just emitting "?" or any such thing. But right now it will
indeed proceed like you describe (that's already the case, it's not changed
by this patch).

I don't want to block that patch but I'm annoyed that it unfairly blocks a
legitimate error function that normally provides sufficient context in error
paths so that errno can be ignored, such as here:

   if (open(path, O_RDONLY) < 0) {
        perror("open()");
        return -1;
   }

What's even more problematic is that Benjamin precisely fixed two other
breakage cases in the same series for the same reason that they were
blocking the build without errno, so it would be more consistent that
this one isn't newly broken.

Willy

