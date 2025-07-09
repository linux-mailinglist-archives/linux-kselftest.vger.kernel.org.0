Return-Path: <linux-kselftest+bounces-36838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875F2AFEEDD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 18:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3119F1893A23
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797E216E1B;
	Wed,  9 Jul 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQHVHgFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E6D21516E;
	Wed,  9 Jul 2025 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078552; cv=none; b=QNHxA0ZOnZCqcyQggnncPG/b/xDpBxAqb51mC841XrQqWtD1ljhXO/7QEEUQZqfHhL7/myGdzudivyida59K9/46JYVsJ19ii1y0TTICLrM4uCXuKy31YtZBlxH6ac/U4LU0+MCi2j+4RRJCq9qfJd4HAPktvTyAg0fk2XvlPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078552; c=relaxed/simple;
	bh=sRZinxGJp0LHZgzPtfypMxAGSMAGRbauJmTwYUBpiyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D06BiLo6SYrPEsc/bgEO8m6m/+9FEhjYlakbEn8P0nXWgY5oBq787p7xuVX/wzOQRUu8wG8OcIOtNWdT8hjR/yebAnPwei9B8UAwdDI+HXm1IqFHwytDBO7dRAXeEObbmK+H+iWwNGhX+dXaw0IdRBE4pciJnTD0gPy/Bv1HWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQHVHgFe; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31393526d0dso141275a91.0;
        Wed, 09 Jul 2025 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752078550; x=1752683350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cNKPiHQhGuB2A2mBLDUtVdPtTHbu/csglYuDV6e8cnY=;
        b=FQHVHgFeGNgDsvHp14YKIZDGOBh0z1MHwIHrzDMFvr8X4N98afMuilMOj7eq3P9xIt
         LZm3c+q5Xebw9mgJYmq2OE91gG67+wXeNyT1mGrR2vbe44/ZLJIUWB96hh3Yz4LypZI5
         UCMAqsWniUR61s0saSMm5BZDYg0dG7kXp/yO5/yO/XwQO6nUq2nWeNiUuAlJdzkoDV49
         f1wiymxqvY+gg0j9m7JHowk2W007n72aa5YXR6MV/DRnqReBgl8qN+dwVlQ3uvov682n
         MSjrJrFRHbAcGk3zCYAUbpFdKU/2rwEeR5QD0x1UdhBHRhrpawxCiUvIEnbPJ0BzfBea
         gD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752078550; x=1752683350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNKPiHQhGuB2A2mBLDUtVdPtTHbu/csglYuDV6e8cnY=;
        b=LEEyTlVeLfgllH0T+sA50MN8Ao0LRW+M/iFrEDkPogqFTXYrAF7OkGyNjI1351agCL
         hooQwu0cyvq9pvGzHlGo2RzFaU2u0A92HO8mroA3YXd124eLEcS4MufEEnYGpzTLQl1b
         1aNhP30VL0kZfnnXP9vAv/VudvwgVLgHBMAN5rRJCUXWTtxcCAmgWqr14i6x92s6Su9B
         F0XvXd0h/79euj0oRB5vKdB/Q7TWCPUD2XZZ3B4Gl6i7pb60DBYBdFv0w99kMEWlw1E5
         1JqlxBekiaIS6Pi2OonkTsckjLSyDtOlWTH9SA5pvu2C3qNek2Ix7jaTTfE8MeDOmhUr
         qBcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/pp54qU8CwmxHEZ6TkZml+01aUZ8b0Rqh3Peehf7k3F0SyszWM+Nq2GtHNFaZ0tN2x+yz+ARR@vger.kernel.org, AJvYcCWIprSFA2cMoUYwCchdyJkviP+UxZV+EQ4EmxseMN1+wLYn1iUZCYZ3ULt5nqX2Y80Rl3Q2M9P+iZlA3EkH@vger.kernel.org, AJvYcCWMpYKE8TO7tCyEwArUt00uBAJRB8QBTRWANWcyxPGBnlUsiIrqZzh33nkE5drRy/TL7tOS+CBfYbRTb+m+41kM@vger.kernel.org, AJvYcCWNdjFpyQWGR6iO1BjIIOJZ0a2Ght5+IyChX8ZCuFIS+R8jCrSiFGsZkY7+bu4j9o0mDAQ=@vger.kernel.org, AJvYcCWszxf5RY3tgDdfXdNRBmxa2JgMGfYQSm0VzQdUDFm+DKp7BWi2+JHZDshHPXXBn+lMcNGj1iMT16Jk@vger.kernel.org
X-Gm-Message-State: AOJu0YyuU57ipT/ZwyTg0Lxc00W/k9tJdZS7hdoaCqfX5xcrLETlVvO3
	qlYnCBa0TFAO7SQXQrIpuh4vcXCCjJ3m7NCLEtPpVrRhpq7bs2JuGsE=
X-Gm-Gg: ASbGncsrcDccC6nG5digysRkb5YNIbtnhR0xlDgibJiG1HJ+85/lwAuyy6FM91UDV27
	Sz/qEKruSWpeegSexZ7zalDvB0odktuybqZDGtzE3QWUgYcoGLJI8F6U4b9FyCBd6KANzKny1yH
	TwPMypD+CFSVrX0RmS+Vy95gWh21mXOSZol2lX9MgeU8pgP0DkaFayJglBkBPL3vyJ0//3x8Bw8
	W1COQgo84d2sifE95ojLvjMS659d06WfY/M2lDDWlaiV893RsCfrOS9+Hh/52PRKtob/3Hzx+XL
	dGeP80ljYvhg2Ilwaoi955LEced9U2Slbj6nLEBhaEoxSkZAEu5HlbgMCMlx3v1swmmY/y22eRg
	cQ8AYbZQ4UMycW6h4gP02r3A=
X-Google-Smtp-Source: AGHT+IEay738lMrbJZ6+Qln/Mixh/N/XCUQ86AX7IEDIBEjNMhpWd1QA49Fe+glBMuPqgQKN87d2vg==
X-Received: by 2002:a17:90b:57c7:b0:313:271a:af56 with SMTP id 98e67ed59e1d1-31c3c30a79amr705858a91.30.1752078550125;
        Wed, 09 Jul 2025 09:29:10 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c301ae5fesm2516829a91.38.2025.07.09.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:29:09 -0700 (PDT)
Date: Wed, 9 Jul 2025 09:29:08 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	"Song, Yoong Siang" <yoong.siang.song@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata
 handling
Message-ID: <aG6Y1J9Li2DdjqWv@mini-arch>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
 <20250702165757.3278625-3-yoong.siang.song@intel.com>
 <77463344-1b1a-443a-97be-a7ef8a88b8af@kernel.org>
 <IA3PR11MB92546301B67FB3A9FDCD716DD842A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <88a64a65-bd8c-4b73-af19-6764054d4572@kernel.org>
 <f5d724ab-0eb6-41a1-b694-8aea566e99ab@iogearbox.net>
 <aGvhzDLSuOolCCWW@mini-arch>
 <27edae8a-f1a8-4000-ac1e-fd4d5b01e807@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27edae8a-f1a8-4000-ac1e-fd4d5b01e807@iogearbox.net>

On 07/09, Daniel Borkmann wrote:
> On 7/7/25 5:03 PM, Stanislav Fomichev wrote:
> > On 07/04, Daniel Borkmann wrote:
> > > On 7/4/25 11:58 AM, Jesper Dangaard Brouer wrote:
> > > > On 04/07/2025 03.17, Song, Yoong Siang wrote:
> > > > > On Friday, July 4, 2025 1:05 AM, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> > > > > > On 02/07/2025 18.57, Song Yoong Siang wrote:
> > > > > > > Introduce the XDP_METADATA_SIZE macro as a conservative measure to
> > > > > > > accommodate any metadata areas reserved by Ethernet devices.
> > > > > > 
> > > > > > This seems like a sloppy workaround :-(
> > > > > > 
> > > > > > To me, the problem arise because AF_XDP is lacking the ability to
> > > > > > communicate the size of the data_meta area.  If we had this capability,
> > > > > > then we could allow the IGC driver to take some of the space, have the
> > > > > > BPF-prog expand it futher (bpf_xdp_adjust_meta) and then userspace
> > > > > > AF_XDP would simply be able to see the size of the data_meta area, and
> > > > > > apply the struct xdp_meta at right offset.
> > > > > > 
> > > > > Thanks for your input.
> > > > > 
> > > > > I agree with you that the implementation will be simple if user application
> > > > > able to get the size of data_meta area. The intention of this patch set is to let
> > > > > developer aware of such limitations before we have a perfect solution.
> > > > > 
> > > > > Btw, do you got any suggestion on how to expose the metadata length?
> > > > > I not sure whether xdp_desc.options is a simple and good idea or not?
> > > > 
> > > > That is a question to the AF_XDP maintainers... added them to this email.
> > > > 
> > > > /* Rx/Tx descriptor */
> > > > struct xdp_desc {
> > > >       __u64 addr;
> > > >       __u32 len;
> > > >       __u32 options;
> > > > };
> > > > 
> > > > As far as I know, the xdp_desc.options field isn't used, right?
> > > 
> > > The options holds flags, see also XDP_PKT_CONTD and XDP_TX_METADATA.
> > > 
> > > > (Please AF_XDP experts, please verify below statements:)
> > > > Something else we likely want to document: The available headroom in the
> > > > AF_XDP frame.  When accessing the metadata in userspace AF_XDP we do a
> > > > negative offset from the UMEM packet pointer.  IIRC on RX the available
> > > > headroom will be either 255 or 192 bytes (depending on NIC drivers).
> > > > 
> > > > Slightly confusing when AF_XDP transmitting from userspace the UMEM
> > > > headroom is default zero (XSK_UMEM__DEFAULT_FRAME_HEADROOM is zero).
> > > > This is configurable via xsk_umem_config.frame_headroom, like I did in
> > > > this example[1].
> > > > 
> > > > Maybe I did something wrong in[1], because I see that the new method is
> > > > setting xsk_umem_config.tx_metadata_len + flag XDP_UMEM_TX_METADATA_LEN.
> > > > This is nicely documented in [2]. How does this interact with setting
> > > > xsk_umem_config.frame_headroom ?
> > > 
> > > If you request XDP_UMEM_TX_METADATA_LEN then on TX side you can fill
> > > struct xsk_tx_metadata before the start of packet data, that is,
> > > meta = data - sizeof(struct xsk_tx_metadata). The validity of the
> > > latter is indicated via desc->options |= XDP_TX_METADATA and then
> > > you fill meta->flags with things like XDP_TXMD_FLAGS_CHECKSUM to
> > > tell that the related fields are valid (ex. request.csum_start,
> > > request.csum_offset) and that you expect the driver to do the
> > > offload with this info. This is also what I mentioned in the other
> > > thread some time ago that imho it would make sense to have this also
> > > on RX side somewhat similar to virtio_net_hdr..
> > 
> > Let's at least document the current behavior where some (small minority of)
> > drivers can reuse the rx metadata area for some of its state? If we want
> > to improve on that by adding another knob, we can follow up?
> > (but I remember last time it was discussed, about a year ago, people
> > were not enthusiastic about another parameter exported as uapi)
> 
> But its still fundamentally broken no? Unless there is no harm for BPF devs
> to override that rx metadata area when the pkt later on goes up the stack, but
> it sounds this is not the case here. Iiuc, Yoong is trying a different approach
> now to prepend before data_hard_start [0]? Then if BPF prog needs it, igc
> already implements xmo_rx_timestamp callback which can copy it from there.
> 
>   [0] https://lore.kernel.org/bpf/20250707191742.662aeffb@kernel.org/

True, Jakub mentioned the same thread to me. This is, indeed, a better
idea!

