Return-Path: <linux-kselftest+bounces-20238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF209A5D98
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 09:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D441F2191F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC261E1038;
	Mon, 21 Oct 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KodUtk5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6E1E1022;
	Mon, 21 Oct 2024 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497111; cv=none; b=PqYWo8kwV4+/oAYzDI4aisUTBE/O9ubnVoGXE9NeWRQWhCciQGCRUy0FPJn6hF+hpnppU2jMHSOLrYlCly/k5cSR5GgLW2Qgdlls+IingYfGDAeoUDIo1gC7onIa/RwkS0GYdVI6kKkNheEfkmIdblIiBgtOwm2cQtcrcddzoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497111; c=relaxed/simple;
	bh=6yOvEmFCdeEqDOE5HHeeYCngV/hqxBfxXKM60LRKMQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/wOtIj4O78/MtybCAhZE7E34RKaPQwZBcd8L6AJx4yxG1/5Hk8GQYhevDdY6X/m9UEKlw0q4eJBWgVn1Cd5D4ygROrueDW+HTm7bQTP3sS/0T3thFkA2srv+yr60qge/IcMRnkrNPTyj9Zcsk6pugttsDcpLVYqPhRwHMvyi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KodUtk5h; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3938e73d3so15934985ab.1;
        Mon, 21 Oct 2024 00:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729497109; x=1730101909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CmjpMjU7ttB0glrLwMg+cLvPAEOZj5fmr050xTEtKE=;
        b=KodUtk5hkCbGPwf7jkc0MFz+1VXudPvkh8InwG+u/GjfbWzZlPZNqZ7jaREDi3HMsZ
         9co5H+kL5GZLoBcn3TybVOb1+Uex3zLhyryIYIR8tX0xGwBmdF5NVOXIdwextXlFW611
         UJdwPMLh18Vsfr2FHMYVcpZP7tU43pBBwdxjNDvXNZSs6foU3BhyHT283mSNHZIv2JBL
         KYgV58mxA3Pfxt6kYCxTfmvvnwyZzkva6P0pTNkPrzf+92QS2snUlepRgQJhYHG6TTQH
         JSC/1mD8EyI+A9/g3sIGfcd3EsuOzJTbftLJCDF2xX3wDbH2idzxj3osL0F1SoArbuae
         xiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729497109; x=1730101909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CmjpMjU7ttB0glrLwMg+cLvPAEOZj5fmr050xTEtKE=;
        b=fJr6JujllMAX7YCZi5BsDepG372hmAi/hrevURPGN+J7mjZovFt2fIwB1+y7ls0xhY
         sxPex7BYThRJoE/49ewuyA24wAgXnHviEMdyusJNzPkIwRGzxX8VO2g0hAgqfa9Y4x/l
         NRSbOFGDj+EHnloB8TxOk0Q4JxKIPxbeY2j6Ux24wJiEDEzsAe9AxGYUX32Ud8SDmd4l
         kXfZssSdpAGgoI0fL6Wa0a7aPmIlIMC0qCll1gtCCEIGrHsGcZRytuE2Ly7C0Lnvcx2m
         nfF10p53ZVGicZ7vrfqyRu31pYeZjMRG/UiC0e1a6ZFURylKyNY91ggkLAkG682sRejY
         WfJg==
X-Forwarded-Encrypted: i=1; AJvYcCXg6wY/64KLos5s4c/SDXfmKSMlMcVZDVWAj8pklzTESQuaQrPT93YgsjmYPsNC5A9VfZI=@vger.kernel.org, AJvYcCXkeXzWMamFQYF/5lRQqFdzZcDN5PBw9JlFv1ybtn3q/jjCQnMRGnHLJqAOUwk2K4Y9ynx/mahHiXwmnioIxH7s@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQs5k4DBHUph9XxgnGPtNtghZT7CIXNfwQeqCY6tqeQo22xds
	snObpmZMzUnn89+jSVnBYIi+PfgtHoBniCkguchorGalBvIWi8po34qRP0Awh98WCLbHdCFqAw+
	2lsO2kTjY1UsZy/eeWCEa8vvi9H0=
X-Google-Smtp-Source: AGHT+IFEPrBW47Jzf+rFn2mLqrSIJjPG0otqndY5wZj2jpLTJdsQq5txwJP+Msmfe7iG0MAWrt1yT16ZjWqt06Ct79A=
X-Received: by 2002:a05:6e02:20cc:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a3f40b1184mr87286955ab.24.1729497108790; Mon, 21 Oct 2024
 00:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021050706.29403-1-kerneljasonxing@gmail.com> <ZxYFn7fko5C9BnHe@krava>
In-Reply-To: <ZxYFn7fko5C9BnHe@krava>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Oct 2024 15:51:12 +0800
Message-ID: <CAL+tcoB-tHf5kW6Hq0TtsnqFLU3nWZEuZ+L7roDyJ0q_qW=WxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: handle MADV_PAGEOUT error in uprobe_multi.c
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:41=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Oct 21, 2024 at 01:07:06PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When I compiled the tools/testing/selftests/bpf, the following error
> > pops out:
> > uprobe_multi.c: In function =E2=80=98trigger_uprobe=E2=80=99:
> > uprobe_multi.c:109:26: error: =E2=80=98MADV_PAGEOUT=E2=80=99 undeclared=
 (first use in this function); did you mean =E2=80=98MADV_RANDOM=E2=80=99?
> >    madvise(addr, page_sz, MADV_PAGEOUT);
> >                           ^~~~~~~~~~~~
> >                           MADV_RANDOM
> >
> > Including the <linux/linux/mman.h> header file solves this compilation =
error.
>
> hi,
> strange, uprobe_multi.c even has:
>
> #ifndef MADV_PAGEOUT
> #define MADV_PAGEOUT 21
> #endif
>
> and '#include <sys/mman.h>' should be all that's needed
>
> could you please share more details (extra flags) on how you compile?

OMG, thanks for reminding me. The net-next branch that I compiled
doesn't have those three lines. Now I can see them in bpf-next. So I
think the issue has been fixed already :)

