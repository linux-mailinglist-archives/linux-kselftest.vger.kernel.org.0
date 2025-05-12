Return-Path: <linux-kselftest+bounces-32875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E9AB4571
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 22:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1803C468180
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1454298CCE;
	Mon, 12 May 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBx4KgqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC08EED8;
	Mon, 12 May 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747081796; cv=none; b=Qp2/VsgloK/hFuzmjhpKtjB+o7Cg9BWErzwIiXdiKC0PmHmRwJxcxNKpJS1+MK87W14hZgl/bL9CU4swlmfd4qRYTLSZfe2LOC1fGDF0bj3URHfzIDuXsF778aW2Acf2bCQ9r6rXwb/o3ydepkEOUNCMldCygljIzbls/2fudV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747081796; c=relaxed/simple;
	bh=Q1AuxTQ7799vYv+9kB6vXV1iWDTncQh/7UoL2uX/9No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm8rZqtF+8URTz0hEIEjYFdRo7YxrbFVTdIp+0Lq8IAUoCxoRSNKbv1TW5QVvmaoMm9AEI1VSytKDXRUFkNp7w1vsdRbow976O5BZHioOQju66lFBs8iMpICWS698kI4YGNVyRXVBi+fyZpHlnCbplSp8incNJI2mW4GmKDvTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBx4KgqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C8BC4CEEF;
	Mon, 12 May 2025 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747081796;
	bh=Q1AuxTQ7799vYv+9kB6vXV1iWDTncQh/7UoL2uX/9No=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tBx4KgqPJq4VQ1ebPq+sGhfPYt+EgimgZpb7ffjTzWptg3sC1RNUxs6d7gcCf1ufJ
	 +jlhrT716R8b0aYG9sWKZd0UA1Cq6JqGv1sdbR1gEIHEm8/3uwnkLWEgPJ1aPzIWT3
	 +iKaXca7/KFAsH4ypGp05neMEmdp38FQR2qkMH8M+NzEicX3hGT1WQxyLT9JJR+//4
	 otYETItWVpkNIl6AeGX04cTSdNpS4loTUB2NTey0KCTnF3+ZpslrhVlfMu47rLC67/
	 k8LUu+e+fJAY1GqKc8l/W5F8rgp9XCrSIqM3pFl6+aV3aOg1i22ccZTVVw91I7fuxK
	 a3X25K5bACSGw==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so70787596d6.0;
        Mon, 12 May 2025 13:29:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMc2oomiT8Hj9uf8ECuH+AzdM25SQlFPkW6b7+mvS5L4eggCiA01Dgcg2JRaKeeAyLaH4=@vger.kernel.org, AJvYcCV4Ssw6UAo+5exiedMNhKgO3Rof70k+4yKM7JgCcRMX3/5ySyHqJczBCDShwOpfUjNKdsij5ba90m8ZhFQ=@vger.kernel.org, AJvYcCWTRfRhYFUF7y8XHKtfSr1wRlo0TxqrVnL5OwYrgQQArByqD4dlLBgUTMDuL9+bR2E+3Q6rjuWHce6jtG01@vger.kernel.org, AJvYcCWsWCKAMCq24o3/xcxacVGfJfJKOzc3E+4IE8BSz5bgL9LFU6GLn3b5xx+Y/szXHuoO+fpOWxsB/LzV4EbziLK7@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQkj9xv3IFbRj442L+X2+WBHJHcu/up1v7JrbYsd8AUCWMz4n
	PmsOZAn3s5KGLENV+mKs8M4mprzGDYpa6LreI8T54+HupNO8HQeXWU6P+VQmAmYBGxhdu4BrkAX
	0dOs1P2BGIMh1T0rFgvlU/LbPTqA=
X-Google-Smtp-Source: AGHT+IG5rkCx/hpDMtSKvEl8qMX6hPk0sGnzSeyFBD0wIK4YZybCKppA5Uh0VUx57tW/L441bM7HGxWCyQByM39LevM=
X-Received: by 2002:ad4:5bc9:0:b0:6e8:f17e:e00d with SMTP id
 6a1803df08f44-6f6e47aa755mr234448176d6.14.1747081795541; Mon, 12 May 2025
 13:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512174036.266796-1-tjmercier@google.com> <20250512174036.266796-6-tjmercier@google.com>
In-Reply-To: <20250512174036.266796-6-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Mon, 12 May 2025 13:29:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6KEtKu5C+Y_X3EFkUFSg8=LnQ9nJFUD81rYgwvBvqzHg@mail.gmail.com>
X-Gm-Features: AX0GCFvzZHZSPJCVC-VLXwXHh9XY0gCw1pbH1Gr6Gl6YMKHnqA26hCVsNML8Mo4
Message-ID: <CAPhsuW6KEtKu5C+Y_X3EFkUFSg8=LnQ9nJFUD81rYgwvBvqzHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/5] selftests/bpf: Add test for open coded dmabuf_iter
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

On Mon, May 12, 2025 at 10:41=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> Use the same test buffers as the traditional iterator and a new BPF map
> to verify the test buffers can be found with the open coded dmabuf
> iterator.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Song Liu <song@kernel.org>

With a nitpick below.

[...]

>
> -static int create_test_buffers(void)
> +static int create_test_buffers(int map_fd)
>  {
> +       bool f =3D false;
> +
>         udmabuf =3D create_udmabuf();
>         sysheap_dmabuf =3D create_sys_heap_dmabuf();
>
>         if (udmabuf < 0 || sysheap_dmabuf < 0)
>                 return -1;
>
> -       return 0;
> +       return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name, &f, =
BPF_ANY) ||
> +              bpf_map_update_elem(map_fd, sysheap_test_buffer_name, &f, =
BPF_ANY);

nit: Instead of passing map_fd in here, we can just call
bpf_map_update_elem() in test_dmabuf_iter()

[...]

