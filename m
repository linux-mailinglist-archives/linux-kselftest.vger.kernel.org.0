Return-Path: <linux-kselftest+bounces-3963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F784650F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 01:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D941F24CD5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 00:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD31382;
	Fri,  2 Feb 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="VpaNj6/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39914EC5;
	Fri,  2 Feb 2024 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706833588; cv=none; b=tc6CnBIfoRN6W8cqfvHsINmO6kgjy5vUyU+ZD8u0ZIGQQO0M96SBYbPyViQsAHZl9tldDSvXqYdv7CMIrAA8RS5tiFGpxePI+V5IFcv8lKs3dmaLEluu6QmGYJM0qPbRaR6p1SIEAigDIxy5UgjF9v+KrtsTG3PhJED9xGB1GvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706833588; c=relaxed/simple;
	bh=b4nuzlN7OXSDkEKK1U2oo8Q0qvyu895tOHZwmXJZYZY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=s6B0ltCoSGxCRrJm8/GcJch2tcLQHKUWcqgmUpY4H7tI70WTtILGSwq4s0lekpOrDTE32Iewlph795xiIMuL5vO5khrtPJgtGaFsEH4yOVX70qAiSmofIXrvlCMyRAF1itWcblgB/wwVkb+xsW2mvmO3N2Z7rWr269UmEb+ImAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=VpaNj6/i; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=b4nuzlN7OX
	SDkEKK1U2oo8Q0qvyu895tOHZwmXJZYZY=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=VpaNj6/iRziFx+GU2tpihBVG7l1JHFd8a
	A7GD2CdvaEXIouZOIYmu0HkU7Yjro1oIcecAG+ryKntLWNqbB91QFrgRsVyh2DreI/KG0m
	BZYC8k786h0blH7dnoSQRuOZEsAfQtUl8+laLj8lX6X7GqGJYhR62VVjydW6zOWbPtl4RC
	wzPNQdbU6ZUjJ6BFlwKspHNooi8k7EbWpFCzTMNqPnkNqGmbj3mU3Gk8EMW9QiBH/F4Wcj
	TvHiEjL8XJZm3ChSiB6KS0njSQG9uZqD4vdBDZOgwq69zsLHW6+ioFjQrr29Yrhpx8MJ/X
	j4IjI2I3Ntjm2p8fN6H7i4JoipVtg==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 5744bf5f;
	Thu, 1 Feb 2024 17:26:25 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Jeff Xu <jeffxu@chromium.org>,
    "Liam R. Howlett" <Liam.Howlett@oracle.com>,
    Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com,
    jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
In-reply-to: <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver> <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com> <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com> <58408.1706828083@cvs.openbsd.org> <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
Comments: In-reply-to Linus Torvalds <torvalds@linux-foundation.org>
   message dated "Thu, 01 Feb 2024 15:15:27 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31812.1706833585.1@cvs.openbsd.org>
Date: Thu, 01 Feb 2024 17:26:25 -0700
Message-ID: <7481.1706833585@cvs.openbsd.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> and using PROT_SEAL at mmap() time is similarly the same obvious
> notion of "map this, and then seal that mapping".

The usual way is:

    ptr = mmap(NULL, len PROT_READ|PROT_WRITE, ...)

    initialize region between ptr, ptr+len

    mprotect(ptr, len, PROT_READ)
    mseal(ptr, len, 0);


Our source tree contains one place where a locking happens very close
to a mmap().

It is the shared-library-linker 'hints file', this is a file that gets
mapped PROT_READ and then we lock it.

It feels like that could be one operation?  It can't be.

        addr = (void *)mmap(0, hsize, PROT_READ, MAP_PRIVATE, hfd, 0);
        if (_dl_mmap_error(addr))
                goto bad_hints;

        hheader = (struct hints_header *)addr;
        if (HH_BADMAG(*hheader) || hheader->hh_ehints > hsize)
                goto bad_hints;

	/* couple more error checks */

	mimmutable(addr, hsize);
	close(hfd);
	return (0);
bad_hints:
	munmap(addr, hsize);
	...

See the problem?  It unmaps it if the contents are broken.  So even that
case cannot use something like "PROT_SEAL".

These are not hypotheticals.  I'm grepping an entire Unix kernel and
userland source tree, and I know what 100,000+ applications do.  I found
piece of code that could almost use it, but upon inspection it can't,
and it is obvious why: it is best idiom to allow a programmer to insert
an inspection operation between two disctinct operations, and especially
critical if the 2nd operation cannot be reversed.

Noone needs PROT_SEAL as a shortcut operation in mmap() or mprotect().

Throwing around ideas without proving their use in practice is very
unscientific.

