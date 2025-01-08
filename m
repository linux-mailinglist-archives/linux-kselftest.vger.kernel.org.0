Return-Path: <linux-kselftest+bounces-24067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48679A061E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 17:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955083A48FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E511FF1DD;
	Wed,  8 Jan 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K8NiHqH6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ADC1FECB0
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354058; cv=none; b=WGx7i3o+lKtdVBP3uxNudU3cm6mMPmpheh87iO+NbXVDKwWk3ObM0sqFXXbRq/kkAnZPAMNOU9Dt0N5zb1WDNzW5qb3zIUOUXIa0WEeOhIf80kaaVUsKxPvNvIDOKNxLtMbmRJivdFEBsPRugJfv7AysBYfTS9u2WMGm4/sff9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354058; c=relaxed/simple;
	bh=D0a/y9S0iQvC9p96QDq/76ekUZ8xj6YnYbAAwe6twA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvOc/VDbXgm1CJcQrPD15+Ul21j5HFcmDPyl8kHoGIK/nnInt5TCKct+M8x/FKZ+WxvA22HV9bWqzDWOT5keGX7VqG7NUcDoQNOvqGBZXvbriEmo6Mc8+7C4Xv4W4HRgMXPppf2ZQrXjV3+bCHFkiEVdu+kZ3POOFrh2uYp/gbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K8NiHqH6; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb8583e9f0so1122167b6e.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736354055; x=1736958855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRN1UZXW+9y9bwtzVbAgnIz/GGI8nLUdXC+YXanAzl4=;
        b=K8NiHqH6z/sm4jqVFRC2rMh3DL2GrcuB1QUtkX3XMGFQjC7Mz12fXXO9NGoTjqvAbH
         nVeLccDWBI8odOg4oRrwRuSwgR0FTqxrBdIeuoEJnQRxm2Bo+SnUPz8HmXf3x0sZ6ogs
         t/NkU+dx4X9EKLnsm6EEBXDgq2DD0T14sIDV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736354055; x=1736958855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRN1UZXW+9y9bwtzVbAgnIz/GGI8nLUdXC+YXanAzl4=;
        b=w/iH2RUIesQMdIQvH3wKBV9X+4WGrjw0AfwyLcCtVujdA6GyD1szk+hgVgdxIrpLL0
         4N4lvjeTYdqPiLKQbcdEXp5lsOVsKEP8eaancPiDgl+cv6EZZ/cnbWdzbVpxzaCTcZuA
         b3TL0WJUMBTiH6fvuZJBmh5VOiKe3BlrUE6WzmKIKAupA6F8PeUR5t3LhItmqdcqcokj
         2wc2uOaqbxJl7jGZs8hjoccL6JWHJMtu7n9L1gfnxOXDwZxALNd6APA/Pr9MOwoQFxmq
         ZHQfjwQ63aWMaDwGvZxVc+3dcNHXe1ZrBW1x4cuCi5UctD18zz+eTA3Ev3sxNKcdOKfI
         Js+A==
X-Forwarded-Encrypted: i=1; AJvYcCU+4aHPL0nZ8zxb+qk4yTxeT79fN4XlzG2eG/5YUMN+vmStSx9CqkkR/YfxOKPOnOog7AykkWK2KQRzLerXeak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxCteYVF9VqvOU2ZzDAdUSP2SKpi/JKBOHQx3V6RaIBvBnTAb
	ufPMyDaFF85id0J9lMDc3Y5/HfsfTlpxHRpzOXnADOB/7t+CDTZ5DZn/KdEdwSSkfIl0Qaw29PA
	0SP9MMxIVwMzujSfYZGwlcgdHJP/97+WtycqX
X-Gm-Gg: ASbGncsOvViHwnlxyVWAH9/YedGOVDdY0vIKc5exMkB3/6flG0AoKwxMthbWnfkns6M
	pIkIUOm/RTFJ9+Ey+QDTqZSJ2SzIiE0SlyWHnV+boHUv3rk01/n7uCOCIQ96vj0DLFrHTkio=
X-Google-Smtp-Source: AGHT+IGvmvYmHZlOKCsOlXjEJdILvND0Wn/bJ5GVMojqs1mv3cAEAWLd7eHHRza+Uj4LBSfncn8YTrDkHdIwKCYXuok=
X-Received: by 2002:a05:6871:67c6:b0:29e:79ce:933a with SMTP id
 586e51a60fabf-2aa069741bamr674062fac.12.1736354054648; Wed, 08 Jan 2025
 08:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com> <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
 <CABi2SkVmdxuETrgucYA2RucV3D4UoaPkDrXZKvLGjfEGp1-v2A@mail.gmail.com>
 <Z3yCzcpTHnW671WL@google.com> <CABi2SkUVZKjtGCJ+rvYbma4OGY_zQP2U3KtPjqVNMnAfoHxYDA@mail.gmail.com>
 <CAH5fLgifNkTFTVHbsp7wXBgRQmXQ3+r3xD03bZq06gU7eOfDOw@mail.gmail.com>
In-Reply-To: <CAH5fLgifNkTFTVHbsp7wXBgRQmXQ3+r3xD03bZq06gU7eOfDOw@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 8 Jan 2025 08:34:03 -0800
X-Gm-Features: AbW1kvbIBhyW0pAreSQi_woM5Mu2LF0rK-L1LSYwv4FWA4jHvElknhVchu7Sv_o
Message-ID: <CABi2SkWWfknibhP6KV16gbGH+Pj4kJC9JGUVaoLHyAwdxoucug@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
To: Alice Ryhl <aliceryhl@google.com>
Cc: Isaac Manjarres <isaacmanjarres@google.com>, Jann Horn <jannh@google.com>, 
	Kees Cook <keescook@chromium.org>, lorenzo.stoakes@oracle.com, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, surenb@google.com, kaleshsingh@google.com, 
	jstultz@google.com, jeffxu@google.com, kees@kernel.org, 
	kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 5:57=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Tue, Jan 7, 2025 at 6:21=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrot=
e:
> > Do you know which code checks for VM_MAYEXEC flag in the mprotect code
> > path ?  it isn't obvious to me, i.e. when I grep the VM_MAYEXEC inside
> > mm path, it only shows one place in mprotect and that doesn't do the
> > work.
> >
> > ~/mm/mm$ grep VM_MAYEXEC *
> > mmap.c: mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
> > mmap.c: vm_flags &=3D ~VM_MAYEXEC;
> > mprotect.c: if (rier && (vma->vm_flags & VM_MAYEXEC))
> > nommu.c: vm_flags |=3D VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
> > nommu.c: vm_flags |=3D VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
>
> The check happens here:
>
> /* newflags >> 4 shift VM_MAY% in place of VM_% */
> if ((newflags & ~(newflags >> 4)) & VM_ACCESS_FLAGS) {
>     error =3D -EACCES;
>     break;
> }

Thanks for helping !
-Jeff

>
> Alice

