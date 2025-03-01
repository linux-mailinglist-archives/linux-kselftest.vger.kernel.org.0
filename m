Return-Path: <linux-kselftest+bounces-27971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F16A4ACA6
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 16:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984887A48CE
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC91E231F;
	Sat,  1 Mar 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hMmyHrw9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D061DF97A;
	Sat,  1 Mar 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844357; cv=none; b=NLijTa2rh10Xlg/KZ6ws7rZEB6aHpsaF25y2vQHz0gKQSzRj2TJOvso0p1GF6ufflj4D4biXXsuVza1NudVxje7UKBjcmorq0aLlGVm4gdS+2l/G0m19lFfsi2pmV+8CE10qKXuMM8YPC3NkPicDfHnCZSFEPtVxfmLazJyS2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844357; c=relaxed/simple;
	bh=NzlLZVaJ/ndv4WHIym4H2JgsNhrYHdtRaCNDVbebWgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWrpE2lExX8Kr/JjoVefxbgfX002mMUON47GG//Iq+tyRsaqCpTMggtF38MxK4o+scjLj8UOCkGs8QfMCNrSGIVWdzP1YB24qihH93+IP1olSllb4soRgGvdtGnnj2J8s+kkGhtckAiTU0h6RhHc+3kytVqI6ltPi7U9GPQoqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hMmyHrw9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740844353;
	bh=NzlLZVaJ/ndv4WHIym4H2JgsNhrYHdtRaCNDVbebWgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMmyHrw9L5CoU5psy7Kgbu8mVzGU3s5jX2hiXWxvQRJnS9aYT0jYq2ZCWzg0v1OKc
	 078BDrzTzcQFXTOLFPjIdc8j8WaWcaPB+T/jzJvZCwCY8EqHojbnbQgi2nZN05oSTk
	 /Mv+tAchRSBTP2u7Ze4XiUZpQQ3d4SA6GzfC7uSY=
Date: Sat, 1 Mar 2025 16:52:32 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and
 N32/N64 ABIs
Message-ID: <44eee648-7764-4f2a-a232-8cbc73304867@t-8ch.de>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
 <20250301112102.GB18621@1wt.eu>
 <alpine.DEB.2.21.2503011543100.12637@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2503011543100.12637@angie.orcam.me.uk>

On 2025-03-01 15:47:52+0000, Maciej W. Rozycki wrote:
> On Sat, 1 Mar 2025, Willy Tarreau wrote:
> 
> > > Introduce support for the N32 and N64 ABIs. As preparation, the
> > > entrypoint is first simplified significantly. Thanks to Maciej for all
> > > the valuable information.
> > > 
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > > Changes in v2:
> > > - Clean up entrypoint first
> > > - Annotate #endifs
> > > - Link to v1: https://lore.kernel.org/r/20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net
> > 
> > OK I tested this series on my glinet (MIPS 24Kc, XARCH=mips32be) and
> > it worked fine, confirming that the stack alignments were not needed
> > and that the cleanup is quite welcome!
> 
>  I do hope it can wait two weeks until I'm back from my holiday.

Absolutely.

> I mean 
> to double-check the code visually and verify it with my R3000 and R4000 
> hardware (the latter for n64/n32 too), both of which are less forgiving 
> when it comes to instruction scheduling (I can check with a 74Kf too).

Your testing and feedback is very valuable, I'm happy to wait for it.

Thanks,
Thomas

