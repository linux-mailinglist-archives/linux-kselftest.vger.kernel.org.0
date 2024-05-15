Return-Path: <linux-kselftest+bounces-10242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1602E8C60A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4066A1C20BE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC303B78D;
	Wed, 15 May 2024 06:15:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380603A29F;
	Wed, 15 May 2024 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753747; cv=none; b=AHChM/1PtCg5l9qnt4eMUfqf3ysXBSycmF63MRrLiB9j7YdbjeMfjFVVExR+8nNEAzvZgkfvRjFU0qqp2wWRn7qQQkdDwwsmRY7F34ROzvinvOwxk8hsNdWxjUAKmNDvps1nQYRiAsStxP+yex0vj1haH/g4DQc/v2aMFE5FMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753747; c=relaxed/simple;
	bh=5pN0Bv3ggxcBHrTLeGSKhEB6L3Vo7V64rQH/kwktpaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJGpv7IBpyTPRgpXlw8guNJUpl37FnGFOUUAyMZ4FMiPpywDwOMQxqetrstGXjaW72dujYwse+0bNZWOrYvDlgmqoqneq/u1a3tOEjJrXV1qrVnCDYs7qfLPukJcWAcQugz20NU77pFPRVy7q1yEFcxQ8QrOminjUZEkLXtiYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 44F6EquX027885;
	Wed, 15 May 2024 08:14:52 +0200
Date: Wed, 15 May 2024 08:14:52 +0200
From: Willy Tarreau <w@1wt.eu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theo de Raadt <deraadt@openbsd.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
        jeffxu@chromium.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, gregkh@linuxfoundation.org,
        usama.anjum@collabora.com, Liam.Howlett@oracle.com, surenb@google.com,
        merimus@google.com, rdunlap@infradead.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <ZkRS3DJQWgUnEBKo@1wt.eu>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net>
 <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org>
 <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
 <92453.1715730450@cvs.openbsd.org>
 <20240515025811.GA1232@1wt.eu>
 <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
 <CAHk-=wh_GHCwCiC-ZR=idjNEb0xZq20=fQnQxnjGkiq-ba5DLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_GHCwCiC-ZR=idjNEb0xZq20=fQnQxnjGkiq-ba5DLg@mail.gmail.com>

On Tue, May 14, 2024 at 09:14:37PM -0700, Linus Torvalds wrote:
> On Tue, 14 May 2024 at 20:36, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Guys, if you let untrusted code execute random system calls, the whole
> > "look, now unmap() acts oddly" IS THE LEAST OF YOUR ISSUES.

I totally agree with this, I'm more speaking about a more general
hardening measure, like what is commonly offered via prctl() and that,
for example, manages to mitigate the consequences of a successful RCE.

> Side note: it doesn't even help to make things "atomic". munmap() acts
> oddly whether it fals completely or whether it fails partially, and if
> the user doesn't check the result, neither case is great.

I don't find the "atomic" aspect that important either, however the
munmap() man page says:

  All  pages containing a part of the indicated range are un-
  mapped, and subsequent references to these pages will generate SIGSEGV.
  It  is  not an error if the indicated range does not contain any mapped
  pages.

This alone is an encouragement to not check the result. And BTW, what
should one do to try to repair the situation after a failed munmap() ?
It reads as "best effort" above: usually upon return, anything that
could be unmapped was unmapped. That's how I'm reading it. I think it's
a nice property that makes this syscall trustable by its users, and
contrary to the atomic aspect I would find it nice if munmap() would
properly unmap everything it can then return the error caused by the
encounter of a sealed area. For me that's even the opposite of an
atomic approach, it's really about making sure to best follow the
developer's intent regardless of any obstacles.

> If you want to have some "hardened mseal()", you make any attempt to
> change a mseal'ed memory area be a fatal error. The whole "atomic or
> not" is a complete red herring.

Yep, agreed.

> I'd certainly be ok with that. If the point of mseal is "you can't
> change this mapping", then anybody who tries to change it is obviously
> untrustworthy, and killing the whole thing sounds perfectly sane to
> me.
> 
> Maybe that's a first valid use-case for the flags argument.

That could be for that use case (developer doing mseal, attacker
trying munmap), indeed, though that couldn't cover for the other
way around (attacker doing mseal() in hope to make a future munmap()
fail).

That's what I like with prctl(), it offers the developer a panoply of
options to decide when and how to lock down a process in order to
mitigate consequences of exploited bugs.

And it could be independent on this series, by essentially focusing on
the ability to kill a process that fails to munmap() a sealed area. I.e.
no need to that that property on the area itself, it's a matter of whether
we consider the process sensitive enough or not.

Willy

