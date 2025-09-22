Return-Path: <linux-kselftest+bounces-42070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF33B91FE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 17:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402EE188C525
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C42EA741;
	Mon, 22 Sep 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBlmArr3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776102EA729
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555545; cv=none; b=rRbT87/Xqs2poTY4JLmgUXSDUXKkT09W8lzkkLShrAkYA/RVcE6xpUlTyfQ+UnlY+rBnRsWSIgzd+UV1YQRcIw0ghAKLx0JJVZnARt2NIwOih0ySPcNIs3Qhz6yIL1VvuL9uqHKBl0wfwfK5u7t0sFhaWEoMgKUXcNm1diGBdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555545; c=relaxed/simple;
	bh=+pi56O3b51xWpK/gynXOWLU473m1ZZ7txSI/RgTjuqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnZsPHmsUjaOhsAz8q7J2aIPN2dNYl2BVqqkAmw833bFDyv2WncalicCm05TuZhZktPxkiDRQef4mB0Hk9An0juOgwNz2QP48e3rUV/NalhfeOOmx4sEGnwpU891pMF3KycoUMwMiW7+x0JUe5Xxi6ttCjWZIc7DlCJqwbe8iUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBlmArr3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f2077d1c8so1461478b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758555544; x=1759160344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+2ag/iV4mxazDtCnvPykVJFi1jwwbRDl7dA4X3Ytkc=;
        b=QBlmArr31oLL8Kd3LI497dLTRX/SlDIDr77UHPMRb0qMIjWX1jN1pGgWAVgp0n3wK8
         5iLJ9+1fMAN22qftQ+idM7DmNplpXnuuU6SrQ3fj2iYSNofBsyVxeJG6KV4bi3MO1MmL
         VaSBYmTAelgPP4vIWp1EeF4QkeePuT4BfpmRxv5EVT/24XGrJ4VVtn+Z81eAh5ukZxSy
         zEj/99O4KL2z79o/YVrqjulLaD4jaC2uSlUy6L7BTmf6cmNWcv/wUXgpllef9xGfuJc6
         04BOvmM7dPeIUJ6a/1a+JsPQgFbTWRh0L5qFs8X1QoeRJ7BpfBpuZeUdON9Kva4MwLN9
         ITXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555544; x=1759160344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+2ag/iV4mxazDtCnvPykVJFi1jwwbRDl7dA4X3Ytkc=;
        b=Zi0rUyNtdswyJJBCCMuQTjS0SyYbY0O3vA8q3B0izwmMpb2YOvrtrJzMCnS3vPPpE/
         6o6BmRbG67tJCJEElefscH/6/cS6TGj3W40qJobMTkpyP/QMusqFVvwRxB2SiQvhBBhO
         UTzEcHkUO1FGi3jvGg/bVisFvaIps/uJfYG/yugY+ZmSxtez7O+173nT5se50M5WbGzX
         iidrHCHsTIaYIUBFuMQtezUi+9Cuv28yBBad/ZV1IGaVuwCVs/LhLNzQsHfyqn/hf9ry
         MlkfbG9gpw02c5Mlg8YwIAJSseTJU+ZI6QpGO4jAC98SMibviRCU3lff3S8Vtm1yknib
         aoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/0jXuN4T07S3+aaLqGp1s83uRSSxr4PoxrIz4HUdLTYC1dOBR9zcPZRmF2ooEfItzxcwAtGqaqie5Fuz9B8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJeQ5ZB/plR9wzJkVvvcgZNbn5NU+f0GplDwwV+kBblGA5RtvY
	CtXU6xG9Mm+DmmT6AfAnwEmFltUvOkqH5cDRzw9tUheEt4PjbyO5Uy0=
X-Gm-Gg: ASbGncsCNV3/PhbWfFXmmB7mj7e8SuxwInHRpqIuTCBkgkF+xCryFA6l2CcTwSXnWi9
	X4+w8iVRMwPxkrvpY6dCBj/k+Us4debD8Ybzcy0WWr1bwGtkFF6p/jr0y2R3nM2x8rNnWk+PeSx
	nT8pv7NnMJkHsi4rlvreLeiQvhErEZDacp7ds5aB4QHsX9aCYa7GCqLRgmiFbcGo0DHKWoNgkCZ
	c9PQPz2ti9fELKG73TaHWjwYm3zSJOehMnT8XeUEgXzA0KORAoJgaPQ7FbkPotuFv6ZR/vgBSIQ
	RXgPyod2j4OrslEo5n4Qpq0qdxuLyB2mP6SaeDIow8UphU9wjwJPTqQfZwvGsnb2HH1kGeqHmr7
	QjU9Jy0QCWFH/zwh8PXi1NzwZi8oUCEh+RPWwXPy1A2J4CY9la7jZObYpHNT1QSaAtDBE2PIDP4
	a2Ejicw/FZkBDR7x0oxiu08xiMuBgQJtkhlOztja0tXXe9hRov+Vd1WnlQugOWt2ZOjP0DCVjWV
	RK3
X-Google-Smtp-Source: AGHT+IE3TS2ZT2iVwXx8IVuVRd65DCwplvU4zTMTt2k1/M2gr1xCgjuzcB7lSRGACmTncGG25EZblA==
X-Received: by 2002:a05:6a20:4327:b0:245:ffe1:5619 with SMTP id adf61e73a8af0-292189dd44emr15040347637.23.1758555543694;
        Mon, 22 Sep 2025 08:39:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b55149526cfsm10207767a12.36.2025.09.22.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:39:03 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:39:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
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
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aNFtljcYeLK3uVo3@mini-arch>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
 <20250920-xdp-meta-rxcksum-v1-1-35e76a8a84e7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250920-xdp-meta-rxcksum-v1-1-35e76a8a84e7@kernel.org>

On 09/20, Lorenzo Bianconi wrote:
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -61,6 +61,11 @@ definitions:
>          doc: |
>            Device is capable of exposing receive packet VLAN tag via
>            bpf_xdp_metadata_rx_vlan_tag().
> +      -
> +        name: checksum
> +        doc: |
> +          Device is capable of exposing receive checksum result via
> +          bpf_xdp_metadata_rx_checksum().
>    -
>      type: flags
>      name: xsk-flags

nit: let's fold it into patch 2? Will be easier to git blame the
feature..

