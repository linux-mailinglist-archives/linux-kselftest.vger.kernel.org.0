Return-Path: <linux-kselftest+bounces-31084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32479A92C43
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 22:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79021B65F40
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 20:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32528209F2A;
	Thu, 17 Apr 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6W+nuAg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8987208994;
	Thu, 17 Apr 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921584; cv=none; b=iRtoyGtSbhoswWFVGOaZ+r8qYvyqOQPhQadCIVHoBMm72NMV6+KspM9TYck45aSXVOwYJvIWLxBnjD4xsTy08+ORceBk11y6oZpEqY6LSNPdppZVJBOFcN2Yp5o0+HxMb4Dm5yvF70X8dNAm/LaF9noT6Nd2O3drjga+ICp2jOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921584; c=relaxed/simple;
	bh=MSIoVWYIYAa+sUrhLyrq1Kjxud8OtJpQnV0I5LjBO3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVswUqoexNm7yLL8U16cLMfEXWcnVlz6m0WOBUmx+G1XO2GHXXoK5AUAnbfcMjtnMuFOyrNVRhae4kRSDYWMNWP/p4uBTo0sZuser/kcNdf3S7fW6kgve+ve3nbTVx5s6laWfcxZiqM+wS2rGiwhsUPFDqGCii4xXb+UbG8MRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6W+nuAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EA8C4CEEE;
	Thu, 17 Apr 2025 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744921583;
	bh=MSIoVWYIYAa+sUrhLyrq1Kjxud8OtJpQnV0I5LjBO3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N6W+nuAgF8wmxKr9Z/HKX+7tNCeuSss8zKQJLTwMz+IlsS4t7ZGGhILI/OR6ppTfq
	 l60y43C66mjR1XBnTy6Tvsl+Enal2NTF4guNNvdWNaeI98/J8uSl3BW6KKuDieWcY3
	 AOFRjW4JSrXy4KVbSNAIGZW0hwTlRJwCN93DnuiaaPgHG6Omn0WuFNn+Txuf3Fcb5e
	 OMdtwBBITtFF4V7zQlc5VKa+f6flSy3a2n2Ap2A0cQNfLB8TjfZtxMphcDH8BUTlCx
	 Hzzg1UQzL/VnNePd/2jGcqXSq2xM5tEpwLtEEJI51FY05tI8qQ19ovPSQ2TpKjclGk
	 IM98KcsvSEaUQ==
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227d6b530d8so14687315ad.3;
        Thu, 17 Apr 2025 13:26:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0H0j4l7uJhkyI51k5/xqlY1BOk8oADCT0uof/EqQ5blG7OXro29NN21HHGozE4KxSwVWu3DzYjEUCm58=@vger.kernel.org, AJvYcCVLTBz1DQsqdlzPqakDWDI5/0okKXZKEc6Aug/HxSyJkyXlTEfWXYxFF0RGrzXA08fc5AGez8jitlgq@vger.kernel.org, AJvYcCWgqXDw+jwOzxYtt2uVqiclsOgNbqFZgqJ82e/0DQ11kf87dPPZOrgGzHGqLjEIfqtqEDw=@vger.kernel.org, AJvYcCXI6Uq7FOgz2sAsNusnV0BlpJCUzYmn3kfRhdsuS4Iqs/lLBkuJ8NA/+3V7TWFApbd6QuHUShAEnDeYsgpCHFHP@vger.kernel.org, AJvYcCXqRb/cKMq1cfCX198aNz4GVbld77109eUMJ2RfHlhUffsxmwvU1K4H0uwaCOSxM+fl36DCjakqNhUSJd6T@vger.kernel.org
X-Gm-Message-State: AOJu0YyXsq1YjyJMZwu0TI04ljx12iQiipW1TMYP+VDZ49mIClgUqiOL
	YmTcz/JYNu1Muo01L9WmsDvvGsWqjFp2su2mHADcdaL+BUIUbZo+FmpyAc8oovNpLFgfxTHD3rh
	hlaiv6KUD1wUlFDg2mzlJG2au4WQ=
X-Google-Smtp-Source: AGHT+IFIdrqkfQ2yDNhbz/9FblYuTge4nV1XL6JmTPE16v3aMPcbe2NW0UpaM5bS7OK2a90u3v9z9kEDj0ljXDeJmJ8=
X-Received: by 2002:a17:902:e5ca:b0:220:c911:3f60 with SMTP id
 d9443c01a7336-22c536283ffmr3670365ad.47.1744921582932; Thu, 17 Apr 2025
 13:26:22 -0700 (PDT)
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
 <CAPhsuW4f2=M_K553+BVnGJq=ddZ7sXj4CfCAHeYQ=4cpihBCzA@mail.gmail.com> <CABdmKX0P1tpa-jxzN1_TCyk6Cw6drYM+KRZQ5YQcjNOBFtOFJw@mail.gmail.com>
In-Reply-To: <CABdmKX0P1tpa-jxzN1_TCyk6Cw6drYM+KRZQ5YQcjNOBFtOFJw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 17 Apr 2025 13:26:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5bgBNu6zY0rn7ZH4VK54nruryU4bS4LrDDsxnCfqQicQ@mail.gmail.com>
X-Gm-Features: ATxdqUGujoL1qIc8Dt7pK8kwCaaGN6jWIU0L4gFL9hmFjqYOACzGGnezHayKk80
Message-ID: <CAPhsuW5bgBNu6zY0rn7ZH4VK54nruryU4bS4LrDDsxnCfqQicQ@mail.gmail.com>
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

On Thu, Apr 17, 2025 at 9:05=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Wed, Apr 16, 2025 at 9:56=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Wed, Apr 16, 2025 at 7:09=E2=80=AFPM T.J. Mercier <tjmercier@google.=
com> wrote:
> > >
> > > On Wed, Apr 16, 2025 at 6:26=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> > [...]
> > > >
> > > > Here is another rookie question, it appears to me there is a file d=
escriptor
> > > > associated with each DMA buffer, can we achieve the same goal with
> > > > a task-file iterator?
> > >
> > > That would find almost all of them, but not the kernel-only
> > > allocations. (kernel_rss in the dmabuf_dump output I attached earlier=
.
> > > If there's a leak, it's likely to show up in kernel_rss because some
> > > driver forgot to release its reference(s).) Also wouldn't that be a
> > > ton more iterations since we'd have to visit every FD to find the
> > > small portion that are dmabufs? I'm not actually sure if buffers that
> > > have been mapped, and then have had their file descriptors closed
> > > would show up in task_struct->files; if not I think that would mean
> > > scanning both files and vmas for each task.
> >
> > I don't think scanning all FDs to find a small portion of specific FDs
> > is a real issue. We have a tool that scans all FDs in the system and
> > only dump data for perf_event FDs. I think it should be easy to
> > prototype a tool by scanning all files and all vmas. If that turns out
> > to be very slow, which I highly doubt will be, we can try other
> > approaches.
>
> But this will not find *all* the buffers, and that defeats the purpose
> of having the iterator.

Do you mean this approach cannot get kernel only allocations? If
that's the case, we probably do need a separate iterator. I am
interested in other folks thoughts on this.

> > OTOH, I am wondering whether we can build a more generic iterator
> > for a list of objects. Adding a iterator for each important kernel list=
s
> > seems not scalable in the long term.
>
> I think the wide variety of differences in locking for different
> objects would make this difficult to do in a generic way.

Agreed it is not easy to build a generic solution. But with the
help from BTF, we can probably build something that covers
a large number of use cases.

Thanks,
Song

