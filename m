Return-Path: <linux-kselftest+bounces-32796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BD3AB1F36
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE051C4509C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C15261399;
	Fri,  9 May 2025 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UE0E/qKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706122609D6
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827007; cv=none; b=reAyCR8M3kah4b8LJn+ikRSe6sgdFnWwRU+zVoW2WzDH5Z5nZGULwNWOb0QZneFOBPu0p0ud6hVOqpcyPNtsayol81SJlB08ks6mm80LW30M7RbzugEjHxmt3SxsWoRNImpCftro3LDWgSm46mBtNcTdJzu8sV1ZfYGS1YAcWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827007; c=relaxed/simple;
	bh=d+W04rz5R6BtxFOPPwdUXW9CdbhpNWKgPp4Gf6m8JPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqbqhAUi2aTZDL4G16ZApAphl1D+6udnRs9/LAg6kJ8qfeuMmCK2NJtVXXgt6K0zNeyOmuvIODiNhJQCb9CwpylQYyOFiETNXW+KfbbOeagWPuPd9ZFVTGyfCjwym7tjWHACcZnOpxFTfJhvjdySZc+d1TVeGqQv+2489LfhTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UE0E/qKC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe808908so19795e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 14:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746827002; x=1747431802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZfju7WUz5Yl04mbuyXvvdOSNmKPyLT8Rq8aUyjFmsM=;
        b=UE0E/qKC2d1CbG4lC0lb/YZTt3/K2oEwieIBCnjwzpeNHiYBX4yowJ6W+nd0RaFCCk
         GzinV0O66x2EICVt1D4esfk95yLyl3lHwE+4BozaqCD4gJ6KAkD1hcArn4SCGVSBt9HP
         6MEcQuHrkJXTtejStHOGJyvgnPzWDhap6Vjz+5ju6cGtRrv6TrEdOCSmNezN9+dd0LBD
         RNACVY68NkJ2qiLUt07pBEQsypRC7Knzgbyhnse/oy2gBiUYiWQ6WvuvkA5MtcyZVnaY
         STNichk+o4hvjKsMtBwNj06yFZgEzCk4JkD2huJRrm2a1DwQK5X7Yod0QFirDKppIVAC
         JggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746827002; x=1747431802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZfju7WUz5Yl04mbuyXvvdOSNmKPyLT8Rq8aUyjFmsM=;
        b=mIHLzKNOK1qeexXibHfv4wivXPv9uxUljikf+KZ+avUm7UXZH3ySu8DfmR8x3I0lEW
         ac8PWV012qYvSQMFtUwU/3lAWFbqJBXmK9LI3H8rnwANDKWnOroN8Elm8iCdyp7SJeMg
         Kj98xY6SgkQJhQQHxr8wnIdWkH1o2f3KqQUSIsRucAU6kA6xYiQIxkXcbWfIDAxVcPUz
         mCJGPX+Oxz/+OcUBbo/chQ0y8FhADe1yHo4yJiZwWe0h2ZM0n35oozRMjeyaEFymaOTw
         UmPfiSaXlv6oRHwsAp4SLA+Az0fApCs/zhHqcjQrBYxDkcnNVRGSXoiy9QeuUfXp600m
         Sa0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd4DQWoqlebLySvYjAr2OE5og3uj3szOwWRLmrDOwIMmJoVkjrKWY0BWePp3V7KrLBPMNICRB08VGtLQEOvsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJC0kwLiE5YJx9quaK4igWnSrWEIL6zO9IOYilq2VBQHsxoB7S
	Up1Qb/vIgmgvAhmO6d5FnfehZGgdyW0E/kHsbTmt21Yi5QlrAbXaTxQai07D/Q97pd3R7Ty8QG8
	VgGe0aqI+B5CNm5OoUid0blqojjx592BJwlt0
X-Gm-Gg: ASbGncuInsNuQw9lEOuKYL+esyl4WJ7/hseISL31bqs/ugWdgmtWI/VNbBsljBDmGvg
	lVafZ23gdy7maYnnvI+DwUirIpnqR2iKiLQ1dy7hKQg63ieGLjXD2dw40KmtRELysx0nmSE9qLo
	oapfQdp4Yxz7H/wDR56FF5vvRTk8F31Y4=
X-Google-Smtp-Source: AGHT+IEsv5HI2i1ZZ/585hqiXPrI+miXZcW/PcnQi9f4aA5/TPapqTvWiJ8fo1Pxmugr4vWjKMzxQzqUzh4HLjZ9xoE=
X-Received: by 2002:a05:600c:6058:b0:441:d438:1c1f with SMTP id
 5b1f17b1804b1-442e03adbdemr15755e9.7.1746827001461; Fri, 09 May 2025 14:43:21
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
 <20250508182025.2961555-6-tjmercier@google.com> <CAPhsuW5WOmyfPqBc_Hn7ApGWP_2uz_cJwyaDWF_VwiHJu9s_1A@mail.gmail.com>
In-Reply-To: <CAPhsuW5WOmyfPqBc_Hn7ApGWP_2uz_cJwyaDWF_VwiHJu9s_1A@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 9 May 2025 14:43:09 -0700
X-Gm-Features: AX0GCFvkQQHihmvnaG3BMibV3EQ_CyOSSZ1huizs69M9NO065M7pYtXEQ0sH-Zc
Message-ID: <CABdmKX2h5cGjNbJshGkQ+2XJ7eOnM+VfbmVr5Pj5c0qfxQA-qg@mail.gmail.com>
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

On Fri, May 9, 2025 at 11:46=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Thu, May 8, 2025 at 11:21=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > Use the same test buffers as the traditional iterator and a new BPF map
> > to verify the test buffers can be found with the open coded dmabuf
> > iterator.
>
> The way we split 4/5 and 5/5 makes the code tricker to follow. I guess
> the motivation is to back port default iter along to older kernels. But I
> think we can still make the code cleaner.
>
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> [...]
>
> >
> > -static int create_udmabuf(void)
> > +static int create_udmabuf(int map_fd)
> >  {
> >         struct udmabuf_create create;
> >         int dev_udmabuf;
> > +       bool f =3D false;
> >
> >         udmabuf_test_buffer_size =3D 10 * getpagesize();
> >
> > @@ -63,10 +64,10 @@ static int create_udmabuf(void)
> >         if (!ASSERT_OK(ioctl(udmabuf, DMA_BUF_SET_NAME_B, udmabuf_test_=
buffer_name), "name"))
> >                 return 1;
> >
> > -       return 0;
> > +       return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name, &f=
, BPF_ANY);
>
> We don't really need this bpf_map_update_elem() inside
> create_udmabuf(), right?
>
> >  }
> >
> > -static int create_sys_heap_dmabuf(void)
> > +static int create_sys_heap_dmabuf(int map_fd)
> >  {
> >         sysheap_test_buffer_size =3D 20 * getpagesize();
> >
> > @@ -77,6 +78,7 @@ static int create_sys_heap_dmabuf(void)
> >                 .heap_flags =3D 0,
> >         };
> >         int heap_fd, ret;
> > +       bool f =3D false;
> >
> >         if (!ASSERT_LE(sizeof(sysheap_test_buffer_name), DMA_BUF_NAME_L=
EN, "NAMETOOLONG"))
> >                 return 1;
> > @@ -95,18 +97,18 @@ static int create_sys_heap_dmabuf(void)
> >         if (!ASSERT_OK(ioctl(sysheap_dmabuf, DMA_BUF_SET_NAME_B, syshea=
p_test_buffer_name), "name"))
> >                 return 1;
> >
> > -       return 0;
> > +       return bpf_map_update_elem(map_fd, sysheap_test_buffer_name, &f=
, BPF_ANY);
>
> Same for this bpf_map_update_elem(), we can call this directly from
> create_test_buffers().
>
> >  }
> >
> > -static int create_test_buffers(void)
> > +static int create_test_buffers(int map_fd)
> >  {
> >         int ret;
> >
> > -       ret =3D create_udmabuf();
> > +       ret =3D create_udmabuf(map_fd);
> >         if (ret)
> >                 return ret;
> >
> > -       return create_sys_heap_dmabuf();
> > +       return create_sys_heap_dmabuf(map_fd);
>
> Personally, I would prefer we just merge all the logic of
> create_udmabuf() and create_sys_heap_dmabuf()
> into create_test_buffers().

That's a lot of different stuff to put in one place. How about
returning file descriptors from the buffer create functions while
having them clean up after themselves:

-static int memfd, udmabuf;
+static int udmabuf;
 static const char udmabuf_test_buffer_name[DMA_BUF_NAME_LEN] =3D
"udmabuf_test_buffer_for_iter";
 static size_t udmabuf_test_buffer_size;
 static int sysheap_dmabuf;
 static const char sysheap_test_buffer_name[DMA_BUF_NAME_LEN] =3D
"sysheap_test_buffer_for_iter";
 static size_t sysheap_test_buffer_size;

-static int create_udmabuf(int map_fd)
+static int create_udmabuf(void)
 {
        struct udmabuf_create create;
-       int dev_udmabuf;
-       bool f =3D false;
+       int dev_udmabuf, memfd, udmabuf;

        udmabuf_test_buffer_size =3D 10 * getpagesize();

        if (!ASSERT_LE(sizeof(udmabuf_test_buffer_name),
DMA_BUF_NAME_LEN, "NAMETOOLONG"))
-               return 1;
+               return -1;

        memfd =3D memfd_create("memfd_test", MFD_ALLOW_SEALING);
        if (!ASSERT_OK_FD(memfd, "memfd_create"))
-               return 1;
+               return -1;

        if (!ASSERT_OK(ftruncate(memfd, udmabuf_test_buffer_size), "ftrunca=
te"))
-               return 1;
+               goto close_memfd;

        if (!ASSERT_OK(fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK), "seal"))
-               return 1;
+               goto close_memfd;

        dev_udmabuf =3D open("/dev/udmabuf", O_RDONLY);
        if (!ASSERT_OK_FD(dev_udmabuf, "open udmabuf"))
-               return 1;
+               goto close_memfd;

        create.memfd =3D memfd;
        create.flags =3D UDMABUF_FLAGS_CLOEXEC;
@@ -59,15 +58,21 @@ static int create_udmabuf(int map_fd)
        udmabuf =3D ioctl(dev_udmabuf, UDMABUF_CREATE, &create);
        close(dev_udmabuf);
        if (!ASSERT_OK_FD(udmabuf, "udmabuf_create"))
-               return 1;
+               goto close_memfd;

        if (!ASSERT_OK(ioctl(udmabuf, DMA_BUF_SET_NAME_B,
udmabuf_test_buffer_name), "name"))
-               return 1;
+               goto close_udmabuf;
+
+       return udmabuf;

-       return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name,
&f, BPF_ANY);
+close_udmabuf:
+       close(udmabuf);
+close_memfd:
+       close(memfd);
+       return -1;
 }

-static int create_sys_heap_dmabuf(int map_fd)
+static int create_sys_heap_dmabuf(void)
 {
        sysheap_test_buffer_size =3D 20 * getpagesize();

@@ -78,43 +83,46 @@ static int create_sys_heap_dmabuf(int map_fd)
                .heap_flags =3D 0,
        };
        int heap_fd, ret;
-       bool f =3D false;

        if (!ASSERT_LE(sizeof(sysheap_test_buffer_name),
DMA_BUF_NAME_LEN, "NAMETOOLONG"))
-               return 1;
+               return -1;

        heap_fd =3D open("/dev/dma_heap/system", O_RDONLY);
        if (!ASSERT_OK_FD(heap_fd, "open dma heap"))
-               return 1;
+               return -1;

        ret =3D ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &data);
        close(heap_fd);
        if (!ASSERT_OK(ret, "syheap alloc"))
-               return 1;
+               return -1;

-       sysheap_dmabuf =3D data.fd;
+       if (!ASSERT_OK(ioctl(data.fd, DMA_BUF_SET_NAME_B,
sysheap_test_buffer_name), "name"))
+               goto close_sysheap_dmabuf;

-       if (!ASSERT_OK(ioctl(sysheap_dmabuf, DMA_BUF_SET_NAME_B,
sysheap_test_buffer_name), "name"))
-               return 1;
+       return data.fd;

-       return bpf_map_update_elem(map_fd, sysheap_test_buffer_name,
&f, BPF_ANY);
+close_sysheap_dmabuf:
+       close(data.fd);
+       return -1;
 }

 static int create_test_buffers(int map_fd)
 {
-       int ret;
+       bool f =3D false;
+
+       udmabuf =3D create_udmabuf();
+       sysheap_dmabuf =3D create_sys_heap_dmabuf();

-       ret =3D create_udmabuf(map_fd);
-       if (ret)
-               return ret;
+       if (udmabuf < 0 || sysheap_dmabuf < 0)
+               return -1;

-       return create_sys_heap_dmabuf(map_fd);
+       return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name,
&f, BPF_ANY) ||
+              bpf_map_update_elem(map_fd, sysheap_test_buffer_name,
&f, BPF_ANY);
 }

 static void destroy_test_buffers(void)
 {
        close(udmabuf);
-       close(memfd);
        close(sysheap_dmabuf);
 }

