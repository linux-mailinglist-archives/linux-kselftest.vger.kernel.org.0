Return-Path: <linux-kselftest+bounces-12571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE76915790
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 22:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5F4284AB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 20:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094E1A01D0;
	Mon, 24 Jun 2024 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Och5tVUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6913D88B;
	Mon, 24 Jun 2024 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259741; cv=none; b=VUeGPhNT2dTzGKsAed941QNEzHaIpNnlkqg3hT7kbT8NrnKTB0w+gyKw0UG4Ju05NRp1uQn05rFRsY9z2mc2WlkoWuJY1xZzDTfb8CXddy8WUCDj2IUxtzF4PCA5YUTvVQ1/5ezS7yGBGn7Rb/WBjDCJxTcX/wtb30Xzg4cOvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259741; c=relaxed/simple;
	bh=v9XA/acd7GIFg6atm+pVGycwFmXdg3oXP2esFHiMfjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZ6o/h+HIXxoNmSpFp/AfLYrDXolLgvOX0X74byiTCHDbPoCL3tNR3wJtCgX6VgeHsa7Rhf51e6W7sJhuWHrrEZxKotNDbcQDLI5WlddQMY+EZo+rhCgSIxsnOps0s8Z+FqwmudG5w80JvuOmEwRpqoO/RazI0v6renn5AtTT/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Och5tVUO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9b523a15cso34035605ad.0;
        Mon, 24 Jun 2024 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719259739; x=1719864539; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o3qBFF/GlmL4MBB59sv0DAYcfMRRvC1IpCS1LsZtTJ8=;
        b=Och5tVUOw/PP7O+e6ofL4cpOTlGuNRcSgsobW9jwvEkuZVYSobwpWm/TQUw529582Y
         JaNiOsVIOQB3uPFIE79OJz3MKUEH2GUT2x8ve/NjBp378YF15F4va2OCPM72gju+0MEV
         IM76DhN1wvwP2WktgUhgsgbkmbY063bvTn0LBAng63SZYRwVjlqJUW/nD5XzEaKmosKi
         hPSfJk9FmVKzC2Ny/nxVlSi8ne26Sxem/K8gTOv/buWMVHYHwwmp8zEx5n2VZkQW05QJ
         hfWRWbwYRmk8dRCHBwo/FlEpYJrabzOfBUKjM/LgLVDuM0P5ROlva9fjajJyBPJg7JsV
         FHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719259739; x=1719864539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3qBFF/GlmL4MBB59sv0DAYcfMRRvC1IpCS1LsZtTJ8=;
        b=DP2+CNM9K+CVcwjKzwGNJq3MFR2h03q/45UBePWuqj+j/LoEtG3vSdhv/YOqQ9N5J4
         CKCOekgVoj7OJMhjxnEWB9pdHSt5EEfAVkub13fi0RgmUn3ts6fprk0laXl5DjkLm5hf
         Rvfq4/O6za2Nz4U3DXKB92EOgVLr2XBo5bfjjbks1EvHvQ6QTAmAPuorRZ8GdAwAJSdB
         cHxte2oBSzSFF+ZkGzfmAiU2hgCzsPhUw7syW5hJ4vpFo3NJvnLGvtOZzwfqTyP9ywDK
         OQ7V9vAaqoXG5SZpkTg1fk7Qxx9fRujsg4v7+bS6+UJX/v/5lkGgUkEqgQ7KhDmdxIIq
         RGFw==
X-Forwarded-Encrypted: i=1; AJvYcCUOxfdxTd2u5XzPrFDM0FoVX/I5DzL7DPrjN2+97wscAllZG7YO5aEuO3JXyc/F7Sxr1eZ0hD3T6MadETfLaozb66QkaPciJ9B2gosoh9F+von3tY0BnoMajqjdQ26C25VnDvWMAXZgcu5epSuujnftXBIuwXr7cEd8mcg4
X-Gm-Message-State: AOJu0YyoEp5yPIG90/HPH9GaWcp/P85FJvcnnmYE4BObx6FDIQO4wmsd
	ji/YtiexRwcMnRaitPzYTl/G1i+bn8DWzkJ9wMhohnQeNcPdh0f/
X-Google-Smtp-Source: AGHT+IHtqGhA1oGSsWRALy10Ivk7ZFyIpcHu3DiUYekvGcHMPaEM0WO4ivSWF8I1IBNqgLqkMWZK9g==
X-Received: by 2002:a17:902:f688:b0:1f9:fb0f:ba05 with SMTP id d9443c01a7336-1fa0fb045f7mr91600865ad.26.1719259739328;
        Mon, 24 Jun 2024 13:08:59 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c6134sm66716075ad.143.2024.06.24.13.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:08:58 -0700 (PDT)
Message-ID: <048c6575cb97baa4b7022a1b0a061fa0aecf3db0.camel@gmail.com>
Subject: Re: [PATCH net 3/3] selftests/bpf: Null checks for link in
 bpf_tcp_ca
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>,  Jakub Sitnicki <jakub@cloudflare.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David
 Ahern <dsahern@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>,  Mykyta Yatsenko <yatsenko@meta.com>, Miao Xu
 <miaxu@meta.com>, Yuran Pereira <yuran.pereira@hotmail.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Mon, 24 Jun 2024 13:08:53 -0700
In-Reply-To: <0f91336b3f464b63ef2f223bba7759adc81affdb.1719234744.git.tanggeliang@kylinos.cn>
References: <cover.1719234744.git.tanggeliang@kylinos.cn>
	 <0f91336b3f464b63ef2f223bba7759adc81affdb.1719234744.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 21:27 +0800, Geliang Tang wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index bceff5900016..8c0306f344e9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -411,7 +411,8 @@ static void test_update_ca(void)
>  		return;
> =20
>  	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> -	ASSERT_OK_PTR(link, "attach_struct_ops");
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> +		return;

At this point the 'skel' is initialized and needs a call to
tcp_ca_update__destroy(). Please add a label at the end of this
function and goto there instead of 'return'.

Same problem in the rest of the hunks.

[...]

