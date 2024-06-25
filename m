Return-Path: <linux-kselftest+bounces-12593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F38915B6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 03:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FE61C21971
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4406D1A6;
	Tue, 25 Jun 2024 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csw79foC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4EE61FDA;
	Tue, 25 Jun 2024 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277197; cv=none; b=DYkz0xVbtLln6AC7eqVknc0hgKbh1gzuKRED85mVQllcP+GYnT/LWnjVuApX76NEGmoQoR1nTp+MXvato2CVzHY5RS36/gVHDM+RQi5PnJXXACQLZZTEjfUMu8lQlhqtwqssU9+nH9XRp5YwZ8UP4a+cY78Zr1zxFxWESKVwL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277197; c=relaxed/simple;
	bh=tbz3fx9me8RYml1zryPFQj2py4/NfAXIo8V2StbotcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b638vbLPgtufn5enZgidroAspB9kXkM1q+Jrdc5JGi4g22le0Leq2X4g0lljuTG00FgCSveChmHmWnJtFgS+nN6pwortsXRqtkD4Klw7pu9mENKiTJuv49IObYyhJlOLU+WqaYPYUWz0TpbHXYDyJQuitfsBQrUvqmN96cHOnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csw79foC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7066f68e22cso1661904b3a.2;
        Mon, 24 Jun 2024 17:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719277195; x=1719881995; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3wYKLT5pUxWJteCWlaUFu6bWDIbS5wMf88srHW9IbAA=;
        b=csw79foCOkW66iSNezErJOBkPxMnYV26NTmBOM27yy9i9tWuPk7HA0Qs8K7ZKNOUGP
         c7u8iExxe1fyawTTSci8qFoZL4yDyNYF6kdZR7rB4tUndSbehvKEj/MAV8AXNgjOrkKI
         afXWz5H2RZHR/UWjt2e+SaMUkZcOcrm92XiHXg7Gs4iQDKzuuGmOv4h/ghA4yBYSYrsS
         7XNlvCCt+aVdg5wlsAj+M37eMoTy9CwfO2SMXLa9fGzxDMvK/jCN9yG4etlxgn3SjK2C
         s8RRpVNO4dwzraC6JPhx92cgxd48fHx+j+QDCWT50VyWhV+hHLC8wYOA0fTIC4V+ODJw
         br+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719277195; x=1719881995;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wYKLT5pUxWJteCWlaUFu6bWDIbS5wMf88srHW9IbAA=;
        b=XCunR3Cvt1FtsFEAzDRuAaIIVsGpxVnyWF+Vf6ll5NWW1DeHOiZqqCA0OFXYJnnJ1r
         HYLWoiDbGkk61N6ldGGidwXsceVkeh/SloXIDxZizYSB8eQFLRGmDkeywFxO+GC/tNFD
         uF7BGx+lPot7f/PhhwANId7m0msRdnvKblj4sv+emnBnbrviOVJbwWIPQYAlN/dASaKD
         mXPJrKqanfMiGutJzKm6TQDdxXz2dQ1osUaGXK5GC61q0M1ZpDHFaxOkU5bKlKeaIlZV
         7n9FIUcZYzeel4CooJ60bgsCp0plCktyGw/UXYN22Vn6CDgiKeUl7Ibfp6CuToUAAQXd
         t38w==
X-Forwarded-Encrypted: i=1; AJvYcCVw09m5HbP6I4hLwU5wTQ3hTIEyy8w7EGQDKtG0W035RIEbb5erLym/gH53JEbIKFxhxuDvD4i7y7uKKTKPAL+y19gD0S4SzNOnBFbWnXL5e590LEh+1hK8ixO6pBpn5PLsUW6g
X-Gm-Message-State: AOJu0Yw0go8UVKm1/3vPts67DExexgJwSt8M/d+5rkLaHzlQ87WSCUEU
	ocM76usedJbwmSqASgApH4/F2BMDrXCubBYDmDzOuR7ZSCjml4tR
X-Google-Smtp-Source: AGHT+IHGa2tKvL95CnD4d2dMG+FPrJgmmHFTE4PF578YR4xqF6UNkGuscVsvV+X7E2HkPYzMlhlDFQ==
X-Received: by 2002:a05:6a00:d0:b0:705:d9e3:6179 with SMTP id d2e1a72fcca58-70670fd4148mr5679603b3a.26.1719277195024;
        Mon, 24 Jun 2024 17:59:55 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba6aa524sm5987566a12.63.2024.06.24.17.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 17:59:54 -0700 (PDT)
Message-ID: <003488efcca0c1205d3091242b2a106bc971f8a1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 6/9] selftests/bpf: Invoke attach_reuseport
 out of make_server
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
Date: Mon, 24 Jun 2024 17:59:49 -0700
In-Reply-To: <f846835a758f2e531026083253eeb747205bd0dd.1719203293.git.tanggeliang@kylinos.cn>
References: <cover.1719203293.git.tanggeliang@kylinos.cn>
	 <f846835a758f2e531026083253eeb747205bd0dd.1719203293.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 12:33 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> In order to facilitate subsequent commits to drop make_server(), this pat=
ch
> invokes attach_reuseport() out of make_server(), right after invoking
> make_server() if the passed "reuseport_prog" argument is not NULL.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../selftests/bpf/prog_tests/sk_lookup.c      | 21 +++++++++----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/t=
esting/selftests/bpf/prog_tests/sk_lookup.c
> index de2466547efe..d87dfcf5db07 100644

Tbh, I don't like this refactoring for sk_lookup, it does not seem to
make the code clearer or shorter (e.g. 1414 LOC vs 1409).
If anything, it looks like reuseport_prog, callbacks setup and
start_server_str could be hidden insider make_server().

> --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> @@ -204,15 +204,6 @@ static int make_server(int sotype, const char *ip, i=
nt port,
>  		}
>  	}
> =20
> -	/* Late attach reuseport prog so we can have one init path */
> -	if (reuseport_prog) {
> -		err =3D attach_reuseport(fd, reuseport_prog);
> -		if (CHECK(err, "attach_reuseport", "failed\n")) {
> -			log_err("failed to attach reuseport prog");
> -			goto fail;
> -		}
> -	}
> -
>  	return fd;
>  fail:
>  	close(fd);
> @@ -610,7 +601,8 @@ static void run_lookup_prog(const struct test *t)
>  		server_fds[i] =3D make_server(t->sotype, t->listen_at.ip,
>  					    t->listen_at.port,
>  					    t->reuseport_prog);
> -		if (server_fds[i] < 0)
> +		if (server_fds[i] < 0 ||
> +		    attach_reuseport(server_fds[i], t->reuseport_prog))
>  			goto close;
> =20
>  		err =3D update_lookup_map(t->sock_map, i, server_fds[i]);
> @@ -636,7 +628,8 @@ static void run_lookup_prog(const struct test *t)
>  		reuse_conn_fd =3D make_server(t->sotype, t->listen_at.ip,
>  					    t->listen_at.port,
>  					    t->reuseport_prog);
> -		if (reuse_conn_fd < 0)
> +		if (reuse_conn_fd < 0 ||
> +		    attach_reuseport(reuse_conn_fd, t->reuseport_prog))
>  			goto close;
> =20
>  		/* Connect the extra socket to itself */
> @@ -878,6 +871,9 @@ static void drop_on_lookup(const struct test *t)
>  	if (server_fd < 0)
>  		goto detach;
> =20
> +	if (attach_reuseport(server_fd, t->reuseport_prog))
> +		goto close_srv;
> +
>  	client_fd =3D make_socket(t->sotype, t->connect_to.ip,
>  				t->connect_to.port, &dst);
>  	if (client_fd < 0)
> @@ -992,6 +988,9 @@ static void drop_on_reuseport(const struct test *t)
>  	if (server1 < 0)
>  		goto detach;
> =20
> +	if (attach_reuseport(server1, t->reuseport_prog))
> +		goto close_srv1;
> +
>  	err =3D update_lookup_map(t->sock_map, SERVER_A, server1);
>  	if (err)
>  		goto close_srv1;


