Return-Path: <linux-kselftest+bounces-14772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCAA946ADE
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 20:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56129281479
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401217C6D;
	Sat,  3 Aug 2024 18:33:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75017BD2;
	Sat,  3 Aug 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709990; cv=none; b=DkXZZEy0hf0TSU1yUdUzau+q8k9cpo4WqxbUQyEm7941zxyGr5vHmYYnWQGyRv/90Xp68IrpliZjaxj2D0XOmdFyfFKstPFNBqlgjxMF2616pkfLSy+J0JTX9syQ2eEh8NwSXT+X6JgO/wWOYMFqTSs6OtuEKCD2eKqalMBMlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709990; c=relaxed/simple;
	bh=PnZH+vTma2Y33lqChWnEGke08kLqhXUVigad5AFAW9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh7wzl+gXtDcnSDeSu/XqgW3Xe7ode8R2DiKqMb3JqD7zWTJWNqVbqhlez6V/TCBP2N6aztzrI77ExeNZlLvdpnwO0GdpWNXHJQ3WJWlrmUV6RRA8XoXaW9i1ExZ79HtO1rkzrjRS9zg9BHdLkcCtbCylWBj5xfWbB69X+USnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 473IWxZY029719;
	Sat, 3 Aug 2024 20:32:59 +0200
Date: Sat, 3 Aug 2024 20:32:59 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/12] tools/nolibc: use attribute((naked)) if available
Message-ID: <20240803183259.GA29716@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-4-bc384269bc35@weissschuh.net>
 <20240803092558.GB29127@1wt.eu>
 <713abd5e-1f72-4cf8-9857-c6795b4b3187@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <713abd5e-1f72-4cf8-9857-c6795b4b3187@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Aug 03, 2024 at 08:28:08PM +0200, Thomas Weißschuh  wrote:
> > I think that it can resolve to roughly this:
> >
> > #if defined(__has_attribute) && __has_attribute(naked)
> > #  define __entrypoint __attribute__((naked))
> > #  define __entrypoint_epilogue()
> > #else
> > #  define __entrypoint __attribute__((optimize("Os", "omit-frame-pointer")))
> > #  define __entrypoint_epilogue() __builtin_unreachable()
> > #endif
> 
> We would need to duplicate the define for the
> !defined(__has_attribute) case.

I don't understand why. Above both are tested on the first line.
Am I missing something ?

> I wanted to avoid that duplication.
> > What do you think ?
> 
> With the reasoning above I'll let you choose.

I'm fine with avoiding duplication, I just don't understand why there
should be.

Willy

