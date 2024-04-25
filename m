Return-Path: <linux-kselftest+bounces-8860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B311A8B2368
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BDB1F23EB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D914A08A;
	Thu, 25 Apr 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uKtWfu7p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793914A092
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053708; cv=none; b=kZJy3gTODmy/1BbNgQskOdUpWuG5pS6uua10l7sxIrIxtXViqDkxMJO/a+feh+078Gau8rD75g9I9L/oYpVfzpd+J47eYkd5qXrDx8m5mURnfIxtZmGyN1uEilSTH0QsA7i9WNbiRQNqwtMogU3jcSYn99HY228WQ+tmYfwoabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053708; c=relaxed/simple;
	bh=ulYE0VHNMZy9EO2UbfcdnnLqLAB4c7Fjw+n0PZCpRjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quLMQQD7b/0YZ0qXY45w9xYni9pHHoFgskJjIcdNzINHnj2nn5h4PGkP58eco2bQjNxNp1nsGzr3RmQNcXKfikwZYfBXxnnckDBzH/YcDADTXFQacaYHC8nTh5LERPW3IY5tgNX2GEQbJC67XJwjI8rKnad1+wv151fRDm7qjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uKtWfu7p; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2BC913FE5B
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714053699;
	bh=Vh9MMkltQi2FaezzyNlR84OxmhjgaayN9uBNja5LyNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=uKtWfu7p8bPcVbquolukahDIXP3b/PgHpCUpgV/ClSthGPJEW5zbLiwf2+DW7JC4j
	 vjl9WR8uMR9w0RU8tSArIWcpSUdkUyataWPaKDL3WXQf3PCS76brQDwK7K8yyq4j4z
	 lsMt/05bNbsVnLebS/AiwjvUS4scxnxxMwrxOrKyidteodZdn3hRRO5o7ygXlWseD1
	 tR/JP6ik4YQcJuB5FJe6uQhI0WRG0HnwOhfqcFFz8w/KRHokHxblmtdDqs2Q3alPyr
	 lUbLM3EZmncYHOdm9Ar4+dUSNWIloS0KMINSQxLTwFZ1zJlfa/heW3GDM+dQvX3tiC
	 0LvOV+773fgvg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a58bca80981so36770266b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 07:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714053698; x=1714658498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh9MMkltQi2FaezzyNlR84OxmhjgaayN9uBNja5LyNc=;
        b=hXK+PQc/t0JPffQWEOuK5fUpRrqzoF691g/jVqgbhahNDmecn4xtcnvxPUs3Q9JUjQ
         Aki5mSK6NWP3Lu2nwPGvWBT1rQHQM9wJoaRy4XhvTup6YEoyQ3cackRZFwcWmp1jemOc
         YwNNUdrB5fr04MRy/c673tdoz2Qy4bublcCp15rrg2VQBg+OgtfWPJ6eN/zKJPKnM7hm
         BEV79bDA1pER++2cPr5Xa1Iv2d8lREYEeaB3E82a6iIr9I6NQt1CUswk4lNESsi795Ev
         7UZMFnF631kM/9yR8QkUqX39pCB0EjoXI1iLZmHKMuQm8trrjixEoX075Virlid0GXek
         d/gw==
X-Forwarded-Encrypted: i=1; AJvYcCVevj2qh2TcH7Shz/vzYR2dRekNHccoDmh0X9BBbb0gEsZux7cgZMvqjc0yPr5ArxIyzNmiy9qv28+UtlLiYiVgcpHKbQCPg4ZyEJeayEQz
X-Gm-Message-State: AOJu0Yyeb8awmwztClH5fq0n7X/yxkS5zUSan2JB8eD8IluBFNRAVJt8
	jyAWfHVIoID4h5JibvzM4wZ/4pwk5egHGf4QBeHcdeqKZEv5MJ63lctqOo5BZPyH8+ChdR2oq7e
	F85z1J5xpFqGuC2soRMSqZLCWfP1PPXxfUpeGf2qx7C0z46pVaN9d+dCCqYzrShOeH2x3SdeLzt
	j49tGMQg==
X-Received: by 2002:a17:906:4a10:b0:a58:9707:6857 with SMTP id w16-20020a1709064a1000b00a5897076857mr3086705eju.12.1714053697251;
        Thu, 25 Apr 2024 07:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUGdvGOdoFM2DQyrp81U9KOxMYphBYPxvDtGDUe2+ZgkEDQFsgVuviPGlX+re7UWJw+WvOAA==
X-Received: by 2002:a17:906:4a10:b0:a58:9707:6857 with SMTP id w16-20020a1709064a1000b00a5897076857mr3086667eju.12.1714053696684;
        Thu, 25 Apr 2024 07:01:36 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id u24-20020a1709060b1800b00a58767c1120sm3711046ejg.10.2024.04.25.07.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:01:35 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:01:33 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Add ring_buffer__consume_n test.
Message-ID: <ZipiPZia5iY_UsHQ@gpd>
References: <20240420155904.1450768-1-andrea.righi@canonical.com>
 <ZiVy9bYrX-w24huD@krava>
 <Zin12J-emVljvVrJ@gpd>
 <ZipLQmwPd--EajCk@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZipLQmwPd--EajCk@krava>

On Thu, Apr 25, 2024 at 02:23:30PM +0200, Jiri Olsa wrote:
> On Thu, Apr 25, 2024 at 08:19:04AM +0200, Andrea Righi wrote:
> > On Sun, Apr 21, 2024 at 10:11:33PM +0200, Jiri Olsa wrote:
> > ...
> > > >  static struct test_ringbuf_map_key_lskel *skel_map_key;
> > > > +static struct test_ringbuf_n_lskel *skel_n;
> > > 
> > > seems like there's no need for this to be static variable
> > 
> > Can you elaborate more? I think we want these pointers to be static to
> > limit the scope to this file, no?
> 
> I meant to move it directly inside ringbuf_n_subtest function,
> I don't see reason why it's defined outside of that function

Oh I see! Yeah, that makes sense, I'll send a v3 soon.

Thanks,
-Andrea

