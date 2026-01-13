Return-Path: <linux-kselftest+bounces-48849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE956D18157
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 11:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF5943067F54
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 10:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB79831352F;
	Tue, 13 Jan 2026 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLxVIXLS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/BldoKD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213828488F
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300503; cv=none; b=Dz50GSepTWp+ooR5pK0QmHwOBpOeoHaPvMRIN9dYFX1XfFShh26A7eIVN4R4bnB1gfajJvq5hkpsmSPkj5miDi0WFRt5o0MZE69+fQklpx7FZGa1WMlBDFgrkQF9A6j3vLQ2HTwq678qfNNOzMlf+pRruDG6rPsFFtBahvUWkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300503; c=relaxed/simple;
	bh=Ce/nJEZGmO6L0kVT9kwF9kuqtSrijP123A9vTXnzjo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gy8PAXCLxO11VG2ejc6iHfzpltTevIhH6C+EBRSbFLF7FYEUX5WPaoqnOKgd+JM6Y0+RP3PPbWP1XIg58TNJSWz8Dsj4YCeMxJ/wIqtBibeIqz8hsnFJjjSH/M6MKpTja3vnzYTi9sAit+8xs8MnuzaQg64xjqAWoR+aAR72X9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLxVIXLS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/BldoKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768300498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp88EAkvfg7NazK48Kg9GATXkhl8V5Ket6LfkoWWXus=;
	b=hLxVIXLSIx82KCrBqxVHv7uGcuTpw5x0BoTbOcaQUtxgJXD4szDVENDVmSLj3INUxbszTt
	Mn7NeN8Yks00K2rEH5rveW2iLZrGVNuc78gWxhMzKLU7jilp5O3mJRKuQTBD6szadNM72j
	C1z1GgF6hSlxBrJMnuFu9this8jKumw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-kuwZdNcsOISdTVLJAvnWOw-1; Tue, 13 Jan 2026 05:34:57 -0500
X-MC-Unique: kuwZdNcsOISdTVLJAvnWOw-1
X-Mimecast-MFC-AGG-ID: kuwZdNcsOISdTVLJAvnWOw_1768300496
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477563a0c75so45450165e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768300496; x=1768905296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rp88EAkvfg7NazK48Kg9GATXkhl8V5Ket6LfkoWWXus=;
        b=I/BldoKDFrmM/AO6uquFDiuDV89YIRCDuCy+/EISJHa8n3W7Qy3XKx+h3cpF55rgS/
         3k+/857zy66cTkNp3ajj5M/k+57No+J/t52KsY4k4Iw3mQEZtktNa86w2HRePSs4k3nW
         StyJVv/a1fHz6n6EerUaD/TTE7fuh+2LWUIAaV9eHAeDPrOMpSQpOtdnqvchwMTj+336
         F5acjg1VpS1qdlOO1Dw/hPb4EDd6Vn6o4Yg3JJTWmhmFlgFfIwp7TVWD4y4fCbd9jzD6
         +YyUsQO2gj2pfTcxoTNfNbTWaTrHXS6OLvHKnRS+onyFaE+me9f2MWkFkaI4ROJjdule
         QOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300496; x=1768905296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp88EAkvfg7NazK48Kg9GATXkhl8V5Ket6LfkoWWXus=;
        b=cBsBpXCNWDXGA12MnQxR8AOuZFE9tssg7kGPtznLmDe5teI1QiEhH39Z0hMCXa9l7T
         EFpbvpritK7eaITOJccBlqFq2vbWVvjqVgcQ/ytD6fa6Xx0j/tTksr4zuc6T4M3qLjrh
         090F9KWxBr2Enhp6cut8WR1g98OiFNxpwRl1aeFVmeCTF48J1FPFZEWGu6Us/uSMztMP
         Gd3iKU8evG9DIuUg2bh/ec4F7GuMuANUvtBJz9wrsBYWRO4YreyuhMmhoBNKCpM7YBLG
         o8RRAATcjKrLPIzHkQV0KrIka5Xfmkkp8lQEI8zZzHCQpJvLcb3VleH/mwq9OAqFmiPW
         j4+A==
X-Forwarded-Encrypted: i=1; AJvYcCUFiHL/5Mm1KVHCWpE9jbaCKt8Xyrj6VuDwa/7gget9cs60ZDaqwNl1HRXt8n+Ts/TGGlyDB/8OoMB5bA4ncjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzM10Dq7q+0ZQ2dBa3g2JvPsvuIc3iLPDKW7OyAvqhb/suLP4
	qD+O9zcaXsw1LZCCAO51SEsvCG1sW0R4KXq3ulgc/aCnNLtYAqbvf4Algew0YjkJMJjjqIoVkSW
	mLrzBjdsSRvBNiCZkZQ1zS/r4T5/jE4/i3ep08yg6UeuMCmkPIGBmh1FwLpA8ph27heo57A==
X-Gm-Gg: AY/fxX4VqPlktPMtYKMroYooC9tvwTHZcwUAvqeHVS4y4DFIuzDIvVJwgeNUTyqfSjI
	sO5M0HOQCrqS0PAptRVKsDz3uwmDOTcXhzMlj6bmW8XkbBb0xE1ody/WePcTTedi8dPuRW9goEP
	94i0VmORdhnQS/eyzJChHeCZkQ18m7I9l4ZiiVybMWSCPGx9NWhYw5R9xrXPDnX0jvTLjLdl4J+
	wMgN4fEjI6Y4EDWZm0oH1ewM9CDIkvg5VCmrVtAYb57a9p/JfgCp7t4ar5kyDBtG1Lgb/pjqFfm
	HWssrZb39u/xlTGiRQlKq11X7w3IJfLswl+81AMXJE8575wdMcYDzBYZfTeO6PEvYztqvAdi+sB
	juj0wRWLDqfZd
X-Received: by 2002:a05:600c:3b1f:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47d84b52b9cmr217868345e9.34.1768300496046;
        Tue, 13 Jan 2026 02:34:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH39g2T92Y4/kmCEQ96bzsNq0jo0zpd85gtHjgmQsLxOO+v0ajp2k6EhijDpMlzAG7BPPZlZA==
X-Received: by 2002:a05:600c:3b1f:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47d84b52b9cmr217867695e9.34.1768300495534;
        Tue, 13 Jan 2026 02:34:55 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm414015045e9.7.2026.01.13.02.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:34:54 -0800 (PST)
Message-ID: <6d4941fd-9807-4288-a385-28b699972637@redhat.com>
Date: Tue, 13 Jan 2026 11:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 8/9] selftests: iou-zcrx: test large chunk
 sizes
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com,
 io-uring@vger.kernel.org
References: <cover.1767819709.git.asml.silence@gmail.com>
 <bb51fe4e6f30b0bd2335bfc665dc3e30b8de7acb.1767819709.git.asml.silence@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bb51fe4e6f30b0bd2335bfc665dc3e30b8de7acb.1767819709.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/26 12:28 PM, Pavel Begunkov wrote:
> @@ -65,6 +83,8 @@ static bool cfg_oneshot;
>  static int cfg_oneshot_recvs;
>  static int cfg_send_size = SEND_SIZE;
>  static struct sockaddr_in6 cfg_addr;
> +static unsigned cfg_rx_buf_len;

Checkpatch prefers 'unsigned int' above

> @@ -132,6 +133,42 @@ def test_zcrx_rss(cfg) -> None:
>          cmd(tx_cmd, host=cfg.remote)
>  
>  
> +def test_zcrx_large_chunks(cfg) -> None:

pylint laments the lack of docstring. Perhaps explicitly silencing the
warning?

/P


