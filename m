Return-Path: <linux-kselftest+bounces-9567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6698BD874
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 02:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3D91C22505
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 00:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844A622;
	Tue,  7 May 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtNluoYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D6F37C
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040893; cv=none; b=Jrr/RFPU1NnR76g28KOz240qWS14c+FpAEwovccF1d9uvwfgCGhh5wnrMb4cXqf2NzWv/tbdwyLhMbPWodQTqDYcOiB5CkKOtZEgWudZOwuStoTN3tO5awhVui9rG5RSvv64V3wj3RQRAfF5ebNdOS4px/Cm9XY1rrk9GVZdVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040893; c=relaxed/simple;
	bh=lu0OQIrcM30++N9sDEIpsDIcuzGB7E5UCYPW/qPlrfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwlKV4yd0Av+nVNlb0Kc2uJdhljdK2OAdsjfVoNd7uQWv1foSAaKvk6n9wuT3bg6kjkxPnHBFEyKFjlcD81Z1QCHAx65NS1ONDIu+Fox5Y0+VmHcVeafAbnEcCHJaQtQW0CIBB1M+vvc5tkHatGG29lbL92VY+cGKgvYCLssOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtNluoYS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso7175a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2024 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715040891; x=1715645691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8oWcFWnZBGCM1E5sWUM+4SbAQ1guZn75qzZz72Y3AQ=;
        b=NtNluoYSNsl4EIr92M4syUAOjb4lj+hBtxoLgRjoE45FQEmPwiwKqCFfj52kDRPvdV
         DQwVqVVG2RpFc37OA7q4lLqvA9W8U9choz4Wsoue2O3L+UzLboeMTAo8Tk8BmhO5gQi8
         k1Xd3z5Sx/0OqFBraIhe7aRWkRM1NH3q3gfvNfI2tmLM7tjC3jysak/5IJykgo4by+Jc
         ml6cqUn1VgJYiWniRcwM6mvqkovCdEszV0TsMfbCIGP8Bvc1nMyMKUDZBazn056P+kC3
         hK/GAZ4PDji8aNfjcfnUzRW+qTrmfZMjI7Qnq3MgDLVLaEf+1idRq/8iTBPHqi7iqidB
         6Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715040891; x=1715645691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8oWcFWnZBGCM1E5sWUM+4SbAQ1guZn75qzZz72Y3AQ=;
        b=Wlq0WgH1RYvZ/I2/I8LCbLPtDTRUIaYxXPk7kLW22FDCNnvshDIMwChQu0X/WXwFWa
         4FZqQ70EA3rTACE1Fi7qn/ZelHAUdxJB1yEg75EAH0wvbvT9xHtdC7IzItjUKJtLTt3M
         7UgCTNQrpmWkF8KBCmdtMgY7pzm2KYLKmegJSR/5HaBJ8tnvFwzioGbp8DgWOxeteBQF
         wX3yoHwvRIy+mZCLd1+JxvDGcsEKiJ+TZYwV5M24jSlCeir1OFKLtL960zo7hHdelhlf
         +hbYPdL1axMgzfPZkFKPJWiwJg1R9isf9bAzIEFO2xojR+yNyPDaM5xqGcEWdLU5Qzl5
         YbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU/guCaUwXHkXtgT7/Wf/enz9/OLHUVHsUkIFtlYJGHKMdcwoi6vPg5Agc5C4QKY6MYMywDJ/psTtrWBR5d4Qa/Q+GdGzBvl7LYlz9f0bN
X-Gm-Message-State: AOJu0YzeuT9HxWbuTrjraLYImUVfowMX8ZmFF4fSFAwAIZwsZlxVU1rJ
	O+2+f2MdFL9TjnhjuvUxxnw8xZMQO3NSlZ87rtUKU23TnSROs2nipu9NvzsreiK62I3W7Dg3k0R
	1jBMMFPAQC6GMX+XIRaY7e+8xYsOYYPyvXja9
X-Google-Smtp-Source: AGHT+IE15l4LDBVGhfGcDhfoCmROQP28ylvV/hj/rCXLLp9j4EClG5UA1ylJkDneYk8xq7WPhDsbgZ8lCxp3B6gC3v0=
X-Received: by 2002:a50:cddc:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57311e083efmr96122a12.6.1715040890499; Mon, 06 May 2024
 17:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152831.3199999-1-usama.anjum@collabora.com>
 <202404161027.63F4D4FDEB@keescook> <CAFP8O3Jjkh0U94CbS=epXELMtCBpYt4fGejX3spH4=GdF7zVSw@mail.gmail.com>
 <202405061704.DD3AF674@keescook>
In-Reply-To: <202405061704.DD3AF674@keescook>
From: Fangrui Song <maskray@google.com>
Date: Mon, 6 May 2024 17:14:36 -0700
Message-ID: <CAFP8O3Kx+bVCVQpQJVBrPkjrQO9d5rdcxGGP-Jn6t_Mpc995RA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: exec: make binaries position independent
To: Kees Cook <keescook@chromium.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, John Hubbard <jhubbard@nvidia.com>, 
	Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yang Yingliang <yangyingliang@huawei.com>, 
	kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 5:05=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Mon, May 06, 2024 at 04:30:27PM -0700, Fangrui Song wrote:
> > On Tue, Apr 16, 2024 at 10:28=E2=80=AFAM Kees Cook <keescook@chromium.o=
rg> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 08:28:29PM +0500, Muhammad Usama Anjum wrote:
> > > > The -static overrides the -pie and binaries aren't position indepen=
dent
> > > > anymore. Use -static-pie instead which would produce a static and
> > > > position independent binary. This has been caught by clang's warnin=
gs:
> > > >
> > > >   clang: warning: argument unused during compilation: '-pie'
> > > >   [-Wunused-command-line-argument]
> > > >
> > > > Tested with both gcc and clang after this change.
> > > >
> > > > Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error"=
)
> > > > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > >
> > > Thanks for this!
> > >
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> > > --
> > > Kees Cook
> >
> > GCC versions before 8.1 do not support -static-pie,
> > while https://www.kernel.org/doc/html/next/process/changes.html says
> > the minimal version is GCC 5.1.
> > Is this a problem?
> >
> > If not, and CFLAGS is guaranteed to include -fpie/-fpic/-fPIE/-fPIC
> > (PIC), using -static-pie looks good to me.
>
> Should we use this alternative, which may be more portable?
> https://lore.kernel.org/all/20240504022301.35250-1-jhubbard@nvidia.com/
>
> -Kees

s/-fPIE -static/-static/ then it looks good to me:)

-static creates a position-dependent executable.
It doesn't matter whether the compiler uses -fno-pic/-fpie/-fpic
codegen, so -fPIE can be removed.



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

