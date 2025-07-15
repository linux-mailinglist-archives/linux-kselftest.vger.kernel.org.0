Return-Path: <linux-kselftest+bounces-37320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B4AB0507B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 06:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3705B1AA6C59
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 04:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA392D29AC;
	Tue, 15 Jul 2025 04:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTzzCOZ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E456B81
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555139; cv=none; b=Ivls/9Tf9yJZsWSe6Gwa5QBXfLkQ1Aa1qgcaCA+Ho3joXXYRbbOjY1/qip6IqFUWRcuVUVoeI68HjQT506VHYDcdU73wy7evJUCSw8Mc1jnl+22U4mjH/DXKTBvM2GPTxta5Z9o9pzHIbGgnf+MC8jkxDQfLK73kn64DpR6+OtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555139; c=relaxed/simple;
	bh=9QB63VBz9r996WNRV3pyu57KzX9K0mFXfnRk7MDY8mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1plF4ftNm4hC/xtjQ7jJblrTY4CEUBIJNCf7HCwaJw3NWfd4QnZXcnBLY48BrpMJeIeuHj7SnsK4uXhwfA6W77grlKBWBrg7y+AZmjGQMMGvYMT/BzXev6dz8m2og4npj1o675KeblTprREIFuj9dYQzyqXReEXt7AdqW66GZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTzzCOZ6; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab86a29c98so51541cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 21:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752555136; x=1753159936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ8PD3h9aJl4C1vHw50I9+gj4+puVBXvKvI7nIOSE6E=;
        b=qTzzCOZ6GvM3fgUX5qn+nFvXt7OZkTeCC8RCcBf0zSXkJHLU1/0D8hk7Jea/0b3hk4
         m76q0NiALmgw19dtzB0D+KBZ4uLpsCfrb5/t8gAkrCExtYWksPKagDw0keHFaiDh3ueY
         infiV7ByzNMPRVQu5nzP4rW1WdF1FTPtMULbyU6zLF2j7udsKbygz2MHCG4Ww813ah1U
         X9vC2sSd0RelZ/KKAFCPmuz2GNKV7GYmSSQthizfqLGU+9KdWJlf9k0qaflFUVnbuEXT
         qJNoYTm2DjS03mVXENGvqW6ZEijtHq/G6/fMycFJ+21DMUOBs+fOiSTAdwi1MrjLpcCz
         ES1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752555136; x=1753159936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ8PD3h9aJl4C1vHw50I9+gj4+puVBXvKvI7nIOSE6E=;
        b=I2gxodEVx5hILdXAsBycZuUPJrpLSDhqC3lTTM2PAI+b5mWKl9Y2IYDRVSMde4m4WM
         UB1SQ+e1skDLFg1Ox1AJQfpXadol+tw9/XR4fdUsUMGeVw2GfZFh5YIlK8P2jKL0bs7l
         o1PIkHHcMtN2GrGAtm8h9nRAehDOOabAkfBLcSU4HcMNXi8NSmRk8SkarisIQXdcpQdH
         drvZ6PLLAX2IqUeW5pJRDqIBwub+tFMZZUEImkNw0e3dPq0fkp+7rt/B71cijQn+z3jU
         dIo79GT2XPpcEvTDuTGqOTSwvONzmP6QvfHIwXkx8c4Zorc4bh/Rz1hzlYgCDvB5yBmU
         OGRA==
X-Forwarded-Encrypted: i=1; AJvYcCW3PZnYXgJEw1CLyiGGNTYRjNMpvAR6fUxaAL8ajdIS/d1gGAOJBrXwagbPGECSfRypouH6Piv9zeftsHxWxyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/Z4WQo8MN/yIJiSbkpx0zybpRR2hjxBZ/xKkUhHS0elnYy92
	EjlPIpdhlcpb8xBhv5aJNHmlPGh7SM3XKuizOUUi6yb/Igw8WUJ1omVnGG+bQPQU0093hYU4iKk
	8+v1puy9toVGWmUIfTR+RHUc9nEHadcew+vhePC/T
X-Gm-Gg: ASbGncsW3enUvG+DcHTsQUgZjxh7XoHzZFq9KNLha59zzl0OTzdJH0jUTH+Hi9x3Wqm
	c3UVMY/YI9RPJgjFLwc/9zhxXt2pfn8wITr46UTNimlVJbG2pstPRB3xh+gv36gYxHyda2oFOOb
	3xMcJg3wnn6xk2wo1E4WjIJfasVZNcP9QcNARfIEzZGGxk6CMNEjYDOEsvLgjqzPWwgkW1ACerI
	iiazrFF965W85ie
X-Google-Smtp-Source: AGHT+IFYrfbYbITqLsmbDEhhjGXIVHUkcXKfujJVgXOvLl5+zvZ5jKAWuBeT9un5hCCfW2/bB0KRKvBcMzJyu/6aRmY=
X-Received: by 2002:ac8:5712:0:b0:4a6:fc57:b85a with SMTP id
 d75a77b69052e-4ab80b73ff6mr2385041cf.14.1752555135579; Mon, 14 Jul 2025
 21:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-2-ynaffit@google.com>
In-Reply-To: <20250714185321.2417234-2-ynaffit@google.com>
From: Carlos Llamas <cmllamas@google.com>
Date: Mon, 14 Jul 2025 21:52:02 -0700
X-Gm-Features: Ac12FXyXnbLo4F75vEUCjUhTuGs_3hGSJQ3tUclmIrwJ3QRBp55s4SEV7DssqUI
Message-ID: <CAFuZdD+ZCo6s5Yo=OeUt22F9kymERk+a5w1xH32Nyae_29q6PQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] binder: Fix selftest page indexing
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 14, 2025 at 11:53:14AM -0700, Tiffany Yang wrote:
> The binder allocator selftest was only checking the last page of buffers
> that ended on a page boundary. Correct the page indexing to account for
> buffers that are not page-aligned.
>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---
>  drivers/android/binder_alloc_selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
> index c88735c54848..486af3ec3c02 100644
> --- a/drivers/android/binder_alloc_selftest.c
> +++ b/drivers/android/binder_alloc_selftest.c
> @@ -142,12 +142,12 @@ static void binder_selftest_free_buf(struct binder_alloc *alloc,
>       for (i = 0; i < BUFFER_NUM; i++)
>               binder_alloc_free_buf(alloc, buffers[seq[i]]);
>
> -     for (i = 0; i < end / PAGE_SIZE; i++) {
>               /**
>                * Error message on a free page can be false positive
>                * if binder shrinker ran during binder_alloc_free_buf
>                * calls above.
>                */
> +     for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
>               if (list_empty(page_to_lru(alloc->pages[i]))) {
>                       pr_err_size_seq(sizes, seq);
>                       pr_err("expect lru but is %s at page index %d\n",
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

LGTM!

Acked-by: Carlos Llamas <cmllamas@google.com>

