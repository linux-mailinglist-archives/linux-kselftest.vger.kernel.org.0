Return-Path: <linux-kselftest+bounces-36700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F25AFB729
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A211AA011C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9512D8390;
	Mon,  7 Jul 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mvW7QBgP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E42DECA3
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901745; cv=none; b=TpNwwZwetbZGWZfO/6MM4YKzCAHSZ0Jdd4WogeUEotnTcWwMOfHqAdF1i/UkKp4rutJDoUHqrBX/hvuoOwQkpciFd6iW72/b54TXNBgT1Gw6R6IoOs4UTtn+WOhf9NpJ55El9M6xcpvWHIMO7n+zn9oprqcGAw6++nf2MrerKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901745; c=relaxed/simple;
	bh=0GTg68eEFbUoEXF9/qnKRvAaLgMWt4WDvMEDTjYB1No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjZ6RJ6m+7z1AzYQbPG3nURW0ykFSUdtwFSyR9u+CBRbhYecVQ36M81yN05XBF9yGDDsgDu3R28J4LEpWY6kl0XshQJrBLpctExc1zvrjSWRicz+nm6Rx+zby8L8vq1U1pOZCBXB82mDemFqmX9V1pyz4t1SnmjQTPu0tvW2ki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mvW7QBgP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1751901735;
	bh=0GTg68eEFbUoEXF9/qnKRvAaLgMWt4WDvMEDTjYB1No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvW7QBgPnxzK1cIAMg1E5o2Nn9SBY7XrCsl0yVdO7TwoIU4PiRc2z6H6+PZjTs8EA
	 FmunQuTZDp1o2zpkpAQD1Tg93yZliuA48WcMywbG9kT66GqKy8Ld6fbhe+6zCYfA2X
	 SrSKmk0TQh9srxa3NP6Lu9aQD1nPdceEPLFCB9kA=
Date: Mon, 7 Jul 2025 17:22:14 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, 
	linux-kselftest@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [RFC v2] tools/nolibc: add sigaction()
Message-ID: <e8cb37f7-7762-43f1-a4d2-dd9e68138e06@t-8ch.de>
References: <20250701122910.45823-1-benjamin@sipsolutions.net>
 <21cf1fee-21ce-43b2-95cc-18aa58adcd87@t-8ch.de>
 <c870d823e686c4b4ef6928d9ca0162d72e484339.camel@sipsolutions.net>
 <81dc0649-9abe-421d-a372-a346c329d3af@t-8ch.de>
 <20250704133309.GA23995@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250704133309.GA23995@1wt.eu>

On 2025-07-04 15:33:09+0200, Willy Tarreau wrote:
> On Fri, Jul 04, 2025 at 12:50:32PM +0200, Thomas Weißschuh wrote:
> > On 2025-07-02 17:33:24+0200, Benjamin Berg wrote:
> > > On Wed, 2025-07-02 at 00:04 +0200, Thomas Weißschuh wrote:
> > > > [SNIP]
> > > > > --- a/tools/include/nolibc/arch-i386.h
> > > > > +++ b/tools/include/nolibc/arch-i386.h
> > > > > @@ -10,6 +10,19 @@
> > > > >  #include "compiler.h"
> > > > >  #include "crt.h"
> > > > >  
> > > > > +/* Needed to get the correct struct sigaction definition */
> > > > > +#define SA_RESTORER	0x04000000
> > > > > +
> > > > > +/* Restorer must be set on i386 */
> > > > > +#define _NOLIBC_ARCH_NEEDS_SA_RESTORER
> > > > > +
> > > > > +/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
> > > > > +#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
> > > > > +
> > > > > +/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
> > > > > +#include <asm-generic/signal.h>
> > > > > +#include <asm-generic/siginfo.h>
> > > > 
> > > > This doesn't work if the user already has <linux/signal.h> included for
> > > > some other reason. The symbol names will conflict.
> > > 
> > > I was thinking this is fine. Such a conflict already exists between the
> > > normal glibc <signal.h> and <linux/signal.h>.
> > 
> > It would be enough to keep compatibility with glibc.
> > But personally I'd like to make it work generally.
> > 
> > > So there would only be a
> > > problem if the user is explicitly not including <signal.h> to then use
> > > <linux/signal.h>. I doubt that makes sense.
> > 
> > Technically nolibc is always included as a whole, so any application
> > using it would be prevented from using linux/signal.h.
> > 
> > Maybe Willy has some strong opinions.
> > Otherwise I'm also fine if we keep this part as is for now.
> > Then if everything else is addressed I'll try to actually implement my
> > proposal on top.
> > 
> > Does this sound reasonable?
> 
> I think that userland application writers are used to seeing random
> failures here and there when they start using linux/ without being invited
> to do so. Of course it's never fun to deal with build failures, but the
> effort spent overengineering solutions is often not worth being spent
> when you figure that sometimes the next application you try will blatantly
> fail again. I'd suggest that we stay on the pragmatic side of things: if
> we find a solution that works fine for the common case, that may break for
> rare cases that already break with glibc, I think we're already fine. That
> doesn't mean we don't need to think about it, but it's not something urgent
> nor that warrants taking more risks either.

I'm all for keeping it simple. However here I think we disagree about
the aproach which would be simpler. As mentioned before let's go with
Benjamin's and I'll try to do my thing on top.
Then we can actually compare two working aproaches (if my idea does work).

<snip>

