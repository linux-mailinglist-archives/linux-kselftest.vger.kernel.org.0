Return-Path: <linux-kselftest+bounces-47221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 013AECA9D64
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 02:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46998305E34E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 01:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B894C224B1E;
	Sat,  6 Dec 2025 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCD3+72Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320C1A256E
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764983784; cv=none; b=NPyNsgDzyRNETRFmd+crMStEBSXvV8YzgCZYxnRsF23E1NwatyYbAcDvOH+GTxSXIAAxyElBzw4DhntvbK3r+q3yzZxATT8xLWZ7fg/ESrpEK0aU2YJ1odtNCjKAt4la/nG6laWXJ2ouJoSdLHOICR5/Yx9dYNdPZt000OOq9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764983784; c=relaxed/simple;
	bh=+1BXBfgTAhDwnQpVoGX6h7juepg+x3TpJFsh1l+r16A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0DOSwCTfTJ/EMy4gq75OVDQxV7bvI1v52QdOxKxMv7j+ojMwYoBTazwzRT4jRaVydJoFdhQeoLejIQF6APPsoGjzw8okIfzSA1Wedw4bXHSzWHl4KinNoYAlOV6d5/zyN7NeSmZUNkuon7HbXUN0lsHX7uwa5Xnh5VinPEiN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCD3+72Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A87C2BC86
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 01:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764983784;
	bh=+1BXBfgTAhDwnQpVoGX6h7juepg+x3TpJFsh1l+r16A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RCD3+72Zu4PDRnFlOyRLlBk3xRjtrh0wIsfQO2Sp8WO09y0ApxiT4P8c0Qq1lFHU0
	 YoiPxbtsAWNUtdTKZ8AWw0/P3iHOvLfqHF4hoh6WOgWpAkhFaOCRG+96//WIq3INlC
	 RFjfZoi7OsYRXiRcvyjqpkAL7nCAKGoej4o2b2Wu2ROqQYPFgaS0EwgNtU6Xx+WjH8
	 3/+Y9TqQaURGLWtxyTDPnl3+KVFjjcMc05mkmWg0tCKKL1Fq8lqA106nx40HV1Otxz
	 /OEKqBcB58UHfu4OnyNVk5sZH2+9BzzlsuwAuu0QNhiiwz18r4HXV65R3KcezL8Roz
	 vLwZ9Oe/MOYBA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78a76afeff6so37021177b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 17:16:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMqW+Sg41+sYnlRYirR71faLSr7ZBPT0nDQKs0jPk+rN1DsY5MOgs3E/yk6Pdz+f3aCMlFjhUFT7pKUDm0+YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeYxB6FBdxIUL4LpAmc7xeDfNc+FP0jnE7qdfKm4HowNklby0
	N1/0x/jFFXvQlBvrO0W8P7KZ/NvGfDjtF85hPfTRkV4UKJnur3nknE+zS4RRKyHGbrlYxTEMrx/
	sCzI8QwVaZEJMn9X6TNMQLlzdDh4NMwE=
X-Google-Smtp-Source: AGHT+IEKLBqq9Qt3Xeav9BIf4AmvNfkTBuygtKiIvRNv9/Db2MTeROqL7E9WgElOm1dHirm+FXzG9gljQnK8HYkOW9U=
X-Received: by 2002:a05:690c:360b:b0:78c:282a:1f8 with SMTP id
 00721157ae682-78c33b904c4mr10405707b3.28.1764983783681; Fri, 05 Dec 2025
 17:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205173923.31740-1-git@danielhodges.dev> <20251205173923.31740-6-git@danielhodges.dev>
In-Reply-To: <20251205173923.31740-6-git@danielhodges.dev>
From: Song Liu <song@kernel.org>
Date: Fri, 5 Dec 2025 17:16:12 -0800
X-Gmail-Original-Message-ID: <CAHzjS_vP=9ghBKvUv80b9zyKHRG6S=A7e0UNsagX+7C2CUhgXw@mail.gmail.com>
X-Gm-Features: AWmQ_bli7iU7fCMpC5zCVKRqk1DTXe4YdoaaF3IhiyhkzigOLgfxWmFsyAU1jA8
Message-ID: <CAHzjS_vP=9ghBKvUv80b9zyKHRG6S=A7e0UNsagX+7C2CUhgXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Add tests for ECDSA
 signature verification kfuncs
To: Daniel Hodges <git@danielhodges.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	vadim.fedorenko@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, shuah@kernel.org, 
	bpf@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 9:40=E2=80=AFAM Daniel Hodges <git@danielhodges.dev>=
 wrote:
>
> Add selftests to validate the ECDSA signature verification kfuncs
> introduced in the BPF crypto subsystem. The tests verify both valid
> signature acceptance and invalid signature rejection using the
> context-based ECDSA API.
>
> The tests use RFC 6979 test vectors for NIST P-256 (secp256r1) with
> well-known valid signatures. The algorithm "p1363(ecdsa-nist-p256)"
> is used to handle standard r||s signature format.
>
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  .../selftests/bpf/prog_tests/ecdsa_verify.c   |  74 ++++++++
>  .../selftests/bpf/progs/ecdsa_verify.c        | 159 ++++++++++++++++++

I think we should also add CONFIG_CRYPTO_ECDSA to
selftests/bpf/config?

Thanks,
Song

