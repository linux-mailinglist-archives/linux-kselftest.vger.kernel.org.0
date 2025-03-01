Return-Path: <linux-kselftest+bounces-27970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA1A4ACA1
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 16:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55A73B92B9
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5022D1DF980;
	Sat,  1 Mar 2025 15:47:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ABD35971;
	Sat,  1 Mar 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844077; cv=none; b=l3b3kFoQBFXL9lPOHuqw1cq+vCOuwRWhkQoxFjjaXQVxQewpnsc7QHbfZBPdQjLDu7cLDPSV6I/20YGKpZWSZo3wBTohr9Ij8WoJST6yjeRDSlyGOkm/8NyGwpRNVPsKS56ldTmcHvrMrGS+Cx6cdCf1vRMLn5ei+oo4t9WvKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844077; c=relaxed/simple;
	bh=fVxiK/9xFBzYeo6zfXt+0WUAGqyLDQgiie09E1wUsZI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=trDxsi39JO9dmhfOs12l7Fnj99dEoWcibyznfuWMwqLtGmWwa2ifovkr/il8+NlrRrYakt2vHxQ8khVq6Pop+7qnwsv0fVUjFVLogqdxxshgWwfDzmNu6AdCCRQkPkXWilM1hgjNhVsEKvq0HCbV/AAMee6loAhvzG16rrVRdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B8A7592009E; Sat,  1 Mar 2025 16:47:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A970B92009C;
	Sat,  1 Mar 2025 15:47:52 +0000 (GMT)
Date: Sat, 1 Mar 2025 15:47:52 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Willy Tarreau <w@1wt.eu>
cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
    Shuah Khan <shuah@kernel.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and
 N32/N64 ABIs
In-Reply-To: <20250301112102.GB18621@1wt.eu>
Message-ID: <alpine.DEB.2.21.2503011543100.12637@angie.orcam.me.uk>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net> <20250301112102.GB18621@1wt.eu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 1 Mar 2025, Willy Tarreau wrote:

> > Introduce support for the N32 and N64 ABIs. As preparation, the
> > entrypoint is first simplified significantly. Thanks to Maciej for all
> > the valuable information.
> >=20
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > ---
> > Changes in v2:
> > - Clean up entrypoint first
> > - Annotate #endifs
> > - Link to v1: https://lore.kernel.org/r/20250212-nolibc-mips-n32-v1-1-6=
892e58d1321@weissschuh.net
>=20
> OK I tested this series on my glinet (MIPS 24Kc, XARCH=3Dmips32be) and
> it worked fine, confirming that the stack alignments were not needed
> and that the cleanup is quite welcome!

 I do hope it can wait two weeks until I'm back from my holiday.  I mean=20
to double-check the code visually and verify it with my R3000 and R4000=20
hardware (the latter for n64/n32 too), both of which are less forgiving=20
when it comes to instruction scheduling (I can check with a 74Kf too).

  Maciej

