Return-Path: <linux-kselftest+bounces-47269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D200CAD836
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 16:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C3FC308F23E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EED32939C;
	Mon,  8 Dec 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1H4I+M/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka5YX4f5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50064329390
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Dec 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203609; cv=none; b=WrZHgI33IfEyPTI1OkKtbY+Ys4E1CPCeimoTl7dZYxkEWhFAGpofchjhAzQ7qazgk9B2HsxiE7WDPtw3+QAHl5lkPqDuSYdiykSp+S5ETU22BMSg8RnKGOhDpI9cUcxdPFyk35zPZVq2FCNszpchk42T2LatqKVBk9X9c9IEAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203609; c=relaxed/simple;
	bh=PljNOTo0RHMKF0uIJ0F72Ecs4jdxizKa+DxYB7R6n6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g6OA31lXqYLEwxFSW2m7y1eK/Xs2mQdrQgMay7m1L4LdpQtQinrClvBWGG3bUpVVF3/r7U+QstRHTxJ22UCpiHEv3HBTFdk7N7iBptIvWoCUDnjogXA8UURjqujxDYJ+ie2eQ1wMmPp7T430GRKX2lxE2rRWPxGpKnmy4TUWIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1H4I+M/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka5YX4f5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765203605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqFvwLojx2/mzRD8U0g4XVY3xgE3qb7B+paToqsc4uA=;
	b=I1H4I+M/rg9ml3UjfRNYBln3qid+RWyNvFeu8pd26PnPmt+etW9RpyNPxoGGVmAQtmHfvG
	z0fOEm/7E5NBC6hL+yHosAiSmEly+blc2Y1SgCmT7Mjm1lxk2GYP4EuQY0CvV9FAmSZmbo
	VzUr11VTWgdkKV+qCCLoPd8Lq2X7Djc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-maA82T9CNGyUQKFevgXDhg-1; Mon, 08 Dec 2025 09:19:58 -0500
X-MC-Unique: maA82T9CNGyUQKFevgXDhg-1
X-Mimecast-MFC-AGG-ID: maA82T9CNGyUQKFevgXDhg_1765203598
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-647a2c3df89so4167577a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765203597; x=1765808397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqFvwLojx2/mzRD8U0g4XVY3xgE3qb7B+paToqsc4uA=;
        b=Ka5YX4f5jfrNDRzG2rT3gy2GzK7QDEveOuGHagrZ6jMxKwTBQC8+esc6+hk18f9E12
         fs/etNazPU2/ptkw2NyGTbH5mYH64CiVYbUMkbEH7qJTdjGSECv+hNHLqlTfGFKzxuiP
         wZ5gvzNtYPZ5F+Gtc2hce0LVpWg4jQZ1PM2erjx5UQkqN38ZJm5z20cUkUbbZY/SyCFQ
         KZS4jTZgK0dwymK47zTrTH8DcxLhKcJulOaofR+bNaC2b7HxioUXHDGpq7oJRVQPFS4m
         Kveb5ri7HTiJ7zZueRQwM7skdCLxW9p4jpcImfClRMWUhjFngiH44gdy399eRE1Ph61w
         5Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203597; x=1765808397;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqFvwLojx2/mzRD8U0g4XVY3xgE3qb7B+paToqsc4uA=;
        b=BAo603PTUMrgLVSFqI0USuf7KFTPOjAqs/GBsfC+32hyrn/DXYfkNsNGH+z1qZZ6aN
         3YCIcbVpwyhtoq8v7QtO2tavxOJ/0sJGFzUGi+F2oBrhq7yPIddKUdRGoZo3qkoJGQeR
         9YLd9TRGN3hoB7wFR1uKnSAem05xmODJKvkLIaOvUINosFewqxiZ/1Hq80K+wbSiSJEL
         r5L3cSsICMDNRo9G3UKDDg8s8SFWjliFce+RMj/eoIKcWcEJxE8e9Zoqc8AdxWC2RmuG
         AFp9YDSv9v7B4KlYyVUHbEzQt0glm1BLOWnQFUcRwVoQC61F2uDhHLLuQNWKCS8ZdonI
         Rsbw==
X-Forwarded-Encrypted: i=1; AJvYcCUDw3Qk38Hm3SzFByWcTUZn7dUgle09IFc4Qgvtor25NUbL1K0LFDWFjffIh/HQOKB4jNprKOznUMO20ABtaZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweXmEgdbqANk8w7CDYv5qtL2ytk8/I+K5kCCpL98jwmL8EmMzY
	VjHuN1+n4CTt1uVlUdF7VlQ7XKgmw7NmcQ9QPIPKUTUZ1NDZyaZzrglTljUwrRqPX3OjStcFSFE
	R6e+NxZ6nataIMhai7IWBrTku6/hcPcF0H66FzW/oUhVjzEJ/rsO9Xab9EVH643o1LNUWqA==
X-Gm-Gg: ASbGncsCdu44n526KfPhPvNlb58s52uHVhDtLIKTdr2YAemJQMpRJtiOGGfDB3/736h
	IIAEUYg9OiSGpJ7J7YbArmuaE0AQMEe6/GftTlj6DpaLrP/1PtebLFAtYKrGz2D5jMtwIkeEdYT
	bdwpIgC/HtlzHS18UjorIeVGQX7w6go4PXl5MVvUnAOl5kKc6M1MjH9LomCkOnjpQ9gMpeucNPD
	uonkCzgDQZ/IEd/Ezt5H4kZPcH2w+Ia6WXBptAM2/oAT17m5KZQjZzFOzJUbEdYLHWAPHZ6Gnde
	1Idkg/mOacZ8IFB2MbK7f0H2Ae5JL9vu0tb8EffqFbdLyFnoVE1/mjExi8I8ozenhwGJT26mVtD
	Ik68WA/vEDGgYu+5yarQKt7HlJubYzr0R8pxz
X-Received: by 2002:a05:6402:2552:b0:640:aae4:b84e with SMTP id 4fb4d7f45d1cf-64919c200afmr7274275a12.13.1765203597584;
        Mon, 08 Dec 2025 06:19:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlwGmklZz9ErsAvsYahFym+NTtrfrXS3XeSEv/0e+lK+B3wopu8o0DAiRcNsRnntzTB46a4Q==
X-Received: by 2002:a05:6402:2552:b0:640:aae4:b84e with SMTP id 4fb4d7f45d1cf-64919c200afmr7274253a12.13.1765203597191;
        Mon, 08 Dec 2025 06:19:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b368de06sm11276090a12.22.2025.12.08.06.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:19:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C3E5A3B25D7; Mon, 08 Dec 2025 15:19:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kohei.enju@gmail.com,
 Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: cpumap: propagate underlying error
 in cpu_map_update_elem()
In-Reply-To: <20251208131449.73036-2-enjuk@amazon.com>
References: <20251208131449.73036-1-enjuk@amazon.com>
 <20251208131449.73036-2-enjuk@amazon.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 08 Dec 2025 15:19:55 +0100
Message-ID: <87o6o96ook.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kohei Enju <enjuk@amazon.com> writes:

> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>
> However, __cpu_map_entry_alloc() returns NULL on all failures, and
> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
> As a result, user space always receives -ENOMEM regardless of the actual
> underlying error.
>
> Examples of unexpected behavior:
>   - Nonexistent fd  : -ENOMEM (should be -EBADF)
>   - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>   - Bad attach type : -ENOMEM (should be -EINVAL)
>
> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
> and have cpu_map_update_elem() propagate this error.
>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


