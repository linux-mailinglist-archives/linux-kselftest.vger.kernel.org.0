Return-Path: <linux-kselftest+bounces-19723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D85499E3AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 12:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6E92846DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697F1E2031;
	Tue, 15 Oct 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWspYGx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1D1D14FF;
	Tue, 15 Oct 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987607; cv=none; b=Zo/lheU42ibLJR5XRFU88P/CPXOkmSeKMCultMCMRbAToJAFUOztJ6NYg2k7iFsBXN4TGLrJtWHjmSbwN4sFtWVNr9AQO0oOW9OL+lWiwGDV4BoADsRQbyR7OIJy9B+VhZ+9lfieYEgqN4ZY9dID7QzhzF61gOUxGrZ+lEI2lgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987607; c=relaxed/simple;
	bh=1B0r2Pee2Um10mXSL8EaHr17ztOTovZFYwJKVbLwPDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI3AZ7qyVYShsrIgEGjYoyiXTM46MQpi4HudJ/MyPFEtuMKai9rRuUW9b16J63mumMNRcAN/LJVYVgKrTj6ibZMefJe8/fTrNjAEdK8oM5l6+9jO7RVrpDLIpLHk2JrnypwpFHIAvPpi1bsyxyaRpNnVeDsTtYWpiofCxUzMZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWspYGx5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99ebb390a5so511868366b.1;
        Tue, 15 Oct 2024 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728987604; x=1729592404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEniXAgF9NWz0JqBFaEwIBfo+8JM59q1xiFtuN3f7V0=;
        b=EWspYGx5GQJMFU17LAET10d+L7JNO4GwAvuQFizIAxitudMZd5+5yft6L+hqb4/jm+
         Pdo7CIAomyasq9ExHBxwYJj+zU+itJZnqnxBMZfIVpaRQkC8KZ5R4T+ll7BK8GoIxfpg
         2l8gj/wkJsDHjPN238gI0M3SxeAXPdSX3ehF8UkHMErs9tHDINaXIjCqu+vLE7U36FD4
         ufwBLg3rJF4K4fLnNX7vNRhEGuMx3b69D2lTbzZH3LOugzWthck++koKM/fzyuFQ2H0t
         bgbrSPVpGuatkv34u5Em6nr0JlOA6fuF8DnWjhvNfGPhcf1jkTJfw54co0pH8+3/DpNP
         W7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728987604; x=1729592404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEniXAgF9NWz0JqBFaEwIBfo+8JM59q1xiFtuN3f7V0=;
        b=BE5Zy90MkkzC/HqOMYNJdn3cIJ4EtlemkTt31VYo9f4UD/1M1ZOYKjFVU/kLYxdI6P
         GEQ61b9LejkQctRbDA1TxSbLtVP4E0XPl/2ExLphisBzx+u+kcpJDbZx7SASIJEpBsSI
         rvxNmLcez9gfKLEwztxRLXoYvBRmN0Q60PLZwilULp+WV+OY111EERT0CmfZdOlhP+ZN
         MM1dmGWxGAxsMjTwOpivro6ktVZTbBwV6gzSHr3A8DkVy3cQXCcBSg93P1QVNa5BOVW/
         FGGzyJSMeNc7awLsqE097gAp4amy/k58iyyLiQK9eUc2lscFuf3mrs7GtMUX1ssN3NHi
         Pk0g==
X-Forwarded-Encrypted: i=1; AJvYcCVauELC9JQeEiWe6Y9+5W0R5DFPlILCeHILRT21SJbKqYNkvVHJNuqy5lvnwLlG0OCcFyuHi6/cjMTrDNrnhVh0@vger.kernel.org, AJvYcCWZRPujkVezLPgQHMTzsmoUSzgnf6Dxu3OC+HnT32cmonP8wnypvFFKMcu1h2g7Qx0mv3Bh4GOO6yJT4r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPIrVRFRW7sXMfcat/l6qw4moMIle3fpOy1VPDb7QidkUwpIE
	y/5qFQAjnjgCechBOs+c/WOPxu/NlLYYmpg+q67m1QuhoG+owUeo
X-Google-Smtp-Source: AGHT+IH4Pfzp9iLRJK488OvWIsjdhCLFarc3MLT0tE7cbFpI4b4Q1AY5pc2oz9MuQSXFKxmqDgk28g==
X-Received: by 2002:a17:907:7da2:b0:a9a:6fd:fc88 with SMTP id a640c23a62f3a-a9a06fdfe11mr715100866b.30.1728987603516;
        Tue, 15 Oct 2024 03:20:03 -0700 (PDT)
Received: from localhost ([188.210.239.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29740e1fsm53733566b.51.2024.10.15.03.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:20:03 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:20:00 +0200
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, anupnewsmail@gmail.com
Subject: Re: [PATCH v2] selftests/intel_pstate: fix operand expected
Message-ID: <4hxgkaxray75k2z4zyhhq6nb6iegsfokhsv6gdthai7bfzbpnw@6doocomldm6m>
References: <20241014172149.324639-1-alessandro.zanni87@gmail.com>
 <41d157fc-6413-4061-95af-518ec7b923f1@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d157fc-6413-4061-95af-518ec7b923f1@linuxfoundation.org>

On 24/10/14 06:05, Shuah Khan wrote:
> On 10/14/24 11:21, Alessandro Zanni wrote:
> > This fix solves theses errors, when calling kselftest with
> > targets "intel_pstate":
> > 
> > ./run.sh: line 90: / 1000: syntax error: operand expected (error token is "/ 1000")
> > 
> > ./run.sh: line 92: / 1000: syntax error: operand expected (error token is "/ 1000")
> > 
> > To error was found by running tests manually with the command:
> > make kselftest TARGETS=intel_pstate
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> > 
> > Notes:
> >      v2: removed debug echos
> 
> See my comments on your v1. It would help to wait a bit
> to send v2.

Ok and thanks for the comments.

> I can't reproduce this problem on Linux 6.12-rc3.
> What's you environment like?

My kernel version is 6.12.0-rc3 from "make kernelversion".

I think the errors are related to the bash type and version, rather than the kernel version.
My bash version is: GNU bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)

In fact, some shell do not complete expressions in variables and $var and command substitutions 
are done before the arithmetic expression itself is parsed.
That expansion happens without regard for the arithmetic syntax, so with $var you can mess 
with that.
So, I suggest to avoid to use $var inside a arithmetic expansion in order to be cross-platform.

> > 
> >   tools/testing/selftests/intel_pstate/run.sh | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> > index e7008f614ad7..0c1b6c1308a4 100755
> > --- a/tools/testing/selftests/intel_pstate/run.sh
> > +++ b/tools/testing/selftests/intel_pstate/run.sh
> > @@ -87,9 +87,9 @@ mkt_freq=${_mkt_freq}0
> >   # Get the ranges from cpupower
> >   _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
> > -min_freq=$(($_min_freq / 1000))
> > +min_freq=$((_min_freq / 1000))
> >   _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
> > -max_freq=$(($_max_freq / 1000))
> > +max_freq=$((_max_freq / 1000))
> >   [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
> 
> thanks,
> -- Shuah

Thanks,
Alessandro

