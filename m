Return-Path: <linux-kselftest+bounces-6246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8815878CE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 03:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC0F1C20AD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD80D6FB6;
	Tue, 12 Mar 2024 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI8/DEW4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B71EB5C;
	Tue, 12 Mar 2024 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209599; cv=none; b=Mb1Rlkdu4BnLyZF85yRbVZ8/SwmD92mZQ7kvVXyxrXP69/+DnT702rZRlp1UVw7ARwZr34yaST0ITJ77QapGXWfCGWcfxwIXvlKwFRYvmRHTr2MDdAyzTPX511lHOdb5r0qiR1P64KeT1NpJ4mnoCLhlSt+lcKroWT10Ob/8FL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209599; c=relaxed/simple;
	bh=xxgkr5eNkvW5q1zkcYlUGp+GjUJ5hPdmOjnvJkUucnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn/iiSEex6TiwnyGjOdH5lhsGnQRNz1Hmx1HTyquVyxTzFYSgeC1dcK1F1AzvleOzVGUdQSOobgkZvTrXbWQ2eoyds/zPB6ZcsJi1aLXd8cRwHhxJfHfXUX9AWgc1kbMrHgxmg9kI0dyjVlpitPdPklSy91FRKIMlD8vO737y6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI8/DEW4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e899ce9e3so1805288f8f.1;
        Mon, 11 Mar 2024 19:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710209596; x=1710814396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxgkr5eNkvW5q1zkcYlUGp+GjUJ5hPdmOjnvJkUucnk=;
        b=EI8/DEW4FPp43ofgqsH2qBfW49i50NoDCrizUb6IYCuupG45uqgzh0Exxt7Isq63pw
         fbg5COrtcmXD63Qu2BfHZL2/skr4dnSx8BufGb+fH3xb93d1jOmCMWMdQfcSOUqk5UNh
         WGrgQ3qV0zStRiyHj655rMmMDIUNftrzZvoHv3npiGzAN57p1pLmHQIlQ0go8EOXhkcG
         En1ujhLOX29nn6LpGrjX44RbCS4WOVFnOcH1SOc33lAF4xhMq1RtE6DYnEnFaZL2Db39
         fw5O35I8YtGn2lik5fJPZ+X/zyyM7oLK3W3HtCMZM15vHuw2Dn1SEpxbEVNGlV3qx8+z
         216g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710209596; x=1710814396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxgkr5eNkvW5q1zkcYlUGp+GjUJ5hPdmOjnvJkUucnk=;
        b=dgSs3a2MIyxDxomMuoq0dNeZsgmiKXA7gcUbcULgc/W8xoB6fcK6IPkNFqIXF2ix8C
         zOB2T8KCL1BzVVO0EHy8WGsGrFWVTKtQ+xPl+ZPNUzQ1b8WGGSsD0Xd9xRzFc7zBnNXi
         kfjAIkHMPBsSz3fE+RFUz2uRyU0TiWwlNveYirzLfH1WJclFivqEgfYDWR1c+6W0nGQw
         qX93w3vQdEyJ/p8ivuIdEnLtkLIPE04MYnJY03+CqVRpNgMI21QJIOcYoGxtLfeWXQE5
         RQIiR4lr2W8rEDPTvPzVvDoAq9Nicad6LXXyUzBuOf2FwMZqWaVLrHZiBPlgD549KdRf
         GzfA==
X-Forwarded-Encrypted: i=1; AJvYcCVCvbMxEXCNkSmEeKEMjaD4seLhhkiEkzWipJXMFGHN95lPfC6WXvjkqL6pyCK0noLLpBFPK7KXWhUjMvVwZYQxCaz2DwlJtHhn+czXAt7TV58+7mrgl8FnjlNyBFE1fxlqMIWPsn0YWt8PaA1jAH6oa9rolni47ezC2njkdNshk2oNbyBbz1dNsk/hjK+2DExpVfiwKqLyna/f90bj34y64PAfgIXl1jHQNb7MPCUjuqM0nJoA8NLA5HnHLNmx6WeDdamWU7yz2Drxcjxb1LOl0gDxAziRUeGkSA==
X-Gm-Message-State: AOJu0YxsgvTpIp43h+AalndypjPsQB29bSwBY+JRm1vAbxqOQVPlLRDa
	lpcvfydqZZ4YZ7cekcpDpalRrG70mcu6SnoeqjYEP+NvijXs8F++KZcK9E3gkNt63TCqkggmh+G
	BcM8SKxYoKSLBlv+CC1Vhd44tPsE=
X-Google-Smtp-Source: AGHT+IGaeIqJnZOJ/SuZRPtu+8MtD/3nozajQZ94fUgHlD7gwqeVkMLfFrTcgwoFQp9lHB+TsWg3BU+ivdAF6tyjFJM=
X-Received: by 2002:a5d:4112:0:b0:33e:74c6:bcb2 with SMTP id
 l18-20020a5d4112000000b0033e74c6bcb2mr5165378wrp.16.1710209596408; Mon, 11
 Mar 2024 19:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-8-dongmenglong.8@bytedance.com> <CAADnVQK4tdefa3s=sim69Sc+ztd-hHohPEDXaUNVTU-mLNYUiw@mail.gmail.com>
 <CALz3k9iabeOwHSrPb9mkfCuOebanh3+bAfi7xh3kBBN0DzHC3A@mail.gmail.com>
In-Reply-To: <CALz3k9iabeOwHSrPb9mkfCuOebanh3+bAfi7xh3kBBN0DzHC3A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 19:13:05 -0700
Message-ID: <CAADnVQKsrLB-2bD53R4ZdzUVdx1aqkgom1rzGCGKK0M3Uc+csQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 7/9] libbpf: don't free btf if
 program of multi-link tracing existing
To: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
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

On Mon, Mar 11, 2024 at 7:05=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongme=
nglong.8@bytedance.com> wrote:
>
> > >
> > > +LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
> > > +
> >
> > It shouldn't be exported.
> > libbpf should clean it up when bpf_object is freed.
>
> Yes, libbpf will clean up the btfs when bpf_object is freed in
> this commit. And I'm trying to offer a way to early free the btfs
> by the users manual to reduce the memory usage. Or, the
> btfs that we opened will keep existing until we close the
> bpf_object.
>
> This is optional, I can remove it if you prefer.

Let's not extend libbpf api unless we really need to.
bpf_program__attach_trace_multi_opts() and
*skel*__attach() can probably free them.
I don't see a use case where you'd want to keep them afterwards.

