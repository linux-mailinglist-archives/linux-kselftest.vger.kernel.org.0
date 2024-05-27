Return-Path: <linux-kselftest+bounces-10738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38A08D0E0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4BC280CEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 19:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D21160880;
	Mon, 27 May 2024 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e4xleDS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6515FCF0
	for <linux-kselftest@vger.kernel.org>; Mon, 27 May 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838596; cv=none; b=T2P6zEuUvp0YIQsoD7T+sUaK0v1cZDi3s6lFaUper2TWmWV2y750UNKlU+JwvUpbqOUlz5h/HDhptznWpzSt5oAFvqZrWiXIGGD9EJcea4sJe9tXK9cNKmUPiGEjSf6KqrIBKpWNCf5QZGDuvRmHGEf8l3kxK1dGe3AyNLTaqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838596; c=relaxed/simple;
	bh=hBztDfsju7jvSHs2X1CbqXJ/9RFgcXepl00UZcxNhpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gB5GlCO3+c3FxHj/+zzlNG8dfILY64mJ+xlqjOjQNB768+8ZyNKcG7eeiU/Ta1+OpVKdyPV8W+84riD5bfKEXx8TD3vLWR3bhvSy+xv6s21eFUtxwvulVgx/BADeKEwWbwUN5RK0KdvleIAKIvYUa6ROc/E9+CaN5nP1c9G92/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e4xleDS6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso471951fa.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 May 2024 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716838593; x=1717443393; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=460uV27lQordnsc0AJG+gZtSNZZpMZFmTeFH7GJ2IBs=;
        b=e4xleDS6EG0oMlnL6PmBruyD0LaoAb459sRhAlFi2ibiZ5JPYDKF3FxwEPryode+z5
         MafddPavtJkECGK6LuZU7pNs2d88ZZ7bqvCl3ki71MgVYnqbaqgBBZMlnEHWKGAkaFTl
         cp1UD0KDnVGd3QX8AR+0z9kh+oDKEMtg8BgtmeNnSUM7+0EBgBric6pnAq4H04dM5Mwm
         m+fU/YkiKRzyFl6fyfpUhJQuUECKqDmx5QPAYfwbrtl2+KWdGje1WnJWzg7DPh7zFdRY
         bpBu4Ir9gDMevfvpwd2rpUYELSjCEx+aQEpF7kVnNOY+5/ZNu8t6MLxbIj6/h5tt4nER
         etNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716838593; x=1717443393;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=460uV27lQordnsc0AJG+gZtSNZZpMZFmTeFH7GJ2IBs=;
        b=xSoj0Nrg6QoEKB48BfpQHPDaSJuapvOv9lK7Uqke+qd7LdyaIBk2LgIqxXnwOJeLrs
         DQ1q7JCqPyiU6uZR0b6+P41UElc4nn5Hv6Ru8s1v0x9lgkMq5AfFt6hniIH189pdFpju
         nBXfnytKbxdj7x7pjdi8+p9fWXr3//jdgem6yEErhG1j6vcMPeNzZVmqbHFbzNmx4rvI
         yzze0hCxASNEq6/hDaetDCExdjV+Hys5K2qHNh3QrHXjgiHEc2pgH343ylQqxGXcpE8h
         9qPLBOkPkZVKu1sqbPqrje9sOntibLrhD+BsD0zY8VoVbX0xrJgV7j5BLetX9P4uNHBY
         yOCw==
X-Forwarded-Encrypted: i=1; AJvYcCW6P0GonX/vJ7ySdEzLOETND/pSrxlD4fTSHwpftOkJd3hVAGFoqPaWEvZkd80hZEAns4J6FASNnopkLcU/n0BI/ZrpsiOTTUl2mMJDcFq9
X-Gm-Message-State: AOJu0Yy3rikOSWCEhwzsvhgmYzGK5HtpugXFmDplQPCzmyz5MNTtBcDO
	orRlir306DLGdRRhfHNDbkuzbH6gVbe1Tt9VEzPey95ZRBuXbyHFx5Mn3AuGwks=
X-Google-Smtp-Source: AGHT+IEojifswV/dPUHHhC/U3xFxhX87rNTI4M2ybuWgK1NozFiNdYtCGW3FO7XEsv5sFQh1P0K/Pw==
X-Received: by 2002:a2e:9e9a:0:b0:2e1:5644:24e7 with SMTP id 38308e7fff4ca-2e95b1cbdd2mr60399711fa.13.1716838592717;
        Mon, 27 May 2024 12:36:32 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57967499969sm3641328a12.22.2024.05.27.12.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 12:36:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Geliang Tang <geliang@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,
  Eduard Zingerman <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song
 Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@google.com>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Geliang Tang <tanggeliang@kylinos.cn>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/8] selftests/bpf: Use bpf_link attachments in
 test_sockmap
In-Reply-To: <6654beff96840_23de2086e@john.notmuch> (John Fastabend's message
	of "Mon, 27 May 2024 10:12:31 -0700")
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
	<32cf8376a810e2e9c719f8e4cfb97132ed2d1f9c.1716446893.git.tanggeliang@kylinos.cn>
	<6654beff96840_23de2086e@john.notmuch>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 27 May 2024 21:36:31 +0200
Message-ID: <87wmnfujwg.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 27, 2024 at 10:12 AM -07, John Fastabend wrote:
> Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>> 
>> Switch attachments to bpf_link using bpf_program__attach_sockmap() instead
>> of bpf_prog_attach().
>
> Sorry it took me a few days to get to this.
>
> Is there a reason to push this to links vs just leave it as is? I had
> a plan to port all the test_sockmap tests into prog_tests anyways. I'll
> try to push some initial patch next week.
>
> The one advantage of test_sockmap is we can have it run for longer
> runs by pushing different options through so might be worth keeping
> just for that.
>
> If you really want links here I'm OK with that I guess just asking.

It was me who suggested the switch to bpf_link in reaction to a series
of cleanups to prog_type and prog_attach_type submitted by Geliang.

Relevant threads:

https://lore.kernel.org/bpf/9c10d9f974f07fcb354a43a8eca67acb2fafc587.1715926605.git.tanggeliang@kylinos.cn
https://lore.kernel.org/bpf/20240522080936.2475833-1-jakub@cloudflare.com
https://lore.kernel.org/bpf/e27d7d0c1e0e79b0acd22ac6ad5d8f9f00225303.1716372485.git.tanggeliang@kylinos.cn

I thought bpf_links added more value than cleaning up "old style"
attachments.

