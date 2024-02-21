Return-Path: <linux-kselftest+bounces-5125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D285CE84
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 04:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3971C2305D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7342B9D7;
	Wed, 21 Feb 2024 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftQDL4B1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13D2837E;
	Wed, 21 Feb 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484538; cv=none; b=dgUQPR41mymwE66dCrog3lC7tib6oCot/35hXkzWA4wVzqbJGdaKrB8ii8NyZM84OMnIemNXBDYTL+esl4ofYtC2A2NNEbgVqZQtrppKuzOLFFbIVEX5GFAjyaTak1LEdmOH/5a+Y8W4S/9c7vkfYgSGqc1eD5bf6ZKMg+oYIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484538; c=relaxed/simple;
	bh=5YeEcEgxYmu09MXHLnpzvtsKYMcG3p92FbXHkOlhAMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBtJEaieu8lEa8HkbpzmBQa7lBvYmuC8ZPvBx7jqXlJCa6l5203GRuEDGy5fnpRmPnKH0zuID7nvDhcdPC0v8fwGy1/xlkXsdILDTvxxg/ON+T/CKdzhYmXeMwB+mh6Bv3uehs4wueHcgOl8gMnyKLgOKXituBKOffa7u9D0EsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftQDL4B1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d509ab80eso1402208f8f.3;
        Tue, 20 Feb 2024 19:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484535; x=1709089335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YeEcEgxYmu09MXHLnpzvtsKYMcG3p92FbXHkOlhAMc=;
        b=ftQDL4B1EpDsa6mlFyunr/yfdN/iW0Vs+lL+vPzoFx5xqFhde/G0tSzlIC3YESoOjC
         ZkBZK8pw0zF+fvADmlmo5RdJ3Y4U61fO1f1R4NdQjTP1I5JXA190WC6Eega79DDEjdkc
         Na6rb9b/2MD+P/eLNClsliNGVvRQicQMNQpsX/WkkI02aMGV5FGDCLUY004c/FjFhcPa
         sWbWG5aiM/vuRED6YZbWbwiU1ZaT0/RcSqursvaDw4TccUj4KseXs2y1cl/jN04O+17n
         l7OmELN39q5nAHV2rhMdG5Y7gGJtRd3nYsp0PG6FWaS/oc51G1H4liiPBKN4qSuoYMT9
         f+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484535; x=1709089335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YeEcEgxYmu09MXHLnpzvtsKYMcG3p92FbXHkOlhAMc=;
        b=FlXQZ3/3qaoXaXSHXlRgjhWEELWt/hCfxzVMTcsTCF2ivvKlqKVwA8eCwMNZrc9bZZ
         btTOc+YZ55raLdX3O1wMU4Jwu2c0doChAnj9zZsTfrRMQDz8wmW7C9Rei4P9hEZbNSwC
         gMnXAUmgXCA4iG55lx29NYuJYQtvFqGAX3Km85seSHUCZyqueqj1ik8TsGwsi5YGAs94
         xgyoJU1lrb+3XlY5d3Gjj3/Pr3LgL4itGCkWFDJsolpVPtPI9qZEeKn+YPJHM+qrXuKn
         7WcGRXvOIBY1CUeskSRmuMbM7ngv2BQuKwsqa3I0ilwtdfUI1jT88rgfvcS3kCnSB6tD
         +zdw==
X-Forwarded-Encrypted: i=1; AJvYcCUqXHIEcrD03evpJkm6SsoAUc2P3vhFEhQv1n5z3Y0FnZjh/voWG1LAbASSge115gVuDeLtO7L0LtE3/xYpq1ykc08LGMRbU+WF4911zbtaRPiUHLgMUyqhWcYEuz6zr7Ol5d1pRJcruN/w5DglvoDOz3AGrMR3deT3RVL+sl8gifSE
X-Gm-Message-State: AOJu0Yx3yLN2vpAHIIREFMSBsj62phDsNlVXor1yHT2cIXCNAQSqRYZE
	C3RiBmp+6crxX0T5i44eoQqmkWuMA+WIPsxc8JpUDeVBFJQQjW1pmJnZWpWX9A/VVG4XYD7XXkf
	E2nYS5uUsl3693f+Rp41eyrN6hXw=
X-Google-Smtp-Source: AGHT+IFXflCjYIorkLHNj0/aaODvrUQ0PoLWhZ3TXJuBYcOMC310Oxt+Nm2xprv0m8PmSrNKxRGUijunEZU7KHlAhdA=
X-Received: by 2002:adf:cd81:0:b0:33d:731f:b750 with SMTP id
 q1-20020adfcd81000000b0033d731fb750mr1454359wrj.54.1708484534678; Tue, 20 Feb
 2024 19:02:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <CAADnVQ+E4ygZV6dcs8wj5FdFz9bfrQ=61235uiRoxe9RqQvR9Q@mail.gmail.com>
 <CALz3k9g__P+UdO2vLPrR5Y4sQonQJjOnGPNmhmxtRfhLKoV7Rg@mail.gmail.com> <CALz3k9h8CoAP8+ZmNvNGeXL9D_Q83Ovrubz9zHECr6C0TXuoVg@mail.gmail.com>
In-Reply-To: <CALz3k9h8CoAP8+ZmNvNGeXL9D_Q83Ovrubz9zHECr6C0TXuoVg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Feb 2024 19:02:03 -0800
Message-ID: <CAADnVQ+bOhh1R_eCoThyNg50dd4nA4-qhpXxOWheLeA_44npXg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 0/5] bpf: make tracing program
 support multi-attach
To: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
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

On Tue, Feb 20, 2024 at 6:45=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongme=
nglong.8@bytedance.com> wrote:
>
> On Wed, Feb 21, 2024 at 10:35=E2=80=AFAM =E6=A2=A6=E9=BE=99=E8=91=A3 <don=
gmenglong.8@bytedance.com> wrote:
> >
> > Hello,
> >
> > On Wed, Feb 21, 2024 at 9:24=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Feb 19, 2024 at 7:51=E2=80=AFPM Menglong Dong
> > > <dongmenglong.8@bytedance.com> wrote:
> > > >
> > > > For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allow=
ed to
> > > > be attached to multiple hooks, and we have to create a BPF program =
for
> > > > each kernel function, for which we want to trace, even through all =
the
> > > > program have the same (or similar) logic. This can consume extra me=
mory,
> > > > and make the program loading slow if we have plenty of kernel funct=
ion to
> > > > trace.
> > >
> > > Should this be combined with multi link ?
> > > (As was recently done for kprobe_multi and uprobe_multi).
> > > Loading fentry prog once and attaching it through many bpf_links
> > > to multiple places is a nice addition,
> > > but we should probably add a multi link right away too.
> >
> > I was planning to implement the multi link for tracing after this
> > series in another series. I can do it together with this series
> > if you prefer.
> >
>
> Should I introduce the multi link for tracing first, then this series?
> (Furthermore, this series seems not necessary.)

What do you mean "not necessary" ?
Don't you want to still check that bpf prog access only N args
and BTF for these args matches across all attach points ?

