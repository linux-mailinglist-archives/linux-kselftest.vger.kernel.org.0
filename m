Return-Path: <linux-kselftest+bounces-14775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6612A946C17
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Aug 2024 05:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983311C2109E
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Aug 2024 03:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A801D28EA;
	Sun,  4 Aug 2024 03:47:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5EB79C2;
	Sun,  4 Aug 2024 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722743276; cv=none; b=fiaRlNcXuo4/09Pn51VKZSwHXjxSRv7GkPt0aiLcuBaWyXZcSC1jG4GHyVyEyQ/bJCq2vVtAp2ON/ssGMGdVpTi76XLvHFCisN6e5LRtelziwT0w+yjlFVSkQmLGo/eusSbnVtUgzC/moGeIzi34joKUE+xVdRCAj23bihfJI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722743276; c=relaxed/simple;
	bh=xV6PCKApYGWqspaDVcZIu+X0vPRPEpYJoJglCeKSETE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN7LkaW9iUV6vXyMACdPz8zQfW6H528+4ptHWyLZ5ILnqhYwr2FAgFOTPzN24UBzB74VUK6T9W9YppD3Vre6kfLjYJWfrr9lZi191jQR8H0azq7S7LyL8u3rLCOG0xqTAcyrFbI11+8lDcaKDFxnJa9U8OgM1Xo9rT3NcmGIgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4743lj87030262;
	Sun, 4 Aug 2024 05:47:45 +0200
Date: Sun, 4 Aug 2024 05:47:45 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/12] tools/nolibc: use attribute((naked)) if available
Message-ID: <20240804034745.GA30236@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-4-bc384269bc35@weissschuh.net>
 <20240803092558.GB29127@1wt.eu>
 <713abd5e-1f72-4cf8-9857-c6795b4b3187@t-8ch.de>
 <20240803183259.GA29716@1wt.eu>
 <d5c952c9-e7f6-4a01-9e43-2b19b586a95b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5c952c9-e7f6-4a01-9e43-2b19b586a95b@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Aug 03, 2024 at 10:55:07PM +0200, Thomas Weißschuh  wrote:
> Aug 3, 2024 20:33:11 Willy Tarreau <w@1wt.eu>:
> 
> > On Sat, Aug 03, 2024 at 08:28:08PM +0200, Thomas Weißschuh  wrote:
> >>> I think that it can resolve to roughly this:
> >>>
> >>> #if defined(__has_attribute) && __has_attribute(naked)
> >>> #  define __entrypoint __attribute__((naked))
> >>> #  define __entrypoint_epilogue()
> >>> #else
> >>> #  define __entrypoint __attribute__((optimize("Os", "omit-frame-pointer")))
> >>> #  define __entrypoint_epilogue() __builtin_unreachable()
> >>> #endif
> >>
> >> We would need to duplicate the define for the
> >> !defined(__has_attribute) case.
> >
> > I don't understand why. Above both are tested on the first line.
> > Am I missing something ?
> 
> This specifically does not work [0]:
> 
> a result, combining the two tests into a single expression as shown
> below would only be valid with a compiler that supports the operator but not
> with others that don't.

Ah I didn't remember about that one, thanks for the reference. Indeed
it's annoying then.

We have a similar construct in compiler.h:

  #if defined(__has_attribute)
  #  if __has_attribute(no_stack_protector)
  #    define __no_stack_protector __attribute__((no_stack_protector))
  #  else
  #    define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
  #  endif
  #else
  #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
  #endif /* defined(__has_attribute) */

Maybe it would be a good opportunity to have our own macro so as to
simplify such tests:

  #if defined(__has_attribute)
  #  define nolibc_has_attribute(x) __has_attribute(x)
  #else
  #  define nolibc_has_attribute(x) 0
  #endif

  #if nolibc_has_attribute(no_stack_protector)
  #  define __no_stack_protector __attribute__((no_stack_protector))
  #else
  #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector"
  #endif

Then:

  #if nolibc_has_attribute(naked)
  #  define __entrypoint __attribute__((naked))
  #  define __entrypoint_epilogue()
  #else
  #  define __entrypoint __attribute__((optimize("Os", "omit-frame-pointer")))
  #  define __entrypoint_epilogue() __builtin_unreachable()
  #endif

It's as you want. Either we take your #undef-based solution or we take
this opportunity to clean up as above. I'm fine with both.

Thanks!
Willy

