Return-Path: <linux-kselftest+bounces-28319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EB2A50401
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3523AF466
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13172505CE;
	Wed,  5 Mar 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHQsMgUT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233FF230BC6;
	Wed,  5 Mar 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190307; cv=none; b=KOF7Rf1pKvzGbJCPaZ2TpLaGrpCrMhVWuSAPc6sea2cuyp2ixteziJK5ZqO1Tq+tFO0u2CdxdrmsZY/x+RCjxokUAdMjiRG+VHt7UwuRjUNvwFD7FRrGrDHAmXiu+k8otrn+uiTJmNe1oJpjiZKJpIcINwDzIgo0BhG507YR138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190307; c=relaxed/simple;
	bh=+oRhlezTzKi/1jDJ5WTqmL8g/xu4LuaqBsnEOCp/6aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJFklu5kQz2KVA6xXu4aAXDgCXgqgQxCiIfqVvnYay3NOpsA44/WPSkKQES7AU+Dpjg42zfCQRXEsYXeUUoKJU+p3vsa3Lj5wIFyZdk7KlJ/Jb3ffA+o96rzt44tWmKqK14ChPYrDAnEbIo3WoavdpyENveyC/rq7LVAys/Z4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHQsMgUT; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30761be8fcfso75502161fa.0;
        Wed, 05 Mar 2025 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190304; x=1741795104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnvbQASgvyl2j7FmmReDnrIkouFUMu43G879AWP2P+g=;
        b=KHQsMgUT+85QsDfatzBpbrloM50X0Yxg2aQtptk6mjVEQ5EZJbXoVawQz1/RgLitLH
         xpDErfIBby7snXUgx/Lg9D1dLKUMc3oXXgKnd/jlzQ9f+g7/U5RcYT+unYhnRCjKlbcK
         uZ99EmumYqt63cl3ZBDQxF3z7zzFOXzZn/f3slvTvjxKpV6z5yLoyYkFZutACLHB3Qky
         DOjNqKFXNIw93FlzcjkGowjn6myh2XPR743SK4P3SL8K0q7cZoQFg7n7/8EibGMX9gHE
         WgL86aHpBMDcLztmDcuYW3zPDYjZJk0oFQLy7lrw/8aI1p/QyDuoSoyao4TPRlPmu47a
         ZsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190304; x=1741795104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnvbQASgvyl2j7FmmReDnrIkouFUMu43G879AWP2P+g=;
        b=G+OpBZ+xlqdWebLrA5EkoGO5u3PdgGFLL69WPbQkND/HvCFvU08XGspg+uatkHkOuS
         IpINwI61Pd3wtysLdenRjbvflGCdRqiFGH6t1YdUJArRjefCjWmUHrHX7DYcR0C4eLKl
         Q9blBFtP4dt64nRtCJCjNDwNn481ZPzkriEg5CXpsbiuM/QWV5Aq0lvjCcBc0IDyXXUS
         oPYKudhAIfOjp0s1Sb1EIkouA3YeRZReBF3AxDkpuyosWpPswXS3Zuu3GmkDtzm1dRBT
         DjOe/snSUd4ZI9uB8rdTw6StdciOtki4H0YkDieRH35P/L8ZDEWJEozapnW9hnn7QITt
         tHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXGT7Yznz1Qn1mbgVhOhRa6bHAODU0jhRSixug7YJk7UrTN3evRcVC8KTFyiw2PptGjU9AmIbg1oZ74wNsaQO0@vger.kernel.org, AJvYcCWN5IxMq8AZz96Ak4YEeieXoul4BNBPp8pXz7LVP94Ueh4mVJSyvpcMNEjn4I6Kf/qT7ViHY72lS2yGwrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYCPvQ8MF3okbM5WbW0pRopnjoYr4OdTHYyvjjohr1YltOeZU
	fBHlQHEsmeRP+wV99QtAXVTvAPiN7siTNQCBXGq7RPg1UYIMRGHMjtxQAnMChuPs/6OhAwWM6HL
	1f59EGzfMC5To9EZDcnRAcjhDTxU=
X-Gm-Gg: ASbGncuB/pHlwyASXqY9HTZSSSXgCNcaJNtMQjUusP16yTqPvqnR0KWz/MmaNnNIeO5
	I+XPnQAt9wgJD1njJmjgzrTiOJqs+sIwht7yAaJlAUUVYy6JFjCAQK7SpnFCh6RjDsb1vmjOOQA
	JQcE+lneBP5f72NYPgE7PcZk8k8Oozvt9aXGZvFJHExw==
X-Google-Smtp-Source: AGHT+IGmkv5mLOUsJScMMmqtWQ6zGpiYx67ym/VV12PdXFxW6/3l6A0lcwQFojikJk+UgnlteFZGHZnbBE+jSgDtaoA=
X-Received: by 2002:a2e:a583:0:b0:30b:d44d:e76d with SMTP id
 38308e7fff4ca-30bd7aca44bmr15621771fa.26.1741190303832; Wed, 05 Mar 2025
 07:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
 <Z8hnXIrMV0ct1YR6@pathway.suse.cz> <CAJ-ks9k7G31uBqygXNtfXcwVQXWvkaAWJh1vkFw2_VZ5bAz=Vg@mail.gmail.com>
 <Z8hz8-Sa6XRC0W5Z@smile.fi.intel.com>
In-Reply-To: <Z8hz8-Sa6XRC0W5Z@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 5 Mar 2025 10:57:47 -0500
X-Gm-Features: AQ5f1JqqN1aImMZd_NPXsUNj4VmLOex6AXk7mvodnkei5XTDi0qnAKX-JBe7Bx8
Message-ID: <CAJ-ks9kz-fEH1YLiCn3fHR9AtYQLCZS77GKfOObifEL4GLwk8A@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 10:55=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 05, 2025 at 10:25:51AM -0500, Tamir Duberstein wrote:
> > On Wed, Mar 5, 2025 at 10:01=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
> > > On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:
>
> ...
>
> > > >  #include <kunit/test.h>
> > > > -#include <linux/bitops.h>
> > > > -#include <linux/kernel.h>
> > > >  #include <linux/module.h>
> > > > -#include <linux/overflow.h>
> > > > -#include <linux/printk.h>
> > > >  #include <linux/prandom.h>
> > > >  #include <linux/slab.h>
> > > > -#include <linux/string.h>
> > > > +#include <linux/sprintf.h>
> > > >
> > > >  #define BUF_SIZE 1024
> > >
> > > It would make more sense to do this clean up in the 3rd patch
> > > where some code was replaced by the kunit macros.
> > >
> > > Also I am not sure about the choice. It might make sense to remove
> > > <include/printk.h> because the pr_*() calls were removed.
> > > But what about the others? Did anyone request the clean up, please?
> > >
> > > I do not want to open a bike shadding because different people
> > > have different opinion.
> > >
> > > I would personally prefer to keep the explicit includes when the
> > > related API is still used. It helps to optimize nested includes
> > > in the header files which helps to speedup build. AFAIK, there
> > > are people working in this optimization and they might need
> > > to revert this change.
> >
> > Yeah, I don't feel strongly. I'll just restore all the includes.
>
> It will be blind approach. Please, try to look at them closely and includ=
e what
> you use (IWYU principle). I don't think anybody uses kernel.h here, for
> example.
>
> --
> With Best Regards,
> Andy Shevchenko

I think I'm getting conflicting instructions here. IWYU is indeed what
I did: bitops, kernel, overflow, printk are all unused; string is used
only for sprintf, so I made that replacement.

However Petr said "Did anyone request the clean up, please?" which
implies to me an aversion to unwanted cleanup. So, which is it please?

