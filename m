Return-Path: <linux-kselftest+bounces-45124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F64C40E4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 497FE4E8C6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F527FB2B;
	Fri,  7 Nov 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwiPSA39"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DC528003A
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532972; cv=none; b=NQQuOSi1KGe+7j5c6Xjq5qhA7wwLJ8TTIKzJJO5tj6PTeIhuRPwLGeQXKwSViLeiD4zUzRO8TrkDvWtQbIF0fyOONGKIpCK2OtqR1VZGkQjguacvQjyKWqp7B4RPHe6SWvJqcQ69h07ekh2zGWQ2s7GjVx45VzqE+cT7aHLA3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532972; c=relaxed/simple;
	bh=rgcoRhyGIK5TkOpZt0kZTN7koiw5JU/Ow/kogtLB0pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7X8tjGpxrpzI9luIPPBWAsEAF8kxE+oOSxQ0Vf7ChVNHtWmdG1zGeUvhHfeuYEZP/znL7Q2jf9aQSNB36JmA0qyx4JrCf9BRA0NkIecg9xvF/X4PX0Inz2K3vZapRtwjDr3z9kUIt+g/Z/wB3DDuG/g9XKNDDnQI7z9KlCL+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwiPSA39; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4330d78f935so7364165ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762532970; x=1763137770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpUHhwLLVw048cC2Tr3FEbA9y73h0hyI54ZDUH0t8tg=;
        b=XwiPSA39nsnkdh5yq9hmq5Q1pQhU/l4yfBPXNq8URc3djc/fKxv8xAtGNqRydKvsJt
         GF7Bpn6csmRSNYYywLHFyVnjvnflwb29uopg0mh8XIbOhEBsibU2nX0E+RoBUgaxZgLs
         B6l+p5yn0YXi+SDNYzdbqb88zoD5UmG/IXfojwVE/lBy8LwpK+uiX1KH+2rvlzs2xONI
         hqutrbyQ027+4Pje0IqvZSS/fnayj3Xtv1qV1FwsqDTdwSI2Ay1YT1vqeEHat4porGTD
         tWFJqRmYe8+2yOUjWKWuO6IxfauB9GEYVidybLZ6IezgvNKp6ac1LTYMBDm6M2Zpob2K
         Np/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532970; x=1763137770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KpUHhwLLVw048cC2Tr3FEbA9y73h0hyI54ZDUH0t8tg=;
        b=t2WH77VZJLlEQlVYazul2s1RO8X88ODkPDfVCQQgDbbHK70mJ2xE1ZqgcFbE6VvQMz
         9YJwPh6+mNEqiGJC2zoLgTS+DqaFjtGAebSLF/PN14lsz92hcFApgUDBpViCcdKCmUeP
         7Po6A15d9tLw+2qb5+dDwO0WaUiPLpa4P42tfzBUG55kC/thUMoQ+zUw8gRmyKsdnwSR
         o22YUYKbJI0YNUtrVIvxayDufobqjbAPcdJxDUx8DuDeb2Ep/wq+70kiFg318rE6Ge7j
         fx2BTF3RcpppliFiSE6ycasO86Xt8tLv6Yk53pox7TsjnJNYWaZ1ttqEvJpop29GQMqi
         ireg==
X-Forwarded-Encrypted: i=1; AJvYcCWoDzKHx3ciVXPea4T7R3K0hj94vSF4/5zWhQ3wKaOe9dh82U7445NWANFXZpt5F2IQPVvXT8qyKQkS0drfxjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnTf+nRPtaOfUWRHRAqHc7e+QwWO2jcRlEwOEQxRJ3kkpFly8
	cb/eWef0cixXuvqGCUINIrt2JzKoP6RJKx6SJIoUrxtqGGk86t+ng67MK2nyJkQAyQ/1C3trfBb
	YdedOZ/1KrPnaa2VaAASszwcZGbQEkeQ=
X-Gm-Gg: ASbGncsPHCl5HwnlfEHzsANsX4wa3WRtUx1uxCHd/nX26HGJGqf9ROC9IXsKc8HiMWT
	ZUh2jkI1uck0xzEmmFNNgdyg6m8RwxoPU4vDGXjWsWyJrTrvCGW8l33yOfU5D6inWBZ+1+wU2YG
	FC1SRjjj1QO6gfm93/4v02OC7GayJKi0Tz1QSrOGzLwPA1WdYZp/0eETXDJA3XpNQdIf8kg7e5V
	Ocgan08LyLOUZk1vTZNyOpfxdZKtjoajo4ua1o+jJ7ipxYe+K3rDptZqo3oEc15mYZocKdRd57L
	xZJPD/hSK1fQWuDdup79cY5uHKKTJPwmhfzVOWqg5ArEGybtXcmcOu56wZXHG9WH48/XgOrenr5
	4lw+FNxQPcBA0yUEidm/89tP0N6O2n9/Ot3FG0ZORK2VNVwGY4Sunir0OZ+6uiI+zOOTl6X0qzT
	wHhxXVQg==
X-Google-Smtp-Source: AGHT+IHLBeBsljRup9vfyIw0zMlrDC0E78/7aLQDxLzaAjO0KjqOY+HyEIQe54ZnzvQGmNPUrUss4m9CIjqFlxlmgpc=
X-Received: by 2002:a05:6e02:168e:b0:433:46a7:be57 with SMTP id
 e9e14a558f8ab-43367e17daamr795725ab.8.1762532970241; Fri, 07 Nov 2025
 08:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <2025102111-facility-dismay-322e@gregkh>
 <CA+wEVJZEho_9kvaGYstc=5f6iHGi69x=_0zT+jrC2EqSFUQMWQ@mail.gmail.com>
 <2025102124-punctuate-kilogram-da50@gregkh> <CA+wEVJajSGzb85YTiv98yAY3bcJFS0Qp_xjLc++wnU8t=wDAOg@mail.gmail.com>
 <2025102211-wolverine-cradling-b4ec@gregkh>
In-Reply-To: <2025102211-wolverine-cradling-b4ec@gregkh>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Fri, 7 Nov 2025 16:29:13 +0000
X-Gm-Features: AWmQ_bn6uEo7-A9xvlR4_AxUEmBwxnRKzTpVyrh4GYZ_AQq2WQg29VVKDwL_Wwo
Message-ID: <CAB=6tBSaGfKq4RgV=nbw28Yq59jHMrVOkm_dx2bqD1AjU37oaw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Add testable code specifications
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuck@wolber.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 5:13=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Oct 22, 2025 at 04:06:10PM +0200, Gabriele Paoloni wrote:
> > > Every in-kernel api documented in a "formal" way like this?  Or a sub=
set?
> > > If a subset, which ones specifically?  How many?  And who is going to=
 do
> > > that?  And who is going to maintain it?  And most importantly, why is=
 it
> > > needed at all?

I appreciate the questions. I sense there may be some confusion over who th=
is
is intended to benefit.

The design of the Linux kernel is emergent. This is a fundamental property =
of
the way it is developed, and the source of its greatest strength. But it ha=
s
some shortcomings that place a burden on kernel maintainers, all kernel
testing, and even people who wish to contribute.

We intend this as a tool to address those areas.


> > > For some reason Linux has succeeded in pretty much every place an
> > > operating system is needed for cpus that it can run on (zephyr for th=
ose
> > > others that it can not.)  So why are we suddenly now, after many deca=
des,
> > > requiring basic user/kernel stuff to be formally documented like this=
?

You are correct, the kernel has succeeded over many decades, and will conti=
nue
succeeding for many decades to come.

With the exception of some very narrow situations, the emergent design (or
"nuanced complexity" if you prefer that term) of the Linux kernel is not
communicated in a broadly consistent way. This affects the way the kernel i=
s
tested, and also the way it is developed. Even veteran kernel maintainers a=
re
tripping over nuance and complexity.


> > Let me try to answer starting from the "why".
>
> Let's ignore the "why" for now, and get to the "how" and "what" which you
> skipped from my questions above.
>
> _Exactly_ how many in-kernel functions are you claiming is needed to be
> documented in this type of way before Linux would become "acceptable" to
> these regulatory agencies, and which ones _specifically_ are they?

Exactly zero. This is not for regulators.


> Without knowing that, we could argue about the format all day long, and
> yet have nothing to show for it.

As this is not intended for regulators, it is not clear to me that catering=
 to
their desires would be a good use of anyone's time.

I say this as a software engineer who works in a _highly_ regulated industr=
y,
and who knows the relevant regulations quite well. There are good ideas bur=
ied
in those regulations, but (in their default form) they are _not_ appropriat=
e
for the Linux kernel development process.


> And then, I have to ask, exactly "who" is going to do that work.

The intent is to allow for a separate maintainer path. There is more to it =
than
that, but I do not want to bury the lede here.


> I'll point at another "you must do this for reasons" type of request we h=
ave
> had in the past, SPDX.  Sadly that task was never actually finished as it
> looks like no one really cared to do the real work involved.  We got othe=
r
> benefits out of that effort, but the "goal" that people started that effo=
rt
> with was never met.  Part of that is me not pushing back hard enough on t=
he
> "who is going to do the work" part of that question, which is important i=
n
> stuff like this.

Well, I am sorry for that. I am not quite sure how to respond, but I certai=
nly
sympathize with past frustrations. I have plenty of my own.

We are not offering a silver bullet here, and the work to describe the kern=
el's
design will be finished when the work of development is finished. This is j=
ust
an attempt to fill in a semantic gap that is responsible for a great deal o=
f
technical debt and maintainer burnout.


> If you never complete the effort, your end goal of passing Linux off to t=
hose
> customers will never happen.

It is not clear to me what customers you are talking about. That is certain=
ly
not a goal in the mind of anyone working on this project that I am aware of=
.


> So, try to answer that, with lots and lots of specifics, and then, if we
> agree that it is a sane thing to attempt (i.e. you are going to do all th=
e
> work and it actually would be possible to complete), then we can argue ab=
out
> the format of the text :)

I respect what you are saying here, and perhaps the point of confusion came
from the safety related source? As is often the case in science and
engineering, we are borrowing (and _heavily_ modifying) a technique that is
found in a different domain.

The intent is to target technical debt and maintainer burnout by filling in=
 a
semantic gap that occurs when a human idea is turned into code. Ironically,
this is why the safety regulations were written in the first place, but lit=
tle
consideration was given to development methodology during that process.

Thank you,

..Ch:W..

