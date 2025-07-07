Return-Path: <linux-kselftest+bounces-36699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C0DAFB6C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC3F423C56
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94A2E1C44;
	Mon,  7 Jul 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY+sawon"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A012E172B;
	Mon,  7 Jul 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900626; cv=none; b=dmIsaSAt3uDhVLEoSrkhZsbPx1meF2rMZiPckz3PQGhIZIM9/uhS7u36Y39b4uNYSvmnNptBe+eT8Z8qpio0g1D+xLV7z1K+JTbEhnbSYFytyreBLRk0s2pAorTZ/ahQGHszENfIeyJvhh5qh3TxxeDZWTRRzo4q6RsjwrI+sTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900626; c=relaxed/simple;
	bh=8vpMMtLZ77ykFwEUeLprgWV5prX+b5ChNM4CEWq+U1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+maxgXjcx1Ho1fmgpJCNKJrCo5hlNFAzja5JwE6Zs+zsHeWCUattP6oDPdqIdPk1uxbPqweX4cbSOhjFHVNimWhZB0rjfnzP4HKvKRretBy9QN10IQjXhrEzBtCVAsSPV1FpSlwWGzu4Sjy1MfBhlzMqF1zqWot8wv+B4bdhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY+sawon; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso3698226a12.0;
        Mon, 07 Jul 2025 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751900623; x=1752505423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PvPiz+8bXdawtqTn2ILmtUwar4MxSLrzHLdkvYFKuoU=;
        b=HY+sawonyC9um/b7OhVpKkhgoZy+Xl56y9duBzzcsJeRDuJfb4/SKBKRkmY6qdowFr
         y27LOjTRWn7x7qu68KEyR8lPipxwuaTuB4rPJ4mepHcTnfgm2mMPx1xmkpDPX0v8hEu1
         lKcJfczcaOzdFxaiyiqEIzhcPvNPjcluNLDVAbybZZAEVRzYSPv0/fJ586euKO4ixM2e
         xMMyh+hb/SJp71QApCx0W33ZZf3AkAilkm7bOoI0283AcQ47bvjkxhnDIJEzLoLfsRmq
         kPmOnzNUSU1Tn5i0baZJd/Q0XVShF64SMKtnBi2i2ZG2+aKy43YjOu9dHdlwFiUtD8ne
         6UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751900623; x=1752505423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvPiz+8bXdawtqTn2ILmtUwar4MxSLrzHLdkvYFKuoU=;
        b=s2S7pOl9xHrGw/P2Hh6yfB4yWIDFMpGSm4IF3RvtbVMCVIlPDLku7efpDqNTMCYG1X
         mOuxunv90rjey4SUR02T4r5JXfuEkfIv/B0ObrQ8+rmtIPe27CUqX5VqkuwZtaoipI+j
         hiGYMQjTM1A4R6bqv47TBZtqTWwK7vzaF5sHGxoBLVMGQliQwOnapNTvHegjwti1I0Y8
         il+gRf3AKlfd7zyQ97Mf662+91ZHv3eiT0T2hSHUv0rhGUJNRk5slQCIu64JdK1RY5Wt
         7LAOojAk2jpZjlJpmC9/U1qgDyF0k6hq1FOtytrY0PrJ3GHJ7bR1hXC2gbO9RUqTALNE
         MEmA==
X-Forwarded-Encrypted: i=1; AJvYcCUoUk4JNpj5kND9kmGF11RvKqxHwu6j4A9q3st58DdkiMsr+FHG2jTGIdCWF7AkOp1HXtDEd4NuEnyEK8WQ@vger.kernel.org, AJvYcCVDwh+xrnFQC4AWNmv0DNVwQNaud4rYDHMf1V8cmRgqKuwj+4JsnJVxIHPetNd6rYFdK94=@vger.kernel.org, AJvYcCX378w9kJehT4vExHBcz0sbbA7URVe1tY0LfXqLOB2w1Jzp9AjoGGGJQG6VxdZ+FFeTCY48y0xnNWckwa39Ih0F@vger.kernel.org, AJvYcCXUdEA+kfeKL8HjIMtiBIxkn0oaUX6+TCbfr6GzQDIAAf9yaD2RARjDTmBKaN8NSVyobVbCPLZE@vger.kernel.org, AJvYcCXlO9W+ipvDTVOrAJTXVHv9kXARIlh0PzbOsyfjhKeFJLQwGRd+oG0dQ5SRZoxewujFrgh5jKT11F1T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8+ow8chSy3rrjg3wjI8bJPQ6rCJO38ainw23vCI6p73o2RvM
	sNue1T/O7b0vlC/nwFp5VI3WwdXbkRtf++92c1GI+U5qsReY0fKrVJg=
X-Gm-Gg: ASbGncvMbaL07dK38ztYphtSPwvGqLCLdjghzELHNG1ZtUN3rgb5Uxt3+7AiaKW06TE
	aRWNOXyAGPYyTWXzoAgvoZCKs8mMFOoel8IT5ty9Z0oT0yUgUEpULx3CQy1qFihMjb/+Snl0D8h
	kZHvQW6zpDCrgLWCyGLtvFuDYsBowyGK3+jVbfIJ03okpTXjSx4J8yY+tvinNqlks/AIs7Ag3x9
	8a5bdnH8R/y/OtUlpXJxLWW0svbslg4kXlWT/TVkbGqX6PyIepVuayAf7Wq8U1pXXK+Bgex1zGd
	YUIITCMYL+ZKIXqg26C0duB++ezTejAgxo4VRjEcSgBTTR74O5Med3/WvbPCgT567YKiVIT4I+h
	Dx1sXSkAaxH2AS1OTHkiscd+yMPMf/nOG1Q==
X-Google-Smtp-Source: AGHT+IGvlZOBcUhR/1tVJDqiFwZYhKHSIOJlcGfOmFaKACrXzn5rUykyWIsigtYL0QKTocWbHdKcFA==
X-Received: by 2002:a17:90b:2e47:b0:311:abba:53d2 with SMTP id 98e67ed59e1d1-31aba8be13amr15776019a91.17.1751900623342;
        Mon, 07 Jul 2025 08:03:43 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31ac2f7ba56sm5415618a91.36.2025.07.07.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:03:41 -0700 (PDT)
Date: Mon, 7 Jul 2025 08:03:40 -0700
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
Message-ID: <aGvhzDLSuOolCCWW@mini-arch>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
 <20250702165757.3278625-3-yoong.siang.song@intel.com>
 <77463344-1b1a-443a-97be-a7ef8a88b8af@kernel.org>
 <IA3PR11MB92546301B67FB3A9FDCD716DD842A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <88a64a65-bd8c-4b73-af19-6764054d4572@kernel.org>
 <f5d724ab-0eb6-41a1-b694-8aea566e99ab@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5d724ab-0eb6-41a1-b694-8aea566e99ab@iogearbox.net>

On 07/04, Daniel Borkmann wrote:
> On 7/4/25 11:58 AM, Jesper Dangaard Brouer wrote:
> > On 04/07/2025 03.17, Song, Yoong Siang wrote:
> > > On Friday, July 4, 2025 1:05 AM, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> > > > On 02/07/2025 18.57, Song Yoong Siang wrote:
> > > > > Introduce the XDP_METADATA_SIZE macro as a conservative measure to
> > > > > accommodate any metadata areas reserved by Ethernet devices.
> > > > 
> > > > This seems like a sloppy workaround :-(
> > > > 
> > > > To me, the problem arise because AF_XDP is lacking the ability to
> > > > communicate the size of the data_meta area.  If we had this capability,
> > > > then we could allow the IGC driver to take some of the space, have the
> > > > BPF-prog expand it futher (bpf_xdp_adjust_meta) and then userspace
> > > > AF_XDP would simply be able to see the size of the data_meta area, and
> > > > apply the struct xdp_meta at right offset.
> > > > 
> > > Thanks for your input.
> > > 
> > > I agree with you that the implementation will be simple if user application
> > > able to get the size of data_meta area. The intention of this patch set is to let
> > > developer aware of such limitations before we have a perfect solution.
> > > 
> > > Btw, do you got any suggestion on how to expose the metadata length?
> > > I not sure whether xdp_desc.options is a simple and good idea or not?
> > 
> > That is a question to the AF_XDP maintainers... added them to this email.
> > 
> > /* Rx/Tx descriptor */
> > struct xdp_desc {
> >      __u64 addr;
> >      __u32 len;
> >      __u32 options;
> > };
> > 
> > As far as I know, the xdp_desc.options field isn't used, right?
> 
> The options holds flags, see also XDP_PKT_CONTD and XDP_TX_METADATA.
> 
> > (Please AF_XDP experts, please verify below statements:)
> > Something else we likely want to document: The available headroom in the
> > AF_XDP frame.  When accessing the metadata in userspace AF_XDP we do a
> > negative offset from the UMEM packet pointer.  IIRC on RX the available
> > headroom will be either 255 or 192 bytes (depending on NIC drivers).
> > 
> > Slightly confusing when AF_XDP transmitting from userspace the UMEM
> > headroom is default zero (XSK_UMEM__DEFAULT_FRAME_HEADROOM is zero).
> > This is configurable via xsk_umem_config.frame_headroom, like I did in
> > this example[1].
> > 
> > Maybe I did something wrong in[1], because I see that the new method is
> > setting xsk_umem_config.tx_metadata_len + flag XDP_UMEM_TX_METADATA_LEN.
> > This is nicely documented in [2]. How does this interact with setting
> > xsk_umem_config.frame_headroom ?
> 
> If you request XDP_UMEM_TX_METADATA_LEN then on TX side you can fill
> struct xsk_tx_metadata before the start of packet data, that is,
> meta = data - sizeof(struct xsk_tx_metadata). The validity of the
> latter is indicated via desc->options |= XDP_TX_METADATA and then
> you fill meta->flags with things like XDP_TXMD_FLAGS_CHECKSUM to
> tell that the related fields are valid (ex. request.csum_start,
> request.csum_offset) and that you expect the driver to do the
> offload with this info. This is also what I mentioned in the other
> thread some time ago that imho it would make sense to have this also
> on RX side somewhat similar to virtio_net_hdr..

Let's at least document the current behavior where some (small minority of)
drivers can reuse the rx metadata area for some of its state? If we want
to improve on that by adding another knob, we can follow up?
(but I remember last time it was discussed, about a year ago, people
were not enthusiastic about another parameter exported as uapi)

