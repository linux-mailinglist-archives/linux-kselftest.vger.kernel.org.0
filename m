Return-Path: <linux-kselftest+bounces-5960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F174E87298B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 22:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20492836A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 21:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558812BEBE;
	Tue,  5 Mar 2024 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Z2vvL2+R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LrbQnx0g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5F18AE0;
	Tue,  5 Mar 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674953; cv=none; b=Q749dxljae0NIK2GACMOmiWeT6sOIkxPmSbkSLwzGuCL6G2UiC4+9zxN3z4bytSSI4KitJIcFwzbC62UJ5g/ylPQBElVp4Hexyv8icbWXTx4yZ54LIKPw0EmSttGGSrYDxG94uooWJvQncq70x5t6G/XNPer4gyRi+eccnR6zcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674953; c=relaxed/simple;
	bh=wZkSkX9694x6IaB7S0oYpjmKV7DkKNY9dxbFCcaTTio=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Z3Pvw4Do4DDv3xhA399z3eLzD/AUs5ZcmuJYr3Z/a2cfcVV7zF4Fq3vvys+gJNrH3jNPZFAUKG0CQgrhxsEr6jX1V43CKZDc8UE/hyZnqhHujb+VqaWVTDwismzi6iEVvnDereeLYZY4fCWowJQPDVEqGh1r6FlIJ9QWKIuxAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Z2vvL2+R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LrbQnx0g; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id BD3A732002E8;
	Tue,  5 Mar 2024 16:42:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 16:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709674948;
	 x=1709761348; bh=Hz9n4ApIEoOa8ewx4aHPiFWUsa7oc5PoCFR5tHWnstc=; b=
	Z2vvL2+RHREKBnnShKno4/jb1cVWnYIk/pbKst0T9GSgO+GTD+lqnOzBt15TR/gF
	Ov/CnFYWmAdf2IiC3orlU2Pht/2QkoWd+aGToBLtJ5AfaXhx/HX9XmU6pWQyp/X+
	AX8T8Irot7PqLSsirVN+Fh7InwWa1J5x7mNhMtcaX5fDZac08EXHvoHM2LZIBZWE
	LrqpFhY+rhTSVfmW7ug7d//DdSDdXHRtyxRSEkef94liSBPoxn1LSI1jugALqKP1
	upSMHg/1B+GDecCwjhCiCzxyasjUnkQM5uqXW3kZmEcinluhig+8c4OhxN9mojCT
	+k+1KVpJarAAbgrXrH7jNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709674948; x=
	1709761348; bh=Hz9n4ApIEoOa8ewx4aHPiFWUsa7oc5PoCFR5tHWnstc=; b=L
	rbQnx0gPIWfZS390XfNT6ZEqwXUw9civMU/UkkPBwkknC9mWgetd9fjEX4tI4MYb
	1HJtZ/9H+AHdr5rAgDfC6agUd1WbWNzREy8a6wgtkj6IcPa/opvwMQ32XZ8Bzpcn
	wIe75VJIaLK+cZwjeXwta/r7SEoJ78IzGmAS8+kB3cObvRTslByL0hDQo2c/fNX/
	kKfHtGqFSumbh44rUaUFyQajtHHTbyjEoF821OxX9Qf1YN1SKnezhh1p4xsbjuM+
	7AMju9IR0lhxNiPoiOCzS46k+Ep1m6s+HkMWNyIyl5cXiBkPfOlij12bqWS79vhO
	k2Lf3PG8L/HB/Ikm1Z9Ng==
X-ME-Sender: <xms:xJHnZRPebw6SNE3J8I7RkTXxbhOBak8toh3zF8ktJQh7guttCQi5yQ>
    <xme:xJHnZT-8oCIfpkUTrmAAoz88Oo4WT-KhnfVUvTlXRl2pqsbJYpaxSNTGQzCBeHy10
    fdJ5kIf98j7nwsumWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:xJHnZQQZBUvrBKK579v_A6WKxSeB1uedMzT3a4s7bznAu3LnDGU2oQ>
    <xmx:xJHnZduqOFIFIDwXh4qZnMeRGz37J-jpTm-4aMRGoE-CNhCuLPv4pw>
    <xmx:xJHnZZdFyZNODhjvxaepeGuFt7JrQh_o-Jhv-1b0jZ3Hjc6YxC1k2g>
    <xmx:xJHnZTvUPetGykXHwgcz5-27tVMiNScPbnZ4eUKhFo6JKmOPuvcEjg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 02874B6008D; Tue,  5 Mar 2024 16:42:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <037496c9-f06a-4946-b903-95d87d577b89@app.fastmail.com>
In-Reply-To: 
 <CAHS8izPhvRDPVHr8mY2FffPCLYjKqaazjy5NFcnJSnLK+CdyCA@mail.gmail.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-6-almasrymina@google.com>
 <5e2f9342-4ee9-4b30-9dcf-393e57e0f7c6@app.fastmail.com>
 <CAHS8izPhvRDPVHr8mY2FffPCLYjKqaazjy5NFcnJSnLK+CdyCA@mail.gmail.com>
Date: Tue, 05 Mar 2024 22:42:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mina Almasry" <almasrymina@google.com>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Andreas Larsson" <andreas@gaisler.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "David Ahern" <dsahern@kernel.org>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 shuah <shuah@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pavel Begunkov" <asml.silence@gmail.com>, "David Wei" <dw@davidwei.uk>,
 "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Yunsheng Lin" <linyunsheng@huawei.com>,
 "Shailend Chand" <shailend@google.com>,
 "Harshitha Ramamurthy" <hramamurthy@google.com>,
 "Shakeel Butt" <shakeelb@google.com>,
 "Jeroen de Borst" <jeroendb@google.com>,
 "Praveen Kaligineedi" <pkaligineedi@google.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Kaiyuan Zhang" <kaiyuanz@google.com>
Subject: Re: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf to netdevice
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 21:00, Mina Almasry wrote:
> On Tue, Mar 5, 2024 at 1:05=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Tue, Mar 5, 2024, at 03:01, Mina Almasry wrote:
>
> A key goal of this patch series is that the kernel does not try to
> parse the skb frags that reside in the dma-buf for that precise
> reason. This is achieved using patch "net: add support for skbs with
> unreadable frags" which disables the kernel touching the payload in
> these skbs, and "tcp: RX path for devmem TCP" which implements a uapi
> where the kernel hands the data in the dmabuf to the userspace via a
> cmsg that gives the user a pointer to the data in the dmabuf (offset +
> size).
>
> So really AFACT the only restriction here is that the NIC should be
> able to DMA into the dmabuf that we're attaching, and dma_buf_attach()
> fails in this scenario so we're covered there.

Ok, makes sense. Thanks for the clarification.

     Arnd

