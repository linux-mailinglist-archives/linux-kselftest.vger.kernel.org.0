Return-Path: <linux-kselftest+bounces-676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFE27FAE85
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 00:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF36B20ED1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0494A49F6A;
	Mon, 27 Nov 2023 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExUZv8D2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E36D187;
	Mon, 27 Nov 2023 15:41:09 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b37dd4bb35so119881139f.3;
        Mon, 27 Nov 2023 15:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701128468; x=1701733268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt4Rz3NPL3GmvcZqUaAKQKsdcESneE9uQ1F4mASw2qo=;
        b=ExUZv8D2SQYbX62tElW9awKBIexPC1O5Vh42SHWyFSby1iDFF+KzvATQOJREgT4a1K
         tXlKWl0UjsrfccGYa1TQ8bO9YJhlIBZz4B2H1s65sAYiqfJg1B8CIBEqOiRZcZ431hFQ
         RQYmC09aKD0NVyZEovWlKdOz/0OsnkQfPd6Nz2+zYh24b8I7kkAAmH5gS0WCEAICh6t4
         iV/a+K5xak0GLoNYlM7MPEud48M7QQ+XU0NHFjX/wX4ZAJcbdZwXNoo7I3mu14MsPkQV
         OFVA3XD1vs3xGfXAwYpyClt3p9cYY6aEszOOXC0vUWc5FUoLOL1Y7JGTP5oc1M7glXvF
         jx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701128468; x=1701733268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xt4Rz3NPL3GmvcZqUaAKQKsdcESneE9uQ1F4mASw2qo=;
        b=kjLrjZ74ANnx21dTctfHZlGrSZ8t9D+1/L/dfEkYKKpiQA6MILR80nkgPo+QppP/NZ
         WiCWmpVf+GuC3guqdeHi2UaGHGxkQAqn4YRQXBRplPRo4QHJyZTQAvgXN2Fo/ghKjiQI
         bPlkuX0AZXB0XFETw4gJZHdYngGP3yIrK6Aq2PoBDxr0hVnCOGO4MOJX+Qxwegex+QBV
         t4TdQKPqjv9pss8TMu2daIe5t5ut+BjjeQVEOWg54jbYwf9Q6CmeP1kbRhCBfWR36M3l
         Y91A28uRNbUpgMCCVeBNSTUJbWRCuFcxe2w4WzjbJhrANDnqxVUYsyT0zbue35JxG/x6
         nAHA==
X-Gm-Message-State: AOJu0YxXaDgYVzkhTEhZEaz56oVHb7Ge3OMqj6bAI3HlCp+KcGhAKDc+
	DMmbewv1rPzQisPc/38NDWhXIS5sw2o01o6RqN0=
X-Google-Smtp-Source: AGHT+IEg/3ClM23o+b0ka8s38xu6Doj3ui9yCzCVjzWnNRlLwByq1TDlrBx4oyoXY6Ye97ho8aQwWUSgOOUdbQNkbqc=
X-Received: by 2002:a05:6602:4904:b0:795:183b:1e3 with SMTP id
 ef4-20020a056602490400b00795183b01e3mr14365005iob.6.1701128468627; Mon, 27
 Nov 2023 15:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127193703.1980089-2-nphamcs@gmail.com> <20231127224650.2636224-1-nphamcs@gmail.com>
In-Reply-To: <20231127224650.2636224-1-nphamcs@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 27 Nov 2023 15:40:57 -0800
Message-ID: <CAKEwX=Pi4xMmZB2S-vrYDWdPvofGKF_Y+U80Vs__p9Hd57-A6Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] list_lru: allows explicit memcg and NUMA node
 selection (fix)
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, cerasuolodomenico@gmail.com, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Actually, please ignore this fixlet. I will send a v7 instead to
prevent further confusion.

On Mon, Nov 27, 2023 at 2:46=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> The original patch missed a list_lru_del() -> list_lru_del_obj()
> conversion. This patch fixed that.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  drivers/android/binder_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
> index e80669d4e037..f69d30c9f50f 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -234,7 +234,7 @@ static int binder_update_page_range(struct binder_all=
oc *alloc, int allocate,
>                 if (page->page_ptr) {
>                         trace_binder_alloc_lru_start(alloc, index);
>
> -                       on_lru =3D list_lru_del(&binder_alloc_lru, &page-=
>lru);
> +                       on_lru =3D list_lru_del_obj(&binder_alloc_lru, &p=
age->lru);
>                         WARN_ON(!on_lru);
>
>                         trace_binder_alloc_lru_end(alloc, index);
> --
> 2.34.1

