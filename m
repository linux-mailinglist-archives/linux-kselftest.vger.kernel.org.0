Return-Path: <linux-kselftest+bounces-17442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE996FFBF
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 05:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE6F1F262C9
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 03:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590DA1CAAC;
	Sat,  7 Sep 2024 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1PJxPwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA41B7E9;
	Sat,  7 Sep 2024 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725678743; cv=none; b=LhX95PSY6njn3LF3RaRCt5apUJDdi5+FXjZl4kKRaQMyZVmRM3ThyvnITliDK3dsJnts8HyWQ/qvrZ9MxCmRcIsAzDqacYy3oWOa2iGbjHNGdYBJja5ObqVUUfRaOK/rsBlmLbyYW3OE9lOPzcrIzGtr//5A25oSow0j5YFL+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725678743; c=relaxed/simple;
	bh=KbmoP0t0DolFc9iPMaiHUQn6qxIGNtai/kwltA855QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcJfqMjWuPxkH8NdRs8lFwoyg14YVMdiwOC4Y/uuAULf8ZIQ8btn2c63dk21/j4FrEJ1EAYKEFVHmPz70jqXajLp4WBjV+JtzLXlw/+IS0VIHvzREqdLCfSgaphSU7oTHMsiC6mDcxwtci2hZN6G85c57cUBhWfb3sPv9k7taec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1PJxPwx; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39d30564949so9759825ab.2;
        Fri, 06 Sep 2024 20:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725678740; x=1726283540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbmoP0t0DolFc9iPMaiHUQn6qxIGNtai/kwltA855QA=;
        b=M1PJxPwxknqbQ9ujqg5DM9aNCG+W2qZ/uq1JeLhL5irtySJFXU5imcrAGy9fqQwvdY
         53VetnKi5TLidn26g36oyRuc2S0+9AFvxehqek9aTm5fqU/OOpBl8G7g0o1nlONi4BUC
         v9PHM0wtWQEFTmBiVCWjxKUx90C3KmIea0LH49gxl6tdvhh2/UPJV85Az1wMVXj2iciY
         FN5/3ihIUSrGhtmki58ectHlgH8vkOGLBOZNeG0E4Xtyb8RfgSIqQXOZxTRm+JsJqyyf
         lJGSVSezJSF0N1fzuWXRUbhU0uE6FPzHL5jhwTEhXE71X4pipTH9CvYaHP7uO/FxpTPh
         2vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725678740; x=1726283540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbmoP0t0DolFc9iPMaiHUQn6qxIGNtai/kwltA855QA=;
        b=H58ggzYCeRCXZo/U6bKQIYCOEVZGV7pDRMul0Jl0JppiKYR3ZIzPRaUSqCOOqzQK7A
         rvlpMJV5Vhx2EaL3yxeLQUvkM3IkaeJv0y3UrwjDf1NB6Ya0GI53VXZnaS8+nWY7HXdn
         Ak+gF83+k3+MHi4Ut+tPokeZnd0sHCz8t+uT/qKpsOBUips4jb+CAV2d4tEToFHNdWcp
         xUN6G9SLwYf+BAiDZom7J/ALI5rgyjKciTng9XazE+R5IAqt2jPxggSB4F7bSJ6EJiib
         0AEAqhcD/QKE7FK9MGAFb/qF6xB3jmpQhX9c42FZfuOVyxwy53LT6DDDvnjuAp0VA3+Y
         OLxw==
X-Forwarded-Encrypted: i=1; AJvYcCUqYWKX3vS4z1A3dy6nxf7GmRc3zRayZ1m64lYTniSFUTe76Il4kRuA/sngIVjdzQFbRga7VZUWovM4DfwgHmk=@vger.kernel.org, AJvYcCVkumsYBFJZIvP2LMy7z49G+p4wG3vxS5zUOmQyRB6p7Myn/IohdYYAVFZ/V4F/TCDIHZZOTQrW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WgH837XM56x32O3+37mttEePMOvfAVcSglUdhb+THf2CrSpp
	Cre9JuVZwCwkvA7VlqAEI32j3CaVn5ZUIbw2o/MgDm33JhWAHif09O6EFYVMEDDVYgdI9cYCHBt
	CDxrna6kYVg09C9UzYc76AtC1Atk=
X-Google-Smtp-Source: AGHT+IESNs0ph6mzZ+5EQVURtGJxGh/vmwZpk07jGVJFojYfOttpMAcamIF9i1r9o0lox+gMuUu7EMiZa7VXPnXMp7o=
X-Received: by 2002:a92:c24c:0:b0:39f:7acb:b95f with SMTP id
 e9e14a558f8ab-3a0568a3db7mr19547665ab.18.1725678740581; Fri, 06 Sep 2024
 20:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906095640.77533-1-kerneljasonxing@gmail.com>
 <20240906095640.77533-2-kerneljasonxing@gmail.com> <66db8f293dbd1_2a33ef294b3@willemb.c.googlers.com.notmuch>
 <CAL+tcoC9NoE3ws3nA-_ANAqD1cWpv9JDzFY11ACryZgg35dQrg@mail.gmail.com> <66dbbbac6a6df_2b0bd0294d3@willemb.c.googlers.com.notmuch>
In-Reply-To: <66dbbbac6a6df_2b0bd0294d3@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 7 Sep 2024 11:11:44 +0800
Message-ID: <CAL+tcoC2TajcYLewWrhpF7KL75XyMiW_G0RV+58=fbMEH8rf=g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net-timestamp: introduce
 SOF_TIMESTAMPING_OPT_RX_FILTER flag
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 10:34=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Sat, Sep 7, 2024 at 7:24=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
> > > > path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> > > > out rx software timestamp report, especially after a process turns =
on
> > > > netstamp_needed_key which can time stamp every incoming skb.
> > > >
> > > > Previously, we found out if an application starts first which turns=
 on
> > > > netstamp_needed_key, then another one only passing SOF_TIMESTAMPING=
_SOFTWARE
> > > > could also get rx timestamp. Now we handle this case by introducing=
 this
> > > > new flag without breaking users.
> > > >
> > > > Quoting Willem to explain why we need the flag:
> > > > "why a process would want to request software timestamp reporting, =
but
> > > > not receive software timestamp generation. The only use I see is wh=
en
> > > > the application does request
> > > > SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> > > >
> > > > Similarly, this new flag could also be used for hardware case where=
 we
> > > > can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't receiv=
e
> > > > hardware receive timestamp.
> > > >
> > > > Another thing about errqueue in this patch I have a few words to sa=
y:
> > > > In this case, we need to handle the egress path carefully, or else
> > > > reporting the tx timestamp will fail. Egress path and ingress path =
will
> > > > finally call sock_recv_timestamp(). We have to distinguish them.
> > > > Errqueue is a good indicator to reflect the flow direction.
> > > >
> > > > Suggested-by: Willem de Bruijn <willemb@google.com>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >
> > > High level: where is the harm in receiving unsolicited timestamps?
> > > A process can easily ignore them. I do wonder if the only use case is
> > > an overly strict testcase. Was reminded of this as I tried to write
> > > a more concise paragraph for the documentation.
> >
> > You raised a good question.
> >
> > I think It's more of a design consideration instead of a bugfix
> > actually. So it is not solving a bug which makes the apps wrong but
> > gives users a hint that we can explicitly and accurately do what we
> > want and we expect.
> >
> > Let's assume: if we remove all the report flags design, what will
> > happen? It can work of course. I don't believe that people choose to
> > enable the generation flag but are not willing to report it. Of
> > course, It's another thing. I'm just saying.
>
> Let's not debate the existing API. Its design predates both of our
> contributions.

Yep.

>
> > I wonder if it makes sense to you :) ?
>
> I don't see a strong use case. I know we're on v5 while I reopen that
> point, sorry.

That's all right. No worries.

>
> It seems simpler to me to not read spurious fields that are not
> requested, rather than to explicitly request them to be set to zero.
>
> Adding more flags is not free. An extra option adds mental load for
> casual users of this alread complex API. This may certainly sound
> hypocritical coming from me, as I added my fair share. But I hope
> their functionality outweighs that cost (well.. in at least one case
> it was an ugly fix for a bad first attempt.. OPT_ID).

I understand what you meant here. But I'm lost...

For some users, they might use the tsflags in apps to test whether
they need to receive/report the rx timestamp or not, and someday they
will notice there are unexpected timestamps that come out. As we know,
it's more of a design consideration about whether the users can
control it by setsockopt...

In addition to the design itself, above is the only use case I know.

>
> I got to this point trying to condense the proposed documentation.
> We can add this if you feel strongly.

If the new flag is not good for future development, we can stop it and
then _only_ document the special case, which we both agreed about a
week ago.

Personally, I don't want to let it go easily. But It's just me. You
are the maintainer, so you have to make the decision. I'm totally fine
with either way. Thanks.

I was only trying to make the feature better. At least, we both have
tried a lot.

>
> But then my main feedback is that the doc has to be shorter and to

It's truly very long, to be honest. I thought I needed to list the
possible combination use cases.

> the point. Why would a user user this? No background on how we got
> here, what they might already do accidentally.

It looks like I should remove those use cases? And then clarify the
reason is per socket control?

I have no idea if I should continue on this.

Thanks,
Jason

