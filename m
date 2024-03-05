Return-Path: <linux-kselftest+bounces-5896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2276C871872
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 09:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9FE4B219BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67EF4E1BF;
	Tue,  5 Mar 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nFCUr8mh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MeGRT64E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555C2E40B;
	Tue,  5 Mar 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628140; cv=none; b=IuDCgWE0ElNh4fAngvLvjgvKNuMF3zcxJrwP62yhKRmbcuLk1t2PN4oYWRondMDEhpcCH0TCtZcCEAFthcY4gPx5lTV4KVbaxmoCloCIWQFnK/F2qIOxovHYLm80BP6aQWne3RsubB6Fz8RzAxpUBpGmmuttloD9JR9aXARK3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628140; c=relaxed/simple;
	bh=NmJCAuRJ199Nz8coLDr4s+3BbQ9AxZ5w+P+Jx63NVw4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=KKQ27b7rQWyv1YzcEjRRSKF6uIk9CsJMtCEOwknbNukNVyrM1TulLEWP42KquIABrfI7Xav2nPz1uy6eG/99XGdLDJny/KzmRSVmEC+C18PkeUKPVz84vtmGPpBcBj4I9WcuXUXy8jeOv6T5CYR9Nq/BoKEOwHw8tLXOFt6JpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nFCUr8mh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MeGRT64E; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 1AD091C0009F;
	Tue,  5 Mar 2024 03:42:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 03:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709628135; x=1709714535; bh=QeA3EPMJnw
	t6NmNxY9VsOPm58VedM11auwf8kvd3l10=; b=nFCUr8mh4qirfdLiF7rJ3ln4Ee
	ac3TZcBsBjTwt2v0sdIiovpLKYKyf84Jxe23adpiNL58TY/A6Un5jj6iESmOfBN+
	NH3EgOLGaP2DQpO5LGujPp+1ACooTgAvYIJALYP/zB1DPOPdMHqcSl6pneGLIuSd
	0k9KzYIWTlZUxiE5d/Z/VfhGrlYPtpIrvzzKaxh55J1YvHGR53svoOQw5rECchxc
	E9ikW19OkQ636itot1R2TSnpEFaS+eT+JgKKFsBgMEmk8BlUWkauiXR3Ls5Vvsp5
	YZii5Qv8k/VvvLOAqjcoX8BsdOlRwRXYH9ceE7QjJGsmut+vnb/zrjODKYag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709628135; x=1709714535; bh=QeA3EPMJnwt6NmNxY9VsOPm58Ved
	M11auwf8kvd3l10=; b=MeGRT64EA+QDDWf22wqOrRSkQjCcngCXPFXQcuj7sKlb
	fsKykmy6Wo/2udr6Dj45/3j5m0Am1YNFMh5ogK0TGmfT3J3p1lUk5UkjwIxfJ/Ci
	Pk+CIVw/J74yah5SJbYvq+QLaOyKzQH6iNNSmcFd0y5fFCKb9E+Yfzt3yz+45LdK
	9sFUcb6Fxl0Wjzf+1CiXDA/ghzeaVvr1VBLLs58vNnkiklddooZ4bWdiOUY+GqIR
	hy0uslWehpOhOdN1+n7zG5X3CplnE4+mdGGx1Yzro47d/GdIV8wduDcs4mOaIpqy
	CGRzWIXTXwbBC9s0rVJ0cHgCt/kyzi8t44pW07QIUA==
X-ME-Sender: <xms:59rmZebHuiNKE7gBn9g7Zws1CrVENXbBVlU7KpglFLP7T_XtZaHvBg>
    <xme:59rmZRbdHQpICUlzFZ9DMOnUcwCIgRZrUGHMk8EmzSdzq9snWlaZ46aLWKLTaTvHK
    Cg5wi_afUGNXBIHc_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:59rmZY8-Af8ZUR5f35jgIeJGVWX966qCxdxdr_0n3EPth7aYYPYY2Q>
    <xmx:59rmZQqJc6RxhGOktKKAE7ByIoMRz8lUdJERuu3D_WLY5uFdFRGIxA>
    <xmx:59rmZZoZzA-bUCffCtvffkklND4SVShkax7NIxvDvebcxKbcpR8E8A>
    <xmx:59rmZdfoSPIHkIwIoZkPmTYx3CVSLM8Fpjgeg_PGly9T-_ds2f3zKnQLvGs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5045FB6008D; Tue,  5 Mar 2024 03:42:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a2d926be-695a-484b-b2b5-098da47e372e@app.fastmail.com>
In-Reply-To: <20240305020153.2787423-13-almasrymina@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-13-almasrymina@google.com>
Date: Tue, 05 Mar 2024 09:41:55 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mina Almasry" <almasrymina@google.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
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
Content-Type: text/plain

On Tue, Mar 5, 2024, at 03:01, Mina Almasry wrote:
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
>  #define SO_PEERPIDFD		77
> +#define SO_DEVMEM_LINEAR	79
> +#define SO_DEVMEM_DMABUF	80
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
>  #define SO_PEERPIDFD		77
> +#define SO_DEVMEM_LINEAR	79
> +#define SO_DEVMEM_DMABUF	80
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
>  #define SO_PEERPIDFD		0x404B
> +#define SO_DEVMEM_LINEAR	98
> +#define SO_DEVMEM_DMABUF	99
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
>  #define SO_PEERPIDFD             0x0056
> +#define SO_DEVMEM_LINEAR         0x0058
> +#define SO_DEVMEM_DMABUF         0x0059
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,11 @@
>  #define SO_PEERPIDFD		77
> +#define SO_DEVMEM_LINEAR	98
> +#define SO_DEVMEM_DMABUF	99

These look inconsistent. I can see how you picked the
alpha and mips numbers, but how did you come up with
the generic and parisc ones? Can you follow the existing
scheme instead?

> diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
> index 059b1a9147f4..ad92e37699da 100644
> --- a/include/uapi/linux/uio.h
> +++ b/include/uapi/linux/uio.h
> @@ -20,6 +20,16 @@ struct iovec
>  	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
>  };
> 
> +struct dmabuf_cmsg {
> +	__u64 frag_offset;	/* offset into the dmabuf where the frag starts.
> +				 */
> +	__u32 frag_size;	/* size of the frag. */
> +	__u32 frag_token;	/* token representing this frag for
> +				 * DEVMEM_DONTNEED.
> +				 */
> +	__u32  dmabuf_id;	/* dmabuf id this frag belongs to. */
> +};

This structure requires a special compat handler to run
x86-32 binaries on x86-64 because of the different alignment
requirements. Any uapi-visible structures should be defined
to avoid this and just have no holes in them. Maybe extend
one of the __u32 members to __u64 or add another 32-bit padding field?

       Arnd

