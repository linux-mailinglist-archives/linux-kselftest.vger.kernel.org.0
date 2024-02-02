Return-Path: <linux-kselftest+bounces-4031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A1A84770A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 19:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6445FB2D494
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB314533A;
	Fri,  2 Feb 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LtKFdmnu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1114AD30
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896747; cv=none; b=YogYhYNPPUUBvWrWaNCphJ/OnRYwKeAgaRGhccErfyv5dF+2iSBn6+UCIvwrYyVVRicpFy9T6bH0V8XisKlgQH/UFesSuU+v9LdU5UuISQMnuztNsVSY0gzGozz2Ynyte+1YDsaZIVuy1kmO0u1vfSOz/oBBgTQmgAqMdGc+C6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896747; c=relaxed/simple;
	bh=b0UK3I6qBl5XLXZ/ULBInBz/ydG+gAjVS2eKkSAUwuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eu53vZEb5fSGSRfjw0VAngVBcVJVudV/S9+FBooUKidJ7/VfCkJ9/CgCCfA4W5fbvaNFqRLTNFP6oTjhnRs+AdMrxzSr7PkDgQlBmbj3AIOE5Yqkb06YVpPbXe9YeTO7HnG0gDxO1+aBQx05WwluOwMvUN4tbj5m8eQ6lo7YL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LtKFdmnu; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e117e0fee8so1253010a34.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706896745; x=1707501545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3MyFHdGuJXKIHAocH1cP+k+k6xBW4irfqW7F3umGsY=;
        b=LtKFdmnuA9zRYggzAzNUaUaUmyKVOrU3o7RbDHpumwWHWdIWt3HRxK05zC1yAXd5Ic
         d0zcKrDc9vE0iPxnps/sWZLyewDKkhPCIJxhubQl3OmkdoxfE+xI0CB13/ZZIanxtW+k
         Z6muAVLps3zZZncPOFwtUaVHPzeXiGn7dKyZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896745; x=1707501545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3MyFHdGuJXKIHAocH1cP+k+k6xBW4irfqW7F3umGsY=;
        b=NXtCmY0RygSidhoxzxDLmfKFnnvJ+JYHfHOH+J+tgnJ6sCt9J+09cg7QGtq4lXg1jm
         yjvfalZOXdUc7o8EcKMbKiq87lkXS9/OfYBaenLBuGMr/1Q+m6nkNLsvTN9ZN6YIn2ac
         vbb32thWqwsUGXruhXBRMDFHpy3Wgj124O1tDhvcrvbI9eshrHDa0hTQlpWSkHRyTEyD
         OkVhVYtu190BeVGt2SpKWDibbWyPOR/CH4F6Qtr+Yeex/y3Q7D6SG9IK45ep2haSCw3l
         SH9/KhyBmkCvBas5tjwPrE/cIm+cnI5A6tKEn0x86idstdss5RSEELaBmkGuk1LKe2Rq
         j5SA==
X-Gm-Message-State: AOJu0YwPhyhsNY8f9VPquUCjkkE4jwzqp2r7r8VHUjFI5McUwOIYHEnc
	uHsGkR247Domm2aNZ0qEOV+SOq0qReq2XuqXVn0FZrdzjfX3TL/S6AGCAzpuB7K+A3rcU6a83KM
	dq44ATFwYuSPrUXzh6TOffLNeCg7DDi9uDvj2
X-Google-Smtp-Source: AGHT+IGpU/xeyR4Cac3EmRCRvgJs1LUHcLu+M+2J4+z8SyoU1mY+7pncKYINef4x09GNaY4SUrFEJxNBeJFX0e+aASY=
X-Received: by 2002:a05:6870:200b:b0:218:eff8:3161 with SMTP id
 o11-20020a056870200b00b00218eff83161mr487923oab.39.1706896745307; Fri, 02 Feb
 2024 09:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
 <58408.1706828083@cvs.openbsd.org> <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
 <CALmYWFtqcixi3p3Ab44wENJr+n2k2SNaCJEofNm_awnNdJZnDQ@mail.gmail.com>
 <8744.1706846710@cvs.openbsd.org> <CABi2SkWSt=UMFWe9n916ZH16wCzaipKXmEJ5VasQHMr1AxerxQ@mail.gmail.com>
 <29248.1706850035@cvs.openbsd.org>
In-Reply-To: <29248.1706850035@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 2 Feb 2024 09:58:53 -0800
Message-ID: <CABi2SkXPNPKgqheuFuQ9iZApQkJm8o6bypNn0B-QDz_W9b0JBQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Jeff Xu <jeffxu@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 9:00=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org> =
wrote:
>
> Jeff Xu <jeffxu@chromium.org> wrote:
>
> > Even without free.
> > I personally do not like the heap getting sealed like that.
> >
> > Component A.
> > p=3Dmalloc(4096);
> > writing something to p.
> >
> > Component B:
> > mprotect(p,4096, RO)
> > mseal(p,4096)
> >
> > This will split the heap VMA, and prevent the heap from shrinking, if
> > this is in a frequent code path, then it might hurt the process's
> > memory usage.
> >
> > The existing code is more likely to use malloc than mmap(), so it is
> > easier for dev to seal a piece of data belonging to another component.
> > I hope this pattern is not wide-spreading.
> >
> > The ideal way will be just changing the library A to use mmap.
>
> I think you are lacking some test programs to see how it actually
> behaves; the effect is worse than you think, and the impact is immediatel=
y
> visible to the programmer, and the lesson is clear:
>
>         you can only seal objects which you gaurantee never get recycled.
>
>         Pushing a sealed object back into reuse is a disasterous bug.
>
>         Noone should call this interface, unless they understand that.
>
> I'll say again, you don't have a test program for various allocators to
> understand how it behaves.  The failure modes described in your docuemnts
> are not correct.
>
I understand what you mean: I will add that part to the document:
Try to recycle a sealed memory is disastrous, e.g.
p=3Dmalloc(4096);
mprotect(p,4096,RO)
mseal(p,4096)
free(p);

My point is:
I think sealing an object from the heap is a bad pattern in general,
even dev doesn't free it. That was one of the reasons for the sealable
flag, I hope saying this doesn't be perceived as looking for excuses.

>

