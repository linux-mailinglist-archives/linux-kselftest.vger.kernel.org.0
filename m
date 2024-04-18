Return-Path: <linux-kselftest+bounces-8337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668078A9D04
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 16:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2785B21FA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781B16C864;
	Thu, 18 Apr 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loFSIq6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082F16C858;
	Thu, 18 Apr 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450382; cv=none; b=aPUKUAmUS+rNm+M5c1xuN+PPA0yXav0SzroBk5naI8xKyT5D50mv0bE55iOscpQqFiECtoEE16hfGtmpJgEme2nycmRfYAPEJaA3ty/hmQ7/QFvZyA84TmJXHoi6FQp98PWvpa50pCUjmcMp9tRNl2twkSwtcNY74raW0v+sw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450382; c=relaxed/simple;
	bh=NKUkEPIklzmJ1VCVBbGNRjPGz57f0h8ntN9uXkQajjk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FdCNFNnjf2dy4Zq6euhi7Z1tGq/yyfr/PJ2mrhQjpxzzL9eBALd6S2mh7qfIlD8/PwfwDhXg5yLZ5Rh0DaH1axj/7oPsdgt0US9x+N+nQIapR/rABs1N4xrBWXhIHbbLM5RZGY4RZsXkgrjKBlWbHwUlSAbnxdK7KCyNKJytv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loFSIq6d; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69b5dae6a64so6089136d6.1;
        Thu, 18 Apr 2024 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713450380; x=1714055180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsTAroBld3Lv4aVO9NgvWx479z4kAgXhu6kHj54mUHY=;
        b=loFSIq6duziGqRxukSZzwYcOEdjBBrKEE7YO0mX7JnCxLrDBvLJWNd7cOS61ep9/Ys
         oaJq+hpVR9M9+rAK6FLxuMH5WeKCnFWLMJAbNlLpHCRYzuaiJdvRNwsSafiVSkqbZ2F2
         ZnKh2xTqa6HUOfaIVFK0Im+v7+YDQ7jc1NLztcOzrtdgrYvxK1LiSiI3ZyJ/mD4d0k3b
         Mcys3qGT0MVJKvWCttXam1ZjbhE1s5FM6k6QBSC2Ff9rXPAZ2mkXqNygDMKyitma7eML
         yPwBUUcRY3gtTuMgsYpjU5sYhfuQrSa+polMG3ZInud7gFm+Ufe2SQLe7Qb7Q8/VkMTA
         qy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450380; x=1714055180;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IsTAroBld3Lv4aVO9NgvWx479z4kAgXhu6kHj54mUHY=;
        b=Q+/DkWmJiKn6AmtvDyXgeDyQJv+Gl6BAlymEMWK271z3zzCa3vsu7C3cymwrlnnaFx
         WhMTUg8u7fQmGXSqGbXwEet3Jw0TghdK7GSejwoOPmzfTDyozDay/ERHtsSHUO3En3xU
         OcYxE3p1mgFvexFJG4EHxpHgIW1r4L05K7xuF1ww/AjijCpUD3C2DhU4NMwWgLg+3gJd
         mB50JlJM8TJ9xVp6xFcmuyITo4FpErt0WUwHaeZjkA1DhM78Fm+36JvJ7k/bhUEyXbj8
         1J5dY/oR6ppR3QEm+FDGBQu6BqGaY3rZXZMiD1ospd89jgRXp4ynsWcJsZ8tSxonbjCM
         UGcg==
X-Forwarded-Encrypted: i=1; AJvYcCVlIodUR0BPkhc0PJ4DmMCe/kGXAJRa4dP6aMJt3WhcrIe6yk2e/LPBvYq6oiDJLokKazfzcj97BlF18UihCp7o3gJ+Qqc8hl04gBt6YX1c
X-Gm-Message-State: AOJu0Yw5KGJxsXywb5p+cAxW8e7UEW0W09uWIQkz34U8yFPiqHpY5inq
	cDV+9M6+lzpNm1Kek6ogh100vaAyz5lruWIyfazuKDoqN/FNj2OV
X-Google-Smtp-Source: AGHT+IE3feTiXzbJC7Z5nnNctPK0a392cMa5qBloNAylckMeXEjIZ/8U5UXjos4OmdZG397Og92agQ==
X-Received: by 2002:a05:6214:c83:b0:69b:51d2:3ff with SMTP id r3-20020a0562140c8300b0069b51d203ffmr3884015qvr.24.1713450380075;
        Thu, 18 Apr 2024 07:26:20 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id i9-20020a0cf109000000b006a04a3d4fbesm690041qvl.56.2024.04.18.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:26:19 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:26:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <66212d8b82945_ec9b9294aa@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240417231146.2435572-8-kuba@kernel.org>
References: <20240417231146.2435572-1-kuba@kernel.org>
 <20240417231146.2435572-8-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 7/8] selftests: net: support matching cases by
 name prefix
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> While writing tests with a lot more cases I got tired of having
> to jump back and forth to add the name of the test to the ksft_run()
> list. Most unittest frameworks do some name matching, e.g. assume
> that functions with names starting with test_ are test cases.
> 
> Support similar flow in ksft_run(). Let the author list the desired
> prefixes. globals() need to be passed explicitly, IDK how to work
> around that.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/ping.py |  3 +--
>  tools/testing/selftests/net/lib/py/ksft.py  | 10 +++++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index 7dd197836ff1..58aefd3e740f 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -24,8 +24,7 @@ from lib.py import cmd
>  
>  def main() -> None:
>      with NetDrvEpEnv(__file__) as cfg:
> -        ksft_run([test_v4, test_v6],
> -                 args=(cfg, ))
> +        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
>      ksft_exit()
>  
>  
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 25f2572fa540..fe4025dc5a16 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -81,7 +81,15 @@ KSFT_RESULT_ALL = True
>      print(res)
>  
>  
> -def ksft_run(cases, args=()):
> +def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
> +    cases = cases or []
> +
> +    if globs and case_pfx:
> +        for key, value in globs.items():
> +            stats_with_pfx = bool([pfx for pfx in case_pfx if key.startswith(pfx)])

stats -> starts

for the reader, just spell out prefix instead of pfx?

perhaps less pythonic, but just

    if key.startswith(prefix) and callable(value):
      cases.append(value)

?

> +            if callable(value) and stats_with_pfx:
> +                cases.append(value)
> +
>      totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
>  
>      print("KTAP version 1")
> -- 
> 2.44.0
> 



