Return-Path: <linux-kselftest+bounces-3961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D1846492
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E7E1C22506
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 23:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D9547F4A;
	Thu,  1 Feb 2024 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="UuduZe5F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4740BE9;
	Thu,  1 Feb 2024 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706831004; cv=none; b=XSGiGb+8ySPhRp3R3YGLE/N0OmRk31VT6Y9TD+tiG06vOakvrlT0VAp1xJ9a64Jzaf3HLM3oSWQBn0QXFNLginDjQdGyogTyIIr86ncjdEXVtP500lJmMmzJiw4oKu5TSCxaymGa0ZeD/iAbE54GCsrHnIM0vUaNyqdqwfyLln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706831004; c=relaxed/simple;
	bh=E/EuFP/XXcsHH/ajGIWHXjQc4oFNk7hnv3UOw4l6RiM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=TTz3KhCj1endBdzpmkH0IzbSBADmqpFZAMXTflZtvEmLKsI9/DQLDAChBmuSxajIGjI18T+T2KTpduI98RZlTFNSeXN9ScrCG95GAx731/tg1xfG0a0xyUdKO0J6KysGRZejpL44EPQOT9GP3se3hlnKCjoWWoqevllXytWxHhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=UuduZe5F; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=E/EuFP/XXc
	sHH/ajGIWHXjQc4oFNk7hnv3UOw4l6RiM=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=UuduZe5F+g7Sb4UNMNnMGju7lX3vLVV9T
	SdhKcs9Z/5wsx6/8QjyATQ+zVRTEVWJdStFfTfsrBtP22IuF2hsOYAkbttWo1zYJaeNa1H
	D6naShPls+8kar87xWt9d2fOkPnqBF9AQAfKZKSKOhcIkilznr1jlnH+w7fzS+LIl8dttt
	ICJwHJZKyMe1dWiKrFy9s+/IUyd3XP9rmMF8omt2kROOv8mAhY0AF0p+Qk7RPRU0g5NO2n
	ts2xcmrrw7aFcNqsRZqx/onC9hdZPIjly+rXOfiy2Tih5vNNAS5kJzBJMGFXUNwcM51f4O
	rg13pwCVW7Q5S/Y4H7M5PTgjN7Cxw==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id fb45d291;
	Thu, 1 Feb 2024 16:43:17 -0700 (MST)
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
Content-ID: <25907.1706830997.1@cvs.openbsd.org>
Date: Thu, 01 Feb 2024 16:43:17 -0700
Message-ID: <99920.1706830997@cvs.openbsd.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So yes, to my mind
> 
>     mprotect(addr, len, PROT_READ);
>     mseal(addr, len, 0);
> 
> should basically give identical results to
> 
>     mprotect(addr, len, PROT_READ | PROT_SEAL);
> 
> and using PROT_SEAL at mmap() time is similarly the same obvious
> notion of "map this, and then seal that mapping".

I think that isn't easy to do.  Let's expand it to show error checking.

    if (mprotect(addr, len, PROT_READ) == -1)
       react to the errno value
    if (mseal(addr, len, 0) == -1)
       react to the errno value

and

    if (mprotect(addr, len, PROT_READ | PROT_SEAL) == -1)
       react to the errno value

For current mprotect(), the errno values are mostly related to range
issues with the parameters.

After sealing a region, mprotect() also has the new errno EPERM.

But what is the return value supposed to be from "PROT_READ | PROT_SEAL"
over various sub-region types?

Say I have a region 3 pages long.  One page is unmapped, one page is
regular, and one page is sealed.  Re-arrange those 3 pages in all 6
permutations.  Try them all.

Does the returned errno change, based upon the order?
Does it do part of the operation, or all of the operation?

If the sealed page is first, the regular page is second, and the unmapped
page is 3rd, does it return an error or return 0?  Does it change the
permission on the 3rd page?  If it returns an error, has it changed any
permissions?

I don't think the diff follows the principle of

if an error is returned --> we know nothing was changed.
if success is returned --> we know all the requests were satisfied

> The reason for having "mseal()" as a separate call at all from the
> PROT_SEAL bit is that it does allow possible future expansion (while
> PROT_SEAL is just a single bit, and it won't change semantics) but
> also so that you can do whatever prep-work in stages if you want to,
> and then just go "now we seal it all".




How about you add basic mseal() that is maximum compatible with mimmutable(),
and then we can all talk about whether PROT_SEAL makes sense once there
are applications that demand it, and can prove they need it?


