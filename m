Return-Path: <linux-kselftest+bounces-32877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BC1AB45F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 23:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68A919E8244
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4E299A9C;
	Mon, 12 May 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07V5YZ6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E995298273
	for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083893; cv=none; b=iezZ/LEEIBc3gohUCYsIi8DNUYI/gfUpSoH7E1EyKYqdsclv1QzzY8pZLRScqGkCAuOcvWhaeTHYvTzsGBlic3Oiitfum6HFz5kJBUspqkEUf8WLcXCT+4Vcibws7yTCCdX3IyqFOqUvXR7p3kE5Eg0Ab3+bdN5exeybc7CFRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083893; c=relaxed/simple;
	bh=Fa5oXFBgKaZ6VyL327hvSH4F43ImIjpa6dE33ADenfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNiaaS1iQVHKQg4B/5bOHcscLb8KkD3FnVrLtpjXFclrbwRLmkpCvYwawgkXO4ro+Tzt45TZ7MFjN5yk1Ralh5EZI5js/ekfT10qP9WicKsTqmoKjnpCApL1S1rANWQy3kqPhUz5BER9+0LwoEJlgFZVKAeFrdXbqQYDnNbaxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07V5YZ6y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso6165e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747083889; x=1747688689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocHMf+lpxFiUglMvQ3QmzmSqN/TDDldlcwv8ib7D0M4=;
        b=07V5YZ6yB1EFOAkq9FTUQGeOSW8giYiLbHWAitYHwJ0W0M5K3RH0RwhZJ83AGtSlEq
         38VkEfKhPfH/7AKmp13wbApNJiJQNAr6xlcX2zRPKGHOv553n9wgroiqm6T5f92NCQLL
         kSepEQ91Ft8oy9ZqwSLNlDQcn+4hK9TKrKHs2fJj/r1gL4sqXCoRKAKOEFhh03ld9v4W
         t5iwbxxD0xBH80xP9iWsNJyLXU9zvAz9Qs5L0KKRTt3koulxVg+0h5me20JLldjNmXkW
         KXZCXHCDLrph9jqUXNZH6B5xDpvq9Gz8+W7xtTsH+Fy/SLz/U9OTVB1xzCZWU52Oyb+c
         NHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747083889; x=1747688689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocHMf+lpxFiUglMvQ3QmzmSqN/TDDldlcwv8ib7D0M4=;
        b=mJcGxwxTH4tnxUtTaqV7DGM6rtcGQWjJ+20SHPaFJESz967MFCiI6JFqjkAZFtsN1y
         yzFN2DwFNTgoEnJTk+qmqr96qiQVIFcoCPZ6nOlkpE9qKlLprieFyKib+XNRKNIWB3bd
         Z0V/KD6jRFB2qN/4vWwJwi3pPuoDT1T6xuTOp40w6eK1tBGNbBU1LXZu3BcfoxgDYmF1
         iPFOJPg58Ka+p2z6aYjJUqYmFyxuMUuXr5fAUOFAHA8kRktW011z7BvAqK4F6d/YCVQl
         WUzTdW6sywzYc2hJXZSTduRrZ4dhq1PDX77q0AAQcjFyFS107IV/3I+egKoAofGnTxxL
         PfnA==
X-Forwarded-Encrypted: i=1; AJvYcCXECYinUzBjN1ia8n1U5GEZgy3hr4LdS1QW6M/2bx1fiKEF94sFR6dBRlhp0IdwcbLkdQBo9x+29EDuUSztVmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfK5nEJ4hc/gqoqsPv1DGeRzf7vfrRqQGVmTKoFHDVjRuKfx7
	1HCM4Hxobm6kkonbA7wmDVslYcip9deCsb4lh3eb1OF3Z3Jq+r/gkqKsntTp1QbbiLKF1C1EYTU
	Zo5xmPxhrl0n8m89GBgYq/n2L6bpBFeiBNL/z+Zk/
X-Gm-Gg: ASbGncv1+5Y2i7RGBvV/Qv1bsvztaxcHn74upFwW4mtadNXBqWPDM+TIq1l7eqgSh46
	l7MuRe1O1/YeEvdgra+dGrvmmXDaAY7xHN8c4UdFg9kGIPG3ScXjNgzSbd9f5N0VwuB9dOYPVQ+
	wX2NUrATYICiN+1okXn5fS0kNU23Ex85w=
X-Google-Smtp-Source: AGHT+IEr0EA2T8//ChQD2cQVB7Yv0cif1v2Nya6VTYqVvclVsxQ7gPAjPiVgt+BRhoXxGJfdm3L5Wdls6puG9ko+yOc=
X-Received: by 2002:a05:600c:1da4:b0:439:9434:1b66 with SMTP id
 5b1f17b1804b1-442ebbe7e80mr37045e9.1.1747083888729; Mon, 12 May 2025 14:04:48
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512174036.266796-1-tjmercier@google.com> <20250512174036.266796-6-tjmercier@google.com>
 <CAPhsuW6KEtKu5C+Y_X3EFkUFSg8=LnQ9nJFUD81rYgwvBvqzHg@mail.gmail.com>
In-Reply-To: <CAPhsuW6KEtKu5C+Y_X3EFkUFSg8=LnQ9nJFUD81rYgwvBvqzHg@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 12 May 2025 14:04:36 -0700
X-Gm-Features: AX0GCFvIOd-tF5p6eczt7ynOfdOnjScDBhB5U-GpV17T4Ix1WysDKZAupTNpB3E
Message-ID: <CABdmKX20zo5FhUGf2ZJXvcSetbK25HV9Z=AG8MhLU+dnT_kP6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/5] selftests/bpf: Add test for open coded dmabuf_iter
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

On Mon, May 12, 2025 at 1:30=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, May 12, 2025 at 10:41=E2=80=AFAM T.J. Mercier <tjmercier@google.c=
om> wrote:
> >
> > Use the same test buffers as the traditional iterator and a new BPF map
> > to verify the test buffers can be found with the open coded dmabuf
> > iterator.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Acked-by: Song Liu <song@kernel.org>

Thanks, I'll send v6 this afternoon or tomorrow morning with all changes.

> With a nitpick below.
>
> [...]
>
> >
> > -static int create_test_buffers(void)
> > +static int create_test_buffers(int map_fd)
> >  {
> > +       bool f =3D false;
> > +
> >         udmabuf =3D create_udmabuf();
> >         sysheap_dmabuf =3D create_sys_heap_dmabuf();
> >
> >         if (udmabuf < 0 || sysheap_dmabuf < 0)
> >                 return -1;
> >
> > -       return 0;
> > +       return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name, &f=
, BPF_ANY) ||
> > +              bpf_map_update_elem(map_fd, sysheap_test_buffer_name, &f=
, BPF_ANY);
>
> nit: Instead of passing map_fd in here, we can just call
> bpf_map_update_elem() in test_dmabuf_iter()
>
> [...]
>

