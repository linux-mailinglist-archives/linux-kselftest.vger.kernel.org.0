Return-Path: <linux-kselftest+bounces-36566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5AAF9449
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15EF5A4DEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C23302051;
	Fri,  4 Jul 2025 13:33:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF872FC000
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636019; cv=none; b=M3kSVvQbNDkWbJTQMSZkPs2OmYFF4EGUjveoog5wBNHkhstsELPpueezlqm+eODCU37aINjQLBWvU3nEsSJtlYhm8oYSAuQBUMoRCe+no8TBvo83HZ5vPSRiFGV1BFTWBwYB7YI4FhPcs1uNfToY60x5PeIOQEeNUdyjTMU6gOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636019; c=relaxed/simple;
	bh=MXbicf/CN8RsEsRNgUbQUrnMIhrP14zCOu9f6J6vtIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmwKEc5AlsNAefjSjkqlzn/D97koVPQq4G7C6EMwx6W8P81NqoGykTiKFa0IR2cQMcH5pNK7hGuRrPaKiP+90DeGR1vHj7ohyqbVhdlkX7tHVQlpRaA61eed7r2eIEe8k8hSaORvfM7DZKR22TTembs8fugYPp/roxco8IAvjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 564DX9v6024345;
	Fri, 4 Jul 2025 15:33:09 +0200
Date: Fri, 4 Jul 2025 15:33:09 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, linux-kselftest@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [RFC v2] tools/nolibc: add sigaction()
Message-ID: <20250704133309.GA23995@1wt.eu>
References: <20250701122910.45823-1-benjamin@sipsolutions.net>
 <21cf1fee-21ce-43b2-95cc-18aa58adcd87@t-8ch.de>
 <c870d823e686c4b4ef6928d9ca0162d72e484339.camel@sipsolutions.net>
 <81dc0649-9abe-421d-a372-a346c329d3af@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81dc0649-9abe-421d-a372-a346c329d3af@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jul 04, 2025 at 12:50:32PM +0200, Thomas Weißschuh wrote:
> On 2025-07-02 17:33:24+0200, Benjamin Berg wrote:
> > On Wed, 2025-07-02 at 00:04 +0200, Thomas Weißschuh wrote:
> > > [SNIP]
> > > > --- a/tools/include/nolibc/arch-i386.h
> > > > +++ b/tools/include/nolibc/arch-i386.h
> > > > @@ -10,6 +10,19 @@
> > > >  #include "compiler.h"
> > > >  #include "crt.h"
> > > >  
> > > > +/* Needed to get the correct struct sigaction definition */
> > > > +#define SA_RESTORER	0x04000000
> > > > +
> > > > +/* Restorer must be set on i386 */
> > > > +#define _NOLIBC_ARCH_NEEDS_SA_RESTORER
> > > > +
> > > > +/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
> > > > +#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
> > > > +
> > > > +/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
> > > > +#include <asm-generic/signal.h>
> > > > +#include <asm-generic/siginfo.h>
> > > 
> > > This doesn't work if the user already has <linux/signal.h> included for
> > > some other reason. The symbol names will conflict.
> > 
> > I was thinking this is fine. Such a conflict already exists between the
> > normal glibc <signal.h> and <linux/signal.h>.
> 
> It would be enough to keep compatibility with glibc.
> But personally I'd like to make it work generally.
> 
> > So there would only be a
> > problem if the user is explicitly not including <signal.h> to then use
> > <linux/signal.h>. I doubt that makes sense.
> 
> Technically nolibc is always included as a whole, so any application
> using it would be prevented from using linux/signal.h.
> 
> Maybe Willy has some strong opinions.
> Otherwise I'm also fine if we keep this part as is for now.
> Then if everything else is addressed I'll try to actually implement my
> proposal on top.
> 
> Does this sound reasonable?

I think that userland application writers are used to seeing random
failures here and there when they start using linux/ without being invited
to do so. Of course it's never fun to deal with build failures, but the
effort spent overengineering solutions is often not worth being spent
when you figure that sometimes the next application you try will blatantly
fail again. I'd suggest that we stay on the pragmatic side of things: if
we find a solution that works fine for the common case, that may break for
rare cases that already break with glibc, I think we're already fine. That
doesn't mean we don't need to think about it, but it's not something urgent
nor that warrants taking more risks either.

I personally also think that we'll face an increasing amount of build
issue reports due to our attempt at being more compatible. Indeed, in the
past, one had to #ifdef all includes and pass -include nolibc on the gcc
command line. Nowadays by supporting a larger number of functions and
include file names, we encourage developers to try to simply switch their
libc for nolibc. We do know that the coverage remains low, and reports
will come proportionally to the ratio of apparent ease of use to feature
coverage. That's expected and we should try to resist feeling bad about
it. I don't think we'll ever aim at competing with glibc/musl for example,
so a little bit of application adaptation is expected from time to time.

Cheers,
Willy

