Return-Path: <linux-kselftest+bounces-10634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6909F8CDB86
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 22:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842971C21B47
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B97CF34;
	Thu, 23 May 2024 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jB4Rs3vj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F159535D4
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497121; cv=none; b=PabDTo6hmiuyWMVZuS3BfrU9vysMRpGzqzQkCMRFh8cziM4VyK5W9VXSw5jSyvk8taIwS5gD04vhlF7bhgwf0ZQCC93wsbG9iwQF0o+ybB8aSWf0ut/b3njLKp4CazfRZYJ/1HhvVxxoWiCc1AFOWYDPoq5JJx8+gvTU4FyC+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497121; c=relaxed/simple;
	bh=5dGe5QSNm8MPWLK7sICCTXvKZfye7pmwp96T7kASauo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A06eD92+AD73wvZtkbt2y3eL+arDbpOyEIj+AdUsQt6SmgN8HX4Lac0uDjfJgPccK5jQ2Dp8ayqaWX3j702pg+B9sAuvsIrxJCWTEgXGT2FvkOgRC2PoS2cCciRTzU0scqdCyOclElzHkWMlGypL9h0M7nJ3Yuc8Cg0y4N0fmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jB4Rs3vj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so4953a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716497118; x=1717101918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6N+gKnd70b4DwOAlz3Ao0iTefD/C31XiD4R/jKiITw=;
        b=jB4Rs3vj9ttBGeLLve7j64vo1hV2zvX0SoCVR8m0nNLzriPPIyz1U+48QyUrTbGT89
         3/ra/QF/ZgnKQQDpqjqZde68YUbe/NjXqvzDmv47hrikbKUqWcfD/5gBwAT9SC5lB8ez
         RllM3JF+wPdVcGWk+W5nsj9g91iNvxpa4DA3zifPdmHiT0n14Syqaakbd2VlPYEwUqCI
         fyFkAN+pTKAJWN3Mn6V0VeAU/B3UT9k92OvLn23hZSU/djsHpO7i0C4DJf8wNKQ6oWkj
         rbh1gloAfqbt8xN0R5WlmmPkMm/cfjzr4LvGKJGj1S4Aa3ChfbBI4RBH4uFzyE+JQsTV
         Yofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716497118; x=1717101918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6N+gKnd70b4DwOAlz3Ao0iTefD/C31XiD4R/jKiITw=;
        b=dgJlrIYg5j5KQPpjoJNDBS48AofLCPuKPywhnowpxxzO9VYpz9ATVUQVq8tuHbp8PY
         DhD2eNh7UI71/uewAcOoLzw3SRS9e+XyvCGzCxbp5ASLIx+4uOhHXtfu3u/WI8D6Dkuo
         QuY5A7NXmvyhxFJnVP6inbvxj1gzObDOK2nFx2suF9Id9qejm18JMxtSTxwFNUP3n0lr
         9kZ4MaXbX9FuHmD05aNtGKNncc8Tr/L6RmP9x5T6GwQuYEUDvzX4O4+f3tAxt03mDcEr
         cyEp7k3IL+308pwkyaqAm31aYzwWLBK5V82URNimtefYb5OGtHcDwHhRMkPCeMI7NT9U
         w0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFDVR1wIPAWskNC/k6BwQy5r++0/UhJ6rBD4nFls/+NaBPDthG9p+0OCSDkPJZwZheNwHdprNKW/cb9w0s3l8rkpck5zviwCK4bQNbvApg
X-Gm-Message-State: AOJu0YxeeyA0/UqiMGG3RRDkoo6FlXzKgy88sq0E19pBaq+zxPxgVzV0
	mvGGkPzUY+dWgbetUpdVUWEbHtLGwCwtp2tBCqLKiXX/Dodif+qU1aRpga5/0jwO8RMgo7TjDzT
	GA957LzSNzsg3O2GXAeqo42l8UCUTyNg0utUN
X-Google-Smtp-Source: AGHT+IHiTb7B2MfFZEs9Qb5GzWN3bD/f4uhDiXHK/UKzqmvTIF1G3MsIOI76EbjynZVznxCrfIiN5R+oVDmmd2wfv/o=
X-Received: by 2002:a05:6402:74e:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-578516800dcmr52317a12.2.1716497118262; Thu, 23 May 2024
 13:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <CALmYWFuLe6RaJkZ4koQpgZR-77b9PP=wooPYN-jFFw1KQ5K3aQ@mail.gmail.com> <20240523124521.99a798d645b0939d331d70c1@linux-foundation.org>
In-Reply-To: <20240523124521.99a798d645b0939d331d70c1@linux-foundation.org>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 23 May 2024 13:44:38 -0700
Message-ID: <CALmYWFtNtyzkbUVR+cQ+3zxMf9TU4SHDoMsH0267n=8V-2ENcw@mail.gmail.com>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, dmitry.torokhov@gmail.com, 
	dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org, 
	skhan@linuxfoundation.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barnab=C3=A1s

Is that OK that I work on V2 ? It will be based on your V1 change and
I will also add more test cases.

Thanks
-Jeff

-

On Thu, May 23, 2024 at 12:45=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 22 May 2024 19:32:35 -0700 Jeff Xu <jeffxu@google.com> wrote:
>
> > >
> > > It's a change to a userspace API, yes?  Please let's have a detailed
> > > description of why this is OK.  Why it won't affect any existing user=
s.
> > >
> > Unfortunately, this is a breaking change that might break a
> > application if they do below:
> > memfd_create("", MFD_NOEXEC_SEAL)
> > fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE); <-- this will fail in new
> > semantics, due to mfd not being sealable.
> >
> > However, I still think the new semantics is a better, the reason is
> > due to  the sysctl: memfd_noexec_scope
> > Currently, when the sysctl  is set to MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> > kernel adds MFD_NOEXEC_SEAL to memfd_create, and the memfd  becomes sea=
lable.
> > E.g.
> > When the sysctl is set to MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> > The app calls memfd_create("",0)
> > application will get sealable memfd, which might be a surprise to appli=
cation.
> >
> > If the app doesn't want this behavior, they will need one of two below
> > in current implementation.
> > 1>
> > set the sysctl: memfd_noexec_scope to 0.
> > So the kernel doesn't overwrite the mdmfd_create
> >
> > 2>
> > modify their code  to get non-sealable NOEXEC memfd.
> > memfd_create("", MEMFD_NOEXEC_SCOPE_NOEXEC)
> > fcntl(fd, F_ADD_SEALS, F_SEAL_SEAL)
> >
> > The new semantics works better with the sysctl.
> >
> > Since memfd noexec is new, maybe there is no application using the
> > MFD_NOEXEC_SEAL to create
> > sealable memfd. They mostly likely use
> > memfd(MFD_NOEXEC_SEAL|MFD_ALLOW_SEALING) instead.
> > I think it might benefit in the long term with the new semantics.
>
> Yes, it's new so I expect any damage will be small.  Please prepare a
> v2 which fully explains/justifies the thinking for this
> non-backward-compatible change and which include the cc:stable.
>
>

