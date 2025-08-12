Return-Path: <linux-kselftest+bounces-38775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36620B228B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC184564F4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE70280023;
	Tue, 12 Aug 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEKwZAyz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F227FB28;
	Tue, 12 Aug 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005233; cv=none; b=dlzt7zEcrX1C3RtKSqDkYXuSgdaMqLdVxTjj8Wza87JBXN6FuvAHCU29aMcDVGxFvG/nPthVU1Yzl9HEMdZoYDKDJn+rtydeaRQJg5F9Gwu/HNkcIp+W942Isk/LJrzUiRtiCmO2mUGGU64p5668eSOk9y2UTRAk4K6guLgixoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005233; c=relaxed/simple;
	bh=ie/kJJDkTzro9jVYrFcfQsbZ3JqTIJO1trf4qDlhrdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3N3csjOChhEv/IHHLGG8uh4T/wPn56qj7YKSSuTBg/HCbZl1wT2LOv6zI7u71A3mgF5Q/I8i9i95VNWa7QgfazSh8HwPnuhkeSuQ6c6evGWCrSJXz9QcWUebTpMkVXk+PmZlERmIJCt+tgqWWJ4OMvYK/k3W1ZCbtwq/JHP3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEKwZAyz; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so4780559fac.0;
        Tue, 12 Aug 2025 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755005231; x=1755610031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RREPB+k7a/mceQdaxCB2njGP8WW7v6Nzrb7ci/2EA8A=;
        b=DEKwZAyzEhjhbAX8wED7bFvWZ2noWruwXPaOM7GrazAoIXoilC3SIhCa8YvCQig+Ni
         BNhRV9HDhUuF8+KCQqIAgnAn5uJ770M6YKXeMJCHoFq/Sg2c21eOWRXU/3U54D1GQq/U
         IFZVlhCbovL/GKK2PSYbUsHEkEZNUYMDAuiJ5PkQfveV8EY1p+t1GlTzFsI1LWnL/yBu
         7lxVivgt63aJR7sapVJcWsJ013uUStqftyV+KJcw6txgiKy63svcxeU5OX4ac6vQXsjN
         ZdoaPOJne2g6UFsp2HEbbwRkgzsZPwwq3DFTfHDayO5lnVMuo8WDEC7ixjCr+r4Es3uR
         9PTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005231; x=1755610031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RREPB+k7a/mceQdaxCB2njGP8WW7v6Nzrb7ci/2EA8A=;
        b=P7rEZ10zMzh3KHVU1lOaQvygk1QfSIngra6ao0yfdwZN7b7mLpQZi+SSDW6VSYyv9E
         msbzIEUbFh7E63KroBzsEgtSg3Egh8nGF4lCVp1m8ZBG6GjGtAQYz9PIvKPDN8IcRMUT
         y2BSkvvm8MafWSRLoXgXYtSjSx+Hl787EmCHuO47Nm2+ulW9uTilGEduQqWNivStYVlc
         cFZb4F8A9hQn98oTHVZlmofcjd5LZUu5OErKQ4wizSkBJ0nZLiIQyO7/YApeUNM27D8v
         P1VKUr59cdcVoEM25Qmj6Bt3DB+docZ3ksh4exXYuzMHya00K3RHipC1jeamCYcjYbMM
         ZcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9uJ7e1gnourbA+vXLGeh2t8BpM7zGzevJLF+23b8EMmzJs3XHKJebn12mWWJiPeL5nGGOJL3vJtEzLWY=@vger.kernel.org, AJvYcCXluSEl+jg+miL/RINHoc/VGpwNEbJ+LmQc6sfmNB0EiUKWyk0G78GcSJ3mNT4PT74n3MRlSUZgQbDTJ97dkoOk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+AI4QrdHYTzMYET94R5zIM7s8uqhQy3prY1SlpqPl9NYcf5p
	HJuOmYAL3nifm/OwJpeiOuWFpJlzkTHib9eua0Hf+iwDx79faUOFeAdjZRBhi7qfDlIr7YWLVuh
	rtzCSfrbgZCZmpPmx9vwoTlH3KJGZWBA=
X-Gm-Gg: ASbGncvZOW56pP7djpU5aEVK10D5kEF1t4RsviZW7Yb05xQw51zOVzRnW9umfLc33nC
	ErlGPbva8NrCSdYI4Q/Iyx0Jdy8C6XH5s7zkZhfoluzX3ECjDVpyjWVEOUIf4RVHzxxJY3d993w
	pTA1IP9D+VPwbmz/cSpjwvncXedWnkJC00NvQRBjlQnDu6lk+39tW/S3zurZ04WITCBUOGRe8zC
	bvN
X-Google-Smtp-Source: AGHT+IGpbMz1DdsWZ1z4GCKL7utzJO8TIQxtkA8SafJyjmZ6lfFuwcFQBFZL2gHHQv89lc/KdDVrhAdvffGsU9WPpY8=
X-Received: by 2002:a05:6871:6718:b0:2e9:925b:206f with SMTP id
 586e51a60fabf-30c94f3cf74mr1607259fac.17.1755005231005; Tue, 12 Aug 2025
 06:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com> <CABFDxMGPS6LE=A25VjXEpfKuzVfgxfgu=_uhkWXc3D+xuq-B6w@mail.gmail.com>
In-Reply-To: <CABFDxMGPS6LE=A25VjXEpfKuzVfgxfgu=_uhkWXc3D+xuq-B6w@mail.gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 12 Aug 2025 22:27:00 +0900
X-Gm-Features: Ac12FXxoAocnTTpz6traLMo0gPyYiDuR8cKin4JSoMSWQ6SUh-o9iDKVTOiC780
Message-ID: <CABFDxMEQYx7fdx4T7meUb01FoqJaHcW_2RoYnBwJ8GzmJTexzQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/damon: fix damon selftests by installing _common.sh
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Enze Li <lienze@kylinos.cn>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Alexandre

On Tue, Aug 12, 2025 at 9:32=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> Hello, Alexandre
>
> On Tue, Aug 12, 2025 at 5:13=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > _common.sh was recently introduced but is not installed and then
> > triggers an error when trying to run the damon selftests:
> >
> > selftests: damon: sysfs.sh
> > ./sysfs.sh: line 4: _common.sh: No such file or directory
> >
> > Install this file to avoid this error.
>
> I tried to reproduce those error with my vm environment but I failed;
> with my workaround test method, it doesn't exist.
> If you're okay, could you please tell me line by line how you execute
> tests in what environment?
> I'm also struggling with the test environment, as well.

I succeeded to reproduce and also check that this patch removes those error=
s.

> > Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host sha=
red function")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---

Tested-by: Sang-Heon Jeon <ekffu200098@gmail.com>

> >  tools/testing/selftests/damon/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/sel=
ftests/damon/Makefile
> > index 5b230deb19e8ee6cee56eb8f18c35e12f331e8b7..ddc69e8bde2905ff1c461a0=
8f2ad008e6b28ac87 100644
> > --- a/tools/testing/selftests/damon/Makefile
> > +++ b/tools/testing/selftests/damon/Makefile
> > @@ -4,6 +4,7 @@
> >  TEST_GEN_FILES +=3D access_memory access_memory_even
> >
> >  TEST_FILES =3D _damon_sysfs.py
> > +TEST_FILES +=3D _common.sh
> >
> >  # functionality tests
> >  TEST_PROGS +=3D sysfs.sh
> >
> > ---
> > base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d
>
> Does this commit exist in `mm-new` or `damon-next`?  I failed to setup
> the same base-commit environment.

However, I'm still not sure that this patch is in the correct
baseline. maybe it will not cause any problems with the merge
though... but I'm not sure. So I didn't add a reviewed-by tag.

> > change-id: 20250812-alex-fixes_manual-aed3ef75dd83
> >
> > Best regards,
> > --
> > Alexandre Ghiti <alexghiti@rivosinc.com>
> >
> >
>
> Thank you for great work!
>
> Best Regards.
> Sang-Heon Jeon

Best Regards.
Sang-Heon Jeon

