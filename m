Return-Path: <linux-kselftest+bounces-6779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B34890C7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 22:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF0F1C24D25
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 21:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782EA13AD2E;
	Thu, 28 Mar 2024 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q815/UKF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0813A244;
	Thu, 28 Mar 2024 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661346; cv=none; b=tTxZ8tHF/8tkQ2vw9raAeofoSaQbT0c2gM9zSyryf3eIVQu5EdfBaIIlMRmBfp0tlRJ20tLfJuiMvlw9AgfNEK6fNV6sgezv4W6qU0cOGJBCYW/YwGJi7IeqQlbhgQJksaaNJ4OLwjKAka8l3MdwuU9YyKmuwcNxHpVHLVHUqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661346; c=relaxed/simple;
	bh=fu9vUyiydStv12IrbMDN19YasY8MTA7HLFJT94T3dNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KC4mmtA4yD2P/l6oXss3CISRulBgFlo6JIIA9Mlg1UOuJUTUcm4par3dxGqCmSbk6VwG/7KQQaP7PMq7nV4YQQVtWNGb+876R3GbjUnzSxPYCeUQ8bHsFDMXg6WLLZzSG0KMSNP+htmdtOeAIEmWc+Cpfm5H436AaG1KxYE99WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q815/UKF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ed6078884so1365193f8f.1;
        Thu, 28 Mar 2024 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711661343; x=1712266143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rZ5v4VYB7xFxkylJdxU/zw8gdhhfD99ak8fXt5M6cs=;
        b=Q815/UKFhLZgHH2DPzS7HNK8+2Kw8u7gnSGggT3Yc2LTSITyeD8UrF0SCh9A0NwGyw
         Bakn/NtkGmXfHWiFvyKaY0S/27xmG6lsRMspt+GNkL4XHej0mgwHTgP8t2O7ww5K6SHl
         u/g4luUdSl7hXuS/uQd1Qotq20z9mb4Alp5bz9DoEO0wtEw5rV/qtM3WoDCtM+N40D4G
         y4uVUSbPOoQPY1WxF5SObSZp20AuD4ERNaXVQtZIo+C1KO3cPLruDc6zEd0O1AeT8e+l
         3nInnEWmxYLFdfWRLPNdTr4zgtruOmY0InsOu0ueJBhjJL8XB4w1cnSRLcuCdZHSbctc
         sASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711661343; x=1712266143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rZ5v4VYB7xFxkylJdxU/zw8gdhhfD99ak8fXt5M6cs=;
        b=r+C+EfMrsHpBQORYSxqRWSiAlSniXsZEA/hdv2lG0p8xW8gRzkbh07335OF/dLV3tW
         67d0pQRX0mlH1/j9rBetNRGb0b1oT1b4FJFLWtUY8A0g1DLt5ktxXzEiaKAvybvcpGDD
         6oks55LorDf3V3uO4RWDq8QaDvUcO4N0eEJENb/hHYX3woHwQg6dDATh2CJD8bdy92iF
         DhoqxxxfHaFKgeeesOZQ/G7RKpF53mDbxrHltu9y0B0odk4jHnMbAYB3pFH0tAAMt0Xr
         IEkX0FnfdS6oltUpxybmeaZB/Km16awfDkN1PZHGE2tu+JI9dKD4oB57cAJfGLaYzHAD
         mPLg==
X-Forwarded-Encrypted: i=1; AJvYcCUJBBt3duXQK07lAchJ1gmKVEe20UjjCSl2WgiDM7lHwjh5qb9K6WaDxSN8ZnhYBkfNcdX7+ffaQQS8esT0BqGSdSCQAMZ+Lx+5Hcg95o7MW+oZVMrCjn3Bgnl0OMmWaddPWE/KJt4xySjvz1oQkfgYlIG5X0PQXNUPGcR4coE7D3bM5OaYv0NJ/IdMZr3Ub9J+n9iYclUag9iT4g==
X-Gm-Message-State: AOJu0YxgEzRCct6JP53fDhO/N/Ra5Mca5MXytm2ALRkW1Gr7ppq0LDV+
	wObdDVLV4YEvh/8Bd4TjdtiBz+j3eVbq08ys/twrOG6MM3uV8OLCR36w6kY21n+/CTyMN2hdLLH
	Xu4KwHrbfz7B8Ewr7uAj14oM0hQs=
X-Google-Smtp-Source: AGHT+IFzIhW2YQyUd9cAOcumnuAgNA8lL7LVX7R3nvoZOS1vxlZNbuJ3S0Kc3PqSPmS2+VvmBf1rEWus56RvmsoxrqI=
X-Received: by 2002:adf:e606:0:b0:342:d5ac:c712 with SMTP id
 p6-20020adfe606000000b00342d5acc712mr609862wrm.7.1711661342976; Thu, 28 Mar
 2024 14:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-ccb56fc7a6e80136db80876c@djalal> <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org> <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org> <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
 <ZgXMww9kJiKi4Vmd@slm.duckdns.org> <CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com>
 <ZgXallkHApJC-adM@slm.duckdns.org>
In-Reply-To: <ZgXallkHApJC-adM@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Mar 2024 14:28:51 -0700
Message-ID: <CAADnVQLSDOfKccynu2jt-7=8nJqoLtoNkRchvHo1NCUEYOQJ7Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
To: Tejun Heo <tj@kernel.org>
Cc: Djalal Harouni <tixxdz@gmail.com>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:01=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Mar 28, 2024 at 01:45:56PM -0700, Alexei Starovoitov wrote:
> > On Thu, Mar 28, 2024 at 1:02=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > There's also cgroup.kill which would be useful for similar use cases.=
 We can
> > > add interface for both but idk. Let's say we have something like the
> > > following (pardon the bad naming):
> > >
> > >   bpf_cgroup_knob_write(struct cgroup *cgrp, char *filename, char *bu=
f)
> > >
> > > Would that work? I'm not necessarily in love with the idea or against=
 adding
> > > separate helpers but the duplication still bothers me a bit.
> >
> > I liked it.
> > So filename will be one of cgroup_base_files[].name ?
> > We probably don't want psi or cgroup1_base_files in there.
>
> Would it matter?

Few weak reasons:
. cgroup_psi_files have show/write/poll/release which
  doesn't map to this bpf_cgroup_knob_write/read ?
. cgroup1_base_files probably needs to a separate kfunc
  bpf_cgroup1_...

> If the user has root perm, they can do whatever with the
> files anyway, so I'm not sure why we'd restrict any specific knob. Maybe =
we
> wanna make sure @filename doesn't include '/'? Or is it that you don't wa=
nt
> to go through the usual file name look up?

yeah. why do a file lookup? The names are there in the array.
cgroup pointer gives that "relative path" and knob name is the last
part of such "path". Easy to search in that array(s).

> > From the verifier pov 2nd arg can be "char *knob__str" and
> > the verifier will make sure it's a constant NULL terminated string,
> > so at runtime it will be easier to search cgroup_base_files array.
> > And 'buf' can be: void *mem, int mem__sz with kfunc doing
> > run-time validation that there a null there.
>
> That all sound good.
>
> Thanks.
>
> --
> tejun

