Return-Path: <linux-kselftest+bounces-45462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55952C54733
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 21:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D879B34366B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236427B359;
	Wed, 12 Nov 2025 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INNtNYiP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEAB2C158F
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979327; cv=none; b=Xv2uhZCNFSGfsV4vmHKwwZ56Gvizgpw3NuDwhEytdPrbmk2O6dJJZBHYFEG3IcsS9/hxMOwFN0jVS/L96gZ7kLwd+pGmg9ap4EsI9KvdZ7RKhGXfno6gr3MECMiBX8PtWsY18ItQ7e6XFKHZQMbniCWcynKRSppuSnMLS3vbT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979327; c=relaxed/simple;
	bh=Xu+yEaLVtWCfJzBUT+z3hYhvz60Mhv4zLSmf0rk5aRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIEFbrMVS0GQ6bSTGQQ1xH+wsez5W/Tcj9W1mJ/kr5EqErgNxrZWb+DQnZrYTRPpqzsAgVxgDpeCUHWCS/30r1TBCIGnNJB18DSJzIFRgmYszRbtE+vAcdYQQJYwSSsbmL9iTOsujGDy6k2/ChWfvnYISkczjZyqnZjqo+s3wxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INNtNYiP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7af603c06easo109088b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 12:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762979325; x=1763584125; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXUXjWIi+7Ihj+So2mzA9gPJc0sAWdTrFlXIRql1P6g=;
        b=INNtNYiPcCBevHzQCh4YHjLdscgucSaCtNVpcTu/kBMmaNRetStmBjVKvdjkgPpzG4
         pjKSaN8E4HsGfzMwmRn9oF7Xs45+nj+bjDDPKKoGwjA8OxnvhvqkpA6un4wBWvTO/Z5c
         AwTwpVg9Zny0LwF+E19FhMeS1tgHN5bF8iGdrK4rA8wIFTwu8Y3XmtGZQ4dIKsPMr/AM
         Ar8hWtCiThXJw02/v3mQdyMsNQuvj+6nQmmYFx0XJyO3irB7u1Q/JlbHzGkvrcBZVjaR
         qV1FHMZhr8GCy6o2ETU7EsP2WwaAkxle2Ft052M/pUxADAlXh/3mWslYy6V+6UH0hMAO
         GVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762979325; x=1763584125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXUXjWIi+7Ihj+So2mzA9gPJc0sAWdTrFlXIRql1P6g=;
        b=P12VWxZY9kxLxRXV07Sz0pOs6RN/55S6ho5J3GXaJyFL+uKrGM27HkkKPXSvfMlCt9
         LllErkkmb5NK45uOMAUaY+vZ2oLsRSmzjt3RbsbKFjPGCSno18UG523U5tyD8rkegWI9
         vRhoBgTXUh2nEAFlsUPgMJHnuXLkbwDMHwGlfnZ0L64dHPz1rIRtctjRrRCsCG0ETZlg
         gV9AOAnAidUuzgfu83lpKJPW7Wruj5I9909HxYnZyiSdAl2SKtb2vfuUvQmGnRBXkRG7
         H1HMqj5C6e9MgsG+kBEoAoqHKhkEFUnHZ/NE1wYjbSrPv9M6BeQoQgDHhHWOjqwTdBtZ
         7xtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI9+pp/I95bwhiXUzD6o5xbUrfLjkwRZPjv5bznxamZyoiTYf2B5/eq7wVF2uaXDug0mUdSL2XDgYbLJWgYNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf0f0x360sJnuN+1RE6DdbbbLVFNMhjxttuZNrM0qZ7Vz026bB
	OGmILn9o61z4Uoy0ZRHNgZN0nTiJE7hXIq6A1Lba52xjf55Rgn5tJZiJxaPmvRsF
X-Gm-Gg: ASbGncu6RFNE3Uf2xP271EpYfvKhcBGQokCRdY2Sp7BWFZcBEPPRRPP5lyJBxQ9EJXE
	uraCOFKE3MejJj0x4HLpepqPWkKX4VYKhq7VOvFmmkekz3eFNVnC83KnwAt9WB1UlyPXHOaNq0+
	J+ZUeMwbVaBbER4ehLk30E2PZpWxIH08lgWjYvAOpsorJXRstc7w63rvL1sNZ2uX24xDaiWusuv
	cI03cffymVXkwlFY97bKA0VYmwmP3w6f06xFi5m4NJ0FTmcvV80DcdJ7DAVsylgIqXeaAf5XjLb
	k0pArq8VXVw+tz+e9aadC5LczBKjd9N9tI85S/CjoaZ+jzcGvkNN5yFQN0/zGPC85wFQW2NGa2r
	kJQyCMqagSgK+281xiL0UYso1a0qMjWtlbhqPDwO0Us9oLpwxAfI4fzuvq0X93AfXUnpIkHlW0w
	ueQjIrX2I8we3mZng+E4aNzUwMGw==
X-Google-Smtp-Source: AGHT+IGDp2IxCpCnzdDE7zKRUSkwZPlpf28ExrTE3D1p+WEOXeHGb8C4KPt8ilZzRNPZb5dIwT7Jnw==
X-Received: by 2002:a05:6a20:394a:b0:347:1a7c:dea7 with SMTP id adf61e73a8af0-35a52789993mr924155637.31.1762979324727;
        Wed, 12 Nov 2025 12:28:44 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3e6d:747b:3d83:10e8? ([2620:10d:c090:500::6:aa7e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc208695cf1sm1091377a12.7.2025.11.12.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:28:44 -0800 (PST)
Message-ID: <a2578a0ee81f5e5bde327192b1544d5d1c9840fb.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: add BTF dedup tests for recursive
 typedef definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>, Ouail Derghal	
 <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>,  Ludovic Paillat <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>, Tristan d'Audibert	
 <tristan.daudibert@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Paul Houssel
 <paul.houssel@orange.com>
Date: Wed, 12 Nov 2025 12:28:41 -0800
In-Reply-To: <c381ca44fccbde23fec1d67131c13fec162603d7.1762956565.git.paul.houssel@orange.com>
References: <cover.1762956564.git.paul.houssel@orange.com>
	 <c381ca44fccbde23fec1d67131c13fec162603d7.1762956565.git.paul.houssel@orange.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 15:11 +0100, Paul Houssel wrote:

Lgtm, one nit below:

> +{
> +	.descr =3D "dedup: recursive typedef",
> +	/*
> +	 * This test simulates a recursive typedef, which in GO is defined as s=
uch:
> +	 *
> +	 *   type Foo func() Foo
> +	 *
> +	 * In BTF terms, this is represented as a TYPEDEF referencing
> +	 * a FUNC_PROTO that returns the same TYPEDEF.
> +	 */
> +	.input =3D {
> +		.raw_types =3D {
> +			/*
> +			 * [1] typedef Foo -> func() Foo
> +			 * [2] func_proto() -> Foo
> +			 */
> +			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
> +			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */

Nit:
Maybe repeat the above two types, just to make sure that deduplication happ=
ens?

> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0Foo"),
> +	},
> +	.expect =3D {
> +		.raw_types =3D {
> +			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
> +			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0Foo"),
> +	},
> +},

[...]

