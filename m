Return-Path: <linux-kselftest+bounces-3954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712F846360
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 23:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E711C20B3E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 22:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34083FE3D;
	Thu,  1 Feb 2024 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="mQtvNz/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFC40BE2;
	Thu,  1 Feb 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826283; cv=none; b=n4rDELgtjXQkrXrtiQXOxssTgT2ZZDCIVnUczZWB2dYJlAcVFngxv3U3yHkXDOSY4aTi1l71KVXBQbot9Cq+JzvI1nUBokhsrD49nh74HgVoOv4m5oYcHxQAOUb1Xrw5EKzNvF4x5RsT6wmM2IJSnSJmxNYcDtYJdr94miVcLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826283; c=relaxed/simple;
	bh=V+pgcDkLptPWj1ZsXMjO/YpMP2pXDVV5rTLspffLxF0=;
	h=From:To:Subject:In-reply-to:References:MIME-Version:Content-Type:
	 Date:Message-ID; b=BBqLUnv2qEk+lxcqSYUo7A0QkvdUipaldpE6XHlFCAFDHA1r4hAfufZ9XGfhCBj1PM1uIBN9MYL/T+F5vlqx/N1r9kZ80PSRE6ezkC4oBEeQpJw6rC/7jUP3Rtnu3YNZl0avB06G8sCLiAmEn0FSlcyiPdJcG2JGRUJnffAEspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=mQtvNz/2; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=V+pgcDkLpt
	PWj1ZsXMjO/YpMP2pXDVV5rTLspffLxF0=; h=date:references:in-reply-to:
	subject:to:from; d=openbsd.org; b=mQtvNz/2l4bObNXPQCEXRYkfvH+3kuXrFbmQ
	5ccm3cu6lDooMGrgLBn1n2RoQ/QYXvQOUNcLRqrZ1kWyTib3gOGK7YIOBFvIxj+aEJ2Can
	NzFcAvwgTKE5s2p15GrjKIZSJ5E83Qw4JU2rm21yzOxjmlYmkAW7Vw82dIzpUc8IJ2Mn+N
	zNbdkKOgBXPLJirZSmKXDwXvoKqt5rpDUHQQ7Q9PX8zVxzrTKL1QzXP4xl2DC0D5KuGUke
	IwafprPJe305G7qvBX7SCXPSP2/jXehf8l2taZ6+A2C7tIOAj8YjRxhVXYXwUELwobIUL6
	AbgXvaGSEL3HyNiF7p9jTivZtg==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 90ae0d7d;
	Thu, 1 Feb 2024 15:24:40 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
    Jeff Xu <jeffxu@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
    akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
    sroettger@google.com, willy@infradead.org,
    gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
    usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com,
    jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
                  Jeff Xu <jeffxu@chromium.org>,
                  Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v8 0/4] Introduce mseal
In-reply-to: <20240201204512.ht3e33yj77kkxi4q@revolver>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver> <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com> <20240201204512.ht3e33yj77kkxi4q@revolver>
Comments: In-reply-to "Liam R. Howlett" <Liam.Howlett@Oracle.com>
   message dated "Thu, 01 Feb 2024 15:45:12 -0500."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85538.1706826280.1@cvs.openbsd.org>
Date: Thu, 01 Feb 2024 15:24:40 -0700
Message-ID: <60731.1706826280@cvs.openbsd.org>

There is another problem with adding PROT_SEAL to the mprotect()
call.

What are the precise semantics?

If one reviews how mprotect() behaves, it is quickly clear that
it is very sloppy specification.  We spent quite a bit of effort
making our manual page as clear as possible to the most it gaurantees,
in the standard, and in all the various Unix:

     Not all implementations will guarantee protection on a page basis; the
     granularity of protection changes may be as large as an entire region.
     Nor will all implementations guarantee to give exactly the requested
     permissions; more permissions may be granted than requested by prot.
     However, if PROT_WRITE was not specified then the page will not be
     writable.

Anything else is different.

That is the specification in case of PROT_READ, PROT_WRITE, and PROT_EXEC.

What happens if you add additional PROT_* flags?

Does mprotect still behave just as sloppy (as specified)?

Or it now return an error partway through an operation?

When it returns the error, does it skip doing the work on the remaining
region?

Or does it skip doing any protection operation at all? (That means the code
has to do two passes over the region; first one checks if it may proceed,
second pass performs the change.  I think I've reat PROT_SEAL was supposed
to try to do things as one pass; is that actually possible without requiring
a second pass in the kernel?

To wit, do these two sequences have _exactly_ the same behaviour in
all cases that we can think of
    - unmapped sub-regions
    - sealed sub-regions
    - and who knows what else mprotect() may encounter

a)

    mprotect(addr, len, PROT_READ);
    mseal(addr, len, 0);

b)

    mprotect(addr, len, PROT_READ | PROT_SEAL);

Are they the same, or are they different?

Here's what I think: mprotect() behaves quite differently if you add
the PROT_SEAL flag, but I can't quite tell precisely what happens because
I don't understand the linux vm system enough.


(As an outsider, I have glanced at the new PROT_MTE flag changes; that
one seem to just "set a flag where possible", rather than performing
an action which could result in an error, and seems to not have this
problem).


As an outsider, Linux development is really strange:

Two sub-features are being pushed very hard, and the primary developer
doesn't have code which uses either of them.  And once it goes in, it
cannot be changed.

It's very different from my world, where the absolutely minimal
interface was written to apply to a whole operating system plus 10,000+
applications, and then took months of testing before it was approved for
inclusion.  And if it was subtly wrong, we would be able to change it.


