Return-Path: <linux-kselftest+bounces-11708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DAD904629
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F4328936B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 21:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BED1527A2;
	Tue, 11 Jun 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib6h9oNC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F038DC8;
	Tue, 11 Jun 2024 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140391; cv=none; b=EoDofWuOa9Ss0qSISfl3ApStaMoGLtTgHGse2imqDrDJlY1E2CGjIOl+yqRfuBAB/YVuTAIX8qJQXGjsPkZWID2iTWJD/Jtr/vBATZ1xnY797wvBgpttKGJyGP+9fWYqRclDO2mq2zehDKMsfVSdq/uXUoxO/mUpdc5RfRea5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140391; c=relaxed/simple;
	bh=yzaX4uUtwLMdt/2B3JOlhXVOm2Xd4pFVjUQA1uSZ9Bc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qsshHaWSHZRj4fkdCuNIKVdhhurFSzF+1r/ffX8O0YsRHh+pUDrQV+uSNA8jrLILAPqWA7/IYEGovRLnqgKBKyoqErdohgKouq3+5XUyV9EsXaZ7kb6OPfBPKjpJ0xsPMUEnhPyiS+J07QA60rWUa7GsxRhxJ6MZMKnXOTpaMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib6h9oNC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-705959a2dfbso258180b3a.1;
        Tue, 11 Jun 2024 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718140389; x=1718745189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yzaX4uUtwLMdt/2B3JOlhXVOm2Xd4pFVjUQA1uSZ9Bc=;
        b=Ib6h9oNCe52DRxrmxf3N5EbeSFhZWIrktzI7EcpY8BRZcVM+I9CX3QAd0wWIFXOWLX
         jrpAzrPJKHLfeHCrj0i/kV6dBOiZbeXbBeacsx/lwo9ex3fJOIt/jIF5BRHPgWoPEVx5
         9/ZcfwOv8mJVFkeoDUhwGsv1E+7aJPB7tp8zWj4eGugz7JE7TFZGQFp5ygBfePBVFF8F
         Ah40R3x3M4fLNp/L4lngB5SGGK8VENZ2TyKfFIrwDf5Rv9XGzwhZUoJaPRE3ShQT5bfU
         GH/MUXB0AnOeF4+Mk39p7CVOrM/hH2RZqedT7a1VCW52Ml9djql6UJqJb3PYK1WvgrSI
         bGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140389; x=1718745189;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzaX4uUtwLMdt/2B3JOlhXVOm2Xd4pFVjUQA1uSZ9Bc=;
        b=AHfkDJiHNXPtXrZcdlaHmIHA+rtH8bctuzEZs14YYTA/I3L3nU5mpAM+fwDrcacDDo
         gZmCp8bnrBbBLlac2ft4ZE/m/bSr5TWsWaZLJJZRYPEDJTEAeMHzD8kz0jG7BE0kfu8h
         oJIeqO+S+9ZP30an16aK0y2f47Fkz8DNfJ/I1nqRFQ06xfZHh93HIJu6eETN4D84h4AX
         Wrm/Vl1yvXG2L0crLesDLYVsYry+WOSIilIOVfRX8j78MzekiRKzt4PIPVN7JNXLAbFs
         PlScbvOW2kssmyQiTWrnZwDAkKQKAnF6q8NqYH7+Bxk/mAM0XY1/LEMHB4PD7Z/VIKbU
         yqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvzQRUEQRXbkaBifA7I1p4ieCgbOFYii6NIO3p3nxZOmKmMKYBYP510jr3WQGl+dBy/drJ6bILjeahPXaP3Eb2uwC06MlGpQIg4X4DaN1GIryN/DAS73yL6yj8b4xNxYrfx3F6
X-Gm-Message-State: AOJu0Ywgs9IaQq7c9RLfm1lKCK59GTX3qRKzwo0ZGYGMayPJc3gnO/EZ
	0d2KvRO8v/0ogpedB6ARtGodmniLhmw4Z/l92Ye1Zc63WBQMzrfV
X-Google-Smtp-Source: AGHT+IHIQWloj2Or4EuXhFAzLSfwwofkCdxs5x+3o+jYgZELPqFQFZd1mCUJDy71MJlO7iSNpQsUrQ==
X-Received: by 2002:a05:6a00:4b10:b0:702:5514:4cb8 with SMTP id d2e1a72fcca58-705a846ac60mr5868323b3a.4.1718140388562;
        Tue, 11 Jun 2024 14:13:08 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7042ee09f0csm5569010b3a.137.2024.06.11.14.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:13:08 -0700 (PDT)
Message-ID: <656bebaca6d5efa8d3e8f3ac185a9f2c3cc56d3c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Use start_server_str in
 test_tcp_check_syncookie_user
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Tue, 11 Jun 2024 14:13:03 -0700
In-Reply-To: <39358e8cb8b91db5587d6e5ce735d12279981732.1718070940.git.tanggeliang@kylinos.cn>
References: <cover.1718070939.git.tanggeliang@kylinos.cn>
	 <39358e8cb8b91db5587d6e5ce735d12279981732.1718070940.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-11 at 09:59 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> Since start_server_str() is added now, it can be used in script
> test_tcp_check_syncookie_user.c instead of start_server_addr() to
> simplify the code.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

