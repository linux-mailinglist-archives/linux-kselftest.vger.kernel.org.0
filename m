Return-Path: <linux-kselftest+bounces-33328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37819ABC247
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823AD166004
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B078528540C;
	Mon, 19 May 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLc6Jory"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8BB2746A;
	Mon, 19 May 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668100; cv=none; b=HjkldhlmwznB7xW/wVt9PzHIOuMajhIFcYh+ayfd715NhwkFLHoiPhbdS+VB4T+nN7BjgJIUBXPffQgAW03oHXvGl3OZNHCFNrVbaDyVaVSly6cUA2A9EshG/W9Vy4daUglWpuj0GsdDXySGMo/z10IdDq5vJqRs2E3wI4yTsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668100; c=relaxed/simple;
	bh=RVXtJ3Hgloiyq4jFttX2VpdBU903R2f64hKm7Okmdt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHrWBKEPHJKL+TP2+TsHJNWjyRgILLoPIKs2egapyclYixeItkiWGCZ6KRvntSFYE+4mhRGKKegUX8kxCarCpPEIziIREJsL6h0jCE8FQtk34pNxeCVCYkYg30hhrJACKdUZWaJsRJPw4FLQiZzB9pQOu14dX5WDo6qTTCXVR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLc6Jory; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26ef4791a5so3037279a12.1;
        Mon, 19 May 2025 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747668098; x=1748272898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pP+CIRb3oAnFziDleY6R4gYNZjLfVO4ecwsp7NW2bUg=;
        b=eLc6JoryfyWM0AiPWeACwIHU//024JYRBzkBSCphi1Hv4xgkKuTpVb98VxhN1EDQZQ
         6ZBA5EneoGx8GJoj3380n+MDY3YuiVlylBlG5sBh+gz/r4jClqyu8uGmdhoonJ+IfVCp
         c4Y0rzjs4QonTWhhU9igh8MqFB9jsSE8NwUObs2UNTqix9oJUyqyK9UpMpiP/Kx5eeUI
         QI2uKp94sd2lS6k7Jf9vhEf4bWcsRccLOH1zFuoh7kW7kjW8bKRCKX7cCA6ayUJ0Ytha
         QThUVbU//BKUGx2f+2KYOMNpvFBWYvWnVX0+1o1LEpI3NjfH3FhejW8RnXxhTaeJvS8l
         Cznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747668098; x=1748272898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP+CIRb3oAnFziDleY6R4gYNZjLfVO4ecwsp7NW2bUg=;
        b=RIQZHOKNdbpO1vZ097t+YbH0Ho/4h/niRKXifMFW2fTbfDhVKcPnOTVXSkKIzkFiu9
         AJTP2efal43ffP9+L/icVIUliXhi/BDYYQcSkQkqd3dDPj6LaBVg/+U6S9tt2RPK7lAp
         kgQ/MQ5xpT84Nhnwp04+Nf9DjmjF0pTExmom1OcPdkKjzkxLJUM+OnVEj2Dek46a/4Yw
         znWUlAKmysMhsvselOvy691e+Dj4Th/Yc8Qwe79XmqckSTfNPHzzEDjxrKQq9qBLEc2j
         CEpmjJF5L0P2IndkfKbKqDzKjVbsuRzLmD+ARxsP/i8RNdZd4F+ZZlIwaE+ZvlETvks4
         YTgw==
X-Forwarded-Encrypted: i=1; AJvYcCVQytVqzQWSCvLIPdspHI8GDhylRyYuU/ZyEO6QQfXd8MIW0WskAPgtUSXBdQPbSyZsehQfghIi+BO7Llg=@vger.kernel.org, AJvYcCVtEdbwG1aR43B1PaQPwHE8DbSnDAKoeKbi82aI6lq3jPrm55r/tttNtK/txrcRexcnWbhphN39gdSLdyHETSDF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TW3yv1xzcwdkcDkmI5ItT7GdYNVprqWx9N9mg5y+lk/EuAZD
	bHxD2rUVQYwYTu+qOsLZ4ZQbc6l2aWvuYYy8WzZKCa0mi4dc/2I5YII=
X-Gm-Gg: ASbGnct7l4G0rzw7yrSEF1KDP3mPqRCp7CcAXvpYNUtT/IrMPCQKbMVMMQSYvDVdxd1
	pIrImv7s1sb+vGedd8CEiNO5KUkYGDOBkMG62DZwcNXMoERF40BqFECFkB4lFQPem4axKEUvZ/F
	/KxeGw+FOwHX0y42gs4vSa716ZSbIPS3NRiLYXbHNXT0Cqejb2DcWRWqN6H5CDqsAl7ykiwIH63
	n7rvui3oR91URg67FXhlQsqu2K0MsCjoqTBqMukAkmzW6KZWjSgMN214K5Bj4XzhVBBvNOOBpdS
	ur2HsoY0zJE4dIt7y+ZEx+KSfJ3M+D6EL4cKCWSOCyMrmUhtfDpa3Klq8ZgSzSKIYyJ3Yd7GErB
	55he0pi/mvVG+
X-Google-Smtp-Source: AGHT+IG9p6T9sjnpGwQxRU/WwwjS4aqcUhPR1D0pl6s0Q1KkLG2SDDssHEuip00DnSF9huvECWJFTg==
X-Received: by 2002:a17:903:174c:b0:232:2f8a:fbd7 with SMTP id d9443c01a7336-2322f8afee0mr77275175ad.11.1747668098096;
        Mon, 19 May 2025 08:21:38 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ebae66sm61321295ad.177.2025.05.19.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:21:37 -0700 (PDT)
Date: Mon, 19 May 2025 08:21:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v1 3/9] net: devmem: preserve sockc_err
Message-ID: <aCtMgDGQBbs0KkxZ@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519023517.4062941-4-almasrymina@google.com>

On 05/19, Mina Almasry wrote:
> Preserve the error code returned by sock_cmsg_send and return that on
> err.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  net/ipv4/tcp.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b7b6ab41b496..45abe5772157 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1067,7 +1067,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  	int flags, err, copied = 0;
>  	int mss_now = 0, size_goal, copied_syn = 0;
>  	int process_backlog = 0;
> -	bool sockc_valid = true;
> +	int sockc_err = 0;
>  	int zc = 0;
>  	long timeo;
>  
> @@ -1075,13 +1075,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  
>  	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags) };
>  	if (msg->msg_controllen) {
> -		err = sock_cmsg_send(sk, msg, &sockc);
> -		if (unlikely(err))
> -			/* Don't return error until MSG_FASTOPEN has been
> -			 * processed; that may succeed even if the cmsg is
> -			 * invalid.
> -			 */
> -			sockc_valid = false;
> +		sockc_err = sock_cmsg_send(sk, msg, &sockc);
> +		/* Don't return error until MSG_FASTOPEN has been processed;
> +		 * that may succeed even if the cmsg is invalid.
> +		 */
>  	}
>  
>  	if ((flags & MSG_ZEROCOPY) && size) {
> @@ -1092,7 +1089,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>  			skb = tcp_write_queue_tail(sk);
>  			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb),
> -						    sockc_valid && !!sockc.dmabuf_id);
> +						    !sockc_err && !!sockc.dmabuf_id);

Why have these extra !! here? Other places below simply do '&& sockc.dmabuf_id',
why not the same here? 

>  			if (!uarg) {
>  				err = -ENOBUFS;
>  				goto out_err;
> @@ -1102,7 +1099,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  			else
>  				uarg_to_msgzc(uarg)->zerocopy = 0;
>  
> -			if (sockc_valid && sockc.dmabuf_id) {
> +			if (!sockc_err && sockc.dmabuf_id) {
>  				binding = net_devmem_get_binding(sk, sockc.dmabuf_id);
>  				if (IS_ERR(binding)) {
>  					err = PTR_ERR(binding);
> @@ -1116,7 +1113,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  			zc = MSG_SPLICE_PAGES;
>  	}
>  
> -	if (sockc_valid && sockc.dmabuf_id &&
> +	if (!sockc_err && sockc.dmabuf_id &&
>  	    (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
>  		err = -EINVAL;
>  		goto out_err;
> @@ -1160,9 +1157,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  		/* 'common' sending to sendq */
>  	}
>  
> -	if (!sockc_valid) {
> -		if (!err)
> -			err = -EINVAL;
> +	if (!!sockc_err) {

Same here, I don't think we need these extra !! ?

