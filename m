Return-Path: <linux-kselftest+bounces-1886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D66812461
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 02:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B74B20D92
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 01:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995E438E;
	Thu, 14 Dec 2023 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="f8EJnL1p"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 17:16:18 PST
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA1CE4;
	Wed, 13 Dec 2023 17:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=whGKbpn2mK
	dixz+7VYNABz/psNG/LtxK3IfpFNItFm0=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=f8EJnL1pM686HWnsDZ2MM+QERZ5fn5hkB
	jS2UEz9O0HQ3CMCPdqYpqvgemPzK/k3sYnnneBkmxRB2mwcLGksMDxQUepWmAMwQXOZWow
	UnukNeZTT7/fyuRPG/vc6WY0665nhjTCzO3swQTttAdyYfO+ykooxNcn7hq9Jif7k877Zg
	NzTQhv5fS8QmQ1kODqjycmd0+HMFk6tqn25KWRfbvwutgEQ8WduyIIyF5VupOqoooaYpMm
	PcMkj3UvHwRNaSIbk8cWjCxE4kuZUOGfwXj+Pof8/c4Lkak7sNxM8KgYhPRr+6RT7pTSqL
	cfcNtU11WwqUAXQZzouEGgjK2Ln1A==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 3f9af318;
	Wed, 13 Dec 2023 18:09:38 -0700 (MST)
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
Content-ID: <45779.1702516178.1@cvs.openbsd.org>
Date: Wed, 13 Dec 2023 18:09:38 -0700
Message-ID: <58421.1702516178@cvs.openbsd.org>

Jeff Xu <jeffxu@google.com> wrote:

> > Or when would you *ever* say "seal this area, but mprotect()" is ok.
> >
> The fact  that openBSD allows RW=>RO transaction, as in its man page [2]
> 
>  "  At present, mprotect(2) may reduce permissions on immutable pages
>   marked PROT_READ | PROT_WRITE to the less permissive PROT_READ."

Let me explain this.

We encountered two places that needed this less-permission-transition.

Both of these problems were found in either .data or bss, which the
kernel makes immutable by default.  The OpenBSD kernel makes those
regions immutable BY DEFAULT, and there is no way to turn that off.

One was in our libc malloc, which after initialization, wants to protect
a control data structure from being written in the future.

The other was in chrome v8, for the v8_flags variable, this is
similarily mprotected to less permission after initialization to avoid
tampering (because it's an amazing relative-address located control
gadget).

We introduced a different mechanism to solve these problem.

So we added a new ELF section which annotates objects you need to be
MUTABLE.  If these are .data or .bss, they are placed in the MUTABLE
region annotated with the following Program Header:

Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
  OPENBSD_MUTABLE 0x0e9000 0x00000000000ec000 0x00000000000ec000 0x001000 0x001000 RW  0x1000

associated with this Section Header

  [20] .openbsd.mutable  PROGBITS        00000000000ec000 0e9000 001000 00  WA  0   0 4096

(It is vaguely similar to RELRO).

You can place objects there using the a compiler __attribute__((section
declaration, like this example from our libc/malloc.c code

static union {
        struct malloc_readonly mopts;
        u_char _pad[MALLOC_PAGESIZE];
} malloc_readonly __attribute__((aligned(MALLOC_PAGESIZE)))
                __attribute__((section(".openbsd.mutable")));

During startup the code can set the protection and then the immutability
of the object correctly.

Since we have no purpose left for this permission reduction semantic
upon immutable mappings, we may be deleting that behaviour in the
future.  I wrote that code, because I needed it to make progress with some
difficult pieces of code.  But we found a better way.


