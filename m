Return-Path: <linux-kselftest+bounces-31150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3FA93A7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA86171E0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78AF214818;
	Fri, 18 Apr 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QaT3PONR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B1210186
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992817; cv=none; b=DzXaNXgt2Uu3B6lf/rltRumItlGTBWnGqTwS4vgm6IYBxwWEaji/Y/6AC+BhdWXposhAYR7puBCeOEUld+SRN5TuRjwYfk8cVZKvKmnzymufPqMOvDR17Nef1YgSn2pCt/78KRF19CM2j62xHdSqMEI3JWF7lhm3Oh7H30jiecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992817; c=relaxed/simple;
	bh=dnPlx1v/5+9ztyxM4DD3uu2rXOji5rsQEo270rydr7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IFMsTptpUX8paaT14Cj0z+Jzq6WVv38dAIMrR4rsZUL/gQih1Ohr/YwyYNKwhzMWYWR5nKGBucOK/6Rq7H5YOS/SWf6gGYpqpv+hOcYK9tR3RiBf4tneyN28pKhahnxqC0ozVUf/EcNpjxPsg6NTcn0DHKh0W/YiYkgPlFKFVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QaT3PONR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso5768167a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744992813; x=1745597613; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnPlx1v/5+9ztyxM4DD3uu2rXOji5rsQEo270rydr7I=;
        b=QaT3PONRArsY3lLNVeDHfsE4UhO014kmIrTkSySDTiTJP7iFtTJyvR2447yF6y5lKF
         ulPWpPmzKAB8TuHdfWNprw0fCGljGVYNKNVSPOxB8nqhHaE2ysaYPC8NjpX7Hn0tOj0Q
         hi3WDjmr/8XFEqtt9NqG+yO/ko1ceBNf+4eXuFXqzHFHCOxivcBixorgyMzB1AgWp3PX
         m5cqqTnz0HTMAEzNsyB/+iO1iJurK6T8GglOuGzIOj4tEduqWiFyBmOuWLEOETtopxN1
         OrNAbA7tAr+txv7ZCFLwmXxVlB3RKNj6AwnFEQE2bhFdwxhAmpPD1ZDcgTnZeX6R0lqu
         fDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744992813; x=1745597613;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnPlx1v/5+9ztyxM4DD3uu2rXOji5rsQEo270rydr7I=;
        b=h2q8VOL3szJhdsl58QZJeac5olY8T7TEuae/EvuBT83Bv//jWfZq7Fy3CJ39EPbPHS
         QxhgdKEBS5KDzo+JVEdPVbweUx8Xl/k2Q22uMo712LmfJeO12dY7NKeV91DIWoxcd3kZ
         0VNh2/V0v3l+/BAaEe5p88OgMs5tMPl/6kO33m7FU18QRBiFuyNVbeqU0doJ29Wb5Ncr
         0NwoA3Y2kH/yHRJcBHDoP38K+8VjfUPJtJpc8ifqskK/K6ONXxeq++v0uAYa03XxWCmy
         anrh6nUDPcznbzWaZpG1UNE5GMc3xZnvRiOH4GfAzI7HSuWTNNDIqstF2Glu0sLEh6xR
         gL0w==
X-Forwarded-Encrypted: i=1; AJvYcCUyY4oo4jeRap08m6UWwg81n1NV8EWKOsM4AgyxL2A4mc+SUY0oE07QlQt0kfy0fj4Hz68+9pEcrFrdTe5XspI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyENa+M9K61bUUS52z/IjxlM0AY5SDxr2FVZ8pTYhvkY7qzDWV/
	KINHSPFLkCGltbtvfNz1W4F3CW62eX8uH0tYrC5Na7KGyJLn2VJY1BoWDnwTK0M=
X-Gm-Gg: ASbGncsn6RF9qu7BwzGlO8g0f34MMSlcCfsAAlD27BXP/yrdVvbWznTwr0MWj6nCJNh
	zk+TVddu7H4QWEFFSYtmV4vM4DxWKHsaJ/XvCgLNVFFbK1zKGrdIRdi4XFdSJ1+aS0Dq2A54sJ2
	6h1n2Pmhfky6i3/PeWjSKpXQo/TlLQxDZAquMMxOsdTKJFVMCHtaEhArVtwUg80F9OyFqhK/JfH
	pHtrcv0205/tPs566jGB/hd/I+om/jqluEMagkrqKJbmzUyTyeQ1eZAvZBCdlyxD4gh695JZSiV
	7WPXbazs4/o2c+b7tJabMwvssOw7hxbvQQ==
X-Google-Smtp-Source: AGHT+IFLgbP7tACquxzJP1RHEXNOH/DlqDIlfnCrIa/5xv6iI7vhI+s5eVpkRTeUtU+t5K/5B3t8Fw==
X-Received: by 2002:a17:907:6e9e:b0:ac1:17fe:c74f with SMTP id a640c23a62f3a-acb7534d843mr242424666b.21.1744992813109;
        Fri, 18 Apr 2025 09:13:33 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefcfb8sm137109166b.111.2025.04.18.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:13:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
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
Subject: Re: [PATCH bpf-next v2 3/9] selftests/bpf: Add u32()/u64() to
 sockmap_helpers
In-Reply-To: <20250411-selftests-sockmap-redir-v2-3-5f9b018d6704@rbox.co>
	(Michal Luczaj's message of "Fri, 11 Apr 2025 13:32:39 +0200")
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
	<20250411-selftests-sockmap-redir-v2-3-5f9b018d6704@rbox.co>
Date: Fri, 18 Apr 2025 18:13:30 +0200
Message-ID: <87cyd9a1n9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 11, 2025 at 01:32 PM +02, Michal Luczaj wrote:
> Add integer wrappers for convenient sockmap usage.
>
> While there, fix misaligned trailing slashes.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

