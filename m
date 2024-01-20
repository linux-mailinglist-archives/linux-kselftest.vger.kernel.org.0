Return-Path: <linux-kselftest+bounces-3272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EB833563
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 17:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24CDB2285C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1C10798;
	Sat, 20 Jan 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="ZBdxT4sm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3446FC12;
	Sat, 20 Jan 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705769951; cv=none; b=CkJ1wYBwf1s4be1tHBAnR1fPwdN9suDmFfxNE1VZId25uxb8Zu6jXOSv+q3/SCDRXqyLBMtQXr1OYKVZ4tfJkIvd9gV7X2exA51bHq+l3VXtmHUzRs2lxXfr5oR7IGxTDGONT0jt5Rk1MGwn5L6z3aE2hzhpNHllMdZOGqrtH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705769951; c=relaxed/simple;
	bh=1oROoR0nKlb6+UFwWsH51B+hCVBgpFqtLuP0ReDclek=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=NBEUN/rTK8MISvbxlrnFWT96uo4uI5aX2ieB24zqqbfqdUNtbIj4AfGFkU+CXbRErZqJmPxBx3/nQFwI04PoynHr/v21Vw2TPTx5pCWwZcNb320MijB1VQYm5fA7/RpK1nWXY0DyLUcitQoKfQub1xxWHrDBym8Dv5QL7XxM93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=ZBdxT4sm; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=1oROoR0nKl
	b6+UFwWsH51B+hCVBgpFqtLuP0ReDclek=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=ZBdxT4smVvYsJtQ1Adk4k08ujFn06ssfD
	pzMIYPOjC1tKV3j2+bVsOnBxn71Lxc2vl0zUnMnRcHB+Cds96zGYxDU0E4aUXN41+AY2q5
	rBMkkB9O5IWT+3RVaYTVl3SG3GtpfVaBsPRgW97s9brjJ5pRhmQX1fkG4PZgvhkIzW4NmU
	v3UH0nED5kIcWYnfDISQhINcSMbfynFn0WvMENDOiInSGX5ETzZmCKRaUPOUnGVXOeRspz
	WfpZowfZ5Lo0CY+OhlDlkM8aLZr3AsmioRInyAIBhiT6bk4ptR0pk5mnJTaIwlIJvmVw8H
	2+b79CKFwG3aw6ZKdpw/uAe9mTINg==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id cc644406;
	Sat, 20 Jan 2024 09:59:07 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Jeff Xu <jeffxu@chromium.org>,
    =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
    Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, willy@infradead.org,
    gregkh@linuxfoundation.org, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
In-reply-to: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org> <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com> <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com> <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com> <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com> <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com> <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com> <78111.1705764224@cvs.openbsd.org> <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
Comments: In-reply-to Linus Torvalds <torvalds@linux-foundation.org>
   message dated "Sat, 20 Jan 2024 08:40:09 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62327.1705769947.1@cvs.openbsd.org>
Date: Sat, 20 Jan 2024 09:59:07 -0700
Message-ID: <80897.1705769947@cvs.openbsd.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 20 Jan 2024 at 07:23, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > There is an one large difference remainig between mimmutable() and mseal(),
> > which is how other system calls behave.
> >
> > We return EPERM for failures in all the system calls that fail upon
> > immutable memory (since Oct 2022).
> >
> > You are returning EACESS.
> >
> > Before it is too late, do you want to reconsider that return value, or
> > do you have a justification for the choice?
> 
> I don't think there's any real reason for the difference.
> 
> Jeff - mind changing the EACESS to EPERM, and we'll have something
> that is more-or-less compatible between Linux and OpenBSD?

(I tried to remember why I chose EPERM, replaying the view from the
German castle during kernel compiles...)

In mmap, EACCESS already means something.

     [EACCES]           The flag PROT_READ was specified as part of the prot
                        parameter and fd was not open for reading.  The flags
                        MAP_SHARED and PROT_WRITE were specified as part of
                        the flags and prot parameters and fd was not open for
                        writing.

In mprotect, the situation is similar

     [EACCES]           The process does not have sufficient access to the
                        underlying memory object to provide the requested
                        protection.

immutable isn't an aspect of the underlying object, but an aspect of the
mapping.

Anyways, it is common for one errno value to have multiple causes.

But this error-aliasing can make it harder to figure things out when
studying a "system call trace" a program, and I strongly believe in
keeping systems are simple as possible.

For all the memory mapping control operations, EPERM was available and
unambiguous.

