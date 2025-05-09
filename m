Return-Path: <linux-kselftest+bounces-32755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55C8AB184C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BB4B2599B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7957522CBF3;
	Fri,  9 May 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BB1pss0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FE212B3E
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804112; cv=none; b=EMAx/HurtN7vsMmb67oZe+ikn8eVPP8EYuozVeg6/Je6xMcwFfOi5+D4cOESnX0rXHRTxwSLhNxHOyuJo8/CQeKJZQlaylmfer5P1oaV9EEhN1/GYqF27T5YZEEHwMCw5jg3fobz+rlZUu1KD8O98tEpxe+dSQzuVYYf+4RU45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804112; c=relaxed/simple;
	bh=u1B1Sb8RLksBy1NXjA72zmYH17yMY9egg/knUIWH66o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoCiLfk1/X6AueS1P6hV0JRMVdP+ApDePniTxpHHz5Orm22XulLvTQIgbeSxfKWZeGvLXoLV0+MNvxpq0WSqvaW2cpFbqBa2jhKKEEqAmvSPf1BkvPpiafbaxzja30GhKpFJErctKi2wbQ9Bt4GnTKrIdJxJsErLnVC0BbrMkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BB1pss0M; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso53525e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746804108; x=1747408908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PODw7ulR9PB7arm5tdpwF+f90XRe1aMGGhaLajPSDEc=;
        b=BB1pss0MZjio6nl12aXfNmWdhf9aq6TlTwsf4xLUS0FfDlF33VH5+Tza1lEziJAfZ8
         DwoqmEAGOAuxOzvjTzZ1JBCqd0kvQVvzkSNvEcghMxY9CrS03MSRp3wFP8Ekv18Baq4S
         L9fUpNhTKSXJXEHnU6tJRBaa548oEl7bwXH8OLtP36DXLDx3f4SB2rk4c27Rh43+5dli
         38tX5sdjTfqouUAIvkdNfbM5etF5OuwpY35s58Jz46XxOaPAAAEFdzHIkqgCT5FW0P0x
         fU/YODdCzWPfIPK+O38zoT3Tv0hSzSMpVHakfh5YEJtgPaVNHvCcZogi1OcNXGbF2C43
         E4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746804108; x=1747408908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PODw7ulR9PB7arm5tdpwF+f90XRe1aMGGhaLajPSDEc=;
        b=sqKM+3zz3wxArIHc8uDINkwGQpnXgrCQHTm28hh3kbUsX2lDggyjPbiKmtWQ3iHJez
         Kv6NeNP3nGhrsJj05rm0qLPDBYbQbBgnydO3pACm860n9xSvRZUAv3IAPU95t0022dkw
         70w1k9llYeD4skw8dHiv5kWwBbeDg4whPVIg7tqIvdGYchTQLU5bkTSUusT5WfsG2C8g
         5lPERD+lNTEmzGmDzoAyC0lT8ZQtsceCkw1sRfiX3I573M6EI+JjGlvvaagDP48AT8EY
         DMCtHT2/morMoKbxrBAnwbimITsQWxN9BsWliSqQUpOfl2k/jv+T8NDqvJ8XeOoLrmVv
         AxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRLNsXJWUo58Wg2jD5Q0edSS+G/MBVv9l7YvRcGy1Flm7co68Sb0jYiD/gf+EaraM0L1sAago8ozlQ4BVVlyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYr/IG1lXU58F1RVbNSG17zcYP2rWxtBN+70/7ufOCmKLhMQD
	mHtkVerCHYcwEgxa1R9wp02nih34n15eNCYnVOXLLB1BTdY+6tu8VZvB6p/FAGatUg/PkWKnPN1
	749bMiS18S/R6JY9WnqiTSc1U16jIK9gcGfMt
X-Gm-Gg: ASbGncsBr+wfJ9XAgeelr7Tu9bt93p/DCS3sUTW8y571DqDHkZ3mdCft4SfvEtiCudM
	Yg2U0NpPIMGoWkXZvONYcY5mhtk1HwrpRYv6kHcsAY4ZNwqHC4C0468Ogc8aw+ym3gx7ikDqnZ8
	p5nLlOCEPbHXjuqmZUnrTc
X-Google-Smtp-Source: AGHT+IFxWr7UYH5UXN0HFUB2iPnwNf7bB78kgOChbtof0mjoiWXBuO/ayaFDhJMwRvTwWokPxNYOF8Jo1WiZoneiOiw=
X-Received: by 2002:a05:600c:4394:b0:43d:5b3a:18cc with SMTP id
 5b1f17b1804b1-442d6ed7d6amr1049915e9.2.1746804107643; Fri, 09 May 2025
 08:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com> <b1e53d0b-04ba-4ad7-abdf-2406283a9cfb@amd.com>
In-Reply-To: <b1e53d0b-04ba-4ad7-abdf-2406283a9cfb@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 9 May 2025 08:21:35 -0700
X-Gm-Features: AX0GCFvggZ1wxI53q8jeqfq4ZRzo6BIGXGFyIIxksh_oUSEqZ6C2et9zbwejpqA
Message-ID: <CABdmKX0FSPtF08sjr5dKTZXTPs9SqbHfXYKVGJ7sPk5vsRctDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/5] Replace CONFIG_DMABUF_SYSFS_STATS with BPF
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: sumit.semwal@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, skhan@linuxfoundation.org, 
	alexei.starovoitov@gmail.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 11:04=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Feel free to add my Acked-by to the patches which don't have my rb yet.
>
> And ping me when I should upstream this through drm-misc-next, but if you=
 want to upstream this through some other branch then that is fine with me =
as well.

Thanks Christian. Alexei mentioned he was willing to take the series
through bpf-next here:
https://lore.kernel.org/all/CAADnVQLqv-ZpoQEhk2UwvSZorSLcjgF7qLD76oHguH5-Gc=
SXxA@mail.gmail.com/

I think it makes sense to send the CONFIG_DMABUF_SYSFS_STATS removal
through drm-misc-next though, so I'll resend that as a standalone
patch whenever I hear about the next longterm stable release.

>
> Regards,
> Christian.
>
> On 5/8/25 20:20, T.J. Mercier wrote:
> > Until CONFIG_DMABUF_SYSFS_STATS was added [1] it was only possible to
> > perform per-buffer accounting with debugfs which is not suitable for
> > production environments. Eventually we discovered the overhead with
> > per-buffer sysfs file creation/removal was significantly impacting
> > allocation and free times, and exacerbated kernfs lock contention. [2]
> > dma_buf_stats_setup() is responsible for 39% of single-page buffer
> > creation duration, or 74% of single-page dma_buf_export() duration when
> > stressing dmabuf allocations and frees.
> >
> > I prototyped a change from per-buffer to per-exporter statistics with a
> > RCU protected list of exporter allocations that accommodates most (but
> > not all) of our use-cases and avoids almost all of the sysfs overhead.
> > While that adds less overhead than per-buffer sysfs, and less even than
> > the maintenance of the dmabuf debugfs_list, it's still *additional*
> > overhead on top of the debugfs_list and doesn't give us per-buffer info=
.
> >
> > This series uses the existing dmabuf debugfs_list to implement a BPF
> > dmabuf iterator, which adds no overhead to buffer allocation/free and
> > provides per-buffer info. The list has been moved outside of
> > CONFIG_DEBUG_FS scope so that it is always populated. The BPF program
> > loaded by userspace that extracts per-buffer information gets to define
> > its own interface which avoids the lack of ABI stability with debugfs.
> >
> > This will allow us to replace our use of CONFIG_DMABUF_SYSFS_STATS, and
> > the plan is to remove it from the kernel after the next longterm stable
> > release.
> >
> > [1] https://lore.kernel.org/linux-media/20201210044400.1080308-1-hridya=
@google.com
> > [2] https://lore.kernel.org/all/20220516171315.2400578-1-tjmercier@goog=
le.com
> >
> > v1: https://lore.kernel.org/all/20250414225227.3642618-1-tjmercier@goog=
le.com
> > v1 -> v2:
> > Make the DMA buffer list independent of CONFIG_DEBUG_FS per Christian K=
=C3=B6nig
> > Add CONFIG_DMA_SHARED_BUFFER check to kernel/bpf/Makefile per kernel te=
st robot
> > Use BTF_ID_LIST_SINGLE instead of BTF_ID_LIST_GLOBAL_SINGLE per Song Li=
u
> > Fixup comment style, mixing code/declarations, and use ASSERT_OK_FD in =
selftest per Song Liu
> > Add BPF_ITER_RESCHED feature to bpf_dmabuf_reg_info per Alexei Starovoi=
tov
> > Add open-coded iterator and selftest per Alexei Starovoitov
> > Add a second test buffer from the system dmabuf heap to selftests
> > Use the BPF program we'll use in production for selftest per Alexei Sta=
rovoitov
> >   https://r.android.com/c/platform/system/bpfprogs/+/3616123/2/dmabufIt=
er.c
> >   https://r.android.com/c/platform/system/memory/libmeminfo/+/3614259/1=
/libdmabufinfo/dmabuf_bpf_stats.cpp
> > v2: https://lore.kernel.org/all/20250504224149.1033867-1-tjmercier@goog=
le.com
> > v2 -> v3:
> > Rebase onto bpf-next/master
> > Move get_next_dmabuf() into drivers/dma-buf/dma-buf.c, along with the
> >   new get_first_dmabuf(). This avoids having to expose the dmabuf list
> >   and mutex to the rest of the kernel, and keeps the dmabuf mutex
> >   operations near each other in the same file. (Christian K=C3=B6nig)
> > Add Christian's RB to dma-buf: Rename debugfs symbols
> > Drop RFC: dma-buf: Remove DMA-BUF statistics
> > v3: https://lore.kernel.org/all/20250507001036.2278781-1-tjmercier@goog=
le.com
> > v3 -> v4:
> > Fix selftest BPF program comment style (not kdoc) per Alexei Starovoito=
v
> > Fix dma-buf.c kdoc comment style per Alexei Starovoitov
> > Rename get_first_dmabuf / get_next_dmabuf to dma_buf_iter_begin /
> >   dma_buf_iter_next per Christian K=C3=B6nig
> > Add Christian's RB to bpf: Add dmabuf iterator
> >
> > T.J. Mercier (5):
> >   dma-buf: Rename debugfs symbols
> >   bpf: Add dmabuf iterator
> >   bpf: Add open coded dmabuf iterator
> >   selftests/bpf: Add test for dmabuf_iter
> >   selftests/bpf: Add test for open coded dmabuf_iter
> >
> >  drivers/dma-buf/dma-buf.c                     |  98 +++++--
> >  include/linux/dma-buf.h                       |   4 +-
> >  kernel/bpf/Makefile                           |   3 +
> >  kernel/bpf/dmabuf_iter.c                      | 149 ++++++++++
> >  kernel/bpf/helpers.c                          |   5 +
> >  .../testing/selftests/bpf/bpf_experimental.h  |   5 +
> >  tools/testing/selftests/bpf/config            |   3 +
> >  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 258 ++++++++++++++++++
> >  .../testing/selftests/bpf/progs/dmabuf_iter.c |  91 ++++++
> >  9 files changed, 594 insertions(+), 22 deletions(-)
> >  create mode 100644 kernel/bpf/dmabuf_iter.c
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.=
c
> >  create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c
> >
> >
> > base-commit: 43745d11bfd9683abdf08ad7a5cc403d6a9ffd15
>

