Return-Path: <linux-kselftest+bounces-15326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D57C951EA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 17:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B6328112C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D61B4C3F;
	Wed, 14 Aug 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKqkeXUc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3101E529;
	Wed, 14 Aug 2024 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649640; cv=none; b=aUloyP/CiH3wK6AskHJI8wNrLG/d3yAS2ZT4DG4HyHnlDl8DB6/oDQPBfFy3cguLqG+mxYOxn4up5E/boIXe226j5osv2y5bousUSRG0UhUtAmix+eJAHWuyH4KXq2sHlrldbjd9+LAaM1v2fArTtGgD/HdH0/9Ny3aqy8OuE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649640; c=relaxed/simple;
	bh=QLbYuL5iDDVjrekLj6uwxZzS6Qfq6dEj/vjZ3vOcbZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJcxvC3XF2r0ffkCdH3POM5E5GcRkEvZP1Q+OlNNPDBYhcNnGewb3OFqGq6yT18FASaKbfoNUzoGOBzA/POIQhu3s6FxoCZvOMSOB8BBZksmlifnC77xPcUGT5jLJZREJmh5pTOsA+O7mms7bZYee1RKbuqEVaSMa/K7ejYBYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKqkeXUc; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70930972e19so1931975a34.3;
        Wed, 14 Aug 2024 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723649638; x=1724254438; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=miqNK+B744VEtho+Cz5BtriydmdXkbKnexaiIQFok4E=;
        b=XKqkeXUcV2xNnZsYuMIUh+RtZhGRKvcio6Hv8eAioXvu5nP/d38e9m1qbWr8V5UbzK
         SdFSivmY/hTsD1f8Cmj3lpkXuL5kcFVfsLmyLKIYzirSXGoK3MbSweihoxz8cF7rRIjM
         MUb4Eplu2zTktziZ/hHcPkEFf/O8SpdDfpSTODPxv4Uge6QfHzLKmIxt0dMbXXMgKaC3
         jncql18YjVPuooN6DxTZOh37s7AV19vv1YLmM8lPkcCMKbvC8Rk24aTDeE1vZZ2+YPRp
         LOcdqkkslLRBl4HB+3376yzREb9MvSPjc/pLwk+yFefrvsP9Ezb4iNPPsNhRjsD0lJR5
         Kupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649638; x=1724254438;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miqNK+B744VEtho+Cz5BtriydmdXkbKnexaiIQFok4E=;
        b=ASFRXUJCqZ1HdqT9nAk9G7eG7YXX2Iaa1xFfKU9tQJOlSllqI0K6TW0Pg0HikSKAYN
         qxbRf91QajrogcOIcwSxKYyaGSRTGs1m1WS/vrtUNuMqSWFW3k+OxuqXSWWxUwIxPVND
         C0Mtg59bgl3s6YWc+igz8eaEuYja6u3ztIL3o6h/0hCvRTaL/GZnepjJ64M39wQPR9Dd
         YEE5l4yW2my89MBG3S6hlql7yfG4brjCcnlcovt35lmiewA4UggAMlBmMYg1vO6b6PfD
         l51oU+HiXQxmKix5DrH3RvYxOQ1fX+QbCESkxtv7qh2gV8fepFx2TIC9oOoK9gxgd+ar
         ZLVg==
X-Forwarded-Encrypted: i=1; AJvYcCXPl5jLkBgf06+1Y6myRxCg8uejYeb7oIdWG4qzjgjAVMjzXVc+FtrypjCRwu2OzHqH6ISceSw0Dpr9y65Wq2XwG5rKEpkaDQeFFQcjCrxoAcvUh+p+BEI28+sLfeoAhQoEehcxeAmBtZpse9H4
X-Gm-Message-State: AOJu0YyCI3VTqVZkHX3i3do5yjLop6m69fOxZTw9NGxtOP57wR1nFqW8
	h2znOAvPw4fpRybOpO2Zm0S3glwXWfqhhR6ChaOuMJ0pFs8s63rW
X-Google-Smtp-Source: AGHT+IEwQqDD1BqP+Zoiab/YVxTNQIEozpAACW41iApb8rmqIU4uPEKI6+p9bS5UeKAf+1oOHFHzqA==
X-Received: by 2002:a05:6830:d13:b0:70a:92e4:6736 with SMTP id 46e09a7af769-70c9d9d9529mr4164350a34.28.1723649638136;
        Wed, 14 Aug 2024 08:33:58 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70c7b89c042sm2254766a34.78.2024.08.14.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:33:57 -0700 (PDT)
Message-ID: <bc279009c4c3c901033e23601efcf9ed4da8743d.camel@gmail.com>
Subject: Re: [PATCH net-next v13 02/14] mm: move the page fragment allocator
 from page_alloc into its own file
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells
 <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org,  linux-kselftest@vger.kernel.org
Date: Wed, 14 Aug 2024 08:33:55 -0700
In-Reply-To: <20240808123714.462740-3-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
	 <20240808123714.462740-3-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> Inspired by [1], move the page fragment allocator from page_alloc
> into its own c file and header file, as we are about to make more
> change for it to replace another page_frag implementation in
> sock.c
>=20
> As this patchset is going to replace 'struct page_frag' with
> 'struct page_frag_cache' in sched.h, including page_frag_cache.h
> in sched.h has a compiler error caused by interdependence between
> mm_types.h and mm.h for asm-offsets.c, see [2]. So avoid the compiler
> error by moving 'struct page_frag_cache' to mm_types_task.h as
> suggested by Alexander, see [3].
>=20
> 1. https://lore.kernel.org/all/20230411160902.4134381-3-dhowells@redhat.c=
om/
> 2. https://lore.kernel.org/all/15623dac-9358-4597-b3ee-3694a5956920@gmail=
.com/
> 3. https://lore.kernel.org/all/CAKgT0UdH1yD=3DLSCXFJ=3DYM_aiA4OomD-2wXykO=
42bizaWMt_HOA@mail.gmail.com/
> CC: David Howells <dhowells@redhat.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/gfp.h                           |  22 ---
>  include/linux/mm_types.h                      |  18 ---
>  include/linux/mm_types_task.h                 |  18 +++
>  include/linux/page_frag_cache.h               |  31 ++++
>  include/linux/skbuff.h                        |   1 +
>  mm/Makefile                                   |   1 +
>  mm/page_alloc.c                               | 136 ----------------
>  mm/page_frag_cache.c                          | 145 ++++++++++++++++++
>  .../selftests/mm/page_frag/page_frag_test.c   |   2 +-
>  9 files changed, 197 insertions(+), 177 deletions(-)
>  create mode 100644 include/linux/page_frag_cache.h
>  create mode 100644 mm/page_frag_cache.c
>=20
>=20

...

> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> new file mode 100644
> index 000000000000..a758cb65a9b3
> --- /dev/null
> +++ b/include/linux/page_frag_cache.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_PAGE_FRAG_CACHE_H
> +#define _LINUX_PAGE_FRAG_CACHE_H
> +
> +#include <linux/log2.h>
> +#include <linux/types.h>
> +#include <linux/mm_types_task.h>
> +

Minor nit. These should usually be in alphabetical order. So
mm_types_task.h should be between log2.h and types.h.


