Return-Path: <linux-kselftest+bounces-31068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482DA9222F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0CC5A1C55
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C64C253F30;
	Thu, 17 Apr 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05T8qUJ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB556366
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905906; cv=none; b=ErqR+UATCrkmIIdLS21oxejPOviumNuMvLgoOEzK7CZLxfN/U2IHXIJeHVkLgIlsG4hzAvDzPeav+ZN0h7+JD9brYNJZLaN6AtsotoccBk/k8eVsuECqXz99xeugXpqb+XYDJyVhglSHBapQ2luysHQ7rtmoNUPxVHjS/+weYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905906; c=relaxed/simple;
	bh=W8qDOiyv1h4pWlH3g88O7C4xDqIzRDAqgGgkiAByMFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebS28A/gZD6StuemC4RHZiL9L9NJeUH9smIaj1ulBkkfAlh/X7FOVDY3BERfxRHXwezNymAWnip+KeI9GDHvkHD+P/gDFh4pXHvh9lp3LQyj0wd0g67fnXYzyV4p/fA0JbkiGMY0S6qvyHeiOwgvLAtUGvGqw3Qcn7EjNQw4JaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05T8qUJ8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ef83a6bfaso64855e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744905903; x=1745510703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8qDOiyv1h4pWlH3g88O7C4xDqIzRDAqgGgkiAByMFA=;
        b=05T8qUJ8RoX5tk45LI7g4c39PTyk5OSEfS5W7exQ5fG9bISBxuDnOWbP8RqIYV/KF6
         Ol6CSpSsyUGmbn3e6GPGa+gftSEpY91LDcfFZ43bpOcdbltJIadnEhoCbUXGqcXLhoSj
         UZgPtAvH9uYXzMZXR95hazlrI8KI+JNcrhSCR+zoI7MyIbJjj/dulsuNpTLbL7Iy/0cy
         yepyFRLzt/XMP79Cp6wYU8wC2eCu6KWYQRac6/gQmkPr6faMqUiRlfJ44bCqNhdx+0AR
         oxI9kkVBz/KUZ+ns1F/vu0IJojmOqe9sNa9JuPf1pt3BWdUlCDNcYSxBIIJaRL9KmUGt
         gPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744905903; x=1745510703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8qDOiyv1h4pWlH3g88O7C4xDqIzRDAqgGgkiAByMFA=;
        b=GgFJ7Zd3zkT3O/Y1tt2eJoUfd5F7K2IHrcNKF1tPR2KSb9DeuUxzLuselz7fi3IPsX
         PITSYM1nCyfaWH0pxJlLn05j7ccJpkagTwiGa4wLPM0FkWdbGshwuCpruERhI0B3RNo6
         nYbVInQ9zpDNXIq+FYhfUYxZUs+WH/e3AG+2Tj63A3AoI7vj9v3itGza4TQU+o4jAoPw
         KH2GAvbnP2XgMY5fTOI9CKGmgl6D9Sk8/w4PErahCRyCmxrxFRKi3oz2vttLobfuAAjq
         dSqvubn4BDqWBYNX6p3TlCuUq3W8Sz2jnDBMwaNeW5n3wavAtc3T0pvH4mFYqrm4ALf1
         V9wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQNPGUJHVq5ALH1sbh7tBR5G0BwJG7Mq5hKYePJspNK5ptbP6OIoPhueqzXUJmjgYjikDZbJfmG1L8JWsxgSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQCmLOWQVx/ZtafelMDTKUB/vouHB3YCryacDYVIMBk6BQ9/wn
	AlDwVuoYiOI9RNe70RHCmusCbxo+LX5yCci6Dcheic9YOYdsmarjt8cvicUvU3Jo4ZvDbYPcz/x
	Tlu23RtZNMDoxgWmXXzrDl3T+8FChBk3mb3lr
X-Gm-Gg: ASbGnctWIg8hIi38JDzBrR2q42UKuAb9uI6jktNW102OG9SN6IsVY/Qye1ATJIhQkvz
	V33QToZVYuT/mcZGTxP7XIR+gPSnrgmyJy1r6XGc0OjClnMvgvijTC0Sw1g4UTEcd4unO+CeMXg
	+obADDalK8DhLu2kUlbuLeeP52/5/kKNhKBR+XFP0fxCAP015VkGw=
X-Google-Smtp-Source: AGHT+IHPxO/HoUoGfRA0x5PPvATzdMA6UAFEJv1oRfObulb1rUcdqwGzvQUiketg6T4NXeqjA4RD4Ot7mU9EPOGp8HE=
X-Received: by 2002:a05:600c:1c1e:b0:439:7fc2:c7ad with SMTP id
 5b1f17b1804b1-44063d6fe78mr983735e9.7.1744905902735; Thu, 17 Apr 2025
 09:05:02 -0700 (PDT)
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
 <CABdmKX1p0KgbipTSW1Ywi4bTBabQmsg21gA14Bp5atYHg8FeXQ@mail.gmail.com> <CAPhsuW4f2=M_K553+BVnGJq=ddZ7sXj4CfCAHeYQ=4cpihBCzA@mail.gmail.com>
In-Reply-To: <CAPhsuW4f2=M_K553+BVnGJq=ddZ7sXj4CfCAHeYQ=4cpihBCzA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 17 Apr 2025 09:04:48 -0700
X-Gm-Features: ATxdqUG71xXjeNh_Y--IqcHwHgbok8UYG45JYmWjM55y53LlzggibWtxWiJMWb4
Message-ID: <CABdmKX0P1tpa-jxzN1_TCyk6Cw6drYM+KRZQ5YQcjNOBFtOFJw@mail.gmail.com>
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

On Wed, Apr 16, 2025 at 9:56=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Wed, Apr 16, 2025 at 7:09=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Wed, Apr 16, 2025 at 6:26=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> [...]
> > >
> > > Here is another rookie question, it appears to me there is a file des=
criptor
> > > associated with each DMA buffer, can we achieve the same goal with
> > > a task-file iterator?
> >
> > That would find almost all of them, but not the kernel-only
> > allocations. (kernel_rss in the dmabuf_dump output I attached earlier.
> > If there's a leak, it's likely to show up in kernel_rss because some
> > driver forgot to release its reference(s).) Also wouldn't that be a
> > ton more iterations since we'd have to visit every FD to find the
> > small portion that are dmabufs? I'm not actually sure if buffers that
> > have been mapped, and then have had their file descriptors closed
> > would show up in task_struct->files; if not I think that would mean
> > scanning both files and vmas for each task.
>
> I don't think scanning all FDs to find a small portion of specific FDs
> is a real issue. We have a tool that scans all FDs in the system and
> only dump data for perf_event FDs. I think it should be easy to
> prototype a tool by scanning all files and all vmas. If that turns out
> to be very slow, which I highly doubt will be, we can try other
> approaches.

But this will not find *all* the buffers, and that defeats the purpose
of having the iterator.

> OTOH, I am wondering whether we can build a more generic iterator
> for a list of objects. Adding a iterator for each important kernel lists
> seems not scalable in the long term.

I think the wide variety of differences in locking for different
objects would make this difficult to do in a generic way.

