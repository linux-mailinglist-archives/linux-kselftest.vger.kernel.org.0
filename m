Return-Path: <linux-kselftest+bounces-36107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B1AEE1D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2001887FC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D728D8E7;
	Mon, 30 Jun 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCKsBch2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12B28B7FE
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295695; cv=none; b=AxVtPq+Yhfey6T4IP6FF3vPAkxYaOx4dq/tTZ+EQghS0yuPwiViFmTM6ZEfSBy9Ty7l6b/LHokOjIYc7MieOcdAXCXYkHpT7VxQLp20m9jGzFIRIWGj7qlgFB5l53nq32SjIgTxoMN1k+yoLWVCPW2J3g+Jl4LpUSKPEK22s8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295695; c=relaxed/simple;
	bh=bA2iVNqi1xBKfeRItYPrF/CNMUgz/auMZ2sX65vERlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9rLq43UWMN+WINlZNGnsHM+BjdhVCYRcTxy3LDqo6IPBQBw4OO/MyApRoE8p/D5xgzZRvXzbbG1IRsz0Y4yUzPefyUvrnFHoIuPN2qsVhMymHkcETEo9l/w2YL4BSh80oufaJtat4IhU+Qnnc6hSFxGDf2B6RyHqhstocK47p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uCKsBch2; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c16e658f4so1134101a34.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751295692; x=1751900492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=15iePih5BC5Jn/3k3dCq80lQGBhxEjm0LI0eUO5reYk=;
        b=uCKsBch2OVUu3+mV617U4c1Rp6E4Cr61unWNVV1P+4IEUxOlw0hZGxQvgVvWEWCQYe
         L3PjlHnR8947/pjnoXfWyNaKLw9UzzHsy29cI70YLQmDyNTUekKz3z+rxVsTp8B6YNIO
         TXm5BBSKjTtLzX9Znr1YXFMVOdcic7gj+P4KHO6+BkpxKTE6UNuv7TqWnVbSXGXClFRt
         dnhEzRd3XXDyC7kTVA/5IVpQzH6YD3XOdCHKUfyO6Art1cLtOI9q35Ax5ylH5XSB/icn
         rOLVhhJcVPyjiZYtvAxYwJj7GLlXeTWBy0q9eqS14c6RJIbPNIuLOPt2oFJ0ZJVbYeOo
         DyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295692; x=1751900492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15iePih5BC5Jn/3k3dCq80lQGBhxEjm0LI0eUO5reYk=;
        b=Oy14HmiVNlVtVTeq2vS/7jn9yS0N1nbpdNyey7y49lHS1ueSas8x2SayDRXFjGgsp9
         xqIFEkp2gKV1HFi8ojopeAPSV3/FQZB5asl7cqBvV0VKJq9s4799dmEzUFyF1RMDFpJC
         E2ngA8yD/Gssw9aJzRrV825Y6oXFUFCGy8UPf1CVDLMYJRzYjJnd3Mmc86pVo5FJOpjF
         wvs/mZ533D4V3TgW/SY4bbjPVeeVfSMLDcppz05QBpahILGiDZ9Pn+sb0a2FLCKpOVqY
         pSj1j7F1zcH7n1vQKnH7AX8AJyaX7FsoqX/sz8j6g2RDY8eq+ZrZ/Jy7r6QW0lH3U9eS
         Gmmg==
X-Forwarded-Encrypted: i=1; AJvYcCUHwxEEAS+gZkj7TiJ32sqV1uLzDs+fUINRdTosiDCkC6oijNuBLEMvSfGSSG1vycLjiv+LeIL+8Hz7EBgJmy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRTmYvcs2x2a2TE13DE3NQkEkIiRU5eLdcHlTDk1PlBBljvnh
	bCNnkEil5VxzLBNusjIxHK/ORb53y3+Gwc6jOM/+DqVfZPISB3pltLrY9SwFU00IleRMwDlmgUz
	PvruPgjpV73kTl5onuTlMPMPsLQX2IXZ16J+WJob8Kw==
X-Gm-Gg: ASbGnctUJlZk5zO7yLiLYC+z21lxVviZCQl+A75v7d6e7Vq5lNMyzwfdJ2GjSd7RSSi
	3UmjDUFnFQcXoKJaDXB5rLHTGSqfXjOTSkVybrXAollSbnp5lupkWNMOpMZesZ7QIunttB5wOuC
	C4AIgiJ1SE8Gixbc8r6kcZKNqgj2PeEPNwdi2/gGg8S6vV
X-Google-Smtp-Source: AGHT+IH39dcYGayERTHKwfkUbm8atj+vg9Buf7IQPXCRI9PooAjIYyvSqsdYej+jsm7V5GylTSqfC6HfkDzqBwhgvgQ=
X-Received: by 2002:a05:6870:a512:b0:2bc:7811:5bb8 with SMTP id
 586e51a60fabf-2efed6aa567mr9175890fac.18.1751295691384; Mon, 30 Jun 2025
 08:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627200501.1712389-1-almasrymina@google.com> <20250627200501.1712389-2-almasrymina@google.com>
In-Reply-To: <20250627200501.1712389-2-almasrymina@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Jun 2025 18:00:55 +0300
X-Gm-Features: Ac12FXy1xBEUxoV-RSx5hkK5xW-WOODrAl4t6LxpeZZdNAPeYcO-k0boL2C7b-c
Message-ID: <CAC_iWjLY10NAW7b7-vk5UD3x-Nay=4sfAW5uowq2MKyK_h-6aQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] selftests: pp-bench: remove
 page_pool_put_page wrapper
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 23:05, Mina Almasry <almasrymina@google.com> wrote:
>
> Minor cleanup: remove the pointless looking _ wrapper around
> page_pool_put_page, and just do the call directly.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  .../net/bench/page_pool/bench_page_pool_simple.c     | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> index 1cd3157fb6a9..cb6468adbda4 100644
> --- a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> +++ b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> @@ -16,12 +16,6 @@
>  static int verbose = 1;
>  #define MY_POOL_SIZE 1024
>
> -static void _page_pool_put_page(struct page_pool *pool, struct page *page,
> -                               bool allow_direct)
> -{
> -       page_pool_put_page(pool, page, -1, allow_direct);
> -}
> -
>  /* Makes tests selectable. Useful for perf-record to analyze a single test.
>   * Hint: Bash shells support writing binary number like: $((2#101010)
>   *
> @@ -121,7 +115,7 @@ static void pp_fill_ptr_ring(struct page_pool *pp, int elems)
>         for (i = 0; i < elems; i++)
>                 array[i] = page_pool_alloc_pages(pp, gfp_mask);
>         for (i = 0; i < elems; i++)
> -               _page_pool_put_page(pp, array[i], false);
> +               page_pool_put_page(pp, array[i], -1, false);
>
>         kfree(array);
>  }
> @@ -180,14 +174,14 @@ static int time_bench_page_pool(struct time_bench_record *rec, void *data,
>
>                 } else if (type == type_ptr_ring) {
>                         /* Normal return path */
> -                       _page_pool_put_page(pp, page, false);
> +                       page_pool_put_page(pp, page, -1, false);
>
>                 } else if (type == type_page_allocator) {
>                         /* Test if not pages are recycled, but instead
>                          * returned back into systems page allocator
>                          */
>                         get_page(page); /* cause no-recycling */
> -                       _page_pool_put_page(pp, page, false);
> +                       page_pool_put_page(pp, page, -1, false);
>                         put_page(page);
>                 } else {
>                         BUILD_BUG();
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

