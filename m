Return-Path: <linux-kselftest+bounces-34171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC4ACBC1E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 22:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204321886B48
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 20:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9A1A9B52;
	Mon,  2 Jun 2025 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iylWw/Jx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278C1805A
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894572; cv=none; b=RvuCGRHMynSwPHuXiX0llbzNRX+DPT86N9Yn9d2+DXauzCODJHr0th1t2e2Va2CwrwNry70CDFujF9gzcD8tON4IJPu//ZR7sY1aH5/h6RdW2spmMjen/wJmxN+gYvhWYvUWFkyHNyeUtEqTyUYTSBXr984xzngU9X6iGhY0BYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894572; c=relaxed/simple;
	bh=O44jyZ1Kd5oy20AmMmw4W6ZFK/TJmZN764rJdr8yx4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4FyscxKkXgq/0bvSGMaKbqhlU5zWBAbedPQtmEqkt5AL6pBwuswy02E9Bgi9f3CLyPnlVx/4skqrkEGLWa5/ivdhbHnRJK3WJYsXF8VM5jwEdzuytx/g9PYLKuJWPrITJ2OtaFSXDFee7wjjfqdVsH5peWD09TtSbkGVSsRxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iylWw/Jx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7caeeef95d4so455080985a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748894570; x=1749499370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O44jyZ1Kd5oy20AmMmw4W6ZFK/TJmZN764rJdr8yx4I=;
        b=iylWw/JxxWujBMjFUrikA+1ZWIGEE0meR8bh8CWFU8HFvD8n398lEvox18579iQHd7
         mqWsIgHEJbnv+QquBgmvsiMqWjOfNDA0NTDtruHxAy9EUXeZQ+IQpO43sHgYXhWq+BS1
         2qCYtNzB4yZ1DcKxdc98PkAMtsymI8qUsh+uYLArSHIp1FUIrrBdx2/QKZiz6f6uXs6w
         tP6kiDcP+UynlE4wPW6bZqrifxlt26xh1J23szo6yIHQ+3O/RutyQ1T7XlgULOQulhAr
         gDR7jJmhhw8gWy7LcTKyJC+R2cQlocMvfxwiY0Uc1RfeeHsxEvEAt4LGt6Q/R6nSufve
         n4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748894570; x=1749499370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O44jyZ1Kd5oy20AmMmw4W6ZFK/TJmZN764rJdr8yx4I=;
        b=NwJVWZY9ecEgLx5BdVPLVJRrTb9FaxQK542ShOdQY77IlhLcC1M1SvaEHeowUKFXYV
         HYQKbCucJ3JqHgqSF6MVZaXy0fJoGK6UiudE/inJiEehGysgA7evWW1W+NiKs9WFHyRV
         Wb/m3QWTJf27gUCu0p5Q+L6mUFKVnehpJ0++ULWOY2+gNkCORDCMFWZBqRhZjm7UNamD
         oAdFaH+HecLROF7LuyMhYE91uPgZFeChNbEa7Ilm/fIO8B/scuBA1hn8uvD8QyMZ4jVO
         KVi8u5w9u6wbLU4OKGuTNXLXZ8nXsBmdhIQXFIHocJOgsxkYakjcCET4F8TK+TuECGsp
         y2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUhSjtjAappW769BkAI2y3glLscIuFjEqq6+N3MpYXvfD73zaTXsNONayDeWcGh5vOPM1FG1E9d1l8Hn9ct+a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1K2VE0H9LWQUD6vHvjZhuAmBwBRpDOlJv7o2yZ0Khx87a5bi
	0/1ClBogjD4igwK8PScvOpvcjOi0n0fznRQ/HlK4Gg5sY2JBskWN2v5U5MYLNTmvuZIWF32hqbX
	8/4D9i/e9t+h508a7ScV8foFMy1pDfSw6dIrG7HoG
X-Gm-Gg: ASbGncv96oZwzoE9tViQFTuxp14H4v7ETdAlfvkn2cJlJSXPCp0PHM4wRGNZiG/Nure
	clWJJvvE8kdJa+yOR4EPnhenhCTh+Aid6sxYlirzX02+bT07IgFSgNg8QNHh0kKV2zaBCAhbvnp
	KqJgKWWN4Z977nOv4BWTpUhPwMHdzSBrwDplnpARKUgqo=
X-Google-Smtp-Source: AGHT+IHgeqPf5EHr1jkfDZ0TWZsQVURsdNh9voMjdnoBkFzaz/mgj3xBAjN2lvxPZngxMNZ2zDqWAhRk0bMIaFAslVQ=
X-Received: by 2002:a05:620a:17a9:b0:7cf:749d:803e with SMTP id
 af79cd13be357-7d0a2034287mr2485082285a.51.1748894570064; Mon, 02 Jun 2025
 13:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531072031.2263491-1-blakejones@google.com> <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com>
In-Reply-To: <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Mon, 2 Jun 2025 13:02:37 -0700
X-Gm-Features: AX0GCFsfxApMIel-NOMbuG9RAZwUCpPsL1Wg6IssdJPcoBruecM6kKjr4-18sUg
Message-ID: <CAP_z_ChBf6tiBZuLYE8ZGOXLYPpbNtH3F54_yBmF59oWpZ_q5A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support for printing BTF character arrays as strings
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

Thanks for taking a look at this.

On Sat, May 31, 2025 at 11:20=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> Please split selftests vs main libbpf parts.
> [...]
> Please use normal kernel style comments.
> We're gradually getting away from networking style.
> [...]
> we allow up to 100 char per line.
> Don't split it that short.

I'll clean these up and send out a new patch set.

Blake

