Return-Path: <linux-kselftest+bounces-6707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F232E88DCA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9ADC296EE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBFC84A2B;
	Wed, 27 Mar 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="P3BFe74e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514083A08
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539401; cv=none; b=j6XEK6YGgfyCk3/iRojwJrc+HBXw6+2b/qSwqUjxk610V7gtI8+OoTKIDUf806a9kMsCaAooNstqk4vBMlRweQmqJea9uOsnAMFjhs1MkBf7uVuujhkSwRnRu8NeQyj9LU+ZcUmkV9mrGBH9+SYBAgxhKcNgDcoGWuP8hZSVyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539401; c=relaxed/simple;
	bh=OfJ34edQdwR8YfjyjKeXgQdTreuHD9J/AXKmoBorsbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbqfmfTLsnVtfMLBl2Ge+1Wd1Oc0jtjeQblqoWvp3tkZQJ48QEHfLy/NhSTw6pyrjXy3ySGjX0j5rdqqrDBrSD3vvwy/VkCVzuLhifHQ0khvVUgqmb0McLCqrBwagXmDdiVpMgdqsqfFb69aD1Qkg1lTh6GwfI/CVpTlskiHwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=P3BFe74e; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c2b4850d2so2061121a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 04:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1711539397; x=1712144197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAkgcXLjhZa6wcaapohBL+DoehmK0FlS2sc4nFrXi/Q=;
        b=P3BFe74eRUuqo5sTR65zvK54vVjQc/z4XiNst1ZkOrwXOH/d6Oez56UInmIqjBoki8
         EqhVsOmqCPI+iQJopZP1b4ffyQ0/T52OoBUcLM7/MRyNz8r54GzpvCTzCYS58LS3gu02
         tKdefV3FRgT7SCbu4v51KmrlkFyC/IuyeLjuz85pp8Gl3RC8XO+UQ3KXPrM7PebztRXY
         sLRV4yNRago/udcW1Rpj0IFYYkueoHjnZHLSYydAaT8ART+ftscgHRg0+Kn4bdP6pSVG
         1+YFXUQjycwa7oslFNvD12RKYp5QU9453M3l5k43Zr1FBMd9XiFknVDEcRlMdQT/Xl2q
         1JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711539397; x=1712144197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAkgcXLjhZa6wcaapohBL+DoehmK0FlS2sc4nFrXi/Q=;
        b=RjhBkbnvHMLM1zF+rthoD5XFbtrMWkRS8k3G8nrSZTTZC7HFb6lCgnURndbp0TNR1W
         UJ6z+zZQ6F9+5X5CPeWOsZMIMPlENqT35T7iG7XCqAejc0LcoflG2FS6WVTaV7hqPJA9
         huODWoT24Wlka8eKrM03+B6NUrWPxcB0fuCJNaw9qG/fKDr8TeJsGL5FjCKvE4O9ziP+
         5mWflp6F2/Iw/S0KEOMNSXEIj3ythoyXQDQBI0uAzK8DZkvSDazj9MVakY89tx1JPyQX
         Au1vUa4GTRHftiPMwCeygZh2ybcxZuz51b9w80HiacgFsD9trG+EUsr34OnyHD7iUayt
         r5eA==
X-Forwarded-Encrypted: i=1; AJvYcCXV6Dq8Fu6yNUXnGqCa6/jh9OXWeW8LJ8f+rMEhlOFqTr9PjcnseYjb7WLSPoWfSeRt6NqeezchG4AC5J3u+O3g+8cNaqp/+yrlJzOUSot3
X-Gm-Message-State: AOJu0YxE8iM2Nrda59RNa7TqaujrEs0qteFmo0CXRIQ0hAdgManygktA
	3LXhIw4QN0D6pKcfuvuWwMzcT49qAayKUPpdw85nwk37UC0xq5fvB1QbW8aGzHK/rwpH5+DSpyK
	wHK1zL5JcZatA578YYA+ML+0mOkGkq7t6bqtPvotCoic8KiwWfA==
X-Google-Smtp-Source: AGHT+IEpF6U85JTj59UDS1Rg7aYSWvA10cmUTXBqiIxQe9j9lt2l3bWAwPMTLeu+e99ar/OWuiRuS6HUexJAdVNQfTw=
X-Received: by 2002:a50:8ace:0:b0:56b:9f82:4a40 with SMTP id
 k14-20020a508ace000000b0056b9f824a40mr4142377edk.11.1711539397221; Wed, 27
 Mar 2024 04:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327110649.283925-1-colin.i.king@gmail.com>
In-Reply-To: <20240327110649.283925-1-colin.i.king@gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Wed, 27 Mar 2024 07:36:24 -0400
Message-ID: <CAP045ArUu52sfJGptaBMYZobhvLytpWZYpEmYjVY3tzX1fRR4w@mail.gmail.com>
Subject: Re: [PATCH][next] selftests/perf_events: Fix spelling mistake
 "sycnhronize" -> "synchronize"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:06=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in an error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/perf_events/watermark_signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/too=
ls/testing/selftests/perf_events/watermark_signal.c
> index 49dc1e831174..e03fe1b9bba2 100644
> --- a/tools/testing/selftests/perf_events/watermark_signal.c
> +++ b/tools/testing/selftests/perf_events/watermark_signal.c
> @@ -75,7 +75,7 @@ TEST(watermark_signal)
>         if (waitpid(child, &child_status, WSTOPPED) !=3D child ||
>             !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) =3D=3D S=
IGSTOP)) {
>                 fprintf(stderr,
> -                       "failed to sycnhronize with child errno=3D%d stat=
us=3D%x\n",
> +                       "failed to synchronize with child errno=3D%d stat=
us=3D%x\n",
>                         errno,
>                         child_status);
>                 goto cleanup;
> --
> 2.39.2
>

Nice catch.

Acked-by: Kyle Huey <khuey@kylehuey.com>

- Kyle

