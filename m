Return-Path: <linux-kselftest+bounces-30983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB7BA90E62
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0C37A3676
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5287E23371F;
	Wed, 16 Apr 2025 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQVw8gfh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AC2BAF4;
	Wed, 16 Apr 2025 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840960; cv=none; b=GxoyeE+bIr49MbYKoami9lGfecx/W64LKLtI6Ubh+mtJJR/LEKHxHLu2YVwRvdOvzCbxf8aTncvGv1eQq7PgmkRMje7+JZdteBJK7L4H35+dZm12sdpT+jMq5KP97yphMee6ohQfKD+EnrkJ0DpFdYhHzr+srrtKQKqwS56j/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840960; c=relaxed/simple;
	bh=pEWNCN4ZX0qZhZ3W3spaJM2B3e1c6C6EMR/RLHg+n0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aA23Ju6yyjM7IBOVDhldkFRwLuv2sboEFewCNsEeDMmXzqaNZwPzXEDe3XI8d8bvBd2wpVcXYiaTMPuTnIfGnjxyU15JYXf26yT9GUFjEF3qCghfTdLYUFk3B1QpzmzxO36rz1PY+59gZh/b6kFhmfQ/RhSJKtfF2q05j7W+sqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQVw8gfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C860C4AF09;
	Wed, 16 Apr 2025 22:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744840959;
	bh=pEWNCN4ZX0qZhZ3W3spaJM2B3e1c6C6EMR/RLHg+n0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vQVw8gfhLmq41PEpDf+Q7IZasp8I0ezszztme0m2nyMwSrwmGiOpTfjcJno7WFCSP
	 ludJQwFLaJ4mhVZW/r3hr/3LqCmU/MbA8enWGWm0GL6AvPWtI6p/EvecpXrxmAPEwg
	 VRfxGaNiqL9fv1RnLj35RKE/eKf9p3EK6xr0H3ig8zgkMGSEfgEChvAkIHdja/txaQ
	 6vwyNe+6US6vqHLHII4v8QZHtTmVvaxJ4Tt8VMgzKD5Uo6T6cCDYnPZib8KUhyp2AH
	 XMzn1d6oaHYcCGCemtinLafjQs+NPu0aVbehMJxABNLxxi4ezUUbGqBxWNEifd37Kw
	 pXsI6xtPiHaSA==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4775ccf3e56so12725961cf.0;
        Wed, 16 Apr 2025 15:02:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtQpOWUFM2x2srL3umuTyjDtKEbjzwDbV54zrrjg4WOyVe4UsxtatX6TpIJbOY05bIpi87/qVlqrobegHX@vger.kernel.org, AJvYcCVD2sYuyppLR/r0GFe+weo0mOqYomUpEr6CSvjXqL2P140SLLIpNfWWPIzISxh80e+kzZAVf6hY0STQ@vger.kernel.org, AJvYcCVLIQHl6SGc0DxcTrzNW0Wm5yr6J864uv/t10+jm/bCtEtcOmr3VrtZlbSRgb9vJnNuaoc=@vger.kernel.org, AJvYcCXTfMZ5LAaxVCENKpUmyYKNvzGJshMlozTXXx1GNYndHOQYsGPBSjpjOvgEb66uun8adKsCKQi6ZGGlz2dTB29S@vger.kernel.org, AJvYcCXWAmWFp1zH12qVdvZHp6RIrffYSJSbc168LXSazJJN4GDiPevYxTaZ2OGMs9kLJUx4B+cPcUT7b4YbSqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzoTHQqvct9WU/yFzzNcNP7RHztzUw9S/eiYfRsGxgGP7rkr7f
	IR3wxTyI5GB8DTz2manf3ldg6qUWUGgmex8RVpKdosy9ZoqMKwJbZOwRIzLtBB2X/j+GEEmNMyn
	11oliFnxL/MpDJJ8reeaNhwNleE4=
X-Google-Smtp-Source: AGHT+IH2FW3F7i+zlhWoFLsnu5ZjPE99AtfOVpaO0+OP0tveE8dajNhBdza9/ZM6TT0O9R83dKaY9ZEW3XMZcAC8g6E=
X-Received: by 2002:a05:622a:5147:b0:475:19cc:a81a with SMTP id
 d75a77b69052e-47adf238197mr10613471cf.21.1744840958640; Wed, 16 Apr 2025
 15:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com> <20250414225227.3642618-3-tjmercier@google.com>
In-Reply-To: <20250414225227.3642618-3-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Apr 2025 15:02:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
X-Gm-Features: ATxdqUG8pASefvj0hrBbKUPzLq8VtsN3bPrVvtjdcRijfVngZmMaVn9SzVG5PSo
Message-ID: <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
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

On Mon, Apr 14, 2025 at 3:53=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
[...]
> +
> +BTF_ID_LIST_GLOBAL_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
> +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_buf =
*dmabuf)
> +
> +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +       struct dma_buf *dmabuf, *ret =3D NULL;
> +
> +       if (*pos) {
> +               *pos =3D 0;
> +               return NULL;
> +       }
> +       /* Look for the first buffer we can obtain a reference to.
> +        * The list mutex does not protect a dmabuf's refcount, so it can=
 be
> +        * zeroed while we are iterating. Therefore we cannot call get_dm=
a_buf()
> +        * since the caller of this program may not already own a referen=
ce to
> +        * the buffer.
> +        */
> +       mutex_lock(&dmabuf_debugfs_list_mutex);
> +       list_for_each_entry(dmabuf, &dmabuf_debugfs_list, list_node) {
> +               if (file_ref_get(&dmabuf->file->f_ref)) {
> +                       ret =3D dmabuf;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&dmabuf_debugfs_list_mutex);

IIUC, the iterator simply traverses elements in a linked list. I feel it is
an overkill to implement a new BPF iterator for it. Maybe we simply
use debugging tools like crash or drgn for this? The access with
these tools will not be protected by the mutex. But from my personal
experience, this is not a big issue for user space debugging tools.

Thanks,
Song


> +
> +       return ret;
> +}

