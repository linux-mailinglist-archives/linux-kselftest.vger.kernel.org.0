Return-Path: <linux-kselftest+bounces-1441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC35680AA2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 18:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D279B209FD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45138DE9;
	Fri,  8 Dec 2023 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="BjINJGv8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D791BD2
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Dec 2023 09:10:13 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1e7971db2aso262105366b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Dec 2023 09:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1702055411; x=1702660211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT2ERtTh7TDwFF0uUcvQZyrq9v2hGvyHlT8iTFDcKgw=;
        b=BjINJGv8Se2ZNM5dgM04aI3zaRiJt1oHH5Yo85O2Hy+QxkE3k0TcuACeNyqLHTNDv+
         rqOjn0pRhxpXCKfupNTgxM9hylKbdnZY4buXBnRjPK6m89G2WVyjAO7qA+HErV5SGDI+
         WT/A2YSF2DYnKhs4Qc1TbJ+XGIiWh8N3fIzrla0u/NiFZxAsgNs4KlRBfTCTx1B9Pp8u
         uUYyjud9MJmLolgDYRHjDqIUrdZi6LnlcsZfNqa+od+fYEQlFSBXqG+vuLOhgF+3BOoQ
         CeFCKexE7G+yD2Y5Z6vTjqHayxOgEv58NozqeThwyTzE+X/G/7WzuZOLTcxDdBpGC2Hl
         0Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702055411; x=1702660211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT2ERtTh7TDwFF0uUcvQZyrq9v2hGvyHlT8iTFDcKgw=;
        b=oT7Xy3O3xYugjlT+Vrr/ooxr8gy5VpXtHFd2kKABksX1HX1Zu7p3TlNo6fDjW7cKBc
         p/wZSeu6OITf+y3gZZqE44eSqaUCvtRnY2xn77/wgfKdELCP0ERuKdsChhwEIgx4Kq9N
         efJ0eUKBekZkfhVutaPOPyy97GSCpkIsU2JPrRdnI1yS6ZXmCVTl+iIEsQdbNpMi3jdQ
         kWecTuv3TrUHaGSltGbYvKjZG6usJI5DRaUaUXEiyVuAqqPHNGOF+AQL0nKNov5Hmohl
         HEtZ40zM4TF79tlG2LBojRH0R+caeCJF3knK7c3jFS2Rt+bIBgZi/3n5S27icUPT8SKj
         vwUw==
X-Gm-Message-State: AOJu0Yyjf5iwTEcNmvCExdXEhEifX0fUs0y8RJzECh6DKBxwVZkhnY2b
	IrrPPTJ2dLW9OpOKrQdpw+WUcPVnNu8Rpe+7oWq61g==
X-Google-Smtp-Source: AGHT+IHGvuTbhBrs1OTyitMrjad5wyb6Xlbd0k3C4Ub46dJTi1an7MU4lzJ7bUx8DWzxrGPZfWz9yBhELKwMZoI01To=
X-Received: by 2002:a17:907:741:b0:a1c:fba4:b9ab with SMTP id
 xc1-20020a170907074100b00a1cfba4b9abmr210269ejb.95.1702055411477; Fri, 08 Dec
 2023 09:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-4-khuey@kylehuey.com>
 <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
 <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com>
 <CAP045AoeVP=n5K+0jt2ddBspif7kx4hzOdBM86CuxNGRCgx4VA@mail.gmail.com>
 <CAP045ArdMgodyOTs_m6-99FxrqUJzRjDth8epkaa69YQtNeSMw@mail.gmail.com> <CANpmjNMehFp7dM7QhR7AQgp33i-a0s0R-J9ZPweyroY45eCizQ@mail.gmail.com>
In-Reply-To: <CANpmjNMehFp7dM7QhR7AQgp33i-a0s0R-J9ZPweyroY45eCizQ@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 8 Dec 2023 09:09:59 -0800
Message-ID: <CAP045AoFHiMjCkopXo8HQZTpNWz8fE2LBt+vPUgnvUpdR9STfQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To: Marco Elver <elver@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Kyle Huey <khuey@kylehuey.com>, 
	linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 12:07=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
> I think that's easy to fix by just defining TRAP_PERF yourself

Yeah that would work here.

- Kyle

