Return-Path: <linux-kselftest+bounces-32805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82878AB1F76
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399F4A22D5E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42562609EB;
	Fri,  9 May 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj/Ji3eS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13A25D1FC;
	Fri,  9 May 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827935; cv=none; b=P7CNXpS8DFzGJ+gDy3ooI2HDKVaMDnmrFsfRe/sBGlRv/4DUyRiKv2YuR5TiqjeHzLPs5aPiRt7LYRqK3ybFRnbJtNlG6i0A1VyFKfPKzX2BydZPQRzcyXLwOKR5hPyo+TpKTd1BU6rnBKBtRyIIuAiuTHruwFHeGlHyT1LmcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827935; c=relaxed/simple;
	bh=bod7OgH9FMLNk7FKdLh8z63aV2T+h8TH6ReCA7jp2gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nT1nuZqvHX1aDgo1g+u7tnHQDC/bZuE3ObN/LGk5AV6V4WAIR++jwPqKnhYpqv+IYW5wONUCFoHW9GAr748wC/unRJ2RfwgxEw4Je4tPJerSUt0vovfxd4eMqdTAndJnHuNTOoUOXDYff1ci+4RdcH6w4B49D6kNYKVo9e714Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj/Ji3eS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E579DC4CEF0;
	Fri,  9 May 2025 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746827934;
	bh=bod7OgH9FMLNk7FKdLh8z63aV2T+h8TH6ReCA7jp2gc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wj/Ji3eSP+f9K5/OX8IPyTGVC+hKeww3Yl6QUod6tkbAtAu7U0Wz1PbqtNRVOjwFv
	 9ihr6xIkNld8R2eg3D/qwKFTzKCB44sM/wo7FZxVdNmFG35vJbswp9WpRB4g9YpQkp
	 559m5BktWJFZGo4x7zXB4pbEKV/NEhnPJI2p03xGmYJoo/0q9PeX5NKUMQ1D2NrYUd
	 hD6VA7olwNYII6sChdMP9QvKoVAyyCPZlZ+LN+HGDbh/0tPkMmT8IK/5JM1F/UfEWO
	 vBcf7l+pLMpJuVSflbkhtlCrXN+JM03dQsJTV8H4aaugOqzs+a7UvfS5j8IFoiCTa6
	 oIMMaIkNxRk+A==
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47692b9d059so41514821cf.3;
        Fri, 09 May 2025 14:58:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURDqUH2FtghFfzt3Rf2haB8dz/ZkaS7o1n5bdVx0yGpclf1/jqPgpQYiaiF4wODoS35Q1SCjJV6/a5sdo=@vger.kernel.org, AJvYcCVBpAKD4MoCFRAuOJ8H9Rqi+i7aQHs4hZIzUxJUgPC91+FuFM+ut+VpHw4wrvqHJsP7C4nUkulCiz0wEJXL@vger.kernel.org, AJvYcCVQE25E9K26TKlT2F7rSuTv4qvp/ruijmamJXipLRlJYWt8zIBYTiybocGSWUfVDhX14ag=@vger.kernel.org, AJvYcCXxOgSPrlrOfxuKxLjg6YU3PrRDq/1+QbaNAHHY0BQ02oysOrjoKLhk9Fm5bvB97ovhrJFF2uvqoo0phH8ni8nd@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMwpQJzUVa+8JfjRvbx3oA+oRMmLf8F2xZKjhiXFWMmj+Ekn8
	1AzZdS6gt8U0mIVm3pGflVjdqhw/vwDTDhxP9ix4tXaqWOJTCXNFuakiFsNAVLF2BlkADzhrV2L
	OaflshGsQo1qxBXzXslo9FLuxrgM=
X-Google-Smtp-Source: AGHT+IEgw/OIWDWXmJWHEkTR/5DcaJ04lcLlTsKykO84AozF3RympSmmA4dzDH25HCRL4W/HlqroK6FilrCD1i+wCWA=
X-Received: by 2002:ad4:5cc7:0:b0:6d4:238e:35b0 with SMTP id
 6a1803df08f44-6f6e47bd8a3mr77458376d6.17.1746827933963; Fri, 09 May 2025
 14:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
 <20250508182025.2961555-6-tjmercier@google.com> <CAPhsuW5WOmyfPqBc_Hn7ApGWP_2uz_cJwyaDWF_VwiHJu9s_1A@mail.gmail.com>
 <CABdmKX2h5cGjNbJshGkQ+2XJ7eOnM+VfbmVr5Pj5c0qfxQA-qg@mail.gmail.com>
In-Reply-To: <CABdmKX2h5cGjNbJshGkQ+2XJ7eOnM+VfbmVr5Pj5c0qfxQA-qg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 9 May 2025 14:58:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7BM=X06Tr+HURsCbD8LwAO=Fdu+ZfKDy6RNK=UNNC1Rg@mail.gmail.com>
X-Gm-Features: ATxdqUHtjHO0cnNYi6P788wo4nENW6QfEqucHX0SCFZlWpdcEK8f_Ki_Hjh7ovQ
Message-ID: <CAPhsuW7BM=X06Tr+HURsCbD8LwAO=Fdu+ZfKDy6RNK=UNNC1Rg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/5] selftests/bpf: Add test for open coded dmabuf_iter
To: "T.J. Mercier" <tjmercier@google.com>
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

On Fri, May 9, 2025 at 2:43=E2=80=AFPM T.J. Mercier <tjmercier@google.com> =
wrote:
>
[...]
> >
> > Personally, I would prefer we just merge all the logic of
> > create_udmabuf() and create_sys_heap_dmabuf()
> > into create_test_buffers().
>
> That's a lot of different stuff to put in one place. How about
> returning file descriptors from the buffer create functions while
> having them clean up after themselves:

I do like this version better. Some nitpicks though.

>
> -static int memfd, udmabuf;
> +static int udmabuf;

About this, and ...

>  static const char udmabuf_test_buffer_name[DMA_BUF_NAME_LEN] =3D
> "udmabuf_test_buffer_for_iter";
>  static size_t udmabuf_test_buffer_size;
>  static int sysheap_dmabuf;
>  static const char sysheap_test_buffer_name[DMA_BUF_NAME_LEN] =3D
> "sysheap_test_buffer_for_iter";
>  static size_t sysheap_test_buffer_size;
>
> -static int create_udmabuf(int map_fd)
> +static int create_udmabuf(void)
>  {
>         struct udmabuf_create create;
> -       int dev_udmabuf;
> -       bool f =3D false;
> +       int dev_udmabuf, memfd, udmabuf;
.. here.

It is not ideal to have a global udmabuf and a local udmabuf.
If we want the global version, let's rename the local one.

[...]

>
>  static int create_test_buffers(int map_fd)
>  {
> -       int ret;
> +       bool f =3D false;
> +
> +       udmabuf =3D create_udmabuf();
> +       sysheap_dmabuf =3D create_sys_heap_dmabuf();
>
> -       ret =3D create_udmabuf(map_fd);
> -       if (ret)
> -               return ret;
> +       if (udmabuf < 0 || sysheap_dmabuf < 0)
> +               return -1;

We also need destroy_test_buffers() on the error path here,
or at the caller.

>
> -       return create_sys_heap_dmabuf(map_fd);
> +       return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name,
> &f, BPF_ANY) ||
> +              bpf_map_update_elem(map_fd, sysheap_test_buffer_name,
> &f, BPF_ANY);
>  }
>
>  static void destroy_test_buffers(void)
>  {
>         close(udmabuf);
> -       close(memfd);
>         close(sysheap_dmabuf);

For the two global fds, let's reset them to -1 right after close().

Thanks,
Song

