Return-Path: <linux-kselftest+bounces-36457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAFBAF7C97
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 17:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85C67B0A0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8EE22B5A3;
	Thu,  3 Jul 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhjthhsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBC223DEC;
	Thu,  3 Jul 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557315; cv=none; b=MzvWcTq5PkkalC+Au0o7OMi2sOdfJTAIlOLlJbd1BI3SDKMbEGgkpTISsc9WZjl5PfNGod+Fybht4XYjVcP5PRm4hX83AtFBQrPoJSDd7Zl8ZV8n7050F+IzgWV5MUcPirMUfDjLU0Znj78lBiM8i34aXCKapshDokLwQj7Zl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557315; c=relaxed/simple;
	bh=NkBIMm7TBqeJYMH6RPL+hi3KACmin4rFhLtSG64UvI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R94FRdBSFvsi/BdL0VAPDGrwEiUOMDIWTVPRMWlhFf7+lPWcEeXlIpVX0wpEiy90cx+VSfJGJe3jy7TGazWXhurHBcBqis9iiz/z4ol82jnyFZLgJ+OasZoPGwQkbcS6MGvWtWOVqa08Pi9NtYkAB8mlgw+8yZWxXyCaLgdIB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhjthhsD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747c2cc3419so133017b3a.2;
        Thu, 03 Jul 2025 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751557313; x=1752162113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fGkOYL8RQfSMzeM60XRGKVUUpz0QC6vboVSRHTQXPEs=;
        b=lhjthhsD4avGlx+IydK8L48d0GlAK/mCJzIqBZSHnzKKWnOPgMQ/xAgumUjcuLP2ap
         yon9DgG7pEzCa0z0dEin+TjW5gJ12MpLWOsXBoBadn0cIaHBiy0fr+v1cS1bvBxhXSgt
         YsaZZQgtQ7sPpAVvYj5YmzI3dyZQdYhhe5Tby5pLdR6kvJj8sfHghbSgn/thnb36/wEw
         O6Pi57rftqlwpMsfRveXtsCFnFploFbnEpneAj4QZS6dt3jR1NJJYbHkvku1AQKBY8OQ
         /TXsbbWlV0G3kSyn4vkrfMPxkIy7SwU1ulVogTUCkWOK+rskvgdVkbdOc62eZg4lDx/2
         BZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751557313; x=1752162113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGkOYL8RQfSMzeM60XRGKVUUpz0QC6vboVSRHTQXPEs=;
        b=Ty7iamvnV7bfIOvSVJEnQLjKdOMqfpJmER+jbimFWTV9K9SHOziDKyYUdeyX3AcB5Y
         6950vkiUPKjs89Sx2shDjqhPqZuW+2GBAWL+/+24BKYyGRkEyTYPQDO9nrL/6TV2MIXc
         s3MgEQih5TquOKSnPSN0vfSgdrRj/nosuRvNReAKlhJdol7K0rQnWnPGAWBsV0SHaYkQ
         mY9XuIdraEOBRwDMbT410M1H4VpygB8fkX0rxsZRosEexZ1VyAbPooviJkKlKKjIrjSe
         TL21uXF9zaeA44bKHotd6hOKK9HTrTlvSRVfUx/fI0MWGPCiS96zzcv8xNdIq4zTeBn/
         jZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUNYE/Tk4UsEZxMZZaeIrBoNXlcsnEcRUqXeOq+0wayOL/DqQ7kYh0ExLq22yAbZtGkezrFgb9Oy0L8q/aT@vger.kernel.org, AJvYcCUvvbvVQr0LG8sRaBGCWubngXcglTiF1vwyT2OoUSG7rgpgUpZU17XGrqM5FFltJZiHXDjYhPjiKrQGRxRhPQrO@vger.kernel.org, AJvYcCVUwGZ7s7qkHBAigzmnjwAcETiia+gXe/ICz+Lucf99/k3XsFpxt3a5Wb5uja0CgypV9Hu173m+@vger.kernel.org, AJvYcCWEshaDoslSwAmmMGq2S503ZCwbSO/qeS0owljjWYUC0Y1bLULiQs+IUMXS5WtG5eBJF5A=@vger.kernel.org, AJvYcCWNKLF3LY+V7P5zckAmZWDbVdG8ZKEOIDqEp0NJ+OzPlYf+HTLVLttiPTH1bbw0sKhX+IdtyduqhFDG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/eDIoAFFkFf3QLUtOvO6TLuO1wIg8EhcNR7Uyg0l/JuQCsFJm
	ddZTeKJ8ifHHenWnQ7BqGj5xCxMiFCxqyCxvUPeWCPIY6ZvHn3OdRdA=
X-Gm-Gg: ASbGncuUYauE4kB+yuh1idi/yeoxFoYlolGcy9d+nlYWXNeW20/7sQaBckC9KvBKDDY
	oLvNEmRvX59Ff/ert4HcxV8EPDT21MMCYx5VeAQJz2o5wD6yjNsiKB6G8ZuQUhAMYBYgKdXS5Ki
	AIRb5s46CC/nvM/8Esa8M8bWntZbsnMrvLYpp1fmnbmKewkaeRMKrIK5M4WNpfskhkckcqCzXKt
	Zpfxl12IKc7mGEgZrsoYofZ/ZM6lo2WybLWRSKWwatQ4sGJUwIvX8KVvMQkCUfZrRogagSinxIE
	q9ccdDBU5MytEWntd0KNSJqZLpEmYK40whsk0KsW9mB6sys3IPDm2cjaSUvxxtv1/X0+Nra9Hpv
	kRl9CsW/dOSASi5z4N1O04T0=
X-Google-Smtp-Source: AGHT+IGqhk2BDmOENKj6dYSheYCLfnncK7OpyMpM5YpFnDZqbsHN5I4tWJo7BQAolfltYHjax/y53g==
X-Received: by 2002:a05:6a00:3e27:b0:749:1c27:bcc5 with SMTP id d2e1a72fcca58-74ca84dbbcamr4511329b3a.22.1751557313153;
        Thu, 03 Jul 2025 08:41:53 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af541e5b6sm18218323b3a.54.2025.07.03.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:41:52 -0700 (PDT)
Date: Thu, 3 Jul 2025 08:41:51 -0700
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
Subject: Re: [PATCH bpf-next,v3 0/2] Clarify and Enhance XDP Rx Metadata
 Handling
Message-ID: <aGakv3SCbr3mAzcA@mini-arch>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702165757.3278625-1-yoong.siang.song@intel.com>

On 07/03, Song Yoong Siang wrote:
> This patch set improves the documentation and selftests for XDP Rx metadata
> handling. The first patch clarifies the documentation around XDP metadata
> layout and METADATA_SIZE. The second patch enhances the BPF selftests to
> make XDP metadata handling more robust across different NICs.
> 
> Prior to this patch set, the XDP program might accidentally overwrite the
> device-reserved metadata.
> 
> V3:
>   - update doc and commit msg accordingly.
> 
> V2: https://lore.kernel.org/netdev/20250702030349.3275368-1-yoong.siang.song@intel.com/
>   - unconditionally do bpf_xdp_adjust_meta with -XDP_METADATA_SIZE (Stanislav)
> 
> V1: https://lore.kernel.org/netdev/20250701042940.3272325-1-yoong.siang.song@intel.com/

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

