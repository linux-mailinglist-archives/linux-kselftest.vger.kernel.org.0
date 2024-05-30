Return-Path: <linux-kselftest+bounces-10973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3918D566E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 01:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AB0B21C8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F04146590;
	Thu, 30 May 2024 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpySWyf8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B921350;
	Thu, 30 May 2024 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112712; cv=none; b=omAnDkOK3hMOdyL/CPyR1PHD+JjfB6j5OBoKb5kTbRuNRlYO8BW8y8xPKKRI+VXNTvH/mcofMovHDYFEYICCrTp8GhLQrobO45OIia2Ipw770wQUcJWqDHlyaXzhEuqZ81xNiI9YhGUf+Zk6dSKZNd2aYRyivDMHeog5TQ6a8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112712; c=relaxed/simple;
	bh=4Oc+m3+Nk8x6Y8I3QBKXaT6ViIsQwI7wH5+yiVXpBJ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p2T0bACcoJOWvPfLjxBWoAvPltj2ljxFafJdL0GOqjuHvDLbOPxg4hIBTrMnD7OqTp2aUiJvwbSSLToeN9fQv/X2qaE6kOQkb6HEm+GEdx7VVNnkGClIwocSv7nkE8MMoJ7G3/npZ+HS6Zl9RTlCUgHvHiPITUqgE1fRIs1muAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpySWyf8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-702492172e3so28377b3a.0;
        Thu, 30 May 2024 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717112709; x=1717717509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3G+jDsv4wEnRcKQbCAKA4BnjOF/6ofEOjGAIR3T0nk=;
        b=TpySWyf8izaiE160FngxfWJYzkmThrrgasG3eg8QiV8GfekMqYJHjJzfkcsetFvqmm
         gz7qP6alyuzEiV8yVXr6Y+FzLAwzZg89V5T6YrlMZx8K2i/osQsN3HmxdZ8sP93cjthL
         FLM4xMtBQBZeopYy3u7PgL/Qo8uWl/fIQWahPMpee44iEnc28O1zAiHuoFT0KE4YurRV
         XgI56fuBpALo3Gl/clkQaRwm5pze+SWt6zxgD+upPIMxpf8/k091EHLG3RpQbCwr3pvk
         99wGulvOcUZn6wS7flU6DrBLC1KdLgd9ot0V5na6ilcUewUCYoYjyDIQIBrGoc1a6uFl
         auOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717112709; x=1717717509;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M3G+jDsv4wEnRcKQbCAKA4BnjOF/6ofEOjGAIR3T0nk=;
        b=NzpGf9MybQ3he/L4PuCWhREWROuza1jcSflnsZ9pI9SRCPEviz3jESumUqJxre9irP
         +eFoZrjbQpRZJT1MhWyecWrjJuRXb+lITzq2r2V94X/jJRl+4KGmos9rOT3otyZogvMq
         9k3NRngo2NijURiGQbjaA2fiOk7Ks1GMdv2ePoEwHYoaShE5wNQUuKeYdsEj3xoIxMLy
         yNFIMtGQ1+MxL+Bapm2U+1yCsUccFNvzyeKohaaH0rcoeCR/mTaxlFGisXgO2Jmg/y9Z
         +izAJ0FvCMNfDBlAUboim753BITbnzX09gxWsWhFRfRBsMVLq3jGalz9aQH9JvXdrxpy
         o98A==
X-Forwarded-Encrypted: i=1; AJvYcCVzFsYLZiGhFGw95g7uM9lacaGi4tEH2m+uy+wolo2954P8XDXBhwGkFU6wCymdxNG4V74PD6JJfaWSm0h7SU08NP3smOqw0dIuFvfJ7mskzJm8EcosC7+eNeROUiGbcwPHN249
X-Gm-Message-State: AOJu0YyUElesJj0mUPG9cn9x/EryR8uwjm2GW7LZqFlteD7KM7jYub0L
	c9zLFHo2i3wyexY3rHIU1kATD3h5/eEFombmHhgcqB/NuLIa+G8aGAGBFw==
X-Google-Smtp-Source: AGHT+IHfch8tKdn3OUAXb+7Qwy6NmKkJfTE8vlQSEIgIkyCUzwEWSpleVlq1uR9EBMm/rwKfI/RfMg==
X-Received: by 2002:a05:6a21:3949:b0:1b0:1025:2d5 with SMTP id adf61e73a8af0-1b26f16ea33mr508541637.36.1717112709246;
        Thu, 30 May 2024 16:45:09 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242ae9d45sm275640b3a.132.2024.05.30.16.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:45:08 -0700 (PDT)
Date: Thu, 30 May 2024 16:45:06 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Geliang Tang <geliang@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <66590f821d120_e5072085a@john.notmuch>
In-Reply-To: <577531139c4db3cb35f3f40e23587bcb9815b0ba.camel@kernel.org>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
 <32cf8376a810e2e9c719f8e4cfb97132ed2d1f9c.1716446893.git.tanggeliang@kylinos.cn>
 <6654beff96840_23de2086e@john.notmuch>
 <87wmnfujwg.fsf@cloudflare.com>
 <577531139c4db3cb35f3f40e23587bcb9815b0ba.camel@kernel.org>
Subject: Re: [PATCH bpf-next 3/8] selftests/bpf: Use bpf_link attachments in
 test_sockmap
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Geliang Tang wrote:
> On Mon, 2024-05-27 at 21:36 +0200, Jakub Sitnicki wrote:
> > On Mon, May 27, 2024 at 10:12 AM -07, John Fastabend wrote:
> > > Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > Switch attachments to bpf_link using
> > > > bpf_program__attach_sockmap() instead
> > > > of bpf_prog_attach().
> > > 
> > > Sorry it took me a few days to get to this.
> > > 
> > > Is there a reason to push this to links vs just leave it as is? I
> > > had
> > > a plan to port all the test_sockmap tests into prog_tests anyways.
> > > I'll
> > > try to push some initial patch next week.
> 
> Great, I strongly agree with porting them into prog_tests. I am also
> willing to participate in implementing this plan together.

I have a first patch that starts to move things I'll dig it up here.
Still a bit behind on everything as you see its Thr already.

> 
> > > 
> > > The one advantage of test_sockmap is we can have it run for longer
> > > runs by pushing different options through so might be worth keeping
> > > just for that.
> > > 
> > > If you really want links here I'm OK with that I guess just asking.
> > 
> > It was me who suggested the switch to bpf_link in reaction to a
> > series
> > of cleanups to prog_type and prog_attach_type submitted by Geliang.
> 
> Yes, patches 3-5 address Jakub's suggestion: switching attachments to
> bpf_link.

OK. Lets just take them the series lgtm. Jakub any other comments?

> 
> > Relevant threads:
> > 
> > https://lore.kernel.org/bpf/9c10d9f974f07fcb354a43a8eca67acb2fafc587.1715926605.git.tanggeliang@kylinos.cn
> > https://lore.kernel.org/bpf/20240522080936.2475833-1-jakub@cloudflare.com
> > https://lore.kernel.org/bpf/e27d7d0c1e0e79b0acd22ac6ad5d8f9f00225303.1716372485.git.tanggeliang@kylinos.cn
> > 
> > I thought bpf_links added more value than cleaning up "old style"
> > attachments.
> 
> Other patches 1-2, 6-8 are small fixes which I found while trying to
> solve the NONBLOCK issue [1]. Yes, I haven't given up on solving this
> issue yet. I think it must be solved, since there is a bug somewhere.
> WDYT?

Yes I think this is an actual issue with the stream parser waking up
sockets before the data is copied into the recv buffers.

