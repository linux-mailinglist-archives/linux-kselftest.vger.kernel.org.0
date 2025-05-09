Return-Path: <linux-kselftest+bounces-32807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFC1AB1FE2
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 00:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18384C81F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB7262D14;
	Fri,  9 May 2025 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2fo7f9s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D6261399
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746829693; cv=none; b=t1eGbNUHKyvYARamTmvWe88lIm/QFCWUdo+w7baoolFhNpPRSPDqRfyEMXuKX4soNwrpzfrwSGOSLFRQyNSynuDiTjjJEp7x06nFdbHyRxtnj6D2rpyViwG76mgLkU5TchNpF53hmFB+qTSqNsr/mtPOeNrpWsgwX7/UTDINnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746829693; c=relaxed/simple;
	bh=/uoIf7h2FBNHtiJVcUKYQNAOOyaMJSSF/8uZrYPjr3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CS32Ry0Wn6/ZooDmQgy3NlVHoeDxB+ysVtYN0dtsowONZD+mr3Tdlx1IqK7cNyL+Pz35o6hlNlc7O7wHfUSOf1ZrG+GsPTajW//2rIUnwkcG2k5o1t7u4+/OYKYBG6v91tD9D6imgB6czNv3YX78ypec1rdQa0jgdsx/jwgeHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2fo7f9s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso8435e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746829689; x=1747434489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Dwe+AkRWKyTQFcGk+FB1loDELsepTcogcqqbMFr0lI=;
        b=Y2fo7f9sXyzZcOiTBtCUATTMet+AKI+p++Wesl5zM/rX8H1MDdC5lSvGXM0wGyOO5l
         1t2EIitltY42VpqrUOJiFCqohgk4MVUdaI3HmYWVe/2bdwz+R2gkPNbC6OsqpFMxYGpL
         28Va8rHk/2LsFKB20z2OaHOX5FlMyvXN8U9/jrZRnzINTkHjuYRHAhcdHz5cl+ToMpWj
         hfyTBLudEmbkJZ3LMilecHwhKvH/MbrEVrXxOzhpM91rbYcMZn9yzwpjJnph3p3Ey3Df
         rnAZVn07b1eeywIntxMEZFdfYI8W31TjIFUzqjJO3QcKbaG02k6jeLy/CAr9brbppSYp
         4Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746829689; x=1747434489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Dwe+AkRWKyTQFcGk+FB1loDELsepTcogcqqbMFr0lI=;
        b=oFzMJ4Fd/thvobACoDorJ4Mlu7m762p0C5YAMIEUYLx94Gam+XpV56TnoxDzqLtxHU
         c5pIDHDlAseOow1+6xyawCt5B6VYoVs+DED18Ufi2R1gGkE9FGjGqtWMUYQaXz3BDSfI
         ylgGzc+DCZHYsBSTahqeTuf/Yus3X9FgTRXcBow7cFx6Bqja2iYf5BWY+aHVHp7fyZiI
         ubhPD3GqEu1HEdXumyto/uY6k8tfWkiF6x1xzlqfEXmsmOhiAeCJ6yQr7eQBeHhKn98e
         WxKZ5hy4P0tn/fLFc+AgiPBDE9ja/ifeUlt0RpYEhnwzwQDCNzNpBdYXgJRRKQIrl9mL
         iZIg==
X-Forwarded-Encrypted: i=1; AJvYcCU/2ucyBSrxRz4kNQZkRIlF2RZbkf0FHkmILSaL0Nc41WwXHGn4RM1oShxWTnmaKb8+pLpvBjXerB+dEW84yXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyusoTioZU01WMBH7Fsn+Fhm8zWEx+Uk8qPn9+5fvAouRRQcCRr
	5nBXYu32Q/NwOvL+AhupL2URPUEjrSLpQ2a+fPBuEoVVzPJvN+/RLZM4U+buy3hIDeYzLBOvCW7
	SG/I9F21dDLQCm5MyTSFEiGVZL6Sa8ZVBwCKC
X-Gm-Gg: ASbGncuNoIXevOnsffUQW+G76LJOFtLyVbc3LVV/CPJX3zjDRNEg6lBt6RUqqbfRYrI
	EbJsuj8mHe6rsgq6qQMMqPDaj+De3HTfguSS4Vb6PcMHlm9kH7Iuxl07ghkz7RDKlpukpT8eGjP
	ECyCmf0jjcTXg74Z0/Dreamk7Rvg1KsPc=
X-Google-Smtp-Source: AGHT+IGvqHCr2YbTyc+Q5mGzfoBCTKlc5wlIEM2vVFXqFenxVP+WaJU85XX6Sq5GSXEM+agSTCbYVlJfJ7nbfIdFhI8=
X-Received: by 2002:a05:600c:5009:b0:43d:5b3a:18cc with SMTP id
 5b1f17b1804b1-442de0efd25mr426825e9.2.1746829689429; Fri, 09 May 2025
 15:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
 <20250508182025.2961555-6-tjmercier@google.com> <CAPhsuW5WOmyfPqBc_Hn7ApGWP_2uz_cJwyaDWF_VwiHJu9s_1A@mail.gmail.com>
 <CABdmKX2h5cGjNbJshGkQ+2XJ7eOnM+VfbmVr5Pj5c0qfxQA-qg@mail.gmail.com> <CAPhsuW7BM=X06Tr+HURsCbD8LwAO=Fdu+ZfKDy6RNK=UNNC1Rg@mail.gmail.com>
In-Reply-To: <CAPhsuW7BM=X06Tr+HURsCbD8LwAO=Fdu+ZfKDy6RNK=UNNC1Rg@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 9 May 2025 15:27:54 -0700
X-Gm-Features: AX0GCFuz9iFkCIfsshnA0MUw61-2gqEtE-ai4BVujTpqsH3eB8SQA_jIOEXe8bw
Message-ID: <CABdmKX3LMJLTZN8-x8jFAM8p58pg-6P5-B=mHBf98_uAVtxxwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/5] selftests/bpf: Add test for open coded dmabuf_iter
To: Song Liu <song@kernel.org>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:58=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, May 9, 2025 at 2:43=E2=80=AFPM T.J. Mercier <tjmercier@google.com=
> wrote:
> >
> [...]
> > >
> > > Personally, I would prefer we just merge all the logic of
> > > create_udmabuf() and create_sys_heap_dmabuf()
> > > into create_test_buffers().
> >
> > That's a lot of different stuff to put in one place. How about
> > returning file descriptors from the buffer create functions while
> > having them clean up after themselves:
>
> I do like this version better. Some nitpicks though.
>
> >
> > -static int memfd, udmabuf;
> > +static int udmabuf;
>
> About this, and ...
>
> >  static const char udmabuf_test_buffer_name[DMA_BUF_NAME_LEN] =3D
> > "udmabuf_test_buffer_for_iter";
> >  static size_t udmabuf_test_buffer_size;
> >  static int sysheap_dmabuf;
> >  static const char sysheap_test_buffer_name[DMA_BUF_NAME_LEN] =3D
> > "sysheap_test_buffer_for_iter";
> >  static size_t sysheap_test_buffer_size;
> >
> > -static int create_udmabuf(int map_fd)
> > +static int create_udmabuf(void)
> >  {
> >         struct udmabuf_create create;
> > -       int dev_udmabuf;
> > -       bool f =3D false;
> > +       int dev_udmabuf, memfd, udmabuf;
> .. here.
>
> It is not ideal to have a global udmabuf and a local udmabuf.
> If we want the global version, let's rename the local one.

Ok let me change up the name of the aliasing variable to local_udmabuf.

> [...]
>
> >
> >  static int create_test_buffers(int map_fd)
> >  {
> > -       int ret;
> > +       bool f =3D false;
> > +
> > +       udmabuf =3D create_udmabuf();
> > +       sysheap_dmabuf =3D create_sys_heap_dmabuf();
> >
> > -       ret =3D create_udmabuf(map_fd);
> > -       if (ret)
> > -               return ret;
> > +       if (udmabuf < 0 || sysheap_dmabuf < 0)
> > +               return -1;
>
> We also need destroy_test_buffers() on the error path here,
> or at the caller.

The caller does currently check to decide if it should bother running
the tests or not, and calls destroy_test_buffers() if not.

> > -       return create_sys_heap_dmabuf(map_fd);
> > +       return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name,
> > &f, BPF_ANY) ||
> > +              bpf_map_update_elem(map_fd, sysheap_test_buffer_name,
> > &f, BPF_ANY);
> >  }
> >
> >  static void destroy_test_buffers(void)
> >  {
> >         close(udmabuf);
> > -       close(memfd);
> >         close(sysheap_dmabuf);
>
> For the two global fds, let's reset them to -1 right after close().
>
> Thanks,
> Song

Will do, thanks.

