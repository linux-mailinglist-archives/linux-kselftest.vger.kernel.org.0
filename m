Return-Path: <linux-kselftest+bounces-21092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669FC9B6127
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 12:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939B01C2124C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840C1E4123;
	Wed, 30 Oct 2024 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6oCTjVU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346531DDA31;
	Wed, 30 Oct 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286786; cv=none; b=igidvpAjyqRsP7g8vjJ2PAq9eKBsDfjgjuNxu+7HQaeaqmjxM64ZNhObAEFvT08/LivPtKbN5YdNnWOzPc3tKHCy+dZkMyy0DwqDtGSNg2A3+5HkU11Is0w581f9ztHvms7AJrlIXN8SUZ4bShUdMOkf8TnqvCdz/8bieBOkmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286786; c=relaxed/simple;
	bh=fCeONLvHegGSfcw9Ky8jaNUZK0p1bHTKuZ3C1akz+tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/arPV6H/cI7X/iZ4MKW42WP3onFgDT9HDunhtwvIRYf7RQmBsvT5rddm3Ouv+eXTCLSbxIJcyRQvlyR6NH8g37NZcnUZdU+jPudMjZswf4v5S3us5elppLMMevxT649Dj84ZRNDO8+ia0aZs9cHbQzRrrV34O0hRT+vSTv5OKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6oCTjVU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so5124662b3a.1;
        Wed, 30 Oct 2024 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730286783; x=1730891583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymRlvy1aQPoMurranzuEhc83ceu3SVzS1IDAUzBuNJY=;
        b=j6oCTjVUib255WSr5Ls3OoFvsvVkWIAPPb1ZKLNaKsUVtbNtBRTEtl6NBRBT1ILsVr
         n5GM9Ecgb/SyEoL3gmVtK9UNP1gWgIuYBp0iPYAot860+ydWk+B1JrEP3yzgGMkHDZzX
         cQRf/HSAYn8s6lQ7+mAYl9ape0ho4snCscIsbVU3SUSUsqyQBANx/yyBxga5T/sz/0Bf
         wRtPEasa5ZBYWzgwRBUc1YEkJ8/HkHjrea1c9C2vKRdCjfeELcGwgYAUscYEFqAn+i9K
         NeGCG8Qefizsun7RVycWX8lTrYQibuK2F3pysw5AYq7x4LCLV4Sxsjvi6Nz/WCt+Cte+
         C9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286783; x=1730891583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ymRlvy1aQPoMurranzuEhc83ceu3SVzS1IDAUzBuNJY=;
        b=jdLbYuaTdp6dnDQ+TawwGELfq6FrnW5EJAIYU65DFjZoSMF4pxM4fY7vtb8hVwjaJB
         AhLlbo4VslKNFbk9TyC+FwvdQ7ldPza5gR4RAFL/cFlIDFKXKjQhXA69GsCo1CiYkrnn
         qMsv8qyK2GFQQv02M42rx6NWfPxt4hCwfGntIHnqMvJPudns46PUc9ll7kIIY1v9tkMN
         d4+AMJ1DXIIN/kh2tq7cCN808Fi0n+gYbB3KEGsG3icRzjwbPXqow/sWri9wlYwOmNbg
         JWP63A789l3f3vgumi35zG/t7c3SVgaz0sG/ostVEjyd+9KkB8aI/08j3Xo1qchnDES4
         gcqw==
X-Forwarded-Encrypted: i=1; AJvYcCWJqZ/MPHXPR9ijJuVa7F8/p3xXCsByIvjAmCvtz3YLDBX/cNdDfw76mlIsKiOuj0nRI9hR0MI/ifgi5LI=@vger.kernel.org, AJvYcCX7o6PjFplFJV6pGZfgWrQ1NN0I5LEL72rdX8QSTQhF+haa83K2ggGYo4eBCIKnqchBv0vqDRiwIQKpYyVWahA/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5zC1YwUSIzd7BsjQRYfdE6JYJHHkSI8zsrR+I7mcjqPmSO7Gf
	S1eRRL7RK0/Ny+/B/JDKOK/g3IP/UFI1Zqn37/OLzkuxBZAdzRAWvUDfXw==
X-Google-Smtp-Source: AGHT+IFu590Lq0TECetYlxh+A+zx5xw+jixfRaS4gaHnOxwLCVbOJeI7mB2J/qtdx99nB4yMsMjyYA==
X-Received: by 2002:a05:6a00:992:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-72062ae79f3mr23973439b3a.0.1730286783297;
        Wed, 30 Oct 2024 04:13:03 -0700 (PDT)
Received: from [172.23.160.204] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b961sm8987011b3a.121.2024.10.30.04.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 04:13:02 -0700 (PDT)
Message-ID: <3bc02b33-421e-4c95-8f69-33ec89782621@gmail.com>
Date: Wed, 30 Oct 2024 19:12:54 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compile error when MPTCP not
 support
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
References: <20241030100108.2443371-1-chen.dylane@gmail.com>
 <abb72d1b-3347-4493-9a18-43c1655b7449@kernel.org>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <abb72d1b-3347-4493-9a18-43c1655b7449@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/10/30 18:49, Matthieu Baerts 写道:
> Hi Tao Chen,
> 
> Thank you for having shared this patch.
> 
> On 30/10/2024 11:01, Tao Chen wrote:
>> Fix compile error when MPTCP feature not support, though eBPF core check
>> already done which seems invalid in this situation, the error info like:
>> progs/mptcp_sock.c:49:40: error: no member named 'is_mptcp' in 'struct
>> tcp_sock'
>>     49 |         is_mptcp = bpf_core_field_exists(tsk->is_mptcp) ?
>>
>> The filed created in new definitions with eBPF core feature to solve
>> this build problem, and test case result still ok in MPTCP kernel.
>>
>> 176/1   mptcp/base:OK
>> 176/2   mptcp/mptcpify:OK
>> 176     mptcp:OK
>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Fixes: 8039d353217c ("selftests/bpf: Add MPTCP test base")
> 
> The commit you mentioned here is more than 2 years old, and as far as I
> can see, nobody else reported this compilation issue. I guess that's
> because people used tools/testing/selftests/bpf/config file as expected
> to populate the kernel config, and I suppose you didn't, right?
>

Hi Matt, thank you for your reply, as you said, i did not use 
tools/testing/selftests/bpf/config to compile kernel, i will use this 
helpful
feature.

> I don't think other BPF selftests check for missing kernel config if
> they are specified in the 'config' file, but even if it is the case, I
> think it would be better to skip all the MPTCP tests, and not try to
> have them checking something that doesn't exist: no need to validate
> these tests if the expected kernel config has not been enabled.
> 

If i use the kernel not support MPTCP, the compile error still exists, 
and i can not build the bpf test successfully. Maybe skill the test case 
seems better when kernel not support. Now that bpf_core_field_exists 
check already used in the code, i think it is better to use new 
definition mode.

> But again, please correct me if I'm wrong, but I don't think there is
> anything to change here to fix your compilation issue: simply make sure
> to use this tools/testing/selftests/bpf/config file to generate your
> kernel config, no?
> 
> Cheers,
> Matt


-- 
Best Regards
Dylane Chen

