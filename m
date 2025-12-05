Return-Path: <linux-kselftest+bounces-47130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C8CA8AA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29DDA30EF1B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043BF34F490;
	Fri,  5 Dec 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngrO7crZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F82D949C
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955909; cv=none; b=d0GPqBljWPuaLOKmAooKcaZvOI8BESqNbTTsDywmg6QK3/cNqUUfmQf14Eo8Tj0z6fyK6f0Wz1dEpbQ3CmMsHkknG+G5AO1a5ljnJTy2jNLLVPGaJsZHAIwiVHWcmlqgPCFzlo/PcRMHNiyKFPPxPaIeLIY3e+rN59H36tHeEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955909; c=relaxed/simple;
	bh=e9CoZSp8ppByynofzj4R8fDqOU91q19IDQEVdfN/Rho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHnp/LYYS+qRuYLZ/AWDeTRHtfm5kBz2Fzs6AteJN3ZcpudC+BDNkCVbY3B3l/GzRVGp8R0qhpefUVc0CA/vK1b9ZJJQL7bCvED2ieLXJcGfus84FE6I/TJ0KgRzsMqP8L5+XskZ32bgz8gEFyTsd6bfvkekOAuepE8CnfMVmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngrO7crZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b735487129fso349619766b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764955906; x=1765560706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JRTQ5qP3nDJv7XXYMbTJlNjt9BNu8NHYBKExw2nneY=;
        b=ngrO7crZoD//Q5eTsIcdJCLVOLciaLwGj+bzv5klL4CI8XH0sej9ITJuvPcZUZhv+j
         NBIy8dvcqR2prZPLFc8PJcijbHRf0bfxf8h0KWA8t1H54X7GaS6nmQ7QV8u5WhR2hEJD
         2hhRNd9MhO3VzqdQ45FSr3WzQUytEkpyd4KkjtCrykl3p6j9v43xxxv8Mq3m85ACadwM
         v9+xBkOeAPF/6rANBJuhlh3NeyxBO+bmXytpvSoJ7xeqCx5vTU6lKjTu5mHrxqKjOwXz
         3sjAdZ2AvPwam/Lqu01cMsMQsXe3C8rDOKShN0mnbbeUqd7BJRlwXEtSmw/+HirAApVx
         wDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955906; x=1765560706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JRTQ5qP3nDJv7XXYMbTJlNjt9BNu8NHYBKExw2nneY=;
        b=Ab2hnpCK+V/1K/NsHjfVgetoYnfrQxzB6Ato5wX13j1hFDZRa28lPPvnRaWsn0UOeU
         1K9818UuZFIagVNl+a7PbrGZDlfbOzzjg4nRbG1XA8DhvchsPT5N2X1mo76+QVE677Q6
         WV9Q2qsU0FtqaRNQXcaWFNKawEQq7AhGCKGZBLgDgvBn7BK5W8V77UOG2COhPrGVJlHN
         paA29qcQnICyaloPHZJCTUfpoBUPWUJUxIDGapfU9OJynl06l0IAywovG5Em4AmFK5L2
         zod9+auGfU/HNQoXBMJtY4EcTNPRIsuMzRfc6RPhNRFjUC+vjDqGgKYlZE6O7yoRVmrq
         RGBg==
X-Forwarded-Encrypted: i=1; AJvYcCXLpymxnM9Ue2Ic7cscf90xv/iFTCRaHFgyGM0jhf4yoD3XjD18RKsuTwa2b15D1Pfm8Ir0eyAWhcbQLcZkfGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6f2hqxQ8IHg3e3viWRL1Zj46uTeXRtD6m7dAxEcpElQ6Vlcs
	dkxjPNBmMnWfZKQMe9edlm50clQxNoxC3DRTBnHBGcmwA6tVnbpvd1wAp/wAnCAXmAtsGPniFLY
	Js3xIO8GXti9eiWgo2lIWRD0xsHgVDCE=
X-Gm-Gg: ASbGnctAbRrm+r8j83KQmZCDxpTUivHJ8iH3lKB0mo6iN8VVaH45M/WgEtwR6/293zO
	zX6r5hdEchxBtl0QYMnVohHL9tilrTa69p52lUwoWNUlmj+oiwvAztetHX1P2I3aL6E1pq4JlwN
	zyZunjF1AXKUDe4A+9eGjK3IlzgDCNEaRHKdfGyRYriAMRbtJev8CM4essneZryr+lWJfYi14V4
	8Eit6pQWbz8jnDXzcMw+dGys0meyCoBvJngKQLeIa8/3O+rdyedEfBsS3qZJ5HhPVsa3KvrWCTY
	kbQnNUgOY9nFIMKk2XSjm6nnIihddw==
X-Google-Smtp-Source: AGHT+IFRCgHfKGsAkZVPOlUmrl9vw+MR8hBEZgtV7PRhOjUmwdoMWwyUcdUQ+ugYeG8JzPcdndAeoqqxibr+uphApf4=
X-Received: by 2002:a17:906:dc95:b0:b6d:73f8:3168 with SMTP id
 a640c23a62f3a-b79dbe71c0amr1072539666b.3.1764955905366; Fri, 05 Dec 2025
 09:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205171010.515236-1-linux@roeck-us.net> <20251205171010.515236-13-linux@roeck-us.net>
In-Reply-To: <20251205171010.515236-13-linux@roeck-us.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Dec 2025 18:31:33 +0100
X-Gm-Features: AWmQ_blDI-utBDx2W6qm1w5i1hudk3paNzpT1OYcZ7gDhfKrn0IT4xpTqmkqetY
Message-ID: <CAOQ4uxiqK6Hj2ggtcD-c7BAtuBcm+LrKVkQOxi93OXhwSE98Dw@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] selftests/fs/mount-notify-ns: Fix build warning
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, wine-devel@winehq.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 6:12=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> Fix
>
> mount-notify_test_ns.c: In function =E2=80=98fanotify_rmdir=E2=80=99:
> mount-notify_test_ns.c:494:17: warning:
>         ignoring return value of =E2=80=98chdir=E2=80=99 declared with at=
tribute =E2=80=98warn_unused_result=E2=80=99
>
> by checking the return value of chdir() and displaying an error message
> if it returns an error.
>
> Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant runn=
ing inside userns")
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Update subject and description to reflect that the patch fixes a buil=
d
>     warning.
>     Use perror() to display an error message if chdir() returns an error.
>
>  .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notif=
y_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify=
_test_ns.c
> index 9f57ca46e3af..90bec6faf64e 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> @@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
>         ASSERT_GE(ret, 0);
>
>         if (ret =3D=3D 0) {
> -               chdir("/");
> +               if (chdir("/"))
> +                       perror("chdir()");

ASSERT_EQ(0, chdir("/"));

and there is another one like this in mount-notify_test.c

Thanks,
Amir.

