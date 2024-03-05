Return-Path: <linux-kselftest+bounces-5950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D908727C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 20:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705E628E7D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926812839C;
	Tue,  5 Mar 2024 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="u+y5s3AA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bI98yQUl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA186AC3;
	Tue,  5 Mar 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667609; cv=none; b=afjMZVwzckNYh2coLlzUPuCbz6cG1t9ei05cfSVAyEi+fQSlmPS/lyDHfUvE107h/MQcDRloGFJhYIkHbV9HoZfw/IZIssVKJ/qXSKRjBmr4MBR/97k69QDDTw3cvNBHucIzFBnq0+Q4OGeZC0/+l9dpLzSM78DhCTBqd4TMUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667609; c=relaxed/simple;
	bh=UdiRxD3hjdDoNoN6V/B0gO/ecb68kq+k4lK7Gr0p4hM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oUKLbPoMolpxhr/3dDSfG7Ut2G79Gfoke6b3G2dS4npOCt4MyGOWkQchMJGEwAHPa4E7FuBG33F8Kq+REBH//H1aYaXHfzvsggw+egPmAPDr1KvzefpFMi4bftpLv/AXV6HlXUYWPZDOSdPTxHNqbEpOZb6+QaY83HvEFdA/oKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=u+y5s3AA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bI98yQUl; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id ABA8C1C000BF;
	Tue,  5 Mar 2024 14:40:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 14:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709667605;
	 x=1709754005; bh=/FrVbuG+NmXdRaEhMkfyj7JdlCIJB5MvqaHthubPGLI=; b=
	u+y5s3AAcSrVGb/JG8he5PBmKDOIvxjrwOHdIL87rOvKwMJPyQiaXkgjiLGJoDmJ
	vQ68/D+qg/6dOekc2yRJIgBeXof3hdc4KEHNBJBx1BmYQbwW2UDdDsV440l3FDm2
	HLetPu0T1oPI74a/+7icglyS8KVKjcZ2lea/2WzWUBr+6ZQpdsP7E5OKdBmPd0Dv
	i38PKFc65hSDD0mi7GLWvYZ+CiPBuKwyFWG+gRwbGEZMZ5Os+h186BmeCRhMHgjH
	d3Ao67bTRY1HiP7Hx+JHdjvhO4l7aRjO95FaVqFvLZBdWyMuAfBwO6DETYuEmATL
	Jr5hKsqqQAKwZKz9STvKqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709667605; x=
	1709754005; bh=/FrVbuG+NmXdRaEhMkfyj7JdlCIJB5MvqaHthubPGLI=; b=b
	I98yQUlraA9OEhljwZxi0xGj/KiX5jmpLe8XfDfafzNLIXrW/onPeGW4mFpbLe9i
	3I8GN/VaGrfcercwlZmFiHf5qumPxnzUPv4W16NYSpU+wodrpmoIw6g2bIVPKtmF
	56oLPpmTIXUr+1O8h3H+d+WwR//OiFnBWVconbGjVSi6Sqo/CaLxhoKi5LoMF+M4
	jbgnUBVi0gMCGz1el3xvqJdob/9W3QBVEZsUXXpwYbc7Cu/rL9Ark7CH17ytR0Jn
	BQwiewVJJQji0TFDpF61+b6TlTtWhnaIa6DyXgB+MFRzvktoyzbVdsD3fdJvGlWW
	w0A1xatwpmxDb9UFKAxdw==
X-ME-Sender: <xms:FXXnZeYhth3peq_cGtBp4XHfmVGv7WRv_BHKEW4-HhNAOrDUl2mSmw>
    <xme:FXXnZRYv_0R9QNKcotBfkLapJRAb0tD9zZ0moncYZfvmrl_PDB5L5uZrDhPyTC1ag
    gpEYS2hPvi8_ZeLK3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:FXXnZY8onRjTqapG4ynsXws_5H6rKs2JW7FmlIXbY0nlhwsG4zMv1A>
    <xmx:FXXnZQorEljARLaZfc0aAM3QVKzExsFlPELkV8jHJd6wWDRyWd4vfA>
    <xmx:FXXnZZoT42d9mRO74wrw3ZySRYpVKA2QMduj2WBU8c3BDS5kwO8stg>
    <xmx:FXXnZddSs7IQiaT3xvSjOg4z4lxJY0V9eTbYBMyYnrWcMBy0QRzc2cFXCpo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DD7D2B6008F; Tue,  5 Mar 2024 14:40:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b7ef0a2b-40e8-4fac-8396-fe0f394bf0e3@app.fastmail.com>
In-Reply-To: 
 <CAHS8izPbBHz=rr65ZtCy-+OGPbXXaY66_5EFSXw2bbhfGweRWg@mail.gmail.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-13-almasrymina@google.com>
 <a2d926be-695a-484b-b2b5-098da47e372e@app.fastmail.com>
 <CAHS8izPbBHz=rr65ZtCy-+OGPbXXaY66_5EFSXw2bbhfGweRWg@mail.gmail.com>
Date: Tue, 05 Mar 2024 20:39:44 +0100
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
Subject: Re: [RFC PATCH net-next v6 12/15] tcp: RX path for devmem TCP
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 20:22, Mina Almasry wrote:
> On Tue, Mar 5, 2024 at 12:42=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Tue, Mar 5, 2024, at 03:01, Mina Almasry wrote:

>>
>> This structure requires a special compat handler to run
>> x86-32 binaries on x86-64 because of the different alignment
>> requirements. Any uapi-visible structures should be defined
>> to avoid this and just have no holes in them. Maybe extend
>> one of the __u32 members to __u64 or add another 32-bit padding field?
>>
>
> Honestly the 32-bit fields as-is are somewhat comically large. I don't
> think extending the __u32 -> __u64 is preferred because I don't see us
> needing that much, so maybe I can add another 32-bit padding field.
> Does this look good to you?

Having a reserved field works but requires that you check it for
being zero already, so you can detect an incompatible caller.

> struct dmabuf_cmsg {
>   __u64 frag_offset;
>   __u32 frag_size;
>   __u32 frag_token;
>   __u32 dmabuf_id;
>   __u32 ext; /* reserved for future flags */
> };

Maybe call it 'flags'?

> Another option is to actually compress frag_token & dmabuf_id to be
> 32-bit combined size if that addresses your concern. I prefer that
> less in case they end up being too small for future use cases.

I don't know what either of those fields is. Is dmabuf_id not a
file descriptor? If it is, it has to be 32 bits wide. Otherwise
having two 16-bit fields and a 32-bit field would indeed add up
to a multiple of the structure alignment on all architectures and
solve the problem.

        Arnd

