Return-Path: <linux-kselftest+bounces-42513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7478DBA55E1
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 00:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C2A326D7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 22:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63B293B75;
	Fri, 26 Sep 2025 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMmYyxbD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E426C3B6
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758927225; cv=none; b=CyBCxvGJr/QqdkD4wXXwc6PUhSXD4oXmeIPv4/H8NvJGRsg6DIt1yQAfTprGE0KRbiEk2J7LxvCIk9FZVSbBLrJRuhcqBIULYT0RofKZZV9D5pD0LZPSJTi62L0SK1sqKXzDdrXIN7Kcv7Ve0qxgcwYrYkm9s96fqfeYy3uiVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758927225; c=relaxed/simple;
	bh=fEomOeWR3k8vHaHxgyePZUTIkATiM1CSbm2n2U1m+B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAUWYZ24iyctIdUnh+qlC2yNbH9F73TyhwiF81Y/SFFy9VkYLwO/2wfuxnxhdnGh0o2Rd/vgrqnrfn3LfvJt+2qJEli6CvB5qjjfai50KDNxu/d9I5nQ2kQZoYgVFXfnoDa2HJz+XYeQeiKFS3+8Y/fxPcTCpfZulnJATRG4T1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMmYyxbD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78100be28easo2037082b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758927223; x=1759532023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L64jj/1bEf6Wb3tfKGPiM7Hcv1CIUMxOk206Ub6oLd8=;
        b=PMmYyxbD0YaFKI+2YT7DJGdSeDPhG94zrNIQx4VdrU3m8w4dwCKu7T6UeiitHXbmwT
         iuIIoUjSgLARZjpAsKyt23goMtb6FJ7D8QefdwvEASMoVzIxWtlkwBJkZIeFf5Y2Z6xi
         TaPIEqwdLRJ1itbKJ5g7tvzsktHFNXoyl6uitjM9QAKszWe4cRZQrnb3byl6Zlu3RfmH
         ngzeZxnFhyvmeNCR2NibUFS8CLYUg7tv8uUsnAbFi9pgzOs9mXdu8yk+h6YcGKQNI4w6
         WaXMoger9qHLon6cZUKi6buVW9Yf882SfT2RngkVD4Zo92ZI1HLCGVlAH0AzA6s0BcGM
         lWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758927223; x=1759532023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L64jj/1bEf6Wb3tfKGPiM7Hcv1CIUMxOk206Ub6oLd8=;
        b=brNIh/+/BJNu4KDou3OJhidhJFCYaOZRx2nt4QNSkjgubETdSeYKLznKw6z277hBh7
         kRePNxluaiku2rVy+0iznqf8UWdIXZrCc83l5ifvhW7q/aWS8C2GbWxij9K96sl71E0V
         49HLe17hf84lyEW3tw4juE+pxWcTOwCuf1uf/xk5tHLcBx6EKPsIz0FHjyHx+ZUOV8Fk
         3xBUx24CLxepRaIxNfqlYu6BPFrPnnioF2PhWoDpoTW/eRlmxM8XZw+710e+Uv51ONBW
         e1MlzmXzDYkxwNBQ5kJY9VHSlziRuNT9Fs7qq0gqD0jeaG44Y7hXXtTD5sy0y7AC9qRb
         ++Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXqUz1R9WMDn19icJmphQkn2vbSqqhx+eeeYrTbDUJAvdT+5QHigxGMcdgDBk9NazKmnv0Y4xEvqCcgx/vNW8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pV6cBT/rHKadPCyFa3wwilg8ljqLao9SVqr5tyY+Rm9XQMVV
	pwO6PFqw617OjvJGA2QKwFf2cr6INpdEkevppCEdWg6/9eQckbgLw7k=
X-Gm-Gg: ASbGncuioIoNfIc9y7+PMriMvEKENPtsfJsuIfTwXXTucj0lniPLVAAljcfxVzNxtMh
	ODhEWTg3tTIlHK8VcU3TBbJO1kkuEJU3lpV1WoAQEIDdgSeR0j826dBVKthoYblbmplfGmdD0Kp
	/KX8+48S+1ff4xQdaYNZnppCp1qp1fRAyAL7aF5NpMq4ZD4iBxDN6+ccp4HvY7WDElKGbYN7/eU
	VyAvjQBrBrmdgMiq5Fihm/6R62NMjwzs6erMvfQjr9XYa8DCErnaeY/d2dhKrbXRaIahjjApYLM
	prcNgNWaeVL1FoqJnHHFTlFC3qSz7Evp2hXPs4WOEuma7tgwmyJ0wQYwsDAK+ErdfVjCdplQn9m
	HkY+damz6s0jujIWPfN6Vzmpq9Ysg1k70H79M91YQO6qXBHz9XlMxxnehiPqcrvAV9KTH1KeCM5
	98x3ZU+I9nkEQzzzYL4FImT5hZY5suUMlO6uZXFQhATT7LVcGbvXVdcbhumsbsz/5vkk6NNKOw8
	DcmrvXCvGSmPVE=
X-Google-Smtp-Source: AGHT+IHzUVqGkwRKGx9oX64k2CwdiQYFO+LB2LrVkfcj7y3QFUFaw1ssnQ7tqKDzQxD8YBaWVCcYfg==
X-Received: by 2002:a05:6a00:2345:b0:77f:2e62:1e32 with SMTP id d2e1a72fcca58-780fce1f177mr9884757b3a.2.1758927222725;
        Fri, 26 Sep 2025 15:53:42 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-78102b22f5fsm5418527b3a.53.2025.09.26.15.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:53:42 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:53:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aNcZdfCivLR2slFw@mini-arch>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
 <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>

On 09/26, Jesper Dangaard Brouer wrote:
> 
> 
> On 26/09/2025 06.20, Stanislav Fomichev wrote:
> > On 09/25, Lorenzo Bianconi wrote:
> > > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > > checksum will be use by devices capable of exposing receive checksum
> > > result via bpf_xdp_metadata_rx_checksum().
> > > Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> > > eBPF program bounded to the device to retrieve the RX checksum result
> > > computed by the hw NIC.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > >   include/net/xdp.h                       | 14 ++++++++++++++
> > >   net/core/xdp.c                          | 29 +++++++++++++++++++++++++++++
> > >   3 files changed, 48 insertions(+)
> > > 
> > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
> > > --- a/Documentation/netlink/specs/netdev.yaml
> > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > @@ -61,6 +61,11 @@ definitions:
> > >           doc: |
> > >             Device is capable of exposing receive packet VLAN tag via
> > >             bpf_xdp_metadata_rx_vlan_tag().
> > > +      -
> > > +        name: checksum
> > > +        doc: |
> > > +          Device is capable of exposing receive checksum result via
> > > +          bpf_xdp_metadata_rx_checksum().
> > >     -
> > >       type: flags
> > >       name: xsk-flags
> > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d4f32544d8b9a30b63 100644
> > > --- a/include/net/xdp.h
> > > +++ b/include/net/xdp.h
> > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > >   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > >   			   bpf_xdp_metadata_rx_vlan_tag, \
> > >   			   xmo_rx_vlan_tag) \
> > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > +			   bpf_xdp_metadata_rx_checksum, \
> > > +			   xmo_rx_checksum)
> > >   enum xdp_rx_metadata {
> > >   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> > >   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > >   };
> > > +enum xdp_checksum {
> > > +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> > > +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> > > +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> > > +	XDP_CHECKSUM_PARTIAL		= CHECKSUM_PARTIAL,
> > > +};
> > 
> > Btw, might be worth mentioning, awhile ago we had settled on a smaller set of
> > exposed types:
> > 
> > https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zaremba@intel.com/
> > 
> > Maybe go through the previous postings and check if the arguments are
> > still relevant? (or explain why we want more checksum now)
> 
> IHMO the linked proposal reduced the types too much.

IIRC, PARTIAL was removed because it's mostly (or only) a TX feature?
So no real need to expose it as an rx hint. And I think empty xdp_csum_status
in that proposal might have indicated NONE?

