Return-Path: <linux-kselftest+bounces-38964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A596B26561
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 14:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD069E8333
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4762FE042;
	Thu, 14 Aug 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuMezp6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A21F8BD6;
	Thu, 14 Aug 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174558; cv=none; b=IYu+W+0IhOtXENjlecswJQdh9iIG8QWfGdE/wMs/Qx394EGp5st/sVauila1r/p8zRjw+kILoX0vVmlH/3FaG7W0jr1WmRjYuzj4mks9Jucz3G+p3ZA3fWRwBpAKTdxccMCXFFyglp+Vo+HWR+1Y3v8Gl3FpRvCgDstgvD2/UTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174558; c=relaxed/simple;
	bh=rO57oBgut8MLaOzJs0p+XeTS4dLzPzn1ceaz8hkxa9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e58wjT3G8dL4UWYem69ja0swVhTzP+33Rpk7Dvyl7fCal5qsqSxCi1kOhZMiJbwiduhxWPYLiTXn5KxMuMR+FFjF6aMHrIat7NiyxWSN5UddT2ML5dCypPOJJ+J8ptAAG+sNMkkt5W3+3ZEY4GrNO2I9beBRjTD8EEy3i+wvdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuMezp6O; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e931cc4c572so846426276.2;
        Thu, 14 Aug 2025 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755174554; x=1755779354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9nMkqU8lfgV6BG9eQtddTrYU3f2ABJUvKOLDHRPKLM=;
        b=XuMezp6OYRsBVMIGyn+2NG0AvNpg9oWEYpawPc944lD5XB/31RZhkm/K6so9X2H46A
         Gx0jgFBxKgLcAZqDpM3ecxmnBTmj8Ua2Fa8q7+TML9JxDGgE9ctYMEMhH1EAyKyCAQFg
         HhVWFs20mPR5mxC94+Fc42NGkMcgah4qyaK8/8TUkw9Zo7EGgF8XCm22yN420XtXUVIx
         +WL7yyPjs5H+PZpbRTAIfYMhXfBnFvgK9QmpiXhGLPM/bb7K5Q1MHzwim+7UpRwCUNvT
         t5LCgrw4vHJoqN7L2rlZOZxhw2GLfoN5SOqk/G1r8od6wGppSo2NcLtM2sbP2BcF+2o3
         IwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755174554; x=1755779354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9nMkqU8lfgV6BG9eQtddTrYU3f2ABJUvKOLDHRPKLM=;
        b=J/a1JnLPR8qLgaaff82rhEDwv13C1ejI/P03SvMmcqL3BlS5aD8Gfc8bVYI0efQPJP
         bdQLAUiIMydMbadM1Z4lf4ByhwWvWJRmlCPyqKoDxMxSATgJ3IvJA43rc9uRYHpe7+Gj
         GyTN8fIlclK3N8ocljEOIgqppfyXrFJj7Js2gSNOd72QZvcnaqGlsjxisStkBp6/KfdF
         gWzmIvgTqfzyHhUgyBU94G4ep/mLYbVw3GOVYa1p1vov7BbwsBNI1c/fXnyWq9t2Rb4R
         rVgtM1uAlge7uiKBG3wTDGBzjB9KNTh2e7e2PrCTYKHLszwQDkZm3XYGSoqlyUVHRlCC
         4b2w==
X-Forwarded-Encrypted: i=1; AJvYcCVUhChfEhOIrxHzQipzNWx/M5I7vBGoHhrFAhxTlxUCZL+L8Wfki1KZQSI1qKN85E+8f64DYJkUolxmMBXCPSD+@vger.kernel.org, AJvYcCVlEbmfykLgUjbgwNoV4C51R4JLiKycxEyoXx8RYs/mmtRSBi5cwEbWo5w7wedPL7ulVxk=@vger.kernel.org, AJvYcCVlbMhxLyCer8NRVQCBctw7UDFRsEsLczzGbbZGfnVErvxHrtSinHmKdeTBQNdwSPID3SDHG428AGaLNjQy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2WZCDDNm5IXIAXSwegad34mHL9phO1s2vz0x0yMOfkg57AEL
	B8/VN9wckkHgrD4t/Bz4EaLTiuRYsrE7j76JU7eLYzHK1BIn+5bWg/NdxZJzPDVk0G7ko3E7Zfa
	ZxhC1EeuaziUbIftGC9+vArp/VVC2nXQ=
X-Gm-Gg: ASbGncumJJ0dIGpkoCwIxyWBw1Gm7mG+qMQQNeeIrmhGLIubIR7wlZBz6KYv7CwkjdA
	e37M+cY+Hf/sbu/SXKkn95VhGoExMkX6RxGt7/QkcX/xJV0MRnuuIUTZ4ezciHi5M6OMFut9NhG
	nECgFBoI/kYo6yU74wSdF0zk2dHVQrwTeSFhQ6Jx0Tv0EiL5HEh4T91deMo8Yr6VrLDWNpqu5uY
	2P38lerag==
X-Google-Smtp-Source: AGHT+IGE1gdLemrEH2Nj6lqz+g07DOtoHK3C3EWMG7OQAmimyaEJ2F2fKwl/j9fdVwM4pcXtaqsv6Ug4x1GQNBC/JZs=
X-Received: by 2002:a05:690c:4b84:b0:71b:6703:b710 with SMTP id
 00721157ae682-71d6360a216mr38415977b3.33.1755174554524; Thu, 14 Aug 2025
 05:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812153719.36465-1-slopixelz@gmail.com> <CAEf4Bzb47GuSPEjbA_dJON94Dw4JKzpWvR+qm4QQW2p+0z1rSA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb47GuSPEjbA_dJON94Dw4JKzpWvR+qm4QQW2p+0z1rSA@mail.gmail.com>
From: Shubham Sharma <slopixelz@gmail.com>
Date: Thu, 14 Aug 2025 17:59:02 +0530
X-Gm-Features: Ac12FXwXgIiKCr7IO21rjznlSCQbU2rxOpaUtZl6pcdj0WUBpnNkmJVevSs19bk
Message-ID: <CAN3jmPQ2HfxVoFg_Jpif3EbjAtdii1hrnRzvC58skTBu=+ZGbA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix typo in kprobe_multi_test.c
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 3:35=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 12, 2025 at 8:37=E2=80=AFAM Shubham Sharma <slopixelz@gmail.c=
om> wrote:
> >
> > Fixed a spelling mistake:
> > - comparision -> comparison
> >
> > Signed-off-by: Shubham Sharma <slopixelz@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c=
 b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index e19ef509ebf8..f377bea0b82d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -463,7 +463,7 @@ static bool skip_entry(char *name)
> >         return false;
> >  }
> >
> > -/* Do comparision by ignoring '.llvm.<hash>' suffixes. */
> > +/* Do comparison by ignoring '.llvm.<hash>' suffixes. */
>
> Is this the only typo in the entire BPF selftests? If we are doing
> single character comment fixes, let's do it as one bigger pass,
> instead of tons of tiny patches?
>
> pw-bot: cr
>
>
> >  static int compare_name(const char *name1, const char *name2)
> >  {
> >         const char *res1, *res2;
> > --
> > 2.43.0
> >


Thank you for the feedback. I understand that small, single-character
fixes are better grouped into a larger patch to avoid multiple tiny
commits.
I=E2=80=99ll review the BPF selftests code for similar typos and send a
combined patch instead.

Thanks,
Shubham Sharma

