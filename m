Return-Path: <linux-kselftest+bounces-2671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7BE82595C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 18:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107C028567A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2D328BC;
	Fri,  5 Jan 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbXUI0j/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657B34CD3;
	Fri,  5 Jan 2024 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so2157014e87.0;
        Fri, 05 Jan 2024 09:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704476910; x=1705081710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbIn5ACItj23td9QdMR6BwB7Gpl3UV5nhL6wUREGdfE=;
        b=dbXUI0j/Bdukn6pd3oDB9CBakLUaS/Yh9zEjDVFpL1V9aImO4RSfT9ujeyr4ivOL5D
         1r27KGJjl63VYQRFlwBrFg0LTB2SHF1L331Zoqg54ncKN/GYzOgXqjom7BqM/bTgOBTa
         XcwTL8rirAyfbUiNottTHoP6S9OQN/P1WSlDyOJFbKmagSNmCQkMOijIKZ10iKilv5A5
         vwCrN15+YklTCHbhgOm0mfWUNmQW/XmG07L3YW6ifK0tS7geYIBooPkqvNxKA5J0Z88+
         srvdyleTvWBFklpzryEL1ofqA2G32v7ae6gqjrXP+8qN9CAzkVSsnd7BMdf41DWN9QLA
         SOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704476910; x=1705081710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbIn5ACItj23td9QdMR6BwB7Gpl3UV5nhL6wUREGdfE=;
        b=g4Bu8qOE62ngXhsdiwQoZM834ayc1tcz5vxgySgzI48thyeW+7ZN8J5D9hhVZn5PLf
         a1fy8HilAO93DkxV++6aSnj2Bh62S2NnzKzRIrKUYxVTwXef57UL8Ae656SWoaqgrpdb
         56ufcfaE54/+iUce/IUG3QaoucbP0Ff2hymGPJ65eGuMxjru+DVZHdbD2Dyng6hDUgKI
         FOM24EnW/fdCXOgS1fRsapFKjBanELfqtOePDLal2Q63ZdDI8a0kFZqHz/1kymiiWogT
         SADVW4cu+M5ELucsVf4dBKbR2yIgWYjgg+oaBYYtwcZxWjTzESGJ3r7r+/PdOKn4DsQf
         w2tw==
X-Gm-Message-State: AOJu0Ywipwcky6dEclAUVGwk6je1726gXknJTP5KjiynR5Xeg/nk4WjU
	h4KkKsgKfFnZnAY+akRpF9E=
X-Google-Smtp-Source: AGHT+IF2jT49pomT63bKUNg27aTomeJg9VxIM1GpL+QAiZFj0a0BCXTo4mphGK5Q5kd9yhEuk1yaMw==
X-Received: by 2002:a05:6512:104e:b0:50e:3777:f779 with SMTP id c14-20020a056512104e00b0050e3777f779mr1538541lfb.31.1704476910058;
        Fri, 05 Jan 2024 09:48:30 -0800 (PST)
Received: from localhost ([193.218.118.182])
        by smtp.gmail.com with ESMTPSA id f8-20020ac25328000000b0050e74f34b2csm291862lfh.17.2024.01.05.09.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:48:29 -0800 (PST)
Date: Fri, 5 Jan 2024 19:48:25 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH bpf-next 12/15] bpf: Preserve boundaries and track
 scalars on narrowing fill
Message-ID: <ZZhA3LBjXEuCQH5Q@mail.gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
 <20231220214013.3327288-13-maxtram95@gmail.com>
 <a4c8b7b9f03ff3455fbf430862b370abe9337bc9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4c8b7b9f03ff3455fbf430862b370abe9337bc9.camel@gmail.com>

On Thu, 04 Jan 2024 at 04:27:00 +0200, Eduard Zingerman wrote:
> On Wed, 2023-12-20 at 23:40 +0200, Maxim Mikityanskiy wrote:
> 
> [...]
> 
> The two tests below were added by the following commit:
> ef979017b837 ("bpf: selftest: Add verifier tests for <8-byte scalar spill and refill")
> 
> As far as I understand, the original intent was to check the behavior
> for stack read/write with non-matching size.
> I think these tests are redundant after patch #13. Wdyt?

_6_offset_to_skb_data is for sure not redundant. I don't test a partial
fill from the most significant bits in my patch 13.

u16_offset_to_skb_data is somewhat similar to
fill_32bit_after_spill_64bit, but they aren't exactly the same: the
former spills (u32)20 and fills (u16)20 (the same value), while my test
spills (u64)0xXXXXXXXX00000000 and fills (u32)0 (the most significant
bits are stripped). Maybe u16_offset_to_skb_data is redundant, but more
coverage is better than less coverage, isn't it?

> > diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > index 809a09732168..de03e72e07a9 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > @@ -217,7 +217,7 @@ __naked void uninit_u32_from_the_stack(void)
> >  
> >  SEC("tc")
> >  __description("Spill a u32 const scalar.  Refill as u16.  Offset to skb->data")
> > -__failure __msg("invalid access to packet")
> > +__success __retval(0)
> >  __naked void u16_offset_to_skb_data(void)
> >  {
> >  	asm volatile ("					\
> > @@ -225,19 +225,24 @@ __naked void u16_offset_to_skb_data(void)
> >  	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
> >  	w4 = 20;					\
> >  	*(u32*)(r10 - 8) = r4;				\
> > -	r4 = *(u16*)(r10 - 8);				\
> > +	r4 = *(u16*)(r10 - %[offset]);			\
> >  	r0 = r2;					\
> > -	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
> > +	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=20 */\
> >  	r0 += r4;					\
> > -	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */\
> > +	/* if (r0 > r3) R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */\
> >  	if r0 > r3 goto l0_%=;				\
> > -	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */\
> > +	/* r0 = *(u32 *)r2 R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */\
> >  	r0 = *(u32*)(r2 + 0);				\
> >  l0_%=:	r0 = 0;						\
> >  	exit;						\
> >  "	:
> >  	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
> > -	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
> > +	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
> > +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > +	  __imm_const(offset, 8)
> > +#else
> > +	  __imm_const(offset, 6)
> > +#endif
> >  	: __clobber_all);
> >  }
> >  
> > @@ -270,7 +275,7 @@ l0_%=:	r0 = 0;						\
> >  }
> >  
> >  SEC("tc")
> > -__description("Spill a u32 const scalar.  Refill as u16 from fp-6.  Offset to skb->data")
> > +__description("Spill a u32 const scalar.  Refill as u16 from MSB.  Offset to skb->data")
> >  __failure __msg("invalid access to packet")
> >  __naked void _6_offset_to_skb_data(void)
> >  {
> > @@ -279,7 +284,7 @@ __naked void _6_offset_to_skb_data(void)
> >  	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
> >  	w4 = 20;					\
> >  	*(u32*)(r10 - 8) = r4;				\
> > -	r4 = *(u16*)(r10 - 6);				\
> > +	r4 = *(u16*)(r10 - %[offset]);			\
> >  	r0 = r2;					\
> >  	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
> >  	r0 += r4;					\
> > @@ -291,7 +296,12 @@ l0_%=:	r0 = 0;						\
> >  	exit;						\
> >  "	:
> >  	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
> > -	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
> > +	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
> > +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > +	  __imm_const(offset, 6)
> > +#else
> > +	  __imm_const(offset, 8)
> > +#endif
> >  	: __clobber_all);
> >  }
> >  
> 
> 
> 

