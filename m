Return-Path: <linux-kselftest+bounces-31129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCADA93995
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5133AC319
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E00213235;
	Fri, 18 Apr 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zyZltt2N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7C421019C
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989941; cv=none; b=HJqT68dj+rrxFC4i3npCALrb/Oer4JURzIY2D392x7kpk+OeGVYV8uiegB6JwePxAYfuJrqBkLYqQKKnFaZ4B5CoRn22nsvwW3Jh4/AiHR2AOxUTPL90KmS/fkts7Sv8pqCffuyzimoVw38qpSW4H2/tr3z5G+p2h1IQ9HwJRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989941; c=relaxed/simple;
	bh=KLMQ/sPbd3/qPx9kvWI7kwA5vqce0csvK2YZ+gn9jtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQnEvZFNInty2fBUlfhKRFsVcdbBX+luKB2s9qyBlmvBWCGGntWy8vTj5r6D0JOheNkR614RNEt//JpgeAAhAB4LiMKvFbCeropoXN9cJxtEPQauH7PmZyLVOodvPZ6/GR3A+OHuZJC5sv+p8KBxi2ETlAEXdy8Ggfr4XKkpuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zyZltt2N; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47666573242so481841cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744989938; x=1745594738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLMQ/sPbd3/qPx9kvWI7kwA5vqce0csvK2YZ+gn9jtw=;
        b=zyZltt2NLgNh064Ghml7lx/Gue0ClpWmp+kcZzJOqivelytKm1ubsXNfy5RaE4SyGp
         saLaGE+FmDpym3LMk24mD3q68U1LM3zbEhW8F0irxN5sHUgENt42MfmP5Dwz4aZfyVlF
         o4nw66xxaTyWZzYOO1Y955LNT+JHdE4H4o/3XsvqSDQDxxHQBUohqb9dvvKXG6HceLQm
         sCOb62TJ/7azxNLXC+YwPpbn+khYrE2bi5XCcddNIeNg4Cy9wVMpev2ynqIyomEKJfbR
         Ar1B52Cq4DTrF43PV9oaXF7pHi9jUqCsDfOTAPAVA3D4JR+M4JEKVz6JWbMIao/e25XA
         WMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744989938; x=1745594738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLMQ/sPbd3/qPx9kvWI7kwA5vqce0csvK2YZ+gn9jtw=;
        b=TArtinbtRh0GkyaGzmK9ebCU+nFWxMY+HJR8BqmVCBRYjpBgpLNFB5D9ApC8yMkBh6
         yRxPy4nPgXQqxwuDqnnpuyd1mWcVBTayvN8EyUAk/5LskptUjW+POUVuvLHnXdosQAum
         X/o+2a2A2U5KDYitLhKYX3QJVssULy/sjhNu3weolg53fjGl7OLyRXYOS0N/+u0PlfV7
         jjgd6kfluyROfLNpCzhjgEV52WEm1P3HdNwgI9LJ9edvQoOE282qIkFVMov8rWDZZh4b
         pA9vt1wZUwcnoeQ8WHFvdDq9w/2DiaAV5eEvyEDHYJd2UdA/WoA1+w1rxRtptDWyIcHg
         D0mw==
X-Forwarded-Encrypted: i=1; AJvYcCUXRbGo7XSU9WgmQpTzI6RpQ8+nEcXUfsLj4cpyxNh8WgoMRhrrMpAdEST+zgUzmfgPxox9MiCE3o+u6x88lJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr36pmFa2cE83reDwJ0QF8XSPD27cPRSu6N7lwSDwA0+PlkXEx
	rx/1BI4jT2oUE8QekSvcBbfgiEcjfcNeRQMa1jbJ3hqVk+XzFNZjIxB/4PgNVZ8NB1RVu1UInJh
	IswFmgHgnFFDhlRRBi7HVo8XLu8pySen2XOYV
X-Gm-Gg: ASbGncu6cER85wxau2DpIjEIHB8Z3HS2jAteAoQaKpZAw/4c2xIXIgJke65H64G+4iJ
	9Y7vHnRrp1R6fkAT6VWsTC4cVpJ+WZuRLFMF8c0UO55cuWkv9PKQ90WUlt1rzEHHPmVySNW2Bg7
	stp9Dc16pvuheaFsoTlqWF
X-Google-Smtp-Source: AGHT+IG8hFCpUPixQxkgnzGIXz1u9OtkRLiT9un/wX7YdVEX+ucM013ElGjUErTcY8lmL4vrTIPIJfqi3eMA/XDrm6c=
X-Received: by 2002:a05:622a:24f:b0:477:63b7:3523 with SMTP id
 d75a77b69052e-47aeb10f6a4mr3977681cf.4.1744989937094; Fri, 18 Apr 2025
 08:25:37 -0700 (PDT)
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
 <CAPhsuW7xvSYjWvy8K9Ev_tMwDRy2dpEiBcHYai3n-wAa0xvLow@mail.gmail.com>
 <CABdmKX1p0KgbipTSW1Ywi4bTBabQmsg21gA14Bp5atYHg8FeXQ@mail.gmail.com>
 <CAPhsuW4f2=M_K553+BVnGJq=ddZ7sXj4CfCAHeYQ=4cpihBCzA@mail.gmail.com>
 <CABdmKX0P1tpa-jxzN1_TCyk6Cw6drYM+KRZQ5YQcjNOBFtOFJw@mail.gmail.com> <CAPhsuW5bgBNu6zY0rn7ZH4VK54nruryU4bS4LrDDsxnCfqQicQ@mail.gmail.com>
In-Reply-To: <CAPhsuW5bgBNu6zY0rn7ZH4VK54nruryU4bS4LrDDsxnCfqQicQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 18 Apr 2025 08:25:18 -0700
X-Gm-Features: ATxdqUFe9V2DPeKz_fCeXdwNGaeIYNCwZNnBebHg8eIdjjPIFTp9wITPuXs7j_A
Message-ID: <CABdmKX3XaVFJEQRav1COi7_1rkMsx1ZhrJoGLB_wtywZ0O-jug@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: Song Liu <song@kernel.org>
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

On Thu, Apr 17, 2025 at 1:26=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Apr 17, 2025 at 9:05=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Wed, Apr 16, 2025 at 9:56=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > On Wed, Apr 16, 2025 at 7:09=E2=80=AFPM T.J. Mercier <tjmercier@googl=
e.com> wrote:
> > > >
> > > > On Wed, Apr 16, 2025 at 6:26=E2=80=AFPM Song Liu <song@kernel.org> =
wrote:
> > > [...]
> > > > >
> > > > > Here is another rookie question, it appears to me there is a file=
 descriptor
> > > > > associated with each DMA buffer, can we achieve the same goal wit=
h
> > > > > a task-file iterator?
> > > >
> > > > That would find almost all of them, but not the kernel-only
> > > > allocations. (kernel_rss in the dmabuf_dump output I attached earli=
er.
> > > > If there's a leak, it's likely to show up in kernel_rss because som=
e
> > > > driver forgot to release its reference(s).) Also wouldn't that be a
> > > > ton more iterations since we'd have to visit every FD to find the
> > > > small portion that are dmabufs? I'm not actually sure if buffers th=
at
> > > > have been mapped, and then have had their file descriptors closed
> > > > would show up in task_struct->files; if not I think that would mean
> > > > scanning both files and vmas for each task.
> > >
> > > I don't think scanning all FDs to find a small portion of specific FD=
s
> > > is a real issue. We have a tool that scans all FDs in the system and
> > > only dump data for perf_event FDs. I think it should be easy to
> > > prototype a tool by scanning all files and all vmas. If that turns ou=
t
> > > to be very slow, which I highly doubt will be, we can try other
> > > approaches.
> >
> > But this will not find *all* the buffers, and that defeats the purpose
> > of having the iterator.
>
> Do you mean this approach cannot get kernel only allocations? If
> that's the case, we probably do need a separate iterator. I am
> interested in other folks thoughts on this.

Correct.

> > > OTOH, I am wondering whether we can build a more generic iterator
> > > for a list of objects. Adding a iterator for each important kernel li=
sts
> > > seems not scalable in the long term.
> >
> > I think the wide variety of differences in locking for different
> > objects would make this difficult to do in a generic way.
>
> Agreed it is not easy to build a generic solution. But with the
> help from BTF, we can probably build something that covers
> a large number of use cases.

I'm curious what this would look like. I guess a good test would be to
see if anything would work for some subset of the already existing
iterators.

