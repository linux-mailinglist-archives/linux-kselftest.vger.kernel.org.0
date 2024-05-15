Return-Path: <linux-kselftest+bounces-10218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 108978C5F33
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 04:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E17B21A60
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCA2F874;
	Wed, 15 May 2024 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="EVzA9XNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B917C96;
	Wed, 15 May 2024 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740961; cv=none; b=QFZp6jR7FV2rEdphHfDQoRwnz+Tj6MqaKDOA4LPFb//2tXK9JrjhSiX9jfWbbowwvfPorLocg7dmzovk2uISNiAHfOJsHu6tc8s9PziRVhkkVNfzISoGCPGWZoOnkRDtmSD9tr5BRsCsm/FTALuRM6KIqntsWwdBWWsUH7jPHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740961; c=relaxed/simple;
	bh=E/eITmSfv/hukN66zjfP822dc02uc7jnjBNrPzQ6vNk=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=dYrEr6iDgTgdyzfkVQdp3ksjSCW7ATRGn7/3HEmS/xI8a+xV0nF8iw18r0gPl1mdzK9OE0xMj5YA1DOs0htzhdZDoV+wq52kNR7oT/w6LMN2Tu1HsO1Zjrncen7n+2ccAtKDM3Xo68nN4ReJgDvUT+v0CkzJWMSzo94wzGtMT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=EVzA9XNP; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=E/eITmSfv/
	hukN66zjfP822dc02uc7jnjBNrPzQ6vNk=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=EVzA9XNPb+gPk9asC5OFVNyHR+i0fVDrX
	z9ATBDqxXlTOWBjRzskA+p4lrJb8vGvkmGIahadIO+N6X9VTQdg+upE34qLc8nykHKnuY4
	wqNDC2Q0W5Oznjn2CSqtM84yOm6dPwVrEqedE0/6mmhog1vx9pEaabKX1Px+VovNJbW9tJ
	VHPvFyJlsKPFNTvh6V2NyZhzfdcuYz2xi1w6ovAUxkwjMkRT6lNcBvtEjguIqLUx1OHff4
	5ethYU+X1oK6WAP/fCgIjJ+r2iQ0CdxRD0WnGC/RI18BOMMGW0/C9kcQzAuugpakmsH6Db
	jPJkuaz3YI2MbHRwYImoyZOwLf7SA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id b934a569;
	Tue, 14 May 2024 20:42:38 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    gregkh@linuxfoundation.org, usama.anjum@collabora.com,
    Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
In-reply-to: <CAHk-=wj=Yb1r_g=geQe8YDGv-TA-UQBQe6-OVhA8FOGjWKnQmA@mail.gmail.com>
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org> <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org> <56001.1715726927@cvs.openbsd.org> <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com> <16982.1715734632@cvs.openbsd.org> <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com> <84192.1715737666@cvs.openbsd.org> <CAHk-=wj=Yb1r_g=geQe8YDGv-TA-UQBQe6-OVhA8FOGjWKnQmA@mail.gmail.com>
Comments: In-reply-to Linus Torvalds <torvalds@linux-foundation.org>
   message dated "Tue, 14 May 2024 19:28:54 -0700."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58986.1715740958.1@cvs.openbsd.org>
Date: Tue, 14 May 2024 20:42:38 -0600
Message-ID: <75628.1715740958@cvs.openbsd.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 14 May 2024 at 18:47, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > Regarding mprotect(), POSIX also says:
> >
> >     An implementation may permit accesses other than those specified by
> >     prot; however, no implementation shall permit a write to succeed where
> >     PROT_WRITE has not been set or shall permit any access where PROT_NONE
> >     alone has been set.
> 
> Why do you quote entirely irrelevant issues?
> 
> If the mprotect didn't succeed, then clearly the above is irrelevant.

Imagine the following region:


    <--------------------------------------------- len
    [region PROT_READ] [region PROT_READ + sealed] 
addr ^

then perform
    mprotect(addr, len, PROT_WRITE | PROT_READ);

This will return -1, with EPERM, when it encounters the sealed region.

I believe in Linux, since it has not checked for errors as a first
phase, this changes the first region of memory to PROT_READ |
PROT_WRITE.  Liam, is that correct?  If I am correct, then this
follows:

So tell me -- did the mprotect() system call succeed or did not it
succeed?

If EPERM means it did not succeed, then why is the first region now
writable?

Immediately after this "call that failed", the process can perform a
write to that first region.  But no succesful system call was made to
change that memory to PROT_WRITE.

Alternatively, does EPERM mean it did not completely fail, and therefore
it is OK that that the prot value has been applied?  That's really obscure,
and undocumented.

In any case it seems, PROT_WRITE can be set on memory, and it is even
more pointless than before for userland to check the errno *because you
can't determine the resulting protection on every page of memory.  It's
all a mishmash after that.

(There is no POSIX system call to ask "what is the permission of a page or
region).

> Theo, you're making shit up.

I'm trying to have a technical discussion.  Please change your approach,
Linus.



