Return-Path: <linux-kselftest+bounces-7897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD478A3A1D
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38020B211C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451A4C97;
	Sat, 13 Apr 2024 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9lAojop"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5946BA;
	Sat, 13 Apr 2024 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712971719; cv=none; b=D7xM0Iuhe6B2mYjZbQGI6NG4fuHb7WzmH0YFnh1OM//hYFFMJx8qAhiM/fqXdPpry+gjdF7dSiYsA2Lpa3jm83J2J5UD7sg9Fkll+N2DVO3LfXuuA6c4sRYYN0XhhmSuiF4BdQQ9g/oCZAHFXGhg6GwCwRbkierEsWiN7Fypwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712971719; c=relaxed/simple;
	bh=WhAGBiQPPx/JGrPTj1iyKZo3W4T89PIdSEdK3xuYH78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKOmiSINLf9bMZQEAyXkzANqc+30x1v1LzUxXDPq484SfpxHS9uwrl8OEJoCdVVEB3fUKKvwVjwQCkJfO1cuUDaOyLChG8SLCXLpvZaYCaCp5WZ7pvJCQoSmPQdy8GMFuwNjBoz14wJLUZUmoQyiXv48dlTbXqK/DxkwCeM4hXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9lAojop; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c60adf3474so931737b6e.1;
        Fri, 12 Apr 2024 18:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712971717; x=1713576517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zt6e5bCgrRRc4HJwpKVPopcB/sjj2Exqawnuhflb4Tg=;
        b=N9lAojopF4NYUSs/88um+68R/i1XygNHodZlDqf3c5/7FsQH5vk0GxS8JbgmdvjjBY
         AflkCjf3jGojEHpLUvqpctITUdKPfW1nUElL4iaczJ2uKlXDHhDq40Cn4sPk7rHl3izk
         86JeZ4pXxEVF+c8l62aw7a5K94TR53q6QmM4/r8sdo+aLYEi5K5i3zKAmqcsBmoiRFXc
         KpCkeIYk8dSLVPUHxWEitZ0ll7fX8EpTQ3x/SU4mKgjCL0We2KHy0JYSBsrM3gU+ndIB
         xMjSWCRDaGR+EMP/VmsAsMgqAQbn7e3Qv5Cm+xzF05+kqf948iASp+bt8rH7JT/vIEM2
         pAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712971717; x=1713576517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zt6e5bCgrRRc4HJwpKVPopcB/sjj2Exqawnuhflb4Tg=;
        b=WTyue07JL5RPKOm4nC3BF8KHJz8Ysoaluc0DpVOrK8khynifay/kbGHhz0Pevls8S0
         CktSrTHwzUGn2vcOKuL0adWdzp260UlDrT3JuUy9mdmkPspDws4gS0/A4jHPuBpSdBVc
         RSO1Vx5KBbzW1XcRgcZ/YGD+3buVVfRbf+2Z/Rz5E/6GIMcd+HPnelJGSxOf27U2jUe0
         uJcRyBCxSc6VXVEUkKdhY2GjIsyqOeq3jL27twcir+hElRQshJK+jXJyWuZjbdM9nNbW
         psIqbmGk4m4GZh/Trl0dXGVsEmP5xShJ37NZ3W3NphI/y0JOG4YvD6YVUaFQrJw7A9d2
         vYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUip8oabkCLLmEZiMsZC0A19WOCfgM2F5QzL3GrqqsBGx3QAln/7X4n2AXHM9t2gBMZvNvgMAhdC2rUYPWCFoFKA8OXggLIX6Q5lgvclkYVyOORCm6Uv0dhlQNYJP2/8YhluqYIAJf7
X-Gm-Message-State: AOJu0YxLDxdMcwodLUajVuPyr3p4Q+TJ0WcV201pNBDbAuo/NaIRxmfR
	0juB8Ho7Fc8Q/Z4XKXYqGj2Z2GaHczOIsdAoN4c35hQcEhwqT/BC
X-Google-Smtp-Source: AGHT+IHlO+J77P0e6CLd4+Zxq2/FAAtzpgqWF10HD7biZPmjtiIpSVyXi+RosuU7X6w+vtwa1mJLoQ==
X-Received: by 2002:a05:6808:2803:b0:3c5:f302:e7d8 with SMTP id et3-20020a056808280300b003c5f302e7d8mr4541775oib.48.1712971717083;
        Fri, 12 Apr 2024 18:28:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a1a1:7d97:cada:fa46? ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0568081a1300b003c5fbfe3ac3sm789885oib.21.2024.04.12.18.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 18:28:36 -0700 (PDT)
Message-ID: <76467c84-3c6b-4859-a815-bee018b3364d@gmail.com>
Date: Fri, 12 Apr 2024 18:28:34 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 1/6] selftests/bpf: Fix bind program for big
 endian systems
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
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
 <5ad9aac3-6170-47cb-87be-b77d4425e31a@gmail.com>
 <CADKFtnR4qtPV4OP_Y04+ON+bKc8uPxxLZF3cTj-0YCupD6y06A@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CADKFtnR4qtPV4OP_Y04+ON+bKc8uPxxLZF3cTj-0YCupD6y06A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/12/24 18:17, Jordan Rife wrote:
> Kui-Feng,
> 
> You are right. Maybe simply "load_word" and "load_byte" would be a 
> better name here. WDYT?

Agree!


> 
> -Jordan
> 
> 
> On Fri, Apr 12, 2024 at 6:01 PM Kui-Feng Lee <sinquersw@gmail.com 
> <mailto:sinquersw@gmail.com>> wrote:
> 
> 
> 
>     On 4/12/24 09:52, Jordan Rife wrote:
>      > Without this fix, the bind4 and bind6 programs will reject bind
>     attempts
>      > on big endian systems. This patch ensures that CI tests pass for the
>      > s390x architecture.
>      >
>      > Signed-off-by: Jordan Rife <jrife@google.com
>     <mailto:jrife@google.com>>
>      > ---
>      >   .../testing/selftests/bpf/progs/bind4_prog.c  | 18
>     ++++++++++--------
>      >   .../testing/selftests/bpf/progs/bind6_prog.c  | 18
>     ++++++++++--------
>      >   tools/testing/selftests/bpf/progs/bind_prog.h | 19
>     +++++++++++++++++++
>      >   3 files changed, 39 insertions(+), 16 deletions(-)
>      >   create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h
>      >
>      > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c
>     b/tools/testing/selftests/bpf/progs/bind4_prog.c
>      > index a487f60b73ac4..2bc052ecb6eef 100644
>      > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
>      > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
>      > @@ -12,6 +12,8 @@
>      >   #include <bpf/bpf_helpers.h>
>      >   #include <bpf/bpf_endian.h>
>      >
>      > +#include "bind_prog.h"
>      > +
>      >   #define SERV4_IP            0xc0a801feU /* 192.168.1.254 */
>      >   #define SERV4_PORT          4040
>      >   #define SERV4_REWRITE_IP    0x7f000001U /* 127.0.0.1 */
>      > @@ -118,23 +120,23 @@ int bind_v4_prog(struct bpf_sock_addr *ctx)
>      >
>      >       // u8 narrow loads:
>      >       user_ip4 = 0;
>      > -     user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[0] << 0;
>      > -     user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[1] << 8;
>      > -     user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[2] << 16;
>      > -     user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[3] << 24;
>      > +     user_ip4 |= load_byte_ntoh(ctx->user_ip4, 0, sizeof(user_ip4));
>      > +     user_ip4 |= load_byte_ntoh(ctx->user_ip4, 1, sizeof(user_ip4));
>      > +     user_ip4 |= load_byte_ntoh(ctx->user_ip4, 2, sizeof(user_ip4));
>      > +     user_ip4 |= load_byte_ntoh(ctx->user_ip4, 3, sizeof(user_ip4));
>      >       if (ctx->user_ip4 != user_ip4)
>      >               return 0;
>      >
>      >       user_port = 0;
>      > -     user_port |= ((volatile __u8 *)&ctx->user_port)[0] << 0;
>      > -     user_port |= ((volatile __u8 *)&ctx->user_port)[1] << 8;
>      > +     user_port |= load_byte_ntoh(ctx->user_port, 0,
>     sizeof(user_port));
>      > +     user_port |= load_byte_ntoh(ctx->user_port, 1,
>     sizeof(user_port));
>      >       if (ctx->user_port != user_port)
>      >               return 0;
>      >
>      >       // u16 narrow loads:
>      >       user_ip4 = 0;
>      > -     user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[0] << 0;
>      > -     user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[1] << 16;
>      > +     user_ip4 |= load_word_ntoh(ctx->user_ip4, 0, sizeof(user_ip4));
>      > +     user_ip4 |= load_word_ntoh(ctx->user_ip4, 1, sizeof(user_ip4));
>      >       if (ctx->user_ip4 != user_ip4)
>      >               return 0;
>      >
>      > diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c
>     b/tools/testing/selftests/bpf/progs/bind6_prog.c
>      > index d62cd9e9cf0ea..194583e3375bf 100644
>      > --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
>      > +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
>      > @@ -12,6 +12,8 @@
>      >   #include <bpf/bpf_helpers.h>
>      >   #include <bpf/bpf_endian.h>
>      >
>      > +#include "bind_prog.h"
>      > +
>      >   #define SERV6_IP_0          0xfaceb00c /*
>     face:b00c:1234:5678::abcd */
>      >   #define SERV6_IP_1          0x12345678
>      >   #define SERV6_IP_2          0x00000000
>      > @@ -129,25 +131,25 @@ int bind_v6_prog(struct bpf_sock_addr *ctx)
>      >       // u8 narrow loads:
>      >       for (i = 0; i < 4; i++) {
>      >               user_ip6 = 0;
>      > -             user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[0]
>     << 0;
>      > -             user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[1]
>     << 8;
>      > -             user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[2]
>     << 16;
>      > -             user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[3]
>     << 24;
>      > +             user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 0,
>     sizeof(user_ip6));
>      > +             user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 1,
>     sizeof(user_ip6));
>      > +             user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 2,
>     sizeof(user_ip6));
>      > +             user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 3,
>     sizeof(user_ip6));
>      >               if (ctx->user_ip6[i] != user_ip6)
>      >                       return 0;
>      >       }
>      >
>      >       user_port = 0;
>      > -     user_port |= ((volatile __u8 *)&ctx->user_port)[0] << 0;
>      > -     user_port |= ((volatile __u8 *)&ctx->user_port)[1] << 8;
>      > +     user_port |= load_byte_ntoh(ctx->user_port, 0,
>     sizeof(user_port));
>      > +     user_port |= load_byte_ntoh(ctx->user_port, 1,
>     sizeof(user_port));
>      >       if (ctx->user_port != user_port)
>      >               return 0;
>      >
>      >       // u16 narrow loads:
>      >       for (i = 0; i < 4; i++) {
>      >               user_ip6 = 0;
>      > -             user_ip6 |= ((volatile __u16
>     *)&ctx->user_ip6[i])[0] << 0;
>      > -             user_ip6 |= ((volatile __u16
>     *)&ctx->user_ip6[i])[1] << 16;
>      > +             user_ip6 |= load_word_ntoh(ctx->user_ip6[i], 0,
>     sizeof(user_ip6));
>      > +             user_ip6 |= load_word_ntoh(ctx->user_ip6[i], 1,
>     sizeof(user_ip6));
>      >               if (ctx->user_ip6[i] != user_ip6)
>      >                       return 0;
>      >       }
>      > diff --git a/tools/testing/selftests/bpf/progs/bind_prog.h
>     b/tools/testing/selftests/bpf/progs/bind_prog.h
>      > new file mode 100644
>      > index 0000000000000..0fdc466aec346
>      > --- /dev/null
>      > +++ b/tools/testing/selftests/bpf/progs/bind_prog.h
>      > @@ -0,0 +1,19 @@
>      > +/* SPDX-License-Identifier: GPL-2.0 */
>      > +#ifndef __BIND_PROG_H__
>      > +#define __BIND_PROG_H__
>      > +
>      > +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>      > +#define load_byte_ntoh(src, b, s) \
>      > +     (((volatile __u8 *)&(src))[b] << 8 * b)
>      > +#define load_word_ntoh(src, w, s) \
>      > +     (((volatile __u16 *)&(src))[w] << 16 * w)
>      > +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>      > +#define load_byte_ntoh(src, b, s) \
>      > +     (((volatile __u8 *)&(src))[(b) + (sizeof(src) - (s))] << 8
>     * ((s) - (b) - 1))
>      > +#define load_word_ntoh(src, w, s) \
>      > +     (((volatile __u16 *)&(src))[w] << 16 * (((s) / 2) - (w) - 1))
>     These names, load_byte_ntoh() and load_word_ntoh(), are miss-leading.
> 
>     They don't actually do byte-order conversion from network order to host
>     order. Network order is big endian. 0xdeadbeef in u32 should be stored
>     as the sequence of
> 
>         0xde, 0xad, 0xbe, 0xef
> 
>     The little endian implementation of load_word_ntoh() provided here will
>     return 0xadde and 0xefbe0000. However, a network order to host order
>     conversion should return 0xbeef and 0xdead0000 for little endian.
> 
>     The little endian implementation of load_byte_ntoh() here returns 0xde,
>     0xad00, 0xbe0000, and 0xef000000. However, a network to host order
>     conversion should return 0xef, 0xbe00, 0xad0000, and 0xde00000.
> 
>     So, they just access raw data following the host byte order, not
>     providing any byte order conversion.
> 
> 
>      > +#else
>      > +# error "Fix your compiler's __BYTE_ORDER__?!"
>      > +#endif
>      > +
>      > +#endif
> 

