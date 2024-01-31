Return-Path: <linux-kselftest+bounces-3880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D68448DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD184289703
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1FE131E5A;
	Wed, 31 Jan 2024 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP6k84EO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD33130E3C;
	Wed, 31 Jan 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732857; cv=none; b=uMoY9kZAa0F7f1yp9UHqx7NgG5eIhEhDvk/uVm0VG2G30l4c030h6ySFlYJAUfKQj3of25ze0B7B2axS8tAsw+3htogRie5ez6mkLGXY8g7ePIy1USgk1u6xG4hH1lWSSrmE8pP05cooKMKjCLA4voZvMoSfEJ2xazZj6e3ChGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732857; c=relaxed/simple;
	bh=WzSzwBPdudJ262CG6Ols7AJ5XlrNJk0qQyTEu0ShNz0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mBoahajbVsKcvxuLUwvF5uuY5vPdx8YM+MYXOohHL291JyaxdXUz4hwDS4LW08WqF/pl2aEaB6vIV7g6cugaQ1eCuTC5eVVoKZc72WvrNFj0AUxLI6eFX72XcGJ+yFtkn+ZpOinGGJyune/TBqpC+id3WcsU9ZYh9z9qxg1apNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP6k84EO; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bebc25da94so128581b6e.2;
        Wed, 31 Jan 2024 12:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706732855; x=1707337655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOUcYqy9EC5gFvTqCNhoV5GMF3JPe9eKJnFbf/tP3aY=;
        b=CP6k84EOIQpkoDU1rOIjh824RDivrBanMM6yR5br3LLpJzQe310zJwWp0JTIoic63t
         LUF8nsd28edMNItZn8LoSZGzNV8MfZfil/d9MkAXKnOae6rYf8QPD1T84dUWXQm5dnIy
         fbYnJnRGBmBXdCzReq6ZpRWWN/L8v7KFgtrBBxbKKIUAF3vMUnR8EEdaQizDX1wVYO3u
         qh1XiZ6hqVotx3IDyY80Ece4b2m3QS1MvXAlMUIYxeZRj17rkmbAccDD1Fv4vTfH/FB3
         2WMXDm/QRYhSwAvBEtNTmTulT1eISZ8IC9MzFxkTwWk8kQCUdR+saJDKZMcitvmijiW8
         TiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706732855; x=1707337655;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aOUcYqy9EC5gFvTqCNhoV5GMF3JPe9eKJnFbf/tP3aY=;
        b=uWXfSCu11LSr/8I55lmsf28iqRFTE0UTIUKW6xxeeyOJiwyQ1/EzVb/IVVDO3a9+Ea
         /G5AcNvuDJ++P86FtNzecYhjAphTy3rQEvRW0eG1rfflMnF/Ml635gthkFUH0Nj4qsxb
         /V5xTbUYtjFMLvrNVi8vPvFf0CoD2S2AKGyczUceqhoVcixQA80uFslbdBJBTK4l38/Z
         QzqmgUcDuky9jX+03CPujhOoQQUMID/vRPJAz5F+4KjfJxXFYK1VHndR4mwOTBW9DhmZ
         ImyWTMsXP7aeEb46AFRYSrPrrC+Lmyc1AmI8RQlyK17Vm0naYMUqsH2nqmJDjOb1PNEi
         9GkQ==
X-Gm-Message-State: AOJu0YyZatsf0z5uecQ9tnTZ9cYUjWSNxB5bKEmP39+8iXnO3wr7AefP
	LWMArlcr/elUXQ2iGc2U5jI2MmTSDzkfoqIyMxMiO9CF876T/4Wt
X-Google-Smtp-Source: AGHT+IEWNwRNc/1r7tpn00tffmMvRJ9Bt9aHwqnL56kiJqeUSPJtZsMGOr0j11FeuUV2XUY70L9P/A==
X-Received: by 2002:a05:6808:1508:b0:3be:53f8:de8a with SMTP id u8-20020a056808150800b003be53f8de8amr3413588oiw.56.1706732854837;
        Wed, 31 Jan 2024 12:27:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUWORy331POupFh5HmzPQLolP4RHfyrA6zCClriw+PMwRQtGY/WvVVXuNgqUzuHUHFGBUmJBwY7bp81Z47ANJ4Y9ULe+Rp+ufR08PCFFIT7MdizPnzOjTJj+1ZlMG0TQVlu3yE8CwJ0HrAGrZZtZfKn88O01kVyDEVFyVuCOIGMAmhrK4xENhqa0mRmCScCqwgAnAHNxP2mDyVE19jBOmKFe1AK+lcTuqeKb+8Mokpx4ye1K1EF5Nsl4qmX9H9Q8KIr
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id fd12-20020a05622a4d0c00b0042aa41424e0sm3496543qtb.83.2024.01.31.12.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:27:34 -0800 (PST)
Date: Wed, 31 Jan 2024 15:27:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <65baad3627cef_1b52d2294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240131102932.6caac1e2@kernel.org>
References: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
 <20240130174736.03c79071@kernel.org>
 <65ba61ea978b4_1699fd294eb@willemb.c.googlers.com.notmuch>
 <20240131102932.6caac1e2@kernel.org>
Subject: Re: [PATCH net-next] selftests/net: calibrate txtimestamp
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
> On Wed, 31 Jan 2024 10:06:18 -0500 Willem de Bruijn wrote:
> > > Willem, do you still want us to apply this as is or should we do 
> > > the 10x only if [ x$KSFT_MACHINE_SLOW != x ] ?  
> > 
> > If the test passes on all platforms with this change, I think that's
> > still preferable.
> > 
> > The only downside is that it will take 10x runtime. But that will
> > continue on debug and virtualized builds anyway.
> > 
> > On the upside, the awesome dash does indicate that it passes as is on
> > non-debug metal instances:
> > 
> > https://netdev.bots.linux.dev/contest.html?test=txtimestamp-sh
> > 
> > Let me know if you want me to use this as a testcase for
> > $KSFT_MACHINE_SLOW.
> 
> Ah, all good, I thought your increasing the acceptance criteria.
> 
> > Otherwise I'll start with the gro and so-txtime tests. They may not
> > be so easily calibrated. As we cannot control the gro timeout, nor
> > the FQ max horizon.
> 
> Paolo also mentioned working on GRO, maybe we need a spreadsheet
> for people to "reserve" broken tests to avoid duplicating work? :S
> 
> > In such cases we can use the environment variable to either skip the
> > test entirely or --my preference-- run it to get code coverage, but
> > suppress a failure if due to timing (only). Sounds good?
> 
> +1 I also think we should run and ignore failure. I was wondering if we
> can swap FAIL for XFAIL in those cases:
> 
> tools/testing/selftests/kselftest.h
> #define KSFT_XFAIL 2
> 
> Documentation/dev-tools/ktap.rst
> - "XFAIL", which indicates that a test is expected to fail. This
>   is similar to "TODO", above, and is used by some kselftest tests.
> 
> IDK if that's a stretch or not. Or we can just return PASS with 
> a comment?

Flaky tests will then report both pass and expected fail. That might
add noise to https://netdev.bots.linux.dev/flakes.html?

I initially considered returning skipped on timing failure. But that
has the same issue.

So perhaps just return pass?


Especially for flaky tests sometimes returning pass and sometimes
returning expected to fa red/green
dash such as 

