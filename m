Return-Path: <linux-kselftest+bounces-31801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B39A9F847
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C87460948
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130C2957AB;
	Mon, 28 Apr 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8A1tUd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BD26AF6;
	Mon, 28 Apr 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864200; cv=none; b=LIX+TFR0OPRaYL1hKpoHY47o+WoXALpy0tXHCQ3DtvjNxTW6SwF4q2IucRNfaZCI0A7UHUUALU9NNQhuVFcswtf8RDQ5er29o1BQta3SSOo/mqc9k/0ytYsMRT61MaWBxMYBfCXTLnoEnjyDObG9VYYAUTEr1KxtiLPjDg9Bw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864200; c=relaxed/simple;
	bh=LTWucmA5QArXmJiKqCaHcfaGujpFrEweYB221Xdig9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFpZOle2oB2PWNG47faRFQ3XErERPpYB1XXuVGDfuziGn1t6zSE/fwr7u3rcu33eo4xMngkQZ7DjG3E26QMpOY5pw1emInOmPZebdwrahxB3815/niZdXrR+z5aJ9aaDNW4JmbFXyaS0fQ9XSKov+nqf8g0AIt1a6D+StgNzl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8A1tUd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1E1C4CEEE;
	Mon, 28 Apr 2025 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864199;
	bh=LTWucmA5QArXmJiKqCaHcfaGujpFrEweYB221Xdig9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F8A1tUd6vekn0150oPD3r7iCDzXFxcxozbBlK4ubr2loaK8uSlCF5Wi6+2Kl+6Iu/
	 iVn5p4rA5qmomQD/OjD37QPMu5F8cFOFfXkAz+cXYbhsegS3Fc2qmHj8Uyuhl3BVHL
	 ggIz4YqfK7pfv4ZqEatUZzSEdYIXZDei/Vwp3bwRjDDxBMF63979359Ab29E66xeci
	 OJMf6nkI2An0BF4W0Wftaxx2KUeBkqjwiT2iIXOgIHmx7ejFMAcGIqOFwqAoaJjmtN
	 BJ548IUOVpGL2tStjxg/Yl0+IE0FnlrZQMqvC16ZeSw5Wig1mvY2Sok+bWUTpyoAnR
	 MIkBPIUSbGbiQ==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c559b3eb0bso305234885a.1;
        Mon, 28 Apr 2025 11:16:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3c60BGEyHG8DXAdA0WopyoSrwXUnkuFike1NbwmkkBvy1q7WRNsox0OciZD+lEK1+iVVhjJYKdhc9evm0@vger.kernel.org, AJvYcCVKdS72NMBZpJnTBWtoJYf8v932uroBR9b/H5n5wyqb5iv4U0iR6Fk1D5NgNl7JOiOUCUBIxOc4zCJpBCruYsm+@vger.kernel.org, AJvYcCVzSVKjYOMY1g50dtEK6Ysx0NzT2j89en79QcPHwxNNOzNMFJGRFDdLlff+U3KU71CSvsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGwFn5WqaSDgSy86yeTd6IRolEnKEiHAy7bnjSHmLaCKkD0ie
	xWaVbqAJM3nepzcpGyEXWotFu+GFVvPZMRwZaaoWIm+ejZhsESCm5fMt2PFsgTaASjzFPyScuKH
	xK7vszxvbMhFJqv73MJZJZi5/oes=
X-Google-Smtp-Source: AGHT+IEG76nmyhkuJhZJM1YlhssBhIEISbVFYcNrAKVYzp5llD/EZQUCazNjmvrM0m4H32FVhUnXAkWHvufEX6CwBsE=
X-Received: by 2002:a05:620a:4590:b0:7c0:9f12:2b7e with SMTP id
 af79cd13be357-7cabdd6f780mr104404385a.11.1745864198561; Mon, 28 Apr 2025
 11:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428180256.1482899-1-tjmercier@google.com>
In-Reply-To: <20250428180256.1482899-1-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Mon, 28 Apr 2025 11:16:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5m32t2-7f6EH+A35-htHcL-kQToJ=_Z2BEBe8dK9xyOg@mail.gmail.com>
X-Gm-Features: ATxdqUEfqMGxBKalVPnccR6NYIdAiyLCB71Tw9QjYzbC0c75PUlTpGO5qpjNSRM
Message-ID: <CAPhsuW5m32t2-7f6EH+A35-htHcL-kQToJ=_Z2BEBe8dK9xyOg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix kmem_cache iterator draining
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:03=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> The closing parentheses around the read syscall is misplaced, causing
> single byte reads from the iterator instead of buf sized reads. While
> the end result is the same, many more read calls than necessary are
> performed.
>
> $ tools/testing/selftests/bpf/vmtest.sh  "./test_progs -t kmem_cache_iter=
"
> 145/1   kmem_cache_iter/check_task_struct:OK
> 145/2   kmem_cache_iter/check_slabinfo:OK
> 145/3   kmem_cache_iter/open_coded_iter:OK
> 145     kmem_cache_iter:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>
> Fixes: a496d0cdc84d ("selftests/bpf: Add a test for kmem_cache_iter")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Song Liu <song@kernel.org>

