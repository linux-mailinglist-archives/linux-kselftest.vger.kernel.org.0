Return-Path: <linux-kselftest+bounces-9248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E08B912E
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 23:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712031C21661
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 21:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E60165FC2;
	Wed,  1 May 2024 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jveuSoGy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509954F898;
	Wed,  1 May 2024 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714600488; cv=none; b=c1t5WmeF3fB4L9Nlj+x0Y2XOvfusGhQnUR5I7oZ1Y+QHYWwp0PBUCd0hyProjR8viehc4tq8C7o/3z2HyouHFn4YKfKxRzI+xFpJ7n6yCYrcm4U1c99sMNIL9P08V3HJUZDJxdSXytqG3MHZEPvHZIb3cimfzLL+idbMrdydMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714600488; c=relaxed/simple;
	bh=vb9in9s6Q1Mtnu2Ihn9CCHnWHAXkzsDtiAI+wblForU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiEDZWFhtU1yCt7+ADFqATAYVM8iQxq6a6tqBI5mNrLyKz7eMtK3Mk/wm6ZTY1OlRa4DcDCargg7vRFFoBDMB5/+8R9kI9PNWE3XQQZzkVrPyJN1GVDq83tzdzQmI6wxXdvGa0CTfK+wvNAr0T/00Ga3lzrCob60+72JR7eDE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jveuSoGy; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-233f389a61eso3750055fac.3;
        Wed, 01 May 2024 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714600485; x=1715205285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnvecM6tvfavb6wTS4XHWVRtX0gJEo2oQRcyz49gnfg=;
        b=jveuSoGy4trzx4kMouwUt5dL4OhObevY6vSufVP3R6v7LJofNionI/YiV1AuGLi9ly
         xk/kV6KuH/IhwNw9QhjtY3BXls+Cw890vWqR3aZ47YxgzAhkR+m7/qSDW7DxgAIYidbf
         PRWmbV1AoLQ32gVsMbXr9NZDqSkxfSoJjbK//RpHePtRXvlXBEhEKaP3+3n9RIt8v8/r
         toMhDIdHCielMwRkmDGiq/Hw1MkA1+mmbtHcDm6VgcgBiczeDk9qKDkwsbE5YUsPF0Gk
         Fft65vsq/bnYXLPkOf6AJIUpAp0VeAqhUi7nQk+TVfaANkwkbXjctvGqlH/u4T09LIk/
         psWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714600485; x=1715205285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnvecM6tvfavb6wTS4XHWVRtX0gJEo2oQRcyz49gnfg=;
        b=RIMrBBntJ+0iQear6b5chsXU+izNJneoh8NXhv+RPjfekQENUDcc5+SGxokO78U84r
         hViyPA3J9aawhTz6ad1GEYpatTNuzRU2wVPr3k1l+IP8LGA89SXEKuY8Qv76vm4cu2xw
         vr8pYqtFnwl8FQVu5pErv8fyAQ0+j7kKRNUafzJhaTh86k6axownlhJfGWorwnpTwMQ7
         wQAKmmZdgMs9w3VWR49KmPWtfdZxp5KQoJSH8/a28pey8lOO0Xh+z9coBzJqVmZ8SPzO
         Z+Ac422vAmeg/8emLfdOwvh8ULSL+5FniTkfFZT9pqBn/65nzDDhcD3w6IPRafew+NsI
         +6dw==
X-Forwarded-Encrypted: i=1; AJvYcCXxzOCeUXV/6/WhgwVMT3JD0eSs579jnndSmiJ8rBdnbv4a8SloU0TBXE0b11aM8Lu7QToeD1JOgrQU/aE0zjqgBVf8aCYpQkoLRS+AJ5YZBulYMBZ0j1TINYHbZdADdbpq4Vlimji0
X-Gm-Message-State: AOJu0YxRlmKG8JS7YfmbHQuUB0lhJ4fV9O2qqLITqtwiqpaT/p10UJQn
	aDtsxrQHoxdlHHi5wgELLU5QAn/GUska/pzJgFSXB9kmp2EooOxN
X-Google-Smtp-Source: AGHT+IF8BlRUoALXfW94X/abjm9dkiv3mju5tMrDxGRlU8xO58yd2zEjCeXyeTuZ8mod5xDmpMwsRw==
X-Received: by 2002:a05:6871:5389:b0:23b:34e9:9772 with SMTP id hy9-20020a056871538900b0023b34e99772mr284357oac.39.1714600485178;
        Wed, 01 May 2024 14:54:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:22b9:2301:860f:eff6? ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id bw3-20020a0568300dc300b006ee5b409f23sm978168otb.22.2024.05.01.14.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 14:54:44 -0700 (PDT)
Message-ID: <e27fc683-29e2-4a35-b43e-2679b6d0592f@gmail.com>
Date: Wed, 1 May 2024 14:54:42 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/6] selftests/bpf: Implement socket kfuncs
 for bpf_testmod
To: Jordan Rife <jrife@google.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
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
 <20240412165230.2009746-3-jrife@google.com>
 <65b2f4a3-bd8e-495b-adca-1e7adce5301d@linux.dev>
 <CADKFtnRYnJG0dk53erhuEK8Ew148nuTRwFgbUxkV6LRZQ=y+Hw@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CADKFtnRYnJG0dk53erhuEK8Ew148nuTRwFgbUxkV6LRZQ=y+Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/24 09:59, Jordan Rife wrote:
>> nit. Can "struct sockaddr_storage addr;" be directly used instead of a char array?
> When using "struct sockaddr_storage addr;" directly, the BPF program
> fails to load with the following error message.
> 
>> libbpf: prog 'kernel_connect': BPF program load failed: Invalid argument
>> libbpf: prog 'kernel_connect': -- BEGIN PROG LOAD LOG --
>> 0: R1=ctx() R10=fp0
>> ; return bpf_kfunc_call_kernel_connect(args); @ sock_addr_kern.c:26
>> 0: (85) call bpf_kfunc_call_kernel_connect#99994
>> arg#0 pointer type STRUCT addr_args must point to scalar, or struct with scalar
>> processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>> -- END PROG LOAD LOG --
>> libbpf: prog 'kernel_connect': failed to load: -22
>> libbpf: failed to load object 'sock_addr_kern'
>> libbpf: failed to load BPF skeleton 'sock_addr_kern': -22
>> load_sock_addr_kern:FAIL:skel unexpected error: -22
>> test_sock_addr:FAIL:load_sock_addr_kern unexpected error: -1 (errno 22)
>> #288 sock_addr:FAIL

I just looked into the definition of struct __kernel_sockaddr_sotrage
and the change log of this type. It has a pointer in it, causing this
error. According to the commit log, the pointer is there to fix an
alignment issue. I am curious if we can replace the pointer with
intptr_t to fix this error.

Of course, this should not block this patch set.

