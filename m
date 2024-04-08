Return-Path: <linux-kselftest+bounces-7435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE98989CDDF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 23:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4716C1F228C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0B0148836;
	Mon,  8 Apr 2024 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C14b7fHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B967E8;
	Mon,  8 Apr 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613358; cv=none; b=SpE4zYIC2jQjesju8NMR0REVbscWkTFp8POPE7wpoUeoQmzfNs9ZXVJAiRV1pxRqOURRdpywftBX7JhpyhmsHeYkORZPWD0EPiFiVhjDS3roVsibDHKqWEkCWjocoCiJINWnCtqvmc3johA9IYck4GFoPlNT3qabnT+T88nKHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613358; c=relaxed/simple;
	bh=q4GxNzePdy6HcJ/G3VBCqdFL3eQrX9vrFENM+WPga8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWrdTSYoxC1l/Jj7aG7YXHZAVw5/1w8/RZDmu0OASshQRCrSeOmPfoUSlxwqFvQZvK5K5OhwF46tIA78Am/RV/KzBcwGQl0izS7abfVDi7jv+cGiY6umKu+m3bsRyma6yFtvKy87A2a9Ek2fVwEWHkA63f6CIAGk0SWnvvHCIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C14b7fHu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5171a529224so1745356e87.0;
        Mon, 08 Apr 2024 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712613355; x=1713218155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4GxNzePdy6HcJ/G3VBCqdFL3eQrX9vrFENM+WPga8A=;
        b=C14b7fHuAVPFYMudVaU85A6LVm5b+d6GjxsH6wUU8cPlQojxwHnVhnhn5lWZfziyob
         Xf+pb42VMbNNyPYFQW0e4xdPssSwB+nOgwsiBvvFUoOkEuu1f4FH46yxLA24NZAwWd8/
         aZc1t0vnHOFnG788fn1BYFTBLBQ5pfeVC+tVj8qGgDGvTDTAfyJZ/o8qzc9qrG6851LL
         pU9d/vI4lGpLeT/j6WZeHR9yk3pZsmJXKgqwJWzFIsXKsWBi3Od6O7vY8xWGpQYcRmTW
         UB+v0+Sa/p2yya7MZx6iyUU9LwmAldyfC8WAY/P/pKFKsm33/y0sknH9r6ltCGBd07sX
         pTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712613355; x=1713218155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4GxNzePdy6HcJ/G3VBCqdFL3eQrX9vrFENM+WPga8A=;
        b=qgeowhlZYbP3x67Joo5TmAhgYMFpgM+BXxA8PFEqsJ3frJvBJxtTUaUIpMzf7Jzdkh
         ke9l8BwUIApPWXK/io/ueM6M47/dkAJ5KMNkG5MQ003Wq93PYKplSG+2g+D/BJXl6YJd
         kSaKYN5gL+wudtrUUnK+mwMq5prhTNjznSyrBCg1blQmODJUmyz2xqFlWSm7BTY2jVrH
         gGM5+WKgACdacar5l79+8JvCVH1Z8+ZK1iveIRSEtz8eaRGO5tIp0+Ot/u6XGcRzbowz
         /GgFXFcGOdNbWy9z5t+2bDkOfUUQHfHNj4R3QOvb12z3Fs62Jjb7m4xbSczagWoB7+Lb
         u9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaelbmucaym1k0FQgd87hURRNfA+q/iMa8xTdLNmx6x2bzlAqdSc5VKuZtfh+RZMgCxnF6afVaeXP61OIvNxoJJQuFqX+3mViPBrk9+GeDH0ShwZeYQY/Qh9j3N/Y5hKV8UUWKLuKJzPA4T/x4
X-Gm-Message-State: AOJu0Yyau61DAfoONZzF4oDNmerB9jIAj5dB/Hzeu0xvHxTSyI4mNahr
	YfS7LnuoIRCTQCr8cGZuyDKikNW4qK/SFtGwfCBHbCnsVNxyJ4me
X-Google-Smtp-Source: AGHT+IHU0e3WR949Puzru+7SwM/GkoanitHTIA+lxpX80diL/Qkx32uXThGUcMzQ8I+8qakyXG/Ksg==
X-Received: by 2002:ac2:44cc:0:b0:516:d09b:cbd6 with SMTP id d12-20020ac244cc000000b00516d09bcbd6mr5750837lfm.15.1712613354820;
        Mon, 08 Apr 2024 14:55:54 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id nb16-20020a1709071c9000b00a51e6222200sm371602ejc.156.2024.04.08.14.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:55:54 -0700 (PDT)
Message-ID: <f80abccc03a9695ab54aaa4841700a069e923c68.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 2/6] bpf: Add support for
 KF_ARG_PTR_TO_TIMER
From: Eduard Zingerman <eddyz87@gmail.com>
To: bentiss@kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 09 Apr 2024 00:55:52 +0300
In-Reply-To: <20240408-hid-bpf-sleepable-v6-2-0499ddd91b94@kernel.org>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
	 <20240408-hid-bpf-sleepable-v6-2-0499ddd91b94@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 10:09 +0200, bentiss@kernel.org wrote:
> From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>=20
> Introduce support for KF_ARG_PTR_TO_TIMER. The kfuncs will use bpf_timer
> as argument and that will be recognized as timer argument by verifier.
> bpf_timer_kern casting can happen inside kfunc, but using bpf_timer in
> argument makes life easier for users who work with non-kern type in BPF
> progs.
>=20
> Fix up process_timer_func's meta argument usage (ignore if NULL) so that
> we can share the same checks for helpers and kfuncs. meta argument is
> only needed to ensure bpf_timer_init's timer and map arguments are
> coming from the same map (map_uid logic is necessary for correct
> inner-map handling).
>=20
> No such concerns will be necessary for kfuncs as timer initialization
> happens using helpers, hence pass NULL to process_timer_func from kfunc
> argument handling code to ignore it.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>=20
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

