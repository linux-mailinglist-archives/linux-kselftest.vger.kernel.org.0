Return-Path: <linux-kselftest+bounces-28303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B63A4FD32
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 12:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FA23A63F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C123371A;
	Wed,  5 Mar 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RBn/DkfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABF233708
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172848; cv=none; b=jJC8N0afdVxXSU1tYh+IPK09ItjVhPthiJeFGJrWyLlyo5Xw3RUgJuhieaGREhAGoMtXk4srlkeJOn2cPV2kuFSEGV9pOmFnEVkMLe6c6S4VsUv5QRc8eLuGHBmMoqxpCAlNVnepvzNq1mMChsR9BLjLI0pDTSZVQlDRU9X22gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172848; c=relaxed/simple;
	bh=YCPEr84HADNtZknZjlNwVsT95fK47HMoG4o4XVCziNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiL0mS7fTandgJ79oqgV8MWuhqcGuHwMeitk0crehP3xt6cUr3EgzTP94mDU5QGQmHy6tIu7u2/nETBudMuVSmclDd7M6XTu/wJ2wNwbxtt1eDd++LhZyJkWX/LSmn1eJ4dQ88tOEVEJLzYIqZeQ3bQt0gVltCaCqNuPe0fUtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RBn/DkfT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-472098e6e75so149831cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741172846; x=1741777646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3b8bsvWe2wdOZZrFq+eS3B5w4t8qU8Mzx9aXoXYEXfU=;
        b=RBn/DkfTgORoPAY/GGtHj5Y3g6Q0xYFSF85N/BbMzHkjii63OndvU1QlU+PY7KXdNx
         5+0Qz7dwPYkPgB5bdkaWW8KQT4ImmXJlm+vnRylPLjH4sasW6+PGLYmoRsfsfIDFsKPi
         sm/IY9zjx1TsWtSxvgptShcQER/+Y8o5sG2QwnmMPm4wU4bA299VVxDy5ax1w3C5IdU1
         k7WUUVCMMRtOcPXUpyufqwL8GGpC5dRC3M4fZa/p5/dEUGwKb5kflN/mJZiGUa6Pa8zt
         sxCVpshLC4TjD4wgO2usdITAjnimtYQcwYQfaL0B/Hp6qVPc25tvLan8PeINbrozm50i
         lGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741172846; x=1741777646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3b8bsvWe2wdOZZrFq+eS3B5w4t8qU8Mzx9aXoXYEXfU=;
        b=cw6AWN3/VsbRSQnYIJZyuvQh8bs7ml3LoAJmd69Pg/yz51E4LieUHeZmMGpPUnmEdE
         Mg7hi4VmTA3Bq2TkJwy81ccyp+oH+0d8w6g5curkMaTh7V9F9F6Gu+McaNseDX46/U86
         Dxs1UIGiBQQXSmDcg6lX+o3xYSz+WN2UiJePQgFuQ1FSAoIHUCDZzykbTBRRbqEHchXf
         e8CKqjt1KEFTPj62KzOtuk26rQid8W8/Bls/o65papy3Rx/y9IGXP5Dh6wlPpwOe5mVb
         sCMxKYT+kcqM0p1hfrvwHq2AW3D4T+aXyVQ9Qc3KOVcBaDLD+SeQNlMM7SRz//mbVuyX
         ZStg==
X-Forwarded-Encrypted: i=1; AJvYcCVC0oGmMw6biprifP1wBomjOo64AybQxVCm+RzQ68nkH4erT+IMlrEkOJx2jYcEn5y5zuRAVzBi2wF0SFB2kO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkIcUvDM3La++SvorqV40d+R1SPwQst+zP+ZnO+5IecLbf1cPS
	2Sm+rzxr9xtQy+a2QUhfqdsJysbAawwd+VKTdviY5+DZsAPMWvP9LPDveujGvJGlcoOrE+wTvTw
	Egc+QhI2K0+CWNqcxID/mw3akll7PiIZIt/wm
X-Gm-Gg: ASbGncv1mVx1Xp28oTLT6fX+qSWTUVDznhJDGnajryo793u2NvupVmbgXQfXZftzlZj
	VMJhF7xHeAvaff5BCDqw4nzpnvgjNRj7NjMvL1K+Qb9YIVoJBiUiRXkRVYrBfapeVizVnPorxUo
	+4P0zzA6Ej/dZU3LOGTFiCCj8064Hq/AqXJhqX48a4iIDXE2iw19HlxRzK
X-Google-Smtp-Source: AGHT+IEL760KZkjyd/+1dFxx1ZG+sfvkJ/ZLzkZJdVLCh1mgfXm97SH5uL0JtnEwSYgrbAmRC3KYpD6jfIDV3TRAsks=
X-Received: by 2002:ac8:5807:0:b0:474:fa94:8d20 with SMTP id
 d75a77b69052e-4750b53c11amr3965601cf.2.1741172845959; Wed, 05 Mar 2025
 03:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com> <20250228-mm-selftests-v3-6-958e3b6f0203@google.com>
In-Reply-To: <20250228-mm-selftests-v3-6-958e3b6f0203@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 5 Mar 2025 12:07:14 +0100
X-Gm-Features: AQ5f1JqnX0ORyymHsw5kQxZqiZ_jVU2MAEIa8yR0CC4Q6dLgX8mYcADTJ_z6BII
Message-ID: <CA+i-1C2pn90pfB6qhuGV8ecUw3YKfg1b8tSTsXs4n_Rw6US9mA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] selftests/mm: Don't fail uffd-stress if too many CPUs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 17:55, Brendan Jackman <jackmanb@google.com> wrote:
>
> This calculation divides a fixed parameter by an environment-dependent
> parameter i.e. the number of CPUs.
>
> The simple way to avoid machine-specific failures here is to just put a
> cap on the max value of the latter.
>
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/selftests/mm/uffd-stress.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index efe2051c393096e237d942c04a264b6611a6e127..5656128590373ed376b3b5d9259e5ca3867a4099 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -434,6 +434,7 @@ static void sigalrm(int sig)
>
>  int main(int argc, char **argv)
>  {
> +       unsigned long nr_cpus;
>         size_t bytes;
>
>         if (argc < 4)
> @@ -452,7 +453,15 @@ int main(int argc, char **argv)
>                 return KSFT_SKIP;
>         }
>
> -       nr_threads = sysconf(_SC_NPROCESSORS_ONLN);
> +       nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +       if (nr_cpus > 32) {
> +               /* Don't let calculation below go to zero. */
> +               ksft_print_msg("_SC_NPROCESSORS_ONLN (%lu) too large, capping nr_threads to 32\n",
> +                              nr_cpus);
> +               nr_threads = 32;
> +       } else {
> +               nr_cpus = nr_threads;

Won't have time to send v4 for a few days so I'll just note here: this
shoudl be nr_thread = nr_cpus. This causes a division by zero on
machines with less than 30 CPUs.

