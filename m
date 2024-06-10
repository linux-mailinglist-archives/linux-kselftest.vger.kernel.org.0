Return-Path: <linux-kselftest+bounces-11517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808F9018F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 02:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B791C20F28
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F7315CE;
	Mon, 10 Jun 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="eaS/rB5p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C01852
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717979279; cv=none; b=QCDgxxm72a8LVKWMle0H9XMaF83zE+EMFONdtJXubmBcMIEQ8q/z2jxKYAHx3SljOrfMGTH28kh0YBdFTBYMg787taecJJt9HR9Bw1tpzF+dgHVo/frRXK2RyfU4R77LDwsj5xsmKRDDlGl68d3b8HAqYZ8M8g+kL+hfVOl3kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717979279; c=relaxed/simple;
	bh=MhpwXQPEWuldXab2yRt6lwaofFGFqOHBQxOKwwMzkWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prlKI0dqTcJvnfzb5Q34nNP4hjKAtkdbWev+w5GNawBE90I6+48cl1ZRwYwmZKvpOqpP9LUPYayF5rFsFnbN91KESJ5CN2XkxudVjDMn3hKrw9VZ/xQZQqsn24eJTVwDJbmLgNjN85wqel08TagC2uxvUOuXuEGzUid4OBH7/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=eaS/rB5p; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6819d785528so2522193a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Jun 2024 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1717979277; x=1718584077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhpwXQPEWuldXab2yRt6lwaofFGFqOHBQxOKwwMzkWs=;
        b=eaS/rB5ptAbHAU0q7qdhCVXxZ7lbplvWL9hU4TV8HO/se05eThjpH8FgH1E6aS56n0
         rW/FP7pOSyTxC+8whzwcsq90dLgrS0QhatoUNkRaMF2tATXfBuMr+yUVS6o0AfoXCkNB
         TQ/NutpDHJ4gJiMiKl9PcUGQqkiHEQYofisKHAoQrKewsoipTcj45F4gmgOrwRNPXnAG
         hLrgEbuXXS/YMk9seiceNyXS95VU2N5n+4a/vXtDWKNahfG762KAc+Imp1kvFGXC0A+p
         MU7pTWE7PVbAluvuq5FFXNSY19XM4DoyPVbkO2q5ZxDdT0TvSqVt3YTSZnHaNO60Y+T1
         bMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717979277; x=1718584077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhpwXQPEWuldXab2yRt6lwaofFGFqOHBQxOKwwMzkWs=;
        b=bSxumDy5iUA+QoR70MydEzb9JclwiZV7P7XRVQZvwlq4EisfKcd7OCK/13nrPvYWfS
         Zj3hAxjS6Qec1l5VUX/nAtoH8Jmos8aNcc1k2hNyEgVX/MCtGO3Xe69PjkhUytEFlf/f
         eGlKOFyselbFp2v7dkQgQxGyuofS8JojG89QaS7+SeshnUKuIQ/XIfLFb91WJ7wRrVQH
         +tGMg808vYo/BgDhge3A6dAEFgQDVeHZndA2pWzMDlMhXtQ+DjviKu7t7AFmtFZ0T3KJ
         2sUVaVORuvnsBFKEtKqsDNq+HEwCLlJnqbhA/6PoIk9zljt3a7FhRsEz4k2uGOPfigok
         9LfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5YKBVWCHDH26Me4CI41AyR19UNkiLD6Fs9C0s5iWTkTaKN+yhOlJ+OdlQ3HJoNS1UEabA/tTYrZiL5iyAO8cq0Zu9Ct3YfPkLXogdUxJQ
X-Gm-Message-State: AOJu0YxYGu0hydPQ6sEjjBjpI2m7TOadc9kUIpEDWGIBMORSlFWHhX+5
	DgxJodIadYKDscyg1EQrAVAyMPyo2JrXERE4NYU0zVf4qnT4dUA48V9RrCP8fCA=
X-Google-Smtp-Source: AGHT+IHFUY13EgQWeWpod8cMzpAhYoaErdO5QtBiSVL31xjUWTYCgJQDuWf1poRGpWIptTmVDcqXrA==
X-Received: by 2002:a17:902:d4c3:b0:1f4:a36c:922c with SMTP id d9443c01a7336-1f6d02de0d6mr98614085ad.20.1717979276488;
        Sun, 09 Jun 2024 17:27:56 -0700 (PDT)
Received: from [192.168.1.8] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f162sm70228185ad.61.2024.06.09.17.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 17:27:56 -0700 (PDT)
Message-ID: <8f7bc361-aa92-4d73-b276-f2d6bb4fbd6a@davidwei.uk>
Date: Sun, 9 Jun 2024 17:27:54 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Content-Language: en-GB
To: David Ahern <dsahern@kernel.org>, Pavel Begunkov
 <asml.silence@gmail.com>, Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-07 17:27, David Ahern wrote:
> I also do not understand why the ifq cache and overloading xdp functions
> have stuck around; I always thought both were added by Jonathan to
> simplify kernel ports during early POC days.

Setting up an Rx queue for ZC w/ a different pp will be done properly
using the new queue API that Mina merged recently. Those custom XDP
hooks will be gone in a non-RFC patchset.

