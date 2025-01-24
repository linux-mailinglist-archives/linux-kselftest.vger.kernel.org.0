Return-Path: <linux-kselftest+bounces-25129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3267A1BC21
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 19:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0A63A460A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B821D47AD;
	Fri, 24 Jan 2025 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4OTjHXs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466823B0;
	Fri, 24 Jan 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737743494; cv=none; b=WrRxeiydclulGzusKawjRntifXifb8oPUFapf8vjEvnvMJ7AVrJU/xDberuqbejn9kOTeUs05zl4igHPgzbQRmFQzFnkAxPJ2r/Vh6Zb+oIaJqPyg0OKjuCl5B3ba5O6t4Aa2y51vioUtd2CpgAlRpPdo7gSfCgyg2xgYPKJL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737743494; c=relaxed/simple;
	bh=Xhd2chL5fbwbn2nVRtvBTP0qnjNpT1z9WdnNQ7RhsTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOJFeBEF74qeHS3RkZuu4O5rPYbb8EsFMC36X8TjQ/tgtDO9g9tsbTTwXp8yye7o1A653WdDDIehiOCLgL5giCRfvTuui8MwpskVNqecwwgxiNWb02T1gx6ugfFTSbv+lMJofVFOPrjN/ffJ9IsDxp3GtE1kAhwwleGWyjydVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4OTjHXs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so3448280a91.3;
        Fri, 24 Jan 2025 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737743491; x=1738348291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkopywtFASn0dgkA+AJtTrdq6ySJ5zqGOQUM9hDbqMU=;
        b=E4OTjHXsyAOKUwgjo2P0e5dIeoWqvazRZYA9zTf8ZL8GpccB/NVyG1jJoorFlMmuxp
         fBOhkzqyDJMdzmqrBsGBioJ/rX4D9rmvlBH0mTo6hqK31l8q/YlI37KGARtBmIu1ujz+
         wbJ7RC7USdza7SeLFRcqY470O4HESa7jZQx5cDUbBMT/+9mKvYfHrhv6/uhOnx1kV5nR
         DbYqL3me0kdKNR9gp/xyuZUi1pzJ7uHFruioGezmGB3YxS5Kzj6uk+IOAPp905BLVdXD
         +hDi1WuHg1dHAt9J1jnBa/ena7bD3yxJ8U+kwTS+mxbfoUXSixyP14Qp7mVINqaHpjb8
         7qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737743491; x=1738348291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkopywtFASn0dgkA+AJtTrdq6ySJ5zqGOQUM9hDbqMU=;
        b=wZ8X9F7SdhM0U/2VGPAITSZvYpotGxfhofod/7xsggGDZPjq2Y9jXgCBKMoo5w25R2
         3KBx+QREWn1eeFTdJUWuaJIMCksO8YTw2CUKiKpgNg7RkL9yQrS5FHkoMb0NBaRSfU4d
         YcNjGZlg3zX3mPLJlU6erv7Gqvj9MP/nMLqT2EPdVFLEygySiuMJ4/K5IYBpKUhvZGE8
         WSWKdwCPweus7/4yMGmQYVrHhJwdKvDU4WBoz+zTQioHwM7M65ga2smhIpW3ELbydeks
         kL6lEkR3BI6KHOhFpFdqieXFQdoAnJwy1yywrfyg0+u438HnsdOFttItcc3SOVB8hxkd
         jG9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhp+wG7Af2xTd9Nz0tt4MO43p4HDTa7HIRhLCzUTljz11wMLGrEJmsUBy4255lG3p2aAf87oVzsfbpk4TWgUt3@vger.kernel.org, AJvYcCWZAzBzKGWfQ//1tiEg9u1IF11kdv1MG8gEbMFC13sTqW50A0sK7DfiAvvo+9xDYSWqxKU=@vger.kernel.org, AJvYcCXKDMJAG+dIdiz+CUD7j2NJMZMMZpz1dbBam1XOh1BPhrL5DUD+7XElg6Rvvxt6Jcta0PcfpLIDAqoQdqza@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/pnMXD4U5tcLKIhiatZ5zlF5+6vibk+WKJv8JMoQvpqPTAbc0
	SzT8qM9O4NsrqQC34M7GudH2uTGUZDaHpGl4NqBJ7+aB6FbFmlWDYB7zL72i7QQ5zBklO0OjmV0
	ov1RCFahkmersc3Hx3kUJ0oK5Zhc=
X-Gm-Gg: ASbGnctiByXFQAd/NlaFFjR3QsFp4j6CSevUL2ko0NT9eLNnEdEyI4YD3UK6Z1McXR2
	n8LlS4okSjXW4aLhoU/TLXY5TR0xeWMJriV16YVE20hMaZpBHve4ujUelUWtPvbBZ2Bah9L8DZE
	RUvg==
X-Google-Smtp-Source: AGHT+IESQLfX+3uuqhMYNPcIVlmq/QCog2yND8CTK/F8ac4W3nXMAF+kaC1hTtJs4Z1fadd3AbMIBWGgZ6nlRoXj8i0=
X-Received: by 2002:a05:6a00:2355:b0:726:41e:b314 with SMTP id
 d2e1a72fcca58-72dafb9dc87mr46764748b3a.19.1737743491324; Fri, 24 Jan 2025
 10:31:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215206.59859-1-slava.imameev@crowdstrike.com> <20250122215206.59859-2-slava.imameev@crowdstrike.com>
In-Reply-To: <20250122215206.59859-2-slava.imameev@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 10:31:19 -0800
X-Gm-Features: AWEUYZkXnPPfOmOwRekYu1RtAmZ0FufU8LpREVkXG5pJmJgYLJka5ZgqrQyxYAQ
Message-ID: <CAEf4Bzajxh4xvg-aCaBhLQdNOZdhwceYUD2UsCcWku4ZBca_Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and attaching
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.kelly@crowdstrike.com, 
	mark.fontana@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 1:53=E2=80=AFPM Slava Imameev
<slava.imameev@crowdstrike.com> wrote:
>
> BPF programs designated as dynamically loaded can be loaded and
> attached independently after the initial bpf_object loading and
> attaching.
>
> These programs can also be reloaded and reattached multiple times,
> enabling more flexible management of a resident BPF program set.
>
> A key motivation for this feature is to reduce load times for
> utilities that include hundreds of BPF programs. When the selection
> of a resident BPF program set cannot be determined at the time of
> bpf_object loading and attaching, all BPF programs would otherwise
> need to be marked as autoload, leading to unnecessary overhead.
> This patch addresses that inefficiency.

Can you elaborate on why it's impossible to determine which BPF
programs should be loaded before BPF object load step?

In general, I'm not too excited about these complications, it's
error-prone enough with just normal autoload (true/false) logic and
various interactions between different features. Adding the third "may
be loaded much later" state just doesn't seem worth the complexit.

Also, for subsequent submissions, please make sure you have [PATCH
bpf-next] subject prefix.

>
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c                        | 144 +++++++++++++++--
>  tools/lib/bpf/libbpf.h                        |   5 +-
>  tools/lib/bpf/libbpf.map                      |   2 +
>  .../selftests/bpf/prog_tests/dynamicload.c    | 145 ++++++++++++++++++
>  .../selftests/bpf/prog_tests/load_type.c      |  61 ++++++++
>  .../selftests/bpf/progs/test_dynamicload.c    |  31 ++++
>  .../selftests/bpf/progs/test_load_type.c      |   8 +

and let's keep selftests in a separate patch from kernel and/or libbpf chan=
ges

>  7 files changed, 385 insertions(+), 11 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c
>

[...]

