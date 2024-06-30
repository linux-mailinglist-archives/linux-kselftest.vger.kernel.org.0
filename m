Return-Path: <linux-kselftest+bounces-12969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAD891D136
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22926281864
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B201C139CF3;
	Sun, 30 Jun 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWfmX3zh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08F12AAC6;
	Sun, 30 Jun 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744269; cv=none; b=BPwAxuVt4LokrT0ErmCSKdTp+XRbX/BBu66sRbbkJrM55JxvzMbL/jZAfOcYyQvDTpu3g/Njn0R4qhD48EyZpsjxjdHGRp4IOluD1/MgOPa+eRKynNKIFdKzFp+p35hJbyUpFkzSVgBXyGn+02o5imvqkGpabId2yPlDjjGItzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744269; c=relaxed/simple;
	bh=Ckm/UMWon9GZwPjTzl0XhxzfXtwCQ85XxSeLPS4Mg24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cftpErHgL32cXKBtHOeAuslpLh43xHBcZzx/eOJo+yLlwJ5ABi87x2I1gxDHkamAJHXYYgbHFoa8DcxJWlsdtISw8X8oLqBtsWGmhaMuxIZuoihICSEDTi5uFzTWjgn6iuLrB2ilpIqe8b6LlAEFjpkgG+jn3kv6M9TJSFpEk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWfmX3zh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso2551596a12.0;
        Sun, 30 Jun 2024 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719744266; x=1720349066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxZ3tJj5i7QOrkJh0VIa529AtPkb/VxWhsoREUbh1oY=;
        b=HWfmX3zhIJpIPll9gn0znjuX+pAppEyJuEfizbVHT4aPY/QXuqCMtcSajrI+SDW4Pe
         msTeEiSg+JbfemlM1+EgTYbjdD+ieUxW/JAzPcYI/0huIW1luS2CKynpAxR6A+W8uOO0
         9ilOohFDbJEPUuTzR2R/+72YF2kSbz7Y//mkl2PO5tdWtMT5qW1KNKfAwGMxzzlI89MC
         VTMEqEIhn//W22MRsaSW3DsZLqsKOtp1URHXl2+WTe2UpcmZjuM2qMtIz+7iDq0J6r8W
         nRA+iO9be0pbhHTRxNfU+zjaCw2yw+EI+Y9xr7VI+P9WgPzlGzfkas48kT5s9p1YwjHe
         8Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719744266; x=1720349066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxZ3tJj5i7QOrkJh0VIa529AtPkb/VxWhsoREUbh1oY=;
        b=w4irnSMPrZ3uzrCNdniolBAi8rcq98C9isP6jzwgs0MjAGy+aIBkd3yke316bADMYQ
         ET6oS5KmFQfBjv6V1C33nhnStKtWtzq9zBJj1Ma+ahvtR4LubSilf+GHaw5LB8AEhY9l
         P/p2Cyf4XBtrRUPpUkU83kIDBqjbeY5qLEawd9k86F8WusMVRo8EDNyUlGgbvVHhyGzk
         E/bxmprckGiavbuUKwEliIBWI6iTs/zq8JmWHY8NkxXYg4MT/r0i2lS1A6IMWUYeFcex
         L+NHWGEVY1wFaQVNjbEwbdSJlJCXKnAmVd7UHkmdpeaG7k4v+56+RhPjuB0JH0N/oft2
         V2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXky86WM9L6kdEQi6ls9632ggMaqg9BOfNlDVFCVMG1R1eIwmXOdH67xG90QhhFbYJUbXgi82Uh0ppcfNA+AF+1Jw+ARwbD06uQ70ZKp1nJgLRJ1RHluSlnEyro5EnLCWU9E+s9G5ypFH0b
X-Gm-Message-State: AOJu0YxyMoeoDY6wbpPp8XFl5ueQbqvJchBEobJcKjlMw4rUa3KIMntA
	Ul4w1txzRzOOOitF5zpWbenYOlrT8aO430HwCxwaUH0Zav/aA19agvuHxu2mKH6+zu+sECVIx+j
	KCs3aYkAVl8WGlbCCTluchPudFVg=
X-Google-Smtp-Source: AGHT+IEwNnRMTNLVFa2Vct7GYPnmOxdeoHNqOi6hW20KZkNAdRp96NVMLfzP0R695C5mK/j/t4BulFbOfccJlSwZwUY=
X-Received: by 2002:a05:6402:5111:b0:57c:da58:51e7 with SMTP id
 4fb4d7f45d1cf-5879eaff6cemr2096516a12.1.1719744266033; Sun, 30 Jun 2024
 03:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628205958.2845610-1-jiaqiyan@google.com> <20240628205958.2845610-2-jiaqiyan@google.com>
In-Reply-To: <20240628205958.2845610-2-jiaqiyan@google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sun, 30 Jun 2024 18:44:12 +0800
Message-ID: <CAK1f24n_SftNx2WG0UE_d-1tZGieR6VDfeFx9DGjakHQ0VpZuA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mm/memory-failure: refactor log format in soft
 offline code
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	rdunlap@infradead.org, corbet@lwn.net, osalvador@suse.de, rientjes@google.com, 
	duenwen@google.com, fvdl@google.com, ak@linux.intel.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 5:00=E2=80=AFAM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> Logs from soft_offline_page and soft_offline_in_use_page have
> different formats than majority of the memory failure code:
>
>   "Memory failure: 0x${pfn}: ${lower_case_message}"
>
> Convert them to the following format:
>
>   "Soft offline: 0x${pfn}: ${lower_case_message}"
>
> No functional change in this commit.
>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

LGTM. Feel free to add:
Reviewed-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance


> ---
>  mm/memory-failure.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2cf7acc286de..685ab9a77966 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2640,6 +2640,9 @@ int unpoison_memory(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(unpoison_memory);
>
> +#undef pr_fmt
> +#define pr_fmt(fmt) "Soft offline: " fmt
> +
>  static bool mf_isolate_folio(struct folio *folio, struct list_head *page=
list)
>  {
>         bool isolated =3D false;
> @@ -2695,7 +2698,7 @@ static int soft_offline_in_use_page(struct page *pa=
ge)
>
>         if (!huge && folio_test_large(folio)) {
>                 if (try_to_split_thp_page(page, true)) {
> -                       pr_info("soft offline: %#lx: thp split failed\n",=
 pfn);
> +                       pr_info("%#lx: thp split failed\n", pfn);
>                         return -EBUSY;
>                 }
>                 folio =3D page_folio(page);
> @@ -2707,7 +2710,7 @@ static int soft_offline_in_use_page(struct page *pa=
ge)
>         if (PageHWPoison(page)) {
>                 folio_unlock(folio);
>                 folio_put(folio);
> -               pr_info("soft offline: %#lx page already poisoned\n", pfn=
);
> +               pr_info("%#lx: page already poisoned\n", pfn);
>                 return 0;
>         }
>
> @@ -2720,7 +2723,7 @@ static int soft_offline_in_use_page(struct page *pa=
ge)
>         folio_unlock(folio);
>
>         if (ret) {
> -               pr_info("soft_offline: %#lx: invalidated\n", pfn);
> +               pr_info("%#lx: invalidated\n", pfn);
>                 page_handle_poison(page, false, true);
>                 return 0;
>         }
> @@ -2737,13 +2740,13 @@ static int soft_offline_in_use_page(struct page *=
page)
>                         if (!list_empty(&pagelist))
>                                 putback_movable_pages(&pagelist);
>
> -                       pr_info("soft offline: %#lx: %s migration failed =
%ld, type %pGp\n",
> +                       pr_info("%#lx: %s migration failed %ld, type %pGp=
\n",
>                                 pfn, msg_page[huge], ret, &page->flags);
>                         if (ret > 0)
>                                 ret =3D -EBUSY;
>                 }
>         } else {
> -               pr_info("soft offline: %#lx: %s isolation failed, page co=
unt %d, type %pGp\n",
> +               pr_info("%#lx: %s isolation failed, page count %d, type %=
pGp\n",
>                         pfn, msg_page[huge], page_count(page), &page->fla=
gs);
>                 ret =3D -EBUSY;
>         }
> @@ -2795,7 +2798,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>         mutex_lock(&mf_mutex);
>
>         if (PageHWPoison(page)) {
> -               pr_info("%s: %#lx page already poisoned\n", __func__, pfn=
);
> +               pr_info("%#lx: page already poisoned\n", pfn);
>                 put_ref_page(pfn, flags);
>                 mutex_unlock(&mf_mutex);
>                 return 0;
> --
> 2.45.2.803.g4e1b14247a-goog
>

