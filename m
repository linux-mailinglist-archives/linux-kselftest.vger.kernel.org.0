Return-Path: <linux-kselftest+bounces-40715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA73B42DA7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 01:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2050C177C9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730192FC01B;
	Wed,  3 Sep 2025 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TppK43Dv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9082FC00C;
	Wed,  3 Sep 2025 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943419; cv=none; b=GPmIJYkR3s0eCVntc+2gv9T7XXpI7ej3aPO6ptQyxlXa5uOg4piiSRISC75jMEJrtImiI8yfw4XUW+J12bv4QMVvbl4/7Le7TQ36ulGIooolaE5lW/eCu5Jp37CNFATE+ZVzAts3hiPoXBBZp4nbMFbQ5BPdmNAhfZzw1xXxVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943419; c=relaxed/simple;
	bh=BqkLCnP3oR6UuS7FXhVR1ZvXxz/7DRQNIuUoOfipT44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as+mO+mMPIjGQDAJb6wfY5Z94YslXK6LpC5KtvTvfPXMZ0DzL3W5RUXjGUBxtfZdnivwSxujyC1K8vBhtN0mIV6sGxuGEwq4kCkAevf1ZjkCGWM8/DERmxNxT55SdKvKBEHGpsE/G9TC58bZ7WxNFBlFid+BeXfFDIB99sWeboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TppK43Dv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7724cacc32bso407996b3a.0;
        Wed, 03 Sep 2025 16:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756943415; x=1757548215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eOCiwclm9k9gMd8SjgNITsnepC3MetxeXscE2+ZlhA=;
        b=TppK43DvH4MtqYM5788M8Kt/9pHLBDT05bD4YLqnIpDMJAmDFxSQ3I+OZbBToQB4Wi
         fJoEF/Su8qAsWqO/2A/0qOADjNxUB/J1zjNRPxkBv8PlMUQgE1whwE9eV261HOXUsS7s
         bAviOwFj+R2mdBVwCYvH27nD/Kj8OCAUEgAcIOTOh/v5FloqyPMQhLEZRoFl8TEX8bFS
         BiNn15atbIiEJ841AERLsjDZQ2w63Aiab+0XRmjWPzKZ5qm0kBWjxeH0lB1ssHQAsbGl
         xiIe9pHAhKvKA+IaRFkELlB72NDueECorNwQ55iMo+W50LS3jNF4JQL0fuyGgIDyEn3D
         LpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756943415; x=1757548215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eOCiwclm9k9gMd8SjgNITsnepC3MetxeXscE2+ZlhA=;
        b=bN/N0iTf0pClx7XXRe8/NrAJh62WutyxrERZb17KPmpepcnvf6iuDAscWxrY/NEqoX
         6wvBecyxPbCBywtSxQEqjwjR1oof7s/Q2veBdnfNHaK8xAzQIOYD/g/AKpEoXk7UW/yk
         3R1A088OlAK1F9IzBhGEBH3bXIXll+9+9BjiJ6fP2Eyl2/R8bTuDeXKlzn77HQwcLpB3
         S9KbGJLMd/K7P2fvyea1CkY67YfF0J5OWyKWtNl0SkJN3N+ioWnDHhigpNMIWRqR1y1F
         jDB6DrymcUnMK0jKvQL2Fm4ArQ2BqoDgR6BSf16uzZhfKLH0/aOq5mNPxt6L0/Jua1IZ
         8eOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf7fFkVx0+4v5UNm9yUj5PTrzV3q9Lzpc7TFhtL1qmVUN2VzlZ1sVfaS375Az5FDTDjxSqVi9BxogzQYVKybdU@vger.kernel.org, AJvYcCWQbUNubMa4+rJ3xfICztrxlO0MFaekP+8nl3sc/DIX+QPcr3i6rekWJ8p8Qn10kjK2+o/wqz0nlusoGkpI@vger.kernel.org, AJvYcCWaMkqkjloPJyuo0c70+I/tm0B/Qx2+MuJ2acuPO/jMFxm383YJnW/JpOft4GGKmKBkKtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7cDcb2lYllNrvz9bM9xa9juyKh/Wk8YDeT+yxL89DZPJ9RYh
	NFn1F9H0wyF3++FPL+AgXa1Rf2+2S9LCQWydFp7krT3WdwKEOC+7cTw+qk+ZzB0BVwXTBxkZsr6
	rIubbo8WHg32qqpVX7sVi1o+PK/t5EYw=
X-Gm-Gg: ASbGncsKAJoZR8I7D45H3M4VSl4syMovtyhHmZAx2oXz1aQ0+aYE3pRC0GUSPmb23Ps
	bivxbb1rR3LMCrVD9AZHjidi0955H2KVQJzTSADF8h0vlzeKN6sftZZ4OAJ2XmOWRQKXzMfvEAI
	/wliDARQIKDVe7rKftQFp01D3IYqcG7n2sT9Vr8hztV0jEC+Hqm8NWMbnYWKnfjs7DOivUFyRkF
	RWU0Odbz5EI2j67gcvk8cw=
X-Google-Smtp-Source: AGHT+IEbvD30j5zQqt7UwIVsxOfkapLt99TiC2+GXC139JaN4tqHx3/ZpTFskOrD/zA4xj3hXn9Q0Z+H7N/iEhZs1ss=
X-Received: by 2002:a17:902:cf08:b0:249:2d84:f406 with SMTP id
 d9443c01a7336-24944870965mr254374065ad.3.1756943414969; Wed, 03 Sep 2025
 16:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901034252.26121-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250901034252.26121-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Sep 2025 16:50:00 -0700
X-Gm-Features: Ac12FXy_S7ElHWHvyy3ZkXbr4arXUIIENhZqC8u6zhUCjSyx8ViFHMQrJkbrzRg
Message-ID: <CAEf4BzZVTr26Uogf8uh=7HmgG6Qo_uVy3fX8bQgC+Xs63wZcCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] selftests/bpf: benchmark all symbols for kprobe-multi
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com, mykolal@fb.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	yikai.lin@vivo.com, memxor@gmail.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 8:43=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add the benchmark testcase "kprobe-multi-all", which will hook all the
> kernel functions during the testing.
>
> This series is separated out from [1].
>
> Changes since V2:
> * add some comment to attach_ksyms_all, which notes that don't run the
>   testing on a debug kernel
>
> Changes since V1:
> * introduce trace_blacklist instead of copy-pasting strcmp in the 2nd
>   patch
> * use fprintf() instead of printf() in 3rd patch
>
> Link: https://lore.kernel.org/bpf/20250817024607.296117-1-dongml2@chinate=
lecom.cn/ [1]
> Menglong Dong (3):
>   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
>   selftests/bpf: skip recursive functions for kprobe_multi
>   selftests/bpf: add benchmark testing for kprobe-multi-all
>

this doesn't apply cleanly over bpf-next, can you please rebase and
resend to let CI run?

>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../selftests/bpf/benchs/bench_trigger.c      |  61 +++++
>  .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
>  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +---------------
>  .../selftests/bpf/progs/trigger_bench.c       |  12 +
>  tools/testing/selftests/bpf/trace_helpers.c   | 234 ++++++++++++++++++
>  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
>  7 files changed, 319 insertions(+), 219 deletions(-)
>
> --
> 2.51.0
>

