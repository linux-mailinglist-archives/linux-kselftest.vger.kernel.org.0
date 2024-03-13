Return-Path: <linux-kselftest+bounces-6287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594D887A08C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 02:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7102851DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 01:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8429CAD5D;
	Wed, 13 Mar 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FDZNA8oD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB933611B
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Mar 2024 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292456; cv=none; b=scTgyc4SyLLQ53g8kJglAwrBmIJS/zvgSUoHW9uBZRzBC54o/Ofzg9c9A6I36wncH5vdxSjh2qDfQXDgmQ6HEHOwBElAzpuRlvc9pmMAGGq3SH4E3DtxitWjUdrG+u5hqxAK1dVmJz3/S2wP4SC0QWZQzwKB87I2hKCkvg0DL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292456; c=relaxed/simple;
	bh=twMccmPlR7/SShgFg0AONE56vJVPPL3EBuKYw8SPbFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgsMYUa2jLrM5XKpv7sl14PphszeiHtc76ePgxHGxiTkmR/T4su6caebNG6bJccjqpl2mp/RnPtnCfdzYDJ5xjiN125p2Vv/zmgoIgKBdYymDFj5IvuGE5lFu0r3R9EagtThnzR6jcaRE4xYSH3MBoWSqVb5T58WFeFCca8v7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FDZNA8oD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29be5386b74so2308059a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710292454; x=1710897254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twMccmPlR7/SShgFg0AONE56vJVPPL3EBuKYw8SPbFI=;
        b=FDZNA8oDu26c1b4Iq8kZpI5sjsgzWxN3M1q+oBqWsp+edkBILL0x/ka8+/nChjOnBo
         cMYlOjrqOw6kEqUyIAMKHDstbnc8rFkNuM1rrWPxLO3KbA3p4Y++EQDbz8OKhAb5qja8
         P/1+acCyx9guR3yh+MkS99mdDHrWjPTSgvwyMWYpSq15boCnFJ9P6M8RBXrnaibQe2qk
         2BsCYF1COi08jt7I+YEdGO6oK2NjxCIwpkkFSRn8A/uCPUSF/O4d72djMV8nJFSKXwUQ
         W8cPGSiSEhradaspEmLUBW3lkkxtC0OsA80J9lNQ/YWJOsOA1HqnRU1xV0YI5hVDMg7T
         PbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710292454; x=1710897254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twMccmPlR7/SShgFg0AONE56vJVPPL3EBuKYw8SPbFI=;
        b=adyCvTgMo7kLhfdg/1maPiEw/8XP5IldzAp9hWvHsqbbpeWXl14D39CS0Bzkit9o0c
         7Xjs7xCrCvq0voQhIv2fLty98Vc9U6gYwTha5olME2SKSaBGQLS3k2PcGU0eqIo2IT9P
         6KFpkhkSyFGIK3r5aUXWoSA2+aqTpeMGZWbwpYFaVfEof6jVKC+Ovhnx9bfrk9LfMX2h
         qE+3Q/w/9MdBGdvKwPXVJrGWyspmpaW0D+WTeYGFT67W8vD2gL06qWdXS+zonV+iHhjZ
         krcNbfMXDAie82U8idgRUzwCoIeW31UzpnJ1DtQCSIr9DYDHQVKcVSJActbYEJ5yzbMK
         d6HA==
X-Forwarded-Encrypted: i=1; AJvYcCVBQHxAyFL1RLjMBrdh27ncB62KE0soqy0MAgHSEYvYXg7id5oIH17CNXOaxT3rLj4xVgJxvHJ7CuwpwLpb2Or6l+xlqgMjJzSMQT9UKMV/
X-Gm-Message-State: AOJu0YxurjbHnI7Gu8LMMuTGvT10Ebe1o8RcAOidwBznuojoin/NCtjc
	C/Zyd3YKeJg+obtqE0ASj+NGJNXnTxeuFU1LvRl4XobEaMqMbvEBqIaoe7lZ0DpUskIb/pn5qRS
	dNf1ZUgBBggTgaG3drgkJUTVogbJwXhjG9M+0ww==
X-Google-Smtp-Source: AGHT+IFJ2nJztVxlcv7iF1fLo4e+81DiH9lck4a4XLEq2MMi6yrbHR+XGNXNfeaQ8LZdIPeyXdsLEIp10M0upU5dDak=
X-Received: by 2002:a17:90a:bb0d:b0:29c:5ba3:890e with SMTP id
 u13-20020a17090abb0d00b0029c5ba3890emr829001pjr.4.1710292454186; Tue, 12 Mar
 2024 18:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-9-dongmenglong.8@bytedance.com> <CAADnVQK+s3XgSYhpSdh7_9Qhq4DimmSO-D9d5+EsSZQMX4TxxA@mail.gmail.com>
 <CALz3k9hZxsbUGoe5JoWpMEV0URykRwiKWLKZNj4nhvnXg3V=Zg@mail.gmail.com> <CAADnVQJ87Ov6ny2hj-0_WymGB3TeuEZu373EmqmRJqZv-8Ze_Q@mail.gmail.com>
In-Reply-To: <CAADnVQJ87Ov6ny2hj-0_WymGB3TeuEZu373EmqmRJqZv-8Ze_Q@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 13 Mar 2024 09:14:03 +0800
Message-ID: <CALz3k9jf4Q7KJPes=omx5oBpEmoFNSvc=vp=D0hEa-51i7tc_A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 8/9] libbpf: add support for
 the multi-link of tracing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:12=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 7:44=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
> > On Tue, Mar 12, 2024 at 9:56=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
> > > <dongmenglong.8@bytedance.com> wrote:
[...]
> > > Pls use glob_match the way [ku]probe multi are doing
> > > instead of exact match.
> >
> > Hello,
> >
> > I'm a little suspecting the effect of glob_match. I seldom found
> > the use case that the kernel functions which we want to trace
> > have the same naming pattern. And the exact match seems more
> > useful.
> >
> > Can we use both exact and glob match here?
>
> exact is a subset of glob_match.
> Pls follow the pattern that[ku]probe multi established
> in terms of user interface expectations.

Okay!

