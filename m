Return-Path: <linux-kselftest+bounces-18175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F058F97D869
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79441F22C5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E8817DFE9;
	Fri, 20 Sep 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGIwn20b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0601E517
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850254; cv=none; b=TASal3epO0VtVWRUNpzFhgm8MH1hqaE/0IpVSYA27t07FTByb2znLWxQwZuOh8XYVbzyAzg0GAWNLGPkTbUqpPjop68LWZu5U1A5ywGx71n2RnZJPZVexTYm2VhffGZGRsTk/B3cDzPhUoU5+lB5AjX0EAsVGw01bjOJDe08Vns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850254; c=relaxed/simple;
	bh=CLdeFhcXjFW/Rn670pgZvMahwb04Xg2afg6QSLEsW9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeX2CdQQxIPD+3KOGaOef363KiQpmWDa5aBfiARBWiVm84z+Uppljg3LrQNddq6GtfZl8aSPBPbb4QifWsRNRJVIqOqD4d+gycARuOUkTxm+2SP7470992u+xbLDdCL49PcBBTX8TJqyxveIhE4X7gXsXaI7NX394H1RN+h/FwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JGIwn20b; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db3763e924so223936b6e.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726850251; x=1727455051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeUoiC4xV3CiCxio8wPUbYZ9DxOg+zY+E1xCmjqF+qE=;
        b=JGIwn20bV1Jl3+RqvTu6eBnUUzjlhm69/EXrjM1sItTAwffQkPpUm2xD0+k/P9zNEU
         EcrkwBbhaTnRZGqj1CjUveQ68nYirkXhWFqXVmnLNAGOacknExPmHBQouGr+aAwVMwov
         ULan7rNbT5Bmf+8sm1xkHP7+epfKPqeqbiGS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850251; x=1727455051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeUoiC4xV3CiCxio8wPUbYZ9DxOg+zY+E1xCmjqF+qE=;
        b=KoRhI//t6lT3AMJK0PufQuBLhxRBgVjw2WC3qVR86QVLege1HfrVmw+EUCVh6t5cnK
         67k2NM8xTaiLFyOqLWr6gxUsiXmNUEEEtBReskKIj4MqqtWwqAqdTs4oyWCjDMznjiYP
         tw0zTiZh1c11hy59ai9ehqLD/r+Rj5c9qRIUFOeSUdh13Nl7xcHLE8bojLM3SrBJlMKF
         uOpGI7QSLH+jiwKr8wUGMvgb/I+w8puDyXQ9J1HRMrDINxLwa0kfb/uonp926J4BKBlv
         IgNba3yo8EO4MDVme+KJtvWHXiRsyV4FS6wu4ET/RtAC4UsLVKQ8ULzQDyVyzn+7H/j4
         iO1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnu+Z/NG91wJDwt5o1V/GKshfRtjxk43EAfs1FDQvU6NaTSBmgW/xyGVctHHVcp+5MX8LTJ8iopUk8SrF4l+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybrz1rcgrEEPBmj5J2/A8nTulBRre7gKMDtPR3z1QBRNiNkF9M
	xf/0YurbupiZTcWX9udJLfq4Ku9cXXVCbmxEJ4tbWx8i2bqlOrLNq4VIbbhGnyXYqBXHHUxcybJ
	LSk6nQQskjN0Jc/6/r+2b6lX6LH9L6T1F9Xgf
X-Google-Smtp-Source: AGHT+IEgc6oFjG/AVNeyCwNJdiZ7/4I53v5fqxBfmjiWXrV2OLBvKIkIyisPGyrs125247P4H7Q2d819NzxIHSA2I1E=
X-Received: by 2002:a05:6870:870c:b0:277:db1c:7c6a with SMTP id
 586e51a60fabf-2803a62c744mr749865fac.7.1726850250833; Fri, 20 Sep 2024
 09:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830180237.1220027-1-jeffxu@chromium.org> <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local> <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <ZurTHc1C27iqofjp@finisterre.sirena.org.uk>
In-Reply-To: <ZurTHc1C27iqofjp@finisterre.sirena.org.uk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 20 Sep 2024 09:37:17 -0700
Message-ID: <CABi2SkUQM8girk31jDYMfx8kVoG0xXMwaSDWmu90b4ZmtdmHHQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Mark Brown <broonie@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pedro.falcato@gmail.com, willy@infradead.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark

On Wed, Sep 18, 2024 at 6:18=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Sep 13, 2024 at 03:50:00PM -0700, Jeff Xu wrote:
>
> > Even though the number of lines is large in these patches, its main
> > intention is to test Pedro's in-place change (from can_modify_mm to
> > can_modify_vma). Before this patch,  the test had a common pattern:
> > setup memory layout, seal the memory, perform a few mm-api steps, verif=
y
> > return code (not zero).  Because of the nature of out-of-loop,  it is
> > sufficient to just verify the error code in a few cases.
>
> > With Pedro's in-loop change, the sealing check happens later in the
> > stack, thus there are more things and scenarios to verify. And there we=
re
> > feedback to me during in-loop change that selftest should be extensive
> > enough to discover all regressions.  Even though this viewpoint is subj=
ect
> > to debate. Since none would want to do it, I thought I would just do it=
.
>
> > So the Patch V3 1/5 is dedicated entirely to increasing the verificatio=
n
> > for existing scenarios, this including checking return code code, vma-s=
ize,
> > etc after mm api return.
>
> > Patch V3 3/5 are for unmap(), during review of V2 of Pedro's in-loop
> > change, we discovered a bug in unmap(), and unmap() is not atomic.
> > This leads to 4/5(mmap), 5/5(mremap), which calls munmap().
> > In addition, I add scenarios to cover cross-multiple-vma cases.
>
> > The  high-level goal of mseal test are two folds:
> > 1> make sure sealing is working correctly under different scenarios,
> > i.e. sealed mapping are not modified.
> > 2> For unsealed memory, added mseal code  doesn't regress on regular mm=
 API.
>
> > The goal 2 is as important as 1, that is why tests usually are done in
> > two phases, one with sealing, the other without.
>
> That's vastly more detail than is in the changelogs for the actual
> patches (which are just a few lines each) or the cover letter of the
> series.  I don't have the MM knowledge to assess the detail of what
> you're saying but I can't help but think that it'd help a lot with
> review if all this detail were part of the actual submission.
Agreed, will update and give more detail in the next version of the patch.

Thanks
-Jeff

