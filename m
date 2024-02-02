Return-Path: <linux-kselftest+bounces-3993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE3846760
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 06:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E881F23268
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 05:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC599171A4;
	Fri,  2 Feb 2024 05:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="sh1XyYJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660251754E;
	Fri,  2 Feb 2024 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850041; cv=none; b=AIfUvQios7BV0jkYqdix1Mckfdi+leimtWY3CC6TKsQajUloNU3PUrFSssG5ZxbpEXMtQMPFUt9qUWSIWPIyYeYE3zNAg0JL+t0nxjqt4GrHRE/xQdBeX74m2QSBjvvx3d/K8Owh/9sA/nuzq2GHRNAPI5lN+h+tnk9XyDW9lYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850041; c=relaxed/simple;
	bh=Al3s5n9XbYajMyMjy8quEUVmt9j6PNC6PhjL+sDVrak=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=PGOTImyz1wFwfZ9t20gApuf5zW8PHdj5W2O7mHeFDzhKW8HpDfsA07nvuQRb4mwBS2F7Bx7x3u4i4eFKMR4wnJEMGkFTpi82nog37jKTAVbTo7L1hPBZKLrHT8vsrY/vzhSZ5c4VIWMsKvyQPN0j9bQIRl8j/S5d8AwYXzHLSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=sh1XyYJV; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=Al3s5n9XbY
	ajMyMjy8quEUVmt9j6PNC6PhjL+sDVrak=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=sh1XyYJVZYspbYXNo5lPr6eTzSsPxlnzX
	fUpQ+m0g7osvlXQvcV2G+BhKvz2pnkmgRy3sVTKxdare0Z+M7o58U4MMgKzbCRET9klZsc
	oaoityDPeqv1qGDLleLPnYPYicdjJuag7OdSxzy341IzrDsWbdrRCEaTWYw12r5aZd3hyr
	mcd8IEBO6yBRfN5Fz7z8ZIlyNrK9UAHgi3UX4zLwYtrzUPse+VNOk62UmZbSMl6Ep8Isxo
	dY7bZ+afNtjp+jwl2P7FZeJp52muDmP09AelHIjXZ7q3df86FM2xZDjkxoVIfNiwglMPfI
	RFfcaD4q2AxYDQzikS7LzNlMfZSRw==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 96394933;
	Thu, 1 Feb 2024 22:00:35 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@chromium.org>
cc: Jeff Xu <jeffxu@google.com>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    "Liam R. Howlett" <Liam.Howlett@oracle.com>,
    Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    usama.anjum@collabora.com, rdunlap@infradead.org,
    jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
In-reply-to: <CABi2SkWSt=UMFWe9n916ZH16wCzaipKXmEJ5VasQHMr1AxerxQ@mail.gmail.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver> <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com> <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com> <58408.1706828083@cvs.openbsd.org> <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com> <CALmYWFtqcixi3p3Ab44wENJr+n2k2SNaCJEofNm_awnNdJZnDQ@mail.gmail.com> <8744.1706846710@cvs.openbsd.org> <CABi2SkWSt=UMFWe9n916ZH16wCzaipKXmEJ5VasQHMr1AxerxQ@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Thu, 01 Feb 2024 20:54:28 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60913.1706850035.1@cvs.openbsd.org>
Date: Thu, 01 Feb 2024 22:00:35 -0700
Message-ID: <29248.1706850035@cvs.openbsd.org>

Jeff Xu <jeffxu@chromium.org> wrote:

> Even without free.
> I personally do not like the heap getting sealed like that.
> 
> Component A.
> p=malloc(4096);
> writing something to p.
> 
> Component B:
> mprotect(p,4096, RO)
> mseal(p,4096)
> 
> This will split the heap VMA, and prevent the heap from shrinking, if
> this is in a frequent code path, then it might hurt the process's
> memory usage.
> 
> The existing code is more likely to use malloc than mmap(), so it is
> easier for dev to seal a piece of data belonging to another component.
> I hope this pattern is not wide-spreading.
> 
> The ideal way will be just changing the library A to use mmap.

I think you are lacking some test programs to see how it actually
behaves; the effect is worse than you think, and the impact is immediately
visible to the programmer, and the lesson is clear:

	you can only seal objects which you gaurantee never get recycled.

	Pushing a sealed object back into reuse is a disasterous bug.

	Noone should call this interface, unless they understand that.

I'll say again, you don't have a test program for various allocators to
understand how it behaves.  The failure modes described in your docuemnts
are not correct.



