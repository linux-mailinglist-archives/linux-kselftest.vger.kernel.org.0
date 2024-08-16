Return-Path: <linux-kselftest+bounces-15483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F43D9540B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 06:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534D81F25BEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9374977F1B;
	Fri, 16 Aug 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QNTNwwy1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119510E4
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723783901; cv=none; b=XWvvkx4MSVelKPX7RBp4eEQQP/dmeAGIOr/UB0j65MuZWNgInot1nxwlNN4sy4e2lH41i/0AymZMzKwpoTrbMytSopWreuKrUBg7P0Pmxtk1Bu9R9CMw/5bQXeGK5vk48SoHTwQrV4En8DVFFXBYe6m3TI+sPeyT0/B2MPuEMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723783901; c=relaxed/simple;
	bh=PP787mnpyQPiRJely5CPAAgYXfHEqHIW48jArRmUmss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiVwLDH4GsSQwm/Pi06pJj3ECS/+G2Q9E9lz6AuSUkjWkcfO2RH7CdfDbu/owVbb3rQSpGnfnBFyMgNUcCMWdNOywcmHujsH432opltYJsyIgcjjJdYSzQ2aPbwmLU0lJNN5wz6hRf3oKZecEwOGloWq3n/ThpZPCJ2EJcXBPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QNTNwwy1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-66a048806e6so16927887b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1723783898; x=1724388698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0SLUkNdmlUCCCnO+rMdels7NZPrmWYQ4Oiryow/Vx8=;
        b=QNTNwwy1r+sKi+Mx2H1VhBQnDfCGLxY8PrKR5qaTGN7v6jSu/WlHJRYcwjbSfnIRP6
         tvjb6wqjMm4dUzk72HKIQ7de+5H8Ta3gpNDvQromU7iItt10J+0rytv2iEdgcTAtQXoy
         39bcgdOB3+K+VKR1rhqF1LhxECvUBc4pGHiPKCpymOjmLmmc3Xg6+B6weMvAW0Oq1HfY
         uCk6NxQ/c36n+sfBcy07q0GNA1Fz38PHLZCSe8fdq7tf+ATbS+FGkyvSUstN84F6J+ux
         hegZqlZtbZ70r6odLnDMrtikpn4Bg7BQ8QIaMue93rI8Z4fBsH+okOJeuMAV+5S/dysU
         hZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723783898; x=1724388698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0SLUkNdmlUCCCnO+rMdels7NZPrmWYQ4Oiryow/Vx8=;
        b=MoyGlRsb1+DUeOYQ0cRQ5/kdfDTeEqZqBQZ1lcH1WDzXrBqpLGUWBZmqXL0ktTU6Ff
         g8Fic94kWNoBpG1d8icMpBnQ8QI6ovNBZQuxa3BIYE209+O0/ULDuR867UBgAdW1hYGb
         c/5JaLnlvPBS9pw4Xe5p9LjfIXBpJfsiyYyoVpcFSd/CEeq8hGlwmvRQlB6Mx2fgceHK
         /tkisfkDGLjmA/AGCrPR4NK31rAInbEDu7vnTS7ejVt+1V7+mhw0FLLdnRARR/Pgx5wM
         6AGiJWMO8DIg9kdiZHF/wQTpPwgQO3IsRvBEFRhG8C34OWNgA2hnD0YsVICOHyouIOlX
         vmPw==
X-Forwarded-Encrypted: i=1; AJvYcCVq9ckTwFRmmLye+3ER0juIU6R+X/bLVNdawOPqGZCytpPiHFh0my27HxdORz6Blc7bb1mLZvePg9d5ZqAW9w64518GM4I1HJIec57NgR6T
X-Gm-Message-State: AOJu0Yw2CVBerru1XIb4EVlnDXq0wzNg9dAZ6evTksfeDgnfHnSl4RHC
	DYeHLgNAq/LSg67HobleAYGzEa8nWKxMYt4IAPzQqosZ6d1zBLCWpeznJhBR3ArzIWQS9v6RemQ
	alMllAcNVZi84v8voW33LG0Pmn9xo5ApZOkv8
X-Google-Smtp-Source: AGHT+IFgMDMHKSSts+gPn9jVeCV5w2kbLH2a+iHrWwU6hHZZ0EIJP9f60mGv6z4sKbZOQzEg9LK332QkL9R4LZvz9Vk=
X-Received: by 2002:a05:690c:60c2:b0:6b1:173:514d with SMTP id
 00721157ae682-6b1b7e5ff81mr19493517b3.14.1723783897732; Thu, 15 Aug 2024
 21:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815-tdc-test-ordinal-v1-1-0255c122a427@kernel.org>
In-Reply-To: <20240815-tdc-test-ordinal-v1-1-0255c122a427@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Aug 2024 00:51:26 -0400
Message-ID: <CAM0EoMnJq9GfapaueCkOWVUH81kTFRbuuwpweVo472X5tUHxsQ@mail.gmail.com>
Subject: Re: [PATCH net] tc-testing: don't access non-existent variable on exception
To: Simon Horman <horms@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:37=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> Since commit 255c1c7279ab ("tc-testing: Allow test cases to be skipped")
> the variable test_ordinal doesn't exist in call_pre_case().
> So it should not be accessed when an exception occurs.
>

LGTM.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> This resolves the following splat:
>
>   ...
>   During handling of the above exception, another exception occurred:
>
>   Traceback (most recent call last):
>     File ".../tdc.py", line 1028, in <module>
>       main()
>     File ".../tdc.py", line 1022, in main
>       set_operation_mode(pm, parser, args, remaining)
>     File ".../tdc.py", line 966, in set_operation_mode
>       catresults =3D test_runner_serial(pm, args, alltests)
>     File ".../tdc.py", line 642, in test_runner_serial
>       (index, tsr) =3D test_runner(pm, args, alltests)
>     File ".../tdc.py", line 536, in test_runner
>       res =3D run_one_test(pm, args, index, tidx)
>     File ".../tdc.py", line 419, in run_one_test
>       pm.call_pre_case(tidx)
>     File ".../tdc.py", line 146, in call_pre_case
>       print('test_ordinal is {}'.format(test_ordinal))
>   NameError: name 'test_ordinal' is not defined
>
> Fixes: 255c1c7279ab ("tc-testing: Allow test cases to be skipped")
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  tools/testing/selftests/tc-testing/tdc.py | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/se=
lftests/tc-testing/tdc.py
> index ee349187636f..4f255cec0c22 100755
> --- a/tools/testing/selftests/tc-testing/tdc.py
> +++ b/tools/testing/selftests/tc-testing/tdc.py
> @@ -143,7 +143,6 @@ class PluginMgr:
>              except Exception as ee:
>                  print('exception {} in call to pre_case for {} plugin'.
>                        format(ee, pgn_inst.__class__))
> -                print('test_ordinal is {}'.format(test_ordinal))
>                  print('testid is {}'.format(caseinfo['id']))
>                  raise
>
>

