Return-Path: <linux-kselftest+bounces-5120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A456885CE40
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8A9285B98
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630928371;
	Wed, 21 Feb 2024 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eY+mcvmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D512574F
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483561; cv=none; b=pV3xY2N0+pWifA4UDr3OIFjjSjSjGIaTmDF1hoy3p6UrmjEP4qIQ6KLEo/Y7gRoKHRbUQ5uWSkvjsssMkq88mPry3WxD2M7Nhja/aefsfHio119lIlZf0zy7ueJCDTUh8AKM7+bgqTOmcndBBHqX3vKxcY8IHYmo6U7V8b88EAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483561; c=relaxed/simple;
	bh=ve1P36IQxgQSH5e/j0CQ97PbRHxGM/0Cwkl/MH1SMuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F77s3kJLoBqL7EnwhF3FoTiEX7Xj+bEa2rU6TQAI5MXaOJI4N0YJKi7dUQ0OnFesMgt05yRhBKb+YVC+ZMIjXev1YufxwfIEyMGyfLjBpstAOZEemklLo6Sj6nBoSnJ2UVMrO1KCwhXxVSXI9v2VwJBrcGgEhC4xRiteIOV0HVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eY+mcvmr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d934c8f8f7so58201225ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 18:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708483559; x=1709088359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve1P36IQxgQSH5e/j0CQ97PbRHxGM/0Cwkl/MH1SMuI=;
        b=eY+mcvmrLFndy3vMd8abbvvdkULPrS9j/rbHuiS6BpOmmsCTwnlklWp6M+wxwAdgeN
         UfoXCNMgSyr5wD1t0VfJ/nMZvzlUdWEoo3e9O6+/v4f32pq7c8hJZ6LYGE17SdTBXkEj
         dRg70wiXqBwr4B3w77PZLgPkW8N0tWg6vRSrytbCzsL1e4enAjTMxJbQ5Eg2QIMEARVQ
         Da5+Iyty92uH2Np1ZUyWQ2X2NhtHK8SN9oDQHOLc+TRCKfj5qtrmTgMBaoJUlPpqV2zB
         RB7capCvii6EPMsLb5g+m23QkBLccOm+NdTIDL2hXEna+MSiUfRgQ+HsXk/0IgJ80vla
         rRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708483559; x=1709088359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve1P36IQxgQSH5e/j0CQ97PbRHxGM/0Cwkl/MH1SMuI=;
        b=rdduTL5TpaAHI82l1NSg4tvB90XMSCoacDScSqhWzYUD3hSbLXCcBkkiJ7Dr1+Ct1u
         gFy5CMY/+a3YZgMEae4ZF8abSyk+N+cJZLA5T2ZmFPT89jwJU2HfeMHc0X9WN2C6YmR7
         ntLuT0GCQXr2nWlRZ/Gzl7uVhtZKesChSJ08/NXIp7OGxXPwmDsUkvVh6WeGdj75Xl+7
         dnmQ5nCd3LYZD83/8qWN1GmnKvVeXNgZp/SygGVPnMIo/5JAeGtkuBJgkemLeIdUXvjQ
         zZtCZCWuneUM/wt3hRqpvUunnygV6pNMqCvhrU6qBcUVmGtpqj6coz3LvwM0C/V4Ko4B
         rNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT7SsHyV3/HoZgv1uXv1E3lt02a5vUwboFxSAi0cQdsVsYKCUsNPjDyV0Tmt9W0nItjF5NzZlAR5HGSvnoYaxbJ3MFj35zwsUuZIVcJCZg
X-Gm-Message-State: AOJu0YyeS2Px6wTSEZCDiPZKHoNCsOv7c8vZtx+Qg0rESpRRoUWPiytX
	Yofvm+Vjtx8vqUucElqENYGEZMe28Ymw+wHTMeKMe78PNox0+SkmdAWJ2QWA7cV2WEqN1fILgOh
	tcbWTPyIbk9gfG2vVUtaFrAVxi2Sr2RXQ4628RA==
X-Google-Smtp-Source: AGHT+IGashesbOHbcyrknzxfVk2lf4tXLZJ5jdamBO+1t79MQQSOI9DHPUj6TjyB6Xz8pKhd36pDvEFEfQoRdh2c6sc=
X-Received: by 2002:a17:90b:1281:b0:299:6848:28c1 with SMTP id
 fw1-20020a17090b128100b00299684828c1mr7815650pjb.26.1708483558766; Tue, 20
 Feb 2024 18:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <CAADnVQ+E4ygZV6dcs8wj5FdFz9bfrQ=61235uiRoxe9RqQvR9Q@mail.gmail.com> <CALz3k9g__P+UdO2vLPrR5Y4sQonQJjOnGPNmhmxtRfhLKoV7Rg@mail.gmail.com>
In-Reply-To: <CALz3k9g__P+UdO2vLPrR5Y4sQonQJjOnGPNmhmxtRfhLKoV7Rg@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 21 Feb 2024 10:45:47 +0800
Message-ID: <CALz3k9h8CoAP8+ZmNvNGeXL9D_Q83Ovrubz9zHECr6C0TXuoVg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 0/5] bpf: make tracing program
 support multi-attach
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Kui-Feng Lee <thinker.li@gmail.com>, 
	Feng Zhou <zhoufeng.zf@bytedance.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:35=E2=80=AFAM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongm=
englong.8@bytedance.com> wrote:
>
> Hello,
>
> On Wed, Feb 21, 2024 at 9:24=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 19, 2024 at 7:51=E2=80=AFPM Menglong Dong
> > <dongmenglong.8@bytedance.com> wrote:
> > >
> > > For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allowed=
 to
> > > be attached to multiple hooks, and we have to create a BPF program fo=
r
> > > each kernel function, for which we want to trace, even through all th=
e
> > > program have the same (or similar) logic. This can consume extra memo=
ry,
> > > and make the program loading slow if we have plenty of kernel functio=
n to
> > > trace.
> >
> > Should this be combined with multi link ?
> > (As was recently done for kprobe_multi and uprobe_multi).
> > Loading fentry prog once and attaching it through many bpf_links
> > to multiple places is a nice addition,
> > but we should probably add a multi link right away too.
>
> I was planning to implement the multi link for tracing after this
> series in another series. I can do it together with this series
> if you prefer.
>

Should I introduce the multi link for tracing first, then this series?
(Furthermore, this series seems not necessary.)

> Thanks!
> Menglong Dong

