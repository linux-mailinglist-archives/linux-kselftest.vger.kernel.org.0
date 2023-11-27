Return-Path: <linux-kselftest+bounces-652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA117FA3FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 16:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A97B21353
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402CD3175A;
	Mon, 27 Nov 2023 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Wp7LujTg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C461113
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 07:03:14 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5ce8af1eab9so26580257b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701097393; x=1701702193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGECS7hQ9z7O8g2r5L0bNaVk88br4ZWd2DQT3SC6LRo=;
        b=Wp7LujTg4LfZcv28YDJaVSs41WopJJg/J6Qck1i6rscY0kQbjdhZVJ87T4vpFYx+Ac
         5h7tvoH/m0bhL66i2ERWzQfQfWzS+0b6CINwRvFLpl5rFVL0zMTVkSnXGrp33N3ObQaP
         hSHctpB4rPCvAemnufqnUb/Z83q9lsqZfJk8SAYc5DDAe+ParZEYZ/wqlFPLx2L82uX1
         v3eRBOcbygh+6p6nDDHLhvliKVw90jLDOiWemuDKWZTOlhNn2cpGi/1zjd9bV5eR8tzY
         wHISyaekBbT/dSCbXM/FaPTHs/p3aCZ5SaY9iL8pJGwQnFDnYXu2RKrAZfHMDMijgj9U
         Ac3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701097393; x=1701702193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGECS7hQ9z7O8g2r5L0bNaVk88br4ZWd2DQT3SC6LRo=;
        b=I/5KrJ5nUSi6+pyq99AIghR1D3H1zg/VpqxRPvx5ZtqOnHHsKrU3adqpa9tBj9I+//
         vBJGRWwvlf1h9y3vTNAuBtqPR0OLX4SCt5JWpRAQZMvePX222V5cozgKqpIhG5KdY4GP
         VL+YVrc7VdGy9lPIwL7cm8o+jc3P8YgFztBkBmwdS2OCWmQLEo4WYhPo4JgTdhrZ8wlG
         ntcsJ1RDc+vc3dMZdow9KeGnVrfxIaX7y+3S/82nXh/LRAVn0nkUOjbGd5jwZh4+e+CF
         x7LHeXJj8be4ebSdZyfPbjlX3gb74B+Bl4hbn4MwhNEsS+d2VJMuW3jf/M4yTGnKGBB8
         Vkfg==
X-Gm-Message-State: AOJu0YzEA4mRW/k4/+p/AEz5udXWkdi1Zriid8HUsXJMtwpxOvYt7LIX
	tpAs1yDyUh1ePBWRtVCVg8SNLTtBV0RsGo8xjqXT
X-Google-Smtp-Source: AGHT+IGWFWX4nZPEY4/r2GM+zJBz8aBYpVp3/NycgX3NsxoWQhG2nQBJqmmnxJUC/Y8LXiDmxbnvm64m3VvefvSfC3s=
X-Received: by 2002:a25:6987:0:b0:db4:158:b9d9 with SMTP id
 e129-20020a256987000000b00db40158b9d9mr12095112ybc.1.1701097392639; Mon, 27
 Nov 2023 07:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs6WafDBtSbcLpoyWehQyBPNeX37PvsP6HzSotXr3dYLg@mail.gmail.com>
In-Reply-To: <CA+G9fYs6WafDBtSbcLpoyWehQyBPNeX37PvsP6HzSotXr3dYLg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Nov 2023 10:03:01 -0500
Message-ID: <CAHC9VhRrxX=LcXmLxyMwF6_rZEEYO+5DG_3EaeWsAoVY9CuSXA@mail.gmail.com>
Subject: Re: lsm_list_modules_test.c:104:22: error: 'LSM_ID_IMA' undeclared
 (first use in this function); did you mean 'LSM_ID_YAMA'?
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, Casey Schaufler <casey@schaufler-ca.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 5:43=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following build errors noticed while building selftests lsm tests for x86
> with gcc-13 toolchain on Linux next-20231127 tag.
>
> Build log:
> ------
> selftest/lsm/lsm_list_modules_test
> lsm_list_modules_test.c: In function 'correct_lsm_list_modules':
> lsm_list_modules_test.c:104:22: error: 'LSM_ID_IMA' undeclared (first
> use in this function); did you mean 'LSM_ID_YAMA'?
>   104 |                 case LSM_ID_IMA:
>       |                      ^~~~~~~~~~
>       |                      LSM_ID_YAMA
> lsm_list_modules_test.c:104:22: note: each undeclared identifier is
> reported only once for each function it appears in
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

A fix was posted last week and should be merged this week, lore link below:

https://lore.kernel.org/linux-security-module/20231122160742.109270-2-paul@=
paul-moore.com/

--=20
paul-moore.com

