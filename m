Return-Path: <linux-kselftest+bounces-851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4149B7FE44C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 00:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7245C1C20912
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 23:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484747A60;
	Wed, 29 Nov 2023 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aD+38mP1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A60810C0
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 15:48:09 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cc66213a34so3757257b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 15:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701301688; x=1701906488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NC6M2ahDfb9yS4fB5Q2Q+a00sO+bDPDpamRwcY9YLA=;
        b=aD+38mP1iM/plI0hGvH3dGQS52CPlKoKbO4PMJo/AmyeUl2TIlWBULyltUFKGoWWf7
         HUGxY4c9Q7DMbb/+zGPqkHtGLaKSxHWJ1/FmliSr37UW8gjUkoNTk9VA8SP2vK03RlRX
         Gp4SXEeVjwMjZvs0ET0r6wo69a6nMpuCdKFzU87/P5MueoSHmv6UrPrfzeFVIP8A08qV
         PdYONByItjb5h56ORzselTUXlaKkvJsx/f4oj4XW2fV+wQqdYz/fA6Sn+085SAAQzsMh
         Ztaz6J4hRsPt0bRvuvsofpcStc8UmmJu3Mn0Y64+JEGYNR+GFwvfFpoMeI1BeYFakXP/
         76MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701301688; x=1701906488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NC6M2ahDfb9yS4fB5Q2Q+a00sO+bDPDpamRwcY9YLA=;
        b=YM8KKfl/AP7GdZd53TPx1DAcj1yXEH5lk/+zXSZaMbZtShAhH8XcyIdhQ8HsUj8+VB
         chsns7dJ0JoxeSqak5Cxx+WlyyxogjyoubvUDL//on4BIDy7Bu0pRHhVlH5ojFTPgPfn
         NG4OJj3HlqisWzPkSN0PwW+9wEFvonLdEPAAIY7Wf2cTuYqI7wO0TKRHbW/P1ZX/uAzV
         MHJOdxyya+kAT0TFTR32oWVgE8FAwgRdpuQX8at/3dcLX4hkKA8sbemedg/RL6gJ7Co8
         aZ9uQ4AaneNNnx6YBeLzcp+Pw99otIwhgV0Ab9MYphItuboseAVWE7EQCQ6ISTvMX9ld
         2+BA==
X-Gm-Message-State: AOJu0Yz+t+z5WYDshFsJMu9it2WjEUAKfyKKzS2gTeW4cgWJN2g6ktUg
	9M2g/g3iZ9mDTtWPO+QO0YoPzToPXHsLmzBtRbSWQw==
X-Google-Smtp-Source: AGHT+IGzlwg1krhw5pbVNhYB2NjkVGjZzcfur4zemp/oS30saYoyeiLUMK8+JztsH4TSXvGe0Lk04Zetks3pQ6ZN/O4=
X-Received: by 2002:a0d:c582:0:b0:5d0:aa04:7b76 with SMTP id
 h124-20020a0dc582000000b005d0aa047b76mr12450890ywd.20.1701301688590; Wed, 29
 Nov 2023 15:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129222424.910148-1-pctammela@mojatatu.com>
In-Reply-To: <20231129222424.910148-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 29 Nov 2023 18:47:56 -0500
Message-ID: <CAM0EoMk=oU8PRQoN79ccnVcqcsX9PgcZf+qucr+ni7JNAhmPTg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] selftests: tc-testing: more tdc updates
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:24=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Follow-up on a feedback from Jakub and random cleanups from related
> net/sched patches
>
> Pedro Tammela (4):
>   selftests: tc-testing: remove spurious nsPlugin usage
>   selftests: tc-testing: remove spurious './' from Makefile
>   selftests: tc-testing: rename concurrency.json to flower.json
>   selftests: tc-testing: remove filters/tests.json
>
>  tools/testing/selftests/tc-testing/Makefile   |   2 +-
>  .../filters/{concurrency.json =3D> flower.json} |  98 +++++++++++++
>  .../tc-testing/tc-tests/filters/matchall.json |  23 ++++
>  .../tc-testing/tc-tests/filters/tests.json    | 129 ------------------
>  4 files changed, 122 insertions(+), 130 deletions(-)
>  rename tools/testing/selftests/tc-testing/tc-tests/filters/{concurrency.=
json =3D> flower.json} (65%)
>  delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/filters/t=
ests.json
>

For the patchset:

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> --
> 2.40.1
>

