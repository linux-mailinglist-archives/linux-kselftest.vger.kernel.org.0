Return-Path: <linux-kselftest+bounces-41050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D69B4AA39
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 12:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2A81C25CF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2183277A7;
	Tue,  9 Sep 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fAqEP8E6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D343218B7
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Sep 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412933; cv=none; b=bSTMGLK2pwcGwsnGTpInC0xtuCLUAyDvgA7MYUyrCWafzJiJwobMSeV1UKNElAp9cDhW3QSHFZXe2Q2wO2LWxiGsL9lbLTFjkSSR55LX5tVYXIozTDNQttjJhxwVpGltrclzHMkU9bylI7incw4UfKUNLDgmp7EqHxxr6CH+4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412933; c=relaxed/simple;
	bh=dPUtmKisXQ2DA9ev867oAwEPape0ZQTi48/IVDu7my4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JMqNps9Fd1N37I1vAvvRv5INmjQHDntR5O+3L0M3L3CdeyOnwpkm7QtVwN3VZMTXhzdWCPs0T3D8e6Jc7rXlO5lwbTxXjhNGcYzylIAsIHiT85irOL6OQZVoy03/7OpIbuF5hSz40amgMt4XUn2+FHvLGH9J0pVVlnn7fZknYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fAqEP8E6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6263d0e4b94so5949609a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Sep 2025 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757412930; x=1758017730; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=351+t/CzaGS0ImzNcqgyVg7QleoOdqpZVilL7S3uUNY=;
        b=fAqEP8E6GP3iiGUbYvjdaKciu7UeCmtH0gEAQ8vVKRYtn3q8umZfEoahkZ6uNONIFD
         2pJ52rFXVWP6YD5DTLGHo69SqJWEveXg8BoABoJsISUGL/f8cu0P5jSgJTrFP34ipv1x
         qgSfCdXITWciRDgkPiORfil/W44EpuGbysLnEYIliJgpZmW20c2zn2oK1bo6ePQCSS/Y
         oglv9Meie2KOtwK2UBwcMRwiyftoy8KtbHNXceUemTgDdexYnSy2e9SilxADKfovu1jf
         SdDo0nPFVFfYQmPQCNcwfHRDNBy8+RQkcET/3somMfb3ov3/h3ruf9w/Yww/9pDeArBW
         sRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412930; x=1758017730;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=351+t/CzaGS0ImzNcqgyVg7QleoOdqpZVilL7S3uUNY=;
        b=f3vgE9p92YrpGVHCW3h7q/gCP7T+N3RzXdMgthVjqDmGHU5P3BzUWyzuJ7iW56NOgl
         1eJtVqCUP4YRGSybBV9nd08YwVHyn9uJw8HKfoxBy/KShVIccAe7FOeesIrlW2/glHBZ
         wWbFcNYie8wYneHMaBZtJZLChMugXBXjqXx1PeUwhxC40TcqrtqMFe1bxRcGZTioFFDP
         Hs3wvqZBEZAaQecIp35JhJ5ZF8gjC/coPoymYbie6j9cpS85Z8JFvpShzmMJtXFnbpix
         ieA16mgsPGSSqrZJ1PthddnF9qLFrGiV9FW8cgHcfks+zf2DwlxiT5JYBvvAbOq2vfSX
         H2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWzHx8sOl62+rbDu49VCZHun3Ju2rN7Jj6lkJaz3q+CYf3Jd4T5giuT/W/8D51cezZjjO9cu7XVamJx2nmQRqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCkDqEzwug+5t+QOssUxtsCfjyaTahKwV/3nz9zYzkWm4y9H8
	LK5uuKg2FFWYxDyq9PK4c+dDkCqVfmcahhTZ9fZFdI3iKiAsIYba3sPKthrLBRacxbw=
X-Gm-Gg: ASbGnctrblrQTaoBJ7461ILRUy03AZAX5vrTrMXMCqonN68D1YhFZsdrx4jyOnFmodf
	TXPvmgshnECjKXHLZ02ByGOfA15FPjDEKv71QhcPpE0HjH/38iuNne5TDxYa429EdqgzMSy0bld
	0B8wPuKrJdxA5Nw8N3GHkxHYdg5RrwyDwJBIvRHUOnQHpzU+YBodACdozb3hHDK6tkp0CRodMgL
	1qGiKyXQ1JqcMBdUt0vlrKpfm2blJW//O9w2lYZxjliRFBE7C9oGDHzm75QjtFtcE1LMuDCgsM/
	gjaQVyXS4Na+JWi5SU6exyAg3qgBcXjTScxl4AQIUuSPuBCkwHH/xmc5bZ4zzQxXiC2gCjTD+Y6
	skYG9xN7qmeMd+I+5vmi0pHnL
X-Google-Smtp-Source: AGHT+IGgVxFdUXRSUbo/y34+EjFdFEBPFfYpLtF5ePOQGmUMb73+H4Li5P0mW7iLurHUcakJ9wYkiw==
X-Received: by 2002:a17:907:3d04:b0:b04:616c:d759 with SMTP id a640c23a62f3a-b04b140d2b5mr988468666b.24.1757412929559;
        Tue, 09 Sep 2025 03:15:29 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01801e4bsm990173a12.37.2025.09.09.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:15:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: sockmap_redir: Simplify
 try_recv()
In-Reply-To: <87ikhs54z2.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Tue, 09 Sep 2025 11:51:13 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-1-9d9e43ff40df@rbox.co>
	<87ikhs54z2.fsf@cloudflare.com>
Date: Tue, 09 Sep 2025 12:15:27 +0200
Message-ID: <87bjnk53uo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09, 2025 at 11:51 AM +02, Jakub Sitnicki wrote:
> On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
>> try_recv() was meant to support both @expect_success cases, but all the
>> callers use @expect_success=false anyway. Drop the unused logic and fold in
>> MSG_DONTWAIT. Adapt callers.
>>
>> Subtle change here: recv() return value of 0 will also be considered (an
>> unexpected) success.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>>  .../selftests/bpf/prog_tests/sockmap_redir.c       | 25 +++++++++-------------
>>  1 file changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>> index 9c461d93113db20de65ac353f92dfdbe32ffbd3b..c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>> @@ -144,17 +144,14 @@ static void get_redir_params(struct redir_spec *redir,
>>  		*redirect_flags = 0;
>>  }
>>  
>> -static void try_recv(const char *prefix, int fd, int flags, bool expect_success)
>> +static void fail_recv(const char *prefix, int fd, int more_flags)
>>  {
>>  	ssize_t n;
>>  	char buf;
>>  
>> -	errno = 0;
>> -	n = recv(fd, &buf, 1, flags);
>> -	if (n < 0 && expect_success)
>> -		FAIL_ERRNO("%s: unexpected failure: retval=%zd", prefix, n);
>> -	if (!n && !expect_success)
>> -		FAIL("%s: expected failure: retval=%zd", prefix, n);
>> +	n = recv(fd, &buf, 1, MSG_DONTWAIT | more_flags);
>> +	if (n >= 0)
>> +		FAIL("%s: unexpected success: retval=%zd", prefix, n);
>>  }
>
> This bit, which you highlighted in the description, I don't get.
>
> If we're expecting to receive exactly one byte, why treat a short read
> as a succcess? Why not make it a strict "n != 1" check?
>
> [...]

Nevermind. It makes sense now. We do want to report a failure for 0-len
msg recv as well. You're effectively checking if the rcv queue is empty.

I'd add MSG_PEEK, to signal that we're _just checking_ if the socket is
readable, and turn the check into the below to succeed only when
queue is empty:

        (n != -1 || (errno != EAGAIN && errno != EWOULDBLOCK))

It's a minor thing. Leaving it up to you. Either way:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>




