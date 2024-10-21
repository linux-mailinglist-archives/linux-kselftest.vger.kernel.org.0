Return-Path: <linux-kselftest+bounces-20240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494249A5E18
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEA0280E68
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BE1E0E11;
	Mon, 21 Oct 2024 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SilbyoqZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAC4C70;
	Mon, 21 Oct 2024 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498075; cv=none; b=lzQY7SlCQu8ej2GA91RIRrYu1VdWDyyutUAZewsUziyVDXDcYQtnDoYIlFYZQvLovROA30sL0Ij5+mh/wKxgDXyTHxqBSs4EZZsOr/CF2HCaDJkrNA9wosVq7+c2HIs2L3cHqtGXdKv3VfaUD0hp9qRtGZZuibHdLaf0kLway1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498075; c=relaxed/simple;
	bh=frqlw9+c2WciPJzXm9k3NmvCJXAIi32u18nbqnTdFvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm5pWYHgR+oIHH9lj8eMp3IcnjOswVBwdx/Kx0ytL8xlGzZ9qdlz1Vms4wEHXRkLO8G5TXl9VX8s6L/zY5VjdzcomI5IMT516xG1uiEQLJRjFRC8n5c0Neh6wrOPIkOGN5hJut//nIxU9urFFQKjuLrqoqchx7YRazV6BYzqCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SilbyoqZ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b1aa0e80so17574465ab.1;
        Mon, 21 Oct 2024 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729498072; x=1730102872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coo1M6T2q8un7meFS9mY2PhxbXk8vajE/KVT3n6kQWM=;
        b=SilbyoqZeQpoSt2gqoGABlau7Sy0ToDAhEn0gQnbd+XDQSercALneU/BHkHgYlc2lu
         +qhOhtLJ+qY5rzYmAn6N8wvkKYRc9EcWS6Q6aTbZubdqVFqlSSaRtxASPhNLaX6bYoVE
         hKdP4x1erIMyzh/TUU4CID54NDYcnMTy91z8AO5hXi4qNKU0Ts/2KmIVTTZ+Xlts83Dv
         IgSCwxcg79nPV3B1jgTy5AAcIZ8fKULUcWk/+RUw5CI8xE8K1ZlUeTAsrtnZiUjF6+jX
         VWlsS+3KMiTqrYqRpNKu5Q4JQG9tOKRWnUcJAvfDd9SNDdLOhvgSTA2XIxyWGi325/Gc
         cv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498072; x=1730102872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coo1M6T2q8un7meFS9mY2PhxbXk8vajE/KVT3n6kQWM=;
        b=RpMcrRqoJMmqm9OMYUSuiTR5r1qNx/XqdV8oMhZ+e6j32nhwHdlwu/KS4bQnYo7M2t
         eiwqe9gpNNuhvG+dlBOzqV1eplTG4CF5SlGRXgSn7iDGQIrTy07nqcMm4Ajrz80aTvX1
         4xRkurrljeI8bGDB+PntbJWOLGT/u2vtMteW/QdA4638Wo5ih5VvRlTgAQ+7CNKdhQ0l
         wgkCq97qTfAUCxkrNxwYgPRlI/Ot8ndz7tZd1nqazfpQrxysrYUL+Y5s65t50sLtMmg9
         j2qp6UFebzODzl7XD+l9sh89ftiLVmY4Z/UKTAmS8HycBxAvI6JolDClEpdanui0NQB9
         xv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/4o/qTINlT0kTDHnrwQNf/0z2NFqouh0Q//bnr1LLjxFJ8YZB90/tmZznmvNd579Dw4g=@vger.kernel.org, AJvYcCXiM9+g6DjkGpQa1lNoJhBR91qkixjROfe2SH6d69DxxBsXZpmWJVDgNPnR2OSP6aiml4wc4VaqiNoPeYkN/vCu@vger.kernel.org
X-Gm-Message-State: AOJu0YyzlA0yv+FeKySY1i29HL9cy00OCLn0TB41WHNp1ZmpEI7kAKXr
	DxI6V/CpWA7WjlnPZvH0lWXxuItv5Goyk7tktU4CjJYoFBiiNU0CVHKwmhrgdYCoyMgsHNIObb/
	cuydMP9du0+O5c4P9cg2mYJKFHZE=
X-Google-Smtp-Source: AGHT+IFCe//Us+lS6LEubEstk9YiF2dA23nNMdrjaSQcU9aRQQfw0CsC355A/EP2xeDnfIYVqD6A/S3PamEqhcEzJfI=
X-Received: by 2002:a05:6e02:180f:b0:3a1:a26e:81a with SMTP id
 e9e14a558f8ab-3a3f4053277mr104239805ab.7.1729498072167; Mon, 21 Oct 2024
 01:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021050706.29403-1-kerneljasonxing@gmail.com>
 <ZxYFn7fko5C9BnHe@krava> <CAL+tcoB-tHf5kW6Hq0TtsnqFLU3nWZEuZ+L7roDyJ0q_qW=WxA@mail.gmail.com>
In-Reply-To: <CAL+tcoB-tHf5kW6Hq0TtsnqFLU3nWZEuZ+L7roDyJ0q_qW=WxA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Oct 2024 16:07:15 +0800
Message-ID: <CAL+tcoAw1WGnJs2DQjEyzsh_rNXKA44oYX5RvQi8nCvt4+ynLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: handle MADV_PAGEOUT error in uprobe_multi.c
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:51=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Oct 21, 2024 at 3:41=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Mon, Oct 21, 2024 at 01:07:06PM +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > When I compiled the tools/testing/selftests/bpf, the following error
> > > pops out:
> > > uprobe_multi.c: In function =E2=80=98trigger_uprobe=E2=80=99:
> > > uprobe_multi.c:109:26: error: =E2=80=98MADV_PAGEOUT=E2=80=99 undeclar=
ed (first use in this function); did you mean =E2=80=98MADV_RANDOM=E2=80=99=
?
> > >    madvise(addr, page_sz, MADV_PAGEOUT);
> > >                           ^~~~~~~~~~~~
> > >                           MADV_RANDOM
> > >
> > > Including the <linux/linux/mman.h> header file solves this compilatio=
n error.
> >
> > hi,
> > strange, uprobe_multi.c even has:
> >
> > #ifndef MADV_PAGEOUT
> > #define MADV_PAGEOUT 21
> > #endif
> >
> > and '#include <sys/mman.h>' should be all that's needed
> >
> > could you please share more details (extra flags) on how you compile?
>
> OMG, thanks for reminding me. The net-next branch that I compiled
> doesn't have those three lines. Now I can see them in bpf-next. So I
> think the issue has been fixed already :)

Link is https://lore.kernel.org/bpf/d9846ceb-b758-4c17-82d1-e5504122a50a@or=
acle.com/

The previous comment is not that right. Making sure to include
<sys/mman.h> first solves the issue so there are no complaints when
compiling. No need to define MADV_PAGEOUT, I think.

