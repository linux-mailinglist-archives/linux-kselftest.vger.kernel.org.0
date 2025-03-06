Return-Path: <linux-kselftest+bounces-28409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9060A55001
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B401888210
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E101991C9;
	Thu,  6 Mar 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Im1WvO6k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AF0EC2
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276948; cv=none; b=rSND+KK2aJXKsSIdxqahQKgFoYtTef5h+1lNDju451lFBAVNmn9C/+xJ1e3m+Y52kqDXQUlQqbGJ7ZpInFb93wTmO7jkL0R0UVsQBnpH4ZA0k3opoAikEwZnmCJaVct3/EAzTw6hkq6WurTAyc5QE2BwP0+ydT8skPqPhCJtNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276948; c=relaxed/simple;
	bh=6aKgQ+tug2/1fc1q/T01kVpV17q2c5r3wjQoFm7zsF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qngcw6yzh39MJwQLeWAAVqGv9PScht2VcLAian3YRro4mPU5mQ9bFReInCGi4RoOHWi/m2j/5zksoV8JmR7NMTiXafxFSbz95GME3CIfSHb6Y+RyLjhJ5K0sfvYd3AqDnfdW9jOwW4WydD54PIJFHI3eThaRVchGGf0vchdYc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Im1WvO6k; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f6970326so6140206d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 08:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741276945; x=1741881745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMo/M/d0EFIcvJgavIcd9kpQdMrMPexMxRrHFLPNiR4=;
        b=Im1WvO6k745BRyomEtOi0hyirMxpv1cuQ2QxLiqWaP9dkj5qKSrvkqgtBxUou13fUg
         FTG1aYOiIibnu+Qk4MARgpffMUUArOWb7HkeW8gS5OY3xBuAVZCtVeAI9qZruH9QqcBD
         bPIbiUWUoapNz3O5TPcAtLWxus6ebyJnewxEsfKccK6KQUEDoJKYyGwUpYoNFhkOoYTD
         heUyBVACk/COHH3dx31gwlEis2Jb/Kvbj1fcVqvgatlhPeeKtKHqUuFhvSnaAZDSi2UF
         Yb5uuqv7CJnW0yUPfPL65krGFke78RxqlUQf27T0tyLwjG11nwlxF6hB5VgS954N4dyf
         dQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276945; x=1741881745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMo/M/d0EFIcvJgavIcd9kpQdMrMPexMxRrHFLPNiR4=;
        b=sBBtD5YyLwg+PVAYL5hoBFmVWcEiN0yLnmkAP2/KrIGhTqeiVcWSfOp/ME+cXlfKCl
         FVzB/K/Dd7UzglWyTAq7QQZdchrwsdwlpzLD/9cKUinE0xjTwIOk6+8Ww4IqVDEiZ8Ky
         H32OZbRkPXWc8BNr4gLZzZciMjQCUG5esre/Vu2WhubooffhKo9IpulTpZH1mPYBeaxN
         m0it2P1LxSSeuxQBMT0w+f49dvjpIhn7EhyTOKVDFo4/N4yxR7OhW/ycZpBhyGB9Nifh
         h8OXOskwqfH+EXME0BnUG2GPVFis3AC4ONae8YNeXSVGASAsqah1njRrb4YEtXrl+Im8
         KT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6a3PLKkSUJf0jyw7cwLUoocF7D7fSZfRzYRqDxsxE4PFAYanX4p0A4roTYD0wHBVoMANz0J26CTBMAzu/Jz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykjVMmeWO+VakUuG/PK7HB9U+wPX2shSMoufN1opMjXcxwEfey
	liuLX3XYJ+l2bJ71qZkWJUeY5eiVr2pe2YWXd+XuhA8rmQ3o0Z/hmBYfZQC/uTTgGKKzuHQ8VJ5
	aWC5kMvr1mkMQeaXYfzya0xp0Df0zCdDaYV3J
X-Gm-Gg: ASbGnctqXvgerjzrltauv1lzCOT7E3S5zrVnbcvan5SSw5cXMED0GQDpR8UJBWIC7AB
	6BkHrdXDHiyv0SkwZx4g0WXZCMbZn8J1MUyxC2sTSo2u9K6JRhhDDEx4/QlDHbqrrF1zKT00U7w
	ftZF6IH+XDeV8EMjimaOxvNCEr3R253A1pTXRf9sTLSfLYJWnOVaB92mD6
X-Google-Smtp-Source: AGHT+IGX/E2PHF/+YLwoVkYYiH/aSpMz8sD+kNIhAFRSQzVHlUIXuGHEMDAwEmby3tNrlm1sVt67699NsHmIFr4orEo=
X-Received: by 2002:a05:6214:d05:b0:6e6:6699:7e58 with SMTP id
 6a1803df08f44-6e8e6d1551fmr101937866d6.1.1741276945215; Thu, 06 Mar 2025
 08:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306002933.1893355-1-rmoar@google.com> <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
 <CA+i-1C12kG9t=jqnVaKnvN4xCn58cTeph4QHOTL0+eg98rn52w@mail.gmail.com>
In-Reply-To: <CA+i-1C12kG9t=jqnVaKnvN4xCn58cTeph4QHOTL0+eg98rn52w@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 6 Mar 2025 11:02:13 -0500
X-Gm-Features: AQ5f1JqAFBgL17msmF4WXZwSYJ4ufzR46Gs0RyKsZz7of0uvV6CYwmBsv3o3TjM
Message-ID: <CA+GJov5kKD+QX+kdEG3LQun=zo_aPwbA7=1NUw0dTLSGg-h=mw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix bug in parsing test plan
To: Brendan Jackman <jackmanb@google.com>
Cc: David Gow <davidgow@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:26=E2=80=AFAM Brendan Jackman <jackmanb@google.com=
> wrote:
>
> On Thu, 6 Mar 2025 at 10:00, David Gow <davidgow@google.com> wrote:
> >
> > On Thu, 6 Mar 2025 at 08:29, Rae Moar <rmoar@google.com> wrote:
> > >
> > > A bug was identified where the KTAP below caused an infinite loop:
> > >
> > >  TAP version 13
> > >  ok 4 test_case
> > >  1..4
> > >
> > > The infinite loop was caused by the parser not parsing a test plan
> > > if following a test result line.
> > >
> > > Fix bug to correctly parse test plan and add error if test plan is
> > > missing.
> > >
> > > Signed-off-by: Rae Moar <rmoar@google.com>
>
> Thanks for taking a look at this Rae! I tried to take a look myself
> but I could not really get a grip on the parsing logic in the time I
> had.
>
> > Thanks for looking into this: I don't think we want to unconditionally
> > error if there's no test plan, though. Pretty much no parameterised
> > tests include one -- it's not always possible to know how many tests
> > there'll be in advance -- so this triggers all of the time.
> >
> > Maybe we can only include an error if we find a test plan line after
> > an existing result, or something?
>
> Since I reported this bug, I discovered that the example above is in
> fact valid TAP:
>
> > The plan [...] must appear once, whether at the beginning or end of the=
 output.
>
> From https://testanything.org/tap-version-13-specification.html

Hi!
This brings up an interesting question because the parser has been
mainly geared towards parsing KTAP
(https://docs.kernel.org/dev-tools/ktap.html) rather than TAP.
(Although we do try to have backwards compatibility with TAP v14
"Subtest" lines)

For example,

TAP version 13
1..1
  TAP version 13
  1..1
  ok 1 test_case
ok 1 test_suite

This would be accepted by the parser without error because it is valid
KTAP even though it is not valid TAP v13.

The scenario above that caused the infinite loop would be incorrect
KTAP (which requires the test plan to follow a version line) but
correct TAP v13. So do we accept it without error? Ideally, we would
parse based on the version given in the version line.

Just an interesting thought. Either way, I will remove the error for
now as our parameterized tests don't properly produce a test plan,
which causes errors.

Thanks!
-Rae

