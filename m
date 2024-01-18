Return-Path: <linux-kselftest+bounces-3218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C288B832186
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 23:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADD11C22B25
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 22:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52E3218B;
	Thu, 18 Jan 2024 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Not8ngm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B531A82
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616628; cv=none; b=cKK47gwd9p0OejheoxpRTmrIpGfdtaFQcTMB64mWVrNOxNL+JbcQhXUrhtKNgicKQxyXUu0YYYO8jhA3hACEOxmUdtbtSNL19i2f8A9SS0Ykxc0rrd+V0M+gtXc6qUKErxw4SUWhcvYM3jl23/kTbsNv1B+CjX2jtDgBSJOQIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616628; c=relaxed/simple;
	bh=wAux2uhZUErM0ix/ZfavGPHGutAJf3/I3/cmMOsrnS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6HumFDG8X7ib1QbZHI2vUAZy8Aze5egyETHHj/HOniV9Afy3X7otMmOeA36iKoHsQWEDd238EKl68guVFGKsNJ2dH9yW5M5s+3B9/kOzk08yi2v9nn8Hit4jhjcmqyr2A6iXJBsYVhjeF1hP16Z+iaybH+8B3A7sX5/rnimrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Not8ngm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-429bdb17616so94781cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 14:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705616625; x=1706221425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/D9CFZxaxRdvm2BArETVuUm8vyoS7oXJdlz2nCdRv4=;
        b=4Not8ngmNdSHuaaaNZUpsusJ1VGPFYDl5fxcPa697MLDgKhhKMqif25QwDR3yow1Df
         +CdPqu4M3YrrqjNe0+dImnrmLmP47UkuS++9ozTYtVz3ZMjoB9tVthmcFxKFwccT7jtz
         km5JpSa7I4ovdDe2Dy1EZLAfiUiSsQiTu0r1167TF+wXF69d+FFoPZAF07T5j02tYN5R
         mSG0NrfLy/NNlEsF0g7xp3v44vUanjv9TUHRI/1rubrGMgSVNZkbuj6Y4EHDWmiHY3rT
         JMFLF0N8rGHogR9Le2HI6AaTzUkSVZEUICTcQ+4eQkx6i1qWobjjBIEwHwJEO0XcR+J7
         F3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705616625; x=1706221425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/D9CFZxaxRdvm2BArETVuUm8vyoS7oXJdlz2nCdRv4=;
        b=FljB10fxyq1JE9tli6ncnsj/wlnCN3MiLK142ZiKkCy3l6HYZAf3CrDnef8T2X6qeo
         d/PjdgubxGPxLBEhdBopfr/luVPEUFbAp31xkzmVS/dNAPbZ1CxoFKOPRAgGLv2tHApn
         a/jMBYW/9Lm5EQjHbOIg1HpnnxEKDDdyNVeQYVI3ypAUbFjZyxrl3VojYtFfF6msFdO8
         SieUJsiySSxAKuFSUFnmGRIs054fu7nBC8zP5vJXPtQAeUNIOqZ57CnkY8A6jM3tLcJv
         0RwXuy6pW3Y6JPWB0jmrfxsBGcJ9EwLhA9FscSzAOw/DzYQ6D8VIIjhHVYPQIm0KqAw/
         qm6g==
X-Gm-Message-State: AOJu0YxuqCPEEcRM+aafsLgR981+KwdlxQnSYZyQkAQ+keDVOcyarEwZ
	pnuJJGaF8x5kfWOzaSk8dkVA2dVmw3WXGGQjACH5ZiqptYzkzh3SKNfgpsmVFPZ4t+l8ChX9Ftc
	EeKBckxOuBENu9vl15vGnmufpfAPCKo5CNiLY
X-Google-Smtp-Source: AGHT+IFiOtHU36EEJM9qMTHKHSIzUrPvwSNbh7ZwRD3ArjfPyZK+NArTYvfMNkK2EA2hPUVBRnxLVHTDVT4Z1PJa21M=
X-Received: by 2002:a05:622a:40ce:b0:429:c6bc:330c with SMTP id
 ch14-20020a05622a40ce00b00429c6bc330cmr83493qtb.14.1705616625277; Thu, 18 Jan
 2024 14:23:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112001240.1710962-1-lucas.demarchi@intel.com>
In-Reply-To: <20240112001240.1710962-1-lucas.demarchi@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 18 Jan 2024 17:23:33 -0500
Message-ID: <CA+GJov4-sWm=MHp6S+4+WsZJjeFjEdLTB462j0sOym8P_sjKLA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Mark filter_glob param as rw
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 7:13=E2=80=AFPM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> By allowing the filter_glob parameter to be written to, it's possible to
> tweak the testsuites that will be executed on new module loads. This
> makes it easier to run specific tests without having to reload kunit and
> provides a way to filter tests on real HW even if kunit is builtin.
> Example for xe driver:
>
> 1) Run just 1 test
>         # echo -n xe_bo > /sys/module/kunit/parameters/filter_glob
>         # modprobe -r xe_live_test
>         # modprobe xe_live_test
>         # ls /sys/kernel/debug/kunit/
>         xe_bo
>
> 2) Run all tests
>         # echo \* > /sys/module/kunit/parameters/filter_glob
>         # modprobe -r xe_live_test
>         # modprobe xe_live_test
>         # ls /sys/kernel/debug/kunit/
>         xe_bo  xe_dma_buf  xe_migrate  xe_mocs
>
> References: https://lore.kernel.org/intel-xe/dzacvbdditbneiu3e3fmstjmttcb=
ne44yspumpkd6sjn56jqpk@vxu7sksbqrp6/
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Hello!

I have tested this and this looks good to me. I agree this is very
helpful and I wonder if we should do the same with the other module
parameters (filter, filter_action).

It did worry me to make filter_glob writable due to the recent patch
that requires the output of filtering to be a valid virtual address
but I think there is a sufficient amount of checking of filter_glob.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>




> ---
>  lib/kunit/executor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 1236b3cd2fbb..30ed9d321c19 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -31,7 +31,7 @@ static char *filter_glob_param;
>  static char *filter_param;
>  static char *filter_action_param;
>
> -module_param_named(filter_glob, filter_glob_param, charp, 0400);
> +module_param_named(filter_glob, filter_glob_param, charp, 0600);
>  MODULE_PARM_DESC(filter_glob,
>                 "Filter which KUnit test suites/tests run at boot-time, e=
.g. list* or list*.*del_test");
>  module_param_named(filter, filter_param, charp, 0400);
> --
> 2.40.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20240112001240.1710962-1-lucas.demarchi%40intel.com.

