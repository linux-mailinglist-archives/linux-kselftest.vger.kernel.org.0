Return-Path: <linux-kselftest+bounces-32207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF90AA77E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 18:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB199C46DB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A7E25DD04;
	Fri,  2 May 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="b2uYl6W7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45E2550CD
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205127; cv=none; b=TQvbXqE29TN6swnU3UQWCC+P7auYKpSk2/M/0H25z0b8mcFFLuIf4d+pw72bUkGYBeFGMWErA9VVQuY083BPZM04e5PrefU3J3hLr1I8Cyvv+TTWpLxGSgUQuY+dVOeWJez3OcmKUlwf2JRXTiWSSwNnnc38ReDIXnZ20jvAw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205127; c=relaxed/simple;
	bh=BFtyWDFTN1QrKrJxpIvshxuClJ86Y3W8VsyPYHB3IwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZAYSj7HUHMHhxRv56myQevXecMMLz4xVjc8n3a2+KZTL6TtLXMyuaT5SAQn8+NIPjxfYUiermEBmBqidZjdEtILAHBNmfca2KtMDiP9WrCw4tdzZ+avicJX1sMIsEPVo4O2UImwDsEHYJU6ET8O3SZMMNVnO++qQg/FMQrVVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=b2uYl6W7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acbb48bad09so396251166b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746205124; x=1746809924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFtyWDFTN1QrKrJxpIvshxuClJ86Y3W8VsyPYHB3IwI=;
        b=b2uYl6W7eFYGrTjdNg1rtqh9OLg+ISkK02p1V1I2mEuTlyEBdBBcPxowKQ+oIrRjvV
         /RUmsCP9UXf7Y9pzV+xNbZ0x5s7PkF8slonkToE3Deka4q9paMKiKj4Ky07nUrWonelT
         Gbz6uNfu3wWFRDlbACunWbFGOZW8U8QgjDuBLnnxpRGYO6FMWjLwq9VpfwDdZVyr+tEs
         SZC1po8AFWD5kvLf1Ig455BuL1EZ30bfrEsZq+0GQEnkkS3pSyfiMaJ76ycC/kPr+7N0
         XdQQrntEWqxSYQYckwxpxNrcvTtbsRNQbh0cv9M7oTZN6m/+kG5SbATapTOoqvwyxIRL
         HZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746205124; x=1746809924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFtyWDFTN1QrKrJxpIvshxuClJ86Y3W8VsyPYHB3IwI=;
        b=KciyDa7L+F0bfv/yqHw38ULX7u2XLlRA+0/Gj1X/Pm1qM4g9WLtdh9k4s7Ql2oXIQh
         PNfRny/qe7A+q++wybfy2/BInZsxVOve07zxmUzF4JJEAItRfIk4xTDU6KMT+itCjtt/
         vus27AS5JhayHFFWb0LAR7EZzf0BNBZeJbra/WF8SoYt6w/VEQqXpHuInqQ8cPKOAGuV
         Ck8XNSrfThVQEKtHQWR800o/YV46KXwRpTGRQhT1AgmKaVYgbMgXaGq7LHY/jU/7Kur4
         DeX/vd4VmcLnxBAhDFvzx9lJxOHgbbUfrBczNqGnXWaXWwMwCdTr4VBmk6RlmSEVXYcp
         msRg==
X-Forwarded-Encrypted: i=1; AJvYcCV86OMjvKsvhsr0sD7ED1FmWPxU8mpnFqcfuCyr7obLe+85vyBCrJq6wuA2NXsircvet+azcYnV5KilEHmvwOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlU3AaxnwEZQR6m7KKMzrkVSO7PJzlEem7OHH6i56SlAMPhGb/
	LzrXqoNJO3BZxINzE2y1khRnNWgzvDDrrk7k5kYyAcVVUsnq4FR1wbJJyoWZptjS1SxEgKQyYLv
	Y8cMXOwsTv6c2BlsauZt6fn4tLbT/ffZxkMfRc68Y8rpYW2KK
X-Gm-Gg: ASbGncthnkdLJW6Yt7j91kTLbhRETkvfiKaJN5KWGIOlGFepiiStrTJgbeHHc0MpOXj
	yS+uL8KxwaEzg531mCjdXGC7Fbsy+ixAEgvXIVSivAf3qJzlc4a5YoDK1AwiVLjWflpl9MuUPGm
	PL6FtArwN9n3p/8e/7VXFHjMH+fiNQS7eNYwY=
X-Google-Smtp-Source: AGHT+IFtImagR6Lqfgo7XIZ1wWl2+tLkZnQp/pTB1oR1k0UzDInmGHhqpcROEep6B+1QLhfQbASn6A2YAzPAFuoWbdA=
X-Received: by 2002:a05:6000:402b:b0:39c:e0e:b27a with SMTP id
 ffacd0b85a97d-3a099ad70dfmr2371455f8f.23.1746204815370; Fri, 02 May 2025
 09:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com> <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com>
In-Reply-To: <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 2 May 2025 17:53:24 +0100
X-Gm-Features: ATxdqUEmdXYDqO_tQ1hPoaj8fCjwznGA5fXIlAwLRODgYtT6LMxPzFPPx9AIs8I
Message-ID: <CAN+4W8i0CB+gYcBNyWUxAA+=89Q+nMFopxKUF3nt1+y5ATaNyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] btf: allow mmap of vmlinux btf
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 11:20=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> User space needs access to kernel BTF for many modern features of BPF.
> Right now each process needs to read the BTF blob either in pieces or
> as a whole. Allow mmaping the sysfs file so that processes can directly
> access the memory allocated for it in the kernel.

I just realised that there is also code which exposes module BTF via
sysfs, which my code currently doesn't handle. I'll send a v3.

