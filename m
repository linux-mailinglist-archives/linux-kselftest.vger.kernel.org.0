Return-Path: <linux-kselftest+bounces-14793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B24947DFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 17:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D115B25881
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAC116CD0C;
	Mon,  5 Aug 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="duwpYqDB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671481537D9
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Aug 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871346; cv=none; b=N1ae9XsnTHvOSG7QMELysAvKHKmYp89wvbTcgC02UlVAKMd4EEWu6Wk5ILGsbGpjx3/bk/rO4TEUV3WiKr1U/+Ts7aR2BGRISJcEdWBps1zTgUJnrD6oHzzI07lNYPqZlG9kQJ5w5d+kRB1NNjBBspda168OxalLdAaoE0HckLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871346; c=relaxed/simple;
	bh=7MNrmWDmCHETLP7byPXDSZNNxg5Ec+2Z6SzvxnYDw+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JRQukg4SbN5l8HVp7S2jjP+bLE7Rf4pB3coY+W+TCw2qFZMaO0lsfPrMRo33AXweUo9YXf64vJ03kXDunx4xb48GSY/kLAcEPl2p1k1jW7eKgRaPeCTErLD1hPVYTurcyJRoroq/dhFZy5w7vHhuMRRSnkQQn5E8g++TVo0hMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=duwpYqDB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7ad02501c3so414624566b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Aug 2024 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722871343; x=1723476143; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MNrmWDmCHETLP7byPXDSZNNxg5Ec+2Z6SzvxnYDw+k=;
        b=duwpYqDBua77XfqYw5QIQe5LVLWY9yG5LkeRuI9lVpVI1aCO9Mg6Mz+tnT7bn3T9Ue
         4TkDgHE+aaneK5vY+FBDA4xAcKa7WnX9BZr6MEV6OOOd7/MmYP8DRWr0n5G/qivR0UYX
         AuCTPY0wVQlOS0nRztNY1K2Y38XlRdO6cu2cAClpJLSzXX+fBAvxUwoAr6PVsq3MGnSN
         18mDY4OrVVVlsES90eRRw1KLeR/gYAuDMmH8jYfKYKBlwmI/NXmN4LuM23a3Zg6fz7WN
         rCQZ5w3gjFMid6UzEFlFYCLktGLe+IEt3hhbUqAUC06CbtBUfzREq+lYOj8SPnhuQ6od
         d/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871343; x=1723476143;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MNrmWDmCHETLP7byPXDSZNNxg5Ec+2Z6SzvxnYDw+k=;
        b=JJHsWPMN5o0cUXbNWb87FH8Z382y2ck+DZvuS3ndwUeVpFivkzsj0yR03LlbLJGzPg
         IFKdRYh6X2FMgThQf0+rvAA4+1bHhApP2FX2rlv5mNPJV6lxjDzrz7zrjvE0g7uHQcb4
         c9Ki/jEAnvOt2uk6JWtNaJ1dTE02tU96aT7tYLIURd976aJwgh8aTHTzN2RZXbbGljYP
         D5TtjbUEIBoc2KjYPHJmlOZU91iXLGwHolTCh86cJBg9US1BY7Hfu/EG1CVpKJkZfmnZ
         KGh7pXIkVJ0kiy9pKVH6V7+L7mjnlkeesZjDo72XOUno6JpVKVXWbMQ/Mf5Et+JT4f6q
         G2lw==
X-Forwarded-Encrypted: i=1; AJvYcCWKRbhjw6/YDkqpswUIEzleXAKAmz6V8EQVxm0eWPfLpSw09aETiz+c7RBm0xObYlUbkJMGUf97iDF6vfwa7ZknAQpOeMTAoLK+X9UfrzjV
X-Gm-Message-State: AOJu0Yw/gpuS58OFw7QR2p5cjoRcEDek/Mwk86xdto8o8oDWpdycR/3S
	FCGE0XJ9rNwMur320GwbS4EVWOQm/N54SNd94amtoNfq8CudD5HjJSOeHSIeaiU=
X-Google-Smtp-Source: AGHT+IHf5/EN37gHp4+psKIk0tgklzZv5YnqYEQ0lWfNPTc/nX+llUFm2rD82+x6VTV0MzzOttW3kQ==
X-Received: by 2002:a17:907:2d24:b0:a6f:c9c6:7219 with SMTP id a640c23a62f3a-a7dc517a75emr918517066b.47.1722871342585;
        Mon, 05 Aug 2024 08:22:22 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de2e1b093sm343351866b.148.2024.08.05.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:22:21 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
In-Reply-To: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
	(Michal Luczaj's message of "Wed, 31 Jul 2024 12:01:25 +0200")
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 05 Aug 2024 17:22:20 +0200
Message-ID: <877ccvyoyb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31, 2024 at 12:01 PM +02, Michal Luczaj wrote:
> Series takes care of few bugs and missing features with the aim to improve
> the test coverage of sockmap/sockhash.
>
> Last patch is a create_pair() rewrite making use of
> __attribute__((cleanup)) to handle socket fd lifetime.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Sorry for the long turn-around time.

I have opened some kind of Pandora's box with a recent USO change and
been battling a regression even since. Also it was CfP deadline week.

I will run & review this today / tomorrow latest.

