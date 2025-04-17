Return-Path: <linux-kselftest+bounces-31035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7BDA91266
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 06:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DF0444644
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 04:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF6C1DE2C7;
	Thu, 17 Apr 2025 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOzRgPEl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0BC7E1;
	Thu, 17 Apr 2025 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865815; cv=none; b=pCWvIOA6IG9oxd8zkrOgYtkv5YBfO+8KcYu3v8lxF+f+dkT2Ev95Co9lQsotpo0BOk7jRqKM1RaRXqkN3aA/bID/pd6D0nL4xwjv4QNcnBrieAzjNCPzGzC+NFO++03CDUW6uKpLxsu5IvqU+58ymS8ucrdOldEzH+mAQmhn3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865815; c=relaxed/simple;
	bh=tmm+QbmYJM9NZANVpptZlZJKOk0h1i4DjoknpPROUPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWKMO0b93ZID1JEDvMH7fJCtHcYZbyaOQMzwBZS95dtijVIZ3rfWCpYsjRTKhKOhqPom2u5bLMvpksu2qCgu2Cqf/40z4Uwu8DvrjYJhH01y2FfQmRsdmaQtEM2td/CxDObXPoqr0BzY+EaTnpcyyOEwtzXND4lpuRSOs4JuEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOzRgPEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E02C4CEF5;
	Thu, 17 Apr 2025 04:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744865814;
	bh=tmm+QbmYJM9NZANVpptZlZJKOk0h1i4DjoknpPROUPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jOzRgPElQp93kazf5N8ZLE36wCfnQfc/BSR1PlnioJ+7xdRk/0WpJnnsRx/Qdnl3o
	 QpoKwWCrQbBa35QDzAuN8O+WySYMdVszRRxxefobklHRgptRnAr9N/cvTItH5K3/bU
	 PUkAcpByBZVvHhFqutwjajJg9UDcRXKrLsMR+SAhss/UbgROw+hEjVgK9P3oNEOeHl
	 hqFVia1DUWziQGWUlU7f5L5+aDdBCeCUV1fRR3b/1zRVuKM0erDMlzF+WnAOL9rswi
	 1fOlEWuqztK1v1I1R/zYPiqzRkkTfVsS31CyQqcwepARS0SyFv13Gals0JpgopaI0u
	 q9VAL+9UW8ARA==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47663aeff1bso4087991cf.0;
        Wed, 16 Apr 2025 21:56:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHXMtYooPqjcEFpYqr3uxPBIN50Af2LZSdTz5pCBvMQZKHYO52O8l46WS3wD/9HDZFkGJB89d2BOej8L8=@vger.kernel.org, AJvYcCUZOFVGalkX9xDA2M+Wce5BV7WEO8xJy5m+WR84Wx24J5qkT3KCeIJuT07+XkcCszCsKA8=@vger.kernel.org, AJvYcCVB5D3V+MQ7PntTR7BPadsT+ObAgEq3O3BmHMEXJcvO7+CnURvdUO5QQy63BYn+qGa2D0oSNyj2p4s9c7AKtOxb@vger.kernel.org, AJvYcCVBO9b6sWSGaU2AsJ62NLdT/G25017EReOIUKOBnjvRtDixiydlnyXdtaZsEBrPzJqnf/XMRgt0HvzcKfN3@vger.kernel.org, AJvYcCWFzL+kqO5byZbmU+FIvOPYObCH60ll47n3yV7c74Bv5JPoiDYHMOZNKZprFXDyZuobK87necDmk7/g@vger.kernel.org
X-Gm-Message-State: AOJu0YztLT6HEQJrAhjJigdriIjWUyTB/gkWKekWo9WFxKvNZ3eIFoF+
	2ou4ig2wX0VCw6VpbovuQ4OdTk5dMqBcbA6Ms/v534pJPnQ+sH9NK/Nre2WjWiyCpjj0VTczQJN
	Vygy9zfdIzgTmrAmw5fmIvkMKn8Y=
X-Google-Smtp-Source: AGHT+IFj9gpXjOfNBYbsZP+Vn5QpEwyj6N1RuCl0FwfJ9EBQ3/JCBLMKfIVXQXchSLXzLc6c/p6NnT4JZBn0Ik2MUXE=
X-Received: by 2002:a05:622a:650:b0:474:db2f:bd32 with SMTP id
 d75a77b69052e-47ad810c870mr59493241cf.38.1744865813457; Wed, 16 Apr 2025
 21:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
 <CABdmKX0bgxZFYuvQvQPK0AnAHEE3FebY_eA1+Vo=ScH1MbfzMg@mail.gmail.com>
 <CAPhsuW72Q2--E9tQQY8xADghTV6bYy9vHpFQoCWNh0V_QBWafA@mail.gmail.com>
 <CABdmKX1tDv3fSFURDN7=txFSbQ1xTjp8ZhLP8tFAvLcO9_-4_A@mail.gmail.com>
 <CAPhsuW7xvSYjWvy8K9Ev_tMwDRy2dpEiBcHYai3n-wAa0xvLow@mail.gmail.com> <CABdmKX1p0KgbipTSW1Ywi4bTBabQmsg21gA14Bp5atYHg8FeXQ@mail.gmail.com>
In-Reply-To: <CABdmKX1p0KgbipTSW1Ywi4bTBabQmsg21gA14Bp5atYHg8FeXQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Apr 2025 21:56:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4f2=M_K553+BVnGJq=ddZ7sXj4CfCAHeYQ=4cpihBCzA@mail.gmail.com>
X-Gm-Features: ATxdqUEk4T3fY6FmmJQdbVRkM42dn04Z_qBTtTJMviwnBymsHkeSKzqSCEwNWdE
Message-ID: <CAPhsuW4f2=M_K553+BVnGJq=ddZ7sXj4CfCAHeYQ=4cpihBCzA@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:09=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Wed, Apr 16, 2025 at 6:26=E2=80=AFPM Song Liu <song@kernel.org> wrote:
[...]
> >
> > Here is another rookie question, it appears to me there is a file descr=
iptor
> > associated with each DMA buffer, can we achieve the same goal with
> > a task-file iterator?
>
> That would find almost all of them, but not the kernel-only
> allocations. (kernel_rss in the dmabuf_dump output I attached earlier.
> If there's a leak, it's likely to show up in kernel_rss because some
> driver forgot to release its reference(s).) Also wouldn't that be a
> ton more iterations since we'd have to visit every FD to find the
> small portion that are dmabufs? I'm not actually sure if buffers that
> have been mapped, and then have had their file descriptors closed
> would show up in task_struct->files; if not I think that would mean
> scanning both files and vmas for each task.

I don't think scanning all FDs to find a small portion of specific FDs
is a real issue. We have a tool that scans all FDs in the system and
only dump data for perf_event FDs. I think it should be easy to
prototype a tool by scanning all files and all vmas. If that turns out
to be very slow, which I highly doubt will be, we can try other
approaches.

OTOH, I am wondering whether we can build a more generic iterator
for a list of objects. Adding a iterator for each important kernel lists
seems not scalable in the long term.

Thanks,
Song

