Return-Path: <linux-kselftest+bounces-14578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D59437AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 23:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325D81F23284
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 21:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640F16C861;
	Wed, 31 Jul 2024 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5AOJVde"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4F16C684
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460771; cv=none; b=N2umoN/T6rTTlSB6jNno0n2s/ykNmvP8bKyzZPriTNujzjPnM0FSp8AZS8TAtMVujHxccTvxrPm+PtZSl9NAiD6BKXSHDg9lo+0v4qWsCjO/8BsDMyjZk05681qT8pRCmBIx2/AUrNh2CClpiga5GuY13RBq8rvlhZCWtyHpZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460771; c=relaxed/simple;
	bh=dEiu0hhQh0Jy26qjQV9Cqq27juU/IGB072cpo+oEEG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcZSaEc9UM2xcMA/++96tx1hptj/VYy+nHzWGjwY/iTJs9zxx10dvqxlPG8/UoFoe0sukaWVY0ee8IOaIjQRFhKTqtQwhxcPGrHlEMXv0CLwG534rcATK/HJcufEH++R8EljS6j8Rxz5JJZ4i9PH9vjiyoYr1jC8EcpaCpxFTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5AOJVde; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367990aaef3so3308093f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722460767; x=1723065567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEiu0hhQh0Jy26qjQV9Cqq27juU/IGB072cpo+oEEG0=;
        b=G5AOJVdeww95s7Qb7CjW1AIB44U8JoB3hsMVjtKEas3JXf1vwCfGamISn0W9Aq/kdy
         yNL1Zqv/cr4RhFQKyRJmPJ6INVWA7HaLN4BA3TPWJOgIpZunPibJa8lDt4dea35PXJMa
         WJnXVfFa8qRDUEOjUhndXkLLFeV3WIfifKMKBtqyAQTnivbTT+brnZBgFMNZdAo8vEjt
         AHpE8w7Pa18w2XjTHFuKm63OtcCWPoxDqHBhXedIrvxFQBDm2ZqArJ12gP+H0TWV+pTi
         hMTXlVceo15PAg4VK22DsRHYu0TuNLhY74kcM8C3XJhIyn3vkFywG3eHmMbwTKrnO4Hh
         vx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722460767; x=1723065567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEiu0hhQh0Jy26qjQV9Cqq27juU/IGB072cpo+oEEG0=;
        b=U9e1QEg54EqxU0caN03T0TOJBhtKi1bAyirvD7RTFaMj6Z8ktAn8WN+jzlloy9oecp
         C/Cw7NAKhVFghAxC5Uq6TdgObqIb5B0oEdqfAJFa1awHUaOHhGLceWlTsSjHk9SQ0cqs
         bc8IfuCvlVKtQKzsQF5u2bT8WBH2+oTtIOK4Jr9rTF76BQP9realLRa03kO1DFmNHg86
         TM8FnMtqMg/yM38xsKd4pQ0XiguCvLSwKzeObSNsdJpnqDUIdGowk1YjFPJx+YEE50Jy
         Nv9oGIeqQTwYYfyOZ2UwNMgXEcRVwsucsjAnCZ14Bzhlbdf86vmKXsOphpmsc1qxT09U
         5m5A==
X-Forwarded-Encrypted: i=1; AJvYcCW45AA9p6H8RgEQSNezZU8mHguAmfBgV0j5feT3uxh32YkHiDk6L9NVcHFUrpotc/MobqqSBuApyS2O9zGElegI7kJYaAF46T50Dqru/R+E
X-Gm-Message-State: AOJu0YxFlmt4zbnmPafN8p8D5PqWkTJcc9dU3lGg5Q5dRqpK//T3ER4Z
	k95iMWwaANo70Tmi4u/fZHajb38kWDcZkI424w0lKdF12cCv+LfKQzsifXPshGjE1iaUrAZnxVj
	NLPd6+4Sb386c5XUOG8xJRlcnjSq1Eo55ufhj
X-Google-Smtp-Source: AGHT+IGCGvp/48H8qaH6fLYg7SPbNiiWFxJtKT/J7GEsXh7PoxMKp+lvuqPbXyBiSW9seEuLTTgslLee6nJ92gY4vjU=
X-Received: by 2002:a5d:4483:0:b0:368:6d75:1bde with SMTP id
 ffacd0b85a97d-36baacdd8aamr351815f8f.15.1722460767120; Wed, 31 Jul 2024
 14:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730022623.98909-1-almasrymina@google.com>
 <20240730022623.98909-2-almasrymina@google.com> <1722327259.5659568-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1722327259.5659568-1-xuanzhuo@linux.alibaba.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 31 Jul 2024 17:19:11 -0400
Message-ID: <CAHS8izMZQLsBWPXWiqPwaQHfupKc5VAuxW+6kpWmzi-vw8JEWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v17 01/14] netdev: add netdev_rx_queue_restart()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 4:17=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 30 Jul 2024 02:26:05 +0000, Mina Almasry <almasrymina@google.com>=
 wrote:
> > Add netdev_rx_queue_restart() function to netdev_rx_queue.h
>
>
> Can you say more? As far as I understand, we just release the buffer
> submitted to the rx ring and get a new page pool.
>

Yes, I just noticed that this commit message is underwritten. I'll add
more color. Maybe something like;

=3D=3D=3D=3D
Add netdev_rx_queue_restart(), which resets an rx queue using the
queue API recently merged[1].

The queue API was merged to enable the core net stack reset individual
rx queues to actuate changes in the rx queue's configuration. In later
patches in this series, we will use netdev_rx_queue_restart() to reset
rx queues after binding or unbinding dmabuf configuration, which will
cause reallocation of the page_pool to repopulate its memory using the
new configuration.

[1] https://lore.kernel.org/netdev/20240430231420.699177-1-shailend@google.=
com/T/
=3D=3D=3D=3D

> But I personally feel that the interface here is a bit too complicated. I=
n
> particular, we also need to copy the rx struct memory, which means it is =
a
> dangerous operation for many pointers.
>

Understood, but the complication is necessary based on previous
discussions. Jakub requests that we must allocate memory for a new rx
queues before bringing down the existing queue, to guard against the
interface remaining down on ENOMEM error.

Btw, I notice the series was marked as changes requested; the only
feedback I got was this one and the incorrect netmem_priv.h header.
I'll fix and repost. It's just slightly weird because both v16 and v17
are marked as changes requested in patchwork.

