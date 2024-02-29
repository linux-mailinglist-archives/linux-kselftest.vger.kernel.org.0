Return-Path: <linux-kselftest+bounces-5663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285F86D2E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 20:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86BF1C21927
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181E1350C9;
	Thu, 29 Feb 2024 19:13:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE888134436;
	Thu, 29 Feb 2024 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233995; cv=none; b=XUmY95We0CIyco+M3wUnh7wszFxWXitWmK5m0fCGlPWnUZ43+o3pcq2yBvxpRvXi/Drh3JnftDTjdi+8gRFHakQSA1NkDIdq14LjnUe5/QAnIsPMHXDEEDJhRstmYvWT73UlgBWzrzWOgmmsxmsLPmnKNT0SY3dp2PsVmSbBwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233995; c=relaxed/simple;
	bh=68Mvbb3k7QKn33UXowNqEyn3+hdJ3GOVrggv3kvEHxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxxK06VBQnwwVggGPz2uUSkUChRxhlPPplJdal84d4fLHwnaa7v1fkxa/xb4cn4189hIeAlDyP1pfZo5QmPy5kRNAEOleiKzkrBWW4xBQwqDpASlgh98vrZ82NxI1MSU+gJFYl2Su3R+dC3oKDTaX+hBDmh/D7Q1SqjGB41BXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a0c7c87dc6so12061eaf.1;
        Thu, 29 Feb 2024 11:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709233993; x=1709838793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68Mvbb3k7QKn33UXowNqEyn3+hdJ3GOVrggv3kvEHxA=;
        b=sgTUr2Ti4J/P7cXkwRXVnJCnWuaZXMqRtOSLW/cXdpO01d6dnppq7a5mXzYJmoX1c+
         xwKC0dFfkex/Cc7M1gUCfqarDwnPjsbLwb19msxUk6C5e4XzWOKJGvqEUcJcHYDw38Zf
         zs+EzKoOW5BYzCwSc48bSNdvOnTko9l5tdiwndWvm9jq15ja/69QCscMbGRCSuBYpANO
         mcT7yIrGKjNuSEUhkyrsHH79yd48ouDhZvca4/DkIZ8R28u0L/bJEtgOG3UweioKszwH
         pNrrSxpCCcvSbQ1GMbpxHhmqHSckMHCMFjmhb0lgFctapgidqQdEx5e/mWu3CcFWhqA0
         iLYg==
X-Forwarded-Encrypted: i=1; AJvYcCX4RqQXk7RI2rExytGz8rEww5ecvs92xuhOCT8WoU0ph0EFUO+YHjfmg2XsgjauUb5a46UEuGy9NGYFTyIyph47Sf5qW+lh5xzifRqhw5vBk9Y7iJNCduz9O15ClC85gxKSmfpmNNHi+x8p/EjXlo2bumxZY0ArbHV6W4U7l/gEWB3msZne2noI28URDt6FYdNM0sv08oVgdnQaZWFrqh3nQUml
X-Gm-Message-State: AOJu0YzkkpLvz26ATR9Px2FO3x0UBpFAvFKOjg09PHD8Cnjqu9n3RPgO
	TV4e+MlTafzi5K8i/LWxx9++brv9sxzcqI/RU33jkkXEVbkdNP1LTc1omn6Ksx6COBX4dAQHJ3n
	jBklMuRY9my9n4j8ql3M2HKCwn2c=
X-Google-Smtp-Source: AGHT+IFzdeSRC0oF4uYm+ATN7F6IC2O/WKB17N/8gWXOt1JzeF+PGQ+XImDO55nGGMnGakXbb12L7seyAmOMa7GGSHY=
X-Received: by 2002:a05:6820:352:b0:5a0:6ef3:ed8e with SMTP id
 m18-20020a056820035200b005a06ef3ed8emr3028823ooe.1.1709233993024; Thu, 29 Feb
 2024 11:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227073924.3573398-1-li.meng@amd.com> <f1964180-458f-4c22-90f6-bda2aee5dbf8@amd.com>
In-Reply-To: <f1964180-458f-4c22-90f6-bda2aee5dbf8@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 20:13:01 +0100
Message-ID: <CAJZ5v0hHS2YSuQnXbyHOqErEaz1BPbxO5pWPa4PY6fKQch1VNg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: adjust min/max limit perf
To: Mario Limonciello <mario.limonciello@amd.com>, Meng Li <li.meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui <ray.huang@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, Nathan Fontenot <nathan.fontenot@amd.com>, 
	Deepak Sharma <deepak.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Shimmer Huang <shimmer.huang@amd.com>, Perry Yuan <Perry.Yuan@amd.com>, 
	Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:36=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 2/27/2024 01:39, Meng Li wrote:
> > The min/max limit perf values calculated based on frequency
> > may exceed the reasonable range of perf(highest perf, lowest perf).
> >
> > Signed-off-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Applied as 6.9 material, thanks!

