Return-Path: <linux-kselftest+bounces-27972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F121EA4ACD7
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD683AD3DA
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7051E32A2;
	Sat,  1 Mar 2025 16:23:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6906A1B3927;
	Sat,  1 Mar 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740846235; cv=none; b=tzj4MaUwvsOPmuato3mdUhMSITq9psqDWOKXtizKq3m/QFb+4zX5B0t+2/ggforIkTeJu+wot3JvBWPfnmblXzuN0fki74xaeNGXEr0CcxrVRz6pWeEzhBzO8uTJd72xQHD+7rGOmoxst8jeKGRZqWc+BdX5qpzZjoAWa/oS564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740846235; c=relaxed/simple;
	bh=5RFdXg+nb0DHFAfwBDuMvaTZ9TVk51ppGsFrP5txGok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ms+dG3uWgv8kEx6M5Eo4tZaTQ3TzWN4VQhyvuwci+KlVfaEREbX8I9u8CL0qGPdEFXryPz1NmZtNZ3vgAef5Ebeyt8I2zAyub3WccrClOPjp4Poar4qVcrGtOPkoYMEU4JYAvfCYYBr/2QIHSXQk0r0hgbMkBcAhGuK7/U/Dv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 521GNkPx013470;
	Sat, 1 Mar 2025 17:23:46 +0100
Date: Sat, 1 Mar 2025 17:23:46 +0100
From: Willy Tarreau <w@1wt.eu>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and
 N32/N64 ABIs
Message-ID: <20250301162346.GB13434@1wt.eu>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
 <20250301112102.GB18621@1wt.eu>
 <alpine.DEB.2.21.2503011543100.12637@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2503011543100.12637@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Mar 01, 2025 at 03:47:52PM +0000, Maciej W. Rozycki wrote:
> On Sat, 1 Mar 2025, Willy Tarreau wrote:
> 
> > > Introduce support for the N32 and N64 ABIs. As preparation, the
> > > entrypoint is first simplified significantly. Thanks to Maciej for all
> > > the valuable information.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
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
>  I do hope it can wait two weeks until I'm back from my holiday.  I mean 
> to double-check the code visually and verify it with my R3000 and R4000 
> hardware (the latter for n64/n32 too), both of which are less forgiving 
> when it comes to instruction scheduling (I can check with a 74Kf too).

Oh that would be great, thank you Maciej!

Willy

