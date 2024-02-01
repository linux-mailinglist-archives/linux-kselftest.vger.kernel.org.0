Return-Path: <linux-kselftest+bounces-3913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876F844ECE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 02:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5A52842B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 01:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98F442F;
	Thu,  1 Feb 2024 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="f/tYr+y7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD24C60;
	Thu,  1 Feb 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752007; cv=none; b=hjKn6DIRHbWPDRj6azfsi2dqS+316TYMVIFDyxnVeuP/lHz1brACZHFL8X2XOfHdj0kOw9sD2vq3CKLNjhMDGtAocw64vWMydtnrLAQyNVKmFeskE3/xABtY1Kt7T24Il4LSOF/jO63nMJDLidU1zwSLTxZzQqP5of7c8/34wJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752007; c=relaxed/simple;
	bh=wFBz+k5fFVkfyImExH0Xqsk93XAwSQpXZbD4zCIYg2s=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=J19DZeywM1U+YJRNdNPJCarMR6bxeDfK/3efwe49ElzHZeEt94/0r5wnaFxF1knd9stvDiZ7ODjNA/DgYm4qLH8eXaTDhKCfdRNTXa//JHZLUpdSYLFmvBSVtlCvuBDPVsu8eLlM/ljDoul89x1nBo0FAukRHppQK/rxlT87WVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=f/tYr+y7; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=wFBz+k5fFV
	kfyImExH0Xqsk93XAwSQpXZbD4zCIYg2s=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=f/tYr+y7eDPbWZOF+9LXCLUy2873vJZin
	cxDmTaOx+Po8NNOY2V+CYGljx5zXiq22sjo1o9/xcaBYwbtKGwpn8twXv67R3Ai4vnQ4ix
	0XyP3Rd3wNm9nkGhtobf6PAbq581Np8LbmBq9TDiiUW6dQZd89eLUf25744aecF0ESRJMO
	CnzeKegKYHs/E+2tPoxHgc19gDJU27v11+fto+1w+T73Oli1/BMB3y2otDUFFgUM8gZfek
	tMvc1lr97CZMwNiIpuBPL3DiINXijpMN7TBpYukDQAOTDIm5PFlfIzVZ713HXnus/8+uUR
	5MSMI/DLDp2p51hL4cf+U0zZyxCtA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id a86ce6c1;
	Wed, 31 Jan 2024 18:46:38 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@chromium.org>
cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
    Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    torvalds@linux-foundation.org, usama.anjum@collabora.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
In-reply-to: <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver> <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Wed, 31 Jan 2024 17:27:11 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37065.1706751997.1@cvs.openbsd.org>
Date: Wed, 31 Jan 2024 18:46:37 -0700
Message-ID: <92663.1706751997@cvs.openbsd.org>

Jeff Xu <jeffxu@chromium.org> wrote:

> I considered Theo's inputs from OpenBSD's perspective regarding the
> difference, and I wasn't convinced that Linux should remove these. In
> my view, those are two different kernels code, and the difference in
> Linux is not added without reasons (for MAP_SEALABLE, there is a note
> in the documentation section with details).

That note is describing a fiction.

> I would love to hear more from Linux developers on this.

I'm not sure you are capable of listening.

But I'll repeat for others to stop this train wreck:


1. When execve() maps a programs's .data section, does the kernel set
   MAP_SEALABLE on that region?  Or does it not set MAP_SEALABLE?

   Does the kernel seal the .data section?  It cannot, because of RELRO
   and IFUNCS.  Do you know what those are?  (like in OpenBSD) the kernel
   cannot and will *not* seal the .data section, it lets later code do that.

2. When execve() maps a programs's .bss section, does the kernel set
   MAP_SEALABLE on that region?  Or does it not set MAP_SEALABLE?

   Does the kernel seal the .bss section?  It cannot, because of RELRO
   and IFUNCS.  Do you know what those are?  (like in OpenBSD) the kernel
   cannot and will *not* seal the .bss section, it lets later code do that.

In the proposed diff, the kernel does not set MAP_SEALABLE on those
regions.

How does a userland program seal the .data and .bss regions?

It cannot.  It is too late to set the MAP_SEALABLE, because the kernel
already decided not do to it.

So those regions cannot be sealed.

3. When execve() maps a programs's stack, does the kernel set
   MAP_SEALABLE on that region?  Or does it not set MAP_SEALABLE?

In the proposed diff, the kernel does not set MAP_SEALABLE.

You think you can seal the stack in the kernel??  Sorry to be the bearer
of bad news, but glibc has code which on occasion will mprotects the
stack executable.

But if userland decides that mprotect case won't occur -- how does a
userland program seal its stack?  It is now too late to set MAP_SEALABLE.

So the stack must remain unsealed.

4. What about the text segment?

5. Do you know what a text-relocation is?  They are now rare, but there
   are still compile/linker stages which will produce them, and there is
   software which requires that to work.  It means userland fixes it's
   own .text, then calls mprotect.  The kernel does not know if this will
   happen.

6. When execve() maps the .text segment, will it set MAP_SEALABLE?

If it doesn't set it, userland cannot seal it's text after it makes the
decision to do.


You can continue to extrapolate those same points for all other segments
of a static binary, all segments of a dynamic binary, all segments of the
shared library linker.

And then you can go further, and recognize the logic that will be needed
in the shared library linker to *make the same decisions*.

In each case, the *decision* to make a mapping happens in one piece of
code, and the decision to use and NOW SEAL THAT MAPPING, happens in a
different piece of code.


The only answer to these problems will be to always set MAP_SEALABLE.
To go through the entire Linux ecosystem, and change every call to mmap()
to use this new MAP_SEALABLE flag, and it will look something like this:

+#ifndef MAP_SEALABLE
+#define MAP_SEALABLE 0
+#endif
-	ptr = mmap(...., MAP...
-	ptr = mmap(...., MAP_SEALABLE | MAP...

Every single one of them, and you'll need to do it in the kernel.




If you had spent a second trying to make this work in a second piece of
software, you would have realized that the ONLY way this could work
is by adding a flag with the opposite meaning:

   MAP_NOTSEALABLE

But nothing will use that.  I promise you


> I would love to hear more from Linux developers on this.

I'm not sure you are capable of listening.


