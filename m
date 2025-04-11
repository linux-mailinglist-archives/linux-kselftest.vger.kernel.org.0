Return-Path: <linux-kselftest+bounces-30617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4716A8651E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 19:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701F08A71F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E666258CDD;
	Fri, 11 Apr 2025 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XIe8zYUP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F72239097
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394093; cv=none; b=U79SSH49zeaGFU46CNrw0vWXAeg069zw/ao2TydMQMNWEznHchTFcDmYBTM5WhU4emqxt4zaGKYsqhEq7sp4gjpBm8+eKQLdo2VYzYuqz2E5TPdfmXjr7AS/OUOqVJeRmEj/K6c5ELnvxEaEcaYXVZuFdJm0pG9WglV5nujyE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394093; c=relaxed/simple;
	bh=ucba/TyRjphp5QB5NmFsNbDWb/WFdcnndSRrwoEMpJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=StrHfNj5RWvvGO+8/JcmL+gxT+lfTeTL51kc+dLikOJzWj9cEvdwtIYmXTVxWaydRFlMr6/O6EkPelhlq4LfvD/Zlw2IHfLiAop8eY3a7eP05QFevsRVO/mtDurUDxLnTthyw8M7uYxyvQ0ScTrbgQbo1S9dEU8gNWyYmQ5TA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XIe8zYUP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so391314466b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744394089; x=1744998889; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZElioqvOJMRGLrrbRjtOKF/8Aggf8tT1T8UOQr1p6A=;
        b=XIe8zYUPdcuX4Vl9xiQHoFR6q7oqLvwv7yFoLGQk/648ktFbwV4erdH8vnG4UNV7W/
         4gqjXnDyTNzYf7Ro1TApfEldZpVvs2o4d5tZRSfNwQZZGsfeSL3BlxAtULHN1M7aKQgi
         XXFwNGzogrlL+z+9HIxZiUIR/mQLyNwX3Anda/UWqZiSq1c5axT8sqvWU3EutLven15V
         Jj8OWgsfRDeufCHi0tqPqmDdZifzNWFXR2NNmESArXmCMW25jJJlFQucVAgGt52nsfLc
         G1lnt9LX1ARITZ1pqid+Mb/R8j46HIDBhKJkvRaFHjCILoxzPbQrs4h+2d/2HnkwD9hH
         P7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744394089; x=1744998889;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZElioqvOJMRGLrrbRjtOKF/8Aggf8tT1T8UOQr1p6A=;
        b=LB+0ARGbmzSdgC5hFFODL2wvJIXAMI+U+8itzzn292wo3dys9hNTwBiFHZsv8uhzRC
         odtewRO6Gk9dbtYvVSOw0NG7tBqzA4TbsIxzlxW0hTkXNPiBrpLqNZyxkjRLCUdDN6EE
         Y1680XPQYqwNO+DnaxsOMdRnOAQk2Zxbi4QRm45bLbeS23cZmMcP0NygEuZvgAfk/OF+
         usmK/kdGV02J3LokMjSVMjKh6bxu1B/WABxgtPWuEpot+DVoW/Rw+eiwOjoL/IqNUykl
         Te7XAicHLPxRKUwQbEAu2OKCIacBmc9PfKPkIhMwqg/oYBm+mjIBHHJS4f8kh7vmQqMd
         HFGw==
X-Forwarded-Encrypted: i=1; AJvYcCX0NbjyHwsCYhotq+TPV5sadbdFx72C1xtoyO19cKgdkcvsfUBG9vwWebKaaT7E5GdsTagpSmCzN2uk4W+i1tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIPkMKHslwVKrMLGYvqNaKsYdTWka3nGJhBvFvRrlYkOVMWHf
	v7DXy8khfZPaViGSdSe4hkQkcVIsx7Cq3uxo4V0OPoXeMBGkz1E2vH0QIH0SbgU=
X-Gm-Gg: ASbGncs0k7B0/qG7vhxBXzRIflIM0RwD4MaPWe6O55HWZyvi1q3/q6l/lqDdvRvFFEb
	6X8BuQYbnfDuyLi8bC8aWNbjgxLP/BgmWAgy6ZceEQCz1uxXGlnVjVvnOIkpD+se97vd88mfMZx
	BZnvjjfoIctbQgOmjan4bVjIPiTh5dlVXlWWzaNgJWO+hDB67yxZ2DZWt0MF4DcVGlD0N7EkLM+
	iulCKMHxDA+iD/b3zvj6ys/4KpUrjHUA1geGnSfp5dVWgIE22P/9BAm6ZHtVM4PgtyJmLDL5qFY
	mwCmuy8lOqBs1woA+o3LFd3uG3I1U2d2
X-Google-Smtp-Source: AGHT+IHlsd1OjqlMWlAQPwwAuOKfCl8uk/pGPlrihEPFE8d9StcXjSTkGzgHNBrELNxLTW7C3iUInw==
X-Received: by 2002:a17:907:6d0b:b0:ac2:cae8:e153 with SMTP id a640c23a62f3a-acad3445f7emr328570666b.4.1744394089440;
        Fri, 11 Apr 2025 10:54:49 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce70ebsm479714666b.178.2025.04.11.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:54:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>, Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 5/9] selftests/bpf: Add selftest for
 sockmap/hashmap redirection
In-Reply-To: <fnsy7wey4vaewoyur5363w2q2nb7dvljmaroijflgq2hfqbumo@gqdged7tly47>
	(Jiayuan Chen's message of "Fri, 11 Apr 2025 21:09:53 +0800")
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
	<20250411-selftests-sockmap-redir-v2-5-5f9b018d6704@rbox.co>
	<fnsy7wey4vaewoyur5363w2q2nb7dvljmaroijflgq2hfqbumo@gqdged7tly47>
Date: Fri, 11 Apr 2025 19:54:47 +0200
Message-ID: <87a58mh9co.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 11, 2025 at 09:09 PM +08, Jiayuan Chen wrote:
> On Fri, Apr 11, 2025 at 01:32:41PM +0200, Michal Luczaj wrote:
>> Test redirection logic. All supported and unsupported redirect combinations
>> are tested for success and failure respectively.
>> 
>> BPF_MAP_TYPE_SOCKMAP
>> BPF_MAP_TYPE_SOCKHASH
>> 	x
>> sk_msg-to-egress
>> sk_msg-to-ingress
>> sk_skb-to-egress
>> sk_skb-to-ingress
>
> Could we also add test cases for SK_PASS (and even SK_DROP)?
> Previously, we encountered deadlocks and incorrect sequence issues when
> the program returned SK_PASS, so explicit testing for these cases would
> be helpful.
>
> If implemented, this test would fully exercise all code paths and
> demonstrate a complete example that covers every aspect of
> sockmap's packet steering and connection management capabilities.

This could easily be a follow up in my mind.

[...]

