Return-Path: <linux-kselftest+bounces-7709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9188A199A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 18:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D900B2503E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055D785945;
	Thu, 11 Apr 2024 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DfIUfbjf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C485285
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849616; cv=none; b=L/vm0us6zbS/U5SCDZmZFc28AfhIAj5QkH8b5+YZg0hSTLyFg4w2baKBKIzvc7lzzIxfHbC4r3nsKxUKX2ha4J6IsDPVgU9IkO/Z6+dW7GgtxgZ2D/FKdZS+HW69rqruoF28Qjqmk88hmCzGyJHuf39hdMyJpWDmsON/KycZhV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849616; c=relaxed/simple;
	bh=PbLspCwu5bkgUdK2U9YWWFJDaTS6qgXYBAw1NQGhQTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BONGxgHqalKAlYvGTB5G9xbCR5L/TACD0weWnxdU3LKctw6FT7xk9vJSTGqgURk32u8GBZMuvpEAqWQPokUJOTPna3Q1C0zkcbaGrwMuGFGZhTa3lgHY/fNkLkuse72q6BwhV+dMrqbnt2kaZcoXPDkVQqfxoCwr4mtG/D2G13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DfIUfbjf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so95015e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712849614; x=1713454414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWEKgvL/ZOpKjtTgIwws6qhc3HHfgaLuekbpj/jm1oc=;
        b=DfIUfbjfC35idweQK7LNh05x+QHPEk6q6gaQAtg8Lbv75BznVDCQI/yKui6fvLDhLi
         OLVB9sI1Zv0VqZvTly7QyiVTUpfXd7w6zyqj8DAkg8tH3zVgcUTLakzL2Wo6Stl1g+gi
         cX8qVz+xEwD0OX10qn0xx4cQJ9mKxvPNy7gKino9urfmR6OHCXJNeX5RiUkPcY2ArUMV
         bG7rjElKIj8ePleuSlqfZ6VUOMLiSXTeGdzNV9u9ME/kQSQrzkwpIGqGNhSq6BdjvYw7
         PnTJRuUz+S7DMwSURQMFv5adDi2glOl6Fe7fSxIH3+pcNfzd2Fb/KNXF+ABq/rpGsvQ6
         vH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849614; x=1713454414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWEKgvL/ZOpKjtTgIwws6qhc3HHfgaLuekbpj/jm1oc=;
        b=tzwNj7hyE17W8/22Ns2jCWTQc4xs+pVJEyZjwLHXqshIMTkkuhDECZRCYg2uDSy6+Z
         ZCJe8JXjHM2sN4YoE3RqGf7E6OOZ1xzp8vlKwTtWYS4N9QlX8zb1zZZ6XTgQ4dkKGFhM
         PzaPSmP6/oBWkSGVbsIlP24nUCcFhmOunX6nIodjId/OUVHha+Y2IwYIYgNs81z5E1TN
         hwcHsBd+xyk26v0xMmmzeuMnCW4/MEypXPnEhDpzeXC5jQQaNMSsNlEsY+U26uuzs7hW
         OdL8Kb1Tp/1yJaue+AlDOyOmqeoxgJi/wHUxSRzvCg21K4yC+YcK8UfYC6sm16581Qwi
         EEWg==
X-Forwarded-Encrypted: i=1; AJvYcCWjifZGFU015kMenIc0Vsg7UUJDSlkRAn3ZVmdNLz/u//HeQKY6qiOd6kEywdz8SYSOTH89UMU+1KSBTI8WuJKISsa5/32jgvY/UrC56w/5
X-Gm-Message-State: AOJu0YyBnmslFOZuOFtsrSPP80WwxfLlLNaZBdDiyG5iZT0SuVAddS87
	LhUoxH7rkIXthLvHDjVlAl3uUcisJ2GRjvjSPTHs9bWGT97zCIVU7nqq8NVXMyOgr7x4vY0TCT1
	SBRxmKE/71XDRky368ZGLC7g+yFIK2DC2j0Q=
X-Google-Smtp-Source: AGHT+IFSA46efEwvLckuLo22i0EaoWGKSXc3A8+EHYGsJ0Jh6gXKAMZ59K5Ow6WfR7oga9HRD4hRH0d17iec05aSqZo=
X-Received: by 2002:a05:600c:3b93:b0:417:3f9e:5cac with SMTP id
 n19-20020a05600c3b9300b004173f9e5cacmr177314wms.3.1712849613449; Thu, 11 Apr
 2024 08:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx> <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx> <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx> <20240404145408.GD7153@redhat.com> <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com> <a9a4a964-6f0c-43a5-9fa8-10926d74fbf1@sirena.org.uk>
In-Reply-To: <a9a4a964-6f0c-43a5-9fa8-10926d74fbf1@sirena.org.uk>
From: John Stultz <jstultz@google.com>
Date: Thu, 11 Apr 2024 08:33:20 -0700
Message-ID: <CANDhNCp=7mTSSO4cXQjYbtLrK8XRCbCyse8Bq5Wbt5V4G-K_dQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement check_timer_distribution()
To: Mark Brown <broonie@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, 
	Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:42=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
> On Sat, Apr 06, 2024 at 05:09:51PM +0200, Oleg Nesterov wrote:
> > Without the commit bcb7ee79029d ("posix-timers: Prefer delivery of sign=
als
> > to the current thread") the test-case fails immediately, the very 1st t=
ick
> > wakes the leader up. Otherwise it quickly succeeds after 100 ticks.
>
> This has landed in -next and is causing warning spam throughout
> kselftest when built with clang:
>
> /home/broonie/git/bisect/tools/testing/selftests/kselftest.h:435:6: warni=
ng: variable 'major' is used uninitialized whenever '||' condition is true =
[-Wsometimes-uninitialized]
>         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor=
) !=3D 2)
>             ^~~~~~~~~~~~
> /home/broonie/git/bisect/tools/testing/selftests/kselftest.h:438:9: note:=
 uninitialized use occurs here
>         return major > min_major || (major =3D=3D min_major && minor >=3D=
 min_minor);
>                ^~~~~
> /home/broonie/git/bisect/tools/testing/selftests/kselftest.h:435:6: note:=
 remove the '||' if its condition is always false
>         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor=
) !=3D 2)
>             ^~~~~~~~~~~~~~~
> /home/broonie/git/bisect/tools/testing/selftests/kselftest.h:432:20: note=
: initialize the variable 'major' to silence this warning
>         unsigned int major, minor;
>                           ^
>                            =3D 0

I hit this one too yesterday and included a fix for it here:
  https://lore.kernel.org/lkml/20240410232637.4135564-2-jstultz@google.com/

thanks
-john

