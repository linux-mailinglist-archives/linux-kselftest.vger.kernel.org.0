Return-Path: <linux-kselftest+bounces-20275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE3E9A6D90
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 17:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435F51F22539
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD11F4731;
	Mon, 21 Oct 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKA+ZeFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC21EBA08;
	Mon, 21 Oct 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523093; cv=none; b=C4s74bD0J4N6QEwAgqTyACuHZ1Wcxp3D2CJQ4kVVodnG/AVM17EHnkEfaqnaQgckY+BL6Cmi1lOlUpPxUxkSp6zuxo3XbRMqKi5dCRHILGiK/R0EWjUYE31THAyMgRXaC1hvSrSJeT8ed0V04QKnnZmFyuI1XBmq2ycqQ93N3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523093; c=relaxed/simple;
	bh=YpyR+0oK6sTRh5iMM2mhp9NQ7lGx0lwNLgFecx7Zzgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3lvN9a9MU2kvkgySrHINkFYeATzkOYTXBYfChek/L/9nONa8NuF4PcSq8j6EVMx06mc5yWw56YgXKWAa5rfjkIjSqq0p/QVOQsL+l8tWh90rjG+2leMyaKtaWWq5mtjWRG9DorD6RVLYHz4pw3By4jO4J02Gl6vgjZAUlnYNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKA+ZeFK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so5349742a12.0;
        Mon, 21 Oct 2024 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729523090; x=1730127890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/JRIMg2z82gb0miw9gdPsnIiJdQXVNTFbR+DAY8GrU=;
        b=DKA+ZeFK0DcrUvnkVlZBmQbzLxHIk18ytUan+O3rRVuIs9k7KXw8+Qbld8zPGkEzBk
         XzeZKbNGVfDaxs2C7U17Zh7fme97TsM/YE4SmNXC/eNb13CtFu7LIFSAVtNMehGV10jj
         iwI1PqU/yWYctorNDiXAz2P+Y4M9d6M322BFVNcaGqCywBu2Mvhq+Eu2fReUhDyEMlLQ
         xQhLOtoFJekR4m5dn1qzsxYkNPX3tG+jMg9tI16FwhQhjP7h3dBeJO1oSnndv8CyCpFH
         QS6liK/KEoRyFAtNGoKoY5XLK5j64IuDlmp2Lwiw8wiHblMr4+vDvY6A/S52ViPhUorQ
         TN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729523090; x=1730127890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/JRIMg2z82gb0miw9gdPsnIiJdQXVNTFbR+DAY8GrU=;
        b=WOPikS23M8HKi3rAjgR1Jp3aqK6Txmqn0xQzjO+2IR1Ohp0egIWLVOpR9bghyk1Fw7
         LANKbZgMp9i850ei75nIkdYmEuvC/oPzswX+XahO9xDmfBHMJOfUYcu3smnWUnaRU8Sq
         JsWmz9H0OpROB0iQGosXvT9RWytZhu0Jt06OymVThkchckLlzWSnIBGgx8a0hxjZXP10
         QlhE1N+pqDNW4tlvT8RUvTMSKPYkRgC0Vi0UjvkwFhy1gBX6hfRUsGHq5qL+hWSPYJBB
         R13nCk5qeYAe+cEkS+7e0HFhewVTCOuuTfnVPqG4q0485X+HHWc1s9bh3qOFxD7q1iwP
         YXKw==
X-Forwarded-Encrypted: i=1; AJvYcCV44KRX+xyTk6E3jPpVp6UKuMmIrDkaMVsFjJAZxu7OjB45bmUGKDNtXL8VDz/7tDjMy+l6Acbs1OylGXE=@vger.kernel.org, AJvYcCWB0oRPf/sPK9zJUd2O82N3M2LUyAD1NExRiYXL7l88/rMe+lWpVag2PhQpRu7a4YE+u1JlT+O+5k8Cnkov42LZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2TZqzMmruN/mrjb8ivJSTRzvwmNdIEnevyRH07VPCb4w+LZLK
	tM9ztqUXDgN4vPWYNa9Ad2SirhEWqasiut0pScaXw9YCBjdMESXwwsYhC5R1gOSlXfzOPAtEFeZ
	/1ndZ6wUt0m0wD8emCxk7S7VwiU0=
X-Google-Smtp-Source: AGHT+IHNUDkn7YmuzYRyjxAXSLvzGs3jkNwapjUsiQvvFToFgyk5dU2LfTFToOW2bJY0IS0ThCPlDb/4DawJHeu7tNE=
X-Received: by 2002:a05:6402:270f:b0:5c9:5a96:2869 with SMTP id
 4fb4d7f45d1cf-5ca0ac85068mr9895133a12.10.1729523089591; Mon, 21 Oct 2024
 08:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014172149.324639-1-alessandro.zanni87@gmail.com>
 <41d157fc-6413-4061-95af-518ec7b923f1@linuxfoundation.org> <4hxgkaxray75k2z4zyhhq6nb6iegsfokhsv6gdthai7bfzbpnw@6doocomldm6m>
In-Reply-To: <4hxgkaxray75k2z4zyhhq6nb6iegsfokhsv6gdthai7bfzbpnw@6doocomldm6m>
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
Date: Mon, 21 Oct 2024 17:04:12 +0200
Message-ID: <CABq9Dx6b0TxXfvsmaaAMG+O=x8v3pD4CY2TTowcGzkL2q=Q1Yg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/intel_pstate: fix operand expected
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On 24/10/14 06:05, Shuah Khan wrote:
> > On 10/14/24 11:21, Alessandro Zanni wrote:
> > > This fix solves theses errors, when calling kselftest with
> > > targets "intel_pstate":
> > >
> > > ./run.sh: line 90: / 1000: syntax error: operand expected (error token is "/ 1000")
> > >
> > > ./run.sh: line 92: / 1000: syntax error: operand expected (error token is "/ 1000")
> > >
> > > To error was found by running tests manually with the command:
> > > make kselftest TARGETS=intel_pstate
> > >
> > > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > > ---
> > >
> > > Notes:
> > >      v2: removed debug echos
> >
> > See my comments on your v1. It would help to wait a bit
> > to send v2.
>
> Ok and thanks for the comments.
>
> > I can't reproduce this problem on Linux 6.12-rc3.
> > What's you environment like?
>
> My kernel version is 6.12.0-rc3 from "make kernelversion".
>
> I think the errors are related to the bash type and version, rather than the kernel version.
> My bash version is: GNU bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)
>
> In fact, some shell do not complete expressions in variables and $var and command substitutions
> are done before the arithmetic expression itself is parsed.
> That expansion happens without regard for the arithmetic syntax, so with $var you can mess
> with that.
> So, I suggest to avoid to use $var inside a arithmetic expansion in order to be cross-platform.

Hello,
any thoughts about this patch?

Were you able to replicate the error?

> > >
> > >   tools/testing/selftests/intel_pstate/run.sh | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> > > index e7008f614ad7..0c1b6c1308a4 100755
> > > --- a/tools/testing/selftests/intel_pstate/run.sh
> > > +++ b/tools/testing/selftests/intel_pstate/run.sh
> > > @@ -87,9 +87,9 @@ mkt_freq=${_mkt_freq}0
> > >   # Get the ranges from cpupower
> > >   _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
> > > -min_freq=$(($_min_freq / 1000))
> > > +min_freq=$((_min_freq / 1000))
> > >   _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
> > > -max_freq=$(($_max_freq / 1000))
> > > +max_freq=$((_max_freq / 1000))
> > >   [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
> >
> > thanks,
> > -- Shuah
>
> Thanks,
> Alessandro

Feel free to indicate if I can provide something useful for your evaluation.

Thanks,
Alessandro

