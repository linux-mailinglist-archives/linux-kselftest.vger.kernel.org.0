Return-Path: <linux-kselftest+bounces-38309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17292B1BA55
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 20:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D192C18A2687
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22129827C;
	Tue,  5 Aug 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDSItHJH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A919E98C
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419180; cv=none; b=rNTuIZfn1vwcmDehtzXQtluohzrNgkDYThffURE+cLt69Q9BUH1WLrXmcdWAwGCqYGhmcSQk3WpN8aa08r8L4OFzg7kcGcswn1umomvk3a0s73r0fxF20cdQGl09i2uQ3Ss+hp3g+R2gdhyFwV0YGiYLrT6UFsQtLinTDfGlGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419180; c=relaxed/simple;
	bh=a62SZS2QmpfIUSwl1RF5uI2a2L6OPvvgldP/i+3ynSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u61qt537yM0pan8Ik/kUPL+gvMKe4l7BkVJDbNGXkSL6g+fRx784p3o8eBIZV369wVZvpqBZZ1WkwrXrE1VNzhnnwnDViMq/j3IqfnoYuoj4gd08R0rf83/fTGtGW7t2lbFkRGv1vOUKzl5IztikLfrUviRKOWtrxXeKMLHVAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDSItHJH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso2178a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754419176; x=1755023976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xUxg+pq2PUvE8Vk3KBIOKz0oljMTyiqWMDUeHpQ214=;
        b=xDSItHJHscbloZCMkLETcKJuq47LylFSYr8YN0xrsMGAm5DK9PNeLEFOBg1Cy5ZyPe
         hgh+u+xzUnIH6I9pfP2dp/fyfyrwapsniYa0a2N3BRbYb/EyKoHqNs3lQQYaQtby0aQN
         6Pi1XzK3kqlAIJh6u0KqGxpS9zswBKxsHEgVQwCHGOLtnD51uLOhORfMVOZwVlgamzSk
         oeynl7UrFxRfGUlJaRPNK1Y6rHSqHXuuqfQWcDDjd4auKJQ1nsafhklgAQciAGl87/gI
         pfppAQKjpY36dSNkdIoEqpsAqDyWYMoSBqjBc0wyjR5YEuPxjFgpiVkg6x6h4PfhJlBn
         Ctfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754419176; x=1755023976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xUxg+pq2PUvE8Vk3KBIOKz0oljMTyiqWMDUeHpQ214=;
        b=Jxy0G1kYhizdgSF0La4uKsvtFX4s0Vmh7ZkCmT9BFHSedxw4acEfPPDRHeCPPRK1lz
         f0BH5vM0OryfcDbc8GBK6Z2Dz9/HwfqmGs5clcR8u2J6x3YXY6WLAwM9soMuiCE9e47k
         XcyzcAT9bELqmVc5bqzRdILCYzvB9i82ENe+vdNACe8+8NeqSpv2nAXHQwlXmUm+HQVd
         LilJw7iSBoWhLB/mfsuoxDkdCxsi4qadOEzHVr96rT3HEU79Zv5bR+J3dnXLT23JyD3w
         XIKcRp1SEw26RPHbWaZVUiIq8X6pe/1XvLuhxNVSSP0y83sJWR+7LyM9UQjfxXbd4m+S
         meBA==
X-Forwarded-Encrypted: i=1; AJvYcCXxj7QfxUtrZI6Bo2q1+OakYTuJbj/LdBPTD7ZDqimQJvE7ghO5aUtLdfIIRZJyve6NVuCEEB64rJ2SCMw5410=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOW5WfZ8LqKDryiUpWBpzObeFM8WhpBP1NC+Cv2eMWZJ2GraY+
	WaZmKoa8eDQef1ea9efZdCacDB5YZbGRLOmL922K2GklFJMBZuOvK8aWPa6MZ5kSF7pjMwpen/+
	DdsBJL5pq5sWXPlZUwZ/Wqp6uQrQJigPDJuVScEgZ
X-Gm-Gg: ASbGncuMTodOZ+EPWrdohctlTdMyNqh2gOJxPXy6kIvLMwgGYeWWWdaYMsiQGetaVQZ
	ZRB4ZEiUR0mJotUmDcsJWj4b6ZG8OMG+AWSR1j8xlbz1V8n3HNLQ4Oz7cj6GqNyVH2fte8+fN8t
	vN1detrcWEpcYkq+HEwZ2NY5vTPSGRGxIVvOlw4M01BN0pCGnnqbsgnNL+RFSqGQcJyBpgnzjPH
	+in+XJIK4WGoCiq9C7E1/Y1nmQ+LoI9hTiE8/nub/Vc4g==
X-Google-Smtp-Source: AGHT+IFy4uCtvmoKREB9xPubyGfQITaTP/Y3zHYx2x5Mjq6NIu7iwEqR3CIj5VJ9+pdXbxXR/6XQYM75C8EoDMNJUO4=
X-Received: by 2002:a05:6402:c02:b0:615:60d2:c013 with SMTP id
 4fb4d7f45d1cf-61795f56174mr2645a12.3.1754419175703; Tue, 05 Aug 2025 11:39:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805175140.241656-1-ziy@nvidia.com>
In-Reply-To: <20250805175140.241656-1-ziy@nvidia.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 5 Aug 2025 20:38:59 +0200
X-Gm-Features: Ac12FXyOYi_qLL7ZLj8tprF4j2V_jxE8BegFfXRvFrXyIiZBLUKoXwoL4IXp0EA
Message-ID: <CAG48ez1wKqyCKZX7J2eJekTuzRshVE2btPEWQEm2hW9Ri46Uuw@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value correctly.
To: Zi Yan <ziy@nvidia.com>
Cc: wang lian <lianux.mm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Kairui Song <ryncsn@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 7:51=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> FORCE_READ() converts input value x to its pointer type then reads from
> address x. This is wrong. If x is a non-pointer, it would be caught it
> easily. But all FORCE_READ() callers are trying to read from a pointer an=
d
> FORCE_READ() basically reads a pointer to a pointer instead of the origin=
al
> typed pointer. Almost no access violation was found, except the one from
> split_huge_page_test.
[...]
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftes=
ts/mm/vm_util.h
> index c20298ae98ea..b55d1809debc 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -23,7 +23,7 @@
>   * anything with it in order to trigger a read page fault. We therefore =
must use
>   * volatile to stop the compiler from optimising this away.
>   */
> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> +#define FORCE_READ(x) (*(const volatile typeof(x) *)&(x))

So is the problem with the old code basically that it should have been
something like

#define FORCE_READ(x) (*(volatile typeof(*(x)) *)(x))

to actually cast the normal pointer to a volatile pointer?

