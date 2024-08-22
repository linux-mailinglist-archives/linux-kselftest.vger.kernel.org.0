Return-Path: <linux-kselftest+bounces-16119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A279B95BEAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 21:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441EA1F2412C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC21CF2BA;
	Thu, 22 Aug 2024 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zS9TR09t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A41CDFD4
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354053; cv=none; b=BbfWHYBMTaHNhRYvr7NUFE//uo4d27JWuRaCUc8oBbizcW0yRfVK/LZ6VEfEAuEj6N+X5qBZmYq7/64wCp9ykgtwLP0QvJ9whTP5NiZ6wUTX4M6p9Dadwqijid9XW/OT8KGybmyX20bxdXfofsZEjGw6/I6IVJ2t5adPgmV41Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354053; c=relaxed/simple;
	bh=kdl9m04IeIhLS7PfVFGy7WD8kTp/VKtBqIsyLvNi4Qs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dRsKRJhEaIVZWoz5A9Yg4Xhc7bk7q6hPhdwjG5711OOSjROSmOfNtQFOJZCM3B8CEc9tAFgaFq/v8ngqGB7YLFgY8XqWCyzP1M2kKKrOP2z1Eemt8ldxWJv0V4A6QlRVOT871zGEhT6nQHR1EkkP/Qxe8fX6/BTFQrBcUZHRYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zS9TR09t; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b3825748c2so23417797b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724354051; x=1724958851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaMcsggMRGrmcGjmkJfU9HDzyIESFhgorCuZMXV4ePU=;
        b=zS9TR09tBvX5uvvL3U44zaIz3FwnWsTDYfS4YLW+q7PK1beex0IhbvmbfYiEblMnk1
         xEUhDND7OD43WH/CGd/4JN/804TNbLj+6ZQBPJ3WasjM+wzl9LMLK4FHAsRNpDYcII35
         hIknjMi059LHD9an+JxO58xRaYlvDahCW94VSh6oqFAZ5rRikygfXE/6ICd86JghbUlD
         f4xRka6xwwlNXKFU3JuSnv1/+/6YNeFtVKM2Xr9BFVf9vytt858k8VbRgV0Pi8Fiy0jn
         QBc79DZU2cQJz570VWqGRcmsY59QmIsxPXG1Iv86vsJwpy1Sg5Gup3PC4ItDUoe6dmIo
         3kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724354051; x=1724958851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaMcsggMRGrmcGjmkJfU9HDzyIESFhgorCuZMXV4ePU=;
        b=N2Ea1MzNxa3ou2ag65mrbL7Ub3/HHqkpZdLw9A+OkpotEYUdZ96p8dWc2Jtsc5ixOT
         hPP2hkdoFyO2yhJi9S0wdscqA/II5FrL7CS8ISQi3Qv92kNqI/exQ8YyhFWRtXdJ0avf
         uwoaq44Pogmqn0NdNw5M+1nE40F3/L/6WwWe16uhMpK8iS5RdohfhXg1AxP9gfenrXgJ
         cj12KHL0ZOIEvnPnQfa4fQiL315wtTiygvWI58Jjo3lHXQ0oCQZsBgl8IqQCivn0UUiF
         ipPrS4vOmOwiuaUBQJCU8jkzQLKbz61XzdiRvDE6IFA7rCPFU0Sv1ghtuuv75dMQuQpV
         wTkw==
X-Forwarded-Encrypted: i=1; AJvYcCVf4A0NzlH98bjrY34wXukwedXy+uDGMA/ANZv9tj8XL9VHwJ4+dVmFkGOW5INp9DxnmuyPgLjt7UB30huJmN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rT/lmerIYLdfEk8Xh3b2u1CT6Myl4n/aCSn0pLiyXKNPRKCg
	n5nhwbn3q0Nb6656pDodaS70/aROf1jEmesXOJ+Zjs2P5voDj+cy+xYMPASYW0eM/nCe2sJirxA
	fsA==
X-Google-Smtp-Source: AGHT+IHBl6IuQkEvzLArh/LdYV3EHTO/Q8/miBxNSbv712XSc9lkasrB1zLI2uH/r1NHjG6hta0iQtO2RM4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6d54:0:b0:e11:6c69:72ed with SMTP id
 3f1490d57ef6-e166552f9eemr59121276.8.1724354051211; Thu, 22 Aug 2024 12:14:11
 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:14:09 -0700
In-Reply-To: <20230227174654.94641-1-ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230227174654.94641-1-ackerleytng@google.com>
Message-ID: <ZseOAY0OIrEIGG2h@google.com>
Subject: Re: [PATCH] tools: Copy linux/align.h into tools/
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: yury.norov@gmail.com, andriy.shevchenko@linux.intel.com, 
	linux@rasmusvillemoes.dk, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 27, 2023, Ackerley Tng wrote:
> This provides alignment macros for use in selftests.
> 
> Also clean up tools/include/linux/bitmap.h's inline definition of
> IS_ALIGNED().
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---

FYI, an almost-equivalent change went through net/, commit 10a04ff09bcc ("tools:
move alignment-related macros to new <linux/align.h>").  It doesn't have these

  #define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
  #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
  #define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))

but I'm pretty sure your use case doesn't need them, so you should be good to go.
And if not, it's easy enough to include a delta patch to add them.

>  tools/include/linux/align.h  | 15 +++++++++++++++
>  tools/include/linux/bitmap.h |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>  create mode 100644 tools/include/linux/align.h
> 
> diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
> new file mode 100644
> index 000000000000..2b4acec7b95a
> --- /dev/null
> +++ b/tools/include/linux/align.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ALIGN_H
> +#define _LINUX_ALIGN_H
> +
> +#include <linux/const.h>
> +
> +/* @a is a power of 2 value */
> +#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
> +#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
> +#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
> +#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
> +#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
> +#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
> +
> +#endif	/* _LINUX_ALIGN_H */
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index f3566ea0f932..8c6852dba04f 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -3,6 +3,7 @@
>  #define _TOOLS_LINUX_BITMAP_H
>  
>  #include <string.h>
> +#include <linux/align.h>
>  #include <linux/bitops.h>
>  #include <linux/find.h>
>  #include <stdlib.h>
> @@ -126,7 +127,6 @@ static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
>  #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
>  #endif
>  #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
> -#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
>  
>  static inline bool bitmap_equal(const unsigned long *src1,
>  				const unsigned long *src2, unsigned int nbits)
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

