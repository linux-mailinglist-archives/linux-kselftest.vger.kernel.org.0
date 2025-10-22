Return-Path: <linux-kselftest+bounces-43758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B40CBFC64C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 16:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FABC4EC141
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CDE34B664;
	Wed, 22 Oct 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWh59COS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258B34B40A
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141988; cv=none; b=dY9aJwwRm4DQFQsc6oq/ipa5lu8URSQSOqoBYZLxRwi91/VFZLPUG/gV1o0ML5DMmFsH/nUOJo8AcJnKOaLHyZ7Xw4yElOHuzDSb67rjOz/d6rvb/djtewXhh4Cmi6DSY4KpDXpaPVG8lCu3Qyf3EPP3E4yjgb73Ws0mv1tYHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141988; c=relaxed/simple;
	bh=5mNGUoLWRLP5PAgJDUcOekik2r6Ky7tQKPOFqRi0yxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAy8GZaZwPtBT93o9Wm1Uqx5VMOyO051/RoxtAN3DsDaNzgdkrDlpQmDSHR3L6F8smrURvg30fdyX58NB/cIMRBkuV7a4mXda3FsM2xomm9g9yZRlxvo7iAvcDRH6vL+p0+/yUQoEWHNSY+IYpzQkO59bdD+QCDmYAHSsVfoEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWh59COS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761141984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpAlIpSy8C909YLuQA//DQkPxxMEs4xSi+qjURZtgFE=;
	b=IWh59COSwMI5KK9doueEPKKdnmPhawLlV4npjgRbmQS4PNQqUzHEIl1qyjufs/CdHApFjx
	ocStss4oYDKNpDxPmB0olQO8GiGu0kM+QTJmefBXIEQ/WVdmXH0K8omeY6lDUQyfo5IB+e
	+DyR3sBtdd8sr8YdPxLlfB1jJ01T2c0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-6_nZqLlrPuiqXHF6V4aOoQ-1; Wed, 22 Oct 2025 10:06:22 -0400
X-MC-Unique: 6_nZqLlrPuiqXHF6V4aOoQ-1
X-Mimecast-MFC-AGG-ID: 6_nZqLlrPuiqXHF6V4aOoQ_1761141982
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e88a5e70a7so37720291cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 07:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141982; x=1761746782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpAlIpSy8C909YLuQA//DQkPxxMEs4xSi+qjURZtgFE=;
        b=PlxPxXRkU9QX3UylcbUlj/p0ejErP3qJdfGBC5PT+M5k61mR+BC6SYGTBQb57bUFhe
         z7fEljQJANvBLPtLriFaW5wKEUGaC+HtwmA4gI/Q2gkDDnZr0tS2WeR+yBhhLUAlLle/
         r0uFFcNoPruzfMbYk6ALVYeUYAO+J7s+tfLDVmaW3H49wYRjQFVv2adYzh5LGLPhlzWk
         OSokzWcWzFPw6CrjIEa37aUkAFH5a+UYKePia1GS2ZPJFPB0hMX+TC4hW8aRnNxDJwdC
         WUMgDLpJcabFtYRhg0sJ8KlNmFUlJUphOvV0rjn+zT9X6GRa7wXAtsHAuRLfkGnK3+s/
         zQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP5kJVaPAN71VTeWeXsh4FEBsuGxzdVNvPWPBauyz/JPSXrwYJvjPJdrqAyrOLaR5c0hazzjVODKxmSYQgzkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyod1PcT1cf4GNpPmwh7CZBTceGsoQwLWO5X5DN60oPl4Cpp9kA
	vWm3u+Aey7KFy3W6SbJ6UwIMkX9rFn+HYQ62Hyp9O2L2cjoiCDlZ7eiAVuVjISvingzV/ISarIu
	bPSOnddoNJazpPAJwx0MolvgpQ8uLjN6x4DqLcF8YYNKOVGsZm9rcnxrmQjbZVdapDGQQn4PDEa
	fA7einOiiWj1amZhnkCGIUllIV71m8Kfhiwhv63DpJZGrW
X-Gm-Gg: ASbGncvSaBgdTyHcTN3yBV0GbE5nxdSD12eWffcI0S+mpWH/iF4+SpsPFY1c2Bql3gL
	6uCSLyXTgLlSnO6QjzeJfD2s9cHPRq3GgnyUlwjBhetexmFXUCR3/cj4BB1YDwak3mdG/k827s7
	rW6hNcOTdAav/WFG6iVGulKOnDALWLcPPLLG8yHZqqhnppuWx4yEO0Ae0nX8GhTNYZtbn41xf4T
	RTJ43mDYKxS9Ez+
X-Received: by 2002:a05:622a:13cd:b0:4b2:d40b:997 with SMTP id d75a77b69052e-4eb784b5ddcmr17973071cf.11.1761141982132;
        Wed, 22 Oct 2025 07:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiy688lq0byckzl7pGXnvWhZZPJXPo0bl3cEscD1D5tdzpAQ54kYl/qCOsifbFz5e/sCUwL37uFix9NhXMCD8=
X-Received: by 2002:a05:622a:13cd:b0:4b2:d40b:997 with SMTP id
 d75a77b69052e-4eb784b5ddcmr17972311cf.11.1761141981436; Wed, 22 Oct 2025
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <2025102111-facility-dismay-322e@gregkh>
 <CA+wEVJZEho_9kvaGYstc=5f6iHGi69x=_0zT+jrC2EqSFUQMWQ@mail.gmail.com> <2025102124-punctuate-kilogram-da50@gregkh>
In-Reply-To: <2025102124-punctuate-kilogram-da50@gregkh>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 22 Oct 2025 16:06:10 +0200
X-Gm-Features: AS18NWBUEXjvL5a7yuhDD9EBuivsDI4OlQF-1ILxjqzVH4-eCsEPHeuZ9-Q2Dr0
Message-ID: <CA+wEVJajSGzb85YTiv98yAY3bcJFS0Qp_xjLc++wnU8t=wDAOg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Add testable code specifications
To: Greg KH <gregkh@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Oct 21, 2025 at 6:46=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Oct 21, 2025 at 11:42:24AM +0200, Gabriele Paoloni wrote:
> > Hi Greg
> >
> > On Tue, Oct 21, 2025 at 9:35=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 06:59:57PM +0200, Gabriele Paoloni wrote:
> > > > [1] was an initial proposal defining testable code specifications f=
or
> > > > some functions in /drivers/char/mem.c.
> > > > However a Guideline to write such specifications was missing and te=
st
> > > > cases tracing to such specifications were missing.
> > > > This patchset represents a next step and is organised as follows:
> > > > - patch 1/3 contains the Guideline for writing code specifications
> > > > - patch 2/3 contains examples of code specfications defined for som=
e
> > > >   functions of drivers/char/mem.c
> > > > - patch 3/3 contains examples of selftests that map to some code
> > > >   specifications of patch 2/3
> > > >
> > > > [1] https://lore.kernel.org/all/20250821170419.70668-1-gpaoloni@red=
hat.com/
> > >
> > > "RFC" implies there is a request.  I don't see that here, am I missin=
g
> > > that?  Or is this "good to go" and want us to seriously consider
> > > accepting this?
> >
> > I assumed that an RFC (as in request for comments) that comes with prop=
osed
> > changes to upstream files would be interpreted as a request for feedbac=
ks
> > associated with the proposed changes (what is wrong or what is missing)=
;
> > next time I will communicate the request explicitly.
> >
> > WRT this specific patchset, the intent is to introduce formalism in spe=
cifying
> > code behavior (so that the same formalism can also be used to write and
> > review test cases), so my high level asks would be:
> >
> > 1) In the first part of patch 1/3 we explain why we are doing this and =
the high
> > level goals. Do you agree with these? Are these clear?
>
> No, and no.
>
> I think this type of thing is, sadly, folly.  You are entering into a
> path that never ends with no clear goal that you are conveying here to
> us.
>
> I might be totally wrong, but I fail to see what you want to have happen
> in the end.
>
> Every in-kernel api documented in a "formal" way like this?  Or a
> subset?  If a subset, which ones specifically?  How many?  And who is
> going to do that?  And who is going to maintain it?  And most
> importantly, why is it needed at all?
>
> For some reason Linux has succeeded in pretty much every place an
> operating system is needed for cpus that it can run on (zephyr for those
> others that it can not.)  So why are we suddenly now, after many
> decades, requiring basic user/kernel stuff to be formally documented
> like this?

Let me try to answer starting from the "why".
IMO There are 2 aspects to consider.
The first one is that requirements/specification and associated tests
are valuable in claiming that Linux can be used in safety critical industri=
es
(like automotive or aerospace).
The second one (that goes beyond the business need) is that the duality
of specifications and tests VS code increases the dependability of the
code itself so that its expected behaviour and associated constraints
are clear to the user and there is evidence of the code behaving as specifi=
ed
(I already tried to address this point in [1]).
Some evidence of improvements can be found in the experiments we did.
E.g.:
- this [2] is a bug found in __ftrace_event_enable_disable()
- this [3] is a code optimization that came as we looked at the
specifications of
  __ftrace_event_enable_disable()
- here [4] we have documented assumptions of use that must be met when
  invoking event_enable_read(), otherwise there could be a wrong event stat=
us
  being reported to the user.

Finally the need for having specifications/requirements associated with Ker=
nel
code has been already discussed at LPC'24 last year ([5]) and we got a thum=
b
up from some key maintainers with initial directions (hence we started
this activity).

[1] https://lore.kernel.org/all/CA+wEVJatTLKt-3HxyExtXf4M+fmD6pXcmmCuhd+3-n=
2J_2Tw8A@mail.gmail.com/
[2] https://lore.kernel.org/all/20250321170821.101403-1-gpaoloni@redhat.com=
/
[3] https://lore.kernel.org/all/20250723144928.341184323@kernel.org/
[4] https://lore.kernel.org/all/20250814122206.109096-1-gpaoloni@redhat.com=
/
[5] https://lpc.events/event/18/contributions/1894/

Now I'll try to answer about the goals.
I do not expect to have all Kernel APIs to be specified according
to the format that we are proposing; my initial goal is to have such
a formalism to be available in the Kernel so that developers that
need to write such specifications have a guideline available.
For example today we have a guideline to write kernel-doc comments,
however (AFAIK) patch acceptance is not gated by these being
present or not.
I think that developers having a direct interest can write such
specifications and associated tests and these could be reviewed and
eventually accepted by maintainers.

>
> In the past, when we have had "validating bodies" ask for stuff like
> this, the solution is to provide it in a big thick book, outside of the
> kernel, by the company that wishes to sell such a product to that
> organization to justify the cost of doing that labor.  In every instance
> that I know of, that book sits on a shelf and gathers dust, while Linux
> is just updated over the years in those sites to new versions and the
> book goes quickly out of date as no one really cares about it, except
> it having been a check-box for a purchase order requirement.

I agree and in fact a key ask from maintainers, as we discussed at
LPC'24 in [5], was to have the code specifications sitting next to the
code so that they could be maintainable as the code evolves (and they
would be even more maintainable if specs come with tests that can flag
regressions as the code evolves).

>
> That's business craziness, no need to get us involved in all of that.
> Heck, look at the stuff around FIPS certification for more insanity.
> That's a check-box that is required by organizations and then totally
> ignored and never actually run at all by the user.  I feel this is much
> the same.
>
> So step back, and tell us exactly what files and functions and apis are
> needed to be documented in this stilted and formal way, who exactly is
> going to be doing all of that work, and why we should even consider
> reviewing and accepting and most importantly, maintaining such a thing
> for the next 40+ years.

Putting business needs aside, I would expect maintainers, today, to
happily accept kernel-doc compliant code documentation as well as kunit
or selftests associated with the code; simply because they add technical
value.
If my assumption here is correct, having these kernel-doc specifications
clearly formalised should be an improvement for the maintainers (since
it would be easier to verify incoming patches when specs and tests are
in place and also it would be easier for a developer to write such
patches).

WRT the scope of code to be documented, I expect that to depend on
the vested interest of companies contributing to it.
The directions from the LPC24 session were to start with some pilot
drivers/subsystems first to define 'how' to specify the code and later
focus on what and scale...

>
> > 2) In the rest of the patchset we introduce the formalism, we propose s=
ome
> > specs (in patch 2) and associated selftests (in patch 3). Please let us=
 know
> > if there is something wrong, missing or to be improved.
>
> I made many comments on patch 3, the most important one being that the
> tests created do not seem to follow any of the standards we have for
> Linux kernel tests for no documented reason.
>
> The irony of submitting tests for formal specifications that do not
> follow documented policies is rich :)

Thanks for your comments and sorry for the mistakes, I see that Alessandro
replied so we'll pay more attention in writing tests in the next revision.

Kind Regards
Gab

>
> thanks,
>
> greg k-h
>


