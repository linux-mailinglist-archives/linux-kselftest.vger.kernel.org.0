Return-Path: <linux-kselftest+bounces-10600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5CF8CCACF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 04:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC80F1F218E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 02:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2013A41C;
	Thu, 23 May 2024 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHCRTCSM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0612BEAC
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716432056; cv=none; b=IOC2hzH6OHxwq+J5HB1AUxhx1bZepXM2U7l9Y92Iw+9qthNQ01c8VXmbFdtobzyTeQ8/1x2NRUt+YUl1kxR/Dk60j8QwA0pVVh2vvPLGf3+O4vA1w02CHJPsH0sKSfFVl/avsnomXKpXrOOEGMZUuYTRKGd4yMeZrerQa9mgTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716432056; c=relaxed/simple;
	bh=8ZGDf3OkPJBcA1wHNNztZpCmXea4Px7Syw1Vmp3K8E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6b+KNHuXM6yz3i9RGMadaQq070JLbc2JdnHEvtXhuwymi8MP5Z+RgVX8SgOukn3glKu1C2ts+qkh6EcNiQQMFJF2Juze7fDz+hZ/Jk635Lh4k0natWVJOZpSDWA3NFczBGAB3keDcbrMX+cWym/1XmhznfAuiLccpPVea6/mXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHCRTCSM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so6944a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716432053; x=1717036853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWPP+Dz40GrCKZ1VUrua2jxqIySm9s34x1EAA+mtGnY=;
        b=uHCRTCSMk85X1GPNz5kWn5DZuwz+GgdxUd9ik5WV3TGUKca8WgXnhk83bGz2RaMBgh
         zJOdERn4w/PYcbL4S3Nycb6T6HC2kcPczJ16rgP8YbqE3tRBJFUwxowhM6WMOWZuLPYS
         UfmwcAag+AKdVoXGpum3KRdbBbhUUvZqWAhKwoSbKBoOAdWNHXEEbTPiGrsPqouaiw/e
         OriJl9uu250e4X/Kk015LU7FFf7AxVuO8q1d4dewZFWYc0UZNyJMHFQeF0WD9scyxvoc
         WmlGui7KszQaSIGZWqWqkxLnEeGjrwqkCadNE1temVBGFBC3RuhEIgmW3WktkU52vaOI
         X8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716432053; x=1717036853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWPP+Dz40GrCKZ1VUrua2jxqIySm9s34x1EAA+mtGnY=;
        b=wtBMEr8cZkH08Dl21XB1WtMw/HzkxnMgp4gj/WkF6Xa8KHS1vEnCE6+TW869cW3hoa
         O4qp1c2GJkbJSEvF6DwjMAntGd5j++SF5+Z0Ioc0K6Otl847DfJlF8Tq5ec6bGhC8fOa
         IsqGAl7SAVWk8Ug4gKA1tBVAlF39AJVknEj7DExHDnhdrlMSLGpu/NI2jsGE//uHQKbR
         snNCt+BbF+AT57R2W3BzMZ3427GnLok8VY+qYx2xJ3QwFZ7t/eK4DRQnc9G8tUJJDDIt
         5WClxfKTijFJnDRhl1/+aNGWEP8Vz65QVdv51esg9DGOTW68wtjCC2geeS8E47qWSF3Q
         Sdqw==
X-Forwarded-Encrypted: i=1; AJvYcCWBnydxpFTZHnub/ItVTIOc8SL/gnzuJY/ltfysbIOsxsX+PUbwQN3AMY/Fn3Aj25KFY/jcDYyh5NeHLYY7YvowHrmOFv/MWmX5pnzZukGs
X-Gm-Message-State: AOJu0YwDn26Hjv43fSuhgyiCSlhktUrLssvdek/MsPu7W3xNxrG2jlwM
	LalkX9iDzg0wDiRpfQiy83N7lZ4sLoW4nPpAiIIySJcHPu7JhZBuBpZH8DFxIJ9+2MORjH/Disq
	TdjkvjypnZ82Cj2hxMgQvyoAQSDt8IEK5GnbX
X-Google-Smtp-Source: AGHT+IFoMprtUuWbtKldBe/3g28FFO7W6k7ncLpONbXIhGG03bnXo2gGbai+JCKMqKm0XjcPlnfIbbiQJUoxfs57HHY=
X-Received: by 2002:a05:6402:4305:b0:572:9eec:774f with SMTP id
 4fb4d7f45d1cf-57843b1aebbmr108042a12.0.1716432052838; Wed, 22 May 2024
 19:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org> <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
In-Reply-To: <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 22 May 2024 19:40:15 -0700
Message-ID: <CALmYWFtnQH2UkjkZ+VWdsDjiQATcn-ori2UM0AdOnqQcxZ8Y-Q@mail.gmail.com>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, 
	jorgelo@chromium.org, skhan@linuxfoundation.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 7:25=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <pobrn@pro=
tonmail.com> wrote:
>
> Hi
>
>
> 2024. m=C3=A1jus 23., cs=C3=BCt=C3=B6rt=C3=B6k 1:23 keltez=C3=A9ssel, And=
rew Morton <akpm@linux-foundation.org> =C3=ADrta:
>
> > On Wed, 15 May 2024 23:11:12 -0700 Jeff Xu <jeffxu@google.com> wrote:
> >
> > > On Mon, May 13, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <po=
brn@protonmail.com> wrote:
> > > >
> > > > `MFD_NOEXEC_SEAL` should remove the executable bits and set
> > > > `F_SEAL_EXEC` to prevent further modifications to the executable
> > > > bits as per the comment in the uapi header file:
> > > >
> > > >   not executable and sealed to prevent changing to executable
> > > >
> > > > However, currently, it also unsets `F_SEAL_SEAL`, essentially
> > > > acting as a superset of `MFD_ALLOW_SEALING`. Nothing implies
> > > > that it should be so, and indeed up until the second version
> > > > of the of the patchset[0] that introduced `MFD_EXEC` and
> > > > `MFD_NOEXEC_SEAL`, `F_SEAL_SEAL` was not removed, however it
> > > > was changed in the third revision of the patchset[1] without
> > > > a clear explanation.
> > > >
> > > > This behaviour is suprising for application developers,
> > > > there is no documentation that would reveal that `MFD_NOEXEC_SEAL`
> > > > has the additional effect of `MFD_ALLOW_SEALING`.
> > > >
> > > Ya, I agree that there should be documentation, such as a man page. I=
 will
> > > work on that.
> > >
> > > > So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested.
> > > > This is technically an ABI break, but it seems very unlikely that a=
n
> > > > application would depend on this behaviour (unless by accident).
> > > >
> > > > [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@go=
ogle.com/
> > > > [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@go=
ogle.com/
> > >
> > > ...
> > >
> > > Reviewed-by: Jeff Xu <jeffxu@google.com>
> >
> > It's a change to a userspace API, yes?  Please let's have a detailed
> > description of why this is OK.  Why it won't affect any existing users.
>
> Yes, it is a uAPI change. To trigger user visible change, a program has t=
o
>
>  - create a memfd
>    - with MFD_NOEXEC_SEAL,
>    - without MFD_ALLOW_SEALING;
>  - try to add seals / check the seals.
>
> This change in essence reverts the kernel's behaviour to that of Linux <6=
.3, where
> only `MFD_ALLOW_SEALING` enabled sealing. If a program works correctly on=
 those
> kernels, it will likely work correctly after this change.
>
I agree with this.

The current memfd_test.c doesn't have good coverage sealable vs not_seable,
most tests are created with MFD_ALLOW_SEALING
I think the test_sysctl_set_sysctl0/1/2 need to add  cases for
no-sealable memfd.
because the change will also change the behavior of  the sysctl.
Do you want to add them as part of the patch ?


> I have looked through Debian Code Search and GitHub, searching for `MFD_N=
OEXEC_SEAL`.
> And I could find only a single breakage that this change would case: dbus=
-broker
> has its own memfd_create() wrapper that is aware of this implicit `MFD_AL=
LOW_SEALING`
> behaviour[0], and tries to work around it. This workaround will break. Lu=
ckily,
> however, as far as I could tell this only affects the test suite of dbus-=
broker,
> not its normal operations, so I believe it should be fine. I have prepare=
d a PR
> with a fix[1].
>
Thanks for the investigation.

>
> >
> > Also, please let's give consideration to a -stable backport so that all
> > kernel versions will eventually behave in the same manner.
> >
> >
>
> I think that is a good idea, should I resend this with the `Cc: stable@..=
.` tag or
> what should I do?
>
>
> Regards,
> Barnab=C3=A1s P=C5=91cze
>
>
> [0]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46=
f267d4a8784cb/src/util/misc.c#L114
> [1]: https://github.com/bus1/dbus-broker/pull/366

