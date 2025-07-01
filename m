Return-Path: <linux-kselftest+bounces-36196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7608AAEFFDA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 18:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E677E7B2B28
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC9427A114;
	Tue,  1 Jul 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKtlXMSc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554931F428F;
	Tue,  1 Jul 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387490; cv=none; b=XDfnDY7RAKN5jSs2+ZtCnHpfM+Renn9TyesYf8nE0N/z+X7dTOO7WJrvwxgBjQJN9lF7mbKBt3oFEWy5nbn8HBtWbxvBoqzyQ2j9c5GL/gEuI6DZfcOil0ahUs5ThV2zJruVgEzSsCgRLUTJ7lC7bobGK9jCiEO858F3JBLDYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387490; c=relaxed/simple;
	bh=CcoZ+jyWrjgQXqI90PfN7uvuJcq1zdmr0lpBisf7mWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGnb1oJXgcbNxBZa1SPYwovBtT7pHS0XlN38k5e8XizXg4q1hJht+uabA1AxISmUrlbtqolttx1FzhPYWLE7m0iu6M4uMGC2pv4bsf/oG6CyLYR5S7b0snUMcT2d+qXzm25w30eiqtj6bP0ERSpCJ/btXc8yY/QSHMGVBA1gD/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKtlXMSc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ef62066eso72450465ad.3;
        Tue, 01 Jul 2025 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751387488; x=1751992288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGjQHDXTl52XkzXC5aSP4R+Ng9QPOvHno+hnhDfXbCI=;
        b=fKtlXMScBm/nqHVW99CVzt5otrDA3zUBKuH+TZYIzEvMY6AsFgOjiy6jnm/k6HQTMT
         NvlPa2U6wdvqErJ3GGfyUQ0JFM44izJ9peLkTE4DCOI7HHKQsqBSHYHdewHP27Xejalp
         PbebwUFaREgXPxYHF71IIR2EYoWKZMQi80nMJWIl78941LSeT6VTV2/wcTTKxZ7uhTZ2
         Ild1NEcE+tq1+CUk/+t7v5e7yiiyMFLLav5eit6NV8F6ck/Gyzez6p59frP8IAH5LMqg
         ZFWtnI4mdyHqsjMe90C7IFgOHus1U9JcrJFWxJTukxJHn9zu8uZAf6468RW118pK0gSL
         l1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387488; x=1751992288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGjQHDXTl52XkzXC5aSP4R+Ng9QPOvHno+hnhDfXbCI=;
        b=IMFTVpgsMCldNthJVQJOAm/cyRkC2Jij5f5xR3H+1wohvi4u2n40fGOMUOH+A/GFQf
         awHpupOZuv+A5CBnAXksd3PpKSZr7X5YYB3WB6oqPlQN6bH8vG/6hR8Wq+oNlOUwZs4s
         z6VS87EmjkTR8EEaDOdau7JI87k8jLyLr/3hfNJI4qsAmOJmQT5pzAnyTHz27xh+UkAD
         6nG/aITc+1lB9nx2LE9OEYNekTOwtnyN5297/jqG26j4Ts5vaRQtBWJq/mCq2AEE6PXA
         zdKCBC7hVsfReOnL8MuJajiPiCtaJPeZ4+9v2YsWeYYvUWtkHjCMVyP6xW10cHUl/wZO
         udtw==
X-Forwarded-Encrypted: i=1; AJvYcCUBxmHBHdUa2bs0InKSzWaKBeVm21vWrl2mYfdMpZUzwiLeyBsqEeG1uiDZZmJggjxUni6pnj8/UtzlLJZF@vger.kernel.org, AJvYcCV2YOGz3WU67ffw4VZl/qS+iS77ghB4FixaxKEdU3I1aUpkn+vGsFoIhlR0G4huHF78+aufXlYUIonw@vger.kernel.org, AJvYcCWuF+v1rNEt/XLQ89q6rO8dcIjV+9vh3ESpGvMEJ+ScMKurS727NMmv6k+u/7MhxbCw9GHEsphH@vger.kernel.org, AJvYcCX740mU+OKASh/wtjtEIEvP44yOyHyT/k3ftfoTlYq12eof9Ax7sU3/2KxAzINonNSGaYQuURTn2hVC7AR+UIco@vger.kernel.org, AJvYcCXdxQdabllHEznDwTNFtHIWMJpR6Lu+j+rNvqJzRnyL/zojfqlTHG0T34wzNS+EGuVxXDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+Ns4t6QdJVt1IYypqMGQmnyjpS6jmCXHxY0VkHF/BXNjUwxh
	YHhIPhGYIjSru1FRzmxE5BQ/nov8+1+0xy0paM7xj/2SafjmoZ6MBx8=
X-Gm-Gg: ASbGncss0ZQ6VrT8CR+iN8yRLbsGMhojlR79W0uCYJgnGmQvhXpk0WbMHIOjrruTJbu
	iheXZfKnLdL9ihy2UnxJiTop4SEG5GdI+KyqrALTG+mgiqYtdKA8yd2+0p8rfvKqoNBfN9usyhv
	j9OpBjGA1ievMVG89acIsUO8AkuON26PogRFEMYrt8zknTC3XQ6x6wk9nIhVzmGP38FxffyZeg2
	h/QHwN688oTOhevj+Foy8HMa+R4C8GPhCsqFoNIWFDeiC2TUCubJR/Xdi8qFCpFS8QdKZnXj7pO
	Eod36sTSCdtOhPfHJJ4W2afnceMuLp7pkPDR9DgF6i2g85jQ0DqRrA86s/fYLe4GQv1OnK7YsYU
	1YS9BVnI66s7C0zftbpwD/SY=
X-Google-Smtp-Source: AGHT+IE42p+bvXcIC/EYegYCnbHHAI3uzv2WW7ETzX20cqGvD5/lHwRMjETv8b5lYWoWaTAuYCqLHg==
X-Received: by 2002:a17:903:7cb:b0:236:15b7:62e8 with SMTP id d9443c01a7336-23ac46244b8mr180664355ad.25.1751387488444;
        Tue, 01 Jul 2025 09:31:28 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c54b8sm115331295ad.217.2025.07.01.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:31:27 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:31:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Enhance XDP Rx Metadata
 Handling
Message-ID: <aGQNWXe6FBks8D3U@mini-arch>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
 <20250701042940.3272325-3-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250701042940.3272325-3-yoong.siang.song@intel.com>

On 07/01, Song Yoong Siang wrote:
> Introduce the XDP_METADATA_SIZE macro to ensure that user applications can
> consistently retrieve the correct location of struct xdp_meta.
> 
> Prior to this commit, the XDP program adjusted the data_meta backward by
> the size of struct xdp_meta, while the user application retrieved the data
> by calculating backward from the data pointer. This approach only worked if
> xdp_buff->data_meta was equal to xdp_buff->data before calling
> bpf_xdp_adjust_meta.
> 
> With the introduction of XDP_METADATA_SIZE, both the XDP program and user
> application now calculate and identify the location of struct xdp_meta from
> the data pointer. This ensures the implementation remains functional even
> when there is device-reserved metadata, making the tests more portable
> across different NICs.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/xdp_metadata.c |  2 +-
>  tools/testing/selftests/bpf/progs/xdp_hw_metadata.c   | 10 +++++++++-
>  tools/testing/selftests/bpf/progs/xdp_metadata.c      |  8 +++++++-
>  tools/testing/selftests/bpf/xdp_hw_metadata.c         |  2 +-
>  tools/testing/selftests/bpf/xdp_metadata.h            |  7 +++++++
>  5 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 19f92affc2da..8d6c2633698b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -302,7 +302,7 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
>  
>  	/* custom metadata */
>  
> -	meta = data - sizeof(struct xdp_meta);
> +	meta = data - XDP_METADATA_SIZE;
>  
>  	if (!ASSERT_NEQ(meta->rx_timestamp, 0, "rx_timestamp"))
>  		return -1;
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index 330ece2eabdb..72242ac1cdcd 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -27,6 +27,7 @@ extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  SEC("xdp.frags")
>  int rx(struct xdp_md *ctx)
>  {
> +	int metalen_used, metalen_to_adjust;
>  	void *data, *data_meta, *data_end;
>  	struct ipv6hdr *ip6h = NULL;
>  	struct udphdr *udp = NULL;
> @@ -72,7 +73,14 @@ int rx(struct xdp_md *ctx)
>  		return XDP_PASS;
>  	}
>  
> -	err = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));

[..]

> +	metalen_used = ctx->data - ctx->data_meta;

Is the intent here to query how much metadata has been consumed/reserved
by the driver? Looking at IGC it has the following code/comment:

	bi->xdp->data += IGC_TS_HDR_LEN;

	/* HW timestamp has been copied into local variable. Metadata
	 * length when XDP program is called should be 0.
	 */
	bi->xdp->data_meta += IGC_TS_HDR_LEN;

Are you sure that metadata size is correctly exposed to the bpf program?

My assumptions was that we should just unconditionally do bpf_xdp_adjust_meta
with -XDP_METADATA_SIZE and that should be good enough.

