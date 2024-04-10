Return-Path: <linux-kselftest+bounces-7614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E48A0371
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E412858DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4BD138E;
	Wed, 10 Apr 2024 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYnXB5PV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91358BE2
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788412; cv=none; b=qG4OXiTMrw03X9BfUn5ILyr46U4TDIeFBnRPUd78vn6N+kpjGYcE2bMC0df3vaaXhTtXIEDBnkFnIFCECtq9GsvoGq4CiqeSx47+7ugGt82pPVo4J+S+Q9zY+7oHrwo8HhpH2KIvzv0Xe9yCwIHDZic2z7by0kdCJYxtg5IynQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788412; c=relaxed/simple;
	bh=4ft8+BLnp4b5tUU7G3n/2WvSh88QV/cvF1d+A/V40wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOub9CDnEU7k8aMc52K9ObMwTWug7NF6ZELBdxC3QTT8EiyIomxEtn+EZQq7vxhB8KlvPuF5PbDbwivcPkxnThhQoGwSzTl5uLshURgQXAs1ch1tm0cHIMwVWdvlbi+i2ONUTy2mNiAhIZuKdK2LhQY9WtghqzUDFhAMNn8hrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYnXB5PV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso17665e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712788409; x=1713393209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGcSmVs/OyYWYMT/pav2rCPGZAehytayienznXagGm4=;
        b=IYnXB5PVVXKgKBzTotaL9+ZIICp7UOVZLEhhAVOCc1qtI7Z5ZMr1775RIuGV5zB9Pp
         wzEmgOcqI+iBnAB/MRXtl+LEvcmcKmhrsa1VBGBEIuKufEvmvtgtBwXro4JGrIaQWil3
         loEDNbKRM2ANY4ZnNPWavAcjFMAuE9+ySrjl2xW8EgYhUOPd0uIa/hggP+Bo82l7YEOA
         +qpwtedsFUHUbOlrJQr0I6WAeC5wiGxe6gZFp3LL/Sxnki+wTo0QSqaZQ1zsR0yQhCmK
         TZjFyg41yInAdbooWF4t9CFPpiTgJywCTrJNuRcbgNDPWZtTsYBt5ZucHhJtj5PKk1vF
         S/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712788409; x=1713393209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGcSmVs/OyYWYMT/pav2rCPGZAehytayienznXagGm4=;
        b=FECThJ852SByKIfZ2w9p5UPXd0hZrIkutMoMf+Y6RhBCqiVAV/E+b49+e/gOxe7I/a
         wWHTr9h7m/xg92fktPLYTxt7eIWlCxKv0yXiBi1IXaIdfOXnNRhmWD/2ki600HNeMkyh
         BUXhqNRfKZYW3E+AVhWcfYzQ0Q+xFEntZEgwuD2GpyXMyIY1SYG3rrqfjOeIaS4n9Zvo
         nrNlFJ2cMs3Eood0u1Q+XD1skNIxtSmbp/4z3tzFDx3U+OBo/gaqbBvRzhINYFfnj8bX
         nMs98b7pPO9DkeJNNKC+0Z5ojy3zWbwqoG5l6O93cFT94hITJ0hjNAd2dysXgryTD4Sf
         eHFA==
X-Forwarded-Encrypted: i=1; AJvYcCVcVFCma0s2Ov8mUQZ3YvpIYM1mcHyqfzzhV8tvA2qXGW83lBby3h+ZCMxR24rSZ3rpc6a9fZ9Ly0IG+u7XrZwRXyMTEpFRc+UWMOwM+5qU
X-Gm-Message-State: AOJu0Yz9sUYpSa0qWLvqY/Z8tjHOTem5OaGwEMYeydvxZb3ApfrpCfgZ
	ufOUIipc1yyAxmc9qEaVWhsyepz7pejuQlz3EgB2IyzJ0omMy7na+09CkXfMbraxL4Oq+4WSIhi
	SyUsvl+IdOuUAgBr5/nr39H445sO7nZhJF0A=
X-Google-Smtp-Source: AGHT+IEBbpFtvARmE1LPzV9bk/pygsBn+sOPIDeU2X2UzQNazot/tH3r4k8KEounn2kt3p3wZnVlOihZCa85CyVDhxA=
X-Received: by 2002:a05:600c:3503:b0:416:6d90:38fe with SMTP id
 h3-20020a05600c350300b004166d9038femr69216wmq.4.1712788409046; Wed, 10 Apr
 2024 15:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404145408.GD7153@redhat.com> <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com> <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com> <20240408184957.GD25058@redhat.com>
 <87il0r7b4k.ffs@tglx> <20240409111051.GB29396@redhat.com> <877ch67nhb.ffs@tglx>
 <20240409133802.GD29396@redhat.com> <CANDhNCrverCP+nB53XnMKFH4sTvxmtchiLWyGbNW6du=8xOSNg@mail.gmail.com>
 <871q7c3l47.ffs@tglx>
In-Reply-To: <871q7c3l47.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Wed, 10 Apr 2024 15:33:17 -0700
Message-ID: <CANDhNCpas4AQuAquVMVFgN3NCfCsVgg993Kjad8MjvSZAbsXow@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/timers/posix_timers: reimplement check_timer_distribution()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Apr 10 2024 at 15:21, John Stultz wrote:
> > On Tue, Apr 9, 2024 at 6:39=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> =
wrote:
> > This is working great here (on both 6.6 and the older 6.1)! Thanks so
> > much for fixing this!
> > One nit below, but otherwise:
> >   Tested-by: John Stultz <jstultz@google.com>
> >
> >> +err:
> >> +       ksft_print_msg(errmsg);
> >
> > This bit is causing the following warning:
> > posix_timers.c:250:2: warning: format not a string literal and no
> > format arguments [-Wformat-security]
> >   250 |  ksft_print_msg(errmsg);
> >       |  ^~~~~~~~~~~~~~
> >
> > A simple fix is just to switch it to:
> >   ksft_print_msg("%s", errmsg);
>
> Can you please send a delta patch against tip timers/urgent?

Will do! Apologies for not getting to test and reply earlier.
-john

