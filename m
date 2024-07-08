Return-Path: <linux-kselftest+bounces-13324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D812C92A86A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 19:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669E2281EBD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B09149C43;
	Mon,  8 Jul 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxMjx8y8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82531146A85
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461013; cv=none; b=mv3Dz9xoutWp/2h8W93DdomYo5ZuDRgihHS+GgIzAnRq9M4Zyz2mZ5REv2EpXERs4knj5QavKHmY2OVt2/LMI078/BlPYapdykDWkNfoQ/r5NHe0nhzNA4fyh7m9HKfwAQPo9+KVTwkw45FEGPIKFo/HleiCIy4GXGmtrmqOFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461013; c=relaxed/simple;
	bh=Cgeu270hOmX3S5GZTXTxjnZltMxA5nAub89Ban01DjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tg3r8f0U9dovVgDJ+9vgNowo5njdpOMOhuGIgA2CUYo7d4QBgUVGLqOI4JCe2zMK2QMklvSdt4APDwRpmyGcIArTjAk3w2IK2m9o3dwHUvzkOqo+rzxg1GZwCXgcmJjTe5F1MJmMhnzTwmJZTPq0jSFOvt084aMcWlfJYo7pmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxMjx8y8; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so4109640276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jul 2024 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720461009; x=1721065809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nESyMzGZXBtAqIeO/AYycg3VVtY82ta3I2iF0FVP4cE=;
        b=kxMjx8y8+f//+s7hEupd9DKh37DXdEahAVb2tjOhRg3I+KR8cBC+wrlTsZAnearr09
         poj2fR+HiezIpXAOvx/+j4SXmv+jxd0LUv5DwTlvGskBUXBE8x75i0fSPlD85ZY0TpUf
         ljmRpZu75n+UXw9PVSFuH4+fI/ctN49/YzKmtyLM7aLkkeiPp92sAzp5BEO3nZ2O7Zov
         Anr+kyAuj3iiTQB4BwPToWM9CnelVdJ+vWj3uZclatMRnAU5+NEzocQ5+gY6rptYn5U4
         5SfYoxdr3MyxJSy59iWeIaFI31lEwYk7Hdi9y6LrbijHXCaf9kewubcp5GHXvOL186U2
         exzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461009; x=1721065809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nESyMzGZXBtAqIeO/AYycg3VVtY82ta3I2iF0FVP4cE=;
        b=GxfCmlfAhX7t4a/FAif09iqI/6hfHlflEDdMTgraH2Oh5eEkvRtzTB7O6Q23H1USJM
         WZy0zLVKpNIk37xmvqojzQf1wiWccWLe7xQqRD7v1xhkBV62jyjsmsEoLZzUoT6LLn9o
         6AtyiuHj9zw9D8n+96kCvBPuyCz59hXWi7+3nPBsrjyYoSUHXUzU4rwBW0kvKb/VwSxq
         62E8TEZJQ3SFRO/fc8+j0Yi9HIZRL92U7/e6JIwK/1jevtUx6nWUjJXMnGYe2zFvqdLz
         3h/u1IxY/f2gU6WmtwWT/CGsbZMd2AXnSHwZq1K5m/IXM4OibLfNWTQHRKPX88RoOff2
         rJRA==
X-Forwarded-Encrypted: i=1; AJvYcCWAcpBN0egJ9pQRMO8zqKMx+7XAXkH8Qp6E2gjq8JzOlYPbt9RpU5MZgTvV9ZMKWvBI4iXU6fXJSHAvBh2oZ+KFg1vknLbgsCPAVt0UdOid
X-Gm-Message-State: AOJu0Ywcrnf13PZPX/XrC7Y/zeH66QmmMD6f/b23j1hG5/9rEvKyquW9
	eFb+HmSld3p+3xEqjzaqONgIivZQnSzNRbM/h3HiwszYFh+ovdMK4F98wSsbYOa1oYhylqSyKd9
	FMmZhvi0Rh9nQMQ5pXwsME0D1ay7HbtMRxkiI
X-Google-Smtp-Source: AGHT+IHcxq/i9rzCxsEN5hnVo4LPbu8O3jBlhcP+IANI38Pst6MQnmRwrHXpKPTOw9a59dfbicjTNMHGzlIpXAxgcP4=
X-Received: by 2002:a05:6902:1361:b0:e03:4e08:c93c with SMTP id
 3f1490d57ef6-e041b03995dmr571404276.13.1720461009288; Mon, 08 Jul 2024
 10:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708134654.1725-1-yuzenghui@huawei.com>
In-Reply-To: <20240708134654.1725-1-yuzenghui@huawei.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 8 Jul 2024 10:49:57 -0700
Message-ID: <CABdmKX1CXWuw0-gRukZeSoF=SZFi3eRPELe=EU_-q3OVKQHZzw@mail.gmail.com>
Subject: Re: [PATCH] kselftests: dmabuf-heaps: Ensure the driver name is null-terminated
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	shuah@kernel.org, wanghaibin.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 6:47=E2=80=AFAM Zenghui Yu <yuzenghui@huawei.com> wr=
ote:
>
> Even if a vgem device is configured in, we will skip the import_vgem_fd()
> test almost every time.
>
>   TAP version 13
>   1..11
>   # Testing heap: system
>   # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   # Testing allocation and importing:
>   ok 1 # SKIP Could not open vgem -1
>
> The problem is that we use the DRM_IOCTL_VERSION ioctl to query the drive=
r
> version information but leave the name field a non-null-terminated string=
.
> Terminate it properly to actually test against the vgem device.

Hm yeah. Looks like drm_copy_field resets version.name to the actual
size of the name in the case of truncation, so maybe worth checking
that too in case there is a name like "vgemfoo" that gets converted to
"vgem\0" by this?

>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 5f541522364f..2fcc74998fa9 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -32,6 +32,8 @@ static int check_vgem(int fd)
>         if (ret)
>                 return 0;
>
> +       name[4] =3D '\0';
> +
>         return !strcmp(name, "vgem");
>  }
>
> --
> 2.33.0
>

