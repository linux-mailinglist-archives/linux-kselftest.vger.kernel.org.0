Return-Path: <linux-kselftest+bounces-15180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CADB94FA1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 01:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBD41F26666
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 23:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB8199E9C;
	Mon, 12 Aug 2024 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iAFebA4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC316849A
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Aug 2024 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503837; cv=none; b=llps9Ae/igIwi3prAAiNQdXo/x6f6goE+zD+SvbWSVgKUW07tyAGHg0n9LPOrwoWeMr92PC1o0yQgfB3/xjYHzgQPc4/N+wLiWi7H/7qc+GZBmm6SHVAAqwS+EC6U9vGVnKQAfBfeChlEe292MftrRziNxO8ikHEcF7ZshsN3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503837; c=relaxed/simple;
	bh=YBiLFaPZjjaRkrtUK9kyWuh07zpn3P9QXmFySdar89E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agpO6eDyJNlbjC81ybdfBybtmeoxpQc3EIOAtP9SCcOrybrLKIrucK4QWxi+EjQos/kuCKqbEbTwMU62uXQL7KkTE3PR+RWJ3j9IwMXuZiOcWbHHeEAt4YRzBXCTyVeNtVUK04A/nzesOjd0VxvArNDQXePd9zRRcH7L0/VIw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iAFebA4Y; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c1b624e3b0so325506a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Aug 2024 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723503834; x=1724108634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEKpiUP3xwZoC0DTSabt4UIs6f5YDF2qKl4QrqSYpJI=;
        b=iAFebA4YYfeUXURbdde47vTzC30mCbtVUlfCyD9cbim8LJsHWd8fOCXs6/WRZ5OkgA
         XXppdgnhG34TUyNxD5mg/fsIIrIzLHyDhqDUdjDI8aGEO8z33tiYOWvYp6FcwbkPTLiy
         K8EW73r6iIDo6w9pvU3nTOZGYEWQ26gI4yZE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723503834; x=1724108634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEKpiUP3xwZoC0DTSabt4UIs6f5YDF2qKl4QrqSYpJI=;
        b=r8oNXMpx3iPMlOu+HHth20TEu9w092Idx/cKYTQAmevn4DB6QXhYC2sbFO593LWnql
         Fg1Oh01Jw48C/+JWdBXTuxgYx9HkxGR93kBcDj16h3g3ClSg+n3JQ9A9mS+897itzudQ
         x0jevI8cHWdiZctSLdIcPRwYds2ltHUE+SbBx8m68OWJWaJ51NilNwrMeYkODFTL3IaT
         xgQ07yuItEB9z64QYXiCB7XMzciJJlumTSlafk0exudAcv3M11jER+qNW1yXd07DVVaZ
         mstkIcibVh34B+swjvzSSycsEwyNKWvw7ay7ciAuS9OQk9Trtg0uH9ljsmDebaUB0YtM
         0aTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvLPn3gWP5s2Eo3Y9J6RIvHmvlVA++Z3g5DsMfuAuIRHmc5d3sH7geR9pTzEHCkNvsqsRnlB4uY+U6RHwf6rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLBDEBZjqiLo7aKnQid/K0mcNQZedADjaGEiqbjuKrM/ksm/h
	NjQMygo30vEQt2c1g+XPyZlEEmcUJFzrV0MQ/tov0tUZDf3irRSr4+3Skwe3tEA=
X-Google-Smtp-Source: AGHT+IGb+9VJLkJYuRsUl48a3JmkbNs0x0SRG38sB9+apl0xp9rPYfz/uXrpREF3TxW5/mERjhINag==
X-Received: by 2002:a05:6a20:431e:b0:1c4:b62f:fec7 with SMTP id adf61e73a8af0-1c8ddfc652dmr266014637.9.1723503833885;
        Mon, 12 Aug 2024 16:03:53 -0700 (PDT)
Received: from [10.229.70.3] (p525182-ipngn902koufu.yamanashi.ocn.ne.jp. [61.207.159.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a06af5sm211486a12.45.2024.08.12.16.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 16:03:53 -0700 (PDT)
Message-ID: <3667e585-ecaa-4664-9e6e-75dc9de928e8@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:03:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: fix relative rpath usage
To: Eugene Syromiatnikov <esyr@redhat.com>, linux-kselftest@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240812165650.GA5102@asgard.redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240812165650.GA5102@asgard.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 10:56, Eugene Syromiatnikov wrote:
> The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
> relative to current working directory and not the executable directory,
> which will lead in incorrect resolution when the test executables are run
> from elsewhere.  Changing it to $ORIGIN makes it resolve relative
> to the directory in which the executables reside, which is supposedly
> the desired behaviour.  This patch also moves these CFLAGS to lib.mk,
> so the RPATH is provided for all selftest binaries, which is arguably
> a useful default.

Can you elaborate on the erros you would see if this isn't fixed? I understand
that check-rpaths tool - howebver I would like to know how it manifests and
how would you reproduce this problem while running selftests?


> Discovered by the check-rpaths script[1][2] that checks for insecure
> RPATH/RUNPATH[3], such as relative directories, during an attempt
> to package BPF selftests for later use in CI:
> 
>      ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]
> 
> [1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
> [2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
> [3] https://cwe.mitre.org/data/definitions/426.html
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
> v2:
>    - Consolidated the updated -L/-Wl,-rpath setting into lib.mk
>    - Described the testing done in the commit message
> v1: https://lore.kernel.org/lkml/20240808145639.GA20510@asgard.redhat.com/
>      https://lore.kernel.org/lkml/20240808151335.GA5495@asgard.redhat.com/
>      https://lore.kernel.org/lkml/20240808151621.GA10025@asgard.redhat.com/
>      https://lore.kernel.org/lkml/20240808151621.GA10025@asgard.redhat.com/
> ---
>   tools/testing/selftests/alsa/Makefile  | 1 -
>   tools/testing/selftests/bpf/Makefile   | 5 ++---
>   tools/testing/selftests/lib.mk         | 3 +++
>   tools/testing/selftests/rseq/Makefile  | 2 +-
>   tools/testing/selftests/sched/Makefile | 3 +--
>   5 files changed, 7 insertions(+), 7 deletions(-)

thanks,
-- Shuah


