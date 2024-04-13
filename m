Return-Path: <linux-kselftest+bounces-7894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B98A3A05
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1461C21947
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714C41758B;
	Sat, 13 Apr 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQHVVdBh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FA17C73;
	Sat, 13 Apr 2024 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712970086; cv=none; b=taUVwucrUiqTt4MFfai2YzFCbTlK0wCmpkRLnoe82JFzGiDIxTWYnNbO5eZJ0mWX87j5uEBB8IRKDEjdQSLETfqgIquQDgC0MkfxqBvoSM6KmQOXuf5RjkSmCgn7gCd2qweaEnfatPWT5cn+DuZ14JUsXOIGWa+JilL5G8+Dna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712970086; c=relaxed/simple;
	bh=dhIdH/yzx6NlS07Ku2dfmWINjKd7hFkyfx7J5admUzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTC6P1w+pql/C0d643/7Al3kilAqYzYFcP0jNWtJuJC3HoBkZSadqVYLrVmffvpsHH2KG2XNv20vboOW4uyx1sLhspTnTUNb8CpScYnTBoX34cD6u3GhKrUsrTI97uHcB+BVNojnpwotoYJ7E7EiYfxxycdw/uEiG61Qle0IFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQHVVdBh; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ea128e4079so940785a34.3;
        Fri, 12 Apr 2024 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712970084; x=1713574884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDclmfrNlChR5+j7MnIqYqQVZXzLRNN3QFYjDNxcdSE=;
        b=kQHVVdBhTK1zbJ/jul+qQoaReFIi3D2ZWtltHtZ4pbQ5TriM02T4FXKrzorHUWnYda
         PqlFk4k61Zz1XWbhcJpg1uAl4WvJkS85zDKc0B+UqHa8PriVE6hFqC/Qg2G1z5L1qF/n
         NRcC5xcE8WU+2KMBtxasJe906WI0AxjGMbOLmpQS5b5LxO3o69Af+wHYU2W4BGCxEt7Z
         AQsVucErHf6JgSgLQQ8ICbQnzKqagwGZHJCFhe/VjuZFN98Ul25cc+Wg0yakc/iE34EJ
         MOPepI3V/z6R0P9eTeN6Z4BAYDA5X4OWI2WYHSUapdfHTS+8NMrVOxx5r/FrjSQdzQNv
         82/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712970084; x=1713574884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDclmfrNlChR5+j7MnIqYqQVZXzLRNN3QFYjDNxcdSE=;
        b=NRRHUGPL+55l5mcWoLEf9FJs+bwqICZyXNYyML5c7PKPlA+lhGOrgfCOGP38KJ7sfD
         KH0y8+XZBCKUfx9QOxDjQw1iBTf3duIrjWQrk+Xi0wRr81SNzheZMXUH1Qs6RSbsEUNZ
         hAT/XuS1ZoB/XtMmVpKRFc8BeNfEJ1e4FPTUOtPW8W7iq0uljtdKTuXYL/6NDcjsl7Us
         j/OlNTvnmy/3Qsr1M+bRwTO6UP5MJP2fBbokwX0j6FdNZs1c93BQ01Ogjy+NhFPdYK3E
         qcYXsQybyiuhSFf/y/4WF+KzsWptLCVR3e+9kONbFJ7jn3wsj8exScgq1AH336mYK8ya
         8y9g==
X-Forwarded-Encrypted: i=1; AJvYcCWmdU9UpidZ5oJnIqTF8PangNIMlfg8++8ei5T+6rPSNiu2IHVuVjymP0rKaidolqbbBnh4xMuXm7Mv87LxFkcvZLgir8Quv3GceW0qzITo9TNpSXm7aIWua84R
X-Gm-Message-State: AOJu0YyWXkfNnNweP4Q5xKJz4cMgJXbJ8mdNyw+88JG8zCUupkaTZG1b
	uOlEU8L99enjSfc3IZCqIDkTKO3htvX7H91k87G0aHMnXtswEpJR
X-Google-Smtp-Source: AGHT+IFV8d7tANhtv2uoKElHCf+6dS4SttJ5LFTyKTfMZWWQWu5q+PRKZH31Kc0vq2uIMBFS4QAtfA==
X-Received: by 2002:a05:6830:20d7:b0:6ea:2dba:b4b9 with SMTP id z23-20020a05683020d700b006ea2dbab4b9mr4686449otq.7.1712970083838;
        Fri, 12 Apr 2024 18:01:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a1a1:7d97:cada:fa46? ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id r19-20020a9d7513000000b006ea232492a7sm913130otk.44.2024.04.12.18.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 18:01:23 -0700 (PDT)
Message-ID: <5ad9aac3-6170-47cb-87be-b77d4425e31a@gmail.com>
Date: Fri, 12 Apr 2024 18:01:21 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 1/6] selftests/bpf: Fix bind program for big
 endian systems
To: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 Artem Savkov <asavkov@redhat.com>, Dave Marchevsky <davemarchevsky@fb.com>,
 Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>,
 David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240412165230.2009746-1-jrife@google.com>
 <20240412165230.2009746-2-jrife@google.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240412165230.2009746-2-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/24 09:52, Jordan Rife wrote:
> Without this fix, the bind4 and bind6 programs will reject bind attempts
> on big endian systems. This patch ensures that CI tests pass for the
> s390x architecture.
> 
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>   .../testing/selftests/bpf/progs/bind4_prog.c  | 18 ++++++++++--------
>   .../testing/selftests/bpf/progs/bind6_prog.c  | 18 ++++++++++--------
>   tools/testing/selftests/bpf/progs/bind_prog.h | 19 +++++++++++++++++++
>   3 files changed, 39 insertions(+), 16 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h
> 
> diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> index a487f60b73ac4..2bc052ecb6eef 100644
> --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> @@ -12,6 +12,8 @@
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
>   
> +#include "bind_prog.h"
> +
>   #define SERV4_IP		0xc0a801feU /* 192.168.1.254 */
>   #define SERV4_PORT		4040
>   #define SERV4_REWRITE_IP	0x7f000001U /* 127.0.0.1 */
> @@ -118,23 +120,23 @@ int bind_v4_prog(struct bpf_sock_addr *ctx)
>   
>   	// u8 narrow loads:
>   	user_ip4 = 0;
> -	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[0] << 0;
> -	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[1] << 8;
> -	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[2] << 16;
> -	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[3] << 24;
> +	user_ip4 |= load_byte_ntoh(ctx->user_ip4, 0, sizeof(user_ip4));
> +	user_ip4 |= load_byte_ntoh(ctx->user_ip4, 1, sizeof(user_ip4));
> +	user_ip4 |= load_byte_ntoh(ctx->user_ip4, 2, sizeof(user_ip4));
> +	user_ip4 |= load_byte_ntoh(ctx->user_ip4, 3, sizeof(user_ip4));
>   	if (ctx->user_ip4 != user_ip4)
>   		return 0;
>   
>   	user_port = 0;
> -	user_port |= ((volatile __u8 *)&ctx->user_port)[0] << 0;
> -	user_port |= ((volatile __u8 *)&ctx->user_port)[1] << 8;
> +	user_port |= load_byte_ntoh(ctx->user_port, 0, sizeof(user_port));
> +	user_port |= load_byte_ntoh(ctx->user_port, 1, sizeof(user_port));
>   	if (ctx->user_port != user_port)
>   		return 0;
>   
>   	// u16 narrow loads:
>   	user_ip4 = 0;
> -	user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[0] << 0;
> -	user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[1] << 16;
> +	user_ip4 |= load_word_ntoh(ctx->user_ip4, 0, sizeof(user_ip4));
> +	user_ip4 |= load_word_ntoh(ctx->user_ip4, 1, sizeof(user_ip4));
>   	if (ctx->user_ip4 != user_ip4)
>   		return 0;
>   
> diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
> index d62cd9e9cf0ea..194583e3375bf 100644
> --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> @@ -12,6 +12,8 @@
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
>   
> +#include "bind_prog.h"
> +
>   #define SERV6_IP_0		0xfaceb00c /* face:b00c:1234:5678::abcd */
>   #define SERV6_IP_1		0x12345678
>   #define SERV6_IP_2		0x00000000
> @@ -129,25 +131,25 @@ int bind_v6_prog(struct bpf_sock_addr *ctx)
>   	// u8 narrow loads:
>   	for (i = 0; i < 4; i++) {
>   		user_ip6 = 0;
> -		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[0] << 0;
> -		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[1] << 8;
> -		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[2] << 16;
> -		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[3] << 24;
> +		user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 0, sizeof(user_ip6));
> +		user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 1, sizeof(user_ip6));
> +		user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 2, sizeof(user_ip6));
> +		user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 3, sizeof(user_ip6));
>   		if (ctx->user_ip6[i] != user_ip6)
>   			return 0;
>   	}
>   
>   	user_port = 0;
> -	user_port |= ((volatile __u8 *)&ctx->user_port)[0] << 0;
> -	user_port |= ((volatile __u8 *)&ctx->user_port)[1] << 8;
> +	user_port |= load_byte_ntoh(ctx->user_port, 0, sizeof(user_port));
> +	user_port |= load_byte_ntoh(ctx->user_port, 1, sizeof(user_port));
>   	if (ctx->user_port != user_port)
>   		return 0;
>   
>   	// u16 narrow loads:
>   	for (i = 0; i < 4; i++) {
>   		user_ip6 = 0;
> -		user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[0] << 0;
> -		user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[1] << 16;
> +		user_ip6 |= load_word_ntoh(ctx->user_ip6[i], 0, sizeof(user_ip6));
> +		user_ip6 |= load_word_ntoh(ctx->user_ip6[i], 1, sizeof(user_ip6));
>   		if (ctx->user_ip6[i] != user_ip6)
>   			return 0;
>   	}
> diff --git a/tools/testing/selftests/bpf/progs/bind_prog.h b/tools/testing/selftests/bpf/progs/bind_prog.h
> new file mode 100644
> index 0000000000000..0fdc466aec346
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bind_prog.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __BIND_PROG_H__
> +#define __BIND_PROG_H__
> +
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +#define load_byte_ntoh(src, b, s) \
> +	(((volatile __u8 *)&(src))[b] << 8 * b)
> +#define load_word_ntoh(src, w, s) \
> +	(((volatile __u16 *)&(src))[w] << 16 * w)
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +#define load_byte_ntoh(src, b, s) \
> +	(((volatile __u8 *)&(src))[(b) + (sizeof(src) - (s))] << 8 * ((s) - (b) - 1))
> +#define load_word_ntoh(src, w, s) \
> +	(((volatile __u16 *)&(src))[w] << 16 * (((s) / 2) - (w) - 1))
These names, load_byte_ntoh() and load_word_ntoh(), are miss-leading.

They don't actually do byte-order conversion from network order to host
order. Network order is big endian. 0xdeadbeef in u32 should be stored
as the sequence of

   0xde, 0xad, 0xbe, 0xef

The little endian implementation of load_word_ntoh() provided here will
return 0xadde and 0xefbe0000. However, a network order to host order
conversion should return 0xbeef and 0xdead0000 for little endian.

The little endian implementation of load_byte_ntoh() here returns 0xde,
0xad00, 0xbe0000, and 0xef000000. However, a network to host order
conversion should return 0xef, 0xbe00, 0xad0000, and 0xde00000.

So, they just access raw data following the host byte order, not
providing any byte order conversion.


> +#else
> +# error "Fix your compiler's __BYTE_ORDER__?!"
> +#endif
> +
> +#endif

