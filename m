Return-Path: <linux-kselftest+bounces-32694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02DAB070F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 02:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B167A068E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC681FB3;
	Fri,  9 May 2025 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/hZksUx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D75B640;
	Fri,  9 May 2025 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746750531; cv=none; b=YxR9BQUrPFOeA6wmBt3Ot7lkh54aR2ESwE3LEG2jwigztMhDGsumoP381mn7FN/dRcVAPVW+Ths5YVrpfb8lAeY4zlUIot0mX+Wo93/gZguc9GsoEVntu4VYP1bV6NNxA73/B5rNnmZm9BJUSB8WUVdIrh03dq3/a3ofV3pu/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746750531; c=relaxed/simple;
	bh=KihOfUg/9XwuGh7JrvWssx/WPXQw1u4V1nnzLZ17ROI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDSGvpLX3sW1+M/i8RSuNpGibPofDTuTEF21giR/V7hlMrdk/Eny/V3QE6aSuiIfJ8vfRJxwonxR9EOh+ok/P/H4Avk9jtnilQxwm7EwSNqUJJE/4JYRdwcg9cqrgJcr/ptXtiY8bhkW++rNwoPSXowPfRScbqwiV5lHKuc15D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/hZksUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62509C4AF0C;
	Fri,  9 May 2025 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746750530;
	bh=KihOfUg/9XwuGh7JrvWssx/WPXQw1u4V1nnzLZ17ROI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B/hZksUx85KQAzQgyJhcLud896d9a0FViZp+yrXcyNtZYKKoJTFoWFVtkFFei4nsG
	 xHgG1MtzZ2YUL555H2MMWXMhyGuzxxquOFXx7YRCG2BGsPXLoK7TAorEpMX63sADY1
	 n1g06vqVgx3UsLudWNEzoMuLUjel0A8Ab9GvipbQNbrYFpN/6UzprB+jyQFzAyH1+l
	 4Vmcuj9/h8uMBxCr7aRBf/tDv92n1DICPin9/rVr8u0xUosuVGmx+HXa1at3KaZGwD
	 xaORDd9OGsff+yrtvgVCNW4LDy9UAmpod1NXKo3Manf7hPp0Ppo4mpscfy2qtZpw2Y
	 DfSTxT9IQjOgQ==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f5496972d3so15311236d6.0;
        Thu, 08 May 2025 17:28:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV6L0rOBntQUjzdrufsMSiK7/Y9D3XrQQaP8nwBE6ICHy1948TaVoTPH3bvkps5p9kBgmaoh84bFUPODzuTQ3H@vger.kernel.org, AJvYcCUiOR0S6otmeE+JMnQFUB3rVtnaseRqt5jDzXiVd1vHnj2pBx0eNNibcAsqBHsAA2e9YI6Nc/ZowJgZMGs=@vger.kernel.org, AJvYcCUoMVy2+wAfp/wIAhPoZRRewQCMpsoSChRtxY4j4gNWfK7up6MrStqYCBDVh6IlfCjXADc=@vger.kernel.org, AJvYcCWr7xzd7YII5GeP4Jd0OHglaii6xmpmI5J+OxSlnCdP9IY+sD2DyVs7fS+Edq+LF2YS79kq4IHoFFeFEMT3@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDKnCF98RKi0qOngBjkdusWA/JpDlSr8T8pDeMaHqC2uYnX6k
	Rh4ME5ljH+kEAu8FdNgTNWgxm907FPxqgOWCgu2bc/4A+WAihGTQPKgSa9FyWSGs+pQJHXzyWIW
	VUG9sbf1Qq5Pg5pBGFcqZB3+yHT0=
X-Google-Smtp-Source: AGHT+IEZjmUuPnl3walRWvq2j8HrpCkOTj0Aad+6bRr9r/jSlB1hm5+VFIy5a/r9RnYh6bQmLPVS3BOr516ElNPcGNk=
X-Received: by 2002:a05:6214:62c:b0:6e8:97f6:3229 with SMTP id
 6a1803df08f44-6f6e47e74a5mr24782636d6.16.1746750529582; Thu, 08 May 2025
 17:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com> <20250508182025.2961555-4-tjmercier@google.com>
In-Reply-To: <20250508182025.2961555-4-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Thu, 8 May 2025 17:28:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW613T4biUPER9zR9DdQA_wscN4-i3vV4efoOKUZ7pkTeA@mail.gmail.com>
X-Gm-Features: ATxdqUEx--2NHG96PqiywIn23M7lRslvlpezfrP_cxwU4xbMt6X3lm7qXfvmTG8
Message-ID: <CAPhsuW613T4biUPER9zR9DdQA_wscN4-i3vV4efoOKUZ7pkTeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/5] bpf: Add open coded dmabuf iterator
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

On Thu, May 8, 2025 at 11:20=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> This open coded iterator allows for more flexibility when creating BPF
> programs. It can support output in formats other than text. With an open
> coded iterator, a single BPF program can traverse multiple kernel data
> structures (now including dmabufs), allowing for more efficient analysis
> of kernel data compared to multiple reads from procfs, sysfs, or
> multiple traditional BPF iterator invocations.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Song Liu <song@kernel.org>

With one nitpick below:

> ---
>  kernel/bpf/dmabuf_iter.c | 47 ++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/helpers.c     |  5 +++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> index 96b4ba7f0b2c..8049bdbc9efc 100644
> --- a/kernel/bpf/dmabuf_iter.c
> +++ b/kernel/bpf/dmabuf_iter.c
> @@ -100,3 +100,50 @@ static int __init dmabuf_iter_init(void)
>  }
>
>  late_initcall(dmabuf_iter_init);
> +
> +struct bpf_iter_dmabuf {
> +       /* opaque iterator state; having __u64 here allows to preserve co=
rrect
> +        * alignment requirements in vmlinux.h, generated from BTF
> +        */

nit: comment style.

> +       __u64 __opaque[1];
> +} __aligned(8);
> +
> +/* Non-opaque version of bpf_iter_dmabuf */
> +struct bpf_iter_dmabuf_kern {
> +       struct dma_buf *dmabuf;
> +} __aligned(8);
> +
[...]

