Return-Path: <linux-kselftest+bounces-27556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6294A4552D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E44188B2C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 05:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E64C267B75;
	Wed, 26 Feb 2025 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfAREa7N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4F2676DD
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549569; cv=none; b=GtupLXkVb/l3heZy9LOId/eg4R/0cVQ2/MaolILjnyWxQryOSYw2UdiYyHozhNNNWU9nCa9/XqBMJByUlsJQPW/n83gw6H7JxSI6fDxPUv19g+uk2gXvMhV3ek9ORxlmA406UHbyWX+0k6avTEoFQ0kZA1+b+3Evgg1EtMdKoFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549569; c=relaxed/simple;
	bh=m7gnNaSnVIQnhwXaGmMm7ApeqEyKQEEPJJKfMSkYWew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kg/J8qxl8it/u4zZ9bvedS7G5z38CREQJtilVrlzkNv44TE7WFxkisYu7W6EyKlbvpH/7NWeNSowev22G4FUzJnO2HgX5Y/gyN3EdzZePZl1QZSumYN2mFxKiDtKJLgDeXdtB716lDd/h85nZHwXblzlx5UUkgi/oKonD8Z1Bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfAREa7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740549566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7gnNaSnVIQnhwXaGmMm7ApeqEyKQEEPJJKfMSkYWew=;
	b=PfAREa7NjUAVOjJaRDNGG9uKIUR9M2DzXN5lsVlMkn9lOsJXJmfzrVJGDxQSeO0DTnxDvM
	3rcdE0k7jhAunAEupe23L1YvdBq5L8+2kF6n3HqQDD2BuZh6MezaoA2zIMcXeHu6SgUQFP
	qXwN6eqA8feelBQktZYdcEo72GuYBmg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-Rk_iY5GrMYSVmfibSr8aCQ-1; Wed, 26 Feb 2025 00:59:25 -0500
X-MC-Unique: Rk_iY5GrMYSVmfibSr8aCQ-1
X-Mimecast-MFC-AGG-ID: Rk_iY5GrMYSVmfibSr8aCQ_1740549564
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc0bc05c00so21000861a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 21:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740549564; x=1741154364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7gnNaSnVIQnhwXaGmMm7ApeqEyKQEEPJJKfMSkYWew=;
        b=n7ZPqOro7le6zPS0NeW1qeYiToy9tDqIkyGAB9zduUgO4RcAJ6PM118vaRgEyIhWP9
         +n58jP78v3y4nYD5K2rq5TWJ6C+wz3BOBCrulShLCAGucvxWJ1iPVQ22Md47nobKcQOJ
         EGQUWFphotzmjWMJm3feApoUUqXbT1PsVvy6hh5WLhzmBTxKhLjhVzTxHmji0igdtLa9
         qqDVqnoN3jMk76lUpgBenbbC4KcwQhrJpH6RQXILbt5HO1meIeQ2mU7zf7ZqJ6e52ko1
         nDaluiuMH9pYpSh/IW0EhjzH/P7iDaAXFCwM+C5xfHEy/0PBeg7icL9FNtiAQjUTSOWn
         mDnA==
X-Forwarded-Encrypted: i=1; AJvYcCV2DIycWgXu/s+Zb1N4epdegJHqNUqUPROs+3jhVDV73WScWJjx4Ws0elhiyhux8Rhnois7r2NUfunUCLLL6KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOL+Jr9ynD8EsNp/Rj24k6n0v7t7L4agHa6YG/VqFauw6hEcQ
	7dj4Lweks1UrrCTm4LUMHh3+Zdp7iAP1nEQ4RUH4MqJBn+3ls++MZHm3YcoeuPEQv+bYi4Zn5ON
	7QoGftidLSVMIm/14ID+s5GzOCpmiGGGFnppzMSeARSbt7i69IH4KBsTFT2mwZHI+/oLTCsNtcp
	FcbsL1L5PPZJOSqpQxnY6vbDNLsSRGgTu59GLgHXwD
X-Gm-Gg: ASbGncukW7ueP/BkUlHT0f9hX4bo5D6iEc8dSqbWhYHPiGNaPXxmXbAd9Tue1R2Pb/6
	JFoNiwWkZJuXi2NGyFHLlfShFP8/9G+/mm9I30rZXSIw0fqJgBQFAxhyAGq0CYqjwyHDOTsK3Pg
	==
X-Received: by 2002:a17:90b:2803:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-2fe692c8403mr10781871a91.33.1740549563986;
        Tue, 25 Feb 2025 21:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjfukw25/3dRjwBrKqTgNYjNEca8F88lv26UtFCag9qeKPB/TQL+bJT6mEpFZEyRdR+HxO/f/07hSLXK/EZbY=
X-Received: by 2002:a17:90b:2803:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2fe692c8403mr10781849a91.33.1740549563668; Tue, 25 Feb 2025
 21:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de> <20250224152909.3911544-3-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250224152909.3911544-3-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:59:10 +0800
X-Gm-Features: AWEUYZn3sINGV0LaU89f2SQBC-EkP65HckbvJbjb0aMWfaIJ_G6VZpbaC4mxxbg
Message-ID: <CACGkMEt72ZwDQUUDPUrxiEJQLTWBQ25pP0wCO-FrZ2tZDj7itA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] net: tun: enable transfer of XDP metadata
 to skb
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:29=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> When the XDP metadata area was used, it is expected that the same
> metadata can also be accessed from TC, as can be read in the description
> of the bpf_xdp_adjust_meta helper function. In the tun driver, this was
> not yet implemented.
>
> To make this work, the skb that is being built on XDP_PASS should know
> of the current size of the metadata area. This is ensured by adding
> calls to skb_metadata_set. For the tun_xdp_one code path, an additional
> check is necessary to handle the case where the externally initialized
> xdp_buff has no metadata support (xdp->data_meta =3D=3D xdp->data + 1).
>
> More information about this feature can be found in the commit message
> of commit de8f3a83b0a0 ("bpf: add meta pointer for direct access").
>
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


