Return-Path: <linux-kselftest+bounces-31273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E154A959D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 01:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675101896B71
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212D225A39;
	Mon, 21 Apr 2025 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z164GCh4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745E1E5209;
	Mon, 21 Apr 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745278757; cv=none; b=b237X+QZtUIATsHENH+KEAM9qxxG0/26nG83/+7i3CXPMPpKqMcQi2jRaaVVd8qG4OT0TzWg9F6PC/bsH94HKHLyLxwyTa6Atsl6ouQj3EukbftE/GQFt4H2xNALCMdzMLo4X2wLWZqPam0wIHLfKt1KhTUqgKF0lvqT/rEe/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745278757; c=relaxed/simple;
	bh=OLQyzlmtzCKjMQFUfXFaxjQdUeb3bxIoaWmWJX2UWp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ucw0w/f5SOL7wXsMrq1RKF5Tkl7Ep9SbGLd6qHhADaYKP4YSkIwkI0wh+BxSUGukg9DICAc8997IUj8R+AmnHEGGW3qozEaN5iev/JiALYAqCkL7H3tRiIYgA4el++MHZb4EvTJCM8s+B8kE29nmFYqAFEDH4qS3lLQa+shoDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z164GCh4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so3091791f8f.3;
        Mon, 21 Apr 2025 16:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745278751; x=1745883551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOyh0KRZOP78elpx9kgGmLRnKlT+oLZaZTHETWW34WA=;
        b=Z164GCh4row5O7PhSduGeHT9qrokg+pXkELoC1YEG/3vYNwZPbhbdMA+OPj9tSXMGF
         odRljqPizs/rshVdKeQHTocHVfOBsuyTIQ0fZq2RoZfAIbE9+SI35WPCcBwhDu/JFOPt
         OQlJ4iwXUL16bE0pmumj4tzqSNVHU7d/z5MFec+mGa4xLjLe/hqFfkfzfq53lqkJKKTH
         /bA6tLx10o6qcXYCFHWjkyS5nCysUiTztFSxRvhB+DA5HCaNUkMt55H28bs3EZnJG1xV
         YJSlsZuEZ0pJzJzONyn+SDAeV5cD8jnd2xhgHGAZWGJJfzseiCyxkeMISYxasPM5kQN7
         PXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745278751; x=1745883551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOyh0KRZOP78elpx9kgGmLRnKlT+oLZaZTHETWW34WA=;
        b=g2giNYnSySrA1/WedG7O6nBmStLRfEvmUa1TJV+IvDhni/akvNxJSAuyAtFx1xcLOz
         zcm4u2sgJlRSysGrrlclnic2fglG7nrQBf9496Bzx4XbNlZwFdUdygOzEsVbQE7+Jfg5
         PjQWSFFsm0++Itl6oFQleJpxCsVZ8g8NC1buhOYBYEq8woOF5Yc5syulcx6fDEdZwzvA
         DVJBjgJ2APkn6CxbAYIwo01wjMMxzcC0xqzn9VckwF+zEFvH0tKHDHUNEwIVFan+cKRD
         O71ghqJqjr1JIGvHyFUZD5JWH0nxPtD17K2y82ObjS4SVdOIUAP8ABq5jVP5yJUJ/F7O
         VtTA==
X-Forwarded-Encrypted: i=1; AJvYcCUSVU+QnjFBxTzSSWd5Y4CfWZXBIDzVK6zt2GByKJZ/G+fpWToSrGZJX6jYbdWaxd4xa+OcUmrCFy4oxz8=@vger.kernel.org, AJvYcCUenX2PQFbSb5lvPMskargdf6fsfMSqCzui+SvHZwD1l9YSZAexWL02C7a7Ze1iGm3Ukyo3wDyYdSXWxhexW+N+@vger.kernel.org, AJvYcCUnMMLevFd5tg9rS0LxkK9NCRFQ4qzr8zJHX9Yp3Ki/9khfnlrPLWbfQD6tAQOq7vriUdFGkcmaTisj@vger.kernel.org, AJvYcCVA6BJBRhw8CSJheDnxG35WxvWn2SDPVoktK5bV7NG7zmNC8iUlSsT6pMYG+n9UkCdFbCE=@vger.kernel.org, AJvYcCW0OdNHyx6R2KUQJwFcIOY9MlKABDZYKfHo7KSISMO7KB1Go9sC2PPv0XYcsIRUsDSeqH0XAepZJPmzsjy6@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7Wu0uoci+T8W/ReZ+0KX2gRjjhOIHzD4eAdbDzSC1jJrE93W
	J1XPprgV1GqRYpSzXV/gHr99aUOgkmf8DNb03gwvvLI0faPSfV+FAHeDTJ29zZ0uX8MB2qRMfX0
	H4cPkaF77JReyBbRMDDM+YVcDuMo=
X-Gm-Gg: ASbGncvT70+0m+P7B+aKtGxltFAckkWoMTgJm/DwRmqzcG5UwNj72+8uFU6GUjmFPwt
	DBxzB1EvUP5xepRTtoz4f4MBFz52H9ctxAWQ7kklZ7p/i/1xfXwamcw3RxRgagF0Q+rff
X-Google-Smtp-Source: AGHT+IH0SrvREf3muergkKdQkak0YZ+ohqfk7d6fakRaBVQUXizurH1NfGeAwSFOPUHkhRWTHwrrpnJQpvzHziO1Ss0=
X-Received: by 2002:a05:6000:2510:b0:39c:30f9:339c with SMTP id
 ffacd0b85a97d-39efba5a84dmr10142882f8f.28.1745278750922; Mon, 21 Apr 2025
 16:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW54g5YCmLVX=cc3m2nfQTZrMH+6ZMBgouEMMfqcccOtww@mail.gmail.com>
 <CABdmKX1OqLLsY5+LSMU-c=DDUxTFaivNcyXG3ntD8D0ty1Pwig@mail.gmail.com>
In-Reply-To: <CABdmKX1OqLLsY5+LSMU-c=DDUxTFaivNcyXG3ntD8D0ty1Pwig@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Apr 2025 16:38:59 -0700
X-Gm-Features: ATxdqUEjOlk2AFAGVhVlgaGgehsi4nkoJpm1iJUvAg9lN7-7SyoelglTBprP5Ug
Message-ID: <CAADnVQ+0PXgm_VuSJDKwr9iomxFLuG-=Chi2Ya3k0YPnKaex_w@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Song Liu <song@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, android-mm@google.com, simona@ffwll.ch, 
	Jonathan Corbet <corbet@lwn.net>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 1:40=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> > > new file mode 100644
> > > index 000000000000..b4b8be1d6aa4
> > > --- /dev/null
> > > +++ b/kernel/bpf/dmabuf_iter.c
> >
> > Maybe we should add this file to drivers/dma-buf. I would like to
> > hear other folks thoughts on this.
>
> This is fine with me, and would save us the extra
> CONFIG_DMA_SHARED_BUFFER check that's currently needed in
> kernel/bpf/Makefile but would require checking CONFIG_BPF instead.
> Sumit / Christian any objections to moving the dmabuf bpf iterator
> implementation into drivers/dma-buf?

The driver directory would need to 'depends on BPF_SYSCALL'.
Are you sure you want this?
imo kernel/bpf/ is fine for this.

You also probably want
.feature                =3D BPF_ITER_RESCHED
in bpf_dmabuf_reg_info.

Also have you considered open coded iterator for dmabufs?
Would it help with the interface to user space?

