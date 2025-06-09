Return-Path: <linux-kselftest+bounces-34516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57205AD26D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 21:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951017A9B63
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D621FF32;
	Mon,  9 Jun 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWk0zO2A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA82F4A;
	Mon,  9 Jun 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497640; cv=none; b=hdU3fKuGpM4eLJ95fSkWZAl8IGqksk9GGYwFR3w9xWTyKxHy6feg0F9te1Pm6BhDYyTKjozTYTvDjPzaVjQntrH36kLl6+RSe7a9d+PHNGVSHID8EamNZrV1q10yVsmutb5XpWxLh0i/QPsdrEHQWRHKm9IiPjedY+1l30iMjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497640; c=relaxed/simple;
	bh=0jArhGSz3UMEtySAtlHbYE5pxnqUAOSkObNt8gqJUmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POqN3PV9F+BTgUOoopAV2DZXAxQS+JjnopVKofCeHRJIi3YfZ2WGVaIUIZiqi42K8xVaAijCvPzmGt7HY3kq/KZ2r8ranuI7YiarStFzmVLCGWFbHxmRWQ+SIm40phb09KzI75QSkefWypWtaL8coR2uq5gT59khPP1/u3TuAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWk0zO2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E807C4CEEB;
	Mon,  9 Jun 2025 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749497640;
	bh=0jArhGSz3UMEtySAtlHbYE5pxnqUAOSkObNt8gqJUmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oWk0zO2A/E5mkOyjsJrGSXoEVjj7lQELngE4VTdtxHfnd1D9IIxqbmRCZE0CCQ0lB
	 pZx6mXFrD+xWoNYyOyvEcuHCvDDybsUw7lrmlP9ItzWP35jd2hd4cqMnmPi8KpdJaz
	 HG00rp0hH5/N8goHNuGxIN28Zn4EszcN01xQqfKi3dXM+rgRgLaJg040nKMMWwC16/
	 VYsFmy1JbySlXU/zfOKtPILSew2VuwjjrDCn4e6e2JHXV/nySoLnUmfUTVTqwiDjne
	 19SaoPXa5f6wptD93yqQkS4plcXR16klSqbC5rSxrHF25JJQYTjCtMcfBmbZq4NuJG
	 2N+SMb423lTlQ==
Date: Mon, 9 Jun 2025 12:33:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, John
 Fastabend <john.fastabend@gmail.com>, Boris Pismenny <borisp@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Ihor Solodrai
 <isolodrai@meta.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf,ktls: Fix data corruption when
 using bpf_msg_pop_data() in ktls
Message-ID: <20250609123358.4e024e62@kernel.org>
In-Reply-To: <20250609020910.397930-2-jiayuan.chen@linux.dev>
References: <20250609020910.397930-1-jiayuan.chen@linux.dev>
	<20250609020910.397930-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 10:08:52 +0800 Jiayuan Chen wrote:
> When sending plaintext data, we initially calculated the corresponding
> ciphertext length. However, if we later reduced the plaintext data length
> via socket policy, we failed to recalculate the ciphertext length.
> 
> This results in transmitting buffers containing uninitialized data during
> ciphertext transmission.
> 
> This causes uninitialized bytes to be appended after a complete
> "Application Data" packet, leading to errors on the receiving end when
> parsing TLS record.

Acked-by: Jakub Kicinski <kuba@kernel.org>

