Return-Path: <linux-kselftest+bounces-9614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB28BE895
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F1728D751
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437416C69A;
	Tue,  7 May 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="opveKBa6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CC916C685
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098741; cv=none; b=YFL0Jq+zNkiKUmW8xnkrt/rhk0BwcwWag8MAVOcx0r3ZpN4CK0jJ1j//YtYQRcFxhbAbHMcjlou90eSHBQOVxnZTS4EVeZbR6zA43AoKRHJnQdPPWoX7NdNqq+UrTcFs2/ixrdCqaYEQqlXUNp/OhqDmr4292nRGS27PqIOL0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098741; c=relaxed/simple;
	bh=0nsEzeVMKy4YdFDUp85eHaoqb8xweeElGlao/4FZIUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFsnY/2aDdcT3bJ0dOBlfDKiQb+AE2aM+0Te4b3mBjSTWvIBNGiD9Qq9hKDMCVvWlQRtVZmjhjWaegn+SGEa1GlZqzYVTHVHMCfFkEfduQFA/LaOV7REyFZeYPKA7pCDSoaq0rVX8s/4lEOwnLB9xxXPmehnZF8HUbwz3U725yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=opveKBa6; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c97066a668so739156b6e.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2024 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715098738; x=1715703538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpA0imZ1JqdhWIK1ORQBd9/L74Ck+FsRXQUsgUAbnpw=;
        b=opveKBa68KDbotBwf+SHOGwR3L1ZEqcrdU071diK37U0beD4PU9lO4RkVxKP0Py0Ic
         YnHD+bPzb79ZIWtRKfMvo7fg51hCnMP2Nc1DMug+5gHJLpkJxs143i+EJJeVaZLIb8ON
         Hki4ApLOWCcRKhlk6LPk3jWJ9kuNTTOmPAze0955YfA3lIifckMzLgXCDhRjH9U7pp87
         QUEreZiAHX+Msr+MM3DRBDfLpxxyehEdPpU2r8XeTFJFXvDPDYkMt/Tgt9MJbgrJ5hIX
         Hve75qz7JpJG2KiWTu0envqkVVDR2M607agTGZ4qrNRqOL8pdgHhP4A5KJXcmBa0rAqU
         5CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098738; x=1715703538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpA0imZ1JqdhWIK1ORQBd9/L74Ck+FsRXQUsgUAbnpw=;
        b=M3scaIFkZpvGOzxbIiItQV3ZdkSifhmmnLdmVRTJbUz2fiWtWkdUly8x3u+DB0prEi
         uSV5P3Tls6hVgCADkA7UXV9McQR2bI6UMhzl7VMSop0bgyYRY4fFffepOpqD0dW/jNOD
         IEtQ4v/A50ay5Mp8a88b1kZwQZr1IYsMrtlfufkgbLv5qqsIN82oz/iP2pvP2PUV0AeC
         mwsL0uykbx1yK2n8kWW/SR/6WAUew8hTYyQ7ONVYasjRxs1f+kq3ln25AKlZVaU4astr
         RjAoKuPRIfh5tQQzD7JmcFf+QgxX4ZqsZVA3BUWeTV4goSLGp68i9vD4E7iMkYMy40de
         3GXA==
X-Forwarded-Encrypted: i=1; AJvYcCX1U6ijmn9PXK1h/wBNgKeyPp0d6rrpaRiNAnLfL5dBeS4BxKgI+8oEiDXJuIi5hWQ9LEx6npFoMA4E/6VeCFluR3bG12vA5m8h1UfSodOn
X-Gm-Message-State: AOJu0Yzi1NY07F0iYz/JW5gnQrH2kiwlsD4yX5r14w3qu7nmxJQir5y2
	Sbjcoqq91VB4xttDnZ5mG82c1KsPNKd2sOJWzqKwKBLxtKDKyxyRbgK8Ite1syc=
X-Google-Smtp-Source: AGHT+IHBeOFCxQYTrI8MfHIwKkBSBqM9hntJdk3KZjtoSOk7dYsXXEt5GzDg6QwjzVe4x2v7iKDOJw==
X-Received: by 2002:a05:6808:242:b0:3c9:70bf:6824 with SMTP id 5614622812f47-3c9852ad715mr54932b6e.7.1715098738624;
        Tue, 07 May 2024 09:18:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mh15-20020a056214564f00b0069942e76d99sm4800030qvb.48.2024.05.07.09.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:18:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4NWr-0001Pl-DR;
	Tue, 07 May 2024 13:18:57 -0300
Date: Tue, 7 May 2024 13:18:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>,
	Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <20240507161857.GA4718@ziepe.ca>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com>
 <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>

On Tue, May 07, 2024 at 05:05:12PM +0100, Pavel Begunkov wrote:
> > even in tree if you give them enough rope, and they should not have
> > that rope when the only sensible options are page/folio based kernel
> > memory (incuding large/huge folios) and dmabuf.
> 
> I believe there is at least one deep confusion here, considering you
> previously mentioned Keith's pre-mapping patches. The "hooks" are not
> that about in what format you pass memory, it's arguably the least
> interesting part for page pool, more or less it'd circulate whatever
> is given. It's more of how to have a better control over buffer lifetime
> and implement a buffer pool passing data to users and empty buffers
> back.

Isn't that more or less exactly what dmabuf is? Why do you need
another almost dma-buf thing for another project?

Jason

