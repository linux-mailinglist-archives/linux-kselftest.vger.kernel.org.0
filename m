Return-Path: <linux-kselftest+bounces-2443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A9981E795
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 14:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7E42826F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017C4EB40;
	Tue, 26 Dec 2023 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J4L5rAOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396E4EB3B
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Dec 2023 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccce3bc472so6563821fa.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Dec 2023 05:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1703596933; x=1704201733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CR5Mc6S1wCj7Fjrv1MlaC7BI2JRcmGN+tCmj6tVa1EY=;
        b=J4L5rAOfh7bGj6TxHaPH/s8tGriFNUOuCsRhtpwZ62slFmHk/eyYyBsvKkXoM8SRMq
         mcNFrSuzMpiPwmWs57bX/PLID6vdZsGYiJTLdUd6PwcqANZ9/kjywE+XlXwtKX0NfiY/
         SASTUiTVvXEE4vN/zCzTqdpz8y+oUt/72PYc5fVRCczJLIZL8oTnV5ZDupGJfO5Nk7GF
         12fcMpLh85yMZ69/k13G86omfTYgqHUBqm5ywKidkzbJnF9gsH8t65CNhfguxr8Dx32A
         nT7sFBmgXug4CpshkW1/abafQmTeuveFPwry5V1KZpLxYAOQzLyiNzvveMhU+teyufdZ
         iO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703596933; x=1704201733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR5Mc6S1wCj7Fjrv1MlaC7BI2JRcmGN+tCmj6tVa1EY=;
        b=OupQ7vjCPwKzIUmqd4S8DvZPAuuQU+EZLbkfgKwL4mei7M6FPBTlbvLipPTnJoL1CP
         7QCEvbSuimforKigGNOm4FVrAZrcWkB9dYjGLEg/zTUglLF87V/Zzpy+XNc3cCnfS3ta
         r+/FXaBtwfyv10RqcYO0cJfcBkyxqGr4mQrIMMde2pD96PKsNjcv9BrxO3dIm9LLtxvp
         jXyOL5K1r7/34b72bn8BQRVEcmPTBi8/Mf01W8fs1Rf+MX0IUEur5j0FMFi7O0cxauAu
         AmJuoAe9IRs4xPB+lpyjnIBjig9VeFsYvg/UFV/v7uEIf+vEdSD98DiEiiW3cbzEeFuz
         sqOA==
X-Gm-Message-State: AOJu0YxvVA/nUgvKla5khlKL1jAIDNt92Y+AdV83ugM297sMxhUzLx1G
	HDLuf1d/k+Lvn5mHf0g5uYxigoiaKgO2nw==
X-Google-Smtp-Source: AGHT+IHhN61dvntgp6XWctfPX5u8iVH15VLdhnKHc3ENYWxrGgPtdwk0Uxk67Oon7SfRsIhRxfDing==
X-Received: by 2002:a2e:9049:0:b0:2cc:7d70:fa45 with SMTP id n9-20020a2e9049000000b002cc7d70fa45mr3070024ljg.27.1703596933283;
        Tue, 26 Dec 2023 05:22:13 -0800 (PST)
Received: from u94a (2001-b011-fa04-d3bc-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:d3bc:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001d1c96a0c63sm10075044plb.274.2023.12.26.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 05:22:12 -0800 (PST)
Date: Tue, 26 Dec 2023 21:22:03 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH bpf-next 01/15] selftests/bpf: Fix the
 u64_offset_to_skb_data test
Message-ID: <j3ops2mlylgtb5ybkht75gu3dljlee6omu6zu4hsmnojssziyo@gnpsrrvh7f7l>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
 <20231220214013.3327288-2-maxtram95@gmail.com>
 <w7xg34uqlrnbb3o3rspng6y563astp3hkfxjtz3xp32rqr4a42@xgpeu7qevatg>
 <ZYqtDuhpbS1ltM2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYqtDuhpbS1ltM2Q@mail.gmail.com>

On Tue, Dec 26, 2023 at 12:38:06PM +0200, Maxim Mikityanskiy wrote:
> On Tue, 26 Dec 2023 at 17:52:56 +0800, Shung-Hsi Yu wrote:
> > On Wed, Dec 20, 2023 at 11:39:59PM +0200, Maxim Mikityanskiy wrote:
> > > From: Maxim Mikityanskiy <maxim@isovalent.com>
> > > 
> > > The u64_offset_to_skb_data test is supposed to make a 64-bit fill, but
> > > instead makes a 16-bit one. Fix the test according to its intention. The
> > > 16-bit fill is covered by u16_offset_to_skb_data.
> > 
> > Cover letter mentioned
> > 
> >   Patch 1 (Maxim): Fix for an existing test, it will matter later in the
> >   series.
> > 
> > However no subsequent patch touch upon u64_offset_to_skb_data(). Was the
> > followup missing from this series?
> 
> Thanks for your vigilance, but it's actually correct, sorry for not
> making it clear enough. In patch 11 ("bpf: Preserve boundaries and track
> scalars on narrowing fill") I modify u16_offset_to_skb_data, because it
> becomes a valid pattern after that change. If I didn't change and fix
> u64_offset_to_skb_data here, I'd need to modify it in patch 11 as well
> (that's what I meant when I said "it will matter later in the series",
> it's indeed subtle and implicit, now that I look at it), because it
> would also start passing, however, that's not what we want, because:
> 
> 1. Both tests would essentially test the same thing: a 16-bit fill after
> a 32-bit spill.
> 
> 2. The description of u64_offset_to_skb_data clearly says: "Refill as
> u64". It's a typo in the code, u16->u64 makes sense, because we spill
> two u32s and fill them as a single u64.
> 
> So, this patch essentially prevents wrong changes in a further patch.

Thank for the thorough explanation. Now I can see and agree that the
u16->u64 change should be made. Digging back a big, the change also
aligns with what's said in commit 0be2516f865f5 ("selftests/bpf: Tests
for state pruning with u32 spill/fill") that introduced the check:

  ... checks that a filled u64 register is marked unknown if the
  register spilled in the same slack slot was less than 8B.

Side note: the r4 value in comment is still "R4=umax=65535", that
probably should be updated as well now that r4 is unbounded.

> [...]
> > > -	r4 = *(u16*)(r10 - 8);				\
> > > +	r4 = *(u64*)(r10 - 8);				\
> > >  	r0 = r2;					\
> > >  	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
> > >  	r0 += r4;					\

