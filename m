Return-Path: <linux-kselftest+bounces-34009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEA0AC8206
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 20:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8062A7AE679
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84422A7EC;
	Thu, 29 May 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvqwBrdI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542ED2AD31;
	Thu, 29 May 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542576; cv=none; b=q4/0VdAzoUODohX/dGXAgybQFIGwt2SfcQeEB53OVJsgoRPx5ATFE2ffrcTljW/x7GWcVooVdPnBOrZl/0lk8i3fquqnaSPv+yxexU4eL8z6GO0+JvBr6fXSnpNuE9bJihX68RC41j5AquGu1lP8zwW3ffLlUmI0V48GOPOXwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542576; c=relaxed/simple;
	bh=Ndkxafaee8/iJXBR/9wIrvk3wAPeoCIY5F3xoJ8MQeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2Z0eXdv/udoD7ZFXYPZHbwLbR8dci5IPsLab39amjSretCTFeBIfDbz9rCoR2gf1CAlsRaEoJ5fr3j87z/C1pa5koGvQFR8wKsEKQ5ivgh3//HPbVC+EPkB0U5xXm3MQxt59DCJZJaP9hUkp+L/z5HTBDaRxa7BLSkBvaoUtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvqwBrdI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-745fe311741so1335429b3a.0;
        Thu, 29 May 2025 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748542573; x=1749147373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wLWFabGjnu2pjZUWCnlpH8NuxluCsu9GKNAcPMcaZ8M=;
        b=fvqwBrdIzu3TLGhXH/iIadXVzkROACE+4svgiCk+BlyTO1YrSePeGwswJYcVQPCXpT
         RfsIo+vo5wf10wdKlPvQyVLJ23Oj1tVoeCeAirUc1kwsHMIn38tdCZQUCegBUgiBtpSV
         zddMFLJLyax5t6pBPuqkri8MdfqFd8pcYu9Qu1eetMKMzUksP5G8P3jmjzi8q3/OZ05L
         iG70tfL4mvrELwVLetFusX7kEXti8Z19jct46BEpSjqFh+EQwEh25fm25Nn+Qcnpu4cV
         B32FsLpxXTWfoJH/O/WA0b9tWizHoyVlK+9+blct44qpzec2Ggu3/FybUbzF30c/Qylz
         P/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748542573; x=1749147373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLWFabGjnu2pjZUWCnlpH8NuxluCsu9GKNAcPMcaZ8M=;
        b=k/8nIgsfmgpS0g7cjN59o5SLc7LrXOWjwTjIpGTDPS9a80tj97Rb6jfVKfRGGevqrs
         Z+q4EcFJNWxjISLJ6mMujB7CMvgwSidN28UQOZD+mE5sAh+H63ZkQNttJNsNy6j8eJEL
         iekfC4zseNGBWq/UUKyEJp0fRXBCuyM5B1RLg91xWBcoQxIKf57RUAvqJrdH6F7CILDZ
         4zhmozCQTrm9RxGLCxddn8aAqcNpvcM1io6BuRLakw0doYOWHNNq/YR3ih8MxIdW1yiE
         qgciETwoz14qgwFjLX9irivuQRczjUWJ1drosNj/qqqbvZNxvT89YYqle9NyUPfuM3Ha
         vtOA==
X-Forwarded-Encrypted: i=1; AJvYcCUkGm35seAoYUDC0EXNnFmVP20Sf4BAwyiRNE9OAuHq/RyXaJiTQxgysSjP6mi8wwZY7NpXKi8M@vger.kernel.org, AJvYcCW5gBVhXhR/B1WJ/1I1hsEcDkYdUUDu1NEikJBpBW2wMvwrEAiu2kAU5aGqGXUvKg+vtplnHa4OUndtk6mPRXKv@vger.kernel.org, AJvYcCWXN0hbrhBqN+0uOWZHv42k3iHdHBweTTedNIuPKg+Rx3E+ZOiEWQLogVSGI531LoL2cF19RJLlnh1Sw88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGSn11nQ42/niDtu2X7j3cmEjfoXXi0OjU00ySo44I1pV+453
	mY2OU6PRSF4Hqmn3bGHD8wSq2e8iPnNuB1m3xaV7NYhhWCztXhb5et5r
X-Gm-Gg: ASbGncs91nPD3h1fEWAXU3lO/w409YREEHOeVVHFVhf4m2Pm6uUrbmCzOEWwmJ6K8ya
	IPAd0dJEyVDnPBVcZ0OXKLCsD4Zit3c/Xz1wPXPX+dsuup9T7/cphKY4KlxgCn2YTk6/KRThi+K
	NVHkHXrNouRjHYg+nXf6lKYKEdhEH3VPloq6iaJHPIwODlD12PP9cLp6NsnZHpf/ADSyc6vHr5+
	D4k4xA4L2ODy1hCVuEorQZPrfHlA1CuW2zStuji6KRTVxwy04iXlUuNvHBUwNOepvmOtGfn+1I3
	YcJD4EoTdGq4G97YcDU387icMz1JcCTq0WBFQSRN/WakQqWxV3He+0g=
X-Google-Smtp-Source: AGHT+IHJe1nExEO/Gk3fjmlnSLJlBBab7HsdJ5qF4WOhLnq5aGIP+ewfPH1xG2NndfuxJCuOLv8QZA==
X-Received: by 2002:a05:6a00:847:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-747bd969f9cmr491255b3a.6.1748542573505;
        Thu, 29 May 2025 11:16:13 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe96781sm1630018b3a.29.2025.05.29.11.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 11:16:12 -0700 (PDT)
Date: Thu, 29 May 2025 11:16:11 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Ihor Solodrai <isolodrai@meta.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf,ktls: Fix data corruption when using
 bpf_msg_pop_data() in ktls
Message-ID: <aDika2FRd4n+VRmZ@pop-os.localdomain>
References: <20250523131915.19349-1-jiayuan.chen@linux.dev>
 <20250523131915.19349-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523131915.19349-2-jiayuan.chen@linux.dev>

On Fri, May 23, 2025 at 09:18:58PM +0800, Jiayuan Chen wrote:
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
> 
> Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/tls/tls_sw.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index fc88e34b7f33..b23a4655be6a 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -872,6 +872,21 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
>  		delta = msg->sg.size;
>  		psock->eval = sk_psock_msg_verdict(sk, psock, msg);
>  		delta -= msg->sg.size;
> +
> +		if ((s32)delta > 0) {
> +			/* It indicates that we executed bpf_msg_pop_data(),
> +			 * causing the plaintext data size to decrease.
> +			 * Therefore the encrypted data size also needs to
> +			 * correspondingly decrease. We only need to subtract
> +			 * delta to calculate the new ciphertext length since
> +			 * ktls does not support block encryption.
> +			 */
> +			if (!WARN_ON_ONCE(!ctx->open_rec)) {

I am wondering if we need to WARN here? Because the code below this
handles it gracefully:

 931                 bool reset_eval = !ctx->open_rec;
 932 
 933                 rec = ctx->open_rec;
 934                 if (rec) {
 935                         msg = &rec->msg_plaintext;
 936                         if (!msg->apply_bytes)
 937                                 reset_eval = true;
 938                 }
 939                 if (reset_eval) {
 940                         psock->eval = __SK_NONE;
 941                         if (psock->sk_redir) {
 942                                 sock_put(psock->sk_redir);
 943                                 psock->sk_redir = NULL;
 944                         }
 945                 }


Thanks for fixing it!
Cong

