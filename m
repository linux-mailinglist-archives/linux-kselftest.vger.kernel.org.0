Return-Path: <linux-kselftest+bounces-40017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26857B375A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E213AD675
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FCD2C0F7C;
	Tue, 26 Aug 2025 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzVw4Auq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638482AE90;
	Tue, 26 Aug 2025 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252205; cv=none; b=pd7jCoyKbL49J3FI5CdYGC25UzqxEZz3USrIrcGyZKt6NjngNZaUnDsqZ8ltiHS0cjUiCvyoOmNzKG6R20ZI3AcF0myRz5wsL9xz8s/CQxP73H6sRy5zvIztHaO7xbtG17gUjVcXSTLj9S3dDhJMYlcSKLhO/oGxC0MRpPuxWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252205; c=relaxed/simple;
	bh=yp0sPi7ensv+tk3ak4LFv+iFDvcNLyplFQW9UDpUncA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXPGKaYpitz8wxR3T9MQviXWY04MQcT3YIO8q4rAwUi/VwNWFzWqnWOtLUbBpaDCcjnml5GViVTebnrihGx+Cvcruia8RYWRIfxHoj758jmjw8bZKGDW4ywehsZBUCjRaP7MekMqZwaxPC8xdFXRNsT7uDBPVDWOeD8ApYeX1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzVw4Auq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so2404175e9.0;
        Tue, 26 Aug 2025 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756252202; x=1756857002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/4a8LhXaZFfcU7YpzkKktV2M/qUnbxvgob32Os+YRE=;
        b=bzVw4AuqXtDoOQbmYIBh0Jl4Xj3u3nZXaVICcLyIuYGqQxY0YSsIBtjRB+pBFyHYI7
         Ac2rd/k26O4o7CoNeYHvR43KtfwqqNWJj9sPYHAnNFpRu4WBQxdDrSOjv+ukIthzbZf5
         xufGdsivnKeS/noxhPOPtkCh7SYI95Dp9ZONC0UX9PSAkdqE98rg8OyY3JhwgXBu/mBx
         qnwrjHat5zIcWxxTdA60mCG/WMD51Gh3vnccVDUXqpHqDq3WIhmZqzY+KZ6KcbS/Dytc
         n4MdpIrV9AcisXpXzm7yQtm3G3e96AmUDqwq9qoBzaOsA8+uyvvN8o3AdYYKk4iWVfjj
         gH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756252202; x=1756857002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/4a8LhXaZFfcU7YpzkKktV2M/qUnbxvgob32Os+YRE=;
        b=EnlNBpAZD0UPPm1xEHhsw1xzZngMOF0JSP3T9kHohUG8x987QObqWsWvA8rG7X58j/
         Apc11YViydpzykHuO1byVUNCk1L0eHU8Qr0G5SyMBM2Y/N2/jKV0WDmU/H6pbqEa4IiP
         TsOuHvvmm3Es4HzkoC/DZkgcJVOymHTkgAUMD2dPcDdUaTOvPiV6fTk0FsBX2TFHMqBa
         967f1F7NGH1FBa/60qIyrIPQUiDNsDn4U67e8XBrmFcpPLT1qbO3keNOL5fqnje/68AF
         Z3+8cva4MPCza/sBHqzPfkiwc/112ZVlrjTVtWVTp7bjoKQtU5hHfykk6fUg/Nz2FKsX
         NefQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIp4XwIj0/XaBleQiRn2bR5spszxesG2lpoUbM5MsnVh0xfU2b3JFd0nG9Lfx3+rV1J98=@vger.kernel.org, AJvYcCUzil6GIspYYL+yOqceVs2wucFibNsQnIgIf/6innZ6GObY9O8dLhDbc9eNiKoOkaITxPhJdsw0V7wgc3TS@vger.kernel.org, AJvYcCX8Z6QkzP5UGDSICjIofW4282JOZIgq5R4c0C/sMPhcrRU3RTuDfRFO7DtOj8PvDW2mw9Ua5Hyl@vger.kernel.org, AJvYcCXgAznOR84GRkNq+b/DRIE9ouIl1E2681uZqpRjr+BwwjjDyzw2bG0FjdorjzEJapH/jQ/ppmEaJpSxq1Rba3gx@vger.kernel.org
X-Gm-Message-State: AOJu0YytObeAB2/RcMBpecdglSE61GRr+xxfhSx/QF6BN/cPVKTnoXga
	KRg/3qkAXSzhu0CFG9kKJFYykWhC3ppxfRvhEAsMgcSLwZYdLOOW0gByiFywHunminplJOEmpcc
	o0GSqHk5Qsn9f4F/ORawrAl/xb+6a5n0=
X-Gm-Gg: ASbGncuQ8sqIYOZZcCBAYQUyagZRhf3k0Gk5quqb+5YJhUouljcYAWbjtc5tC8N3zmm
	Y3yZJzM/5+Oo0YJyzuOxIogtfeU48hmnUKl56qa7kJF+yG7+QL0oBr0XV9mMiy35k2YDM5N2sNe
	spThwKgmsJ4PvWipcUdHR/IchCj1PhDkEyxbVEQp6D2YPicceMsPn9etSgOeveyYxks+oaHmOdb
	zmVOcOhlgY2CAEhp2MHZgBIBY9535+4mZIhHlCxTS4lwhc=
X-Google-Smtp-Source: AGHT+IGOef4BkFmgq9uqxMXYnUDjhEW8H9g/OL+f3GTmv1InuyS+566WxiHJhas/C0bhDuk4CyPbcBTUnih/0vHqLiY=
X-Received: by 2002:a05:600c:474e:b0:453:6c45:ce14 with SMTP id
 5b1f17b1804b1-45b6b045954mr13042075e9.4.1756252201513; Tue, 26 Aug 2025
 16:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826131158.171530-1-matt@readmodwrite.com>
In-Reply-To: <20250826131158.171530-1-matt@readmodwrite.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Aug 2025 16:49:50 -0700
X-Gm-Features: Ac12FXy2S8MJX84UFWWWSnzeF83x3Sm34xHiKgTplshGBttG4YFKeH0bi0meFek
Message-ID: <CAADnVQ+=bYcR6whXxEPst4a4n1eKeDXp4tO8Q2wEx_6GbwqMFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Add LPM trie microbenchmarks
To: Matt Fleming <matt@readmodwrite.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 6:12=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> +static int baseline(__u32 index, __u32 *unused)
> +{
> +       struct trie_key key;
> +       __s64 blackbox;
> +
> +       generate_key(&key);
> +       /* Avoid compiler optimizing out the modulo */
> +       barrier_var(blackbox);
> +       blackbox =3D READ_ONCE(key.data);

Overall looks good, but gcc-bpf found an actual issue.

pw-bot: cr

