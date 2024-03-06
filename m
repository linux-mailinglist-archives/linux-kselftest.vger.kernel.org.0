Return-Path: <linux-kselftest+bounces-5968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E85872CC2
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 03:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A5A1F24D6A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 02:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85317DDD4;
	Wed,  6 Mar 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="tXzN2w3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC03D529
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709692136; cv=none; b=ROy3bBL3YAjIPHlLVlKrpW4i8JjolAuIV1rMkUMCsyI+MQjm3rwJAKlcfmJ1HcG6ZuUvJ5NMa6+wDwQlqvwE3CaOkpHDQu9i+GBGaP/zcb2ZRaEV695nCnsHSCI6aFHkE6rRDp87+86YlBlyPe2N5kIHAmW6Lykaly1JFhq5IU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709692136; c=relaxed/simple;
	bh=m/4/IJpnreuZGBCjDFZuh5CJChe0Zp0mf+/fUUyVNyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6mAvMKijx7370rp7k8oS85jrUZb3FzACVQdKmmkasW0Y2DVYAyUXCKtNJV74ciHmWjFkOAm72DaYozt/dMFhZZQ8vjyMGqfFaQsCIll5rg47Hy5smeGdA+fdlW0P0yD3z8JTQGTE5Abx9q6ZITB/P/Pi/+k5hX7vTE7GChguw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=tXzN2w3m; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-220a0cacf9fso139426fac.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 18:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709692133; x=1710296933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9CloCqaM+25WoaR2YknpneBnZb2s33DuZ5EXKAJgUk=;
        b=tXzN2w3mIA42+kxiYmI+IfLVus4l/QCyp13ANiYCaN2AX0ORMGh8eFZyBZrHwi5+ui
         zNdIkjkiBk4A/hgNMWzvhoZCVZgub5eQsDzmq3IH7LIsjQRrvMfh2CRMGVf8ialf+Rus
         nghzApmYQfTLUlMYRSXbb4x6B6akvEuK4rNb6WwQoK4aLQOK0EG+oA4Ab7xlOOeaibDg
         nJSUHhZ9ODRVCyFEvPMgBTKDGO9DRMtkgCfGe4EIFAsUKHZm1wpITxZLA3udaKd58MVY
         6IouXTOA0w+XUEzqhiMWwJtLgVug5qR8dVcL0sonjarAz3MYOIYP8a1XnRJ4sV8i2/vC
         ncEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709692133; x=1710296933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9CloCqaM+25WoaR2YknpneBnZb2s33DuZ5EXKAJgUk=;
        b=Lc1F14lwQXaVWZzTFLggBOkwToltJqdzRXcjBPu3Xxj9B2WcrpyL46FiFJA+YUJE8L
         5mNIysO4USpjFHMex6FVP4ONnzlKAaG0qxVQGfxYILYjwLS4itxyaNFLC98ZsQKZcqLO
         2fmlLCUU76y5WL4/066VbUTs+gUfnmS9hfC6qCnrOAIaqUr47nWtdmwZjRqsGHgAAXU/
         vczK49UkLwt3w64f+7hnWUc9EbdojD5S3J7coXHNoz9dtwFFj0HM8umuS6pUm2R4ekQC
         LydVZO8YofpOR7f7+q2f9RxsgGwzpFq24wbxa6+ZbwEcwFNESFC5cjHnYCjfLbhXPXB2
         bILA==
X-Forwarded-Encrypted: i=1; AJvYcCUqbqE4k6znOCf0KX2wKKRus4IQOOFbaKO0iXJimS9iclpl7cLAGXDWNjImEmMK6E+Syk12N/XVPKJSpH1hMfZ1l4CIaBUxDK4CBBZq8gI/
X-Gm-Message-State: AOJu0YyC6lfyimvwTSnJl7/1Q1xvKDa4szbolgr271xCLjenV3wmwQGe
	RrXA+MkrFNJAjV80b5PxH658fQkWFR+uarTOV0AzvbIJtln1kfsJalqbFTZkQxA=
X-Google-Smtp-Source: AGHT+IHKixed8Mkgk+0mpRfXfdBzYVdPnWZ0ptxrRYAk7Gk8YnML1zfyWGAr7RcPhYJE96tLslzelg==
X-Received: by 2002:a05:6870:1786:b0:220:8d17:6ebd with SMTP id r6-20020a056870178600b002208d176ebdmr3863595oae.42.1709692133363;
        Tue, 05 Mar 2024 18:28:53 -0800 (PST)
Received: from [192.168.1.24] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id x35-20020a056a0018a300b006e5bdc19842sm7873904pfh.73.2024.03.05.18.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 18:28:52 -0800 (PST)
Message-ID: <383c4870-167f-4123-bbf3-928db1463e01@davidwei.uk>
Date: Tue, 5 Mar 2024 18:28:51 -0800
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
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240305020153.2787423-10-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-04 18:01, Mina Almasry wrote:
> +	if (pool->p.queue)
> +		binding = READ_ONCE(pool->p.queue->binding);
> +
> +	if (binding) {
> +		pool->mp_ops = &dmabuf_devmem_ops;
> +		pool->mp_priv = binding;
> +	}

This is specific to TCP devmem. For ZC Rx we will need something more
generic to let us pass our own memory provider backend down to the page
pool.

What about storing ops and priv void ptr in struct netdev_rx_queue
instead? Then we can both use it.

