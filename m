Return-Path: <linux-kselftest+bounces-3959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0E4846455
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 00:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B705F1F245AB
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 23:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8047A6C;
	Thu,  1 Feb 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O0ZwYtOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767B47A7A
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829350; cv=none; b=lOE3GnnkZfkzLUiXhSKjpycM8NZdbr1bHjQFQlmAsmhWK49mJ4sZRhJZdlxwJyrD0LxZmXgGUevu4DQ3cIjwc1GptEoj16IPQEEPsHBWr2c2+hhrEmP6DQ/958HyBEHo1DOEXRK5IgwIKbpURtWlZMD0m1gjIi7cXCbDh/am8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829350; c=relaxed/simple;
	bh=fY0i4/MKLDNI6g9oyGYppVz4kakO1fL7ygQCWGCJrpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NianPFE7AqLr6M3JkKkn85Oug8dTao0/WlLQOx2mq2g+QDpgArc0EFNzSXV35hhSSd72T/q6eDRNFNcA5vqQJ0ZQJEzhKpXmvdNwpNSXh0bbleWIjxXnyczStywJY3zjViSSPyMwjHbfETXKQBkOk7copyyHds89fJ3EEBr6Pvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O0ZwYtOZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51120e285f6so1816346e87.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 15:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706829346; x=1707434146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9K//vSZ1lGeh0sw5K4/Yw1CUaoAoUAFBdXCL4ofyJ/A=;
        b=O0ZwYtOZM8PYjiRKaxKh5UBCIOLmvBQoLDk4g1AZAfh2QW592R5CxoCd5mnoeWUnZP
         iNKWHEi7OuyS797GmP7nZ8SkVrC+Vwm0rcC9D4SSLKDT31SotyvTn5cZu6kyprqbl3Mj
         s9L7N5+xn1HNObdyt+T2FjOi28pk0wj3XOnoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706829346; x=1707434146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K//vSZ1lGeh0sw5K4/Yw1CUaoAoUAFBdXCL4ofyJ/A=;
        b=BaLEjth+ktn6eglNCWdx8lPO99x6eKepPOAHVSkPEVn7TTlPexDhwyGuwk4eJPgKPy
         guI9krAS/5sRtOtRCPSC2NazfJZ6Xwh+q3ZEn/QgOAIQaKLfwk2IgNL6UbcoypQ+zAzs
         A9/7OJ6OU/27+J6UJVxvG0EPG4tzdL8ohrxbVNV/gXhbDr8HlzmrBBR3dIil9o3SS6Xy
         Hq9NiwFruNCp9cA1JqEnGqQerHkC4SDO+GHbGrjiV+CNIc1WRnsgI3ASH+xoFnkCWRcW
         5Ocz/YkgejLw1HzihbMHQSZ42iCAZeLAQrjQ0VjgP6XL8FqROVqiYo2UQCd0YnzgvK1Q
         hhSw==
X-Gm-Message-State: AOJu0YwntI2rDMwZo2auWhv3fYXF/sP6+zz3kxClqzuc2hFGs6eY0soN
	/ih6b6dacA8Mo4eb8e3urHCVgl7wmbz+CV/2McUBfyjSoDenpvbvlXqtWCACY4ctlq9ser9N5jk
	b7WyIGQ==
X-Google-Smtp-Source: AGHT+IGb0f72mS6GUvlvYL8pssSfv4CgVXAUxPs4TzfPMv/nk3s8HRiLcVu+6BYgMl87tZW2yO9lNA==
X-Received: by 2002:a2e:a368:0:b0:2cf:175e:612a with SMTP id i8-20020a2ea368000000b002cf175e612amr4573056ljn.28.1706829346526;
        Thu, 01 Feb 2024 15:15:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWaP0560tQuzBNJp8cNDKkuclID0aIQZ9lNm5AHXhtaIx7Of5Dd2309WlaMBcUsb/nThmfZNs2pQqN5Kp7WX3+BKV30CprdwLYkZ8vnCZbF
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id cz8-20020a0564021ca800b0055f8adf1d6esm265831edb.47.2024.02.01.15.15.44
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 15:15:45 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso2127610a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 15:15:44 -0800 (PST)
X-Received: by 2002:a05:6402:60a:b0:55f:4602:bf7d with SMTP id
 n10-20020a056402060a00b0055f4602bf7dmr4355014edv.26.1706829344286; Thu, 01
 Feb 2024 15:15:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
 <58408.1706828083@cvs.openbsd.org>
In-Reply-To: <58408.1706828083@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 15:15:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
Message-ID: <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Jeff Xu <jeffxu@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 14:54, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Linus, you are in for a shock when the proposal doesn't work for glibc
> and all the applications!

Heh. I've enjoyed seeing your argumentative style that made you so
famous back in the days. Maybe it's always been there, but I haven't
seen the BSD people in so long that I'd forgotten all about it.

That said, famously argumentative or not, I think Theo is right, and I
do think the MAP_SEALABLE bit is nonsensical.

If somebody wants to mseal() a memory region, why would they need to
express that ahead of time?

So the part I think is sane is the mseal() system call itself, in that
it allows *potential* future expansion of the semantics.

But hopefully said future expansion isn't even needed, and all users
want the base experience, which is why I think PROT_SEAL (both to mmap
and to mprotect) makes sense as an alternative form.

So yes, to my mind

    mprotect(addr, len, PROT_READ);
    mseal(addr, len, 0);

should basically give identical results to

    mprotect(addr, len, PROT_READ | PROT_SEAL);

and using PROT_SEAL at mmap() time is similarly the same obvious
notion of "map this, and then seal that mapping".

The reason for having "mseal()" as a separate call at all from the
PROT_SEAL bit is that it does allow possible future expansion (while
PROT_SEAL is just a single bit, and it won't change semantics) but
also so that you can do whatever prep-work in stages if you want to,
and then just go "now we seal it all".

          Linus

