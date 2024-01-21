Return-Path: <linux-kselftest+bounces-3278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D588A83372D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 01:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6732BB2189B
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 00:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D8819F;
	Sun, 21 Jan 2024 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jb6xoVCm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5498377
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705796213; cv=none; b=ANgB7JKPeL0En+7VrwF0nZVgfpbagUJ260ugzD+uUHVUzmAgZ5BNw9NFPsuR868gKqUTSdxucxZZEf/6iOd1mB3BFL3wdL92RZgQeB9t3hAcBdZGSpcdPtCU8M+SMqWpGTzqYLFSPNHhRntpaNc909AnkvYD0S22wnIHkRW7FoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705796213; c=relaxed/simple;
	bh=/C66J7wkQwwS2IqQ96WKFgsVf+pRy97LkmCeeYhVdP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwnKWebeCCjZiq1oHkwXqUFZaCd5ExFr8Y0spj9KZXg/AcnkkBB94ZbY/fs3mh1PJeymyC/WKdg8wYDUCMVOjsAXMdFOOXwxtUXuD0YZw/jIN6uNb6tbkgidZFEcKzJTFQ3BJL5MCrhP7a3gspkwLjLCQDVHGnf6bMNJ7mhDDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jb6xoVCm; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-210aaf2af35so1448355fac.2
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Jan 2024 16:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705796211; x=1706401011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGx1uUqBJNwaB067t1zS9OZh+thLjfiev6N5olOliBQ=;
        b=jb6xoVCm4erIHuii7QR+BQMXQW1udD1XI2eGpmGrRN07v1b8g2Dans3F6BK64Hguzm
         agWG9o5d4WAs+bSZfi/Q6SQQaidl50E81tkc5ANVEDAw1sEsgqRkaAHEwRGh5ZQ0NAbL
         EjhBG8lpCf1gr06FhT8gVyDJyUCm3wAkpYBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705796211; x=1706401011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGx1uUqBJNwaB067t1zS9OZh+thLjfiev6N5olOliBQ=;
        b=ZW3ZGdFVHXwqvkxvcRFdDsxYuUDEpmr0SiRSAOXU7LGrNs4AsaNwUnDB3+4bkqaQKY
         3Y6uqbO+0Yl3VklCrN1iyzG68AaXEBU/TEmxSheE+iOsDF5L0ZJE45fHEXTAIscKadWJ
         TnU0PfjUBEgiEIHQh6XXpWrUmrst8HnY9mFMG6W+2zlwJZFckzpkPqRZOU1Z99Yw3ntg
         gEbkZb1GLUDLIHTfUUCqDd8k8at4tAOKWTbOpveVflooVUIpEy4hh9SY4rKgh7VbXK3G
         OhttnhqY8JgOtzdjr12VfWR9oTkBQge02p1AYk1ur+7EWVGgkH0vO6w5CkolZCBlTUvU
         yLLA==
X-Gm-Message-State: AOJu0YzRnJtOQezqGgaovZzPKudQQeL+FJSj6OUGHYVxvFiiQTasQXhZ
	Wmg2doBa36n2FD8xmOBfn/klUh3xYLZXLag+oD8qxTHJ1L8Q4LApbN82TeOO0TBHGnJykT46q+C
	xN6TOVU16AjxW0JD/DV3Y8VM9HjfC4edrSZaw
X-Google-Smtp-Source: AGHT+IFwp+DKXCAKoixsZuns+yTYxxlyPCYBxSpYdd1fXnL6rdiY+k7qeKJU05Nn//cgId/cR/5b/LaiwJxnDuIsufc=
X-Received: by 2002:a05:6870:2e06:b0:210:8df6:3b04 with SMTP id
 oi6-20020a0568702e0600b002108df63b04mr2269701oab.102.1705796210854; Sat, 20
 Jan 2024 16:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
 <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
 <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
 <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
 <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com>
 <78111.1705764224@cvs.openbsd.org> <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 20 Jan 2024 16:16:39 -0800
Message-ID: <CABi2SkVXgyG4r-SzkXx0-MOQ2dqhy1ewwhvfXMJLw066i1zJKw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theo de Raadt <deraadt@openbsd.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 8:40=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 20 Jan 2024 at 07:23, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > There is an one large difference remainig between mimmutable() and msea=
l(),
> > which is how other system calls behave.
> >
> > We return EPERM for failures in all the system calls that fail upon
> > immutable memory (since Oct 2022).
> >
> > You are returning EACESS.
> >
> > Before it is too late, do you want to reconsider that return value, or
> > do you have a justification for the choice?
>
> I don't think there's any real reason for the difference.
>
> Jeff - mind changing the EACESS to EPERM, and we'll have something
> that is more-or-less compatible between Linux and OpenBSD?
>
Sounds Good. I will make the necessary changes in the next version.

-Jeff

>              Linus

