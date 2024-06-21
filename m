Return-Path: <linux-kselftest+bounces-12474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE04912EBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF41C20E8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6017B4F2;
	Fri, 21 Jun 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifw4aBrJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86216D311;
	Fri, 21 Jun 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002696; cv=none; b=Sh7d6CAJzKr9zoYeY1gUu9E9lO9c+TYbe98gfb3/27RisQFJyDTFpGk0SskLkrUdNgK6ZzWkdpTDLE+jeljvlGOT2v6UTCIgVu9yqSI5YxVfEW6gyg/7e7EMt1RRJ/Jc7G2N5dLq81j1vpBsksyAiDSpc8cntc6GK3smKBVPgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002696; c=relaxed/simple;
	bh=Kgeq7fENCxQOY8iQNJHg5JbJEhcew5upIRGQUHDV12k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+QY2kIS4GkfmT/x1YKyOWaf7Rf0zMUIAgfb1R9v7xmC7cVddQQCUnZ9SgT9oT0u4FyV2sa+7po05lnuN6yC1oauH5ZKNvXAyV5KBkXmEqofqXkLxkghG6ziodBxh7M47mm/FoCZ6uXBpreN3mjylQN67Zym/OxEi/xKB6FEfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifw4aBrJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-701b0b0be38so2154582b3a.0;
        Fri, 21 Jun 2024 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719002694; x=1719607494; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zW48d9PX3dvPiRYYiZ+fX9fq5/RFMgB9MUuALdyJx4w=;
        b=ifw4aBrJqCxYj7sYxSnM9MAaKxqqY+4Ysvt71g12mgQyuFniHLOCbc1dDj7N0gtdwD
         e/UOLiie8Y/KdlW7MvrkVlOQ+jBebTKCHZsBxLkDp9xCTlCrZ7jx+B4F+CIQNPCGcl7C
         /LZ9v7s6Y+0p/RMtVB7TJZA4r3ZX17o1WgnxJc4AdXRKqLofL/IpbaBdY7akbLFHoOyW
         txpp2A4b4m4vrVEvVk7A74kWtYzBcXa5OVhjQ4HwQFCmEhT8zZ3u9SOx3NMw8wK2rA59
         WHPb8Jvk7mv84r/Blyfx9V9raXt9Lo0hMuEQPAafoFiJmrZgf8xi0tysxJJIQKOqgxvX
         U/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719002694; x=1719607494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zW48d9PX3dvPiRYYiZ+fX9fq5/RFMgB9MUuALdyJx4w=;
        b=c+qyKBDSadUOsaF3mUIOonc3+VaI8GAitHarGZYzmc4rz/d/AZGvw6iwjjY52adV/1
         fZyY6sdmLKDtkzJIAAAvvuAePbXam43GLv2zeyKEg1a0cKJyNWMUas5xW93J2jBf3uHm
         thGuAaEIr44VgGXXntw2BJfyrupJqmfVspp9tPmqcbIsmq7Fv9haA7Xtxosmv0E9U5um
         10oXYM6aSP3QNdqxcmZvF8UYba22I/gjx6heKxDsEoEOFabCr/BgAMflZz9hRWX7lCJJ
         tazOiERQ8/gpBd2hjZtVUzrksJvuyis/U9unHTJdoPRC85DaFTYchq/pgI4tRep+gxN8
         NkTA==
X-Forwarded-Encrypted: i=1; AJvYcCWOzQVyQyIjJ1mJu6GW1HW2i14nUb0FeXMicyINFspHpzlVAp9YuUp737wkJzELL0uxWCUd0oNq+8DrPE6rAHbG35E0y1y6EJsIg4JqvH+KZFDvuGc1YYbTYBeT8sRoK7HnHiKe
X-Gm-Message-State: AOJu0Ywk8brq6qcjeQnjNxwY5dSMmcHCz1X5CYqxKD3w+jMw5JQUqI7X
	Q6fVEJjF8KEk26aRROUSuRFLZW+YhhiosZbjt2992WdWQD8LqXPv
X-Google-Smtp-Source: AGHT+IGuSuIfrylsxpd6ptAwFnvh2mC9AdxC1JjZuR6fixXFuWxA8PJcQ4CtjeBq0NMuESgEYsuAOA==
X-Received: by 2002:a17:90b:1a88:b0:2c7:ef22:2c20 with SMTP id 98e67ed59e1d1-2c7ef222c99mr5081615a91.41.1719002694022;
        Fri, 21 Jun 2024 13:44:54 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4ff980dsm4113956a91.4.2024.06.21.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:44:53 -0700 (PDT)
Message-ID: <1f76e30b4a298dd8403e661cece6735b398f5b1e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/6] selftests/bpf: Use connect_to_fd in
 sk_lookup
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 21 Jun 2024 13:44:48 -0700
In-Reply-To: <588b96d36b36f88095802d28a6b236842e30cb96.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
	 <588b96d36b36f88095802d28a6b236842e30cb96.1718965270.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 18:35 +0800, Geliang Tang wrote:

[...]

> @@ -883,12 +881,10 @@ static void drop_on_lookup(const struct test *t)
>  	if (server_fd < 0)
>  		goto detach;
> =20
> -	client_fd =3D make_socket(t->sotype, t->connect_to.ip,
> -				t->connect_to.port, &dst, &len);
> +	client_fd =3D connect_to_fd(server_fd, 0);

Nit: make_socket() used timeout { .tv_sec =3D IO_TIMEOUT_SEC },
     while here commect_to_fd is called with timeout disabled.
     Same applies to other replacements below.

>  	if (client_fd < 0)
>  		goto close_srv;
> =20
> -	err =3D connect(client_fd, (void *)&dst, len);
>  	if (t->sotype =3D=3D SOCK_DGRAM) {
>  		err =3D send_byte(client_fd);
>  		if (err)

[...]

> @@ -1257,17 +1247,13 @@ static void run_multi_prog_lookup(const struct te=
st_multi_prog *t)
>  	if (err)
>  		goto out_close_server;
> =20
> -	client_fd =3D make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst, &len);
> -	if (client_fd < 0)
> -		goto out_close_server;
> -
> -	err =3D connect(client_fd, (void *)&dst, len);
> -	if (CHECK(err && !t->expect_errno, "connect",
> +	client_fd =3D connect_to_fd(server_fd, 0);

I'm not sure this is correct.
The original test uses EXT_IP4, EXT_PORT here,
while t->listen_at could be both { EXT_IP4, EXT_PORT } and { INT_IP4, INT_P=
ORT }.
See test_multi_prog_lookup().

> +	if (CHECK(client_fd < 0 && !t->expect_errno, "connect",
>  		  "unexpected error %d\n", errno))
> -		goto out_close_client;
> -	if (CHECK(err && t->expect_errno && errno !=3D t->expect_errno,
> +		goto out_close_server;
> +	if (CHECK(client_fd < 0 && t->expect_errno && errno !=3D t->expect_errn=
o,
>  		  "connect", "unexpected error %d\n", errno))
> -		goto out_close_client;
> +		goto out_close_server;
> =20
>  	done =3D 0;
>  	prog_idx =3D PROG1;

[...]


