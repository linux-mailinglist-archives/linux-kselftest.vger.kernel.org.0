Return-Path: <linux-kselftest+bounces-34372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E540ACF266
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F5817A6B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280941917FB;
	Thu,  5 Jun 2025 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jncFLnTr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7E62C324C;
	Thu,  5 Jun 2025 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135338; cv=none; b=JVXyaTKZCitU84BuZm+OFgc51Wd4yz5ZqNt+qKxI53hq4zpn33JsPAbWz7wvooix8S3Xlf+xy7B34mgjuz+EYEIWMrFocrjTMgqm2iKXhHtqaZxetfYk3MO4i3Nnt8qToGxLbqU5gRVs0jb3z62YSo+rhIc9h3GgdvohmbTPJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135338; c=relaxed/simple;
	bh=9cZHR0UR0AtY4B2b908smxj28pEOo7Yf1Vgakmevv4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XViKhBl3tl/AlpBITXtcq/4dFYXrVVelhvgnkZSG7OkRPQxfCB17SCHOdCJGnXp3d5GbqX2vbUFy82pMnqDwv41dMXDtnb8hPTMCyAHmNZYrfAkgO6W56qWu3AJWLsVrxltwJh2ocNHoA8yJXff26RMl3ac3L3+U8ZorPbhtzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jncFLnTr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231e98e46c0so10550235ad.3;
        Thu, 05 Jun 2025 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749135336; x=1749740136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=COOVN/2kU9VyocOPfGmhspc1kH4NR3Ob5i1C6qOFT+g=;
        b=jncFLnTrNhXDZlWY8cnpZaFZV1AebyDXEN3gpYA4dKhqq+69f9FPVhSXzhpx3uMfv/
         bzwTL1pLxYsQgglS5eBxTseB3Uf5exulAp+tJiQMG3kLee91NLyfhZH/jeOMeW9slLqz
         JJeeUBzR1K1NAnOREzhJD7IrZ4yhVop9A5KZnEzqigM/QA4Bka+Mac7b0pqldKUzj6T0
         MUH/M1Kfe5SVP62QxpfBQaMCS7JPoDSmeTa4xkLsOVuFfEVymFgeevdMv6igisKJa2HS
         luGxN6YxJMCZZlg3ibsnkq/t/Bd08FYyYGuDngrxU0HLXtXa5UXP9pyrKLP1OjLwGs4P
         YjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135336; x=1749740136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COOVN/2kU9VyocOPfGmhspc1kH4NR3Ob5i1C6qOFT+g=;
        b=JofXv7iaC72qdkZubCklAwf9ERQxkuGFqdz2ZzFDYXLF/3qXEyPJK8lUlhJjZ67N9L
         j6AeqPCOpJcadw8UIG3ZqYA9ij5YeaoqQHeXo0aoaizBCDcFMrXEzI1eWiclOPWbN0TP
         On2963yhy1TFcXWPxOTi8tTjPvKsqu9w96JBa/NumxvRlkIrDvIHiG2QaAx69QIf3gMR
         QhNENXqFViH1abqfji/Te4EL2YrJY1K/ozpRbtO0a2FAuktpLNE0cHH8J7NGhHxY4HK8
         nVeUT1AmyCnfq30bsQSylMzi2ncuxh/4faL9kqrP+w5CeO3BxSDxsR2I/bJ7pgRqh2yb
         6o7w==
X-Forwarded-Encrypted: i=1; AJvYcCWe/E9O3ZdT7O5pfylsx3hAjMyi9MmZoTQV87BG77HF5BtGPQh4lb3yvQZTI19kKxM1IjGstvSG@vger.kernel.org, AJvYcCWzyx3e5BNcvLjC1U0ucVuOon9iQq2RouMlV3l83VCC3OUcDcjAQe1Oc5LiBarukG3Mngw=@vger.kernel.org, AJvYcCXVmswRzqSrA/x2XKDDXA/WO6djy0A//OTup7mPCdfl84N4HKs36J3fQwSJYfx3AA1rB5xK4JY1YX7IS7dw7CPS@vger.kernel.org, AJvYcCXcVtWqsyP5XjrO5l9idl1dN8B9gnF9nqIieOYFDeT96GZ9C9vnCcOgghN1J0S2/sX6fDlx0EeY5941/rCj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0muR7ZqeY3UFkrr9Q9ub4I5vdZlshjeZe/nBK4BECk3JadYlv
	YxVz2UUQYO87z+Rk2EUG+ajAtdMq6f8RfwYiq5mEhqC9itfC4gm7dA1o
X-Gm-Gg: ASbGnctjFdEaJUiNmestJ+ENTBMOFDMEHFlLu4FfFnkK6kaZMnxb5I8IbvfBeViqny8
	WuMZXIh58Mq/7WWp7lt1mBe/MqCA97KEb2Gq4t92t7avt3Nvn2x1nAvLq5DhwD/NKiU4Kl+6J49
	Pl+KATlptB1dh0JBjaK5SdFd4VXp6sgHcv04IecyIyAX+bYBH3nM4W1EQ7lx4F9FJ3L3pSd83ct
	yXw8R18dqujzQDJOfTobIV4wAPvBHfQGAYuvSjZKI4o+JGlr2vthOdvBt0o/ALAfePGMyK3xt6Q
	fdveVTauVAADjHCku2kUK1DO1bjhoLeunZZbV56GDytTebaHtzKhVowXo8g/cA==
X-Google-Smtp-Source: AGHT+IEjdviQxVCCEwlyGzpI/wq2drQDCMCyyBvG5XqgSZkx4Z1pIi+SDjUcETxQ8pGPSokV/7UJBA==
X-Received: by 2002:a17:903:3b47:b0:235:eb8d:800b with SMTP id d9443c01a7336-235eb8d82dbmr52447465ad.26.1749135335203;
        Thu, 05 Jun 2025 07:55:35 -0700 (PDT)
Received: from gmail.com ([98.97.41.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd9486sm120154115ad.67.2025.06.05.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:55:34 -0700 (PDT)
Date: Thu, 5 Jun 2025 07:55:29 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, bpf@vger.kernel.org,
	Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Ihor Solodrai <isolodrai@meta.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf,ktls: Fix data corruption when using
 bpf_msg_pop_data() in ktls
Message-ID: <20250605145529.3q3aqr6iygpa6xg6@gmail.com>
References: <20250523131915.19349-1-jiayuan.chen@linux.dev>
 <20250523131915.19349-2-jiayuan.chen@linux.dev>
 <aDika2FRd4n+VRmZ@pop-os.localdomain>
 <d99805aaeadd9cd041c9048801084648832a6da1@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d99805aaeadd9cd041c9048801084648832a6da1@linux.dev>

On 2025-06-02 11:04:50, Jiayuan Chen wrote:
> 2025/5/30 02:16, "Cong Wang" <xiyou.wangcong@gmail.com> 写到:
> 
> > 
> > On Fri, May 23, 2025 at 09:18:58PM +0800, Jiayuan Chen wrote:
> > 

[...]

> > 
> > I am wondering if we need to WARN here? Because the code below this
> > 
> > handles it gracefully:
> > 
> 
> Hi Cong
> 
> The ctx->open_rec is freed after a TLS record is processed (regardless
> of whether the redirect check passes or triggers a redirect).
> The 'if (rec)' check in the subsequent code you print is indeed designed
> to handle the expected lifecycle state of open_rec.
> 
> But the code path I modified should never see a NULL open_rec under normal
> operation As this is a bug fix, I need to ensure the fix itself doesn't
> create new issues. 
> 
> Thanks.

If we never see the NULL lets just drop the WARN. In general we prefer
not to scatter warns everywhere.

Can you resubmit without it?

Thanks!
John

