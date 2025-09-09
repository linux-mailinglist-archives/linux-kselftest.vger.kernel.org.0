Return-Path: <linux-kselftest+bounces-41011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D30B49F40
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 04:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066DD4E2924
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 02:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3B242D7B;
	Tue,  9 Sep 2025 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6Ll46oX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA71531F9;
	Tue,  9 Sep 2025 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385289; cv=none; b=UfCsG9f75juKQIVX9OjXvFCzMhJ5UKSWWqjLICxIHwOQ+kz/WSdqd7CY1FHqVXogvaw9mYuB6pLlcmyV131wLSd2/LlZls5MkRW7lTkk1W9EMz2+OvjDn7ZlFtqF0ea/8d/omZmmkQhnVr8ucLD3ivKdLsC8feJo2gaj0p4+sXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385289; c=relaxed/simple;
	bh=0fxHmtzAUPO1l0AwP428vHiE1jIdrSRMVjS1tUi9cTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjul1E1+rsgi4ywycehycA6dvRZNcf2BNkLLZdhCiBu7NIlvumXdb/5ThArk16TIZVAFgGe7RnqhUcTEmjuXPQVUV6MevzrjjIyw2V4kpPD7SzGR72ozFoP6V2KAwB6l5UPElTMHoR8+Dftc3dP83JkUt9FIxNmD2jRkAFMVHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6Ll46oX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b9853e630so47251645e9.0;
        Mon, 08 Sep 2025 19:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757385286; x=1757990086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fxHmtzAUPO1l0AwP428vHiE1jIdrSRMVjS1tUi9cTM=;
        b=c6Ll46oXL49TxXJ2IGKx8qHofTy1R4bOhuHdSpEzMc7W01d1vjtXNuVkq8Zu1zvf5s
         09FkdvaxRbflsQ0ZzZxnDoCC35kFn3xr9hlUD7Ye7ijjWhPpExUbhjxlMwqoYhNx61B8
         /lstWg4Fbc58Hmcvc7OWjkjXZrIS5hnnGwVAVMQV8YsjqPSAFYZh/2n8vofavAeilI6O
         4cxdv3XWKezH9NFGk9kh9cAsJeuRdg9QloKnyPH7NLn+RZd3Puav+H1K1kkouCV28flJ
         CN+R6ZC4h5HLlDUK1pD79spZJSYE0D4GeeB0V/ipErsiMp266eQun+yC+mq4ZwaB/Kwq
         Q5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757385286; x=1757990086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fxHmtzAUPO1l0AwP428vHiE1jIdrSRMVjS1tUi9cTM=;
        b=NJ7uyoVWAa1YBZ+ig7UiNZQ6KwpRQhg0clk0+IHTlF8yyFxxpeaMRQsCW6lfEBZ3Vq
         Qc2colMi3jrQ0XqwdAjSBd66UZDjDOqiKMMBRqqH5WfGmJ2yvKW+8cP0SeHR9HZPT6/z
         9IX/WYAwDwmGu8HirMxmu3IGzR95Xh+8hOY6nl5HgZ5L5VSrcq2Pm4YGd0nm24lG3pGC
         pIj+Vee9jVWfFxKrQYhW/JSHx3rdo14uqbWn+hhlnXVO1QNunjxhQZHaHphyKsFgRobY
         c2riczhMGAlloEY5JlCr9SO3/FH0S4jPIt3ZtngxOyHLv4F9AfX/RridcnlK4P+piJ2c
         NYZg==
X-Forwarded-Encrypted: i=1; AJvYcCUoy5LQeA5/VFz+rELVUAsTgpcLMsJaKtUtzqukgJiMKgpG1iynIlK0YC2nwDGVLutSpthG2S9sE/MQRZ7k4A/R@vger.kernel.org, AJvYcCWIebQUBu28x4f/4sGgNk6jelw5YaSfVNIatL0HXNUoUJAGN5V0fNYw+AjrXscfLBP18y7Lb7GbPCkogWfK@vger.kernel.org, AJvYcCWuePFBh8s5jzq06lhrDWJUcD4yiSqkxHy3TGtF2l/1utxonz1JLWfYqVvX7vRHRVGmMxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8bKBWW+yIaaJJp5Fn0TKMSwzQO1sLMaiJRWQQ4PNzNVXUgqv
	B+M8eJhz1RJwFUxccs9r6Xn/mBao1TsGl6Dle8qIoGYgTReClgdxAy9HboP7FEF8DjXUC+rrAhw
	/1sm08qnj7SzrT5UHJaMlbHEOnsRTFNU=
X-Gm-Gg: ASbGnctzbN3ZXf5UiXdAdKJ+QUGdxjhqqPCGjugOcOeEBQQM5YjGYI8mopm83vXXhWd
	FbxghM1P6UgAOW+6MONKc//naeRMMeD2nBCQWzYhilEzf1UELZRuULn1O4MrTgcsO26qXo7FQl1
	AhMuRqAYHIym9kFm1z1HyCmeFUv17c9cj778STkUMjjjJcJ8fQgBMovcTQlQ/eTBAnUyZBf/V3Y
	0g2iUNF6Lc6w0ciSL5Wpr8utN1cixm7lFEj
X-Google-Smtp-Source: AGHT+IHGzEjNQ78v7147fv8udPqX8mhUgZElxGvZm8XRQmhD/8kiorE11oS+t1rco3nVVQ4BFCP0G5RZCk0mTCwI1Qs=
X-Received: by 2002:a05:600c:4ed0:b0:45d:e28c:8741 with SMTP id
 5b1f17b1804b1-45de712289emr40954855e9.29.1757385286149; Mon, 08 Sep 2025
 19:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909023130.28325-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250909023130.28325-1-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 19:34:35 -0700
X-Gm-Features: AS18NWCCrBOMdOF4e5-We_dOqe-bHQ46YfHjAQlm0V4QqSX5SVf48lBh1lZ-6rg
Message-ID: <CAADnVQKDbNLwbAAreqdjA3eko9MHqCQCVmrghPttvJn=oaskzQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix incorrect array size calculation
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 7:31=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> Fix it by using ARRAY_SIZE.

Fix what ?
The commit log should be clear on its own and shouldn't require
people clicking through the links.

pw-bot: cr

