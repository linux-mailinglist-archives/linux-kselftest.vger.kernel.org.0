Return-Path: <linux-kselftest+bounces-3252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D7832E03
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8B81C23AD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3613F55C06;
	Fri, 19 Jan 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnLuMoyk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DD1E89D;
	Fri, 19 Jan 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684786; cv=none; b=j/k5xCbVGFunFblfZZWwdGr6y5OxuvD5fTcg+FphXeJBhGsiR4z2Tx4vKiJuWS7Kc3PCMBt3QYpJ/4164UvL10zy6mt1RbqHGDGqFf4AunDfZxQFbMgfZvmJi4yBlHUMPJICOAiCWmXvShFbWZrC5OIU78+v/DW7JqKbX7NadwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684786; c=relaxed/simple;
	bh=bDhF8B6h1xrXw6H8tlXIPJgaraDfw0PAGv0Mm821Yjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOicQK5So3kFpgST0Eryu1+AC4qS/gYAD1BztGUDa5k13IGE70bvR2JFiI6svxPGvIGh0QFKzxKqO8V/+dqpY7r9dYoCIBuXUUtcaI1nwsf4Jefe2VwVS9e7Ll4YzwIJKpDlWvxEdXYjtVpKRJr4aWTF7Vy/rzuIBR8S6L4gnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnLuMoyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FF5C433C7;
	Fri, 19 Jan 2024 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705684785;
	bh=bDhF8B6h1xrXw6H8tlXIPJgaraDfw0PAGv0Mm821Yjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GnLuMoyk6ly5HfBq21se67MsvK/Q7e7JKHUOerIz5zh609pBTiTfkdbUA2z+79JuE
	 2jtGT5ofzalSuGd1cpmxrTKVErTR/NwKqmSPjadpk5aHZP7CeedhBLYBkWLoOeNp3u
	 fdejNEjOLSgU/ShNLSY0AFjDfFa2RIq4YkZythXdDFqHG8y9s5OKnyAv05xo+JOOTH
	 7XUvxznQh80eSCxo+NdTPODJppFmy6Gy3P1Dz6xccWHF+eB0sLvOR3/4neVRlNWnVE
	 uNkcMMP6kEYuMjPGk10mktEJwLcmYkx9sJcRZxrvIFXEvEoOiqI4dZ8f4NGz3btAmJ
	 MRqc1PVl0q/tA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso1359085e87.1;
        Fri, 19 Jan 2024 09:19:44 -0800 (PST)
X-Gm-Message-State: AOJu0YyHhTXkCOoJtq2iEfzSHHi5EuubrwHL78kkUetCNPahaf46JlWq
	SIFaqglGQBVAMbOX3lu8gfNWBuQefRPjjE5raCvtvMDD7xKbXzo/tWeTAmULcS+wdyZDN4Ff/aa
	e5Um1uJe6cCQeGVnO25U33c7iCnk=
X-Google-Smtp-Source: AGHT+IF/kpB1TaQevR2J9zhea3m456h09vYKNyWY0eT4qO/Q8ILY8mDyHpusW8aOWGt2IG4Oazq2koAmDOD7teUb9fk=
X-Received: by 2002:a05:6512:401c:b0:50e:246d:7566 with SMTP id
 br28-20020a056512401c00b0050e246d7566mr7313lfb.7.1705684783008; Fri, 19 Jan
 2024 09:19:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119001352.9396-1-khuey@kylehuey.com> <20240119001352.9396-5-khuey@kylehuey.com>
In-Reply-To: <20240119001352.9396-5-khuey@kylehuey.com>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 09:19:31 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7Qr_sDDDR_PLZsLKHFM+KHScwonKVvprTWVbK=dEZJ4A@mail.gmail.com>
Message-ID: <CAPhsuW7Qr_sDDDR_PLZsLKHFM+KHScwonKVvprTWVbK=dEZJ4A@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 4:14=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>

Acked-by: Song Liu <song@kernel.org>

with a couple nitpicks below.

[...]
> +int sigio_count, sigtrap_count;
> +
> +static void handle_sigio(int sig __always_unused)
> +{
> +       ++sigio_count;
> +}
> +
> +static void handle_sigtrap(int signum __always_unused,
> +                          siginfo_t *info,
> +                          void *ucontext __always_unused)
> +{
> +       ASSERT_EQ(info->si_code, TRAP_PERF, "wrong si_code");

nit: I would just call it "si_code", not "wrong si_code".

> +       ++sigtrap_count;
> +}
[...]
> +       if (!ASSERT_OK(sigaction(SIGTRAP, &action, &previous_sigtrap), "s=
igaction"))
> +               return;
> +
> +       previous_sigio =3D signal(SIGIO, handle_sigio);
> +       if (!ASSERT_NEQ(previous_sigio, SIG_ERR, "signal"))
> +               goto cleanup;

nit: If we goto cleanup here, we will do

       signal(SIGIO, SIG_ERR);

This is a no-op, so it is not a real issue. But it is not very clean.

[...]

