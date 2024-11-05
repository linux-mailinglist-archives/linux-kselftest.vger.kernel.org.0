Return-Path: <linux-kselftest+bounces-21503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393469BD9D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 00:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C2C1F23C17
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A5D216A38;
	Tue,  5 Nov 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yyk7x/g6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68109216A29
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730850214; cv=none; b=XXy62v4fxL1PShfN5hPFJhr7KTPTSQ0a+PrEwDM2eCbEUeIcYBeuHVyHBnlhuLiq92znR6anf/pO4M6gZdsGpSarn1TzXx92TL42ok2MY9RuPlMjjPOMXc2cbJ7cu0WpYwVzjWGA5SWEhHcit+vmpxuZ9mZStVpeyp+22juDxiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730850214; c=relaxed/simple;
	bh=rGIxfYUMGC+0p+tJHBH5oxT0lD72QKAWr4fKDQjgByo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVeXX0TjgGJ06ZzoiZIgk4qctSVbcnEuo/1eItQzC0wos7Vo06xHY3cBiVjkVSnaDVFrrzOlTLoQxAdt18CEaRxdXeEU3DGsXc5/vUqz3mIFun4LelTzPWfEiUF8dAf7AhV+4R3LbqP9C29OwLzTcJoMyBpc3NsqLuls4Be0zco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yyk7x/g6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460969c49f2so102781cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Nov 2024 15:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730850212; x=1731455012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMSgq328bvRoczOV74Kr3/mekiOMOJv1wpyXhdeNrrc=;
        b=yyk7x/g6f1zeJCLCF42LT5AehZILxSl4JrT/IJ4BUmykq0VysfIlbF1Z6vrAIKNuWK
         DmAEC3Pd9DpRR2noU6+IGOlhdJv9cvfyhilvJuNeCweDcI7qw3G/kcz2olLDgiB4U4yi
         W9EoHZ+SEiLZxkLzkmXgvVh2RrJbjBsPTiqN2MR0Mt30VZD3NwyFA+oKEQNf3cpxj/O3
         Sm4zO0O/tNv2VLK2mjkNTy7DbZ6R4H51ZGtsaIwnxd3PhmLImOsoOlRgseR3ozta20Uq
         lMKQYPTdYLJKAVnvxuel+g3NpOBlNWbBjrfB+M45pSC2djAXW/7DEtMuNAe7jW8XhpFw
         um+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730850212; x=1731455012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMSgq328bvRoczOV74Kr3/mekiOMOJv1wpyXhdeNrrc=;
        b=JQLJXu5INVnDLb6x83Dli8laC0wlJj9eZkMb9yPhoHd+U/fl5Kn1ngLAWPLn+X72hI
         PY4LgE4MPj6yw1l9z0boXLRHZWp4oEVwRIHsGlmCEU5PE69TTSJy7T+pC1SWgyPRjsOH
         XdcRPTHuSk2Jl2qs/J2dtwWH5qK9ho8y2gBi2BLcOsRLQ6P4OGrfIvUJfKToGPxeahCt
         hnnu8VZmI1IE7Vk3pkqPrkWXJVjI5ffE48F9wsTY48fPNBz6qI3zE2gYrJdwr7LEoxDa
         QNVB7Oj67hhZ0cw8wweYWzgupWUFCrvi/y6tDcznftOCwgWdnNvhlUAtlE6klstU5hWa
         YtfA==
X-Forwarded-Encrypted: i=1; AJvYcCWUaYFW2NvN9ZmqIOHNUjRFPofpSwxqLju0rOWhK4sEr9cnHjzTZ0Q1YRtx0p2I6FnUWs3+duYlAH5HT0U5I8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfA8Cxw0yWbzD/Spiy/LjxIeuxlZTFOxwFkqOVOCXSpIb9e3D5
	wDOQmqLaheK9jXe6lh2qWzxLlmro8BXX6F5xWUTdyH4gsWikY2VESpYmOcFmScEuv8yR2YarUBI
	9xWlcY5v5F/KLexU8XQXYcf8RQdNW75Y1Vhvo
X-Gm-Gg: ASbGncur8xpGTE7cxSQ6WdmkNK/+LAXfeJBEJwKuhm3r/P4TrBwXBsJqpNHxPwJRUqD
	7/Nc3m04Xxrc31Hl598iEPtVWFc5ZkHo=
X-Google-Smtp-Source: AGHT+IHTdjsvhxECrEd5mYYOu8rK42TjP9yPIHUQHEW+CcKJ7zyMPDDZSE31qTz+BJkoW7NLSmTmgLtkwHec4mur7IA=
X-Received: by 2002:a05:622a:1b8d:b0:462:a9c7:e60f with SMTP id
 d75a77b69052e-462f16c07c0mr428371cf.15.1730850211785; Tue, 05 Nov 2024
 15:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029205524.1306364-1-almasrymina@google.com>
 <20241029205524.1306364-2-almasrymina@google.com> <ZyJDxK5stZ_RF71O@mini-arch>
 <CAHS8izNKbQHFAHm2Sz=bwwO_A0S_dOLNDff7GTSM=tJiJD2m0A@mail.gmail.com>
 <ZyJLkn3uM1Qz6NZn@mini-arch> <CAHS8izMWbcKSr3uOVWQDmo5=aQvFdcD6o_myz1bw=a1rzrJE_A@mail.gmail.com>
 <ZyqSHic5hW_vi47l@mini-arch>
In-Reply-To: <ZyqSHic5hW_vi47l@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 5 Nov 2024 15:43:20 -0800
Message-ID: <CAHS8izOdqnXytOOyg+EATHg5ON+eBDn4qe=L3a3YKd5tzdqV0A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 6/7] net: fix SO_DEVMEM_DONTNEED looping too long
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Yi Lai <yi1.lai@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 1:46=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
> > > > Also, the information is useless to the user. If the user sees 'fra=
g
> > > > 128 failed to free'. There is nothing really the user can do to
> > > > recover at runtime. Only usefulness that could come is for the user=
 to
> > > > log the error. We already WARN_ON_ONCE on the error the user would =
not
> > > > be able to trigger.
> > >
> > > I'm thinking from the pow of user application. It might have bugs as
> > > well and try to refill something that should not have been refilled.
> > > Having info about which particular token has failed (even just for
> > > the logging purposes) might have been nice.
> >
> > Yeah, it may have been nice. On the flip side it complicates calling
> > sock_devmem_dontneed(). The userspace need to count the freed frags in
> > its input, remove them, skip the leaked one, and re-call the syscall.
> > On the flipside the userspace gets to know the id of the frag that
> > leaked but the usefulness of the information is slightly questionable
> > for me. :shrug:
>
> Right, because I was gonna suggest for this patch, instead of having
> a separate extra loop that returns -E2BIG (since this loop is basically
> mostly cycles wasted assuming most of the calls are gonna be well behaved=
),
> can we keep num_frags freed as we go and stop and return once
> we reach MAX_DONTNEED_FRAGS?
>
> for (i =3D 0; i < num_tokens; i++) {
>         for (j ...) {
>                 netmem_ref netmem ...
>                 ...
>         }
>         num_frags +=3D tokens[i].token_count;
>         if (num_frags > MAX_DONTNEED_FRAGS)
>                 return ret;
> }
>
> Or do you still find it confusing because userspace has to handle that?

Ah, I don't think this will work, because it creates this scenario:

- user calls SO_DEVMEM_DONTNEED passing 1030 tokens.
- Kernel returns 500 freed.
- User doesn't know whether:
(a)  The remaining 530 tokens are all attached to the last
tokens.count and that's why the kernel returned early, or
(b) the kernel leaked 530 tokens because it could not find any of them
in the sk_user_frags.

In (a) the user is supposed to recall SO_DEVMEM_DONTNEED on the
remaining 530 tokens, but in (b) the user is not supposed to do that
(the tokens have leaked and there is nothing the user can do to
recover).

The current interface is more simple. The kernel either returns an
error (nothing has been freed): recall SO_DEVMEM_DONTNEED on all the
tokens after resolving the error, or,

the kernel returns a positive value which means all the tokens have
been freed (or unrecoverably leaked), and the userspace must not call
SO_DEVMEM_DONTNEED on this batch again.


--
Thanks,
Mina

