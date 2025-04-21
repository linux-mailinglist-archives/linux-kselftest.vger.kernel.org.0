Return-Path: <linux-kselftest+bounces-31274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA349A959EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 01:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B357A34D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 23:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6690F20297B;
	Mon, 21 Apr 2025 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beZYmPkT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930A139D;
	Mon, 21 Apr 2025 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745279337; cv=none; b=tWYf9sOgFxNtT4R+OX7GSp9LLzhyiMIyej+p0WGmRhGVIdW31dB3PBVtvYZWY+GNCp6zJOyeWhX0hNDcYz2q66gOQi7OH3aP6dvmVmN5ZQCSXTeP11d3uwv48qQ1FisX8NKnFtj+dC04tpWgYbXE61tJ8LXeA+iu6IrNQUjMwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745279337; c=relaxed/simple;
	bh=HfVBTitlqw37llnfFhy3ubEbFd6ASiMSxBhfGkJ/7oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbYIl4qkdmHwlixZgMf/5b1D+vf0kN4VNp+vxzlN7Qmsay9hSEfhz60ooBYPjtyLTkZM5DjXa90qex58PpL2RfaDDVFcqoa5MANiTqB6t2vuZ9OvQE8oV92J2FiqP2xnUigUA3l1oQCVSAgSipgGNsYqsWt2Lr7A1dq/4LB5KN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beZYmPkT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe574976so32919635e9.1;
        Mon, 21 Apr 2025 16:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745279334; x=1745884134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfVBTitlqw37llnfFhy3ubEbFd6ASiMSxBhfGkJ/7oQ=;
        b=beZYmPkTDaoIVp156oTuImnq2Z11gH8geshaAedO+07CxJ0Dt46eXiRXmtCDaOe1i0
         7vAOqgGCDOMup2nko7cq/Zai1AY4SoPF/6Z7tAQ1PeMyDKTlim2MCuFWxwBFTKlCdrlw
         xj1ANWHmAUIxFoP0V3DeXwMuls0G9pZQ2LXzpZ6LNfrRiiiZcVw2yOpjrfHsx3lGEbQk
         uPyD6yEz9mffFXlOpYLwWasW5sNoN92oXNbz8tP/TQRfhgCbtmS64VpDZCEakalr+t4k
         JI/NJIS1fttypKa/IiWdu8iKlwg+hnIESuN/ctJ9Wp+YAERSO/D497yvn0nZHzAJq9x0
         pDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745279334; x=1745884134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfVBTitlqw37llnfFhy3ubEbFd6ASiMSxBhfGkJ/7oQ=;
        b=mkjoagBaYqQB4ws/rkJlXpOY9d6oOWOr1gI0XH8qtNiS/9sNCNCDnQ0btoPTWS4H3p
         GnJFy4jrGkO17g5bOM85PxzSqI6hHUYe8mjpevcAkeQ7w0Izuk2NDwHCIz5jG6sUtk3u
         95IKlxUnvQpAspgRNH7vaWImrGKvcD/8S7NkO45jfBoQAIXjPWFF46Fr69s/X6HvpOdT
         yT1JJ9nyMMr0YhlE7B03cQRJIfVVRh3KLv8z8T5uUo2Oqv7jt+roxw5oGLuZqE1NcXu1
         RDTzT0R+GeWspwMnOU/0o4SJ8fSSixU6fUnJbukTtJPhykQ8O1bBchYz1oysl4oWqSPl
         CNvA==
X-Forwarded-Encrypted: i=1; AJvYcCUJQ4IRKGshK0C4A+2roZ62HPzYm46C9nt/BEi20x0nt1tcJ9fMroCjUiRvQmrDDHgft3B1/Xd9akJ/xJY/FD+KCzWY6tsR@vger.kernel.org, AJvYcCUgp5LYWzHkb4wbRoGe802KEMZd+OkvlM+fKHT9gu8tEoLkTeJk0WuuOjwNGOIGeCR2318YU2hGcXM=@vger.kernel.org, AJvYcCW4gs6DwI2kPeWXI7HEU6gJhoUVN9yzOG2ltgG/eq1YoNOV+twRTWVsalmhEWuELwSdCDVC4vlMkX81@vger.kernel.org, AJvYcCW8xlX/C4rk+aAR43EUK3O0B1FfaFMGUrHRgf8TUyOKmbLOz/4Y6+irZrXzI5q6rH+ZjNE=@vger.kernel.org, AJvYcCWO+0JRTI+uOSMD9yESp5WiGHIMhh7qywri1+HCEXLu2OPzriI77LgdEaqKHoASdOW+8hdF9BXgUiWklGrP@vger.kernel.org, AJvYcCWXLdsUEPAjtZAvjRMIVRMbm1Eb8vEMdcel7qnZqBVKZcx3+ZO7CICX+HDf3qMleyLxnDQ5BlnQi8SAaMMf@vger.kernel.org, AJvYcCXL2S19HBif7x4ZNRCPq311lRafpOAF4vYXb/FWS9V0gttkFvlYPhVDARNkGybfh9/rPlVL174gYTCzyXTj@vger.kernel.org, AJvYcCXg7xopgp4Ri1hi+xEqoGsPXYAslytxSG986CQ5BYRX7G9t7otbirskp+q18wXerP6tRr5TNM7l6Y/LGUMX6vlL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywep8W9MKdwzlJsZ1ClvCnFCoOPfipnj4ighf1gsNdK6hrb18Id
	gHo6a84oTrUIwgvdfVWm4z29UXCAdeNBOXWiyXWqIZA0VZB/pjq3I28M0YDqiexh50zVHGcCBZp
	4Pv935D4svJriNbFXmyHt/YGxYoU=
X-Gm-Gg: ASbGncvbkb4+rL3IEyVuTjWR4VPGgbaaqncGwgywo9TRRitRvKKC/8pI6OpWu99Xd7e
	JFO0oWyynHezGMWQDZqVQ9csE4lIFwRAhItCSVAGj4BhJVJMSTEmU5p4oW/bVzdT4ww0I
X-Google-Smtp-Source: AGHT+IEXBshZFqY/Fm57erlfCKXrxXtVpOr0Raqyk+6rCL7tzyvjIoEz5K9J8PoMsndTW79fhqMVLoXuyIzCeovcuR0=
X-Received: by 2002:a05:6000:4282:b0:39c:1257:feb8 with SMTP id
 ffacd0b85a97d-39efbb0a99emr10401061f8f.56.1745279333918; Mon, 21 Apr 2025
 16:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com> <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
 <87friajmd5.fsf@microsoft.com> <CAADnVQKb3gPBFz+n+GoudxaTrugVegwMb8=kUfxOea5r2NNfUA@mail.gmail.com>
 <87a58hjune.fsf@microsoft.com> <CAADnVQ+LMAnyT4yV5iuJ=vswgtUu97cHKnvysipc6o7HZfEbUA@mail.gmail.com>
 <87y0w0hv2x.fsf@microsoft.com> <CAADnVQKF+B_YYwOCFsPBbrTBGKe4b22WVJFb8C0PHGmRAjbusQ@mail.gmail.com>
 <CAHC9VhS0kQf1mdrvdrs4F675ZbGh9Yw8r2noZqDUpOxRYoTL8Q@mail.gmail.com>
In-Reply-To: <CAHC9VhS0kQf1mdrvdrs4F675ZbGh9Yw8r2noZqDUpOxRYoTL8Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Apr 2025 16:48:42 -0700
X-Gm-Features: ATxdqUFvJ5JqiHZwXYEgBfCPoKBSXKlaJ9eXRgCVajk_7W-Bdt-DhPnVxLR_eG0
Message-ID: <CAADnVQK7kyBso6bNEtNyC6zTBDuBv-K-c4a9KBVid+B405VX6Q@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Paul Moore <paul@paul-moore.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 3:04=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Apr 21, 2025 at 4:13=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Wed, Apr 16, 2025 at 10:31=E2=80=AFAM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> > >
> > > > Hacking into bpf internal objects like maps is not acceptable.
> > >
> > > We've heard your concerns about kern_sys_bpf and we agree that the LS=
M
> > > should not be calling it. The proposal in this email should meet both=
 of
> > > our needs
> > > https://lore.kernel.org/bpf/874iypjl8t.fsf@microsoft.com/
>
> ...
>
> > Calling bpf_map_get() and
> > map->ops->map_lookup_elem() from a module is not ok either.
>
> A quick look uncovers code living under net/ which calls into these APIs.

and your point is ?

Again, Nack to hacking into bpf internals from LSM,
module or kernel subsystem.

