Return-Path: <linux-kselftest+bounces-36542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF77AF90ED
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD11564426
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D100C2DA77B;
	Fri,  4 Jul 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MqNHx/Qw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310361F419B
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626251; cv=none; b=WveJTi38twRrRX7QQSv78kpX6zy/9Qg+H3V+rjlCIeNk6qJQQEEhB+VjCIBVVdUi22DBZ41nfyhMnio108o4oy0G/aJfmjzTxJcPQU71jKfbLafejsPG9pSYx05iT5zBQokYurOnOK5BgvpoGNBcoH733g6+8536/vVXwE3aC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626251; c=relaxed/simple;
	bh=vDm4PlOetYgrRJSB4GfGALzaBygRMzpTDzjUyFWTfOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpfl4E+1BceU/a4KdMhaTGxGT6g1JH7tUMSBccpJDUX/2meCusDU5zXKxqTbhe+lh+p7GpH3xcFbJ2DN+olrWRY3a4r9pmQngfMZRzLkL+A+xXC2gE6MvTU83MIUcOtrNKwPuejsNwaRocu9csrAo4paNe6hQQzCjM/dTy23EZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MqNHx/Qw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1751626240;
	bh=vDm4PlOetYgrRJSB4GfGALzaBygRMzpTDzjUyFWTfOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqNHx/QwHmTAGfsHel8KT/iKKV3AM2sEaiSMYO3fZy02WFC+b+eB8ul87AzSfmW7j
	 biA/0Uzk9yzK2nyrDS09BvxwdYvQfVAwx3pl5Z++BfGrMszCDSkLqW24UDUf5Gt7hs
	 C2EM2XNdnfHiyJQPy9cNpwxRNl7vA9WyTo8Pa8gI=
Date: Fri, 4 Jul 2025 12:50:32 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [RFC v2] tools/nolibc: add sigaction()
Message-ID: <81dc0649-9abe-421d-a372-a346c329d3af@t-8ch.de>
References: <20250701122910.45823-1-benjamin@sipsolutions.net>
 <21cf1fee-21ce-43b2-95cc-18aa58adcd87@t-8ch.de>
 <c870d823e686c4b4ef6928d9ca0162d72e484339.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c870d823e686c4b4ef6928d9ca0162d72e484339.camel@sipsolutions.net>

On 2025-07-02 17:33:24+0200, Benjamin Berg wrote:
> On Wed, 2025-07-02 at 00:04 +0200, Thomas Weißschuh wrote:
> > [SNIP]
> > > --- a/tools/include/nolibc/arch-i386.h
> > > +++ b/tools/include/nolibc/arch-i386.h
> > > @@ -10,6 +10,19 @@
> > >  #include "compiler.h"
> > >  #include "crt.h"
> > >  
> > > +/* Needed to get the correct struct sigaction definition */
> > > +#define SA_RESTORER	0x04000000
> > > +
> > > +/* Restorer must be set on i386 */
> > > +#define _NOLIBC_ARCH_NEEDS_SA_RESTORER
> > > +
> > > +/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
> > > +#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
> > > +
> > > +/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
> > > +#include <asm-generic/signal.h>
> > > +#include <asm-generic/siginfo.h>
> > 
> > This doesn't work if the user already has <linux/signal.h> included for
> > some other reason. The symbol names will conflict.
> 
> I was thinking this is fine. Such a conflict already exists between the
> normal glibc <signal.h> and <linux/signal.h>.

It would be enough to keep compatibility with glibc.
But personally I'd like to make it work generally.

> So there would only be a
> problem if the user is explicitly not including <signal.h> to then use
> <linux/signal.h>. I doubt that makes sense.

Technically nolibc is always included as a whole, so any application
using it would be prevented from using linux/signal.h.

Maybe Willy has some strong opinions.
Otherwise I'm also fine if we keep this part as is for now.
Then if everything else is addressed I'll try to actually implement my
proposal on top.

Does this sound reasonable?


Thomas

