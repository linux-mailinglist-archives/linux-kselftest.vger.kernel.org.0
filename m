Return-Path: <linux-kselftest+bounces-32580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF06BAAE2BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 16:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE6D17D4B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED0628BABD;
	Wed,  7 May 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG/sp2PJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64E28BA93;
	Wed,  7 May 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627257; cv=none; b=PkF8hAiOUs7VntUA4YAlG4uiEocfw0rjgn0evyYgMsEFjghJZhV6Hf2qnEIpvPmj9vf8hfhc1zG92kyJ9zzLhqUF8AmE6FbbV6vlkQSzkrsWwCIuqjJLSHleh40vVTP3tbBCD4FrvC0qQMtVOcCLj6yWJpfpeXc2+JG3lyrZAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627257; c=relaxed/simple;
	bh=ZNnZUmX34eCntIlv80BWyc/0QNlOJepYSEHreCjNtrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9jZFPCiNs7L/IrGw/PP8T+6is8eOMwKHxRk4EKQ/cFhEvjDK9hKXIBlHwZnIahGC0DOhh4z7IwQHa8CFw1Hoim2XuicHjnu47n8gqPzLpBrHcYJpNiv/XKcL1d6/RnJxkButZjoxIkFLL0Hzdt6jqsrscM5jatLzEI+5OQNlhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG/sp2PJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so6786458f8f.1;
        Wed, 07 May 2025 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746627254; x=1747232054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNnZUmX34eCntIlv80BWyc/0QNlOJepYSEHreCjNtrU=;
        b=FG/sp2PJKmRZIE3jDKdJnF+OhDAj3kFR8+icDYRsMoiTuApbVJENLr3+g+12mtKaFF
         jRWm0SvGYio+pjDG1C4rfc0AcIDC6OUNBTNH/uUD7NI2b51wYZ+uz1uwvV4+N2yyc5h9
         xteBat+YlploY+Qxfs7RTDeWbEwMRttWaIryW7tQtyfXpTz9Ag2d5kY2Ak38NFyghKYp
         5LUascj8UwOjez6KYPvzPsY3ZzcRfQqpRSNELiaseYzZv5bgeg7r4BxnoFzE0F3MA1CS
         cciUqJzORVUITBSoN5ONK9Sa+oH3+qHiaE9TKq2K7VW2ZFB3ASVOyWEMYWSFQ6QfaT/c
         caAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627254; x=1747232054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNnZUmX34eCntIlv80BWyc/0QNlOJepYSEHreCjNtrU=;
        b=kn+JzILZ6yguBHuBjgboml8+rN2txtu/7k/mvf+2TR715QKSa7UNdRvKKwAHOEVG6Y
         LScpjAbWRloVwFKKShlJ+Ijskl1kVJ6aawA5ElwFUmo4qmBZa/TsqIAMvMDeL0Ikm9fq
         9ETac3ZURTEZ4/kHyQTREDuwC8R0tysRFrmLJZvSulcvdviUkmkPcbua9MFIlBbO+asT
         oh0yvJpbKpew8KRfYKTJa2c243E6TlGcOwRGOVX85oEQV0iQ976zbxIft7PNKNCbdnBz
         khJJwLSwUODEDLdd3OCZMrKRbPo/SoPEzVsqHNLwjCb6MQiGzP/Xd0OVhHFwJXRaWVpJ
         U8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVDvM9usQ/Jg77W6aUrvtb3LshBB/U/Df2M1UuvOv6lg2eKHCAj6adpiy5Dto3FgkPNOZs=@vger.kernel.org, AJvYcCVZBUacmi55xz1dBSgWsNBODzERoNhGTSQzT8T430sa6E3sVA0l9NAMfd2QLzushvYAyEgVzYCR4Ht/1UDO@vger.kernel.org, AJvYcCWZ4ZljUME2jHCGycIa56FDItL+JQJhNrkDRHCu7fgeNH59MdDJyjPCv0TwYMwPzF39LhA7IwNbtIp3qLBoPqg9@vger.kernel.org, AJvYcCX8k17e6R13IScK9B8tdytVHJVBrh1EkRZgI5Y67yBZTXOgfIHdxq+Xp7pCLUbw5Z7pseUaUAo/kFlH86I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OtIT6Tny/xttTrRGPp8rMW+0Nmz+omWEZovJGKmSR8eCTuY7
	kjB74wAyLLZ20w+p2WQmNk1ZZI43F8TeOAugZZEdNwcj9mSXlJ1DagBwxRDg9DwIpWMEVarbe5o
	IeT0JIRLR6NWRN4l+DoJwspUycb8=
X-Gm-Gg: ASbGncveOfKklAErD0Rg001m3nWSO9B+WiaKdqL8pbuLK5QFmlgdWAtGpCG0McQANDR
	DU2iaQBWwpjf3h1fVgkruOZVPlTxJ9SdLfh2A+xRbHEbvBMDnx46T58sYfLrxiJuFZQdT2a9eOw
	CS8XqXdVi3C34/ylacj9aIXF0lGkGRYi5fopnPuJr79vkD34cg/vPPWFZsAlW8
X-Google-Smtp-Source: AGHT+IE7YwupMe0PY2KfsKAdsd0JUDs8JdlQnJurFBmdXtxSRg25+HLcgrkwMi498eBlgYRhQzzHmmHYGwbzShYGjPA=
X-Received: by 2002:a05:6000:220d:b0:3a0:b940:d479 with SMTP id
 ffacd0b85a97d-3a0b940d807mr45656f8f.53.1746627254068; Wed, 07 May 2025
 07:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507001036.2278781-1-tjmercier@google.com> <20250507001036.2278781-3-tjmercier@google.com>
In-Reply-To: <20250507001036.2278781-3-tjmercier@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 May 2025 07:14:03 -0700
X-Gm-Features: ATxdqUEf5_19Jno_4-zzyhqzCAe0qZhQRxDd8zooZHFiVvDpL9j0mU5OqeyoxoQ
Message-ID: <CAADnVQL2i87Q4NEX-4rXDBa_xpTWnh=VY-sMCJzK+nY0qogeqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Song Liu <song@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, android-mm@google.com, simona@ffwll.ch, 
	Eduard <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:10=E2=80=AFPM T.J. Mercier <tjmercier@google.com> =
wrote:
>
> +/**
> + * get_first_dmabuf - begin iteration through global list of DMA-bufs
> + *
> + * Returns the first buffer in the global list of DMA-bufs that's not in=
 the
> + * process of being destroyed. Increments that buffer's reference count =
to
> + * prevent buffer destruction. Callers must release the reference, eithe=
r by
> + * continuing iteration with get_next_dmabuf(), or with dma_buf_put().
> + *
> + * Returns NULL If no active buffers are present.
> + */

kdoc wants to see 'Return:'.

See errors in BPF CI.

And patch 5 shouldn't be using /** for plain comments.

pw-bot: cr

