Return-Path: <linux-kselftest+bounces-3478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28B83B196
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EE21F2561F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66B131743;
	Wed, 24 Jan 2024 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QPRpSzpX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11AF13175C
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122582; cv=none; b=OLtr0bS/p+MsJFql6K6SPcGHygfpVaFybPAPFR/OF+GSsgDm1vauLlgpSTZ5pGF43Th7b4tZukuei+sqRzZIowD3homELkItsDOea3w10cTmR+jKYMWPgWZA8NhAGC4zLkYpIxpejiBIInzQF8M9T7mGmq1zmHkv9MSMb5Kn94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122582; c=relaxed/simple;
	bh=kvTmUVyu+5YoGL+Mb3PsywwjW5Ffb/120oGIh9eGFfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fUQtt8hGwf2P23UBbVHR1xNAIckuMfZZctzcFrSsJjPuM3rzV5gAMik6tCPnI5ixdHyluEKGn+GcJcO66lpp19DJb8lG92YExyvb8d9ybF1KeWkID3HWwexZJQ3jdaUqhS6ettw0V/f7uBm1GsXJXM1JkeBDwsIkwrvlwRQrU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QPRpSzpX; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21429ac4dc9so2108195fac.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706122580; x=1706727380; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flii4r2OO0TnE/OvuRDIQl+ib46GfR+jZZh0in4dSPQ=;
        b=QPRpSzpX1b9hPwo98NWL7tu+w7wusN8S4eifQypM25L1xp1DfbTuH9ruwGyFh7T/b1
         J+qep3MdPSA8AbFSACTL7dQzDllJ03r2a0Rp0C/5rRUQ2kHzD8KyuYNBEYqDQFulTKSi
         DnspGYBxvlkxmGb/FNWT9U39SPIgHHfW3Kd7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122580; x=1706727380;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flii4r2OO0TnE/OvuRDIQl+ib46GfR+jZZh0in4dSPQ=;
        b=RPWGQZeBoLMYuQsV5rtlTVLCv4P0j3o+AWkH+5uI2GDBhcoZgfPe2O/w+NpcZYHqAu
         uwQ/3VQV/EkDHcRhQHy4rJbtyCyF8exJcP+dXFLJD8SexnuNF/ToChVN0NWLcd+9q2km
         KJkU8E8YD6SRmtxBzyWlFbtxEKXWRvJoABRDYFHfj2uOuQ5d4kTilf+aWrSQY8RTWtA+
         /HqYSlDPrOTCfqTJ/6zZirfuKkG7w+30MxMC8/O8pYJUj1XbXDdJ2TvvKD3S63JVHqhW
         K1XbN/17BChxXe/k89FiWSVsAYf76Lp+kXFRr8Zh9djkuJHy4xc8D0T7dCIGmBdxDazj
         1oYg==
X-Gm-Message-State: AOJu0YxAsgdYvW8h4CtQ/tye+i8pkiofjbwwlw1r1blw7eaIzYUDRNsS
	IHFqsJvrQmXnzY3JlJESQpcuHl/lMM9v6kl6RAfxHFPTmf5RTrKGjcRyFpz621+dowl8GIVhAvn
	gLtR62Lm34J97MlKa9GkqAXjulvEHS19DJj0q
X-Google-Smtp-Source: AGHT+IEokCZUL1ojdQxZQFJ36V2Jcy4lGrhyLp03ij/BLj+yI4uyj0fd4X4i3tCBO73J+D9TXYai3KJPK1EDBvi2YW0=
X-Received: by 2002:a05:6870:b69b:b0:214:8734:1345 with SMTP id
 cy27-20020a056870b69b00b0021487341345mr35826oab.7.1706122579922; Wed, 24 Jan
 2024 10:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122152905.2220849-1-jeffxu@chromium.org> <726.1705938579@cvs.openbsd.org>
 <CABi2SkXrnUZsWvpqS61mHw-SqDBOodqpcfjdoTTyeeYG9tRJGA@mail.gmail.com>
 <86181.1705962897@cvs.openbsd.org> <20240123173320.2xl3wygzbxnrei2c@revolver> <85359.1706036321@cvs.openbsd.org>
In-Reply-To: <85359.1706036321@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 24 Jan 2024 10:56:08 -0800
Message-ID: <CABi2SkWfgqA89+_qdy6y7HQB1TjA+N2oCNOwO_ZtV+3cJOmV1Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce mseal()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 10:58=E2=80=AFAM Theo de Raadt <deraadt@openbsd.org=
> wrote:
>
> It's the same with MAP_MSEALABLE.  I don't get it. So now there are 3
> memory types:
>        - cannot be sealed, ever
>        - not yet sealed
>        - sealed
>
> What purpose does the first type serve?  Please explain the use case.
>
> Today, processes have control over their entire address space.
>
> What is the purpose of "permissions cannot be locked".  Please supply
> an example.  If I am wrong, I'd like to know where I went wrong.
>
The linux example is in the V3 and V4 cover letter [1] [2] of the open
discussion section.

[1] https://lore.kernel.org/linux-mm/20231212231706.2680890-1-jeffxu@chromi=
um.org/T/
[2] https://lore.kernel.org/linux-mm/20240104185138.169307-3-jeffxu@chromiu=
m.org/T/

Copied below for ease of reading.
---------------------------------------------------------------------------=
--------------
During the development of V3, I had new questions and thoughts and
wished to discuss.

1> shm/aio
From reading the code, it seems to me that aio/shm can mmap/munmap
maps on behalf of userspace, e.g. ksys_shmdt() in shm.c. The lifetime
of those mapping are not tied to the lifetime of the process. If those
memories are sealed from userspace, then unmap will fail. This isn=E2=80=99=
t a
huge problem, since the memory will eventually be freed at exit or
exec. However, it feels like the solution is not complete, because of
the leaks in VMA address space during the lifetime of the process.

2> Brk (heap/stack)
Currently, userspace applications can seal parts of the heap by
calling malloc() and mseal(). This raises the question of what the
expected behavior is when sealing the heap is attempted.

let's assume following calls from user space:

ptr =3D malloc(size);
mprotect(ptr, size, RO);
mseal(ptr, size, SEAL_PROT_PKEY);
free(ptr);

Technically, before mseal() is added, the user can change the
protection of the heap by calling mprotect(RO). As long as the user
changes the protection back to RW before free(), the memory can be
reused.

Adding mseal() into picture, however, the heap is then sealed
partially, user can still free it, but the memory remains to be RO,
and the result of brk-shrink is nondeterministic, depending on if
munmap() will try to free the sealed memory.(brk uses munmap to shrink
the heap).

3> Above two cases led to the third topic:
There one option to address the problem mentioned above.
Option 1:  A =E2=80=9CMAP_SEALABLE=E2=80=9D flag in mmap().
If a map is created without this flag, the mseal() operation will
fail. Applications that are not concerned with sealing will expect
their behavior to be unchanged. For those that are concerned, adding a
flag at mmap time to opt in is not difficult. For the short term, this
solves problems 1 and 2 above. The memory in shm/aio/brk will not have
the MAP_SEALABLE flag at mmap(), and the same is true for the heap.

If we choose not to go with path, all mapping will by default
sealable. We could document above mentioned limitations so devs are
more careful at the time to choose what memory to seal. I think
deny of service through mseal() by attacker is probably not a concern,
if attackers have access to mseal() and unsealed memory, then they can
also do other harmful thing to the memory, such as munmap, etc.

4>
I think it might be possible to seal the stack or other special
mappings created at runtime (vdso, vsyscall, vvar). This means we can
enforce and seal W^X for certain types of application. For instance,
the stack is typically used in read-write mode, but in some cases, it
can become executable. To defend against unintented addition of
executable bit to stack, we could let the application to seal it.

Sealing the heap (for adding X) requires special handling, since the
heap can shrink, and shrink is implemented through munmap().

Indeed, it might be possible that all virtual memory accessible to user
space, regardless of its usage pattern, could be sealed. However, this
would require additional research and development work.

---------------------------------------------------------------------------=
--------------------------

