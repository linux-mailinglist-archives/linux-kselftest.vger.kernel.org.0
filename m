Return-Path: <linux-kselftest+bounces-20327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12D89A921A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 23:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B66284471
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75EC1E2830;
	Mon, 21 Oct 2024 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5irPlnb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB031E22EE;
	Mon, 21 Oct 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546462; cv=none; b=ZlZCN4A1sLd0XXb2MK6Hcp14hgRHEifA7dKdM4QCWzK4U2ef1PvaRibBOgvOPeWpRy8UJy8vfVgOEUThhxdpjaeQ8Zrcfwm884Y9m3I15sFvIQmQlxPnTSW+Vxy21zbMPk+wUIy0/WZ6otxUpUhh3bZ6QtjR1aGHZJJCofsTIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546462; c=relaxed/simple;
	bh=72De2m6CuEoBK6qdyabKnMLZQNHcaEaT9izzqI5EAPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGBmvHEN24hmGSOkHbjP6YDhdTCK492lPLk9N0lDowHT6dEX+FjyBauhl+4numPTOdN3c+URLyadnaQj33H3M54Tvt4NX53Ic2fJcGKHFBOoqjAmFC/bcTBMx+pT+UaB+ZN9um1tz7mKsf3L2sxyGnK4Xh1neb4qeyxnaz8nSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5irPlnb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so5745098a12.0;
        Mon, 21 Oct 2024 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729546459; x=1730151259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pS/AikCpps8muRk+3laCVn6HEgGEdqX7SYVz1C2hea0=;
        b=X5irPlnbRe5PjYF77t/8ayrzhyJZ0gHFidxbs6FHQIuu5/ktUsNRi1rc3yfEUZRbCW
         dJXyItUYPyYoYyV94OvUNc8dLfkn0sC9O8Z25Xrn4Q4YSNaQYeN7aFU4cCuf2FFLdx8V
         Elqx1JSMquAuiXgMoQFydw/7GGc7FxWQj/GMbAGSVn8mCmWwET1GJufFpEqsrg2J9nHN
         3TOK5+TEvDH+0b6ppSr4WHeT6Tg4itcFAGxz785UlmhJLQvoM6gOkH+ODJnASAEY0wdI
         zhyJpHgPxa/5po47qAlYUeU56yKnyTXdtpRTKfeBgOgIQDJyC+X+TljTgAv23zd2RcEz
         oWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729546459; x=1730151259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS/AikCpps8muRk+3laCVn6HEgGEdqX7SYVz1C2hea0=;
        b=OKJ40Bc9+SQSpWrtFmswhfnIWibbAm8KN30BS2uLF1r+mPxr4zkGxj8r7SxS/cekz3
         ggHExwtNtwWoR00lcJaFoxwpq2TcKiuTvAEGMxtXRF3GcrP/3gP1n7/Pna2SwUsVpTrp
         Ef3eM0VBewic6xs3YFtzCUHQkUux7nFE3E/q+pEXTLskOLEMFn7nNXppyUccgiltLhVr
         lP2/Kk3ljP6trtxDsBqLWeNSJfosXmRJ5m2UPq4HXOnCoHWWwiAKpK+G3kMqZMHKVy3i
         MBevj+kHTVRLrgRLTmZZ4oKmd0CLbU3odg+G4PC85K20f0sHmqKi8VCskd/TNnuW7K8X
         08cw==
X-Forwarded-Encrypted: i=1; AJvYcCUt9y3z0lt9WX4kBwqKibwwgGhrumla+GoFcLM2FenFEw2nBcFUgg8M24rfSA8lgmNJ2N4EqQLFMyVqIVk=@vger.kernel.org, AJvYcCW8kASYvBRXn6KuxYG0tHL9C6Qo8LwB3JhP6P30LCOB6KQ2ng/xOknCT1NJypsrMlRmYVBFHgKiurb1nEh12L68@vger.kernel.org
X-Gm-Message-State: AOJu0YwDhqULEFDsotL7xBhtfhNtr6miwPlr+XJw/xrnJSUAcj5U3KWa
	icWDrpLsXqeVwN/mxtWSwvEnJh/3WjA06kQMZsrmh5TvkacnRYJ/U9zUEdLvcGi/Xmu3zjSKOP4
	0rKPhLYykVKcnzCzoWvKoeK8nzPI=
X-Google-Smtp-Source: AGHT+IH4rKFYUx2xJcrjXdIVDZcgiWLxRXRDfm8y7roqWODKxpVWTZKV+3I/+D2uJUGd1UrnzvHaoG/AZgjPCqZ0+ig=
X-Received: by 2002:a05:6402:4011:b0:5cb:6b2c:c139 with SMTP id
 4fb4d7f45d1cf-5cb7fce39fdmr213901a12.13.1729546459289; Mon, 21 Oct 2024
 14:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014172149.324639-1-alessandro.zanni87@gmail.com>
 <41d157fc-6413-4061-95af-518ec7b923f1@linuxfoundation.org>
 <4hxgkaxray75k2z4zyhhq6nb6iegsfokhsv6gdthai7bfzbpnw@6doocomldm6m>
 <CABq9Dx6b0TxXfvsmaaAMG+O=x8v3pD4CY2TTowcGzkL2q=Q1Yg@mail.gmail.com> <583282bc-17b7-4c7c-8e94-44d720c09682@linuxfoundation.org>
In-Reply-To: <583282bc-17b7-4c7c-8e94-44d720c09682@linuxfoundation.org>
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
Date: Mon, 21 Oct 2024 23:33:43 +0200
Message-ID: <CABq9Dx5DDJXO3Xc+F_2o86xxfGJD35u39o1nmBkhbBqDo=HS5g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/intel_pstate: fix operand expected
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On 10/21/24 09:04, Alessandro Zanni wrote:
> >> On 24/10/14 06:05, Shuah Khan wrote:
> >>> On 10/14/24 11:21, Alessandro Zanni wrote:
> >>>> This fix solves theses errors, when calling kselftest with
> >>>> targets "intel_pstate":
> >>>>
> >>>> ./run.sh: line 90: / 1000: syntax error: operand expected (error token is "/ 1000")
> >>>>
> >>>> ./run.sh: line 92: / 1000: syntax error: operand expected (error token is "/ 1000")
> >>>>
> >>>> To error was found by running tests manually with the command:
> >>>> make kselftest TARGETS=intel_pstate
> >>>>
> >>>> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> >>>> ---
> >>>>
> >>>> Notes:
> >>>>       v2: removed debug echos
> >>>
> >>> See my comments on your v1. It would help to wait a bit
> >>> to send v2.
> >>
> >> Ok and thanks for the comments.
> >>
> >>> I can't reproduce this problem on Linux 6.12-rc3.
> >>> What's you environment like?
> >>
> >> My kernel version is 6.12.0-rc3 from "make kernelversion".
> >>
> >> I think the errors are related to the bash type and version, rather than the kernel version.
> >> My bash version is: GNU bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)
> >>
> >> In fact, some shell do not complete expressions in variables and $var and command substitutions
> >> are done before the arithmetic expression itself is parsed.
> >> That expansion happens without regard for the arithmetic syntax, so with $var you can mess
> >> with that.
> >> So, I suggest to avoid to use $var inside a arithmetic expansion in order to be cross-platform.
> >
> > Hello,
> > any thoughts about this patch?
> >
> > Were you able to replicate the error?
> >
>
> Yes I was able to reproduce what you are seeing.
>
> >>>>
> >>>>    tools/testing/selftests/intel_pstate/run.sh | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> >>>> index e7008f614ad7..0c1b6c1308a4 100755
> >>>> --- a/tools/testing/selftests/intel_pstate/run.sh
> >>>> +++ b/tools/testing/selftests/intel_pstate/run.sh
> >>>> @@ -87,9 +87,9 @@ mkt_freq=${_mkt_freq}0
> >>>>    # Get the ranges from cpupower
> >>>>    _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
> >>>> -min_freq=$(($_min_freq / 1000))
> >>>> +min_freq=$((_min_freq / 1000))
> >>>>    _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
> >>>> -max_freq=$(($_max_freq / 1000))
> >>>> +max_freq=$((_max_freq / 1000))
> >>>>    [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
> >>>
>
> The patch is fine. I applied and run it. I found another problem
> when cpupower command doesn't run
>
> # ./run.sh: line 89: cpupower: command not found
> # ./run.sh: line 91: cpupower: command not found
>
> So you would have to check if min_freq and max_freq are valid
> and don't continue if cpupower isn't found. This test depends
> on cpupower.

Thanks for the feedback.
I'm going to work also on the cpupower issue.

> You can do that as a separate patch and send it as a series with
> commit log changes I suggested on v1 of this patch.

Ok.

> thanks,
> -- Shuah

Thank again,
Alessandro

