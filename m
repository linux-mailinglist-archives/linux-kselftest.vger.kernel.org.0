Return-Path: <linux-kselftest+bounces-9564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B1B8BD830
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 01:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2DD1C21D01
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 23:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3715CD65;
	Mon,  6 May 2024 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vejhz29H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3ED15CD78
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715038244; cv=none; b=Iysp1UKwmN07Cxsc92OgS0DQEBxNCy+/+Bwgtpgw0kNWGQHlqfWUCtkPkaE82pCAxa3Bf9jNElICaeyvaH2rOj3WFGEUs9IYj/tQbX27H6QwYv1bDsulgg67h7s53B5M6Qk2Crbe5fATUUUEdAblAV4miCuRCTl4pTgvp9/zYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715038244; c=relaxed/simple;
	bh=dC5gmNPxNSH+aIEWUfqlcoUV3/RSi8n3oR46/xve6dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qi62R9jNJERojl/JXLKWCJ1li7mqltu1r98mQ3W8vRKp2NUGaeH4HpjSsmbvNRTdKlN8ggtsPYGB4elE8jNfnhoUMUT9gGYdCvdjbG4eFG3qeQgGBsl8czlqIyzFc34sh0fdXJQ5Q5yWOWrUZ8lkSXo2LGUz3NPxQoJHKGD/m7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vejhz29H; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso2364a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2024 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715038241; x=1715643041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rday+enGpH1mUN4w1iIrCf7IG9Q6aF8QR6lBBrCyZ7g=;
        b=vejhz29HQj+gKtb2WBiToZaEiReMxu6rMyWsEaQNyrYelzJtXm6QXARFGs+gCMc9uI
         1bR8A8t7uZb8FSTLnOipGuyAZmNvSCl2NFiAbn4XxXfy1Imvhd7IVqvIN+bib+3w1lg5
         IPQd+9F7JFynHtvPiJBcLsZxTmMac1vH7Gm2e1xTsVooNKySrtOU+K8dzpYmwKqHaa82
         0CNs5dMpqqcaWO5Xlv5V0TwvxIYN32LFWPStMApOSn/fJ5Nxj1XPwaooQvf/nQ/JLTvf
         H+wXXm5iOf+UNGNkM2f30GeWTBQxcMGMYv7L7JHrGMtb3P7m+yGK18wfaU1L5bTxH32p
         r+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715038241; x=1715643041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rday+enGpH1mUN4w1iIrCf7IG9Q6aF8QR6lBBrCyZ7g=;
        b=kN9BLAIvn5bc6jZ1KgWeks83bl0dJ/Gf3zL81kp2aTa9pqrviaYS3g8oo/LAiujerA
         QxVXrfd+Nx9vqHKpZWlSCcEznSXe+MlUtxhFDR36K6kTvYacx3CWVxr6xR1UhNa7HgOy
         +ilgib1/Xr7xLVfgX5/l8a6djQNYhge9Lzf5xYNqVr13UATtcITXKoFNf5AvMBTaHGh9
         iBD1mnjFcxsmLFS3HzvhwZLFIy4rLO7zrBidSIlbLgWL9xEabf5sX3JiKJHWpMh9CmPe
         7CBtISJ8W+a3mhBwTzr/ldVUeShEwG9hkRMpyATMpl3M4adW4nO8FwXPEzDZylyCe4QN
         XDYw==
X-Forwarded-Encrypted: i=1; AJvYcCUpBfRX0Yfy1YByVbbkKzT1I0jjUQo+lLmlCOKXF+QgJWWOFBdGY+Au0j1wCSIUhpQLuUE/MsdZedbQbKtcQRYGPcIX4HcA+VUZ98oz93zv
X-Gm-Message-State: AOJu0YxsF8fmynUky4fj452oXNX5k5JscV4aS/vM8zMlIeezd3YX44qm
	ezQOVsOvJmvYSdiNjFBnrjbOKVr0XPuq50jDa0UHnOSewgv9/oexEMsGkWSfojWu6AL5g0iuqQN
	QwY+hgDwP8NOBEje/Rh9fwCeBmBkD9+nyvWRq
X-Google-Smtp-Source: AGHT+IFPtbSaAcsaOKbHp6npYdFSTUzqld8pO8i1uwvZe0pXCtMxJsE/ukQM7Zz7NLIcHgg7/XYVun1u85SF7+71r+g=
X-Received: by 2002:aa7:d389:0:b0:572:554b:ec4f with SMTP id
 4fb4d7f45d1cf-5731316c507mr37653a12.3.1715038240800; Mon, 06 May 2024
 16:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152831.3199999-1-usama.anjum@collabora.com> <202404161027.63F4D4FDEB@keescook>
In-Reply-To: <202404161027.63F4D4FDEB@keescook>
From: Fangrui Song <maskray@google.com>
Date: Mon, 6 May 2024 16:30:27 -0700
Message-ID: <CAFP8O3Jjkh0U94CbS=epXELMtCBpYt4fGejX3spH4=GdF7zVSw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: exec: make binaries position independent
To: Kees Cook <keescook@chromium.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yang Yingliang <yangyingliang@huawei.com>, 
	kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:28=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Apr 16, 2024 at 08:28:29PM +0500, Muhammad Usama Anjum wrote:
> > The -static overrides the -pie and binaries aren't position independent
> > anymore. Use -static-pie instead which would produce a static and
> > position independent binary. This has been caught by clang's warnings:
> >
> >   clang: warning: argument unused during compilation: '-pie'
> >   [-Wunused-command-line-argument]
> >
> > Tested with both gcc and clang after this change.
> >
> > Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
> Thanks for this!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

GCC versions before 8.1 do not support -static-pie,
while https://www.kernel.org/doc/html/next/process/changes.html says
the minimal version is GCC 5.1.
Is this a problem?

If not, and CFLAGS is guaranteed to include -fpie/-fpic/-fPIE/-fPIC
(PIC), using -static-pie looks good to me.


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

