Return-Path: <linux-kselftest+bounces-35325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B4ADF8A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 23:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E2F1BC3A76
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 21:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0627A93B;
	Wed, 18 Jun 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCmCBEJi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4E27A10A;
	Wed, 18 Jun 2025 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281752; cv=none; b=ld60/3/V3I0fUio+EE29sc2OHMdM64Uz+dC4qYC/qYOnL4v/Vmq3oRYSA+1Bu8wtCqMkoMhPSDtv5J9h4+ZX1P1Dxbbi1SkQdFzzy8LvIXaijXKZpVBxr1sXAjmg1mlw83EYTwceP/0wVa76UJLPehzY2iq/F5iQl7Ibt7C/3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281752; c=relaxed/simple;
	bh=V/t1gt9M6rjQyJdUJERSP2IMF2CqZn+1I9QkJVP+oFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rwG4lh4ghlRoUFOXSmLEN7SkZ32AYBdVXPOjSdvHtGE4Mwia+q3ELXZarCOnqGmWJ7MDowxE7dYW2IVESi4DLT5mmGljKLAHXxdMf4vn4uXjUnExUxcpV1/xY3DC+Z0OD/rgPPiGBGiFOxfhCHDZDfYRBkmQfLOIfaDseTwPgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCmCBEJi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so90050b3a.0;
        Wed, 18 Jun 2025 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750281750; x=1750886550; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b0zAMXxFoe+upxCIdElSXBtC3aWZiW6q58tCsn6I1+E=;
        b=cCmCBEJiqBBgAXcKHBi00WuJsyh8xRGCa6Xf+qDI1Z4pOPWkKNgl65y47N+1N23xFg
         6GcWNfUudXfRjnDot0BFDDHKHU8aCQ+b4YKGGoyL7u/afOAP3fPPPZRKccW0XbsLkPmq
         ygZxvtlcEve6ONF2bmYIfvIqb+0IHovAXLiGqWTbO3I4pXte1ru4CCjODpI8E86+yufC
         dcc0hNeyOtZYsOlYONBIUjEcE6pn1gzfQdS7Dn+EpOp6uQ10yiVvkJYD/kH10NEKQkTc
         bMcdu1BdLZv0C2USIsikQrcEh2gjzxRNbn8b3U5/TPXW6QxosJri6O4Dyj76Us3bX6Hp
         Bl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750281750; x=1750886550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0zAMXxFoe+upxCIdElSXBtC3aWZiW6q58tCsn6I1+E=;
        b=CUdY7MWaDwpr0D9szWy/scygzHgIev+JpDJujaD9noLxZ3/haUB1Y+22GJSY37DiAh
         sFdIkb5EGBpI/Fn+mFDJgnHZhoZvaMUiqaKvSGC+x4mepB5PvRKQAs1ti7VCIYGpR3Qb
         MyIylz4LJ0CLIu4wP94UcvrzhNo1Gxo1KwqnqNb5vyd3VdtWDRoeBWcoRlLplv0GoO6e
         FdtcWZ65Hz57IHgySiLo6pP2i7Ku822BWtWjdrSXBQPhbNVyEYcxhSViA0/gq/koUhuQ
         QxbGKrwRTRg13+DRY4b2bMz9p7CaRQm/6J6dHFtbjrb4MD0ab8x/RVgt4eoSwVf0qkzz
         nLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVODSH7Fl7jYHMLva8CPOmYZfSJI+ULUkT9mdikITMRjGBFxsPWpk4ZyMaIbg0g26m7sBZ/xW3rbQu+ECZr@vger.kernel.org, AJvYcCW5ki8h4y6T0V7jO2r8tAhx7nhKGoXLyUN6xYuRM+uWo3qR6Vj8VcuJs1Dps3Klf9pHjbI=@vger.kernel.org, AJvYcCWCCFX+gsBJF2RV0ShwSJDFzcLckmXwMBiWFvv9ELqf5m32wdLcvkwnZufwkloqgS4JF744pUuMlskBJWrFLSQJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvg+P4TlBcVl1JnNfbmC+e9DsaWVZn3INhYSuPHH/Lml7RJBz2
	Oe3oWjIAHqcEiX39r04OyineGQzbkwESApc3A32pOiwRQuMZUyCEjCRm
X-Gm-Gg: ASbGncvGhJ4THiwFMaA2Mku8QYdWcWUU4JdDXQ3d2pxZmOt4z2Z+zTqxM9HJ8Js7mDS
	hLj3tPY4HZL75Bcl3P10X5tFtF6jZLCYWG0M/Yt0TbJDsjUJBzIBw4kST7czC6htTrrt5RdMZm9
	RXSl5IWoe+wZxNYOH2CKd9v3me0iNkD7FFWua4XKxO/E6QjX10IJZbKkXZSlVNQUqNCrLZo6kQW
	v/Kei5BLly1bHenmNScNAFk/j0u2vg1v9pXzoyGjl0HUo6713lKUlMt6lU86WJoP0oBPpefpMAG
	kVFSXXXwZeHaN8vIJC7CIJljxCalqGeCsVfdWJxty9NAOLH0Tlzm2PpaiN95zLfI/rqp
X-Google-Smtp-Source: AGHT+IFjAwSOo3G7jVf5CkMPOsnDz5CqO1o4ODwWNgkseEzJcUmU+R/WUfLBsS5pB6IR/sJd1UZq6A==
X-Received: by 2002:a05:6a20:2589:b0:21f:4ecc:119d with SMTP id adf61e73a8af0-220111b1bb6mr1690579637.7.1750281750331;
        Wed, 18 Jun 2025 14:22:30 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d255fsm12004870b3a.172.2025.06.18.14.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 14:22:29 -0700 (PDT)
Message-ID: <5b3b620d04fc3bcf4286dc4bb8c6fd995df86a25.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Add testcases for BPF_ADD and
 BPF_SUB
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	ast@kernel.org
Cc: m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu, 
	santosh.nagarakatte@rutgers.edu, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko	
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Matan Shachnai	
 <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, Kumar
 Kartikeya Dwivedi	 <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org
Date: Wed, 18 Jun 2025 14:22:27 -0700
In-Reply-To: <20250617231733.181797-3-harishankar.vishwanathan@gmail.com>
References: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
	 <20250617231733.181797-3-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-17 at 19:17 -0400, Harishankar Vishwanathan wrote:
> The previous commit improves the precision in scalar(32)_min_max_add,
> and scalar(32)_min_max_sub. The improvement in precision occurs in
> cases when all outcomes overflow or underflow, respectively. This
> commit adds selftests that exercise those cases.
>=20
> Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> ---

Could you please also add test cases when one bound overflows while
another does not? Or these are covered by some other tests?

[...]

> +SEC("socket")
> +__description("64-bit addition overflow, all outcomes overflow")
> +__success __log_level(2)
> +__msg("7: (0f) r5 +=3D r3 {{.*}} R5_w=3Dscalar(smin=3D0x800003d67e960f7d=
,umin=3D0x551ee3d67e960f7d,umax=3D0xc0149fffffffffff,smin32=3D0xfe960f7d,um=
in32=3D0x7e960f7d,var_off=3D(0x3d67e960f7d; 0xfffffc298169f082))")

Would it be possible to pick some more "human readable" constants here?
As-is it is hard to make sense what verifier actually computes.

> +__retval(0)
> +__naked void add64_ovf(void)
> +{
> +	asm volatile (
> +	"call %[bpf_get_prandom_u32];"
> +	"r3 =3D r0;"
> +	"r4 =3D 0x950a43d67e960f7d ll;"
> +	"r3 |=3D r4;"
> +	"r5 =3D 0xc014a00000000000 ll;"
> +	"r5 +=3D r3;"
> +	"r0 =3D 0;"
> +	"exit"
> +	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[...]


