Return-Path: <linux-kselftest+bounces-14842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 913F4948E47
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397871F2396C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DC11C232A;
	Tue,  6 Aug 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CtTWSoPN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C683166F2F
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Aug 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945691; cv=none; b=SADzNCV6tJI9GsSChp++eiJ9LbWf+MP90a7kmbudtEv1eM9RgLaH7OzyjUb/ljS9Qq4MY+w/ZQo8TimXLvMQBNVVGQJ2NJSxssVgYp0iQljhgHAZS1TUZJdOfIDrSustxdF2SZS/zqBOlJb59Vz8dSK13KfvHC0xrauE4A2jmO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945691; c=relaxed/simple;
	bh=Lugsx6fzDwyeoUcfvVDJLgsJHlh3ibZ4yuE5vwJULrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EMPJowESCVQwFo/nYuYqVKhy7eFiTaHmT6UIowE17ZX/6w9wa/BCt9pdTw6R23Ev8fHL1mEOB3kbX26uhgoJz4xw+45b8zuWfPAe4x/H94n/V6tsPgEVQ5hPdn1Kb7PgFC94Uc3gX+L0TpS/XxA2KrvhGaONbGvf6MTOwMpwkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CtTWSoPN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aa086b077so64049966b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Aug 2024 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722945688; x=1723550488; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SC/B0o7+RdgTPnb7EbqFy0h9TTXJHbv05EgMHed2hQM=;
        b=CtTWSoPNMagkvVC+duRMDzRo3hkUXDVqG54/wYPFyQAHcG+XyyseU9ZJIQscFWaeTy
         lq79QpXkVvF3Aw34hrlsJIKdhtkg2sG3gHskJpPFFe5u6UTzMqzKhHU0lqDUKh4GcDk8
         K3r0OT9krfaCpmyHC+my2c4Gq0O2MMjnUg5FvTh3bqBVqNSzAbRgUGbanfXyoPOwjfQ0
         MoOLmu8cls45V38tlqAfmb9YvsWzS3+/+uTWcm/QMwf3nEyfTOVYPrHd2S3+rbs8sYBB
         S4Y98UP+e1LfUqv/H3YPj8m/+m2TkbB7HUfS7Pyi/FUU2awOfmNDalO+0CEgboNsg0SI
         0nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722945688; x=1723550488;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC/B0o7+RdgTPnb7EbqFy0h9TTXJHbv05EgMHed2hQM=;
        b=uQn9TI9z3mSARDDeEs+Nzb7u3bgVVP43WxkkyPi/WdkzVKFInCee0IMVBdqPDwd0X0
         UHzUUBOREeOZe0BScHA17O0XYCJjOt11Ngc8pUhCBr5fYxDQKiXdg3T6tX+OMkmtXJ/8
         lVToWccAHbYI5ahpvaFzPf9/bYUOmOyRY0IjbAdEFyzjUq02Xt9OZXB8xgcuo/Yoif9V
         5U/qu6vxo4xYElcZt4xldZDl7/HzNd2SkJuq4wzSNpaw0Y53aJk5qJ5uBPlc+g8Ogh1y
         HUowgxiNqQjpt2PgcbelOVKtyiWOe/0tg+/I6yobZ6l6XbXHwCZRu3FsdSz1drocdGe+
         tGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPwd5Xt9vZ3P5se/og6hsML6d7uo/GMxe6c4jdRoZqGGZYTy/a0uUoFc4X8gjl2k7m46VI89XNz7GR7CZyaIH9SEMexvk618KqamQfvQtt
X-Gm-Message-State: AOJu0YzYU17WOWn+wxo5edl9GmFvz4FRCQUP40PJmBYi9Hgt/1A3i1Er
	DuAwCzlEAIoVlJgv40aJJq0yjnkv7eaMSSFnPfw/rDQa7UpepPdQc8TJJpxAR8w=
X-Google-Smtp-Source: AGHT+IFZECUBQXofC+L4rA9OhKjiBlUfVSyXAns5FoFrow7eTVkumUQVC1WUleF3rWg3eVS8qyr7bQ==
X-Received: by 2002:a17:906:db03:b0:a7a:b070:92cc with SMTP id a640c23a62f3a-a7dc5106e2amr1253822266b.45.1722945687914;
        Tue, 06 Aug 2024 05:01:27 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c801sm539912666b.59.2024.08.06.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:01:26 -0700 (PDT)
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
Date: Tue, 06 Aug 2024 14:01:25 +0200
Message-ID: <87y159yi5m.fsf@cloudflare.com>
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
> Changes in v2:
> - Rebase on bpf-next (Jakub)
> - Use cleanup helpers from kernel's cleanup.h (Jakub)
> - Fix subject of patch 3, rephrase patch 4, use correct prefix
> - Link to v1: https://lore.kernel.org/r/20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co
>
> Changes in v1:
> - No declarations in function body (Jakub)
> - Don't touch output arguments until function succeeds (Jakub)
> - Link to v0: https://lore.kernel.org/netdev/027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co/
>
> ---
> Michal Luczaj (6):
>       selftests/bpf: Support more socket types in create_pair()
>       selftests/bpf: Socket pair creation, cleanups
>       selftests/bpf: Simplify inet_socketpair() and vsock_socketpair_connectible()
>       selftests/bpf: Honour the sotype of af_unix redir tests
>       selftests/bpf: Exercise SOCK_STREAM unix_inet_redir_to_connected()
>       selftests/bpf: Introduce __attribute__((cleanup)) in create_pair()
>
>  .../selftests/bpf/prog_tests/sockmap_basic.c       |  28 ++--
>  .../selftests/bpf/prog_tests/sockmap_helpers.h     | 149 ++++++++++++++-------
>  .../selftests/bpf/prog_tests/sockmap_listen.c      | 117 ++--------------
>  3 files changed, 124 insertions(+), 170 deletions(-)
> ---
> base-commit: 92cc2456e9775dc4333fb4aa430763ae4ac2f2d9
> change-id: 20240729-selftest-sockmap-fixes-bcca996e143b
>
> Best regards,

Thanks again for these fixes. For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>

