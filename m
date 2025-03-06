Return-Path: <linux-kselftest+bounces-28422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 669F3A55341
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA117673C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C6B25A350;
	Thu,  6 Mar 2025 17:42:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28361FF7C4;
	Thu,  6 Mar 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282936; cv=none; b=GJIM9QFAwHEFPyMaWyWoF8eheOxR4qr8J13IyPZeNF28dLdm6UyNQpD+ZhaIAoe9Rf+0UEtqu9uIoO0G1dabAVgTOc+B/1LoCSXnqaew4xXtnnN20yr1jLDNofQnOh4vFQGJagICo7+GOLhqoSADmqIntnTCD3ZMTwXvOuH7WLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282936; c=relaxed/simple;
	bh=iw+ETJ2+K7Tyuy8IC4lFQQIx0hmixpIjt52ylaXFvqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHRf7576x0KnFZBZZWa9bqBlJLoPtyG2c7Cz6qDtdM7BZDBoW7zTOkJgK7Js4pTu5LGnFSr1ECz0X/QD5FdEVp6tzYygEGxZFKr4FMUQvpBlE/y54unzkmJAAXBgxLWV8SCDDsTclJJeQM42VXQnuWHk+wafuDzmdfSW6+/t06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 526Hg7aZ025946;
	Thu, 6 Mar 2025 18:42:07 +0100
Date: Thu, 6 Mar 2025 18:42:07 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Louis Taylor <louis@kragniz.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/5] tools/nolibc: add support for openat(2)
Message-ID: <20250306174207.GD23569@1wt.eu>
References: <20250304075846.66563-1-louis@kragniz.eu>
 <20250304081116.GG9911@1wt.eu>
 <598c8370-507b-4d6f-bf7e-ce17a3b5dca0@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <598c8370-507b-4d6f-bf7e-ce17a3b5dca0@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Thu, Mar 06, 2025 at 06:22:45PM +0100, Thomas Weißschuh wrote:
> Hi Willy,
> 
> On 2025-03-04 09:11:16+0100, Willy Tarreau wrote:
> > On Tue, Mar 04, 2025 at 07:58:15AM +0000, Louis Taylor wrote:
> > > openat is useful to avoid needing to construct relative paths, so expose
> > > a wrapper for using it directly.
> > 
> > Reviewed the whole series, no comments from me. Let's wait for Thomas
> > to double-check but for me it's OK:
> > 
> > Acked-by: Willy Tarreau <w@1wt.eu>
> 
> Fairly happy with it, only some tiny nitpicks.

Thanks for double-checking, you caught way more things than me!

> > Thomas, since you already have plenty of changes in queue, do you mind
> > if I let you pick this series ?
> 
> Sure.
> 
> Also we need to send a PR to Shuah soon.
> I have some patches I want to get into it.
> In case you missed it:
> https://lore.kernel.org/lkml/20250305-nolibc-asm-headers-v1-1-f2053def2ee7@linutronix.de/

Yes I noticed them, these days I'm totally overwhelmed and tend to only
be able to have a look at them during my week-ends :-(

> Also the removal of the constructor order validation.

Yes, not sure I'll have time for it yet :-( I can try, though!

> Will you send a patch or should I?

As last time it will greatly help me if you take care of it. I
feel like I'm leaving you with all the work these days :-/

Cheers,
Willy

