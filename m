Return-Path: <linux-kselftest+bounces-25393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D330A223D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 19:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2EC1887C93
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE691DF268;
	Wed, 29 Jan 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfrPszNq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3691552F5;
	Wed, 29 Jan 2025 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175069; cv=none; b=fnkaa8PQ/NVc7QY/LTIIih0NtCoy+jpPlsr0jQQp3Q1ROgYtJpU2nJIrQXpvgFTcJL/qwzDbE58LOqocPeJwVqs3xEoTk+HUMit6/4yIkDqv8149X2+HxeclHeqmCePGxhIdG+Z0Wk376JnBu2Tgq4pcnJADYvZFJNi1YaiY9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175069; c=relaxed/simple;
	bh=fsXVvAzAtZZgYo+UcFjIrPlDSF/lJxnvBIN3XkxfnFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFnfNXFh6BXSAy/Eey5Wwj6dtOXEaQn/lausW72NVd2vuX+rt2vHdnKX3yZlQNLGw9nA6JQg1fDMutqG6r39kyL0gRhi7e79MrEjX8M7cEBWHQ4RkI664CfqhWpWHBxKL1Lmh7gYeDj2Z42FLh9uk1p17UlnWwA6zUruqarNpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfrPszNq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-306007227d3so72386611fa.0;
        Wed, 29 Jan 2025 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738175065; x=1738779865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIGGzfQ0/TAeUf8PgDonO1t6XZ+XQpG44YzXL+6av8Q=;
        b=CfrPszNq9OnEGcbNXwbw+m8LGiatvVj5B5i7qSh2giHDtrtHxKj41q9rJljnkziY7S
         NaS1wleui1KjdBeBcj8VF/xYtOG5JwObxnDKsO55P62C9+fsBhGyNE8akxTiuM6ymlpj
         m6G9IPM6ZEx+LNeFB4rNuzEU8mvfVr1VymyawTBE+t9fC6UrTk5+sWvl7MIeDuj1/FOQ
         R3xVGTZH7GVwW2UWxkh4cUGBMG6NkmHREcn3Y2aIDn97M4+9AU22mLL+PIBZf0JMfUs6
         yAUTenvjenQ1dgKb48lL+xKGW2xB6BeKVCrE8bfkoef4YWl+5kTjpwNjwyYR7t4sZn8+
         XK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738175065; x=1738779865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIGGzfQ0/TAeUf8PgDonO1t6XZ+XQpG44YzXL+6av8Q=;
        b=lEVz3KDvvKOR7VtUcBT1fQxOuTe5qxg9RpoBI1Izyu6sQJRsGmWbyCcXfwd9nsLJjB
         EaXqzNoyHMDstuQsBKc4mas2uhQW2P/ISys2iMeVTzaED3vpa71KKfI5Om9pM3ApVfFI
         potwTo/p+DKCdgLFJp4L/hExKDaxdfCckN5u4rXRDdw37YZ+Z9OXMoWet5ghvYwl2Fq4
         4isgn9bInl83MFaznvWgNcgUKSS+KtKJ9K8DbQSg2uynmz+XESgvYPp6TPEqBxABy2QL
         dXLeSKWep2qaBgXYqeAoJ1albTN6WOh6isBpJyHtBQpRYkz7EWo2lsHpmATtbFUKWci7
         hQZw==
X-Forwarded-Encrypted: i=1; AJvYcCUg1RVn9l/vB3t6oQ9Od5tasjgHM5U8+Dmnz+ngGdkH70W0qsksRdKbeKthcKvbYe/jCMNmZVjasr1dJAk=@vger.kernel.org, AJvYcCWN9RF8YyElyl+wG5FTBmq15EHcz7IDPteGhm/tCW0hgIAOeqQRgB8EfRaKy0IVNEdOqqPYd4nfB95vFWDtgNHa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26CJzfXE81EkysSHVkJX9i5BK198CBXj9YJP0GKjWYZU4Wu+V
	ryWx6725nPoWxIJugPrDikuJBg7pwVctL893EcxQnGmF/4pueyJjQAy/u7BgopNMg+Ti3z1HB63
	tjAPBH7GuMuU9QtU1jD26a0JJvkw=
X-Gm-Gg: ASbGncufRTuCJwIFP5ZG33dvGvh+zDkJD1Dbb01nBPZXIH58tNDGOPx0ZH1Ubpx2wgW
	jALTHIj1xcoco3T8iytYam+i8UHoVA1weiAGBh8MEm1rJ14iZPNjoVvtsWLlXHiobGFJhk2zzUi
	vKrNYU/+rXSvFHEiviSHZwJRzQneSlkrD8qO54kA==
X-Google-Smtp-Source: AGHT+IGewwuB/uZuQl1n4dnYvZPmU/kT6Qq7oAdpHhYpO0NnorzwTkOCni+qGS8/PKYbVfZKxEhZV2HAq/DFNZZRmqg=
X-Received: by 2002:a05:651c:2224:b0:300:42ad:f284 with SMTP id
 38308e7fff4ca-3079681efe3mr16809661fa.7.1738175065201; Wed, 29 Jan 2025
 10:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126105932.63762-1-purvayeshi550@gmail.com> <d85f9c94-249a-4847-a323-2f547fe60732@csgroup.eu>
In-Reply-To: <d85f9c94-249a-4847-a323-2f547fe60732@csgroup.eu>
From: Purva Yeshi <purvayeshi550@gmail.com>
Date: Wed, 29 Jan 2025 23:54:11 +0530
X-Gm-Features: AWEUYZluEDh-khvtJAhzensN70-xXtAeQ_-2QMqNdmI4IFQkwKHyBbZryvYcdh0
Message-ID: <CAMp3bLW_NwMZ7DTErUHMmzEfz4M6r0PkU=w2WzptGzhmW2FmaQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/vDSO: Fix undefined CLONE_NEWTIME by including
To: Christophe Leroy <christophe.leroy@csgroup.eu>, skhan@linuxfoundation.org
Cc: shuah@kernel.org, Jason@zx2c4.com, liaoyu15@huawei.com, broonie@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27/01/25 13:32, Christophe Leroy wrote:
>
>
> Le 26/01/2025 =C3=A0 11:59, Purva Yeshi a =C3=A9crit :
>> [Vous ne recevez pas souvent de courriers de purvayeshi550@gmail.com.
>> D=C3=A9couvrez pourquoi ceci est important =C3=A0
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Fix the build failure caused by the undefined `CLONE_NEWTIME`.
>> Include the `linux/sched.h` header file where the function is defined to
>> ensure successful compilation of the selftests.
>
> This is supposed to be already fixed by commit 34d5b600172b ("selftests:
> vDSO: Explicitly include sched.h")
>
> Can you explain what is the exact problem still ? And why linux/sched.h ?

Yes, I noticed that sched.h is already included, but I still encountered
an "undeclared CLONE_NEWTIME" error during compilation.

Error I got:
CC       vdso_test_getrandom
vdso_test_getrandom.c: In function =E2=80=98kselftest=E2=80=99:
vdso_test_getrandom.c:257:29: error: =E2=80=98CLONE_NEWTIME=E2=80=99 undecl=
ared (first
use in this function); did you mean =E2=80=98CLONE_NEWPID=E2=80=99?
   257 |         ksft_assert(unshare(CLONE_NEWTIME) =3D=3D 0);
       |                             ^~~~~
vdso_test_getrandom.c:47:20: note: in definition of macro =E2=80=98ksft_ass=
ert=E2=80=99
    47 |         do { if (!(condition)) ksft_exit_fail_msg("Assertion
failed: %s\n", #condition); } while (0)
       |                    ^~~~~
vdso_test_getrandom.c:257:29: note: each undeclared identifier is
reported only once for each function it appears in
   257 |         ksft_assert(unshare(CLONE_NEWTIME) =3D=3D 0);
       |                             ^~~~~
vdso_test_getrandom.c:47:20: note: in definition of macro =E2=80=98ksft_ass=
ert=E2=80=99
    47 |         do { if (!(condition)) ksft_exit_fail_msg("Assertion
failed: %s\n", #condition); } while (0)
       |                    ^~~~~
make[1]: * [../lib.mk:222:
/home/purva/linux/tools/testing/selftests/vDSO/vdso_test_getrandom] Error 1
make[1]: Leaving directory '/home/purva/linux/tools/testing/selftests/vDSO'


>
> Did you properly build kernel headers before building selftests ?
>
>
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   tools/testing/selftests/vDSO/vdso_test_getrandom.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> index 95057f7567db..b2c9cf15878b 100644
>> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> @@ -29,6 +29,8 @@
>>   #include "vdso_config.h"
>>   #include "vdso_call.h"
>>
>> +#include <linux/sched.h>
>> +
>>   #ifndef timespecsub
>>   #define        timespecsub(tsp, usp,
>> vsp)                                      \
>>          do
>> {                                                            \
>> --
>> 2.34.1
>>
>

