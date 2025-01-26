Return-Path: <linux-kselftest+bounces-25196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36E9A1C853
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411163A5C05
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E707E14D28C;
	Sun, 26 Jan 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="H2WWdMxT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9B13C3F2
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Jan 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900736; cv=none; b=N1DMzIe8sLN5qA3Fsyf+m4lndM3pU/1N6PDw8rcXJxpUnjfHHeOTO4FyPPFwV/iV3D51P0FktY5nRvoKwqnlCVmTlTOf4M5rDlaZfDsbtISGYZYjIXwdzO5WbGboj69/wOaDDqHa6eyocgiRtZauCOCcRH0i/nt8SsbRysGB3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900736; c=relaxed/simple;
	bh=da9YorvvFk4UIYAefIerEYb4xCuivSVbVedCiCnFYfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7J9epO0wpNgg0Z5dRAUiSYVmoNdHkkbKeEFppFzOrevhwWsS6rKPlmnAaUAyiw9fFsEbU0DzH/vBiIxRMGPWAaUkZq/RWbjVsWp5EbUeGUcvArz5JVkTBNs6Fc2LPYT5QOsFJ6gzYqTmTaVhjaGwdkOr+jkCatHZoNGnKwKfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=H2WWdMxT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5db689a87cbso7246106a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Jan 2025 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900732; x=1738505532; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=da9YorvvFk4UIYAefIerEYb4xCuivSVbVedCiCnFYfA=;
        b=H2WWdMxTEBWu8YzCIX7u2/9XZXqzo1mKYjwVtSD3h4/dByN4Z6N2UrMXOqxljunCje
         Pqh52tYfxCAWMjPAeGKyyGiJNWpmEwGStY9IMMTuJnR7NuVVQboZTdD+xrquWP7rs2yf
         U0j0tEdnklmUatLiNIx/OGwo1mgYooIBdN3LeeJEDJ5pD600aUBuwLsa/WRkSB9CKRdd
         No8jyYnX/TWy747D808Bo8tsxezlEsWuJ7d/6mYbg8+pQy39bsesQR6+cEVOensfdC9L
         GbVB/w1wrt+4nvBs1BkRlEtDmbfc1f2HUZaBvvbewkFR4ZQYYbsyhibrrHZN4nO4a+kX
         JMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900732; x=1738505532;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da9YorvvFk4UIYAefIerEYb4xCuivSVbVedCiCnFYfA=;
        b=g1y5wItSCc5EhKAKQz1igNhpJZI9TB0MJQBGkhxOHUBE8qFBmVDK9IncNuhUEB6NaO
         2bE1seEzQ/9ZNPLFpqs7yyLiSymdlhck2U1MzJFzJQzkK4iktgQPK64zQn31w5L4K+60
         8KBous9WCO8oG5ZHDpeFRHv+Q/zIkzIh+0+pJDrTJEFzeCM4mkBwOPilAzuuU7++wgpp
         OYg6Y1IXoIMwksb07OkmFxELnYLtzPSbn0O/cs+ww3LkBYbpHacQzHZ0l7KBdcPhylc7
         +AS6sCFVCIN6CDA6pnNlTbRGJ4UUoPwQ/UUli5NuZfB5DO8RyjRdGcQP9C5cveMbiT0/
         ivEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsZUPyQUSpJLpMPRNpf98TN+n3DPoP5LmaozWUl6kG83GKmxQalvCG+a7pwWfTxaJxfcTwKtYgVP4dTdaz95s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbFHD9FR2MMV7dBokHjxoV7u2UvmTWWoPiuHegOs/3ApVIKEJ
	oWXdV0+bXxpj8ZgoglMJCOqJ4FDzjcGEMuJlhPzVqdMaQhv50kztw4O0AledMdQ=
X-Gm-Gg: ASbGncvbyJQEvLCx968gAq9TF1YfMOMbmsdStUbDw+rmd+Q+pq3YjrcmILic1cRd2TL
	aVGgXGOjMtvREAWbphnLm009XciNRyfvj3S448yo7ixUxYzJf5mTrGbA6HqBVAhgpOLHalxgD2G
	TixvCTJHSjpGjZM0R9OmA5O+/TQo/d+gRE3XBQMfYuzGhte7hHPZl0wcB0le1Du27Nsl8mWvMv8
	NoawvLqtHPYKsXeq93aGgGNzG+41npZl/MgjaUYidObNQ3lXgw8WxupnurXUhIk2T86fgRrew==
X-Google-Smtp-Source: AGHT+IGBKFasEkaDtZZ5CWcrV1Bxnz3k+ijYYsGxkH5Dhoqoj3FM7YBEen0VjurFTCvcD+kWOyT5Vw==
X-Received: by 2002:a05:6402:3509:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5db7d2d9958mr37213488a12.6.1737900732189;
        Sun, 26 Jan 2025 06:12:12 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc1863a1fasm3986231a12.37.2025.01.26.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:12:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 4/5] selftests/bpf: fix invalid flag of recv()
In-Reply-To: <20250122100917.49845-5-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:16 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-5-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:12:08 +0100
Message-ID: <87frl5d5qf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> SOCK_NONBLOCK flag is only effective during socket creation, not during
> recv. Use MSG_DONTWAIT instead.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

