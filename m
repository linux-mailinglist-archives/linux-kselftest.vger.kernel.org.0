Return-Path: <linux-kselftest+bounces-14275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EDA93D792
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 19:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B1B1C23134
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819AC17C9F3;
	Fri, 26 Jul 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FdiAcVPy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD617C208
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014859; cv=none; b=Ie+ynSTewT4lw3k/tyjkZJed48hVQZ+Q92Jrszj6A4I3a2EhP5E8+i1slLdFFuQHFegaZVHwNG7SKyGldMsiFPXwS3ZErT+0nrY9P+wg283x+iRflBG4ptXLGg6AT9qshWGzUOfh5xDuyuDV9dkPDYL2+uGh1DmellkLd3T+7eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014859; c=relaxed/simple;
	bh=qFGlvMhteFMAaqJUl6N6Xqh/+JZvLGYqyFFAThGVfPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6/rcaA46kRhx2N3E7vmm986ENyFBi/fhiekU7zC6YMcPzg1xslNbvRIx6f5yEHYvZjQj7gGY/gDwA9DtyK3R5xNABYcHk0IYSHjhQKet19dGD1z+emjqBVQL6yW17QWKGJ7XcU/KrcJ6+ihrCbheSDhNhnSR2adp2X0KBqDvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FdiAcVPy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so3019607a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722014856; x=1722619656; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EyOtirsWmopDCe9GEITwcgKLVaDmjcC2IWcfFdj4as=;
        b=FdiAcVPylSmsObz1AIiSgfOzBnHxjeMKeXdSNIe9ZHlGLLLgyDGOMVKUWqh/4EgRqn
         3txQ28itDx7+JueNKIZY6k2RMY4NgNa5F+pkTHdjlD3X4KqgZP2s5WC89EAUuVrdxh3/
         wF1t8nl/SEcEXrLgMhfTGS31BeKPUGHmno79mnb9bac6VlohruNv10JJUn/+IP96wyhN
         WTkwRbROgz0QP1H/jDXfsHVLPsjQz5C/Sqagd63zmHxabLK8sHNT3y6tCJqYs5zqWV6T
         gjuQ75o8DkzhOyOVqlAFkOwuS5ZeDKrqYwZ2syW1fnfSRiIN4f4gn3BVDQMQay+YRvlE
         GcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014856; x=1722619656;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EyOtirsWmopDCe9GEITwcgKLVaDmjcC2IWcfFdj4as=;
        b=NXsoKGmW97e500y7AbhpDp8nSFsana1ttguKSqvgW5y7rJw4ppycasuzox3oRgVpbD
         rfzYkaSVGtn6MnEbBr6SSNZTuvw2blUWHH91k6K2rV+PVx0zAD1nvgvnU2U8ABKIibUy
         QGGy14KUdCU0IdVMFKFERvFMXzd+7dkdCA1lVQuVxW5kMgp3T3MEWaD2HL4dZTUKOfWN
         ZmFHOX59yYz8YJaWwzPwTrz0HkwnXBQaCifMJAFdkHvjdO0e8OciOLbecpYRG4uF4pw9
         IT0Wn3Ier4wx3pssx6dcm4YH09l0FNyeJ12mniP4ivzuyKfB/I4q9RpgKeyhbXhr7D9C
         WSXA==
X-Forwarded-Encrypted: i=1; AJvYcCWVdRvX3VlOtcOHA8EfFbNT7gigYtTVBsUTjdGiz/x9EqBgPjBMj9EQG1lkzur/vLAj4vR7jlmpyeQmVtSMjpV7tRLb+d3efM3YSjX44AUl
X-Gm-Message-State: AOJu0Yx1RY4oNdx0zU6XEs+nZFE+1s0xmDMdzNZL8effkG6rxxNPCvUG
	p06xc8aySZYwGyqJ58t1NUrpB7ikGUWlaTGs7IeXI0X13b7LBZRISe2XwcUfSiE=
X-Google-Smtp-Source: AGHT+IHvx2x2riTEqoxuCBwrXZm2KqzJYh/bqylu0umjwLin316iEYSM6CBdYzfcsDW46OEMhID5rw==
X-Received: by 2002:a17:907:7d86:b0:a72:5f9a:159a with SMTP id a640c23a62f3a-a7d3ff583a6mr16652066b.2.1722014856217;
        Fri, 26 Jul 2024 10:27:36 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab50cbfsm197311866b.47.2024.07.26.10.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:27:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 6/6] selftest/bpf: Introduce
 __attribute__((cleanup)) in create_pair()
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-6-46165d224712@rbox.co>
	(Michal Luczaj's message of "Wed, 24 Jul 2024 13:32:42 +0200")
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
	<20240724-sockmap-selftest-fixes-v1-6-46165d224712@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 26 Jul 2024 19:27:34 +0200
Message-ID: <878qxokqrd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 24, 2024 at 01:32 PM +02, Michal Luczaj wrote:
> Rewrite function to have (unneeded) socket descriptors automatically
> close()d when leaving the scope. Make sure the "ownership" of fds is
> correctly passed via take_fd(); i.e. descriptor returned to caller will
> remain valid.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  .../selftests/bpf/prog_tests/sockmap_helpers.h     | 57 ++++++++++++----------
>  1 file changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> index ead8ea4fd0da..2e0f9fe459be 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> @@ -182,6 +182,21 @@
>  		__ret;                                                         \
>  	})
>  
> +#define take_fd(fd)                                                            \
> +	({                                                                     \
> +		__auto_type __val = (fd);                                      \
> +		fd = -EBADF;                                                   \
> +		__val;                                                         \
> +	})

Probably should operate on a pointer to fd to avoid side effects, like
__get_and_null macro in include/linux/cleanup.h. take_fd is effectively
__get_and_null(fd, -EBADFD).

> +
> +static inline void close_fd(int *fd)
> +{
> +	if (*fd >= 0)
> +		xclose(*fd);
> +}
> +
> +#define __close_fd __attribute__((cleanup(close_fd)))
> +
>  static inline int poll_connect(int fd, unsigned int timeout_sec)
>  {
>  	struct timeval timeout = { .tv_sec = timeout_sec };
> @@ -369,9 +384,10 @@ static inline int socket_loopback(int family, int sotype)
>  
>  static inline int create_pair(int family, int sotype, int *p0, int *p1)
>  {
> +	__close_fd int s, c = -1, p = -1;
>  	struct sockaddr_storage addr;
>  	socklen_t len = sizeof(addr);
> -	int s, c, p, err;
> +	int err;
>  
>  	s = socket_loopback(family, sotype);
>  	if (s < 0)
> @@ -379,25 +395,23 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
>  
>  	err = xgetsockname(s, sockaddr(&addr), &len);
>  	if (err)
> -		goto close_s;
> +		return err;
>  
>  	c = xsocket(family, sotype, 0);
> -	if (c < 0) {
> -		err = c;
> -		goto close_s;
> -	}
> +	if (c < 0)
> +		return c;
>  
>  	err = connect(c, sockaddr(&addr), len);
>  	if (err) {
>  		if (errno != EINPROGRESS) {
>  			FAIL_ERRNO("connect");
> -			goto close_c;
> +			return err;
>  		}
>  
>  		err = poll_connect(c, IO_TIMEOUT_SEC);
>  		if (err) {
>  			FAIL_ERRNO("poll_connect");
> -			goto close_c;
> +			return err;
>  		}
>  	}
>  
> @@ -405,36 +419,29 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
>  	case SOCK_DGRAM:
>  		err = xgetsockname(c, sockaddr(&addr), &len);
>  		if (err)
> -			goto close_c;
> +			return err;
>  
>  		err = xconnect(s, sockaddr(&addr), len);
> -		if (!err) {
> -			*p0 = s;
> -			*p1 = c;
> +		if (err)
>  			return err;
> -		}
> +
> +		*p0 = take_fd(s);
>  		break;
>  	case SOCK_STREAM:
>  	case SOCK_SEQPACKET:
>  		p = xaccept_nonblock(s, NULL, NULL);
> -		if (p >= 0) {
> -			*p0 = p;
> -			*p1 = c;
> -			goto close_s;
> -		}
> +		if (p < 0)
> +			return p;
>  
> -		err = p;
> +		*p0 = take_fd(p);
>  		break;
>  	default:
>  		FAIL("Unsupported socket type %#x", sotype);
> -		err = -EOPNOTSUPP;
> +		return -EOPNOTSUPP;
>  	}
>  
> -close_c:
> -	close(c);
> -close_s:
> -	close(s);
> -	return err;
> +	*p1 = take_fd(c);
> +	return 0;
>  }
>  
>  static inline int create_socket_pairs(int family, int sotype, int *c0, int *c1,

This turned out nice and readable, IMHO.

