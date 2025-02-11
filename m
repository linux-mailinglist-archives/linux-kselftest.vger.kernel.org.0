Return-Path: <linux-kselftest+bounces-26365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4EA30EC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664B03A63E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3B250BF9;
	Tue, 11 Feb 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5iVfld4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE922E410;
	Tue, 11 Feb 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285326; cv=none; b=k3W9IGp5LZHLgMgJnlfOA+JVzdS6exmj/uie/BtmdCSk9RI8O7harccXhjqZU9SEw3tKrk0uqzDz5v3nRh7WNZtpkSDIH6lDpv3sJ2xYAlq+Eh0SUjUGkEjZOIrKxFUHyWp948IjHaZ5/8gV3v90wnQovkzK94vSf8Nsu8uR46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285326; c=relaxed/simple;
	bh=JfQdjMVxGbYsw8sMM6Ri650tQ0UNKwrkOmxaShYK07U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMuyebKmZqJtTsEraC32TCKbJYtpBDV1bBGwY2m61OKu8dK06wxUFeXXz287Vf1UssiXErF7FfpMLLlvovo6Ua8SuutNItmMg91YpDUYJmVBA4TyGb/sQwD5bz+Olayea1mBmT2o3F2bnBTLtcXF36GUKzPBoNjyZL65grAuJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5iVfld4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307bc125e2eso52815921fa.3;
        Tue, 11 Feb 2025 06:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739285323; x=1739890123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb8WGpZVQ0ZPLASqjNohDLlbvR12SUwdUzxjh12ST9Q=;
        b=F5iVfld4xE3KhrfHOwSrH1nu2vQlq8mjj2B7zmgXPtNSABAFpXiURkJXHopc7Dkio1
         Xn7kuxlmd8MfK/7+3KCi9w7thO1Mln7A534FT5HEuUBKoZ4YgT76pXmkhEde4dPGV9o8
         dQ2JSHnwXNAUyK2Ds3w8K5Yr2UF/jxjkCiKe5PV+Yb5YKIub0Ky3JudbktCdW+hU4PGR
         wzkPCeMLf/z7HY445nx/klqO69ia3OMaOwWQ8O95vpgOs95YpJ3QjGby+cQV2E+5dikV
         yOMi42IkA2LqcRlknjpgK/zOXAbZZHQuUPt5yMGj0RYxYZp+TGUaCnn8KWpDmrq7Ore2
         q6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739285323; x=1739890123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb8WGpZVQ0ZPLASqjNohDLlbvR12SUwdUzxjh12ST9Q=;
        b=I3OoKZjWRZu0+0zIQZkfQapwj58Eh3Nd2ssmA/+2qDl0eQroDkZMbGwupLCpPc/JhG
         t9j188myvImqbQzNbAnIwWy09K5S3Yuq714iUs+XfGFZEm3iQrKY6+Nhf2qnN+C2FWdl
         zKES5RFbrmm6FlJJr4C9sbl+KfCoCcAkGhFRmn5V3xhOQyvANDtD/Zb37nNFpJZ8LCKn
         RSsShpN+pMy+N56nDUJntlPOQJtNDPZBPJ6MzauPQEFHOwtM0UQPugFhNaJePiHippLC
         F10+X3H2Z8B8JYMwo5CJSafBlsA17x8Hijxb0QdDZS4rG8Da8/Q8H4Qv6ZhvCQGo8qCO
         oKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy2OxN8IUFxuGUhnA8K1ODjeFSNNz5eO2QtIski5u9CKaiB1AAy1UfDRFCnw7bDEcEzfk33IEPDy1+A78/bHcl@vger.kernel.org, AJvYcCWhkOb2OXuRCBzAlxoaCA35/4sZZxZcEH3bK/JdaP704LuzAE5VKmyZrs3JdUKOTe/k6qMUmsumivI4Rns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMr9iDacs5/i3wMYLYeGSs2324xYcPH0DAhQ4drwkQaD9Lk6EB
	6k7xQdHEQjslfSo7SbWIDmdkVlucdyeoX3LSV4nfJ5mFJqc+68KRockY8lAN17y+bJMn6sKesJt
	AS1JwjcAI84ussGQq0S8jhire01rna3pF
X-Gm-Gg: ASbGncsmSjSj6ZdGtRxrHolAEDXe2k1VTbEdNcMrgKNF2yFE6bWB1eVdJbXoLGfBsjP
	EMcVN+2Kpmv8BqNgjhdh0wRDQeZTT/vmT//V2uoLX1lMRcSUSr20WlMaeT3pbjxfhSBjmBrem2e
	54TcQmBuU/deYJ
X-Google-Smtp-Source: AGHT+IFyQBNVwkAP+WJ5grg060BXEsXvubUYYvwxhjyORFrC58EExOAqo/K8MUl3U2ORZxt9dv5lMH4DKLM7UOj6YmI=
X-Received: by 2002:a2e:9f4b:0:b0:308:e3ee:8773 with SMTP id
 38308e7fff4ca-308e3eea069mr33664771fa.17.1739285322444; Tue, 11 Feb 2025
 06:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
 <20250210-scanf-kunit-convert-v6-1-4d583d07f92d@gmail.com>
 <Z6s2eqh0jkYHntUL@pathway.suse.cz> <CAJ-ks9n5=FYiFdmzWCkkACzX6oEVs=Z261_ZAKVq3tkqgJoSCQ@mail.gmail.com>
 <Z6s_VHExZe7ArgO7@smile.fi.intel.com>
In-Reply-To: <Z6s_VHExZe7ArgO7@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 09:48:06 -0500
X-Gm-Features: AWEUYZnWuvUuM0jAwAOHslBvVwO43LvTTZE23sNpqpSNVMknAe3J7QJIe_NCv4M
Message-ID: <CAJ-ks9=fRs212-okYDDQFN=LD_w7PQ6JP_NvMT0W6pfpruXxTw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 11, 2025 at 06:45:07AM -0500, Tamir Duberstein wrote:
> > On Tue, Feb 11, 2025 at 6:37=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
> > > On Mon 2025-02-10 13:13:48, Tamir Duberstein wrote:
>
> > > > +     kunit_printk(KERN_DEBUG, test, "\"%s\", \"%s\" ->", str, fmt)=
;  \
> > >
> > > The switch from pr_debug() to kunit_printk() causes printing huge
> > > amount of messages even when the test passes.
> >
> > I'm not able to reproduce this. pr_debug expands to printk(KERN_DEBUG,
> > ...) which is also what kunit_printk(KERN_DEBUG, ...) expands to. Can
> > you help me understand how you're testing?
>
> You are missing something.
> https://stackoverflow.com/a/57762255/2511795
>
> --
> With Best Regards,
> Andy Shevchenko
>

I see. Given Petr's comment about pr_debug also not being the right
thing, I took a closer look and realized that these debug logs are
redundant as they don't provide any information beyond what the
failure messages already do. So I'll just remove them.

