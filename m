Return-Path: <linux-kselftest+bounces-1926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C98133DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 16:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F3B28332C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904AA5B5D8;
	Thu, 14 Dec 2023 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="PLBrEZS7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B6126;
	Thu, 14 Dec 2023 07:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=lCD3+ezRCh
	upqVYtTsaKKo9VlIgR426K/Lj3+3UW9Lk=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=PLBrEZS7k+fCdGI14dJhB2v1zvxNnsWk9
	IRwAQdeRVII3pH1g8hvSp+4wXgOErhxma+bYwWSm5xauaUQ7o3ffHh9OwSJzgvv2i/oDYi
	VneeJ/r+5fLESiWCho3NPSaIEg6rUw+rjBNVz4k66s1r3y1wCdshT9EKiPlkNE4mbXJjX/
	SEWhtsxcFVJeJ9VkAIHz3IHXHnCGM+/CR6YeSCNq93e96JeAcu30WBjiCFdN0lHJdV98la
	hs2BPr3p9m/QblAm7HJWcF+fkLeiryOsxRzUdb1oxWVACdHezLgxWljow4bGg4NxJx2zfO
	ZJN7G4XowUUmBY/c7b9ZyrP2GrDzg==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id fdf4dfe5;
	Thu, 14 Dec 2023 08:04:23 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@google.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>, jeffxu@chromium.org,
    akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
    sroettger@google.com, willy@infradead.org,
    gregkh@linuxfoundation.org, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
In-reply-to: <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org> <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com> <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@google.com>
   message dated "Wed, 13 Dec 2023 16:35:26 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63611.1702566263.1@cvs.openbsd.org>
Date: Thu, 14 Dec 2023 08:04:23 -0700
Message-ID: <56221.1702566263@cvs.openbsd.org>

Jeff Xu <jeffxu@google.com> wrote:

> In short, BSD's immutable is designed specific for libc case, and Chrome
> case is just different (e.g. the lifetime of those mappings and requirement of
> free/discard unused memory).

That is not true.  During the mimmutable design I took the entire
software ecosystem into consideration.  Not just libc.  That is either
uncharitable or uninformed.

In OpenBSD, pretty much the only thing which calls mimmutable() is the
shared library linker, which does so on all possible regions of all DSO
objects, not just libc.

For example, chrome loads 96 libraries, and all their text/data/bss/etc
are immutable. All the static address space is immutable.  It's the same
for all other programs running in OpenBSD -- only transient heap and
mmap spaces remain permission mutable.

It is not just libc.

What you are trying to do here with chrome is bring some sort of
soft-immutable management to regions of memory, so that trusted parts of
chrome can still change the permissions, but untrusted / gadgetry parts
of chrome cannot change the permissions.  That's a very different thing
than what I set out to do with mimmutable().  I'm not aware of any other
piece of software that needs this.  I still can't wrap my head around
the assurance model of the design. 

Maybe it is time to stop comparing mseal() to mimmutable().

Also, maybe this proposal should be using the name chromesyscall()
instead -- then it could be extended indefinitely in the future...

