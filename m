Return-Path: <linux-kselftest+bounces-39817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C279B3341C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 04:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6664416BF2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 02:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E5F1CEAB2;
	Mon, 25 Aug 2025 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHj85OQ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88C38DD8;
	Mon, 25 Aug 2025 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090429; cv=none; b=NcoEVDiUSZGuVbkxaqZrin9v34MAKXwFgCrZT0ycN1FJYlBfMl8DeqHfji37tdH7is6k18hqeh1tEMxG6s9Uzd7MHE9EYs0E6GK+sYIZxw3bZ1wmm8Ui4UMK6AZrBQD+NtERagPw08dtdGCWP7HKBvk6o//A1fm6FeClA3XNr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090429; c=relaxed/simple;
	bh=AKXdzx3iGv0Cdlf3syAes3VVjlT9t9y5HamF5W7AGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGXPHOl9owSulMEk9S+xSeZW4XG7vWOioi9qHTwYSXbI3PSQdvivC2UooduLRGTj9h6uIDDfsiObivftsVR8GPAFz2XqnSFtks/LJKHxHVfUHcMxvsOSbu13r5rlE+qgdduHafC0wWOiZHaFBKKH+3R3SshOUfQcFpqMwtUC4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHj85OQ8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so5741227a12.3;
        Sun, 24 Aug 2025 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756090425; x=1756695225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuQEOF8lXWx0tyN0E34X9QSFDbgyKnv6vJT8/V1kPN8=;
        b=RHj85OQ83igf0JodNDTuzl+McNt08BjWQr1xqZAKqTTheujqJdJzg9+DidSmaUWOUn
         khJYAou/0AKhDeQuxS1dNC1Vh0H0EsSqxoNp2unN/k3EQtue4Gi+SqE/GSbmfKDTMrWb
         kiuxpR45fYIfqpUgAW3WCOp+eAiz7HzQdTZyD4W8gkx/Yyx26RnRt/iLTRi6JYNuk5q1
         K3IAoxlr8iGI8JsWBGTma04g49cfYvYtCGZOrgfxTpmnFrlHmYq918V5xDpziS0k+x36
         4p2xYv2blaWd7TfkcCwPibmPLMCch1t9pPDH5IlqysMbnH3msMq4oRpR+iaJh5DUmibv
         VUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756090425; x=1756695225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuQEOF8lXWx0tyN0E34X9QSFDbgyKnv6vJT8/V1kPN8=;
        b=fZEwnhpKI1IpFZ2+uPfdHdNiXCGtgeKCQTEpGHHW5Zu+PHGL668ugrsTEzwcvidH5b
         ptHGahHYwQa4PmErR5m/HoLuVIQRmzLBRlF1fhZwwr4vWTRJsWfX9FVlC9RGQzTS8IF+
         abp+opQAvgKEUS2w6AzZiStoeZWLgrFd8XVYmorzBD0JDSiIrUtZGgx3D0wqOcj2dhvA
         5xhsUSJVs7SrnSBDnU+h2zYAfnxCy4PTwa0yDVGyBFsuV38hJzHZrZQWaAHY+mlmG8BX
         nAQWv/rt1/1hFM9hH1Qj9k8AoRSqFSvwfZ9AQgHOz6T/j08jn/tTtpib5UK2pvVAwudK
         gwAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMP+Uj9EcVImlmYopHf4GKHXXqI7pRlY481dsp9opWwFpPCMYBh4dVfGY9gwAZWMig2mclfmpMbkMY3Ic=@vger.kernel.org, AJvYcCWcvNa6Jhss/RmN0e9BP2SIrX+9ryU7euFAnVEQRDSRwHPQEKE6I7UeX6uwfbl6jvCkt7gBLxOa9OJ+BWm2KodI@vger.kernel.org
X-Gm-Message-State: AOJu0YxNF0bCqNzuU665NE52U/QpWLy9zqcWnNu9xwCfkz5SxHpK/QwU
	PZdPcuum/8+QRRYYfe08dkeTJzA+WiKd1iwPGSb7Dg6EMwOUALbZIu4ipN3Khr4eLkXThKwnl3m
	/pNP1D7XY4Wv20Eu9isVvHSyU0unynEk=
X-Gm-Gg: ASbGncsjl++kHPVqIchtAzmBA5Ph9+7HpQ8pknt/klx3MGc5weMeRW5IGd33mY5sHc2
	Js7uUHHDrToU+0BWDUHb42hguxz2hgBa7x/buaDSYHhom8bpVLE9pWb7hid++/Wea2a4i2+yPzU
	70+T7Nnre2PYqoaEcwNDGt1RGyjUkC1VV0cMR6xl/bCbeY9OxAW0i3IzRnLV77RWJqtblEGzUph
	YIWTcWNgccrfoZrhsQxehxuoVBbgK1FeE9pY9/Jjxk8dIkfb2gF7fJLCZO7pDwHuEtl+yAuPg==
X-Google-Smtp-Source: AGHT+IEU1FlX6VqgN+0TONBTh6JTkrbGtb1BTJ7rjrRMKFIkmyRa22u+pADcYFGDkQRMTM+s2m7G/3I2ftjPQejby5g=
X-Received: by 2002:a05:6402:27c7:b0:609:7ed1:c791 with SMTP id
 4fb4d7f45d1cf-61c1b6f5a6amr8602984a12.32.1756090425106; Sun, 24 Aug 2025
 19:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823170208.184149-1-allyheev@gmail.com> <aKq25rlqbyYDaWVo@pc636>
 <20250824171722.ea915592ea3bd060c6b17a38@linux-foundation.org>
In-Reply-To: <20250824171722.ea915592ea3bd060c6b17a38@linux-foundation.org>
From: ally heev <allyheev@gmail.com>
Date: Mon, 25 Aug 2025 08:23:33 +0530
X-Gm-Features: Ac12FXyys5mnbxszcX8Pac2LI8BHvZ5qDrWuATBA5w2UNc7UXOxjIJmIvIcS8TQ
Message-ID: <CAMB6jUH70j20WgJ9TD=Lsy21XktDG0PqxEgjZ7XZFvcus9SjkA@mail.gmail.com>
Subject: Re: [PATCH] kselftest: mm: fix typos in test_vmalloc.sh
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, skhan@linuxfoundation.org, david@redhat.com, 
	shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> A changelog would be identical to the subject.  checkpatch is being a
> bit excessive here.

Yes. Hence omitted it


On Mon, Aug 25, 2025 at 5:47=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun, 24 Aug 2025 08:53:26 +0200 Uladzislau Rezki <urezki@gmail.com> wr=
ote:
>
> > >  run_stability_check()
> > > @@ -160,7 +160,7 @@ function run_test()
> > >             usage
> > >     else
> > >             if [[ "$1" =3D "performance" ]]; then
> > > -                   run_perfformance_check
> > > +                   run_performance_check
> > >             elif [[ "$1" =3D "stress" ]]; then
> > >                     run_stability_check
> > >             elif [[ "$1" =3D "smoke" ]]; then
> > > --
> > > 2.34.1
> > >
> > >
> > ./scripts/checkpatch.pl ./0001-kselftest-mm-fix-typos-in-test_vmalloc.s=
h.patch
> > WARNING: Missing commit description - Add an appropriate one
> >
> > total: 0 errors, 1 warnings, 24 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > ./0001-kselftest-mm-fix-typos-in-test_vmalloc.sh.patch has style proble=
ms, please review.
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > Can you add a commit message?
>
> A changelog would be identical to the subject.  checkpatch is being a
> bit excessive here.
>
> Oh well, I'll add the obvious text.

