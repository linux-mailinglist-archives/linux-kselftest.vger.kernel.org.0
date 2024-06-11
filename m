Return-Path: <linux-kselftest+bounces-11709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C0904634
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 23:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8D2886C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 21:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4738152E12;
	Tue, 11 Jun 2024 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSiCUo7m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55901101E2;
	Tue, 11 Jun 2024 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140855; cv=none; b=kAd2E/miOvhFGDruK+gldB1w6eSIO8ESdbzUx2hljPcrEIyb+krkg50KBvz2fOesPE3Fj5/kPe6/q+zDc6Y2JZhooyqVnQ7FuZQ8XcMEZPDDMoAu2CjIK/4iNWN4SZRUpH8lwv1MgUtsujnO7kAa+i5IhJqJwCTvJaN1i3vl6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140855; c=relaxed/simple;
	bh=8V372jQuMlopDnHaclClHN5Qs0I7y5Rvg67+Aebv5Aw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oCRsj6Z45jtu12qumvhNH/zF9ny+4Y7xMsDbLmrQVvZ8/UB1nvhkIFPp21ScvZefJwmGWlstfwp9peTg1cQwsVKcng3Kq3GnzsYmbZKgUqp1KXFTw0anS/eM5PvS1J8rAi+NAHR4ZknF6wB2mINwY4v2ttlJr+G33diwyWu3WZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSiCUo7m; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso4999670a12.2;
        Tue, 11 Jun 2024 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718140853; x=1718745653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IBoxGK85jBdmizYIhLF/Od3Ee0Iiwcb2PyDWtr73idk=;
        b=QSiCUo7mC6IQpCsDixYo96l0BgleKBrvShP3StpDjiHHNVNCrSyPPNW0tgix+DgrTl
         amQj4hcAcIXE5gBLfOFRk4frtIiH56RbMsfkVIvJtwMzqgBu1kYh8LB4vWNOzxbQYvfM
         onfe7MnwkIDrcahGc3LFW/3ZHhB8BwqHfKpEpBcE9lNk1CakNfI9V66Ht9IdkcXmDR2L
         rl8tmUmaLZTEP+726R8VjoZXLf4U8tNqJcypBVY/5IQ2degDhPdnQrOmgfZZaXWlFCP1
         haFJCefwD0ffJpVKTwwBdFnbw1RM0xoWvmKEmdWKG+lFh7NyW0z0PKOVciPCF2ywMVVT
         wtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140853; x=1718745653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBoxGK85jBdmizYIhLF/Od3Ee0Iiwcb2PyDWtr73idk=;
        b=XfJiOrCgZtoG9S989fGdjfqcWe03H/K8nuq0iCkB8aW2znORsRbi3qik773njRKJfX
         2MlKY/hCyHVXihorB4wnp0YCa/5UKmYxJ+s7/WB1QOoIACrIw27u6CMcXhBolftdS8il
         GhbTQVZG3shqdd1GT6lLaUEuBvDwX0WJ8KruDwl+eQLjgxSkWjwZw8cYwoxu2ZJGAhoD
         qBWUM4uqLMWh7ZiclDDnriWiuEw3m3mCJdzNGLHdjXrbSY+yKOKsxDwosKoygcTUTplu
         /5HVyb37t1QH0EDzkTSz/EflwAE3IjCsf3+ehPyTctF6nmizWFxyLLHre1Vf4WjtuVan
         v9vA==
X-Forwarded-Encrypted: i=1; AJvYcCVhOXz7eytGE2LHyKz/B+aT1A0zXXMuaojjJbmLBwwEyspSjLjHpawPV25TJkffZJDt8Vu0WOCj3RMpylANmwKKtZc3UfVUUMmzmyogr69OM3JjMGHOXuYXi4+Y5wn5GAV6Bb6+
X-Gm-Message-State: AOJu0YzgTXrXLgQ01OwZ7Zk+6/BcBFiod3l0CL8GnnabbHxgCOTYWUiS
	/rq2q7XJdt5Mh4oG+CfdEFVO/McAr+wtCefCurXkHTnRz9TRV6OV
X-Google-Smtp-Source: AGHT+IGcBXLRZgrVWFIhNrsWv7KKTRiON0MYiXy4LNq4g77BwvfEQ31rUvvKLYOzMJySex7GipvkPA==
X-Received: by 2002:a05:6a21:196:b0:1b6:bb61:3782 with SMTP id adf61e73a8af0-1b8a9c51034mr187405637.39.1718140853481;
        Tue, 11 Jun 2024 14:20:53 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6fadca2b0sm61796055ad.206.2024.06.11.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:20:53 -0700 (PDT)
Message-ID: <90648db3ed02c6f75ce2f90cf6651c8a6f0123a0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: Drop type from
 network_helper_opts
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
Date: Tue, 11 Jun 2024 14:20:48 -0700
In-Reply-To: <b80ca04f4f1e65e4b796331c48283ea282fe7ee0.1718070939.git.tanggeliang@kylinos.cn>
References: <cover.1718070939.git.tanggeliang@kylinos.cn>
	 <b80ca04f4f1e65e4b796331c48283ea282fe7ee0.1718070939.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-11 at 09:59 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> The opts.{type, noconnect, must_fail} is at least a bit non intuitive or
> unnecessary. The only use case now is in test_bpf_ip_check_defrag_ok whic=
h
> ends up bypassing most (or at least some) of the connect_to_fd_opts()
> logic. It's much better that test should have its own connect_to_fd_opts(=
)
> instead.
>=20
> This patch adds a new helper named __connect_to_fd_opts() to do this. It
> accepts a new "type" parameter, then opts->type can be replaced by "type"
> parameter in this helper. In test_bpf_ip_check_defrag_ok, different types
> are passed to it. And the strcut member "type" of network_helper_opts can
> be dropped now.
>=20
> Then connect_to_fd_opts can implement as a wrapper of this new helper.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Patches #1,2,3 trade options specified as struct fields for options
specified as function parameters. Tbh, this seems to be an opinionated
stylistic change, what is the need for it?

If anything, I think that this is less readable:

> +	client_rx_fd =3D __connect_to_fd_opts(srv_fd, 0, &rx_opts);

compared to this:

>  	struct network_helper_opts tx_ops =3D {
>  		.timeout_ms =3D 1000,
> -		.type =3D SOCK_RAW,
>  		.proto =3D IPPROTO_RAW,
>  		.noconnect =3D true,
>  	};
...
> -	client_rx_fd =3D connect_to_fd_opts(srv_fd, &rx_opts);

(given that by patch #3 three parameters are added to
 __connect_to_fd_opts() *and* it also accepts options).

[...]

