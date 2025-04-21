Return-Path: <linux-kselftest+bounces-31266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10548A955B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4529616732B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7CE1E7C18;
	Mon, 21 Apr 2025 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppk17UCN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8C1DFFD;
	Mon, 21 Apr 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259191; cv=none; b=az9zkx1JRsg73r+9J8tK+PlABIgz+av1yGgsnDd88gQWu8xsQiQO+2umErngkSBdH/BTWp5vP6SatZmW6VU10bqvWNndU0SNnCrWknKnDkSE4S2YGJmxDUdoLghlVl1P2kwYMszuTdvueYXuq4ryp8tvbnPw8PYjxkfbSi7mueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259191; c=relaxed/simple;
	bh=UqEEYmm2ZXFfWchDWvLB7F32I6SFMlaqs6jCp43ewCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSoRjMIJjNMue2L2tGOrg7zocPDVTer6jlV0lsO+zaTgSRul+k1Tvh2z+aYjMEjK/wE7teeY/a601PrReU1vyfibQJERod3KEGMSxNFruBsVKy+h9WaakxT/itydnmRumY0EY3gyeU759uiWQH8/6fyJw2blpI/bn958h4rNhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppk17UCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A2EC4CEF1;
	Mon, 21 Apr 2025 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745259189;
	bh=UqEEYmm2ZXFfWchDWvLB7F32I6SFMlaqs6jCp43ewCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ppk17UCNl+NWNPGpHARWMjemyWbSH9b7F3SpbJpbNRAIL/eZQhz2jUdaPGWOORfuX
	 BF7liSOnHOAHTxlK6/w/iDPm6+Cb67yZSeg+++/vbkoOK/ZWAn9z1vWGyR9VxjwGth
	 yR3+JakJ1x9Ak1YIb1gXzIwBvxBDo4KqrXwyPs2OwSOio+DAANzjk03OxR9PZ7Y9e7
	 rUEhmkIIMke6QRiobyTnI3uvZtFv8CDQHkwraVG5dX4NHc4v3GnttzfOP6M15nF670
	 hkkpy1Tj/Db/7dvKTEeRC++AL8m5ePdBYDBIwOoofAOJyw+4tzeHyOA41ikITFdowY
	 ZRf55xE3tOf9w==
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47677b77725so47775351cf.3;
        Mon, 21 Apr 2025 11:13:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI/d19xTnu3XlSQ4ppOSa02SFh1CVgK/N7KZ3Ds9FXhLXg3pGiJLXE2c5DUHQfHXZFVJ8=@vger.kernel.org, AJvYcCWF5n3wAR75cyuXBXQsA1S+ET2bbJ2SzP22pClh9n6Ir4SoENpcYDXGZV+QH8XIGsc69S5h8W1MoyqTOUAc7gn8@vger.kernel.org, AJvYcCWbWfD3fsnyaVeM1iUAm7WgjDGoFAFZGGj100khd0PHz6O0O86eDwoOJSZjDjVR/uhvDmEQm3ouQl8U@vger.kernel.org, AJvYcCWxAWg4CmlLQOshBDgfsRZDRZQVjVVPyPoAxKNXuzkRn2tc6cGAwW/8d0ojhBZFQRHwFVNQTHLj+tnaaYFt@vger.kernel.org, AJvYcCXw6+6hMB0EMf5Ft70e3G8L6Cg0EEbNLUX83FooMyONul2oKQ7nerLOO1Ad7rtdtWeBJ2S7EBVduwqsHPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTB6/r+6VMy56LY67l4lwAjOfUx86VViCS4S+6Fh+ZKD4PXRn1
	BbEY6+z9Dl0XCKHTylN/nw4/0EDTJ60R8ki+22ms1t+Kz0yt+rv6qO4OAJklSJypfsUxTUbldmv
	t85Fj1UOGqfpoW4FTEo3BnckB10w=
X-Google-Smtp-Source: AGHT+IEMoK6z85Hs/F8U6UU20wgjMdYOaIFxg+BBuF5nUJtPL8v5TWwEUaRQNjNwFFSXKecYeXKtzNZd4CPhFPCMLAU=
X-Received: by 2002:ac8:59cf:0:b0:476:a03b:96ec with SMTP id
 d75a77b69052e-47aec492c20mr236803811cf.32.1745259188284; Mon, 21 Apr 2025
 11:13:08 -0700 (PDT)
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
 <CABdmKX0P1tpa-jxzN1_TCyk6Cw6drYM+KRZQ5YQcjNOBFtOFJw@mail.gmail.com>
 <CAPhsuW5bgBNu6zY0rn7ZH4VK54nruryU4bS4LrDDsxnCfqQicQ@mail.gmail.com> <CABdmKX3XaVFJEQRav1COi7_1rkMsx1ZhrJoGLB_wtywZ0O-jug@mail.gmail.com>
In-Reply-To: <CABdmKX3XaVFJEQRav1COi7_1rkMsx1ZhrJoGLB_wtywZ0O-jug@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 21 Apr 2025 11:12:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7G+Y3DcpN+N7c4wUuSGoq-DaUmLTAy87xAKWK=ZAZ+Dg@mail.gmail.com>
X-Gm-Features: ATxdqUGaR_CqVYxjaESNT2qiEdWLdHIia7pDWLQYNSOmKVvfaPSPNPMNDOlcZB4
Message-ID: <CAPhsuW7G+Y3DcpN+N7c4wUuSGoq-DaUmLTAy87xAKWK=ZAZ+Dg@mail.gmail.com>
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

On Fri, Apr 18, 2025 at 8:25=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Thu, Apr 17, 2025 at 1:26=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Apr 17, 2025 at 9:05=E2=80=AFAM T.J. Mercier <tjmercier@google.=
com> wrote:
> > >
> > > On Wed, Apr 16, 2025 at 9:56=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> > > >
> > > > On Wed, Apr 16, 2025 at 7:09=E2=80=AFPM T.J. Mercier <tjmercier@goo=
gle.com> wrote:
> > > > >
> > > > > On Wed, Apr 16, 2025 at 6:26=E2=80=AFPM Song Liu <song@kernel.org=
> wrote:
> > > > [...]
> > > > > >
> > > > > > Here is another rookie question, it appears to me there is a fi=
le descriptor
> > > > > > associated with each DMA buffer, can we achieve the same goal w=
ith
> > > > > > a task-file iterator?
> > > > >
> > > > > That would find almost all of them, but not the kernel-only
> > > > > allocations. (kernel_rss in the dmabuf_dump output I attached ear=
lier.
> > > > > If there's a leak, it's likely to show up in kernel_rss because s=
ome
> > > > > driver forgot to release its reference(s).) Also wouldn't that be=
 a
> > > > > ton more iterations since we'd have to visit every FD to find the
> > > > > small portion that are dmabufs? I'm not actually sure if buffers =
that
> > > > > have been mapped, and then have had their file descriptors closed
> > > > > would show up in task_struct->files; if not I think that would me=
an
> > > > > scanning both files and vmas for each task.
> > > >
> > > > I don't think scanning all FDs to find a small portion of specific =
FDs
> > > > is a real issue. We have a tool that scans all FDs in the system an=
d
> > > > only dump data for perf_event FDs. I think it should be easy to
> > > > prototype a tool by scanning all files and all vmas. If that turns =
out
> > > > to be very slow, which I highly doubt will be, we can try other
> > > > approaches.
> > >
> > > But this will not find *all* the buffers, and that defeats the purpos=
e
> > > of having the iterator.
> >
> > Do you mean this approach cannot get kernel only allocations? If
> > that's the case, we probably do need a separate iterator. I am
> > interested in other folks thoughts on this.
>
> Correct.

I read more into the code, and realized that udmabuf fd is not for
the same file here. I guess this also justifies a separate iterator.

Thanks,
Song

