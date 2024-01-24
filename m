Return-Path: <linux-kselftest+bounces-3486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E706A83B320
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253EA1C23523
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78548133426;
	Wed, 24 Jan 2024 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="0o7fBzG7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09613341F;
	Wed, 24 Jan 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128624; cv=none; b=YozqtUEClP0s8706fT6srqV0ncu3sHGPB2XAXw3A+udL71L5/IS9G+TXT+cX7SA31XmdSt0q85KjDHq14OI4oNbqJGgU4AKeKt+1pDXTHt6CQKUhq5wU2/mloeWS6c80AQHo3XX4isY6r3L0G+bG1JL+l0NMD7Ds3Ud/ooM82Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128624; c=relaxed/simple;
	bh=qAbil4CI0GaxYPzRWGXFLvmaTeTW+0u/q2km4lPInBk=;
	h=From:To:Subject:In-reply-to:References:MIME-Version:Content-Type:
	 Date:Message-ID; b=Z68Hrty6OC8nL/Bhsw16jpD4SW5EIEVVPwF+6hzyqXwCtfNRWxcUyVW7VdLyf947DnEIj9KEQozn8q2eR0oq5AE+nb5YJZvtEvpxKE4YznBQYnHmkZreftELPpV8xPztbsJV4R4p+2wcdXORjxa4mz6fVTQmBzwcTu4cPsZPgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=0o7fBzG7; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=qAbil4CI0G
	axYPzRWGXFLvmaTeTW+0u/q2km4lPInBk=; h=date:references:in-reply-to:
	subject:to:from; d=openbsd.org; b=0o7fBzG7svwTo7Kh/7vEMdx4zsLVBwfhUjx7
	LzKHCLemDhJUdJ7kBZaqq01ZZ6mlhV0jWW06VsG6SUsO7zj0FeYsoxnPL9UtPen++V47RQ
	ErfXssKrPcoH8QLd+hU+jukqcPmjimWifKkdopTDURMn9dO7cqzVoKyFukCGefgWOYXTio
	xURM/Wusq1CJvrg1T+Azs3147HZSSvjL+B5MXaUTyh8ZOw3ldi6leFFdbZoK66gbnu2Eg3
	///ySdBAMqzJCTTXtIrNNoQccj9/O8GFah537gVUnEWwIe/8wXXjb5KYV0+qI/7G4QlCcH
	GnAgpHEqv2ufgXUk2hJGztMgSA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 065cb52c;
	Wed, 24 Jan 2024 13:37:01 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
    Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    torvalds@linux-foundation.org, usama.anjum@collabora.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
                  Jeff Xu <jeffxu@chromium.org>,
                  akpm@linux-foundation.org, keescook@chromium.org,
                  jannh@google.com, sroettger@google.com,
                  willy@infradead.org, gregkh@linuxfoundation.org,
                  torvalds@linux-foundation.org,
                  usama.anjum@collabora.com, rdunlap@infradead.org,
                  jeffxu@google.com, jorgelo@chromium.org,
                  groeck@chromium.org, linux-kernel@vger.kernel.org,
                  linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
                  pedro.falcato@gmail.com, dave.hansen@intel.com,
                  linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 2/4] mseal: add mseal syscall
In-reply-to: <20240124200628.ti327diy7arb7byb@revolver>
References: <20240122152905.2220849-1-jeffxu@chromium.org> <20240122152905.2220849-3-jeffxu@chromium.org> <20240123181457.idckaydk7dt7q2qy@revolver> <CABi2SkX=wKnHmooxXzBnJxxmtfSjvfgYabN1Wh1LxFYjtFoFaQ@mail.gmail.com> <20240124200628.ti327diy7arb7byb@revolver>
Comments: In-reply-to "Liam R. Howlett" <Liam.Howlett@Oracle.com>
   message dated "Wed, 24 Jan 2024 15:06:28 -0500."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54058.1706128621.1@cvs.openbsd.org>
Date: Wed, 24 Jan 2024 13:37:01 -0700
Message-ID: <98656.1706128621@cvs.openbsd.org>

Liam R. Howlett <Liam.Howlett@Oracle.com> wrote:

> > Adding mseal() into picture, however, the heap is then sealed
> > partially, user can still free it, but the memory remains to be RO,
> > and the result of brk-shrink is nondeterministic, depending on if
> > munmap() will try to free the sealed memory.(brk uses munmap to shrink
> > the heap).

"You are holding it wrong".

> > [...]. We could document above mentioned limitations so devs are
> > more careful at the time to choose what memory to seal.

You mean like they need to be careful what memory they map, careful
what memory they unmap, careful what they do with mprotect, careful
about not writing or reading out of bounds, etc.  They need to be
careful about everything.

Programmers have complete control over the address space in a program.
This is Linux we are talking about, it still doesn't have strict policy
on W | X memory, but misuse of mseal is suddenly a developer crisis?

Why is this memory attribute different, and how does it actually help?

When they use mseal on objects with unproven future, the program will
crash later, beautifully demonstrating that they held it wrong.  Then
they can fix their abusive incorrect code.

This discussion about the malloc heap is ridiculous.  Obviously it is
programmer error to lock the permissions on memory you will free for
reuse.  But you can't fix this problem with malloc(), without breaking
other extremely common circumstances where the allocation of memory
and PERMANENT-USE-WITHOUT-RELEASE of such memory are seperated over a
memory boundary, unless you start telling all open source library authors
to always use MAP_SEALABLE in their mmap() calls.


