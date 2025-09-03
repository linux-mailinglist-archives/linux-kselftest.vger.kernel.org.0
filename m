Return-Path: <linux-kselftest+bounces-40712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0574B42CE7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 00:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7503AE995
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 22:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451D2EE61D;
	Wed,  3 Sep 2025 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3I1KwVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E282EDD5F;
	Wed,  3 Sep 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939503; cv=none; b=ddiMX7dLae0/ft4Aml8RGRlCwZJXl2QOcGheDRu0VwhRXsoRdDgYoPT5Wd6ivsA5AYpRYIRNt1xCvDEKdzdqfcXfsBKh1sNz3wWkWiiCizU6ww3Q+wzmDfRrqrKodr0YfpbATEqNL4oOHDaUc/7d3MMu47/kfqmdN5oxdRZvm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939503; c=relaxed/simple;
	bh=X4M5dxCySHk6n3YMYnYuaIkMPLew79HE+kt/+TR04Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixsFlmMi6xJqsv/CFAKHH0ynCeAWBP6EdmhVqLGxdX9hUyrCClSYYRflc/INubsHHkdipdP8UN5KnP+ODSzaYVevRjWttR0dFLVfXXD9nhif1IrswUt4zY3y4YX/9mbnuPPelLMv7udU/Gro+rD5uEbDkbNb4mfY1CAJ/hAVtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3I1KwVd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so312145f8f.3;
        Wed, 03 Sep 2025 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756939499; x=1757544299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL3wjF1wZcqv+Uc+OJ9t7+Bmgm+ovPvwomwGXVd1Zl4=;
        b=A3I1KwVdO1PGr6bdJxMvua6BcrXHLpCEecVjABMlbInTYWkLEjb5FMd7OU4fAbYtdM
         bj23lg4tB8z0r4cOM8Bg0/O05IFaOmvl0gjfuYGUzaHB1i7iJPvQ0Bgl2i/SicMcYKhV
         CI1dvyYRBMqhdXh+46sC6d21hkl/1k2wxzs23kmoO7SlA6HJK6/lTMstFaZOVGqLfDU/
         F19Mnuhlllyg0RIcyzNHuKNvaBXTi9Cl2PJ6nH8/ROM5N8EDOQSsDVToP654tTVaGYR2
         vBLZqTYkQxSV45VdjvyD1KUtd6IUw5r+mZ6MbFmYv1tbC0LINUliV8oPgWz7jnNsYv61
         Lqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756939499; x=1757544299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VL3wjF1wZcqv+Uc+OJ9t7+Bmgm+ovPvwomwGXVd1Zl4=;
        b=hlWln59uzOe+k0CNDaZcfIIQSsiDkS/g7DQzg2moCiYSrGv3W/xto5e4apQPTDewuf
         C3a1E2NffGp87tnRr9sSeuPwdjpidfI6QKPA6mo0ifVGSy+Fip7KHe0xRnc9ZFyIG/IZ
         7pX+1CVBpoCy/dv19cB1kQHR17Nb9KjzJz7mWbbmDtMy7VQVScdFUxP2jXJVmCS70aTX
         dySmwSDXGcQ5MNqx+LPsfbJPSciz16RVMY2i371MjVIwj48DmZo0YGLgT/+nPRfd80jI
         LHUFXiiRiB/cX1INPgAuVV+Xty4/SVXY7yZUfEVLXsv6SNoMkWv6PiMb9KIe6D3xmXyP
         yOPA==
X-Forwarded-Encrypted: i=1; AJvYcCU7DlLou6wZdUEvMn1Sahrfwi+jTo71O9vIq6nYuvDiqQygPOAac+zz83aOaD+uBfwYpq7Crm+Gx09PkVuA@vger.kernel.org, AJvYcCW0T+Hdx+BVfB8R2HANAs/cfdtcoot1YQHhzX0IHviEsqxXLo+uL+BfSbuBA1cQ3iTl13ZKrILXMg03@vger.kernel.org, AJvYcCWj//Lb/9u65ceN/04BSNpFZVuvw4Gh+zsfOmS2IEuI2T2/DpyGlOY33xqa8WNHGdEvuRE=@vger.kernel.org, AJvYcCWoF6v3BBlTF32yui/9/eK3sGlIuyjPUALg34rdNKqUxqCv7YT55Un5o4UhheSF6sZjRAxY234j8/pSIFfM4cds@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGdhgaLLtY3jR1CtZudLElDpZ60fY1PhAWdIM79JfQrvOxBTF
	94aUAbmI1DTJ0kJTL+nlsPfECRFGmVVvFAu1G9cWP+tYnH4Ee/tellGXBpusppjcPlyfy3GYV6B
	+AYe3fpVfj+vomC5rpHGVZf4rx5gm798=
X-Gm-Gg: ASbGncuVnx10QHAbRRI4SEt18W7lVjLVNtDZapu0XaZeKuEWk46Cccg/aINDxZja4yu
	tfYgFH06MzY4WfLoWSzSH3FHuts6n4Kc4+EfeBSV1XPvxI/KfSm+kujk5k0LYjZtWXrff/Si12P
	mLSmOLMuBU9D/8G80/IBLyTUGU77l+f57KU1r19daLc972QGUag7lyOT6d1Epr4EZC9pug/qT/c
	6Dhjw==
X-Google-Smtp-Source: AGHT+IE39f9U9RxaEWs4FarYajYYUmFc4BTg+msL9eIc847MP0P53GL+oasa8Vh3X/AfZuiv7OMUvD4AxL4KvRQQUA8=
X-Received: by 2002:a05:6000:2011:b0:3cd:edee:c7f1 with SMTP id
 ffacd0b85a97d-3d1e07a4d63mr11912777f8f.56.1756939499125; Wed, 03 Sep 2025
 15:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903203805.1335307-1-tom.hromatka@oracle.com>
 <CAADnVQLve3KgrqNqSqVrmL-wz6Jj1QUdjAcE5P26Z4wvh9e4HA@mail.gmail.com> <42cf76db-6cda-4606-9128-6f433da57d48@oracle.com>
In-Reply-To: <42cf76db-6cda-4606-9128-6f433da57d48@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Sep 2025 15:44:47 -0700
X-Gm-Features: Ac12FXz9XSXTF31t9YDp5oRWnCCbLgWQbDHP1nrNlbz-A35_LCJZvinVMNmatWc
Message-ID: <CAADnVQJSgcAjEnU-A9bF6-9MQRFvbHqRsCCY7a0Y6bhVGtcGpA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
To: Tom Hromatka <tom.hromatka@oracle.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Sargun Dhillon <sargun@sargun.me>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:52=E2=80=AFPM Tom Hromatka <tom.hromatka@oracle.co=
m> wrote:
>
> On 9/3/25 2:45 PM, Alexei Starovoitov wrote:
> > On Wed, Sep 3, 2025 at 1:38=E2=80=AFPM Tom Hromatka <tom.hromatka@oracl=
e.com> wrote:
> >>
> >> +
> >> +       spin_lock_irq(&current->sighand->siglock);
> >> +       spin_lock_irq(&task->sighand->siglock);
> >> +
> >> +       if (atomic_read(&task->seccomp.filter_count) =3D=3D 0) {
> >> +               spin_unlock_irq(&task->sighand->siglock);
> >> +               spin_unlock_irq(&current->sighand->siglock);
> >
> > did you copy this pattern from somewhere ?
> > It's obviously buggy.
>
> I tried to mimic the logic in copy_seccomp() in kernel/fork.c,
> but as you point out, I probably messed it up :).
>
> Do you have recommendations for a better design pattern?

Several things look wrong here.
Double _irq() is one obvious bug.
Grabbing spin_lock to do atomic_read() is another oddity.

