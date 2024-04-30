Return-Path: <linux-kselftest+bounces-9154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EEC8B7E7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 19:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E921C2092F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBE1802DA;
	Tue, 30 Apr 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3fQ7nWt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEAE17BB20
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498214; cv=none; b=ET68SLS4yqgSTC4dUx8Z25oLh0dCUs1A/wJQUnwqDxomKSSC0cVCVynOxHt+vuxOoqarXRiqqV5Y5gRKi/s6eoLzZZY1ZNwJSuIlKpm4j2n8Y3UKlQduqTkS+Ptx3yvOROAhhcyBr+gZ9Q8WsmRH/vBcNTrGCerkC8renPywjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498214; c=relaxed/simple;
	bh=BR9Wkd6miBhzfBRCvTbhOcpLA80oqmQjUGpUH96Ratk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV4XAxaE2Ojs0JhhsYyuM+JlsMkJtcoGbvDeIbsN3IpoYqnqAFqncfGHfT5tPHEsI/5LgpehdtzkMhDsafkKDhHwkDu31a5yG1kr2zf+8B/42Nh85yaOJoouXwVn1J59hrzdJFiCKfZaaFdEJYrbyjF4bfzFD8KpqsoPc3tmk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3fQ7nWt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5727ce5b804so1208a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498211; x=1715103011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awaW7AT0wOcGmKhgMWqej99cmUwIAXC84LCX446x4FU=;
        b=E3fQ7nWtq0h9yfZi/OzLRPTB2tGnydDkoPI1hk3+4siYKA3C8bStTw9+poPooBbbZY
         wpHOyB3udWf7SMQd5EumaDO/N5Vi38cZdZWKs27l8ssk6OYKKhPpP6vzgNpzLVEf73zq
         6Ko2G1+Gxtk+uuiJCUCn3sPRHMFKLZQ+OprCkert8yjmvB3tnqai3Aes1I6cePUlgc0k
         rMKCBgIrsQzf+tb/4hdP/iq1kUoXMz7FgC6d/RTLBTRKBsoasjIJC09iE5imzZRZqERe
         mrsUvIPDEggWeoBQ4PCvQ8BL5DmB0WuERrGAA2Y5SDsD5UM1r3d8LGgVoSJ4aliWkoo8
         U2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498211; x=1715103011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awaW7AT0wOcGmKhgMWqej99cmUwIAXC84LCX446x4FU=;
        b=Jx6aTVfdyOYPlow7qKFfI5TrZr5G0lTyGF6EdgCRc36Qxbsh5w6PQARkPLMzeh633Q
         Y8BvHAf8nyFFgInquhncz5OYzkwiY2qgCTcVO+V7h8RAeiHUJH5t6Mu2Vuq8NWgNO+mU
         czllBH3+hJFsJ1l6PW0hqfYqaB2ousVhs9GcBfmWzcA87EbMl2NJuiXjKcWLemwwRXXd
         tb4mdoXXi+ndmglQehAl3wdG8Js9iIqsTw8mDH6HaqWJEmBmK9WceByGHsj/dawuJQJ1
         XPVqAMwZErtVnfQBxdHA2gtvRNyyH8QQzZfrj4apZeMcDAqZb0b87TCGYRQ64TOCB7xL
         sJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCX2bq4UmRtMdRJRUPdml3EcTWxXkgYc0vFsKGEzenHk5sDkxIkAbW4xu0XzZJP/uVSsLMZyk1E2P7gUGQ2XTYckiokdWmfFO4koBqZqKyPf
X-Gm-Message-State: AOJu0Yw/6hvrHJ24l+n01Qk9UWtm4txj21rs6OAwRil3tX7iEc+Tx6xi
	YBLYxZX87IR+/vac/A0T1HmZvqUzxvhSiEDIj9wyMvan6J/rJC0xlLIdUC0FMcjUBfpR5Dzl0IH
	NMSf+EG3CVLXnbYcq8YGapYgRlL729pfDO/Wo
X-Google-Smtp-Source: AGHT+IH+9i4rJwPsBQqyArNc6DyoylM2VtMH1uR90G8+UmkTIaIfFTHI45q8A/gfsHjMbdT2dAMNGIl7Sk7gnVSSnaI=
X-Received: by 2002:a05:6402:3105:b0:572:9960:c21 with SMTP id
 dc5-20020a056402310500b0057299600c21mr145767edb.7.1714498210546; Tue, 30 Apr
 2024 10:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430010628.430427-1-edliaw@google.com> <2024043037-debate-capsize-e44c@gregkh>
In-Reply-To: <2024043037-debate-capsize-e44c@gregkh>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 30 Apr 2024 10:29:43 -0700
Message-ID: <CAG4es9VL8CdROKVygYi3YAo3ZuugXgiyt6uhf+3yq6s8iKfQeg@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] kselftest: Add a ksft_perror() helper
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:51=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Apr 30, 2024 at 01:06:27AM +0000, Edward Liaw wrote:
> > From: Mark Brown <broonie@kernel.org>
> >
> > [ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]
> >
> > The standard library perror() function provides a convenient way to pri=
nt
> > an error message based on the current errno but this doesn't play nicel=
y
> > with KTAP output. Provide a helper which does an equivalent thing in a =
KTAP
> > compatible format.
> >
> > nolibc doesn't have a strerror() and adding the table of strings requir=
ed
> > doesn't seem like a good fit for what it's trying to do so when we're u=
sing
> > that only print the errno.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers t=
est to generate KTAP output")
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >  tools/testing/selftests/kselftest.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
>
> This commit is already in 6.6.29, why submit it again?

Hi Greg,
I double checked and I don't see this commit in 6.6.29.   As far as I
can tell the earliest it has been merged is in 6.7.1.  Do you mind
rechecking?

Thank you,
Edward

>
> confused,
>
> greg k-h

