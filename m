Return-Path: <linux-kselftest+bounces-5970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92987872CF1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 03:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B7EB24880
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 02:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B9CDDD8;
	Wed,  6 Mar 2024 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="RH95CX61"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C37D531
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693220; cv=none; b=TtaZXATw20YcFtwFcIKR5nYTZh99JV22cRXTjYuBNSTg48Z9zENLd4hJ5kcH1aTP9cf+7IZroarrdanrTuRkrT2ij8npk//Qjv7EqmP7trW8Te51zhe+TbRFXNKJ8ztErGBx1FH/NHB+pLH9O7mtNG1Q24FEPKnlrAmf5l6Mmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693220; c=relaxed/simple;
	bh=vgsULBah38khq6izlM1CG5mUxG895JBR5VzGpBHy3FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfPnDLXuNM9Q6Z4rHcgXEkEQJ2jtvxjsy+hAM9UqEy5Y6i5NEC4353G9XNGPIOa2K7oymoxEWfdXmeybh8tcAQ3TxzajCj7tZPjhLgWd9VJ0XoScd21SPJxx01NeNRTBkhtCVQkgt6CeMaUA/SGjVc1AfISfOTVBSS9emkFuQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=RH95CX61; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21fa086008fso2855682fac.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 18:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709693217; x=1710298017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/AZhM1ardFsAGX29qTgbwwqhyfXbQstP0cTfps3sJk=;
        b=RH95CX612YwxRLTNIu4v3zLtCu3aw3P0O5Xg9O0RfH8Z/hp9seSg/nGkaua/Aec2mt
         qGI9bRFbbTxabTtQi3xGtF90fQzVxSqwH1lS2Rg2WmjU6EpO/A8STxSid0/vLmD7Apwu
         hMOkSWTa8K6z8RDyvx1Vdz/l2gw3EHdLT4pYT/IQt7zxAH3pm4HvAmu1DK0YccC2v7fX
         pAqLegabU1gggT7hI+WjI4Fp5Lrw9hf97XcshLS3mEKtKOeLo6DVidu5BryVC3v3u7BU
         925rceimbjXK/QAEgca22Ma6vB9fB9+1j7ehWInrT4/BpX2fVfaPN5B9GQxtvuXasfbO
         Bp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709693217; x=1710298017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/AZhM1ardFsAGX29qTgbwwqhyfXbQstP0cTfps3sJk=;
        b=osEyViPbZU7Hoq3BcGnoqjhetPqDAzx4YMHqZWmEDI2vht5Ogm8GSXL+jbiU8NKDqh
         P/hyjzvWnugu73OM2k+cKkwEOg31xN8n+JvbqG6y9+s8CmUUABe7c/QENuxlonVWHs3p
         9hSNFDIUk3okzBukP88Gyf04GB+3pAGX5ICGfgIvd4Bv/EkvmvS9ok6OfVPgGs/dtges
         gm/34PsKIrUmpGWVZ8e8n3XzkOcT4msRF7flg1FjMUXkimBa7KgfQ3djdLIJ7RORyXxX
         xUqyk2D4M7T8zV7NiYNNrU0QgbGbeV9VfethBNWIYwk/bVUAx3jxqADsyzXRkpbz1ISQ
         NahQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPjgXT0XL7Z+tHgHswP3XrBjpAzK8Zj2S8FzCqEDA5GrVhac9SwA8YWiMdHrEuq81os0R6zWXoE5uqACSKyUbxNNz6THLCwx9//vDKgcCF
X-Gm-Message-State: AOJu0Yxs1HNI+w7F60bxCh0zW/hhjiCPTlosy6CfqNqFkklkf9rswxko
	FzKK8ylZnWUF5HcfjGQuVzxsP3ogBYpHzxx9EnyLpQ6N7y8qK+ObpI0tyPqfi6Q=
X-Google-Smtp-Source: AGHT+IElGkSnHiGxc2lEze/zAWu5r0LLRyGowQ+sBx3sowtn7O6N/+zrQ759eeI/XO5+QBu0Nsc7Pw==
X-Received: by 2002:a05:6870:461b:b0:21e:4a2a:f060 with SMTP id z27-20020a056870461b00b0021e4a2af060mr4180063oao.13.1709693216865;
        Tue, 05 Mar 2024 18:46:56 -0800 (PST)
Received: from [192.168.1.24] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id r16-20020a62e410000000b006e46047fe04sm9667498pfh.204.2024.03.05.18.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 18:46:56 -0800 (PST)
Message-ID: <6562b8b0-6cc0-4652-b746-75549801c002@davidwei.uk>
Date: Tue, 5 Mar 2024 18:46:55 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 09/15] memory-provider: dmabuf devmem
 memory provider
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-10-almasrymina@google.com>
 <383c4870-167f-4123-bbf3-928db1463e01@davidwei.uk>
 <CAHS8izP_PzDJVxycwZe_d_x10-SX4=Q-CWpKTjoOQ5dc2NSn3w@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izP_PzDJVxycwZe_d_x10-SX4=Q-CWpKTjoOQ5dc2NSn3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-03-05 18:42, Mina Almasry wrote:
> On Tue, Mar 5, 2024 at 6:28 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-03-04 18:01, Mina Almasry wrote:
>>> +     if (pool->p.queue)
>>> +             binding = READ_ONCE(pool->p.queue->binding);
>>> +
>>> +     if (binding) {
>>> +             pool->mp_ops = &dmabuf_devmem_ops;
>>> +             pool->mp_priv = binding;
>>> +     }
>>
>> This is specific to TCP devmem. For ZC Rx we will need something more
>> generic to let us pass our own memory provider backend down to the page
>> pool.
>>
>> What about storing ops and priv void ptr in struct netdev_rx_queue
>> instead? Then we can both use it.
> 
> Yes, this is dmabuf specific, I was thinking you'd define your own
> member of netdev_rx_queue, and then add something like this to
> page_pool_init:
> 
> +       if (pool->p.queue)
> +               io_uring_metadata = READ_ONCE(pool->p.queue->io_uring_metadata);
> +
> +       /* We don't support rx-queues that are configured for both
> io_uring & dmabuf binding */
> +       BUG_ON(io_uring_metadata && binding);
> +
> +       if (io_uring_metadata) {
> +               pool->mp_ops = &io_uring_ops;
> +               pool->mp_priv = io_uring_metadata;
> +       }
> 
> I.e., we share the pool->mp_ops and the pool->mp_priv but we don't
> really need to share the same netdev_rx_queue member. For me it's a
> dma-buf specific data structure (netdev_dmabuf_binding) and for you
> it's something else.

This adds size to struct netdev_rx_queue and requires checks on whether
both are set. There can be thousands of these structs at any one time so
if we don't need to add size unnecessarily then that would be best.

We can disambiguate by comparing &mp_ops and then cast the void ptr to
our impl specific objects.

What do you not like about this approach?

> 
> page_pool_init() probably needs to validate that the queue is
> configured for dma-buf or io_uring but not both. If it's configured
> for both then the user is doing something funky we shouldn't support.
> 
> Perhaps I can make the intention clearer by renaming 'binding' to
> something more specific to dma-buf like queue->dmabuf_binding, to make
> it clear that this is the dma-buf binding and not some other binding
> like io_uring?
> 

