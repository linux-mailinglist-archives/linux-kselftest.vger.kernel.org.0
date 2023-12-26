Return-Path: <linux-kselftest+bounces-2440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6381E6E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 11:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E20D1C21129
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37401E4AE;
	Tue, 26 Dec 2023 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm2U+IJR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE51E48A;
	Tue, 26 Dec 2023 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso5165464a12.3;
        Tue, 26 Dec 2023 02:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703587090; x=1704191890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNFOYxOzxlD3oJvg3yOj9aCj5UZhCdf3rCeNzSOfqG8=;
        b=dm2U+IJRUUvZ7F09Ka1ioIvd5Ho1ELYS7pYBnmx6A4w3edtN91NLS6UO+ZgIZMlkn5
         sB9NaUoqQczGgdzXdF7hrUce4YYnP8zkwR9fYKgC0UcdxGwrXiWgSiY927uMtG4ZlnMe
         1pK6w75dIjEdCz0opJqsUNsOkcjpNc0MNErdFRxa2KBqjh+4jS/snQNGd5BT52yTY0am
         U6FV2mc0Agab30QjNcQS4lA2X7W5UvBXVGa4E70ivb96f1mPoBdorQLcMWGsCE1vvW2Q
         abpk1DVTtKT+and/Q/odvmInQV4LPkjgOA7YIJHEm3itGPeBcThF78fSfn/dlSnntpz5
         3ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703587090; x=1704191890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNFOYxOzxlD3oJvg3yOj9aCj5UZhCdf3rCeNzSOfqG8=;
        b=aaSN037m2yHVE55vbC5Y9XM7DPFH1MU3XDsc1Ka95ohaA73VbmwIC7EtBLLoklmQeo
         ojxYUMtxOwuKH+X8QeNyik0gFx0aXfkYklzK6y9492vLlC9F0Gn8hsbAgY3+wa9+K95n
         qPUaX1KoV4SwbxGoAoGY3i1UJhujrkmjnVu+JIk0mVqFKF/zGv0cd3dTiwQO5ZXDwfOg
         KfmyQo4FyyzvyWrjKqRbo5yOjrKwMixyp7C8FtOXr5UIDXmXcmIrcOOsCw+A6C/+D9NN
         NeKDtmHqP2DXorawTp3WYWGPoPXeWpGq1jiFjl/gMJDZd0p0sN/6xVmC40BBn4b4RcSw
         OHFg==
X-Gm-Message-State: AOJu0YxSrexcuZUgqQErtUg2tbPLlY3DfrWpnUbW6CxEYzuUubCp9iI2
	0QelqMtWSV2ioSX4o5kGPIo=
X-Google-Smtp-Source: AGHT+IHonaeiY2gSwu5qqv1ZBX50s/xg0LHtnvm02YI8U59u8gTRBuC2W4DepMz6dOpBvHCZvtVYsA==
X-Received: by 2002:a17:906:af93:b0:a26:9963:5e59 with SMTP id mj19-20020a170906af9300b00a2699635e59mr3155678ejb.77.1703587090279;
        Tue, 26 Dec 2023 02:38:10 -0800 (PST)
Received: from localhost ([185.220.101.83])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b00a26f20fa719sm1675374ejj.220.2023.12.26.02.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:38:09 -0800 (PST)
Date: Tue, 26 Dec 2023 12:38:06 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH bpf-next 01/15] selftests/bpf: Fix the
 u64_offset_to_skb_data test
Message-ID: <ZYqtDuhpbS1ltM2Q@mail.gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
 <20231220214013.3327288-2-maxtram95@gmail.com>
 <w7xg34uqlrnbb3o3rspng6y563astp3hkfxjtz3xp32rqr4a42@xgpeu7qevatg>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w7xg34uqlrnbb3o3rspng6y563astp3hkfxjtz3xp32rqr4a42@xgpeu7qevatg>

On Tue, 26 Dec 2023 at 17:52:56 +0800, Shung-Hsi Yu wrote:
> On Wed, Dec 20, 2023 at 11:39:59PM +0200, Maxim Mikityanskiy wrote:
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> > 
> > The u64_offset_to_skb_data test is supposed to make a 64-bit fill, but
> > instead makes a 16-bit one. Fix the test according to its intention. The
> > 16-bit fill is covered by u16_offset_to_skb_data.
> 
> Cover letter mentioned
> 
>   Patch 1 (Maxim): Fix for an existing test, it will matter later in the
>   series.
> 
> However no subsequent patch touch upon u64_offset_to_skb_data(). Was the
> followup missing from this series?

Thanks for your vigilance, but it's actually correct, sorry for not
making it clear enough. In patch 11 ("bpf: Preserve boundaries and track
scalars on narrowing fill") I modify u16_offset_to_skb_data, because it
becomes a valid pattern after that change. If I didn't change and fix
u64_offset_to_skb_data here, I'd need to modify it in patch 11 as well
(that's what I meant when I said "it will matter later in the series",
it's indeed subtle and implicit, now that I look at it), because it
would also start passing, however, that's not what we want, because:

1. Both tests would essentially test the same thing: a 16-bit fill after
a 32-bit spill.

2. The description of u64_offset_to_skb_data clearly says: "Refill as
u64". It's a typo in the code, u16->u64 makes sense, because we spill
two u32s and fill them as a single u64.

So, this patch essentially prevents wrong changes in a further patch.

> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > [...]
> >  SEC("tc")
> >  __description("Spill u32 const scalars.  Refill as u64.  Offset to skb->data")
> > -__failure __msg("invalid access to packet")
> > +__failure __msg("math between pkt pointer and register with unbounded min value is not allowed")
> >  __naked void u64_offset_to_skb_data(void)
> >  {
> >  	asm volatile ("					\
> > @@ -253,7 +253,7 @@ __naked void u64_offset_to_skb_data(void)
> >  	w7 = 20;					\
> >  	*(u32*)(r10 - 4) = r6;				\
> >  	*(u32*)(r10 - 8) = r7;				\
> > -	r4 = *(u16*)(r10 - 8);				\
> > +	r4 = *(u64*)(r10 - 8);				\
> >  	r0 = r2;					\
> >  	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
> >  	r0 += r4;					\

